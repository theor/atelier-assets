@0xdbbcd8ccbd223b6c; # unique file ID, generated by `capnp id`

struct AssetId {
  id @0 :Data;
}
struct AssetType {

}

struct KeyValue {
  key @0 :Data;
  value @1 :Data;
}

enum FileType {
  file @0;
  directory @1;
  symlink @2;
  none @3;
}

enum FileState {
  exists @0;
  deleted @1;
}

struct DirtyFileInfo {
  state @0 :FileState;
  sourceInfo @1 :SourceFileInfo;
}

struct SourceFileInfo {
  type @0 :FileType;
  lastModified @1 :UInt64;
  length @2 :UInt64;
}

# The identifier for an import artifact is the hash of 
# - Source asset contents
# - Source metadata contents
# - Importer version/id
# - Importer configuration (target platform etc)
struct ImportArtifactKey {
  hash @0 :Data;
}

# To find the imported asset data for an assetId,
# we use assetId as key and AssetImportLocation as the value.
# We then use the ImportArtifactKey to find the asset in the imported artifact
struct AssetImportLocation {
  artifact @0 :ImportArtifactKey;
  index @1 :UInt64;
}

struct AssetMetadata {
  id @0 :AssetId;
  type @1 :AssetType;
  runtimeDependencies @2 :List(AssetId);
  buildDependencies @3 :List(AssetId);
  tags @4 :List(Text);
  indexingValues @5 :List(KeyValue);
}

# The import artifact contains the asset data and metadata 
# for all assets extracted from the source file
struct ImportArtifact {
  assetMetadata @0 :List(AssetMetadata);
  assetData @1 :List(Data);
}
