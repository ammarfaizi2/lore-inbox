Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbSKEQYq>; Tue, 5 Nov 2002 11:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSKEQYq>; Tue, 5 Nov 2002 11:24:46 -0500
Received: from [198.149.18.6] ([198.149.18.6]:49634 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264890AbSKEQYm>;
	Tue, 5 Nov 2002 11:24:42 -0500
Date: Tue, 5 Nov 2002 18:45:37 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com, braam@clusterfs.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix intermezzo compile failure
Message-ID: <20021105184537.A9230@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	braam@clusterfs.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intermezzo has some strange, broken code trying to deal with extended
attributes and and ACLs.  Fortunately the xattr code is hidden under
a config option that's never set, but the ACL code is enabled by
CONFIG_POSIX_ACL that's se by ext2/ext3 and jfs now.  Change it to
#if 0 to get intermezzo compiling again.


--- 1.11/fs/intermezzo/vfs.c	Sat Oct 12 03:13:43 2002
+++ edited/fs/intermezzo/vfs.c	Tue Nov  5 17:24:16 2002
@@ -74,7 +74,7 @@
 #ifdef CONFIG_FS_EXT_ATTR
 # include <linux/ext_attr.h>
 
-# ifdef CONFIG_FS_POSIX_ACL
+# if 0 /* was a broken check for Posix ACLs */
 #  include <linux/posix_acl.h>
 # endif
 #endif
@@ -466,7 +466,7 @@
         struct dentry *dentry;
         struct presto_file_set *fset;
         int error;
-#ifdef  CONFIG_FS_POSIX_ACL
+#if 0 /* was a broken check for Posix ACLs */
         int (*set_posix_acl)(struct inode *, int type, posix_acl_t *)=NULL;
 #endif
 
@@ -507,7 +507,7 @@
                                  (dentry->d_inode->i_mode & ~S_IALLUGO);
                 CDEBUG(D_PIOCTL, "chmod: orig %#o, set %#o, result %#o\n",
                        dentry->d_inode->i_mode, set_mode, iattr->ia_mode);
-#ifdef CONFIG_FS_POSIX_ACL
+#if 0 /* was a broken check for Posix ACLs */
                 /* ACl code interacts badly with setattr 
                  * since it tries to modify the ACL using 
                  * set_ext_attr which recurses back into presto.  
@@ -535,7 +535,7 @@
                 }
         }
 
-#ifdef CONFIG_FS_POSIX_ACL
+#if 0 /* was a broken check for Posix ACLs */
         /* restore the inode_operations if we changed them*/
         if (iattr->ia_valid & ATTR_MODE) 
                 dentry->d_inode->i_op->set_posix_acl=set_posix_acl;
@@ -2252,7 +2252,7 @@
 
 #ifdef CONFIG_FS_EXT_ATTR
 
-#ifdef CONFIG_FS_POSIX_ACL
+#if 0 /* was a broken check for Posix ACLs */
 /* Posix ACL code changes i_mode without using a notify_change (or
  * a mark_inode_dirty!). We need to duplicate this at the reintegrator
  * which is done by this function. This function also takes care of 
@@ -2395,7 +2395,7 @@
                 goto exit;
         }
 
-#ifdef CONFIG_FS_POSIX_ACL
+#if 0 /* was a broken check for Posix ACLs */
         /* Reset mode if specified*/
         /* XXX: when we do native acl support, move this code out! */
         if (mode != NULL) {
