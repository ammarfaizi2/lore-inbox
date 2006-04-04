Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWDDCLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWDDCLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWDDCLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:11:49 -0400
Received: from mga06.intel.com ([134.134.136.21]:61117 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751809AbWDDCLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:11:48 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,160,1141632000"; 
   d="scan'208"; a="18895540:sNHT17259949"
Date: Mon, 3 Apr 2006 19:11:22 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
Message-ID: <20060403191122.B31895@unix-os.sc.intel.com>
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060403172408.A31895@unix-os.sc.intel.com> <4431CA4F.3020304@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4431CA4F.3020304@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Apr 04, 2006 at 11:22:23AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 11:22:23AM +1000, Peter Williams wrote:
> OK.  I think this means some fiddling with avg_load may be necessary in 
> some cases but this will be complex.  I'm not really happy about making 
> this code more complex until some of the current unnecessary complexity 
> is removed.  I.e. until a proper solution to the problem of triggering 
> active_load_balance() is implemented.

Here is Nicks view about active_load_balance()

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3950745131e23472fb5ace2ee4a2093e7590ec69

> > 
> > c) DP system: if the cpu-0 has two high priority and cpu-1 has one normal
> > priority task, how can the current code detect this imbalance..
> 
> How would it not?

imbalance will be always < busiest_load_per_task and
max_load - this_load will be < 2 * busiest_load_per_task...
and pwr_move will be <= pwr_now...

> > d) 4-way MP system: if the cpu-0 has two high priority tasks, cpu-1 has
> > one high priority and four normal priority and cpu-2,3 each has one
> > high priority task.. how does the current code distribute the normal
> > priority tasks among cpu-1,2,3... (in this case, max_load will always
> > point to cpu-0 and will never distribute the noraml priority tasks...)
> 
> This should cause cpu-0 to lose one of its tasks creating a new state 

how? in this case also...

imbalance will be always < busiest_load_per_task and
max_load - this_load will be < 2 * busiest_load_per_task...
and pwr_move will be <= pwr_now...


> Without smpnice, can you show how the default load balancing would 
> result in the "nice" values being reliably enforced in your examples.

I agree with the issue that we are trying to fix here.. but I feel
it is incomplete.. With the current code in mainline, anyone can say the 
behavior by going through the code.... with smpnice code, code is complex
and really doesn't achieve what that patch really wants to fix..

> The good news is that, in real life, high priority tasks generally only 
> use very short bursts of CPU. :-)

do we then really need smpnice complexity?

thanks,
suresh
