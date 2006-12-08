Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424818AbWLHGxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424818AbWLHGxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424820AbWLHGxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:53:23 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:60386 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424818AbWLHGxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:53:23 -0500
Date: Fri, 8 Dec 2006 15:56:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andy <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC] [PATCH] virtual memmap on sparsemem v3 [0/4] introduction
Message-Id: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, virtual mem_map on sparsemem/generic patch version 3.

I myself likes this patch.
But someone may feels this patch is intrusive and scattered.
please pointing out.

Changes v2 -> v3
- make map/unmap function for general purpose. (for my purpose ;)
- drop memory hotplug support. will be posted after this goes in.
- change pfn_to_page()/page_to_pfn() defintions.
- add CONFIT_SPARSEMEM_VMEMMAP_STATIC config.
- several clean ups.
- drop optimized pfn_valid() patch will be posted later after this goes in.
- add #error to check vmem_map alignment.

Changes v1 -> v2:
- support memory hotplug case.
- uses static address for vmem_map (ia64)
- added optimized pfn_valid() for ia64  (experimental)

Intro:
When using SPARSEMEM, pfn_to_page()/page_to_pfn() accesses global big table
of mem_section. if SPARSEMEM_EXTREME, this is 2-level table lookup.

If we can map mem_section->mem_map in (virtually) linear address, we can expect
optimzed pfn <-> page translation.

Virtual mem_map is not useful for 32bit archs. This uses huge virtual
address range.

-Kame

