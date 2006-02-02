Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423051AbWBBBmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423051AbWBBBmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423048AbWBBBmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:42:09 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:56725 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1423051AbWBBBmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:42:07 -0500
Message-ID: <43E1636D.1000304@bigpond.net.au>
Date: Thu, 02 Feb 2006 12:42:05 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain> <20060201130818.GA26481@elte.hu> <20060201131111.GA27793@elte.hu>
In-Reply-To: <20060201131111.GA27793@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 2 Feb 2006 01:42:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>i think the right approach would be to split up this work into smaller 
>>chunks. Or rather, lets first see how this can happen: why is 
>>can_migrate() false for so many tasks? Are they all cpu-hot? If yes, 
>>shouldnt we simply skip only up to a limit of tasks in this case - 
>>it's not like we want to spend 1.5 msecs searching for a cache-cold 
>>task which might give us a 50 usecs advantage over cache-hot tasks ...
> 
> 
> the only legimate case where we have to skip alot of tasks is the case 
> when there are alot of CPU-bound (->cpus_alowed) tasks in the runqueue.  
> In that case the scheduler really has to skip that task. But that is not 
> an issue in your workload.

The new SMP nice load balancing may cause some tasks to be skipped while 
it's looking for ones with small enough bias_prios but I doubt that this 
would cause many to be skipped on a real system.

BTW why do you assume that this problem is caused by can_migrate() 
failing and is not just simply due to large numbers of tasks needing to 
be moved (which is highly likely to be true when hackbench is running)?

If it is a "skip" problem that would make the "busting it up into 
smaller chunks" solution more complex as it would make it desirable to 
remember where you were up to between chunks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
