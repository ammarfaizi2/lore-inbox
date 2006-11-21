Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934272AbWKUBHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934272AbWKUBHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934281AbWKUBHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:07:40 -0500
Received: from mga05.intel.com ([192.55.52.89]:5390 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S934272AbWKUBHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:07:39 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,441,1157353200"; 
   d="scan'208"; a="18154134:sNHT19366767"
Date: Mon, 20 Nov 2006 16:43:38 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [patch] sched: decrease number of load balances
Message-ID: <20061120164338.B17305@unix-os.sc.intel.com>
References: <20061120142633.A17305@unix-os.sc.intel.com> <Pine.LNX.4.64.0611201625240.23868@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0611201625240.23868@schroedinger.engr.sgi.com>; from clameter@sgi.com on Mon, Nov 20, 2006 at 04:39:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 04:39:03PM -0800, Christoph Lameter wrote:
> On Mon, 20 Nov 2006, Siddha, Suresh B wrote:
> 
> > +		if (local_group && balance_cpu != this_cpu && balance) {
> 
> This would need to be *balance right? balance is always != 0.

No. In newly idle case it is NULL. In newly idle case there is likely
some imbalance and hence wanted to go through normal logic of doing load balance
till it finds something. newly idle balance anyhow won't do load balance at NUMA
domain.

> How well was this patch tested?

We have run it through workloads which are used to identify kernel perf
regressions and ran on several DP and MP systems with HT and MC.
(workloads and system info can be found at http://kernel-perf.sourceforge.net)
We didn't find any regression with this patch.

We are also doing more testing with this patch and also wanted to get it tested
in -mm.

> We already have idle processors pulling processes from elsewhere in the 
> system. Load balancing on an idle processor could only replicate the 
> balance on idle logic.

My patch is not changing any idle load balancing logic and hence it is no
less/more aggressive as the current one.

What do you mean by "balance on idle logic"? Are you referring to load_idx that
gets used, based on the processor is idle/busy?

Even with out this patch, if there is an idle processor in a group at domain level
'x',  then the idle processor will do an idle load balance between the groups
at level 'x'. This patch just cuts down the load balances done by the busy
and other idle cpus in the group.

thanks,
suresh
