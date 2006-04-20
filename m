Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWDTRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWDTRIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDTRHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:07:52 -0400
Received: from mga06.intel.com ([134.134.136.21]:23225 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751163AbWDTRHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:07:23 -0400
X-IronPort-AV: i="4.04,141,1144047600"; 
   d="scan'208"; a="25637793:sNHT160142213"
X-IronPort-AV: i="4.04,141,1144047600"; 
   d="scan'208"; a="25637785:sNHT475741546"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,141,1144047600"; 
   d="scan'208"; a="25653720:sNHT49594664"
Date: Thu, 20 Apr 2006 10:04:57 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly loaded for balancing
Message-ID: <20060420100457.B10267@unix-os.sc.intel.com>
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060419182444.A5081@unix-os.sc.intel.com> <444719F8.2050602@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444719F8.2050602@bigpond.net.au>; from pwil3058@bigpond.net.au on Thu, Apr 20, 2006 at 03:19:52PM +1000
X-OriginalArrivalTime: 20 Apr 2006 17:07:20.0925 (UTC) FILETIME=[E2CAB8D0:01C6649C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 03:19:52PM +1000, Peter Williams wrote:
> > 
> > This patch doesn't fix this issue for example:
> > 4-way simple MP system. P0 containing two high priority tasks, P1 containing
> > one high priority and two normal priority tasks, one high priotity task
> > each on P2, P3. Current load balance doesn't detect/fix the
> > imbalance by moving one of the normal priority task running on P1 to P2 or P3.
> 
> Is this always the case or just a possibility?  Please describe the hole 
> it slips through (and please do that every time you provide a scenario).

I thought a scenario is enough to show the hole :) Anyhow, I brought this 
issue before also..
http://www.ussg.iu.edu/hypermail/linux/kernel/0604.0/0517.html

Load balance on P2 or P3 will always show P0 as max load but it will not
be able to move any load from P0. As
imbalance will be always < busiest_load_per_task and
max_load - this_load will be < imbn(2) * busiest_load_per_task...
and pwr_move will be <= pwr_now...

Basically sched groups with highest priority tasks can mask the 
imbalance between the other sched groups with in the same domain. 

thanks,
suresh
