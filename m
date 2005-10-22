Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVJVQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVJVQTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVJVQTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:19:07 -0400
Received: from silver.veritas.com ([143.127.12.111]:19349 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932242AbVJVQTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:19:06 -0400
Date: Sat, 22 Oct 2005 17:18:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] mm: page fault scalability
Message-ID: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:19:01.0816 (UTC) FILETIME=[506ECB80:01C5D724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes the third batch of my page fault scalability patches, against
2.6.14-rc4-mm1.  This batch actually gets there.  There will be a little
more to come later (e.g. comments in ppc64, page_table_lock in sparc64,
perhaps out-of-lining pte_offset_map_lock - I haven't quite decided, and
attempt to update Documentation/vm/locking); but this is the most of it.

Hugh

 arch/arm/kernel/signal.c        |   96 +++++++---------------------------------
 arch/arm/kernel/traps.c         |   14 +++--
 arch/arm/mm/fault-armv.c        |    7 ++
 arch/arm/mm/mm-armv.c           |    1 
 arch/cris/arch-v32/mm/tlb.c     |    6 +-
 arch/i386/kernel/vm86.c         |   17 ++-----
 arch/parisc/kernel/cache.c      |   24 +++-------
 arch/sh/mm/fault.c              |   40 +++++++++-------
 arch/sh64/mm/cache.c            |   66 ++++++++++++---------------
 arch/um/include/tlb.h           |    1 
 arch/um/kernel/process_kern.c   |    8 ++-
 arch/um/kernel/skas/mmu.c       |    1 
 arch/um/kernel/tlb.c            |    9 ---
 arch/um/kernel/tt/tlb.c         |   36 ---------------
 include/asm-generic/pgtable.h   |    2 
 include/asm-parisc/cacheflush.h |   35 +++++++-------
 include/linux/mempolicy.h       |    3 -
 include/linux/mm.h              |   26 ++++++++++
 include/linux/sched.h           |   42 +++++++++++++++--
 mm/Kconfig                      |   13 +++++
 mm/filemap.c                    |    6 +-
 mm/memory.c                     |   28 +++++++----
 mm/mremap.c                     |   11 ++++
 mm/rmap.c                       |   15 +++---
 mm/swap_state.c                 |    3 -
 25 files changed, 248 insertions(+), 262 deletions(-)
