Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278313AbRKDDvL>; Sat, 3 Nov 2001 22:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278428AbRKDDvC>; Sat, 3 Nov 2001 22:51:02 -0500
Received: from ns.ithnet.com ([217.64.64.10]:24585 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278313AbRKDDu5>;
	Sat, 3 Nov 2001 22:50:57 -0500
Message-Id: <200111040350.EAA22275@webserver.ithnet.com>
Date: Sun, 04 Nov 2001 04:50:43 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Content-Transfer-Encoding: 7BIT
Subject: Re: Adaptec vs Symbios performance 
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <200111032318.fA3NIQY62745@aslan.scsiguy.com>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Hello Justin, hello Gerard                                         
                                                                      
> >                                                                   
                                                                      
> >I am looking currently for reasons for bad behaviour of aic7xxx    
driver                                                                
> >in an shared interrupt setup and general not-nice behaviour of the 
                                                                      
> >driver regarding multi-tasking environment.                        
                                                                      
>                                                                     
> Can you be more specific?                                           
                                                                      
Yes, of course :-)                                                    
What I am seeing over here is that aic7xxx is _significantly_ slower  
than symbios _in the exact same context_. I refused to use the "new"  
driver as long as possible because I had (right from the first test)  
the "feeling" that it hurts the machine overall performance in some   
way, meaning the box seems _slow_ and less responsive than it was with
the old aic driver. When I directly compared it with symbios (LSI     
Logic hardware sold from Tekram) I additionaly found out, that it     
seems to hurt the interrupt performance of a network card sharing its 
interrupt with the aic which again does not happen with symbios. I    
have already seen such behaviour before, on merely every driver I     
formerly wrote for shared interrupt systems I had to fill in code that
_prevents_ lockout of other interrupt users due to indefinitely       
walking through the own code in high load situation.                  
But, of course, you _know_ this. Nobody writes a driver like new      
aic7xxx _and_ doesn't know :-)                                        
My guess is that this knowledge made you enter the comment I ripped   
from your code about using bottom half handler instead of dealing with
workload in a hardware interrupt. Again, I have to no extent read your
code completely or the like. I simply tried to find the hardware      
interrupt routine and look if it does significant eli (EverLasting    
Interrupt ;-) stuff - and I found your comment.                       
Can you re-comment from todays point of view?                         
                                                                      
> >This is nice. I cannot read the complete code around it (it is     
derived                                                               
> >from aic7xxx_linux.c) but if I understand the naming and comments  
                                                                      
> >correct, some workload is done inside the hardware interrupt (which
                                                                      
> >shouldn't), which would very much match my tests showing bad       
overall                                                               
> >performance behaviour. Obviously this code is old (read the        
comment)                                                              
> >and needs reworking.                                               
                                                                      
> >Comments?                                                          
                                                                      
>                                                                     
> I won't comment on whether deferring this work until outside of     
> an interrupt context would help your "problem" until I understand   
> what you are complaining about. 8-)                                 
                                                                      
In a nutshell:                                                        
a) long lasting interrupt workloads prevent normal process activity   
(creating latency and sticky behaviour)                               
b) long lasting interrupt workloads play bad on other interrupt users 
(e.g. on the same shared interrupt)                                   
I can see _both_ comparing aic with symbios.                          
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
