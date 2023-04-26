// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "solecs/Component.sol";

uint256 constant ID = uint256(keccak256("component.Memory"));

struct Vector {
    uint256 dim;
    uint256[] data;
}

struct Memory {
  Vector[] embeddings;
  string[] texts;
}

contract MemoryComponent is Component {
  constructor(address world) Component(world, ID) {}

  mapping (uint256 => Memory ) memorys;

  function getSchema() public pure override returns (string[] memory keys, LibTypes.SchemaValue[] memory values) {
    keys = new string[](1);
    values = new LibTypes.SchemaValue[](1);

    keys[0] = "value";
    values[0] = LibTypes.SchemaValue.UINT32;
  }

  function set(uint256 entity, uint32 value) public virtual {
    set(entity, abi.encode(value));
  }

  function getValue(uint256 entity) public view virtual returns (uint32) {
    uint32 value = abi.decode(getRawValue(entity), (uint32));
    return value;
  }

  function getEntitiesWithValue(uint32 value) public view virtual returns (uint256[] memory) {
    return getEntitiesWithValue(abi.encode(value));
  }
}
