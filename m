Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932783AbWAKDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWAKDki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWAKDki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:40:38 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:50019 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932783AbWAKDkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:40:37 -0500
Message-ID: <43C47E32.4020001@bigpond.net.au>
Date: Wed, 11 Jan 2006 14:40:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601111249.05881.kernel@kolivas.org> <43C46F99.1000902@bigpond.net.au> <200601111407.05738.kernel@kolivas.org>
In-Reply-To: <200601111407.05738.kernel@kolivas.org>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 11 Jan 2006 03:40:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 11 Jan 2006 01:38 pm, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>> > I guess we need to check whether reversing this patch helps.
>>
>>It would be interesting to see if it does.
>>
>>If it does we probably have to wear the cost (and try to reduce it) as
>>without this change smp nice support is fairly ineffective due to the
>>fact that it moves exactly the same tasks as would be moved without it.
>>  At the most it changes the frequency at which load balancing occurs.
> 
> 
> I disagree. I think the current implementation changes the balancing according 
> to nice much more effectively than previously where by their very nature, low 
> priority tasks were balanced more frequently and ended up getting their own 
> cpu.

I can't follow the logic here and I certainly don't see much difference 
in practice.

> No it does not provide firm 'nice' handling that we can achieve on UP 
> configurations but it is also free in throughput terms and miles better than 
> without it. I would like to see your more robust (and nicer code) solution 
> incorporated but I also want to see it cost us as little as possible. We 
> haven't confirmed anything just yet...

Yes, that's true.  I must admit that I wouldn't have expected the 
increased overhead to be very big.  In general, the "system" CPU time in 
a kernbench is only about 1% of the total CPU time and the extra 
overhead should be just a fraction of that.

It's possible that better distribution of niceness across CPU leads to 
more preemption within a run queue (i.e. if there all the same priority 
they won't preempt each other much) leading to more context switches. 
But you wouldn't expect that to show up in kernbench as the tasks are 
all the same niceness and usually end up with the same dynamic priority.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
