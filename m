Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDEH7S>; Thu, 5 Apr 2001 03:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRDEH7J>; Thu, 5 Apr 2001 03:59:09 -0400
Received: from out2.prserv.net ([32.97.166.32]:54495 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S132570AbRDEH65>;
	Thu, 5 Apr 2001 03:58:57 -0400
Message-Id: <m14krR1-001PKbC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: nigel@nrg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Sun, 01 Apr 2001 14:07:42 MST."
             <Pine.LNX.4.05.10104011347060.14420-100000@cosmic.nrg.org> 
Date: Thu, 05 Apr 2001 03:51:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.05.10104011347060.14420-100000@cosmic.nrg.org> you write
:
> > Setting a running task's flags brings races, AFAICT, and checking
> > p->state is NOT sufficient, consider wait_event(): you need p->has_cpu
> > here I think.
> 
> My thought here was that if p->state is anything other than TASK_RUNNING
> or TASK_RUNNING|TASK_PREEMPTED, then that task is already at a
> synchonize point,

Right.  Theoretically possible to set p->state and not sleep, but it's
not a bad assumption.

> > schedule():
> > 	if (!(prev->state & TASK_PREEMPTED) && prev->syncing)
> > 		if (--sync_count == 0) wake_up(&syncing_task);
> 
> Don't forget to reset prev->syncing.

Right.

> I agree with you about wait queues, but didn't use them here because
> of the problem of avoiding deadlock on the runqueue lock, which the
> wait queues also use.

And right again.  Yeah, it has to be done manually.  Ack, can I
retract that Email?

Rusty.
--
Premature optmztion is rt of all evl. --DK
