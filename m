Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933879AbWKTC0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933879AbWKTC0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbWKTCY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933878AbWKTCY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:26 -0500
Date: Mon, 20 Nov 2006 03:24:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Edward Shishkin <edward@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [-mm patch] fs/reiser4/: possible cleanups
Message-ID: <20061120022425.GR31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global functions statis:
  - plugin/file/file_conversion.c: prepped_dclust_ok()
  - plugin/file/file_conversion.c: cryptcompress2unixfile()
- #if 0 the following unused global functions:
  - plugin/file/cryptcompress.c: prepare_write_cryptcompress()
  - plugin/file/file_conversion.c: prot_delete_object_cryptcompress()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/plugin/file/cryptcompress.c   |    2 ++
 fs/reiser4/plugin/file/file.h            |    3 ---
 fs/reiser4/plugin/file/file_conversion.c |    8 +++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/file.h.old	2006-11-20 02:12:25.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/file.h	2006-11-20 02:14:54.000000000 +0100
@@ -203,8 +203,6 @@
 ssize_t prot_read_cryptcompress(struct file *, char __user *buf,
 				size_t read_amount, loff_t * off);
 
-int prepare_write_cryptcompress(struct file *file, struct page *page,
-				unsigned from, unsigned to);
 ssize_t write_cryptcompress(struct file *, const char __user *buf, size_t write_amount,
 			    loff_t * off, int * conv);
 ssize_t prot_write_cryptcompress(struct file *, const char __user *buf, size_t write_amount,
@@ -230,7 +228,6 @@
 int create_cryptcompress(struct inode *, struct inode *,
 			 reiser4_object_create_data *);
 int delete_object_cryptcompress(struct inode *);
-int prot_delete_object_cryptcompress(struct inode *);
 void init_inode_data_cryptcompress(struct inode *, reiser4_object_create_data *,
 				   int create);
 int cut_tree_worker_cryptcompress(tap_t *, const reiser4_key * from_key,
--- linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/cryptcompress.c.old	2006-11-20 02:12:37.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/cryptcompress.c	2006-11-20 02:12:56.000000000 +0100
@@ -3768,11 +3768,13 @@
 	return 0;
 }
 
+#if 0
 int prepare_write_cryptcompress(struct file *file, struct page *page,
 				unsigned from, unsigned to)
 {
 	return prepare_write_common(file, page, from, to);
 }
+#endif  /*  0  */
 
 
 /*
--- linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/file_conversion.c.old	2006-11-20 02:13:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/reiser4/plugin/file/file_conversion.c	2006-11-20 02:15:07.000000000 +0100
@@ -239,7 +239,7 @@
 }
 
 #if REISER4_DEBUG
-int prepped_dclust_ok(hint_t * hint)
+static int prepped_dclust_ok(hint_t * hint)
 {
 	reiser4_key key;
 	coord_t * coord = &hint->ext_coord.coord;
@@ -410,8 +410,8 @@
 
 
 /* do conversion */
-int cryptcompress2unixfile(struct file *file, struct inode * inode,
-			   reiser4_cluster_t * clust)
+static int cryptcompress2unixfile(struct file *file, struct inode * inode,
+				  reiser4_cluster_t * clust)
 {
 	int i;
 	int result = 0;
@@ -577,10 +577,12 @@
 			    (file, ppos, count, actor, target));
 }
 
+#if 0
 int prot_delete_object_cryptcompress(struct inode *inode)
 {
 	return PROT_PASSIVE(int, delete_object, (inode));
 }
+#endif  /*  0  */
 
 /*
   Local variables:

