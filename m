Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSH0GEJ>; Tue, 27 Aug 2002 02:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSH0GEJ>; Tue, 27 Aug 2002 02:04:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37118 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314514AbSH0GEI>;
	Tue, 27 Aug 2002 02:04:08 -0400
Date: Tue, 27 Aug 2002 11:41:52 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       davej@suse.de, Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [BKPATCH] Read-Copy Update 2.5
Message-ID: <20020827114152.A2072@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020827022239.C31269@in.ibm.com> <20020826193708.0C64C2C07B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020826193708.0C64C2C07B@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Aug 27, 2002 at 10:24:30AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Tue, Aug 27, 2002 at 10:24:30AM +1000, Rusty Russell wrote:
> In message <20020827022239.C31269@in.ibm.com> you write:
> > +static struct rcu_data rcu_data[NR_CPUS] __cacheline_aligned;
> 
> Not "static DEFINE_PER_CPU(struct rcu_data, rcu_data)"?

Yes, I can use per-cpu data areas here. Done.

> 
> > +/* Fake initialization to work around compiler breakage */
> > +DEFINE_PER_CPU(long, cpu_quiescent) = 0L;
> 
> static?  And I assume you're talking about the tendency for gcc 2.95
> to put uninitialized static vars in the bss, even if they are marked
> as having a section attribute?  If so, you should say so.
> 
> > +#ifdef CONFIG_PREEMPT
> > +/* Fake initialization to work around compiler breakage */
> > +DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr) = 
> > +			{ATOMIC_INIT(0), ATOMIC_INIT(0)};
> > +DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr) = NULL;
> > +DEFINE_PER_CPU(atomic_t, *next_preempt_cntr) = NULL;
> 
> Also static I assume?

So, only statics are broken by gcc 2.95, right ? If so, then
the fake initializers aren't required. I got bitten by this in
another piece of RCU code where there was a static per-cpu
tasklet and I got paranoic after that.

> 
> Other than that, it looks good.  You should probably cc: Ingo Molnar
> as it touches the scheduler...

Ok, I will do that from now on. Thanks for the review.
I will have the new bits up as soon as I finish testing.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
