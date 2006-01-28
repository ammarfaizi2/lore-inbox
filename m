Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWA1XFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWA1XFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWA1XFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:05:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45835 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750781AbWA1XEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:04:49 -0500
Date: Sun, 29 Jan 2006 00:04:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/coda/: proper prototypes
Message-ID: <20060128230449.GU3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a file fs/coda/coda_int.h with proper prototypes 
for some code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

---

This patch was already sent on:
- 21 Jan 2006

 fs/coda/coda_int.h |   13 +++++++++++++
 fs/coda/dir.c      |    3 ++-
 fs/coda/file.c     |    2 ++
 fs/coda/inode.c    |    2 ++
 fs/coda/psdev.c    |    9 ++-------
 5 files changed, 21 insertions(+), 8 deletions(-)

--- /dev/null	2005-11-08 19:07:57.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/coda/coda_int.h	2006-01-21 01:06:23.000000000 +0100
@@ -0,0 +1,13 @@
+#ifndef _CODA_INT_
+#define _CODA_INT_
+
+extern struct file_system_type coda_fs_type;
+
+void coda_destroy_inodecache(void);
+int coda_init_inodecache(void);
+int coda_fsync(struct file *coda_file, struct dentry *coda_dentry,
+	       int datasync);
+
+#endif  /*  _CODA_INT_  */
+
+
--- linux-2.6.16-rc1-mm2-full/fs/coda/file.c.old	2006-01-21 01:02:36.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/coda/file.c	2006-01-21 01:02:51.000000000 +0100
@@ -24,6 +24,8 @@
 #include <linux/coda_psdev.h>
 #include <linux/coda_proc.h>
 
+#include "coda_int.h"
+
 /* if CODA_STORE fails with EOPNOTSUPP, venus clearly doesn't support
  * CODA_STORE/CODA_RELEASE and we fall back on using the CODA_CLOSE upcall */
 static int use_coda_close;
--- linux-2.6.16-rc1-mm2-full/fs/coda/dir.c.old	2006-01-21 01:03:33.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/coda/dir.c	2006-01-21 01:03:57.000000000 +0100
@@ -27,6 +27,8 @@
 #include <linux/coda_cache.h>
 #include <linux/coda_proc.h>
 
+#include "coda_int.h"
+
 /* dir inode-ops */
 static int coda_create(struct inode *dir, struct dentry *new, int mode, struct nameidata *nd);
 static struct dentry *coda_lookup(struct inode *dir, struct dentry *target, struct nameidata *nd);
@@ -50,7 +52,6 @@
 /* support routines */
 static int coda_venus_readdir(struct file *filp, filldir_t filldir,
 			      void *dirent, struct dentry *dir);
-int coda_fsync(struct file *, struct dentry *dentry, int datasync);
 
 /* same as fs/bad_inode.c */
 static int coda_return_EIO(void)
--- linux-2.6.16-rc1-mm2-full/fs/coda/inode.c.old	2006-01-21 01:04:12.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/coda/inode.c	2006-01-21 01:04:28.000000000 +0100
@@ -31,6 +31,8 @@
 #include <linux/coda_fs_i.h>
 #include <linux/coda_cache.h>
 
+#include "coda_int.h"
+
 /* VFS super_block ops */
 static void coda_clear_inode(struct inode *);
 static void coda_put_super(struct super_block *);
--- linux-2.6.16-rc1-mm2-full/fs/coda/psdev.c.old	2006-01-21 01:04:36.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/coda/psdev.c	2006-01-21 01:06:07.000000000 +0100
@@ -48,12 +48,9 @@
 #include <linux/coda_psdev.h>
 #include <linux/coda_proc.h>
 
-#define upc_free(r) kfree(r)
+#include "coda_int.h"
 
-/* 
- * Coda stuff
- */
-extern struct file_system_type coda_fs_type;
+#define upc_free(r) kfree(r)
 
 /* statistics */
 int           coda_hard;         /* allows signals during upcalls */
@@ -394,8 +391,6 @@
 MODULE_AUTHOR("Peter J. Braam <braam@cs.cmu.edu>");
 MODULE_LICENSE("GPL");
 
-extern int coda_init_inodecache(void);
-extern void coda_destroy_inodecache(void);
 static int __init init_coda(void)
 {
 	int status;

