Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUBFXs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUBFXs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:48:57 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18823 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265580AbUBFXsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:48:09 -0500
Date: Fri, 06 Feb 2004 15:47:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <232690000.1076111266@flay>
In-Reply-To: <4024261E.5070702@cyberone.com.au>
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If CPU 8 has 2 tasks, and cpu 1 has 1 task, there's an imbalance of 1.
>> *If* that imbalance persists (and it probably won't, given tasks being
>> created, destroyed, and blocking for IO), we may want to rotate that 
>> to 1 vs 2, and then back to 2 vs 1, etc. in the interests of fairness,
>> even though it's slower throughput overall.
>> 
> 
> Yes, although as long as it's node local and happens a couple of
> times a second you should be pretty hard pressed noticing the
> difference.

Not sure how true that turns out to be in practice ... probably depends
heavily on both the workload (how heavily it's using the cache) and the
chip (larger caches have proportionately more to lose).

As we go forward in time, cache warmth gets increasingly important, as
CPUs accelerate speeds quicker than memory. Cache sizes also get larger.
I'd really like us to be conservative here - the unfairness thing is 
really hard to hit anyway - you need a static number of processes that
don't ever block on IO or anything.

M.

