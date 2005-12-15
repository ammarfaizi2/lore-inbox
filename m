Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVLOAOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVLOAOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVLOAOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:14:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:8901 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932621AbVLOAOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:14:32 -0500
Date: Wed, 14 Dec 2005 16:14:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 00/14] Zoned VM stats
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

The new statistics are then used to realize zone reclaim.

Patchset is against 2.6.15-rc5-mm2. The patches after zone reclaim are optional.

This is expanding and I hope its complete. But I have not tested it in UP and SMP yet.
There may be yet unforeseen consequences to the changes to various counters.


1 Add some consts for inlines in mm.h
2 Basic counter functionality
3 Convert nr_mapped
4 Convert nr_pagecache
5 Resurrect scan_control.may_swap
6 Zone Reclaim
7 Expanded node and zone statistics
8 Convert nr_slab
9 Convert nr_page_table
10 Convert nr_dirty
11 Convert nr_writeback
12 Convert nr_unstable
13 Remove get_page_state functions
14 Remove wbs

