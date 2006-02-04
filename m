Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946268AbWBDCh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946268AbWBDCh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946269AbWBDCh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:37:57 -0500
Received: from fmr23.intel.com ([143.183.121.15]:15786 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1946268AbWBDCh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:37:56 -0500
Date: Fri, 3 Feb 2006 18:36:52 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: hawkes@sgi.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] load_balance: "busiest CPU" -> "busier CPUs"
Message-ID: <20060203183651.A24554@unix-os.sc.intel.com>
References: <20060204003807.28210.77735.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060204003807.28210.77735.sendpatchset@tomahawk.engr.sgi.com>; from hawkes@sgi.com on Fri, Feb 03, 2006 at 04:38:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 04:38:07PM -0800, hawkes@sgi.com wrote:
> In these circumstances, an all-pinned "busiest CPU" will effectively
> disable load_balance balancing.

Solving all the load balancing issues that occur under all-pinned case is
tricy... For example, even with this patch, at a particular sched domain,
load balance might still be disabled for the cpus which belong to the same 
sched group as the all-pinned "busiest CPU"

> @@ -243,6 +243,8 @@ struct runqueue {
>  	int active_balance;
>  	int push_cpu;
>  
> +	int cpuid;			/* of this runqueue */
> +
>  	task_t *migration_thread;
>  	struct list_head migration_queue;

A simple change to find_busiest_queue() can avoid that addition to the
runqueue struct.

thanks,
suresh
