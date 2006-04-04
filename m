Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWDDGiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWDDGiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWDDGiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:38:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28296 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751822AbWDDGix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:38:53 -0400
Date: Tue, 4 Apr 2006 08:36:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: improve smpnice load balancing when load per task imbalanced
Message-ID: <20060404063614.GA1796@elte.hu>
References: <44320FE5.5080309@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44320FE5.5080309@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> Problem:
> 
> 2 CPU system: if the cpu-0 has two high priority and cpu-1 has one 
> normal priority task, how can the current code detect this imbalance 
> because imbalance will be always < busiest_load_per_task and max_load 
> - this_load will be < 2 * busiest_load_per_task and pwr_move will be 
> <= pwr_now.
> 
> Solution:
> 
> Modify the assessment of small imbalances to take into account the 
> relative sizes of busiest_load_per_task and this_load_per_task.  This 
> is exploiting the fact that if the difference between the loads is 
> greater than busiest_load_per_task and busiest_load_per_task is 
> greater than this_load_per_task then moving busiest_load_per_task 
> worth of load from busiest to this will be an improvement in the 
> distribution of weighted load.
> 
> Required patches:
> 
> sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
> sched-improve-stability-of-smpnice-load-balancing.patch
> 
> Note: This patch makes no change to load balancing in the case where 
> all tasks are nice==0.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
