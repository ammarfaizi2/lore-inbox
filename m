Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWJSCjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWJSCjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 22:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423211AbWJSCjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 22:39:03 -0400
Received: from mga05.intel.com ([192.55.52.89]:3853 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1423223AbWJSCjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 22:39:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,326,1157353200"; 
   d="scan'208"; a="5397351:sNHT18314145"
Date: Wed, 18 Oct 2006 19:19:00 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
Message-ID: <20061018191900.D26521@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com> <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com> <45366DF0.6040702@yahoo.com.au> <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com> <45367D32.6090301@yahoo.com.au> <Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com>; from clameter@sgi.com on Wed, Oct 18, 2006 at 02:59:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:59:07PM -0700, Christoph Lameter wrote:
> load_balancing has the potential of running for some time if f.e.
> sched_domains for a system with 1024 processors have to be balanced.
> We currently do all of that with interrupts disabled. So we may be unable
> to service interrupts for some time. Most of that time is potentially
> spend in rebalance_tick.

Did you see an issue because of this or just theoretical?

> +static void rebalance_tick(unsigned long dummy)
>  {
> +	int this_cpu = smp_processor_id();
> +	struct rq *this_rq = cpu_rq(this_cpu);
> +	enum idle_type idle;
>  	unsigned long this_load, interval, j = cpu_offset(this_cpu);
>  	struct sched_domain *sd;
>  	int i, scale;
>  
> +	idle = (current == this_rq->idle) ? SCHED_IDLE : NOT_IDLE;

We need to add nr_running check too, to determine if we want to do
idle/not-idle balancing. This is in the context of wake_priority_sleeper()

thanks,
suresh
