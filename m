Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVBPKA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVBPKA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 05:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVBPKAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 05:00:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7691 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261992AbVBPJ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 04:59:33 -0500
Date: Wed, 16 Feb 2005 10:59:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/jffs2/: misc cleanups
Message-ID: <20050216095932.GE3272@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlessly global functions static
- remove the following unused global functions:
  - compr.c: jffs2_set_compression_mode
  - compr.c: jffs2_get_compression_mode

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2005
- 24 Jan 2005

 fs/jffs2/compr.c       |   10 ----------
 fs/jffs2/compr.h       |    3 ---
 fs/jffs2/compr_rtime.c |   12 ++++++++----
 fs/jffs2/erase.c       |    3 ++-
 fs/jffs2/file.c        |   15 +++++++++++----
 fs/jffs2/fs.c          |    3 ++-
 fs/jffs2/nodelist.h    |    1 -
 fs/jffs2/os-linux.h    |    5 -----
 fs/jffs2/wbuf.c        |    2 +-
 9 files changed, 24 insertions(+), 30 deletions(-)

--- linux-2.6.10-mm2-full/fs/jffs2/compr.h.old	2005-01-08 04:16:42.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/compr.h	2005-01-08 04:18:40.000000000 +0100
@@ -41,9 +41,6 @@
 #define JFFS2_COMPR_MODE_PRIORITY   1
 #define JFFS2_COMPR_MODE_SIZE       2
 
