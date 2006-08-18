Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWHRTOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWHRTOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHRTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:14:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45798 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932416AbWHRTOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:14:40 -0400
Date: Sat, 19 Aug 2006 04:13:28 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
Message-Id: <20060819041328.225b0170.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608181138190.32621@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
	<20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
	<20060816094358.e7006276.ak@muc.de>
	<Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
	<44E3FC4F.2090506@colorfullife.com>
	<Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
	<20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
	<20060819031916.85d5979e.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608181138190.32621@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 11:44:22 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:
> > and usual SPARSEMEM, (not EXTREME)
> > --
> > page = mem_section[(pfn >> SECTION_SHIFT)].mem_map + pfn
> > --
> > need one table look up. maybe not very big.
> 
> Bigger than a cacheline that can be kept in the cache? 

powerpc's section size is 16Mbytes. so table itself is bigger than cacheline.
And powerpc doesn't have DISCONTIG configuration.

> > with SPARSEMEM_EXTREME
> > --
> > page = mem_section[(pfn >> SECTION_SHIFT)][(pfn & MASK)].mem_map + pfn
> > --
> > need one (big)table look up.
> 
> Owww... Cache issues.
> 
> Could we do the lookup using a sparse virtually mapped table like on 
> IA64. Then align section shift to whatever page table is in place (on 
> platforms that require page tables and IA64 could continue to use its 
> special handler)?
> 
> Then page could be reached via
> 
> page = vmem_map + pfn
> 
> again ?
> 

In early days of implementing SPARSEMEM,  I tried vmem_map + SPARSEMEM.
But it was very complicated.....so it was dropped.
Before retrying, I think performance/profile test with each memory model should
be done.

Considering ia64, an advantage of SPARSEMEM is (just?) memory hotplug.
If people need extreme performance, they can select DISCONTIGMEM.

But powerpc(NUMA) people has only SPARSEMEM. So test on powerpc will be 
necessary, anyway.(of course, they doesn't have vmem_map)

-Kame





