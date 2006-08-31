Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWHaKIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHaKIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHaKIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:31 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:60363 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750766AbWHaKIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:30 -0400
Message-ID: <44F6B512.60305@bigpond.net.au>
Date: Thu, 31 Aug 2006 20:08:18 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Martin Ohlin <martin.ohlin@control.lth.se>, linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com> <44F6365A.8010201@bigpond.net.au> <44F67EE2.5060605@in.ibm.com>
In-Reply-To: <44F67EE2.5060605@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 31 Aug 2006 10:08:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Peter Williams wrote:
> 
>>> I do not understand controlling the nice value? Most cpu control the
>>> bandwidth/time - are there any advantages to controlling the nice
>>> value?
>>
>> Trying to control CPU allocations purely using time allocations will 
>> only work well for CPU bound processes.  Furthermore, the faster CPUs 
>> become the more this will be the case.
> 
> The resource we are controlling is CPU bandwidth,

Unfortunately, most tasks' bursts of CPU are much shorter than the sizes 
of the time slices you're allocating (and the faster CPUs get the more 
this will be the case) so they don't have much effect.

> what other parameters 
> can we
> use to control it?

Dynamic priority.

>. Nice values indirectly control the time a task gets, 
> but
> also affects its priority. Even if a task is not CPU bound, we are only
> interested in its CPU bandwidth utilization in the CPU resource controller.
> 
>>
>>> How does this interplay with dynamic priorities that the
>>> scheduler currently maintains?
>>
>> But your implication here is valid.  It is better to fiddle with the 
>> dynamic priorities than with nice as this leaves nice for its primary 
>> purpose of enabling the sysadmin to effect the allocation of CPU 
>> resources based on external considerations.  Having said that I would 
>> also opine that the basic mechanism this author uses to fiddle the 
>> nice values could be applied to the dynamic priorities instead with 
>> the key difference being that nice can be fiddled from outside the 
>> scheduler but you really need to be inside the scheduler to fiddle 
>> with dynamic priorities.
>>
> 
> The problem with controlling nice values that I see is that nice values 
> do not
> necessarily linearly map CPU time. Changing the nice value also changes the
> priority, which impacts the order in which tasks are run.
> 
> It's my belief that time and priorities are orthogonal. Nice does a good 
> job
> of trying to mix the two,  but in the case of resource management it 
> might not
> be such a good idea.

Think "dynamic priorities".

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
