Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUAPVOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUAPVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:14:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:56290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265766AbUAPVOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:14:32 -0500
Date: Fri, 16 Jan 2004 13:14:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: [PATCH 1/2] Move XATTR_SECURITY_PREFIX macro to common location
Message-ID: <20040116131423.Q19023@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the XATTR_SECURITY_PREFIX macro to the xattr.h header so that it's
in a common location.

 fs/devpts/xattr_security.c |    2 --
 fs/ext2/xattr_security.c   |    2 --
 fs/ext3/xattr_security.c   |    2 --
 include/linux/xattr.h      |    2 ++
 security/selinux/hooks.c   |    7 +++----
 5 files changed, 5 insertions(+), 10 deletions(-)

===== fs/devpts/xattr_security.c 1.1 vs edited =====
--- 1.1/fs/devpts/xattr_security.c	Sun May 25 14:08:03 2003
+++ edited/fs/devpts/xattr_security.c	Fri Jan 16 12:14:14 2004
@@ -8,8 +8,6 @@
 #include <linux/security.h>
 #include "xattr.h"
 
-#define XATTR_SECURITY_PREFIX "security."
-
 static size_t
 devpts_xattr_security_list(struct dentry *dentry, char *buffer)
 {
===== fs/ext2/xattr_security.c 1.1 vs edited =====
--- 1.1/fs/ext2/xattr_security.c	Mon May  5 06:19:21 2003
+++ edited/fs/ext2/xattr_security.c	Fri Jan 16 12:14:14 2004
@@ -10,8 +10,6 @@
 #include <linux/ext2_fs.h>
 #include "xattr.h"
 
-#define XATTR_SECURITY_PREFIX "security."
-
 static size_t
 ext2_xattr_security_list(char *list, struct inode *inode,
 			const char *name, int name_len)
===== fs/ext3/xattr_security.c 1.1 vs edited =====
--- 1.1/fs/ext3/xattr_security.c	Mon May  5 06:18:48 2003
+++ edited/fs/ext3/xattr_security.c	Fri Jan 16 12:14:15 2004
@@ -11,8 +11,6 @@
 #include <linux/ext3_fs.h>
 #include "xattr.h"
 
-#define XATTR_SECURITY_PREFIX "security."
-
 static size_t
 ext3_xattr_security_list(char *list, struct inode *inode,
 		    const char *name, int name_len)
===== include/linux/xattr.h 1.4 vs edited =====
--- 1.4/include/linux/xattr.h	Tue Feb 25 08:21:08 2003
+++ edited/include/linux/xattr.h	Fri Jan 16 12:14:15 2004
@@ -12,4 +12,6 @@
 #define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
 #define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
 
+#define XATTR_SECURITY_PREFIX	"security."
+
 #endif	/* _LINUX_XATTR_H */
===== security/selinux/hooks.c 1.11 vs edited =====
--- 1.11/security/selinux/hooks.c	Tue Dec 30 00:40:59 2003
+++ edited/security/selinux/hooks.c	Fri Jan 16 12:14:15 2004
@@ -16,10 +16,6 @@
  *      as published by the Free Software Foundation.
  */
 
-#define XATTR_SECURITY_PREFIX "security."
-#define XATTR_SELINUX_SUFFIX "selinux"
-#define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -61,6 +57,9 @@
 
 #include "avc.h"
 #include "objsec.h"
+
+#define XATTR_SELINUX_SUFFIX "selinux"
+#define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
