Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWHRHPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWHRHPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHRHPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:15:35 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51586 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750810AbWHRHPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:15:34 -0400
Date: Fri, 18 Aug 2006 16:17:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
Message-Id: <20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
	<20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
	<20060816094358.e7006276.ak@muc.de>
	<Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
	<44E3FC4F.2090506@colorfullife.com>
	<Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 23:17:54 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:
>
> So we only have a single lookup of vmem_map from memory in order to 
> calculate the address of struct page. The cacheline for vmem_map is 
> heavily used and certainly in memory. virt_to_page seems to be a very 
> efficient means to get to struct page. The problem scope may simply be
> to minimize the cachelines touched during free and alloc.

Just a note: with SPARSEMEM, we need more calculation and access to
mem_section[] table and page structs(mem_map).

> vmalloc_to_addr is certainly slower due to the page table walking. But the 
> user already is aware of the fact that vmalloc memory is not as fast as
> direct mapped.
Hmm.

I wonder....
==
vmalloc() area is backed-up by VHPT(16Kb page size). And direct-mapped-area
is backed-up by software-tlb-miss-handler (16MB/64MB page size)

If TLB misses frequently, prefetch will work well in virtually-mapped area
(region5) rather direct-mapped-area (region 7) because of hardware assist
of 'VHPT walker'. (just I think. I have no data)

Considering some code walking through a list of objects scattered over all memory,
Is virtually-mapped area really slow ?

-Kame

