Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSAOBoZ>; Mon, 14 Jan 2002 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289350AbSAOBoF>; Mon, 14 Jan 2002 20:44:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:35590 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289347AbSAOBoA>;
	Mon, 14 Jan 2002 20:44:00 -0500
Message-Id: <200201150143.CAA24288@webserver.ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Date: Tue, 15 Jan 2002 02:43:51 +0100
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: Jussi Laako <jussi.laako@kolumbus.fi>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <3C435995.24B8880B@kolumbus.fi>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:                                                     
> >                                                                   
> > > > In eepro100.c, wait_for_cmd_done() can busywait for one       
millisecond                                                           
> > > > and is called multiple times under spinlock.                  
> > >                                                                 
> > > Did I get that right, as long as spinlocked no sense in         
> > > conditional_schedule()                                          
> >                                                                   
> > No conditional schedule, no pre-emption. You would need to rewrite
that                                                                  
> > code to do something like try for 100uS then queue a 1 tick timer 
to                                                                    
> > retry asynchronously. That makes the code vastly more complex for 
an                                                                    
> > error case and for some drivers where irq mask is required during 
reset                                                                 
> > waits won't help.                                                 
>                                                                     
> That wait_for_cmd_done() and similar functions in other drivers are 
called                                                                
> let's say 3 times in interrupt handler or spinlocked routine and 20 
times in                                                              
> non-interrupts disabled nor spinlocked functions.                   
>                                                                     
> Spinlocked reqions are usually protected by spin_lock_irqsave().    
                                                                      
Now I have really waited for this one: _usually_.                     
My servers work usually, except for the days they hit that other      
rather unusual part of the code...                                    
                                                                      
> So the code reads                                                   
>                                                                     
> 	if (!spin_is_locked(sl))                                           
> 		conditional_schedule();                                           
>                                                                     
> This doesn't make the whole problem go away, but could make the     
situation a                                                           
> little bit better for most of the time?                             
                                                                      
Time to take out these big hats and rename ourself to Gandalf or the  
like. What do you expect your server to do, having no problem "most of
the time"? Please read Albert E. Time can be pretty relative to your  
personal point of view...                                             
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
