Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUBFXl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUBFXl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:41:29 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:13270 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265510AbUBFXl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:41:27 -0500
Message-ID: <4024261E.5070702@cyberone.com.au>
Date: Sat, 07 Feb 2004 10:41:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay>
In-Reply-To: <231480000.1076110387@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>From a later email ....
>>
>>Hopefully just tending to round down more would damp it better.
>>*imbalance = (*imbalance + SCHED_LOAD_SCALE/2) >> SCHED_LOAD_SHIFT;
>>Or even remove the addition all together.
>>
>
>I'd side with just removing the addition alltogether ...
>
>

By that stage though, it has already passed through the
imbalance_pct filter, and with the higher precision and
averaging of previous loads, it might take a while to
get there.

>>>Moreover, as Rick pointed out, it's particularly futile over idle cpus ;-)
>>>
>>I don't follow...
>>
>
>If CPU 7 has 1 task, and cpu 8 has 0 tasks, there's an imbalance of 1.
>There is no point whatsoever in bouncing that task back and forth
>between cpu 7 and 8 - it just makes things slower, and trashes the cache.
>There's *no* fairness issue here.
>
>

Right, it should not be moved. I think Anton is seeing a problem
with active balancing, and not so much a problem with the imbalance
calculation though.

>If CPU 8 has 2 tasks, and cpu 1 has 1 task, there's an imbalance of 1.
>*If* that imbalance persists (and it probably won't, given tasks being
>created, destroyed, and blocking for IO), we may want to rotate that 
>to 1 vs 2, and then back to 2 vs 1, etc. in the interests of fairness,
>even though it's slower throughput overall.
>

Yes, although as long as it's node local and happens a couple of
times a second you should be pretty hard pressed noticing the
difference.

