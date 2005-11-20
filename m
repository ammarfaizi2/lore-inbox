Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVKTKlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVKTKlX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKTKlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:41:23 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:911 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751207AbVKTKlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:41:23 -0500
In-Reply-To: <200511202128.13308.kernel@kolivas.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF6356B37E.AB766095-ONC22570BF.003ABD3E-C22570BF.003AF06F@il.ibm.com>
From: Marcel Zalmanovici <MARCEL@il.ibm.com>
Date: Sun, 20 Nov 2005 12:43:46 +0200
X-MIMETrack: Serialize by Router on D12ML102/12/M/IBM(Release 6.5.1| March 5, 2004) at
 20/11/2005 12:41:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                                                   
                      Con Kolivas                                                                                                  
                      <kernel@kolivas.o        To:       Marcel Zalmanovici/Haifa/IBM@IBMIL                                        
                      rg>                      cc:       linux-kernel@vger.kernel.org                                              
                                               Subject:  Re: Inconsistent timing results of multithreaded program on an SMP        
                      20/11/2005 12:28          machine.                                                                           
                                                                                                                                   
                                                                                                                                   
                                                                                                                                   










On Sun, 20 Nov 2005 21:18, Marcel Zalmanovici wrote:
> Hi Con,
>
> Thanks for the quick reply.

No problems.

Please reply below what you are replying to so we can keep track of email
threads.

>                       <kernel@kolivas.o        To:       Marcel
> Zalmanovici/Haifa/IBM@IBMIL rg>                      cc:
> linux-kernel@vger.kernel.org Subject:  Re: Inconsistent timing results of
> multithreaded program on an SMP 20/11/2005 11:54          machine.
>
> On Sun, 20 Nov 2005 20:27, Marcel Zalmanovici wrote:
> > Hi,
> >
> > I am trying, as part of my thesis, to make some improvement to the
linux
> > scheduler.
> > Therefore I've written a small multithreaded application and tested how
> > long on average it takes for it to complete.
> >
> > The results were very surprising. I expected to see the completion time
> > vary 1 to 2 seconds at most.
> > Instead what I've got was an oscillation where the maximum time was
twice
> > and more than the minimum!! For a short test results ranged ~7sec to
~16
> > sec, and the same happened to longer tests where the min was ~1min and
>
> the
>
> > max ~2:30min.
> >
> > Does anyone have any clue as to what might happen ?
> > Is there anything I can do to get stable results ?
> >
> > Here is a small test case program:
> >
> > (See attached file: sched_test.c)
> >
> > The test was always done on a pretty much empty machine. I've tried
both
> > kernel 2.6.4-52 and 2.6.13.4 but the results were the same.
> >
> > I'm working on a Xeon Intel machine, dual processor, hyperthreaded.
>
>                                                        ^^^^^^^^^^^^^^
>
> I suspect what you're seeing is the random nature of threads to bind
either
> to
> a hyperthread sibling or a real core. If all your threads land on only
one
> physical cpu and both hyperthread siblings it will run much slower than
if
> half land on one physical cpu and half on the other physical cpu. To
> confirm
> this, try setting cpu affinity just for one logical core of each phyiscal
> cpu
> (like affinity for cpu 1 and 3 only for example) or disabling hyperthread
> in
> the bios.

Ok I've had a look at the actual program now ;) Are you timing the time it
takes to completion of everything?

Yes. I'm timing the whole program.

This part of your program:
             for (i= 0; i<8; i++)
                         pthread_join(tid[i], NULL);

Cares about the order the threads finish. Do you think this might be
affecting
your results?

I highly doubt that. The worst case scenario would have thread 0 finish
last right ? but then, all other queries would simply return without
waiting.

Cheers,
Con


