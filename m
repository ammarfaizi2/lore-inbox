Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWAKFOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWAKFOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAKFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:14:08 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:10662 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751374AbWAKFOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:14:07 -0500
Message-ID: <43C4941D.6080302@bigpond.net.au>
Date: Wed, 11 Jan 2006 16:14:05 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601111249.05881.kernel@kolivas.org> <43C46F99.1000902@bigpond.net.au> <200601111407.05738.kernel@kolivas.org> <43C47E32.4020001@bigpond.net.au>
In-Reply-To: <43C47E32.4020001@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 11 Jan 2006 05:14:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> On Wed, 11 Jan 2006 01:38 pm, Peter Williams wrote:
>>
>>> Con Kolivas wrote:
>>> > I guess we need to check whether reversing this patch helps.
>>>
>>> It would be interesting to see if it does.
>>>
>>> If it does we probably have to wear the cost (and try to reduce it) as
>>> without this change smp nice support is fairly ineffective due to the
>>> fact that it moves exactly the same tasks as would be moved without it.
>>>  At the most it changes the frequency at which load balancing occurs.
>>
>>
>>
>> I disagree. I think the current implementation changes the balancing 
>> according to nice much more effectively than previously where by their 
>> very nature, low priority tasks were balanced more frequently and 
>> ended up getting their own cpu.
> 
> 
> I can't follow the logic here and I certainly don't see much difference 
> in practice.

I think I've figured out why I'm not seeing much difference in practice. 
  I'm only testing on 2 CPU systems and it seems to me that the main 
difference that the SMP nice patch will have is in selecting which CPU 
to steal tasks from (grabbing the one with the highest priority tasks) 
and this is a non issue on a 2 CPU system.  :-(

So I should revise my statement to say that it doesn't make much 
difference if there's only 2 CPUs.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
