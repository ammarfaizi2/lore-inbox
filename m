Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDSGmi>; Fri, 19 Apr 2002 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311618AbSDSGmf>; Fri, 19 Apr 2002 02:42:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31207 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S311587AbSDSGmd>;
	Fri, 19 Apr 2002 02:42:33 -0400
Date: Fri, 19 Apr 2002 06:38:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Dave Olien <oliendm@us.ibm.com>
Cc: davidsen@tmr.com, <jbourne@MtRoyal.AB.CA>, <linux-kernel@vger.kernel.org>,
        <Molnar@tmr.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <200204181748.g3IHm4K08649@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0204190635060.3975-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Apr 2002, Dave Olien wrote:

> Cache warmth in handling interrupts is good.  In fact, this is one of
> the reasons to use interrupt affinity.

and in fact this is why IRQ handlers in the irqbalance patch stay affine
to a single CPU for at least 10 msecs. So for most practical purposes when
there is no direct affinity between tasks and IRQs, this brings us very
close the highest possible affinity that can be achieved.

/proc/irq/*/smp_affinity is still preserved for those workloads when some
direct relationship can be established between process activity and IRQ
load. (such as perfectly partitioned server workloads.)

> But, directing all interrupts to single processor penalizes unfairly any
> tasks that are scheduled to run on that processor.  Under heavy
> interrupt load, a tasks can become effectively "pinned" onto that
> processor, unable to get cpu time to make progress, and unable to be
> scheduled somewhere else.
> 
> Under really heavy interrupt load, it's good to have many processors
> handling interrupts.  It increases rate the system can handle
> interrupts, and it reduces the latency of individual interrupts.

yes, this is why the irqbalance patch goes to great lengths to assure that
distribution of IRQs is as random as possible, with the following
variation: idle CPUs are more likely to be used by the IRQ balancing
mechanism than busy CPUs.

	Ingo

