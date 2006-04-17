Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWDQRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWDQRBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDQRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:01:54 -0400
Received: from mga07.intel.com ([143.182.124.22]:8712 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751154AbWDQRBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:01:54 -0400
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24063671:sNHT54435787"
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24063642:sNHT47056177"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24063609:sNHT52214085"
Date: Mon, 17 Apr 2006 09:59:20 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing outcomes
Message-ID: <20060417095920.A19931@unix-os.sc.intel.com>
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au> <20060414112750.A21908@unix-os.sc.intel.com> <44404455.8090304@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44404455.8090304@bigpond.net.au>; from pwil3058@bigpond.net.au on Sat, Apr 15, 2006 at 10:54:45AM +1000
X-OriginalArrivalTime: 17 Apr 2006 17:01:26.0520 (UTC) FILETIME=[904F8F80:01C66240]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 10:54:45AM +1000, Peter Williams wrote:
> Yes, there are problems with the active/expired arrays but they're no 
> worse with smpnice than they are without it.

With smpnice, if we make any wrong decision while moving the high and
low priority tasks, we will enter an endless loop(as load balance
will keep on showing the imbalance and move_tasks will always move
the wrong tasks, instead of the correct ones pointed by imbalance..)

With the current code in the mainline, we don't have such a problem.

> Going to a single priority array would eliminate this problem not to 
> mention other problems to do with when to excuse tasks from being put on 
> the expired array at the end of their time slice (see Mike Galbraith's 
> patches).  But I haven't had much luck pushing that barrow. :-)

I will take a loot at those patches.

> If you have a better suggestion for how move_tasks() does its job, how 
> about providing a patch and with supporting arguments as to why its 
> better.  If it is better then we can use it.

I think we can have a second pass(if the first pass fails to move any),
in which we will not skip those tasks which will become highest priority
on the target runqueue...

> > The only special check in find_busiest_group() helping MT/MC balancing
> > is pwr_now and pwr_move calculations..
> 
> What about the very messy code I had to put in so that 
> find_busiest_group() would return a group even if there were no queues 
> in the group with more than one task.  Similar for find_busiest_queue().

Thats messy for sure and that was introduced by you to fix an imabalance
issue for a simple DP system(with out breaking HT systems). I will post a fix
for that.

thanks,
suresh
