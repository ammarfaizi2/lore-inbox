Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279799AbRKAVcS>; Thu, 1 Nov 2001 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRKAVcJ>; Thu, 1 Nov 2001 16:32:09 -0500
Received: from ns.ithnet.com ([217.64.64.10]:44554 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279798AbRKAVb7>;
	Thu, 1 Nov 2001 16:31:59 -0500
Message-Id: <200111012131.WAA28302@webserver.ithnet.com>
Date: Thu, 01 Nov 2001 22:31:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
Subject: Re: The good, the bad & the ugly (or VM, block devices, and SCSI :-)
To: =?iso-8859-1?q?G=E9rard?= Roudier <groudier@free.fr>
In-Reply-To: <20011101142507.S1471-100000@gerard>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The TCQ-depth shouldn't matter as long as only the CD drive is      
accessed                                                              
> given that such devices are unlikely to support tagged commands.    
> Nevertheless, you should check your boot log messages and also      
compare the                                                           
> thoughput negotiation between controller and devices.               
                                                                      
Hm, I am not so sure about TCQ not having _any_ influence. Remember I 
read the CD _and_ write the image to disk (the U160 IBM). So it could 
well be that the results are an accummulation of two bad performing   
things on aic7xxx: the CD read and the disk write.                    
                                                                      
Hear my risky analysis of the problem:                                
The aic7xxx interrupt handler is the cause. It may be that it "wants" 
to much, meaning its hanging hard on its business eating up resources 
(and gaining nothing for it), and therefore playing bad with the      
network interrupt handling _and_ its own higher layer code.           
Or (another pure guess) its busted by its own memory handling         
strategy. I see during the cd read 2 or 3 times simple "freezes" (no  
bug deal, but remarkable) where the systems seems to "hang" for just  
1-2 seconds. symbios code does not show this, but runs smoothly       
through the whole test. This is _not_ related to VM, there is a lot   
free mem during these "small-freezes".                                
                                                                      
> [...]                                                               
> Indeed, the configs look very similar.                              
                                                                      
Believe me, it is.                                                    
                                                                      
> > I can. I did a whole lot of such tests during my former job for a 
company                                                               
> > producing scsi-controllers.                                       
>                                                                     
> Interesting, if you can elaborate...                                
                                                                      
These were the g'old Commodore times (Amiga). :-) Ask me off-list If  
you're interested ...                                                 
                                                                      
> > > Thanks, anyway, for your report.                                
> >                                                                   
> > Well, as already said, take it as a hint that your part of the    
story performs                                                        
> > pretty well.                                                      
> > ;-)                                                               
>                                                                     
> The sym53c8xx driver beeing faster than the aic7xxx with CD devices 
using                                                                 
> Ultra160 controllers is an amuzing result. :)                       
> I still cannot beleive that it is due to a aic7xxx driver fault. If 
I had                                                                 
> such a controller, I would for sure check that, but I haven't any.  
                                                                      
Hm, if I find some spare time, I try to proof it. I am almost sure it 
has nothing to do with hardware. Maybe I am going to earn another red 
herring from linus, which turns out to be red lobster afterwards ;-)  
Keep smiling, we are all having fun here :-)                          
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
