Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRLHPNN>; Sat, 8 Dec 2001 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281812AbRLHPNC>; Sat, 8 Dec 2001 10:13:02 -0500
Received: from ns.ithnet.com ([217.64.64.10]:6672 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281004AbRLHPMv>;
	Sat, 8 Dec 2001 10:12:51 -0500
Message-Id: <200112081512.QAA16585@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Sat, 08 Dec 2001 16:12:37 +0100
Subject: Re: [PATCH] for pre6: hisax user config =?iso-8859-1?q?MAX=5FCARD?= and fix potential data trashing
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <Pine.LNX.4.33.0112081026010.1300-100000@vaio>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <linux-kernel@vger.kernel.org>, <kkeil@suse.de>,
        <kai.germaschewski@gmx.de>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 8 Dec 2001, Stephan von Krawczynski wrote:                  
>                                                                     
> > attached is the second patch for ISDN-Driver HiSax for            
kernel-inclusion that does the                                        
> > following:                                                        
>                                                                     
> Please send patches to the maintainers (i.e. Karsten/me) first, not 
> directly to Linus/Marcelo. Also, CC'ing lkml isn't really necessary,
                                                                      
> either. (Documentation/SubmittingPatches is worth reading)          
                                                                      
Well, in fact my hope was, somebody from lkml would give it a quick   
look, because it again turned out the original author may not see     
minor problems :-)                                                    
                                                                      
> This makes the procedure take a bit longer, but things like missing 
> semicolons get caught in the process ;-)                            
                                                                      
Yes, I declare myself guilty. It's a nice example how a real simlpe   
patch woes.                                                           
                                                                      
> So let's drop Linus/Marcelo/lkml from CC. I'll submit the patch     
> eventually. (If it's already applied, that's fine, too)             
>                                                                     
> Generally the patch looks good (still wondering if you've got that  
many                                                                  
> cards in one machine).                                              
                                                                      
Lots. :-)                                                             
Last event which made me think about this patch to submit (and not    
just hacking in every time I needed it), were 12. But to be honest, I 
made it work for less than 8 because I do think that 8 is a bit       
oversized for most people.                                            
                                                                      
> Some comments:                                                      
>                                                                     
> (original patch)                                                    
>                                                                     
> > +/* string magic */                                               
> > +#define h1(s) h2(s)                                              
> > +#define h2(s) #s                                                 
> > +#define PARM_PARA "1-"h1(HISAX_MAX_CARDS)"i"                     
> > +                                                                 
> you should use __MODULE_STRING (from linux/module.h)                
                                                                      
I love to in the future, now that I _know_ it. :-) Please convert it  
on your next submission to Marcelo & L. We don't wanna keep           
superfluous code.                                                     
                                                                      
> > --- linux/drivers/isdn/hisax/hisax.h-orig	Sat Dec  8 00:24:20 2001
> > +++ linux/drivers/isdn/hisax/hisax.h	Sat Dec  8 00:40:49 2001     
> > @@ -950,7 +950,9 @@                                               
> >  #define  MON0_TX	4                                               
> >  #define  MON1_TX	8                                               
> >                                                                   
> > +#ifndef HISAX_MAX_CARDS                                          
> >  #define	 HISAX_MAX_CARDS	8                                       
> > +#endif                                                           
> >                                                                   
> >  #define  ISDN_CTYPE_16_0	1                                       
> >  #define  ISDN_CTYPE_8_0		2                                       
>                                                                     
> Why is that necessary?                                              
                                                                      
Hm, good question. The thing is: I wanted to make 1000% sure it       
doesn't get lost. This should have been already in the first patch,   
where it was not really clear how to get the CONFIG definition.       
Additionally I feel uncomfortable with code being not complete in     
terms of symbols. You cannot grep through *.c/*.h to find             
missing/mis-spelled symbols then. I always lived with the idea that   
compile-time definitions _tune_ the code, but it should be complete   
even without. In fact it doesn't make a difference in the created     
binary.                                                               
                                                                      
> > @@ -1563,6 +1564,8 @@                                             
> >  		if (protocol[i]) {                                             
> >  			cards[i].protocol = protocol[i];                              
> >  		}                                                              
> > +		else                                                           
> > +			cards[i].protocol = DEFAULT_PROTO;                            
> >  	}                                                               
> >  	cards[0].para[0] = pcm_irq;                                     
> >  	cards[0].para[1] = (int) pcm_iob;                               
>                                                                     
> nitpicking:                                                         
>                                                                     
> This should be                                                      
> 		} else                                                            
> 			cards[i]...                                                      
>                                                                     
> Actually, I'd prefer                                                
>                                                                     
> 		} else {                                                          
> 			cards[i]...                                                      
> 		}                                                                 
                                                                      
Feel free. I in fact thought about the other way round, but that's    
only a personal viewing and reading issue.                            
                                                                      
> I'll fix up these small bits, commit it to our CVS and take care of 
> submitting the patch.                                               
>                                                                     
> Thanks again for your work.                                         
                                                                      
You're welcome.                                                       
                                                                      
While reading config.c I came to the conclusion that this is pretty   
"organic" code :-) .                                                  
As in most ISDN drivers I read so far there is a whole lot of         
duplication inside. I had the strong urge to clean it up, but didn't  
want to submit a whole new file as a patch dealing with something     
completely different.                                                 
Perhaps I will in the future.                                         
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
