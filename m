Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271598AbRHPRhz>; Thu, 16 Aug 2001 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271599AbRHPRhp>; Thu, 16 Aug 2001 13:37:45 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:8049 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S271598AbRHPRhj>; Thu, 16 Aug 2001 13:37:39 -0400
Date: Thu, 16 Aug 2001 18:41:08 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Align VM locks
Message-ID: <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  The patch below ensures the pagecache_lock and pagemap_lru_lock aren't
sharing an L1 cacheline with anyone else - espically each other!

Mark


diff -ur -X dontdiff linux-2.4.9-pre4/mm/filemap.c L1-2.4.9-pre4/mm/filemap.c
--- linux-2.4.9-pre4/mm/filemap.c	Thu Aug 16 15:57:51 2001
+++ L1-2.4.9-pre4/mm/filemap.c	Thu Aug 16 18:28:24 2001
@@ -45,12 +45,12 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;

-spinlock_t pagecache_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t __cacheline_aligned pagecache_lock = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagecache_lock with
  *       the pagemap_lru_lock held.
  */
-spinlock_t pagemap_lru_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t __cacheline_aligned pagemap_lru_lock = SPIN_LOCK_UNLOCKED;

 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)

