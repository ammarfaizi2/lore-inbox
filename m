Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVAQINm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVAQINm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAQINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:13:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261451AbVAQINe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:34 -0500
Date: Mon, 17 Jan 2005 09:13:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/filemap.c: make a function static
Message-ID: <20050117081329.GY4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global and EXPORT_SYMBOL'ed function 
sync_page_range_nolock static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 include/linux/writeback.h |    2 --
 mm/filemap.c              |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/writeback.h.old	2004-12-12 03:49:31.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/writeback.h	2004-12-12 03:49:38.000000000 +0100
@@ -107,8 +107,6 @@
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count);
-int sync_page_range_nolock(struct inode *inode, struct address_space
-		*mapping, loff_t pos, size_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
--- linux-2.6.10-rc2-mm4-full/mm/filemap.c.old	2004-12-12 03:48:06.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/mm/filemap.c	2004-12-12 03:49:58.000000000 +0100
@@ -290,8 +290,9 @@
  * as it forces O_SYNC writers to different parts of the same file
  * to be serialised right until io completion.
  */
-int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
-			loff_t pos, size_t count)
+static int sync_page_range_nolock(struct inode *inode,
+				  struct address_space *mapping,
+				  loff_t pos, size_t count)
 {
 	pgoff_t start = pos >> PAGE_CACHE_SHIFT;
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
@@ -306,7 +307,6 @@
 		ret = wait_on_page_writeback_range(mapping, start, end);
 	return ret;
 }
-EXPORT_SYMBOL(sync_page_range_nolock);
 
 /**
  * filemap_fdatawait - walk the list of under-writeback pages of the given

