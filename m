Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVLSE3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVLSE3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVLSE3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:29:32 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:28920 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030249AbVLSE3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:29:31 -0500
Date: Sun, 18 Dec 2005 23:28:43 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <20051219042248.GG23384@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0512182327280.3446@gandalf.stny.rr.com>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2005, Andi Kleen wrote:

> >     $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
> >     8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
> >     checking VFS performance.          checking VFS performance.
> >     avg loops/sec:      34713          avg loops/sec:      84153
> >     CPU utilization:    63%            CPU utilization:    22%
> >
> >    i.e. in this workload, the mutex based kernel was 2.4 times faster
> >    than the semaphore based kernel, _and_ it also had 2.8 times less CPU
> >    utilization. (In terms of 'ops per CPU cycle', the semaphore kernel
> >    performed 551 ops/sec per 1% of CPU time used, while the mutex kernel
> >    performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times
> >    more efficient.)
>
> Do you have an idea where this big difference comes from? It doesn't look
> it's from the fast path which is essentially the same.  Do the mutexes have
> that much better scheduling behaviour than semaphores? It is a bit hard to
> believe.
>
> I would perhaps understand your numbers if you used adaptive mutexes
> or similar that spin for a bit, but just for pure sleeping locks it seems
> weird. After all the scheduler should work in the same way for both.
>

Perhaps it's the smaller structures, as Ingo said, which would allow for
better cache handling.

-- Steve

