Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVLJAy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVLJAy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVLJAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:54:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5007 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932541AbVLJAy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:54:58 -0500
Date: Fri, 9 Dec 2005 16:54:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 0/6] Zoned VM stats
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zone based VM statistics are necessary to be able to determine what the state
of memory in one zone is. In a NUMA system this can be helpful to do local
reclaim and other memory optimizations by shifting VM load to optimize
page allocation. It is also helpful to know how the computing load affects
the memory allocations on various zones.

The patchset introduces a framework for counters that is a cross between the
existing page_stats --which are simply global counters split per cpu-- and the
approach of deferred incremental updates implemented for nr_pagecache.

Small per cpu 8 bit counters are introduced in struct zone. If counting
exceeds certain threshold then the counters are accumulated in an array in
the zone of the page and in a global array. This means that access to
VM counter information for a zone and for the whole machine is possible
by simply indexing an array. [Thanks to Nick Piggin for pointing me
at that approach].

The patchset currently consists of 6 pieces.

1. Framwork

Implements counter functionality but does not define any. Contains atomic_long_t hack.

2. nr_mapped

Make nr_mapped a zone based counter.

3. nr_pagecache

Make nr_pagecache a zone based counter.

4. Extend /proc output

Output the complete information contained in the global and zone statistics
array to /proc files.

5. nr_slab

Convert nr_slab a zone to NR_SLAB.

6. nr_page_table_pages

Convert nr_page_table_pages to NR_PAGETABLE

