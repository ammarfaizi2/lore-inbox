Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWEAHLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWEAHLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWEAHLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:11:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41489 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751299AbWEAHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:11:26 -0400
Date: Mon, 1 May 2006 09:11:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/sync.c: make do_sync_file_range() static
Message-ID: <20060501071125.GD3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global do_sync_file_range() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2006

 fs/sync.c          |    8 +++++---
 include/linux/fs.h |    2 --
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/fs.h.old	2006-04-23 15:54:22.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/fs.h	2006-04-23 15:54:38.000000000 +0200
@@ -762,8 +762,6 @@
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
-extern int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
-			unsigned int flags);
 
 /* fs/locks.c */
 extern void locks_init_lock(struct file_lock *);
--- linux-2.6.17-rc1-mm3-full/fs/sync.c.old	2006-04-23 15:53:30.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/sync.c	2006-04-23 15:54:15.000000000 +0200
@@ -14,6 +14,9 @@
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 			SYNC_FILE_RANGE_WAIT_AFTER)
 
+static int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
+			      unsigned int flags);
+
 /*
  * sys_sync_file_range() permits finely controlled syncing over a segment of
  * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
@@ -125,8 +128,8 @@
 /*
  * `endbyte' is inclusive
  */
-int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
-			unsigned int flags)
+static int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
+			      unsigned int flags)
 {
 	int ret;
 	struct address_space *mapping;
@@ -161,4 +164,3 @@
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(do_sync_file_range);

