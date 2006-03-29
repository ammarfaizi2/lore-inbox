Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWC2Wwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWC2Wwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWC2Wwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:52:50 -0500
Received: from mga06.intel.com ([134.134.136.21]:3115 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751147AbWC2Wws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:52:48 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,144,1141632000"; 
   d="scan'208"; a="16816044:sNHT39798556"
Date: Wed, 29 Mar 2006 14:52:42 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
Message-ID: <20060329145242.A11376@unix-os.sc.intel.com>
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <442A0235.1060305@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Mar 29, 2006 at 02:42:45PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 02:42:45PM +1100, Peter Williams wrote:
> I meant that it doesn't explicitly address your problem.  What it does 
> is ASSUME that failure of load balancing to move tasks is because there 
> was exactly one task on the source run queue and that this makes it a 
> suitable candidate to have that single task moved elsewhere in the blind 
> hope that it may fix an HT/MC imbalance that may or may not exist.  In 
> my mind this is very close to random.  

That so called assumption happens only when load balancing has
failed for more than the domain specific cache_nice_tries. Only reason
why it can fail so many times is because of all pinned tasks or only a single
task is running on that particular CPU. load balancing code takes care of both
these scenarios..

sched groups cpu_power controls the mechanism of implementing HT/MC
optimizations in addition to active balance code... There is no randomness
in this.


> Also back to front and inefficient.

HT/MC imbalance is detected in a normal way.. A lightly loaded group
finds an imbalance and tries to pull some load from a busy group (which
is inline with normal load balance)... pull fails because the only task
on that cpu is busy running and needs to go off the cpu (which is triggered
by active load balance)... Scheduler load balance is generally done by a 
pull mechansim and here (HT/MC) it is still a pull mechanism(triggering a 
final push only because of the single running task) 

If you have any better generic and simple method, please let us know.

thanks,
suresh
