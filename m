Return-Path: <linux-kernel-owner+w=401wt.eu-S1762406AbWLJTrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762406AbWLJTrf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762408AbWLJTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:47:35 -0500
Received: from mailhub.hp.com ([192.151.27.10]:45224 "EHLO mailhub.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762381AbWLJTre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:47:34 -0500
From: "Bob Picco" <bob.picco@hp.com>
Date: Sun, 10 Dec 2006 14:47:30 -0500
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Andy <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [0/4] introduction
Message-ID: <20061210194730.GA10629@localhost>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki KAMEZAWA wrote:	[Fri Dec 08 2006, 01:56:08AM EST]
Hi Kame,
> Hi, virtual mem_map on sparsemem/generic patch version 3.
> 
> I myself likes this patch.
> But someone may feels this patch is intrusive and scattered.
> please pointing out.
> 
> Changes v2 -> v3
> - make map/unmap function for general purpose. (for my purpose ;)
> - drop memory hotplug support. will be posted after this goes in.
> - change pfn_to_page()/page_to_pfn() defintions.
> - add CONFIT_SPARSEMEM_VMEMMAP_STATIC config.
> - several clean ups.
> - drop optimized pfn_valid() patch will be posted later after this goes in.
> - add #error to check vmem_map alignment.
> 
> Changes v1 -> v2:
> - support memory hotplug case.
> - uses static address for vmem_map (ia64)
> - added optimized pfn_valid() for ia64  (experimental)
> 
> Intro:
> When using SPARSEMEM, pfn_to_page()/page_to_pfn() accesses global big table
> of mem_section. if SPARSEMEM_EXTREME, this is 2-level table lookup.
Did you gather any performance numbers comparing
VIRTUAL_MEM_MAP+SPARSEMEM to SPARSEMEM+EXTREME? I did some quick but
inconclusive (small machine) ones when you first posted. There was
perhaps a slight degradation in VIRTUAL_MEM_MAP+SPARSEMEM.

bob
> 
> If we can map mem_section->mem_map in (virtually) linear address, we can expect
> optimzed pfn <-> page translation.
> 
> Virtual mem_map is not useful for 32bit archs. This uses huge virtual
> address range.
> 
> -Kame
