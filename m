Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVGIBLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVGIBLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVGIAqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:46:45 -0400
Received: from silver.veritas.com ([143.127.12.111]:61506 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263052AbVGIAqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:46:25 -0400
Date: Sat, 9 Jul 2005 01:47:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] delete from_swap_cache BUG_ONs
Message-ID: <Pine.LNX.4.61.0507090146090.14262@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:46:23.0110 (UTC) FILETIME=[A1122260:01C5841F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three of the four BUG_ONs in delete_from_swap_cache are immediately
repeated in __delete_from_swap_cache: delete those and add the one.
But perhaps mm/ is altogether overprovisioned with historic BUGs?

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swap_state.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

--- 2.6.13-rc2-mm1/mm/swap_state.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/mm/swap_state.c	2005-07-07 18:40:36.000000000 +0100
@@ -123,6 +123,7 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
+	BUG_ON(PagePrivate(page));
 
 	radix_tree_delete(&swapper_space.page_tree, page->private);
 	page->private = 0;
@@ -195,11 +196,6 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	BUG_ON(!PageSwapCache(page));
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
-	BUG_ON(PagePrivate(page));
-  
 	entry.val = page->private;
 
 	write_lock_irq(&swapper_space.tree_lock);
