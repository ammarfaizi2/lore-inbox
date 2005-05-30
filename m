Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVE3T0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVE3T0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVE3T0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:26:38 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:12182 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261703AbVE3T0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:26:00 -0400
Date: Mon, 30 May 2005 21:24:48 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Karim Yaghmour <karim@opersys.com>
Cc: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
In-Reply-To: <429B5316.2080500@opersys.com>
Message-Id: <Pine.OSF.4.05.10505302040560.31148-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Karim Yaghmour wrote:

> 
> [ From my point of view, it is clear that this part of the thread is
> non-technical. IOW, we could go on back-and-worth indefinitely. In
> the following, I'm putting my nanokernel-promoter hat back on to point
> out a few things ... Previous disclaimers still apply :) ]
> 
> James Bruce wrote:
> > I think it's a bit more like you haven't realized the answer when people 
> > gave it, so let me try to be more clear.  It's purely a matter of effort 
> > - in general it's far easier to write one process than two communicating 
> > processes.  As far as APIs, with a single-kernel approach, an RT 
> > programmer just has to restrict the program to calling APIs known to be 
> > RT-safe (compare with MT-safe programming).  In a split-kernel approach, 
> > the programmer has to write RT-kernel support for the APIs he wants to 
> > use (or beg for them to be written).  Most programmers would much rather 
> > limit API usage than implement new kernel support themselves.
> 
> Actually, I would suggest that anybody who's for PREEMPT_RT to drop
> this argument. Fact is, requiring more work on the part of those wanting
> to accomplishing very specialized tasks (such as RT) can very much be
> seen as the Linux way.
> 
> So yes, it sucks having to write two apps, and it sucks having to port
> drivers, but let's face it, 95% of Linux applications and 95% of drivers
> -- statistics accurate 19 times out of 20 with a margin of error of +/-
> 3% :D -- will never ever be used in a hard-rt environment.
> 
You know what? Most of the commercial RTOS I happen to use at work can't
be used for hard RT either. That includes stuff like the IP stack and
filesystem. But the small part which is (the scheduler + syncronization
mechanisms + simple drivers like UARTs) etc is _very_ usefull for RT. Some
of the drivers are not good enough for RT - but most doesn't exist at all!
Same for Linux with PREEMPT_RT: The basis system is hard RT (even better
priority inheritance mechanism) (but not as low latencies). The basis for
making a RT system is there. No, you can't use the IP stack and you can't
use the filesystem from RT threads. But all the 95% which isn't RT works
much better than in the commecial RTOS. And there is a chance that someone
might lift the burden to lift some of it to become RT to various degrees.
With a nanokernel the chance of somebody lifting a subsystem into the
nanokernel space and integrate it with the existing Linux API is very,
very close to nil. (Please, prove me wrong if you have a RT IP-stack
and maybe a RT USB stack for RTAI.)

In my view there is no really big difference between Linux and the RTOS I
use at work except that Linux works much better for all the non-RT
stuff, have better driver support etc. PREEMPT_RT shows that low priority,
non-RT stuff can be made to stop interfering with high priority RT stuff -
with exactly the same mechanisms as in the traditional RTOS, opening the
same kind of posibilities. Unless people start to throw around
raw_spin_lock's or preempt_disable() in subsystem code, I can't see why
you shouldn't rely on it to stay that way.

A subkernel is a _hack_. You must admit that. It was only done in the
first place because Linux was too big a mouthfull to rewrite. Now Ingo
have more or less done it. Why then should we continue to use a hard
to maintain hack, when we can get the real thing?

Ingo's patch have one big advantage: The good chance of going mainstream. 
People might not run with CONFIG_PREEMPT_RT just as most people aren't
running with CONFIG_PREEMPT now, but the code will be there and there will
be large group ready to maintain it once it goes mainstream.

Esben

