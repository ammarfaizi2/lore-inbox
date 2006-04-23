Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWDWLmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWDWLmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDWLmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:42:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63499 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750972AbWDWLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:42:18 -0400
Date: Sun, 23 Apr 2006 13:42:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/buffer.c: possible cleanups
Message-ID: <20060423114217.GK5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- add a proper prototype for the following global function:
  - buffer_init()
- make the following needlessly global function static:
  - end_buffer_async_write()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/buffer.c                 |    3 +--
 include/linux/buffer_head.h |    2 +-
 init/main.c                 |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/buffer_head.h.old	2006-04-23 12:07:30.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/buffer_head.h	2006-04-23 12:19:48.000000000 +0200
@@ -149,7 +149,6 @@
 			unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
-void end_buffer_async_write(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
@@ -214,6 +213,7 @@
 int nobh_writepage(struct page *page, get_block_t *get_block,
                         struct writeback_control *wbc);
 
+void buffer_init(void);
 
 /*
  * inline definitions
--- linux-2.6.17-rc1-mm3-full/fs/buffer.c.old	2006-04-23 12:06:43.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/buffer.c	2006-04-23 12:07:19.000000000 +0200
@@ -566,7 +566,7 @@
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
  */
-void end_buffer_async_write(struct buffer_head *bh, int uptodate)
+static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
 	char b[BDEVNAME_SIZE];
 	unsigned long flags;
@@ -3168,7 +3168,6 @@
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(cont_prepare_write);
-EXPORT_SYMBOL(end_buffer_async_write);
 EXPORT_SYMBOL(end_buffer_read_sync);
 EXPORT_SYMBOL(end_buffer_write_sync);
 EXPORT_SYMBOL(file_fsync);
--- linux-2.6.17-rc1-mm3-full/init/main.c.old	2006-04-23 12:17:46.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/init/main.c	2006-04-23 12:18:09.000000000 +0200
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/buffer_head.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -79,7 +80,6 @@
 extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
-extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
 extern void prio_tree_init(void);

