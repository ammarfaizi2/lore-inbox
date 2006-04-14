Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWDNBRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWDNBRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWDNBRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:17:20 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:58976 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965089AbWDNBRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:17:19 -0400
Message-ID: <443EF81C.9020800@bigpond.net.au>
Date: Fri, 14 Apr 2006 11:17:16 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice: issues with finding busiest queue
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au> <20060411185709.A2401@unix-os.sc.intel.com> <443C8AEC.9010309@bigpond.net.au> <443D95DF.2090807@bigpond.net.au> <20060413173104.B15723@unix-os.sc.intel.com>
In-Reply-To: <20060413173104.B15723@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 14 Apr 2006 01:17:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Apr 13, 2006 at 10:05:51AM +1000, Peter Williams wrote:
>> There be dragons here :-(.
>>
> 
> At more places in this part of the world (smpnice) :)
> 
> We need to relook at find_busiest_queue()... With the current weighted
> calculations, it doesn't always make sense to look at the highest weighted
> runqueue in the busy group..
> 
> for example on a DP with HT system, how does the load balance behave with
> Package-0 containing one high priority and one low priority, Package-1
> containing one low priority(with other thread being idle)..
> 
> Package-1 thinks that it need to take the low priority thread from Package-0.
> And find_busiest_queue() returns the cpu thread with highest priority task..
> And ultimately(with help of active load balance) we move high priority
> task to Package-1. And same continues with Package-0 now, moving high priority
> task from package-1 to package-0..
> 
> Even without the presence of active load balance, load balance will fail
> to balance(having two low priority tasks on one package, and high
> priority task on another package) the above scenario....
> 
> We probably need to use imbalance(and more factors) to determine the busiest 
> queue in the group.....

A patch would be nice.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
