Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVHKGlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVHKGlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVHKGlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:41:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37630 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932239AbVHKGlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:41:18 -0400
Date: Thu, 11 Aug 2005 12:11:05 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
Message-ID: <20050811064105.GC3937@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 04:54:44AM +0000, Zwane Mwaikambo wrote:
> for_each_cpu walks through all processors in cpu_possible_map, which is 
> defined as cpu_callout_map on i386 and isn't initialised until all 
> processors have been booted. This breaks things which do for_each_cpu 
> iterations early during boot. So, define cpu_possible_map as a bitmap with 
> NR_CPUS bits populated. This was triggered by a patch i'm working on which 
> does alloc_percpu before bringing up secondary processors.
> 

Zwane,

I don't know the context of your work here, but a couple of 
observations.

Since you populate cpu_possible_map with NR_CPUS, alloc_percpu()
would end up allocating for all NR_CPUS.  Wouldn't you have achieved
the same thing by compile time allocation ? Wouldn't this change
lead to NR_CPUS allocations from alloc_percpu() for all users ?

Now since you have separated cpu_possible_map from cpu_callout_map,
do we need to reflect cpu_possible_map with the value from
cpu_callout_map after the cpu_callout_map is initialized fully from
smp_prepare_cpus().

BTW, I am working on Kiran's dynamic percpu allocator patch and making
it cpu hotplug aware. With that, alloc_percpu would initially allocate
only for the possible cpus and would allocate for other cpus as and when
they come up.

Regards,
Bharata.
