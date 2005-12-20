Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVLTWCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLTWCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVLTWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:02:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32900 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932156AbVLTWCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:06 -0500
Date: Tue, 20 Dec 2005 14:01:51 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 0/14]: Overview
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

The remaining counters in page_state are just for showing some statistics
via proc. Another patchset "VM event counters" will convert the remaining
counters to lightweight inline counters and allows switching off nonessential
counters for embedded systems.

This patchset is against 2.6.15-rc5-mm3. Only the first 4 patches are needed
to support zone reclaim.

1 Add some consts for inlines in mm.h
2 Basic zoned counter functionality
3 Make /proc/vmstat include zoned counters
4 Convert nr_mapped
5 Convert nr_pagecache
6 Expanded node and zone statistics
7 Convert nr_slab
8 Convert nr_page_table
9 Convert nr_dirty
10 Convert nr_writeback
11 Convert nr_unstable
12 Convert nr_bounce
13 Remove get_page_state functions
14 Remove wbs

