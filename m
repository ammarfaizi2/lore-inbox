Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUBGALM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUBGALL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:11:11 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:59044 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266472AbUBGALF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:11:05 -0500
Message-ID: <40242D14.6070908@cyberone.com.au>
Date: Sat, 07 Feb 2004 11:11:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay>
In-Reply-To: <232690000.1076111266@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>If CPU 8 has 2 tasks, and cpu 1 has 1 task, there's an imbalance of 1.
>>>*If* that imbalance persists (and it probably won't, given tasks being
>>>created, destroyed, and blocking for IO), we may want to rotate that 
>>>to 1 vs 2, and then back to 2 vs 1, etc. in the interests of fairness,
>>>even though it's slower throughput overall.
>>>
>>>
>>Yes, although as long as it's node local and happens a couple of
>>times a second you should be pretty hard pressed noticing the
>>difference.
>>
>
>Not sure how true that turns out to be in practice ... probably depends
>heavily on both the workload (how heavily it's using the cache) and the
>chip (larger caches have proportionately more to lose).
>
>As we go forward in time, cache warmth gets increasingly important, as
>CPUs accelerate speeds quicker than memory. Cache sizes also get larger.
>I'd really like us to be conservative here - the unfairness thing is 
>really hard to hit anyway - you need a static number of processes that
>don't ever block on IO or anything.
>
>

Can we keep current behaviour default, and if arches want to
override it they can? And if someone one day does testing to
show it really isn't a good idea, then we can change the default.

I like to try stick to the fairness first approach.

We got quite a few complaints about unfairness when the
scheduler used to keep 2 on one cpu and 1 on another, even in
development kernels. I suspect that most wouldn't have known
one way or the other if only top showed 66% each, but still.

