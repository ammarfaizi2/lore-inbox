Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293142AbSCEBb1>; Mon, 4 Mar 2002 20:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293143AbSCEBbR>; Mon, 4 Mar 2002 20:31:17 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:32530 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293142AbSCEBbM>; Mon, 4 Mar 2002 20:31:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        Hubertus Franke <frankeh@watson.ibm.com>
In-Reply-To: Your message of "04 Mar 2002 14:49:51 CDT."
             <1015271393.15277.112.camel@phantasy> 
Date: Tue, 05 Mar 2002 12:34:29 +1100
Message-Id: <E16i3qX-0005H3-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1015271393.15277.112.camel@phantasy> you write:
> > +static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
> 
> Could we make this per-waitqueue?

Yes, once someone gives benchmarks proving it's worth doing the whole
"multiple locks and cache aligned" thing.  Until then, it's premature
optimization.

> We should do:
> 
> 	#define FUTEX_UP	1
> 	#define FUTEX_DOWN	-1

Ack.  Definitely.

> here.  The preempt statements compile away if CONFIG_PREEMPT is not set,
> so you can just put them in, even on arches that don't do preemption
> yet.

Oops, that code shouldn't have been in patch, and the only reason that
preempt_disable() was commented out is that I tested the patch on 2.4.

> ... oh, and I would love an example of using it in userspace ;)

I'll throw it in for patch IV. 8)

> Nice work, Rusty.

I don't know if I can accept the kudos: it's now hovering at about 70%
my code, but only 20% my ideas.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
