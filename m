Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVF1MNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVF1MNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVF1MNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:13:05 -0400
Received: from verein.lst.de ([213.95.11.210]:9623 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261439AbVF1MMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:12:42 -0400
Date: Tue, 28 Jun 2005 14:12:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, a.gruenbacher@computer.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] really remove xattr_acl.h
Message-ID: <20050628121228.GA1938@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like it sneaked back with the NFS ACL merge..


Signed-off-by: Christoph Hellwig <hch@lst.de>


Index: linux-2.6/fs/nfs/nfs3acl.c
===================================================================
--- linux-2.6.orig/fs/nfs/nfs3acl.c	2005-06-26 13:26:24.000000000 +0200
+++ linux-2.6/fs/nfs/nfs3acl.c	2005-06-28 14:05:05.000000000 +0200
@@ -2,7 +2,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
-#include <linux/xattr_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include <linux/nfsacl.h>
 
 #define NFSDBG_FACILITY	NFSDBG_PROC
@@ -53,9 +53,9 @@
 	struct posix_acl *acl;
 	int type, error = 0;
 
-	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+	if (strcmp(name, POSIX_ACL_XATTR_ACCESS) == 0)
 		type = ACL_TYPE_ACCESS;
-	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+	else if (strcmp(name, POSIX_ACL_XATTR_DEFAULT) == 0)
 		type = ACL_TYPE_DEFAULT;
 	else
 		return -EOPNOTSUPP;
@@ -82,9 +82,9 @@
 	struct posix_acl *acl;
 	int type, error;
 
-	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+	if (strcmp(name, POSIX_ACL_XATTR_ACCESS) == 0)
 		type = ACL_TYPE_ACCESS;
-	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+	else if (strcmp(name, POSIX_ACL_XATTR_DEFAULT) == 0)
 		type = ACL_TYPE_DEFAULT;
 	else
 		return -EOPNOTSUPP;
@@ -103,9 +103,9 @@
 	struct inode *inode = dentry->d_inode;
 	int type;
 
-	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+	if (strcmp(name, POSIX_ACL_XATTR_ACCESS) == 0)
 		type = ACL_TYPE_ACCESS;
-	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+	else if (strcmp(name, POSIX_ACL_XATTR_DEFAULT) == 0)
 		type = ACL_TYPE_DEFAULT;
 	else
 		return -EOPNOTSUPP;
Index: linux-2.6/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.orig/fs/nfsd/vfs.c	2005-06-26 13:26:24.000000000 +0200
+++ linux-2.6/fs/nfsd/vfs.c	2005-06-28 14:10:16.000000000 +0200
@@ -46,10 +46,9 @@
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
-#include <linux/xattr_acl.h>
 #include <linux/posix_acl.h>
-#ifdef CONFIG_NFSD_V4
 #include <linux/posix_acl_xattr.h>
+#ifdef CONFIG_NFSD_V4
 #include <linux/xattr.h>
 #include <linux/nfs4.h>
 #include <linux/nfs4_acl.h>
@@ -1872,10 +1871,10 @@
 		return ERR_PTR(-EOPNOTSUPP);
 	switch(type) {
 		case ACL_TYPE_ACCESS:
-			name = XATTR_NAME_ACL_ACCESS;
+			name = POSIX_ACL_XATTR_ACCESS;
 			break;
 		case ACL_TYPE_DEFAULT:
-			name = XATTR_NAME_ACL_DEFAULT;
+			name = POSIX_ACL_XATTR_DEFAULT;
 			break;
 		default:
 			return ERR_PTR(-EOPNOTSUPP);
@@ -1919,17 +1918,17 @@
 		return -EOPNOTSUPP;
 	switch(type) {
 		case ACL_TYPE_ACCESS:
-			name = XATTR_NAME_ACL_ACCESS;
+			name = POSIX_ACL_XATTR_ACCESS;
 			break;
 		case ACL_TYPE_DEFAULT:
-			name = XATTR_NAME_ACL_DEFAULT;
+			name = POSIX_ACL_XATTR_DEFAULT;
 			break;
 		default:
 			return -EOPNOTSUPP;
 	}
 
 	if (acl && acl->a_count) {
-		size = xattr_acl_size(acl->a_count);
+		size = posix_acl_xattr_size(acl->a_count);
 		value = kmalloc(size, GFP_KERNEL);
 		if (!value)
 			return -ENOMEM;
Index: linux-2.6/include/linux/xattr_acl.h
===================================================================
--- linux-2.6.orig/include/linux/xattr_acl.h	2005-06-17 13:18:10.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,50 +0,0 @@
-/*
-  File: linux/xattr_acl.h
-
-  (extended attribute representation of access control lists)
-
-  (C) 2000 Andreas Gruenbacher, <a.gruenbacher@computer.org>
-*/
-
-#ifndef _LINUX_XATTR_ACL_H
-#define _LINUX_XATTR_ACL_H
-
-#include <linux/posix_acl.h>
-
-#define XATTR_NAME_ACL_ACCESS	"system.posix_acl_access"
-#define XATTR_NAME_ACL_DEFAULT	"system.posix_acl_default"
-
-#define XATTR_ACL_VERSION	0x0002
-
-typedef struct {
-	__u16		e_tag;
-	__u16		e_perm;
-	__u32		e_id;
-} xattr_acl_entry;
-
-typedef struct {
-	__u32		a_version;
-	xattr_acl_entry	a_entries[0];
-} xattr_acl_header;
-
-static inline size_t xattr_acl_size(int count)
-{
-	return sizeof(xattr_acl_header) + count * sizeof(xattr_acl_entry);
-}
-
-static inline int xattr_acl_count(size_t size)
-{
-	if (size < sizeof(xattr_acl_header))
-		return -1;
-	size -= sizeof(xattr_acl_header);
-	if (size % sizeof(xattr_acl_entry))
-		return -1;
-	return size / sizeof(xattr_acl_entry);
-}
-
-struct posix_acl * posix_acl_from_xattr(const void *value, size_t size);
-int posix_acl_to_xattr(const struct posix_acl *acl, void *buffer, size_t size);
-
-
-
-#endif /* _LINUX_XATTR_ACL_H */
