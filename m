Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRDGUKi>; Sat, 7 Apr 2001 16:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRDGUK1>; Sat, 7 Apr 2001 16:10:27 -0400
Received: from [195.55.70.99] ([195.55.70.99]:1798 "EHLO mozart")
	by vger.kernel.org with ESMTP id <S131346AbRDGUKN>;
	Sat, 7 Apr 2001 16:10:13 -0400
Message-Id: <m14lysQ-001PHqC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        nigel@nrg.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Fri, 06 Apr 2001 18:25:36 MST."
             <OF37B0793C.6B15F182-ON88256A27.0007C3EF@LocalDomain> 
Date: Sun, 08 Apr 2001 05:59:49 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <OF37B0793C.6B15F182-ON88256A27.0007C3EF@LocalDomain> you write:
> > Priority inversion is not handled in Linux kernel ATM BTW, there
> > are already situations where a realtime task can cause a deadlock
> > with some lower priority system thread (I believe there is at least
> > one case of this known with realtime ntpd on 2.4)
> 
> I see your point here, but need to think about it.  One question:
> isn't it the case that the alternative to using synchronize_kernel()
> is to protect the read side with explicit locks, which will themselves
> suppress preemption?  If so, why not just suppress preemption on the read
> side in preemptible kernels, and thus gain the simpler implementation
> of synchronize_kernel()?  You are not losing any preemption latency
> compared to a kernel that uses traditional locks, in fact, you should
> improve latency a bit since the lock operations are more expensive than
> are simple increments and decrements.  As usual, what am I missing
> here?  ;-)

Already preempted tasks.

> Another approach would be to define a "really low" priority that noone
> other than synchronize_kernel() was allowed to use.  Then the UP
> implementation of synchronize_kernel() could drop its priority to
> this level, yield the CPU, and know that all preempted tasks must
> have obtained and voluntarily yielded the CPU before synchronize_kernel()
> gets it back again.

Or "never", because I'm running RC5 etc. 8(.

Rusty.
--
Premature optmztion is rt of all evl. --DK
