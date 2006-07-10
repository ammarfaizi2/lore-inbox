Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWGJO6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWGJO6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWGJO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:58:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:27832 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422648AbWGJO6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:58:02 -0400
Date: Mon, 10 Jul 2006 07:58:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/rcutorture.c: make code static
Message-ID: <20060710145838.GA1446@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709175333.GL13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709175333.GL13938@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 07:53:33PM +0200, Adrian Bunk wrote:
> On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm6:
> >...
> > -srcu-rcu-variant-permitting-read-side-blocking.patch
> > -srcu-2-rcu-variant-permitting-read-side-blocking.patch
> > -srcu-add-srcu-operations-to-rcutorture.patch
> > -srcu-2-add-srcu-operations-to-rcutorture.patch
> > +srcu-3-rcu-variant-permitting-read-side-blocking.patch
> > +srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
> > +srcu-3-add-srcu-operations-to-rcutorture.patch
> > 
> >  Updated srcu patchset.
> >...
> 
> The contents of the patch below somehow got lost during these updates.
> 
> cu
> Adrian

My bad...  I have applied this to my local view.

Andrew, please apply.

							Thanx, Paul

> <--  snip  -->
> 
> 
> This patch makes needlessly global code static.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  kernel/rcutorture.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.17-mm3-full/kernel/rcutorture.c.old	2006-06-27 17:59:20.000000000 +0200
> +++ linux-2.6.17-mm3-full/kernel/rcutorture.c	2006-06-27 18:01:00.000000000 +0200
> @@ -105,11 +105,11 @@
>  static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
>  	{ 0 };
>  static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
> -atomic_t n_rcu_torture_alloc;
> -atomic_t n_rcu_torture_alloc_fail;
> -atomic_t n_rcu_torture_free;
> -atomic_t n_rcu_torture_mberror;
> -atomic_t n_rcu_torture_error;
> +static atomic_t n_rcu_torture_alloc;
> +static atomic_t n_rcu_torture_alloc_fail;
> +static atomic_t n_rcu_torture_free;
> +static atomic_t n_rcu_torture_mberror;
> +static atomic_t n_rcu_torture_error;
>  
>  /*
>   * Allocate an element from the rcu_tortures pool.
> @@ -338,7 +338,7 @@
>  	}
>  }
>  
> -int srcu_torture_stats(char *page)
> +static int srcu_torture_stats(char *page)
>  {
>  	int cnt = 0;
>  	int cpu;
> @@ -567,7 +567,7 @@
>  /* Shuffle tasks such that we allow @rcu_idle_cpu to become idle. A special case
>   * is when @rcu_idle_cpu = -1, when we allow the tasks to run on all CPUs.
>   */
> -void rcu_torture_shuffle_tasks(void)
> +static void rcu_torture_shuffle_tasks(void)
>  {
>  	cpumask_t tmp_mask = CPU_MASK_ALL;
>  	int i;
> 
> 
