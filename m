Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261414AbSIWTvQ>; Mon, 23 Sep 2002 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSIWTvQ>; Mon, 23 Sep 2002 15:51:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23816 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261414AbSIWTvO>; Mon, 23 Sep 2002 15:51:14 -0400
Date: Mon, 23 Sep 2002 15:48:58 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020923083004.B14944@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Larry McVoy wrote:

> > No matter how fast you do context switch in and out of kernel and a sched
> > to see what runs next, it can't be done as fast as it can be avoided.
> 
> You are arguing about how many angels can dance on the head of a pin.

Than you have sadly misunderstood the discussion.

> Sure, there are lotso benchmarks which show how fast user level threads
> can context switch amongst each other and it is always faster than going
> into the kernel.  So what?  What do you think causes a context switch in
> a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
> of the time?  And doesn't that mean you already went into the kernel to
> see if the I/O was ready?  And doesn't that mean that in all the real
> world applications they are already doing all the work you are arguing
> to avoid?

Actually you have it just backward. Let me try to explain how this works.
The programs which benefit from N:M are exactly those which don't behave
the way you describe. Think of programs using locking to access shared
memory, or other fast resources which don't require a visit to the kernel.
It would seem that the switch could be done much faster without the
transition into and out of the kernel.

Looking for data before forming an opinion has always seemed to be
reasonable, and the way design decisions are usually made in Linux, based
on the performance of actual code. The benchmark numbers reports are
encouraging, but actual production loads may not show the huge improvement
seen in the benchmarks. And I don't think anyone is implying that they
will.

Given how small the overhead of threading is on a typical i/o bound
application such as you mentioned, I'm not sure the improvement will be
above the noise. The major improvement from NGPT is not performance in
many cases, but elimination of unexpected application behaviour.

When someone responds to a technical question with an attack on the
question instead of a technical response I always wonder why. In this case
other people have provided technical feedback and I'm sure we will see
some actual application numbers in a short time. I have an IPC benchmark
I'd like to try if I could get any of my test servers to boot a recent
kernel :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

