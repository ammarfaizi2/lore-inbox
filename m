Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCYA4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCYA4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCYA4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:56:32 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:7157 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750759AbWCYA4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:56:32 -0500
Message-ID: <4424953B.9030000@bigpond.net.au>
Date: Sat, 25 Mar 2006 11:56:27 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: more smpnice patch issues
References: <20060322155122.2745649f.akpm@osdl.org> <4421F702.5040609@bigpond.net.au> <20060324154558.A20018@unix-os.sc.intel.com>
In-Reply-To: <20060324154558.A20018@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 25 Mar 2006 00:56:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> more issues with smpnice patch...
> 
> a) consider a 4-way system (simple SMP system with no HT and cores) scenario
> where a high priority task (nice -20) is running on P0 and two normal
> priority tasks running on P1. load balance with smp nice code
> will never be able to detect an imbalance and hence will never move one of 
> the normal priority tasks on P1 to idle cpus P2 or P3.

Why?

> 
> b) smpnice seems to break this patch..
> 
> [PATCH] sched: allow the load to grow upto its cpu_power
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0c117f1b4d14380baeed9c883f765ee023da8761
> 
> example scenario for this case: consider a numa system with two nodes, each
> node containing four processors. if there are two processes in node-0 and with
> node-1 being completely idle, your patch will move one of those processes to
> node-1 whereas the previous behavior will retain those two processes in node-0..
> (in this case, in your code max_load will be less than busiest_load_per_task)
> 
> smpnice patch has complicated the load balance code... Very difficult
> to comprehend the side effects of this patch in the presence of different 
> priority tasks...

That is NOT true.  Without smpnice whether the "right thing" happens 
with non zero nice tasks is largely down to luck.  With smpnice the 
result is far more predictable.

The PURPOSE of smpnice IS to alter load balancing in the face of the use 
of non zero nice tasks.  The reason for doing this is so that nice 
reliably effects the allocation of CPU resources on SMP machines. I.e. 
changes in load balancing behaviour as a result of tasks having nice 
values other than zero is the desired result and NOT a side effect.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
