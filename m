Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTK1EQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 23:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTK1EQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 23:16:05 -0500
Received: from holomorphy.com ([199.26.172.102]:32706 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261953AbTK1EQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 23:16:02 -0500
Date: Thu, 27 Nov 2003 20:15:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031128041558.GW19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a forward port of Hugh Dickins' patch to implement ABI-
preserving large software PAGE_SIZE support, effectively "large VM
blocksize". It's also been called "subpages". "pgcl" is an abbreviation
for "page clustering", after the historical but different BSD notion.

This is meant to make memory management more efficient by reducing the
number of objects to manage, as well as establishing more physical
contiguity of memory by keeping it pieces larger than what individual
ptes map. This very noticeably reduces the space requirements for
mem_map[]. I hope to eventually demonstrate further advantages like
larger fs blocksize support and reduced sglist length requirements.

This release features a rewrite of all the fault handling logic, done
to incorporate a forward port of hugh's original fault handlers. This
should perform much better than prior releases as they efficiently
implement COW unsharing's trivial case and have bounded search overhead,
though there is clearly a lot of room for further optimization.

Tested for basic userspace functionality on a 256MB Thinkpad T21 and a
32GB NUMA-Q with 32KB PAGE_SIZE. It does break when you push it, though
it does run init scripts, most programs, and some benchmarks here.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

Incremental patches for all stages of the rewrite as well as cumulative
diffs vs. 2.6.0-test5-bk3 and 2.6.0-test5 are also available there.

Errata:
(1) the CONFIG_PAGE_CLUSTER==0/PAGE_MMUCOUNT==1 case is nonfunctional
(2) some oopsen zwane found while running KDE
(3) some mysterious preempt imbalance(s)
(4) drivers and fs's are essentially totally unaudited, probably broken
(5) non-i386 are all broken
(6) CONFIG_DEBUG_HIGHMEM is nonfunctional
(7) CONFIG_DEBUG_PAGEALLOC is nonfunctional
(8) many, many more

TODO:
(1) merge to current
(2) sweep drivers/fs's
(3) optimize and rework kmap_atomic_sg() API to not impact CONFIG_NOHIGHMEM
(4) clean up potentially-removable code impacts (e.g. debug code)
(5) rework pagetable allocation
(6) rework/optimize rmap interaction
(7) rework TLB invalidations
(8) fix all bugs (as usual)
(9) eventually play with ia64's 32-bit emulation


-- wli
