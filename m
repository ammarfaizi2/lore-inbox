Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSKKSLD>; Mon, 11 Nov 2002 13:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbSKKSLD>; Mon, 11 Nov 2002 13:11:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:39390 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266907AbSKKSLB>;
	Mon, 11 Nov 2002 13:11:01 -0500
Message-ID: <3DCFF447.43EE55FE@digeo.com>
Date: Mon, 11 Nov 2002 10:17:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: programming for preemption (was: [PATCH] 2.5.46: accesspermission 
 filesystem)
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk>
		<87k7jkg969.fsf@goat.bogus.local> <3DCF1593.CB9C7AA4@digeo.com> <87znsgov9e.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 18:17:43.0761 (UTC) FILETIME=[A0F65C10:01C289AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> 
> > Olaf Dietsche wrote:
> >>
> >> Ben Clifford <benc@hawaga.org.uk> writes:
> >>
> >> > I still get those stack traces, though...
> >>
> >> I retested with CONFIG_PREEMPT=y and now I get those stack traces,
> >> too. So, it seems my code is not preempt safe.
> >>
> >
> > It's not that your code is unsafe with preemption.  It's just that
> > CONFIG_PREEMPT=y turns on the debugging infrastructure which allows
> > us to detect things like calling kmalloc(GFP_KERNEL) inside spinlock.
> 
> Thanks for this hint. So this means kmalloc(GFP_KERNEL) inside
> spinlock is not necessarily dangerous, but should be avoided if
> possible?

It can lock an SMP kernel up.  This CPU can switch to another task in the
page allocator and then, within the context of the new task, come around
and try to take the same lock.

> Is using a semaphore better than using spinlocks?

A semaphore won't have that problem.  If your CPU comes around again onto
the already-held lock it will just switch to another task.

> Is
> there a list of dos and don'ts for preempt kernels beside
> Documentation/preempt-locking.txt?

Not that I'm aware of.  (This is not preempt-related though.  Generally,
correct SMP coding is correct preempt coding)
 
> And btw, who is "us"?
> 

It is a broad term for "those who code on the kernel".
