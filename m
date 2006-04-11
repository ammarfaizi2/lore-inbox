Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWDKOfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWDKOfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWDKOfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:35:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:3811 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751020AbWDKOfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:35:07 -0400
Date: Tue, 11 Apr 2006 07:35:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/rcupdate.c: kill synchronize_kernel()
Message-ID: <20060411143531.GA1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060411035100.GD3190@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411035100.GD3190@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Adrian,

This one is on my list for May 1st.  At that time, I will submit a
patch such that:

o	synchronize_kernel() goes away

o	call_rcu() and call_rcu_bh() become EXPORT_SYMBOL_GPL().

						Thanx, Paul

On Tue, Apr 11, 2006 at 05:51:01AM +0200, Adrian Bunk wrote:
> synchronize_kernel() is both deprecated and completely unused.
> 
> Let's kill this bloat.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/RCU/whatisRCU.txt |    1 -
>  include/linux/rcupdate.h        |    1 -
>  kernel/rcupdate.c               |    9 ---------
>  3 files changed, 11 deletions(-)
> 
> --- linux-2.6.17-rc1-mm2-full/Documentation/RCU/whatisRCU.txt.old	2006-04-11 01:23:39.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/Documentation/RCU/whatisRCU.txt	2006-04-11 01:23:45.000000000 +0200
> @@ -790,7 +790,6 @@
>  
>  RCU grace period:
>  
> -	synchronize_kernel (deprecated)
>  	synchronize_net
>  	synchronize_sched
>  	synchronize_rcu
> --- linux-2.6.17-rc1-mm2-full/include/linux/rcupdate.h.old	2006-04-11 01:23:53.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/include/linux/rcupdate.h	2006-04-11 01:24:28.000000000 +0200
> @@ -263,7 +263,6 @@
>  				void (*func)(struct rcu_head *head)));
>  extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
>  				void (*func)(struct rcu_head *head)));
> -extern __deprecated_for_modules void synchronize_kernel(void);
>  extern void synchronize_rcu(void);
>  void synchronize_idle(void);
>  extern void rcu_barrier(void);
> --- linux-2.6.17-rc1-mm2-full/kernel/rcupdate.c.old	2006-04-11 01:24:36.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/kernel/rcupdate.c	2006-04-11 01:24:57.000000000 +0200
> @@ -593,14 +593,6 @@
>  	wait_for_completion(&rcu.completion);
>  }
>  
> -/*
> - * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
> - */
> -void synchronize_kernel(void)
> -{
> -	synchronize_rcu();
> -}
> -
>  module_param(blimit, int, 0);
>  module_param(qhimark, int, 0);
>  module_param(qlowmark, int, 0);
> @@ -611,4 +603,3 @@
>  EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
>  EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
> -EXPORT_SYMBOL_GPL_FUTURE(synchronize_kernel); /* WARNING: GPL-only in April 2006. */
> 
