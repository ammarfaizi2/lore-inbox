Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSIWV1V>; Mon, 23 Sep 2002 17:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSIWV1U>; Mon, 23 Sep 2002 17:27:20 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:61568 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261451AbSIWV1N>; Mon, 23 Sep 2002 17:27:13 -0400
Date: Mon, 23 Sep 2002 14:32:21 -0700
To: Larry McVoy <lm@work.bitmover.com>
Cc: Larry McVoy <lm@work.bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923213221.GD2075@gnuppy.monkey.org>
References: <20020922143257.A8397@work.bitmover.com> <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com> <20020923083004.B14944@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923083004.B14944@work.bitmover.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:30:04AM -0700, Larry McVoy wrote:
> > No matter how fast you do context switch in and out of kernel and a sched
> > to see what runs next, it can't be done as fast as it can be avoided.
> 
> You are arguing about how many angels can dance on the head of a pin.
> Sure, there are lotso benchmarks which show how fast user level threads
> can context switch amongst each other and it is always faster than going
> into the kernel.  So what?  What do you think causes a context switch in
> a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%

That's just for traditional Unix applications, which is only one category.
You exclude CPU intensive applications in that criticism, media related
and otherwise. What about cases where you need to balance a large data
structure across large number of threads or something like that ?

> of the time?  And doesn't that mean you already went into the kernel to
> see if the I/O was ready?  And doesn't that mean that in all the real
> world applications they are already doing all the work you are arguing
> to avoid?

IO isn't the only thing that's event driven. What about event driven
systems that depend on a fast condition-variable ? That's very cheap in
a UTS (userspace thread system), 2 context switches, a call to thread-kernel
to dequeue a waiter and releasing/aquiring some very light weight userspace
locks. And difficult to beat if you think about it.

So that level of confidence in 1:1 is a intuitively presumptuous for those
reasons.

But if you're architecture is broken or exotic...then it gets more complicated ;)

bill

