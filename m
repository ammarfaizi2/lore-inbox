Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWJ1SSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJ1SSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWJ1SSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:18:38 -0400
Received: from mga05.intel.com ([192.55.52.89]:57377 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751308AbWJ1SSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:18:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,368,1157353200"; 
   d="scan'208"; a="8775908:sNHT19147797"
Date: Sat, 28 Oct 2006 10:57:27 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 5/7] Move idle stat calculation into rebalance_tick()
Message-ID: <20061028105727.A9917@unix-os.sc.intel.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com> <20061028024138.10809.27755.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061028024138.10809.27755.sendpatchset@schroedinger.engr.sgi.com>; from clameter@sgi.com on Fri, Oct 27, 2006 at 07:41:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 07:41:38PM -0700, Christoph Lameter wrote:
> Index: linux-2.6.19-rc3/kernel/sched.c
> ===================================================================
> --- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-27 15:43:45.467245352 -0500
> +++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 15:45:30.794096498 -0500
> @@ -2849,10 +2849,16 @@ static void update_load(struct rq *this_
>   * Balancing parameters are set up in arch_init_sched_domains.
>   */
>  static void
> -rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
> +rebalance_tick(int this_cpu, struct rq *this_rq)
>  {
>  	unsigned long interval;
>  	struct sched_domain *sd;
> +	/*
> +	 * A task is idle if this is the idle queue
> +	 * and we have no runnable task
> +	 */
> +	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
> +				SCHED_IDLE : NOT_IDLE;

this_rq->idle will always be set to idle task. You wanted to check, if
the current task is idle or not, right? Perhaps we can skip that and
just check for nr_running..

comment needs to be fixed and also please mention that in case of SMT nice,
nr_running will determine if the processor is idle or not(rather than
checking for current task is idle)

thanks,
suresh
