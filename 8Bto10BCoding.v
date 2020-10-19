`timescale 1ns / 1ps
module Transition_8Bto10B(DATA_I,DATA_OUT,RD_I,RD_OUT,K_I);
   input [7:0]DATA_I;
	input RD_I,K_I;
	output[9:0]DATA_OUT;
	output RD_OUT;
	reg [9:0]DATA_OUT;
	reg [5:0]abcdei;
	reg [3:0]fghj,i;
	reg [2:0]Disparity_5Bto6B,Disparity_3Bto4B;
	reg RD_after5Bto6B;
	reg RD_OUT;
   reg RD_IN,K_IN;
	reg [7:0]DATA_IN;
	
	initial
     begin
	   DATA_IN=8'b10111100;
		RD_IN=0;
		K_IN=0;
		if(K_IN&&(DATA_IN[4:0]===5'b11100))
		 begin
			if(!RD_IN)
				abcdei=6'b001111;
			else
				abcdei=6'b110000;
		 end
		else
		begin
			if(!RD_IN)
				begin
					case(DATA_IN[4:0])
						 5'b00000 :                
							abcdei=6'b100111;
						 5'b00001 :                
							abcdei=6'b011101;
						 5'b00010 :                
							abcdei=6'b101101;
						 5'b00011 :
							abcdei=6'b110001;
						 5'b00100 :                
							abcdei=6'b110101;			  
						 5'b00101 :
							abcdei=6'b101001;	
						 5'b00110 :
							abcdei=6'b011001;
						 5'b00111 :                
							abcdei=6'b111000;
						 5'b01000 :                
							abcdei=6'b111001;
						 5'b01001 :
							abcdei=6'b100101;
						 5'b01010 :
							abcdei=6'b010101;  
						 5'b01011 :
							abcdei=6'b110100;
						 5'b01100 :
							abcdei=6'b001101;
						 5'b01101 :
							abcdei=6'b101100;
						 5'b01110 :
							abcdei=6'b011100;
						 5'b01111 :              
							abcdei=6'b010111;
						 5'b10000 :             
							abcdei=6'b011011;
						 5'b10001 :
							abcdei=6'b100011;
						 5'b10010 :
							abcdei=6'b010011;
						 5'b10011 :
							abcdei=6'b110010;
						 5'b10100 :
							abcdei=6'b001011;
						 5'b10101 :
							abcdei=6'b101010;
						 5'b10110 :
							abcdei=6'b011010;
						 5'b10111 :             
							abcdei=6'b111010;
						 5'b11000 :             
							abcdei=6'b110011;
						 5'b11001 :
							abcdei=6'b100110;
						 5'b11010 :
							abcdei=6'b010110;
						 5'b11011 :              
							abcdei=6'b110110;
						 5'b11100 :
							abcdei=6'b001110;
						 5'b11101 :             
							abcdei=6'b101110;
						 5'b11110 :               
							abcdei=6'b011110;
						 5'b11111 :     
							abcdei=6'b101011;
					  default :
							abcdei=6'bXXXXXX;		
					endcase
				end
			else
				begin
					case(DATA_IN[4:0])
						 5'b00000 :                
							abcdei=6'b011000;
						 5'b00001 :                
							abcdei=6'b100010;
						 5'b00010 :                
							abcdei=6'b010010;
						 5'b00011 :
							abcdei=6'b110001;
						 5'b00100 :                
							abcdei=6'b001010;			  
						 5'b00101 :
							abcdei=6'b101001;	
						 5'b00110 :
							abcdei=6'b011001;
						 5'b00111 :                
							abcdei=6'b000111;
						 5'b01000 :                
							abcdei=6'b000110;
						 5'b01001 :
							abcdei=6'b100101;
						 5'b01010 :
							abcdei=6'b010101;  
						 5'b01011 :
							abcdei=6'b101100;
						 5'b01100 :
							abcdei=6'b001101;
						 5'b01101 :
							abcdei=6'b101100;
						 5'b01110 :
							abcdei=6'b011100;
						 5'b01111 :              
							abcdei=6'b101000;
						 5'b10000 :             
							abcdei=6'b100100;
						 5'b10001 :
							abcdei=6'b100011;
						 5'b10010 :
							abcdei=6'b010011;
						 5'b10011 :
							abcdei=6'b110010;
						 5'b10100 :
							abcdei=6'b001010;
						 5'b10101 :
							abcdei=6'b101010;
						 5'b10110 :
							abcdei=6'b011010;
						 5'b10111 :             
							abcdei=6'b000101;
						 5'b11000 :             
							abcdei=6'b001100;
						 5'b11001 :
							abcdei=6'b100110;
						 5'b11010 :
							abcdei=6'b010110;
						 5'b11011 :              
							abcdei=6'b001001;
						 5'b11100 :
							abcdei=6'b001110;
						 5'b11101 :             
							abcdei=6'b010001;
						 5'b11110 :               
							abcdei=6'b100001;
						 5'b11111 :     
							abcdei=6'b010100;
					  default :
							abcdei=6'bXXXXXX;		
					endcase
				end
		end
			
		for(i=0;i<6;i=i+1)
			DATA_OUT[i+4]=abcdei[i];
			
			
		for(i=0;i<6;i=i+1)
			Disparity_5Bto6B=Disparity_5Bto6B+abcdei[i];
			
		if(Disparity_5Bto6B>3||abcdei===6'b000111||(Disparity_5Bto6B==3&&RD_IN==1))
		   RD_after5Bto6B=1;
		else
			RD_after5Bto6B=0;

		if(!K_IN)
		begin
			if(!RD_after5Bto6B)
				begin
					case(DATA_IN[7:5])
						3'b000:
							fghj=4'b1011;
						3'b001:
							fghj=4'b1001;
						3'b010:
							fghj=4'b0101;
						3'b011:
							fghj=4'b1100;
						3'b100:
							fghj=4'b1101;
						3'b101:
							fghj=4'b1010;
						3'b110:
							fghj=4'b0110;
						3'b111:
							if((abcdei[0]==1)&&(abcdei[1]==1))
							  fghj=4'b0111;
							else
							  fghj=4'b1110;
						default :
                        fghj=4'bXXXX;
					endcase
				end
			else
				begin
					case(DATA_IN[7:5])
						3'b000:
							fghj=4'b0100;
						3'b001:
							fghj=4'b1001;
						3'b010:
							fghj=4'b0101;
						3'b011:
							fghj=4'b0011;
						3'b100:
							fghj=4'b0010;
						3'b101:
							fghj=4'b1010;
						3'b110:
							fghj=4'b0110;
						3'b111:
							if((abcdei[0]==0)&&(abcdei[1]==0))
							  fghj=4'b1000;
							else
							  fghj=4'b0001;
					   default :
                        fghj=4'bXXXX;
					endcase
				end
		end
		else
		begin
			if(!RD_after5Bto6B)
				begin
					case(DATA_IN[7:5])
						3'b000:
							fghj=4'b1011;
						3'b001:
							fghj=4'b0110;
						3'b010:
							fghj=4'b1010;
						3'b011:
							fghj=4'b1100;
						3'b100:
							fghj=4'b1101;
						3'b101:
							fghj=4'b0101;
						3'b110:
							fghj=4'b1001;
						3'b111:
							fghj=4'b0111;
						default :
                        fghj=4'bXXXX;
					endcase
				end
			else
				begin
					case(DATA_IN[7:5])
						3'b000:
							fghj=4'b0100;
						3'b001:
							fghj=4'b1001;
						3'b010:
							fghj=4'b0101;
						3'b011:
							fghj=4'b0011;
						3'b100:
							fghj=4'b0010;
						3'b101:
							fghj=4'b1010;
						3'b110:
							fghj=4'b0110;
						3'b111:
							fghj=4'b1000;
						default :
                        fghj=4'bXXXX;
					endcase
				end
	  end
	
	  for(i=0;i<4;i=i+1)
			DATA_OUT[i]=fghj[i];
	
	  for(i=0;i<4;i=i+1)
			Disparity_3Bto4B=Disparity_3Bto4B+fghj[i];
	  
		if(Disparity_3Bto4B>2||fghj===4'b0011||(RD_after5Bto6B==1&&Disparity_3Bto4B==2))
			RD_OUT=1;
		else
			RD_OUT=0;
	end
	

endmodule

module testbench;
	reg [7:0]DATA_IN;
	reg K_IN,RD_IN;
	wire [9:0]DATA_OUT;
	wire RD_OUT;
	
	Transition_8Bto10B testbench(.DATA_I(DATA_IN),.RD_I(RD_IN),.K_I(K_IN),.DATA_OUT(DATA_OUT),.RD_OUT(RD_OUT));
	
  initial
	  begin    
			DATA_IN=8'b10111100;
			K_IN=0;
			RD_IN=0;
	  end

		
endmodule
