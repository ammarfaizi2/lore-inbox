Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSH0Ac2>; Mon, 26 Aug 2002 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSH0Ac2>; Mon, 26 Aug 2002 20:32:28 -0400
Received: from dp.samba.org ([66.70.73.150]:11730 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318308AbSH0Ac2>;
	Mon, 26 Aug 2002 20:32:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       davej@suse.de, Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [BKPATCH] Read-Copy Update 2.5 
In-reply-to: Your message of "Tue, 27 Aug 2002 02:22:39 +0530."
             <20020827022239.C31269@in.ibm.com> 
Date: Tue, 27 Aug 2002 10:24:30 +1000
Message-Id: <20020826193708.0C64C2C07B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020827022239.C31269@in.ibm.com> you write:
> +static struct rcu_data rcu_data[NR_CPUS] __cacheline_aligned;

Not "static DEFINE_PER_CPU(struct rcu_data, rcu_data)"?

> +/* Fake initialization to work around compiler breakage */
> +DEFINE_PER_CPU(long, cpu_quiescent) = 0L;

static?  And I assume you're talking about the tendency for gcc 2.95
to put uninitialized static vars in the bss, even if they are marked
as having a section attribute?  If so, you should say so.

> +#ifdef CONFIG_PREEMPT
> +/* Fake initialization to work around compiler breakage */
> +DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr) = 
> +			{ATOMIC_INIT(0), ATOMIC_INIT(0)};
> +DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr) = NULL;
> +DEFINE_PER_CPU(atomic_t, *next_preempt_cntr) = NULL;

Also static I assume?

Other than that, it looks good.  You should probably cc: Ingo Molnar
as it touches the scheduler...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
