Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWAZXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWAZXgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWAZXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:36:39 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:2898 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030243AbWAZXgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:36:38 -0500
Message-ID: <43D95D04.8050802@bigpond.net.au>
Date: Fri, 27 Jan 2006 10:36:36 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Con Kolivas <kernel@kolivas.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: smp 'nice' bias support breaks scheduler behavior
References: <20060126025220.B8521@unix-os.sc.intel.com> <200601262325.05296.kernel@kolivas.org>
In-Reply-To: <200601262325.05296.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 26 Jan 2006 23:36:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thursday 26 January 2006 21:52, Siddha, Suresh B wrote:
> 
>>Con,
>>
>>
>>>[PATCH] sched: implement nice support across physical cpus on SMP
>>
>>I don't see imbalance calculations in find_busiest_group() take
>>prio_bias into account. This will result in wrong imbalance value and
>>will cause issues.
> 
> 
> 
> in 2.6.16-rc1:
> 
> find_busiest_group(....
> 
> 	load = __target_load(i, load_idx, idle);
> else
> 	load = __source_load(i, load_idx, idle);
> 
> where __target_load and __source_load is where we take into account prio_bias.
> 
> I'm not sure which code you're looking at, but Peter Williams is working on 
> rewriting the smp nice balancing code in -mm at the moment so that is quite 
> different from current linus tree.
> 

Yes, indeed.  And it would be very helpful if people interested in this 
topic (and that have test suites designed to test whether "niceness" is 
being well balanced across CPUs) could test it.  This is especially the 
case for larger systems as I do not have ready access for testing on them.

> 
> 
>>For example on a DP system with HT, if there are three runnable processes
>>(simple infinite loop with same nice value), this patch is resulting in
>>bouncing of these 3 processes from one processor to another...Lets assume
>>if the 3 processes are scheduled as 2 in package-0 and 1 in package1..
>>Now when the busy processor on package-1 does load balance and as
>>imbalance doesn't take "prio_bias" into account, this will kick active
>>load balance on package-0.. And this is continuing for ever, resulting
>>in bouncing from one processor to another.
>>
>>Even when the system is completely loaded and if there is an imbalance,
>>this patch causes wrong imabalance counts and cause unoptimized
>>movements.
>>
>>Do you want to look into this and post a patch for 2.6.16?

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
