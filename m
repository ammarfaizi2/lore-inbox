Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVCYV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVCYV0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVCYV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:26:35 -0500
Received: from mail.dif.dk ([193.138.115.101]:40115 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261800AbVCYVZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:25:51 -0500
Date: Fri, 25 Mar 2005 22:27:43 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove redundant kfree() NULL pointer checks in fs/jfs/
Message-ID: <Pine.LNX.4.62.0503252225260.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() can handle a NULL pointer, don't worry about passing it one.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/jfs/acl.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/jfs/acl.c	2005-03-25 21:40:49.000000000 +0100
@@ -70,8 +70,7 @@ static struct posix_acl *jfs_get_acl(str
 		if (!IS_ERR(acl))
 			*p_acl = posix_acl_dup(acl);
 	}
-	if (value)
-		kfree(value);
+	kfree(value);
 	return acl;
 }
 
@@ -112,8 +111,7 @@ static int jfs_set_acl(struct inode *ino
 	}
 	rc = __jfs_setxattr(inode, ea_name, value, size, 0);
 out:
-	if (value)
-		kfree(value);
+	kfree(value);
 
 	if (!rc) {
 		if (*p_acl && (*p_acl != JFS_ACL_NOT_CACHED))
--- linux-2.6.12-rc1-mm3-orig/fs/jfs/xattr.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/jfs/xattr.c	2005-03-25 21:43:13.000000000 +0100
@@ -946,8 +946,7 @@ int __jfs_setxattr(struct inode *inode, 
       out:
 	up_write(&JFS_IP(inode)->xattr_sem);
 
-	if (os2name)
-		kfree(os2name);
+	kfree(os2name);
 
 	return rc;
 }
@@ -1042,8 +1041,7 @@ ssize_t __jfs_getxattr(struct inode *ino
       out:
 	up_read(&JFS_IP(inode)->xattr_sem);
 
-	if (os2name)
-		kfree(os2name);
+	kfree(os2name);
 
 	return size;
 }


