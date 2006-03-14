Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWCNWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWCNWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCNWJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:09:57 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:19144 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964790AbWCNWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:09:57 -0500
Message-ID: <44173F32.9020302@bigpond.net.au>
Date: Wed, 15 Mar 2006 09:09:54 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
References: <200603131906.11739.kernel@kolivas.org> <4415F49C.8020208@bigpond.net.au> <cone.1142290371.837084.5853.501@kolivas.org>
In-Reply-To: <cone.1142290371.837084.5853.501@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 14 Mar 2006 22:09:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Peter Williams writes:
> 
>> Con Kolivas wrote:
>>
>>> +unsigned long weighted_cpuload(const int cpu)
>>> +{
>>> +    return (cpu_rq(cpu)->raw_weighted_load);
>>> +}
>>> +
>>
>>
>> Wouldn't this be a candidate for inlining?
> 
> 
> That would make it unsuitable for exporting via sched.h.

If above_background_load() were implemented inside sched.c instead of in 
sched.h there would be no need to export weighted_cpuload() would there? 
  This would allow weighted_cpuload() to be inline and the efficiency 
would be better as above_background_load() doesn't gain a lot by being 
inline as having weighted_cpulpad() non inline means that it's doing a 
function call several times in a loop i.e. it may save one function call 
by being inline but requires (up to) one function call for every CPU.

The other way around the cost would be just one function call.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
