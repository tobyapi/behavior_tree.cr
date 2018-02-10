require "./*"

module BehaviorTree::Node
  class Selector(State, Command) < Node(State, Command)
    
    @children : Array(Node(State, Command))

    def initialize(@children = [] of Node(State, Command))
    end
    
    def <<(child : Node(State, Command))
      @children << child
    end
    
    def run(state : State, command : Command) :: Boolean
      @children.each do |child|
        local_state = state.dup
        if child.run(local_state, command)
          state = local_state
          return true
        end
      end
      false
    end
  end
end