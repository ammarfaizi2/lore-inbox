Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270683AbUJUOYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270683AbUJUOYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbUJUOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:24:21 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:32987 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S270683AbUJUOUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:20:33 -0400
Date: Thu, 21 Oct 2004 16:16:35 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: john cooper <john.cooper@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
In-Reply-To: <4177A49E.3060901@timesys.com>
Message-Id: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, john cooper wrote:

> Ingo Molnar wrote:
> 
> >* Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >
> >>Yeah, for a semaphore it is, but not for a mutex.
> >>
> >
> >but mutexes dont exist in upstream Linux as a separate entity. (they
> >exist in my tree but that's another ballgame.)
> >
> Mutexes layered on existing semaphores seems convenient
> at the moment. However a more native mutex mechanism
> which tracks ownership would provide a basis for PI as
> well as further instrumentation. This may not be an
> issue at the present but I don't think it is too far
> off.
> 
> -john
> 

Actually you need to have another kind of semaphore based on a new kind of
wait-queue: Priority based. I.e. the task with the highest priority get
woken up first. Then on top of that you build your mutex.

I was planning to start to look at it and try to see if I could get
anything to work, but I must admit I haven't got much further than
just getting Igno's -U8.1 up running.

An idea I had was to make a macro in list.h called
 list_insert_sorted(list, element, condition_statement)
and use that in this kind of wait_queue...

To get a mutex with priority inheritance add an element pointing to the
current owner and a field where you store the owners original priority
which it has to be set back to when it relases the mutex (I am not sure
how this will work out if someone holds several mutexes!)

Regards,
Esben


