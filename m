Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWDKXqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWDKXqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWDKXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:46:35 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:60503 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751340AbWDKXqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:46:35 -0400
Message-ID: <443C3FD8.2060906@bigpond.net.au>
Date: Wed, 12 Apr 2006 09:46:32 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com>
In-Reply-To: <20060410181237.A26977@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 11 Apr 2006 23:46:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Mon, Apr 10, 2006 at 04:45:32PM +1000, Peter Williams wrote:
>> Problem:
>>
>> The current implementation of find_busiest_group() recognizes that 
>> approximately equal average loads per task for each group/queue are 
>> desirable (e.g. this condition will increase the probability that the 
>> top N highest priority tasks on an N CPU system will be on different 
>> CPUs) by being slightly more aggressive when *imbalance is small but the 
>> average load per task in "busiest" group is more than that in "this" 
>> group.  Unfortunately, the amount moved from "busiest" to "this" is too 
>> small to reduce the average load per task on "busiest" (at best there 
>> will be no change and at worst it will get bigger).
> 
> Peter, We don't need to reduce the average load per task on "busiest"
> always. By moving a "busiest_load_per_task", we will increase the 
> average load per task of lesser busy cpu (there by trying to achieve
> the equality with busiest...)

Well, first off, we don't always move busiest_load_per_task we move UP 
TO busiest_load_per_task so there is no way you can make definitive 
statements about what will happen to the value "this_load_per_task" as a 
result of setting *imbalance to busiest_load_per_task.  Load balancing 
is a probabilistic endeavour and we need to take steps that increase the 
probability that we get the desired result.

Without this patch there is no chance that busiest_load_per_task will 
get smaller and whether this_load_per_task will get bigger is 
indeterminate.  With this patch there IS a chance that 
busiest_load_per_task will decrease and an INCREASED chance that 
this_load_per_task will get bigger.  Ergo we have increased the 
probability that the (absolute) difference between this_load_per_task 
and busiest_load_per_task will decrease.  This is a desirable outcome.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
