Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbUKUARp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUKUARp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUKUAPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:15:44 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:47376 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S263200AbUKUANt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:13:49 -0500
Date: Sat, 20 Nov 2004 19:13:47 -0500
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH 5/5] reiserfs: cleaning up const checks
Message-ID: <20041121001347.GF979@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Linux 2.6.5-7.111-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up some warnings in the const qualifiers introduced by
the reiserfs/selinux patches.

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr.c linux-2.6.9.selinux/fs/reiserfs/xattr.c
--- linux-2.6.9/fs/reiserfs/xattr.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.selinux/fs/reiserfs/xattr.c	2004-11-20 18:03:57.523322224 -0500
@@ -134,7 +134,7 @@ get_xa_root (struct super_block *s)
  * If flags allow, the tree to the directory may be created. If creation is
  * prohibited, -ENODATA is returned. */
 static struct dentry *
-open_xa_dir (const struct inode *inode, int flags)
+open_xa_dir (struct inode *inode, int flags)
 {
     struct dentry *xaroot, *xadir;
     char namebuf[17];
@@ -193,7 +193,7 @@ open_xa_dir (const struct inode *inode, 
  * for the inode. If flags allow, the file is created. Otherwise, a
  * valid or negative dentry, or an error is returned. */
 static struct dentry *
-get_xa_file_dentry (const struct inode *inode, const char *name, int flags)
+get_xa_file_dentry (struct inode *inode, const char *name, int flags)
 {
     struct dentry *xadir, *xafile;
     int err = 0;
@@ -244,7 +244,7 @@ out:
 
 /* Opens a file pointer to the attribute associated with inode */
 static struct file *
-open_xa_file (const struct inode *inode, const char *name, int flags)
+open_xa_file (struct inode *inode, const char *name, int flags)
 {
     struct dentry *xafile;
     struct file *fp;
@@ -610,7 +610,7 @@ out:
  * inode->i_sem: down
  */
 int
-reiserfs_xattr_get (const struct inode *inode, const char *name, void *buffer,
+reiserfs_xattr_get (struct inode *inode, const char *name, void *buffer,
                     size_t buffer_size)
 {
     ssize_t err = 0;
diff -ruNpX dontdiff linux-2.6.9/include/linux/reiserfs_xattr.h linux-2.6.9.selinux/include/linux/reiserfs_xattr.h
--- linux-2.6.9/include/linux/reiserfs_xattr.h	2004-08-14 01:38:11.000000000 -0400
+++ linux-2.6.9.selinux/include/linux/reiserfs_xattr.h	2004-11-20 17:00:26.000000000 -0500
@@ -46,7 +47,7 @@ int reiserfs_permission (struct inode *i
 int reiserfs_permission_locked (struct inode *inode, int mask, struct nameidata *nd);
 
 int reiserfs_xattr_del (struct inode *, const char *);
-int reiserfs_xattr_get (const struct inode *, const char *, void *, size_t);
+int reiserfs_xattr_get (struct inode *, const char *, void *, size_t);
 int reiserfs_xattr_set (struct inode *, const char *, const void *,
                                size_t, int);
 
-- 
Jeff Mahoney
SuSE Labs
