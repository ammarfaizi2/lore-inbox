Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261890AbSJEA33>; Fri, 4 Oct 2002 20:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSJEA33>; Fri, 4 Oct 2002 20:29:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41734 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261890AbSJEA32>; Fri, 4 Oct 2002 20:29:28 -0400
Date: Fri, 4 Oct 2002 17:36:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (NUMA)
In-Reply-To: <515070000.1033777302@flay>
Message-ID: <Pine.LNX.4.44.0210041730450.2993-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Martin J. Bligh wrote:
> 
> It would be nice to have it all working and in place by the time Hammer arrives 
> and makes this much more widespread ;-) 

I agree, the Hammer is going to be interesting. But one of the most
interesting things to do will be to see if using it as a per-CPU memory
NUMA machine is slower or faster than using it with the memory interleaved
across CPU's (in which case it won't look NUMA at all).

My personal guess (assuming hypertransport works well) is that you'd
actually en dup interleaving at least for dual setups, and quite possibly
for quads as well. The per-node non-interleaved setup probably makes for
best _aggregate_ memory throughput if you have a load that has very
NUMA-friendly behaviour, but interleaving should make for best sustained
throughput for not-very-balanced-loads.

> Just an order of magnitude figure for you ... number of seconds spent in kernel
> space across all CPUs during a kernel compile on a 16-way NUMA-Q ... 
> 
> 2.4 with every patch I had (including O(1) sched + NUMA mods) ... 120s. 
> On 2.5.40-mm1 with one small NUMA scheduler patch ... 38s. 

Yeah, looking good..

		Linus

