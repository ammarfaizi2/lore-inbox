Return-Path: <linux-kernel-owner+w=401wt.eu-S1751411AbXAUTNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXAUTNV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAUTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:13:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4201 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751401AbXAUTM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:12:59 -0500
Date: Sun, 21 Jan 2007 20:13:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup include/linux/xattr.h
Message-ID: <20070121191304.GM9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- reduce the userspace visible part
- fix the in-kernel compilation

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Jan 2007

 include/linux/Kbuild  |    2 +-
 include/linux/xattr.h |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

--- linux-2.6.20-rc3-mm1/include/linux/Kbuild.old	2007-01-05 23:42:02.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/linux/Kbuild	2007-01-05 23:42:47.000000000 +0100
@@ -159,7 +159,6 @@
 header-y += videotext.h
 header-y += vt.h
 header-y += wireless.h
-header-y += xattr.h
 header-y += x25.h
 
 unifdef-y += acct.h
@@ -337,6 +336,7 @@
 unifdef-y += wanrouter.h
 unifdef-y += watchdog.h
 unifdef-y += wireless.h
+unifdef-y += xattr.h
 unifdef-y += xfrm.h
 
 objhdr-y += version.h
--- linux-2.6.20-rc3-mm1/include/linux/xattr.h.old	2007-01-05 23:42:43.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/linux/xattr.h	2007-01-05 23:42:47.000000000 +0100
@@ -13,6 +13,10 @@
 #define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
 #define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
 
+#ifdef  __KERNEL__
+
+#include <linux/types.h>
+
 /* Namespaces */
 #define XATTR_OS2_PREFIX "os2."
 #define XATTR_OS2_PREFIX_LEN (sizeof (XATTR_OS2_PREFIX) - 1)
@@ -29,6 +33,8 @@
 #define XATTR_USER_PREFIX "user."
 #define XATTR_USER_PREFIX_LEN (sizeof (XATTR_USER_PREFIX) - 1)
 
+struct inode;
+struct dentry;
 
 struct xattr_handler {
 	char *prefix;
@@ -50,4 +56,6 @@
 int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
 int generic_removexattr(struct dentry *dentry, const char *name);
 
+#endif  /*  __KERNEL__  */
+
 #endif	/* _LINUX_XATTR_H */

