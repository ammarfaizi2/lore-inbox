Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVAaMRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVAaMRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVAaMRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:17:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7174 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261163AbVAaMRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:17:22 -0500
Date: Mon, 31 Jan 2005 13:17:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/page-writeback.c: remove an unused function
Message-ID: <20050131121718.GA18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 mm/page-writeback.c        |   24 ------------------------
 1 files changed, 24 deletions(-)

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

