Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRDDQwA>; Wed, 4 Apr 2001 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132822AbRDDQvt>; Wed, 4 Apr 2001 12:51:49 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12144 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132817AbRDDQvm>; Wed, 4 Apr 2001 12:51:42 -0400
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104041650.JAA95432@google.engr.sgi.com>
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 4 Apr 2001 09:50:58 -0700 (PDT)
Cc: mingo@elte.hu (Ingo Molnar), frankeh@us.ibm.com (Hubertus Franke),
        mkravetz@sequent.com (Mike Kravetz),
        fabio@chromium.com (Fabio Riccardi),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
In-Reply-To: <20010404170846.V20911@athlon.random> from "Andrea Arcangeli" at Apr 04, 2001 05:08:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I didn't seen anything from Kanoj but I did something myself for the wildfire:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/10_numa-sched-1
> 
> this is mostly an userspace issue, not really intended as a kernel optimization
> (however it's also partly a kernel optimization). Basically it splits the load
> of the numa machine into per-node load, there can be unbalanced load across the
> nodes but fairness is guaranteed inside each node. It's not extremely well
> tested but benchmarks were ok and it is at least certainly stable.
>

Just a quick comment. Andrea, unless your machine has some hardware
that imply pernode runqueues will help (nodelevel caches etc), I fail 
to understand how this is helping you ... here's a simple theory though. 
If your system is lightly loaded, your pernode queues are actually 
implementing some sort of affinity, making sure processes stick to 
cpus on nodes where they have allocated most of their memory on. I am 
not sure what the situation will be under huge loads though.

As I have mentioned to some people before, percpu/pernode/percpuset/global
runqueues probably all have their advantages and disadvantages, and their
own sweet spots. Wouldn't it be really neat if a system administrator
or performance expert could pick and choose what scheduler behavior he
wants, based on how the system is going to be used?

Kanoj
