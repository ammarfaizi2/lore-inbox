Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVDBWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVDBWyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDBWyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:54:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:58018 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261337AbVDBWxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:53:32 -0500
Date: Sun, 3 Apr 2005 00:55:46 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][4/7] cifs: dir.c cleanup - kfree()
Message-ID: <Pine.LNX.4.62.0504030054460.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant NULL pointer checks before kfree() in fs/cifs/dir.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch3	2005-04-03 00:02:22.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-03 00:02:24.000000000 +0200
@@ -321,12 +321,9 @@ int cifs_create(struct inode *inode, str
 		}
 	}
 
-	if (buf)
-	    kfree(buf);
-	if (full_path)
-	    kfree(full_path);
+	kfree(buf);
+	kfree(full_path);
 	FreeXid(xid);
-
 	return rc;
 }
 
@@ -377,10 +374,8 @@ int cifs_mknod(struct inode *inode, stru
 		}
 	}
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
-
 	return rc;
 }
 
@@ -450,8 +445,7 @@ struct dentry *cifs_lookup(struct inode 
 		   if file exists or not but no access BB */
 	}
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return ERR_PTR(rc);
 }
@@ -481,8 +475,7 @@ int cifs_dir_open(struct inode *inode, s
 
 	cFYI(1, ("inode = 0x%p and full path is %s", inode, full_path));
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
