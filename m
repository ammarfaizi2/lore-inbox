Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbTCYWIU>; Tue, 25 Mar 2003 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbTCYWIG>; Tue, 25 Mar 2003 17:08:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:55226 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262586AbTCYWFi>; Tue, 25 Mar 2003 17:05:38 -0500
Date: Tue, 25 Mar 2003 22:18:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 08/13 rmap comments
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252217540.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update a few locking comments in rmap.c.

--- swap07/mm/rmap.c	Tue Mar 25 20:44:02 2003
+++ swap08/mm/rmap.c	Tue Mar 25 20:44:13 2003
@@ -14,8 +14,8 @@
 /*
  * Locking:
  * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the zone->lru_lock, then the
- *   mm->page_table_lock, and then the page lock.
+ *   which nests within the the mm->page_table_lock,
+ *   which nests within the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
  *   on the mm->page_table_lock
@@ -584,9 +584,8 @@
  * table entry mapping a page. Because locking order here is opposite
  * to the locking order used by the page fault path, we use trylocks.
  * Locking:
- *	zone->lru_lock			page_launder()
- *	    page lock			page_launder(), trylock
- *		pte_chain_lock		page_launder()
+ *	    page lock			shrink_list(), trylock
+ *		pte_chain_lock		shrink_list()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
 static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
@@ -673,8 +672,8 @@
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold zone->lru_lock
- * and the page lock.  Return values are:
+ * page, used in the pageout path.  Caller must hold the page lock
+ * and its pte chain lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later

