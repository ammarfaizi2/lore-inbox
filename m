Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVHKV1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVHKV1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVHKV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:27:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:62091 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750982AbVHKV1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:27:46 -0400
Date: Thu, 11 Aug 2005 15:33:30 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Bharata B Rao <bharata@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
In-Reply-To: <20050811064105.GC3937@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0508111529270.19138@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
 <20050811064105.GC3937@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bharata,

On Thu, 11 Aug 2005, Bharata B Rao wrote:

> I don't know the context of your work here, but a couple of 
> observations.
> 
> Since you populate cpu_possible_map with NR_CPUS, alloc_percpu()
> would end up allocating for all NR_CPUS.  Wouldn't you have achieved
> the same thing by compile time allocation ? Wouldn't this change
> lead to NR_CPUS allocations from alloc_percpu() for all users ?

The patch has been modified (courtesy Andi Kleen) to do something a bit 
smarter and only allocate for detected cpus in MADT or MP table. But my 
prime concern was that for_each_cpu didn't work at all during boot.

> Now since you have separated cpu_possible_map from cpu_callout_map,
> do we need to reflect cpu_possible_map with the value from
> cpu_callout_map after the cpu_callout_map is initialized fully from
> smp_prepare_cpus().

This should be taken care of using above.

> BTW, I am working on Kiran's dynamic percpu allocator patch and making
> it cpu hotplug aware. With that, alloc_percpu would initially allocate
> only for the possible cpus and would allocate for other cpus as and when
> they come up.

Great, that takes care of my concerns regarding processors which aren't 
enumerated during smp boot.

Thanks for the feedback,
	Zwane

