Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314385AbSDRRu0>; Thu, 18 Apr 2002 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSDRRuZ>; Thu, 18 Apr 2002 13:50:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43727 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314401AbSDRRuX>; Thu, 18 Apr 2002 13:50:23 -0400
Date: Thu, 18 Apr 2002 10:48:04 -0700 (PDT)
From: Dave Olien <oliendm@us.ibm.com>
Message-Id: <200204181748.g3IHm4K08649@eng2.beaverton.ibm.com>
To: davidsen@tmr.com, jbourne@MtRoyal.AB.CA
Subject: Re: SMP P4 APIC/interrupt balancing
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>, Molnar@tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cache warmth in handling interrupts is good.  In fact, this is one
of the reasons to use interrupt affinity.

But, directing all interrupts to single processor penalizes unfairly any
tasks that are scheduled to run on that processor.  Under heavy interrupt
load, a tasks can become effectively "pinned" onto that processor, unable
to get cpu time to make progress, and unable to be scheduled somewhere
else.

Under really heavy interrupt load, it's good to have
many processors handling interrupts.  It increases rate the system
can handle interrupts, and it reduces the latency of individual interrupts.


Dave.


> From linux-kernel-owner@vger.kernel.org Thu Apr 18 09:11:22 2002
> Date: 	Thu, 18 Apr 2002 12:04:35 -0400 (EDT)
> From: Bill Davidsen <davidsen@tmr.com>
> To: James Bourne <jbourne@MtRoyal.AB.CA>
> cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>    Ingo Molnar <mingo@elte.hu>
> Subject: Re: SMP P4 APIC/interrupt balancing
> 
>   Is this positive or negative on performance? If you have a system
> getting so many interrupts that one CPU can't handle them, obviously there
> is a gain. However, by thrashing the cache of all CPUs instead of just one
> you have some memory performance cost.
> 
>   I first looked at this for a mainframe vendor who decided that putting
> all the interrupts in one CPU was better. That was then, this is now, but
> I am curious about metrics, like real and system time doing a kernel
> compile, etc.
> 
