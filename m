Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272672AbTG1Gnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272673AbTG1Gnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:43:47 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:22834 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272672AbTG1Gnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:43:46 -0400
To: <akpm@osdl.org>
Subject: [PATCH]2.6 test1 mm2 special_file move
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 28 Jul 2003 09:25:36 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S272672AbTG1Gnq/20030728064346Z+201@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

            Here's special_file macro move.It was used twice in both vfs & jfs with same definition.

Regards,
Fabian

            diff -Naur orig/fs/jfs/inode.c edited/fs/jfs/inode.c
--- orig/fs/jfs/inode.c	2003-07-14 05:28:52.000000000 +0200
+++ edited/fs/jfs/inode.c	2003-07-27 22:42:03.000000000 +0200
@@ -65,9 +65,6 @@
 	}
 }
 
-/* This define is from fs/open.c */
-#define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
-
 /*
  * Workhorse of both fsync & write_inode
  */
diff -Naur orig/fs/open.c edited/fs/open.c
--- orig/fs/open.c	2003-07-14 05:29:30.000000000 +0200
+++ edited/fs/open.c	2003-07-27 22:41:49.000000000 +0200
@@ -20,8 +20,7 @@
 #include <linux/mount.h>
 #include <linux/vfs.h>
 #include <asm/uaccess.h>
-
-#define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
+#include <linux/fs.h>
 
 int vfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
diff -Naur orig/include/linux/fs.h edited/include/linux/fs.h
--- orig/include/linux/fs.h	2003-07-23 15:59:42.000000000 +0200
+++ edited/include/linux/fs.h	2003-07-27 22:41:46.000000000 +0200
@@ -1320,6 +1320,8 @@
 
 extern struct file_operations generic_ro_fops;
 
+#define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
+
 extern int vfs_readlink(struct dentry *, char __user *, int, const char *);
 extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);


___________________________________



