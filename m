Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVAHWJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVAHWJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVAHWHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:07:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261864AbVAHWDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:03:40 -0500
Date: Sat, 8 Jan 2005 23:03:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: al@alarsen.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/qnx4/: make some code static
Message-ID: <20050108220336.GE14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 fs/qnx4/bitmap.c        |    4 ++--
 fs/qnx4/inode.c         |    8 ++++----
 include/linux/qnx4_fs.h |    2 --
 3 files changed, 6 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/qnx4/bitmap.c.old	2005-01-08 17:14:26.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/qnx4/bitmap.c	2005-01-08 17:14:38.000000000 +0100
@@ -28,8 +28,8 @@
 	return 0;
 }
 
-void count_bits(register const char *bmPart, register int size,
-		int *const tf)
+static void count_bits(register const char *bmPart, register int size,
+		       int *const tf)
 {
 	char b;
 	int tot = *tf;
--- linux-2.6.10-mm2-full/include/linux/qnx4_fs.h.old	2005-01-08 17:15:37.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/qnx4_fs.h	2005-01-08 17:15:52.000000000 +0100
@@ -114,7 +114,6 @@
 extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
 extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
 
-extern struct buffer_head *qnx4_getblk(struct inode *, int, int);
 extern struct buffer_head *qnx4_bread(struct inode *, int, int);
 
 extern struct inode_operations qnx4_file_inode_operations;
@@ -130,7 +129,6 @@
 extern int qnx4_rmdir(struct inode *dir, struct dentry *dentry);
 extern int qnx4_sync_file(struct file *file, struct dentry *dentry, int);
 extern int qnx4_sync_inode(struct inode *inode);
-extern int qnx4_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh, int create);
 
 static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
 {
--- linux-2.6.10-mm2-full/fs/qnx4/inode.c.old	2005-01-08 17:15:01.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/qnx4/inode.c	2005-01-08 17:16:08.000000000 +0100
@@ -162,8 +162,8 @@
 	return 0;
 }
 
-struct buffer_head *qnx4_getblk(struct inode *inode, int nr,
-				 int create)
+static struct buffer_head *qnx4_getblk(struct inode *inode, int nr,
+				       int create)
 {
 	struct buffer_head *result = NULL;
 
@@ -212,7 +212,7 @@
 	return NULL;
 }
 
-int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
+static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
 {
 	unsigned long phys;
 
@@ -447,7 +447,7 @@
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
-struct address_space_operations qnx4_aops = {
+static struct address_space_operations qnx4_aops = {
 	.readpage	= qnx4_readpage,
 	.writepage	= qnx4_writepage,
 	.sync_page	= block_sync_page,