-void jffs2_set_compression_mode(int mode);
-int jffs2_get_compression_mode(void);
-
 struct jffs2_compressor {
         struct list_head list;
         int priority;              /* used by prirority comr. mode */
--- linux-2.6.10-mm2-full/fs/jffs2/compr.c.old	2005-01-08 04:18:49.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/compr.c	2005-01-08 04:19:59.000000000 +0100
@@ -23,16 +23,6 @@
 /* Actual compression mode */
 static int jffs2_compression_mode = JFFS2_COMPR_MODE_PRIORITY;
 
-void jffs2_set_compression_mode(int mode) 
-{
-        jffs2_compression_mode = mode;
-}
-
-int jffs2_get_compression_mode(void)
-{
-        return jffs2_compression_mode;
-}
-
 /* Statistics for blocks stored without compression */
 static uint32_t none_stat_compr_blocks=0,none_stat_decompr_blocks=0,none_stat_compr_size=0;
 
--- linux-2.6.10-mm2-full/fs/jffs2/compr_rtime.c.old	2005-01-08 04:20:19.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/compr_rtime.c	2005-01-08 04:21:09.000000000 +0100
@@ -29,8 +29,10 @@
 #include "compr.h"
 
 /* _compress returns the compressed size, -1 if bigger */
-int jffs2_rtime_compress(unsigned char *data_in, unsigned char *cpage_out, 
-		   uint32_t *sourcelen, uint32_t *dstlen, void *model)
+static int jffs2_rtime_compress(unsigned char *data_in,
+				unsigned char *cpage_out, 
+				uint32_t *sourcelen, uint32_t *dstlen,
+				void *model)
 {
 	short positions[256];
 	int outpos = 0;
@@ -69,8 +71,10 @@
 }		   
 
 
-int jffs2_rtime_decompress(unsigned char *data_in, unsigned char *cpage_out,
-		      uint32_t srclen, uint32_t destlen, void *model)
+static int jffs2_rtime_decompress(unsigned char *data_in,
+				  unsigned char *cpage_out,
+				  uint32_t srclen, uint32_t destlen,
+				  void *model)
 {
 	short positions[256];
 	int outpos = 0;
--- linux-2.6.10-mm2-full/fs/jffs2/nodelist.h.old	2005-01-08 04:24:11.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/nodelist.h	2005-01-08 04:24:16.000000000 +0100
@@ -460,7 +460,6 @@
 int jffs2_do_mount_fs(struct jffs2_sb_info *c);
 
 /* erase.c */
-void jffs2_erase_block(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 void jffs2_erase_pending_blocks(struct jffs2_sb_info *c, int count);
 
 #ifdef CONFIG_JFFS2_FS_NAND
--- linux-2.6.10-mm2-full/fs/jffs2/erase.c.old	2005-01-08 04:24:24.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/erase.c	2005-01-08 04:24:44.000000000 +0100
@@ -33,7 +33,8 @@
 static void jffs2_free_all_node_refs(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 
-void jffs2_erase_block(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
+static void jffs2_erase_block(struct jffs2_sb_info *c,
+			      struct jffs2_eraseblock *jeb)
 {
 	int ret;
 	uint32_t bad_offset;
--- linux-2.6.10-mm2-full/fs/jffs2/os-linux.h.old	2005-01-08 04:25:12.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/os-linux.h	2005-01-08 04:27:59.000000000 +0100
@@ -173,11 +173,7 @@
 extern struct inode_operations jffs2_file_inode_operations;
 extern struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, struct dentry *, int);
-int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg);
 int jffs2_do_readpage_unlock (struct inode *inode, struct page *pg);
-int jffs2_readpage (struct file *, struct page *);
-int jffs2_prepare_write (struct file *, struct page *, unsigned, unsigned);
-int jffs2_commit_write (struct file *, struct page *, unsigned, unsigned);
 
 /* ioctl.c */
 int jffs2_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
@@ -208,7 +204,6 @@
 void jffs2_gc_release_page(struct jffs2_sb_info *c,
 			   unsigned char *pg,
 			   unsigned long *priv);
-int jffs2_flash_setup(struct jffs2_sb_info *c);
 void jffs2_flash_cleanup(struct jffs2_sb_info *c);
      
 
--- linux-2.6.10-mm2-full/fs/jffs2/file.c.old	2005-01-08 04:25:37.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/file.c	2005-01-08 04:27:48.000000000 +0100
@@ -25,6 +25,11 @@
 extern int generic_file_open(struct inode *, struct file *) __attribute__((weak));
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin) __attribute__((weak));
 
+static int jffs2_commit_write (struct file *filp, struct page *pg,
+			       unsigned start, unsigned end);
+static int jffs2_prepare_write (struct file *filp, struct page *pg,
+				unsigned start, unsigned end);
+static int jffs2_readpage (struct file *filp, struct page *pg);
 
 int jffs2_fsync(struct file *filp, struct dentry *dentry, int datasync)
 {
@@ -65,7 +70,7 @@
 	.commit_write =	jffs2_commit_write
 };
 
-int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
+static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
@@ -105,7 +110,7 @@
 }
 
 
-int jffs2_readpage (struct file *filp, struct page *pg)
+static int jffs2_readpage (struct file *filp, struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
@@ -116,7 +121,8 @@
 	return ret;
 }
 
-int jffs2_prepare_write (struct file *filp, struct page *pg, unsigned start, unsigned end)
+static int jffs2_prepare_write (struct file *filp, struct page *pg,
+				unsigned start, unsigned end)
 {
 	struct inode *inode = pg->mapping->host;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
@@ -198,7 +204,8 @@
 	return ret;
 }
 
-int jffs2_commit_write (struct file *filp, struct page *pg, unsigned start, unsigned end)
+static int jffs2_commit_write (struct file *filp, struct page *pg,
+			       unsigned start, unsigned end)
 {
 	/* Actually commit the write from the page cache page we're looking at.
 	 * For now, we write the full page out each time. It sucks, but it's simple
--- linux-2.6.10-mm2-full/fs/jffs2/fs.c.old	2005-01-08 04:28:06.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/fs.c	2005-01-08 04:28:36.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/crc32.h>
 #include "nodelist.h"
 
+static int jffs2_flash_setup(struct jffs2_sb_info *c);
 
 static int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 {
@@ -644,7 +645,7 @@
 	page_cache_release(pg);
 }
 
-int jffs2_flash_setup(struct jffs2_sb_info *c) {
+static int jffs2_flash_setup(struct jffs2_sb_info *c) {
 	int ret = 0;
 	
 	if (jffs2_cleanmarker_oob(c)) {
--- linux-2.6.10-mm2-full/fs/jffs2/wbuf.c.old	2005-01-08 04:28:50.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs2/wbuf.c	2005-01-08 04:29:01.000000000 +0100
@@ -1087,7 +1087,7 @@
 };
 
 
-int jffs2_nand_set_oobinfo(struct jffs2_sb_info *c)
+static int jffs2_nand_set_oobinfo(struct jffs2_sb_info *c)
 {
 	struct nand_oobinfo *oinfo = &c->mtd->oobinfo;
 

