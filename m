Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWDLB6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWDLB6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDLB6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 21:58:41 -0400
Received: from mga06.intel.com ([134.134.136.21]:34884 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751301AbWDLB6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 21:58:40 -0400
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="22174865:sNHT16741585"
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="22174859:sNHT17005527"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="22174858:sNHT17766077"
Date: Tue, 11 Apr 2006 18:57:09 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
Message-ID: <20060411185709.A2401@unix-os.sc.intel.com>
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443C3FD8.2060906@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Apr 12, 2006 at 09:46:32AM +1000
X-OriginalArrivalTime: 12 Apr 2006 01:58:31.0974 (UTC) FILETIME=[99B31C60:01C65DD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 09:46:32AM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > On Mon, Apr 10, 2006 at 04:45:32PM +1000, Peter Williams wrote:
> >> Problem:
> >>
> >> The current implementation of find_busiest_group() recognizes that 
> >> approximately equal average loads per task for each group/queue are 
> >> desirable (e.g. this condition will increase the probability that the 
> >> top N highest priority tasks on an N CPU system will be on different 
> >> CPUs) by being slightly more aggressive when *imbalance is small but the 
> >> average load per task in "busiest" group is more than that in "this" 
> >> group.  Unfortunately, the amount moved from "busiest" to "this" is too 
> >> small to reduce the average load per task on "busiest" (at best there 
> >> will be no change and at worst it will get bigger).
> > 
> > Peter, We don't need to reduce the average load per task on "busiest"
> > always. By moving a "busiest_load_per_task", we will increase the 
> > average load per task of lesser busy cpu (there by trying to achieve
> > the equality with busiest...)
> 
> Well, first off, we don't always move busiest_load_per_task we move UP 
> TO busiest_load_per_task so there is no way you can make definitive 
> statements about what will happen to the value "this_load_per_task" as a 
> result of setting *imbalance to busiest_load_per_task.  Load balancing 
> is a probabilistic endeavour and we need to take steps that increase the 
> probability that we get the desired result.

I agree with you. But the previous code was more conservative and may slowly
(just from theory pt of view... I don't have an example to show this..)
balance towards the desired state. With this code, I feel we are
aggressive. for example, on a DP system: if I run one high priority
and two low priority processes, they keep hopping from one processor
to another... you may argue it is because of the "top" or some other
process... I agree that it is the case.. But same thing doesn't happen
with the previous version.. I like the conservative approach...

> Without this patch there is no chance that busiest_load_per_task will 
> get smaller 

Is there an example for this?

> and whether this_load_per_task will get bigger is 
> indeterminate.  With this patch there IS a chance that 
> busiest_load_per_task will decrease and an INCREASED chance that 
> this_load_per_task will get bigger.  Ergo we have increased the 
> probability that the (absolute) difference between this_load_per_task 
> and busiest_load_per_task will decrease.  This is a desirable outcome.

All I am saying is we are more aggressive.. I don't have any issue with
the desired outcome..

thanks,
suresh
