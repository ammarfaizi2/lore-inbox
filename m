Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbULLTxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbULLTxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbULLTxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:53:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1554 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262100AbULLTwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:52:33 -0500
Date: Sun, 12 Dec 2004 20:52:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/page-writeback.c: remove an unused function
Message-ID: <20041212195221.GI22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused global function.


diffstat output:
 include/linux/page-flags.h |    1 -
 mm/page-writeback.c        |   24 ------------------------
 2 files changed, 25 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/page-flags.h.old	2004-12-12 03:52:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/page-flags.h	2004-12-12 03:52:27.000000000 +0100
@@ -310,7 +310,6 @@
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
-int __clear_page_dirty(struct page *page);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
 
--- linux-2.6.10-rc2-mm4-full/mm/page-writeback.c.old	2004-12-12 03:52:39.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/mm/page-writeback.c	2004-12-12 03:52:47.000000000 +0100
@@ -741,30 +741,6 @@
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-/*
- * Clear a page's dirty flag while ignoring dirty memory accounting
- */
-int __clear_page_dirty(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-
-	if (mapping) {
-		unsigned long flags;
-
-		write_lock_irqsave(&mapping->tree_lock, flags);
-		if (TestClearPageDirty(page)) {
-			radix_tree_tag_clear(&mapping->page_tree,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-			write_unlock_irqrestore(&mapping->tree_lock, flags);
-			return 1;
-		}
-		write_unlock_irqrestore(&mapping->tree_lock, flags);
-		return 0;
-	}
-	return TestClearPageDirty(page);
-}
-
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);

