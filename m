Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVCXDbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVCXDbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVCXDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:11:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263001AbVCXDJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:09:31 -0500
Date: Thu, 24 Mar 2005 04:09:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/filemap.c: make sync_page_range_nolock static
Message-ID: <20050324030927.GS1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sync_page_range_nolock isn't used outside of this file.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Mar 2005

 include/linux/writeback.h |    2 --
 mm/filemap.c              |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.11-mm1-full/include/linux/writeback.h.old	2005-03-04 15:40:45.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/writeback.h	2005-03-04 15:40:55.000000000 +0100
@@ -107,8 +107,6 @@
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count);
-int sync_page_range_nolock(struct inode *inode, struct address_space
-		*mapping, loff_t pos, size_t count);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
--- linux-2.6.11-mm1-full/mm/filemap.c.old	2005-03-04 15:41:05.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/filemap.c	2005-03-04 15:41:29.000000000 +0100
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


