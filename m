Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRLIAje>; Sat, 8 Dec 2001 19:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRLIAjZ>; Sat, 8 Dec 2001 19:39:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:35856 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274752AbRLIAjN>;
	Sat, 8 Dec 2001 19:39:13 -0500
Message-Id: <200112090039.BAA25399@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Sun, 09 Dec 2001 01:39:03 +0100
Subject: Re: Typedefs / gcc / HIGHMEM
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <9uu8d8$spc$1@cesium.transmeta.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The first is u64, the second u32. Either the u64 value is not     
                                                                      
> > required, or the statement is broken. Astonishing there is _no_   
                                                                      
> > compiler warning in this line.                                    
                                                                      
> >                                                                   
>                                                                     
> Why should there be?  The u32 value gets promoted to u64 before the 
> comparison is done.                                                 
                                                                      
Yes, ok, you're right. This was not a well thought out statement.     
Anyway the problem with printf statement stays. It is obviously       
confused by a unsigned long long and "%08x". How would you fix this?  
Downcasting to u32?                                                   
                                                                      
> > BTW, my personal opinion to "typedef unsigned int u32" is that it 
                                                                      
> > should rather be "typedef unsigned long u32", but this is         
religious.                                                            
>                                                                     
> I see you have a background in environments where you move between  
16-                                                                   
> and 32-bit machines.  Guess what, in Linux the major movement is    
> between 32- and 64-bit machines, and "unsigned int" is consistent,  
> whereas "unsigned long" isn't (long is 32 bits on 32-bit machines,  
64                                                                    
> bits on 64-bit machines.)                                           
                                                                      
Ha, I always wondered what this u64 is all about :-)                  
Honestly, this whole datatyping is gone completely mad since the 16-32
bit  change. In my opinion                                            
byte is 8 bit                                                         
short is 16 bit                                                       
long is 32 bit                                                        
<callwhatyouwant> is 64 bit (I propose long2 for expression of bitsize
long * 2).                                                            
<callwhatyouwant2> is 128 bit (Ha, right I would call it long4)       
                                                                      
char is the standard representation of chars in the corresponding     
environment, currently sizeof(byte).                                  
int is the same and should move from 16 bit to 32 bit to 64 bit       
depending on the machine. I mean whats the use of an int register in a
64bit environment, when datatype int is only of size 32 bit? This is  
_shit_.                                                               
                                                                      
How do you call a 64 bit datatype in a 128 bit environment? According 
to your / the worlds current terminology long will then be 128 bit and
int will (ridiculously) still be 32 bit. It will be pretty interesting
to hear people talking about integer registers and people writing     
portable applications do #define int long ... A wait this will break  
your #typedef unsigned int u32 story :-)                              
                                                                      
Writing portable applications can be easily done by using "meta"      
datatype char/int/etc., whereas machine dependant coding could be done
by byte/short/long/long2/etc.                                         
This is completely consistent as it _never_ changes.                  
                                                                      
Now you have an _additional_ layer where you call the stuff           
u8/u16/u32/u64, which I find still ok, but you can then completely    
shoot long/short/byte.                                                
                                                                      
But, in fact, this is more a discussion for the RMS-world than for    
L-world :-)                                                           
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
