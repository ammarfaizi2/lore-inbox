Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWDQX4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDQX4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWDQX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:56:17 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:4571 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932072AbWDQX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:56:16 -0400
Message-ID: <44442B1E.10308@bigpond.net.au>
Date: Tue, 18 Apr 2006 09:56:14 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing
 outcomes
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au> <20060414112750.A21908@unix-os.sc.intel.com> <44404455.8090304@bigpond.net.au> <20060417095920.A19931@unix-os.sc.intel.com>
In-Reply-To: <20060417095920.A19931@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 17 Apr 2006 23:56:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 15, 2006 at 10:54:45AM +1000, Peter Williams wrote:
>> If you have a better suggestion for how move_tasks() does its job, how 
>> about providing a patch and with supporting arguments as to why its 
>> better.  If it is better then we can use it.
> 
> I think we can have a second pass(if the first pass fails to move any),
> in which we will not skip those tasks which will become highest priority
> on the target runqueue...

That won't solve the problem that this patch is intended to address.  As 
a reminder the problem is that a low priority task is being moved when 
we would prefer a high priority task to be moved.  I.e. we want to move 
the high priority task because it's the best one to move not because we 
couldn't move any tasks.

NB (ignoring races and can_migrate_task() vetoing a task being moved) 
there should always be a task that can be moved as the minimum value of 
imbalance is the average load per task of the source queue and there 
must be tasks whose load weight is less than or equal to the average 
(it's axiomatic).

To put that another way, only a change in the state of the source queue 
since imbalance was determined (possible because that's all done without 
locks) or can_migrate_task() will stop at least one task being moved.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
