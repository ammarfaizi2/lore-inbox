Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946494AbWJSVA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946494AbWJSVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946496AbWJSVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:00:56 -0400
Received: from mga05.intel.com ([192.55.52.89]:55379 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1946494AbWJSVAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:00:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="5730279:sNHT671350653"
Date: Thu, 19 Oct 2006 13:40:46 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
Message-ID: <20061019134046.A2305@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com> <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com> <45366DF0.6040702@yahoo.com.au> <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com> <45367D32.6090301@yahoo.com.au> <Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com> <20061018191900.D26521@unix-os.sc.intel.com> <Pine.LNX.4.64.0610190736210.7337@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0610190736210.7337@schroedinger.engr.sgi.com>; from clameter@sgi.com on Thu, Oct 19, 2006 at 08:50:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 08:50:50AM -0700, Christoph Lameter wrote:
> Ok. Thanks. Would this work?
> 
> Index: linux-2.6.19-rc2-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.19-rc2-mm1.orig/kernel/sched.c	2006-10-19 09:39:08.000000000 -0500
> +++ linux-2.6.19-rc2-mm1/kernel/sched.c	2006-10-19 09:42:10.733631242 -0500
> @@ -2846,7 +2846,8 @@ static void rebalance_tick(unsigned long
>  	struct sched_domain *sd;
>  	int i, scale;
>  
> -	idle = (current == this_rq->idle) ? SCHED_IDLE : NOT_IDLE;
> +	idle = (current == this_rq->idle && !this_rq->nr_running) ?
> +				SCHED_IDLE : NOT_IDLE;

A comment of why we are checking for nr_running would be nice.

And one more thing. We can reduce some of the tasklet invoking complexity
by actually checking for a load_balance() need at any domain and thus
invoking tasklet which will do the load balance, rather than unconditionally
invoking tasklet for each tick.

thanks,
suresh
