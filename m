Return-Path: <linux-kernel-owner+w=401wt.eu-S1751034AbXAFBJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXAFBJ2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXAFBJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:09:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2533 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751034AbXAFBJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:09:28 -0500
Date: Sat, 6 Jan 2007 02:09:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup include/linux/reiserfs_xattr.h
Message-ID: <20070106010931.GI20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- #ifdef guard this header for multiple inclusion
- adjust the #include's to what is actually required by this header
- remove an unneeded #ifdef
- #endif comments

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/reiserfs_xattr.h |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- linux-2.6.20-rc3-mm1/include/linux/reiserfs_xattr.h.old	2007-01-05 23:47:43.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/linux/reiserfs_xattr.h	2007-01-05 23:48:31.000000000 +0100
@@ -2,7 +2,10 @@
   File: linux/reiserfs_xattr.h
 */
 
-#include <linux/xattr.h>
+#ifndef _LINUX_REISERFS_XATTR_H
+#define _LINUX_REISERFS_XATTR_H
+
+#include <linux/types.h>
 
 /* Magic value in header */
 #define REISERFS_XATTR_MAGIC 0x52465841	/* "RFXA" */
@@ -13,7 +16,18 @@
 };
 
 #ifdef __KERNEL__
+
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/rwsem.h>
+#include <linux/reiserfs_fs_i.h>
+#include <linux/reiserfs_fs.h>
+
+struct inode;
+struct dentry;
+struct iattr;
+struct super_block;
+struct nameidata;
 
 struct reiserfs_xattr_handler {
 	char *prefix;
@@ -49,9 +63,7 @@
 
 extern struct reiserfs_xattr_handler user_handler;
 extern struct reiserfs_xattr_handler trusted_handler;
-#ifdef CONFIG_REISERFS_FS_SECURITY
 extern struct reiserfs_xattr_handler security_handler;
-#endif
 
 int reiserfs_xattr_register_handlers(void) __init;
 void reiserfs_xattr_unregister_handlers(void);
@@ -137,6 +149,8 @@
 static inline void reiserfs_init_xattr_rwsem(struct inode *inode)
 {
 }
-#endif
+#endif  /*  CONFIG_REISERFS_FS_XATTR  */
+
+#endif  /*  __KERNEL__  */
 
-#endif				/* __KERNEL__ */
+#endif  /*  _LINUX_REISERFS_XATTR_H  */

