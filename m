Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTLMCUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLMCUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:20:42 -0500
Received: from dp.samba.org ([66.70.73.150]:32464 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263137AbTLMCUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:20:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler 
In-reply-to: Your message of "Fri, 12 Dec 2003 18:00:42 +1100."
             <3FD9679A.1020404@cyberone.com.au> 
Date: Fri, 12 Dec 2003 18:23:36 +1100
Message-Id: <20031213022038.300B22C2C1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FD9679A.1020404@cyberone.com.au> you write:
> 
> Thanks for having a look Rusty. I'll try to convince you :)
> 
> As you know, the domain classes is not just for HT, but can do multi levels
> of NUMA, and it can be built by architecture specific code which is good
> for Opteron, for example. It doesn't need CONFIG_SCHED_SMT either, of 
> course,
> or CONFIG_NUMA even: degenerate domains can just be collapsed (code isn't
> there to do that now).

Yes, but this isn't what we really want.  I'm actually accusing you of
lacking ambition 8)

> Shared runqueues I find isn't so flexible. I think it perfectly describes
> the P4 HT architecture, but what happens if (when) siblings get seperate
> L1 caches? What about SMT, CMP, SMP and NUMA levels in the POWER5?

It describes every HyperThread implementation I am aware of today, so
it suits us fine for the moment.  Runqueues may still be worth sharing
even if L1 isn't, for example.

> The large SGI (and I imagine IBM's POWER5s) systems need things like
> progressive balancing backoff and would probably benefit with a more
> heirachical balancing scheme so all the balancing operations don't kill
> the system.

But this is my point.  Scheduling is one part of the problem.  I want
to be able to have the arch-specific code feed in a description of
memory and cpu distances, bandwidths and whatever, and have the
scheduler, slab allocator, per-cpu data allocation, page cache, page
migrator and anything else which cares adjust itself based on that.

Power 4 today has pairs of CPUs on a die, four dies on a board, and
four boards in a machine.  I want one infrastructure to descibe it,
not have to do program every infrastructure from arch-specific code.

> w26 does ALL this, while sched.o is 3K smaller than Ingo's shared runqueue
> patch on NUMA and SMP, and 1K smaller on UP (although sched.c is 90 lines
> longer). kernbench system time is down nearly 10% on the NUMAQ, so it isn't
> hurting performance either.

Agreed, but Ingo's shared runqueue patch is poor implementation of a
good idea: I've always disliked it.  I'm halfway through updating my
patch, and I really think you'll like it better.  It's not
incompatible with NUMA changes, in fact it's fairly non-invasive.

> And finally, Linus also wanted the balancing code to be generalised to
> handle SMT, and Ingo said he liked my patch from a first look.

Oh, I like your patch too (except those #defines should really be an
enum).  I just think we can do better with less.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
