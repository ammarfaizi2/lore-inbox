Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVLSEXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVLSEXE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVLSEXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:23:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:10442 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030245AbVLSEXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:23:02 -0500
Date: Mon, 19 Dec 2005 05:22:48 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219042248.GG23384@wotan.suse.de>
References: <20051219013415.GA27658@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219013415.GA27658@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
>     8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
>     checking VFS performance.          checking VFS performance.
>     avg loops/sec:      34713          avg loops/sec:      84153
>     CPU utilization:    63%            CPU utilization:    22%
> 
>    i.e. in this workload, the mutex based kernel was 2.4 times faster 
>    than the semaphore based kernel, _and_ it also had 2.8 times less CPU 
>    utilization. (In terms of 'ops per CPU cycle', the semaphore kernel 
>    performed 551 ops/sec per 1% of CPU time used, while the mutex kernel 
>    performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times 
>    more efficient.)

Do you have an idea where this big difference comes from? It doesn't look
it's from the fast path which is essentially the same.  Do the mutexes have
that much better scheduling behaviour than semaphores? It is a bit hard to 
believe.

I would perhaps understand your numbers if you used adaptive mutexes 
or similar that spin for a bit, but just for pure sleeping locks it seems 
weird. After all the scheduler should work in the same way for both.

-Andi

