Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVCZODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVCZODq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVCZODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:03:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:661 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262074AbVCZOAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:00:17 -0500
Date: Sat, 26 Mar 2005 15:02:17 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][4/6] cifs: inode.c cleanup - kfree
Message-ID: <Pine.LNX.4.62.0503261501240.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant NULL pointer checks before calling kfree()

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/inode.c.with_patch3	2005-03-26 13:53:26.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 14:17:01.000000000 +0100
@@ -222,8 +222,7 @@ int cifs_get_inode_info(struct inode **p
 				    + strnlen(search_path, MAX_PATHCONF) + 1,
 				    GFP_KERNEL);
 			if (tmp_path == NULL) {
-				if (buf)
-					kfree(buf);
+				kfree(buf);
 				return -ENOMEM;
 			}
 
@@ -235,8 +234,7 @@ int cifs_get_inode_info(struct inode **p
 			kfree(tmp_path);
 			/* BB fix up inode etc. */
 		} else if (rc) {
-			if (buf)
-				kfree(buf);
+			kfree(buf);
 			return rc;
 		}
 	} else {
@@ -352,8 +350,7 @@ int cifs_get_inode_info(struct inode **p
 					   inode->i_rdev);
 		}
 	}
-	if (buf)
-	    kfree(buf);
+	kfree(buf);
 	return rc;
 }
 
@@ -495,8 +492,7 @@ int cifs_unlink(struct inode *inode, str
 	cifsInode = CIFS_I(inode);
 	cifsInode->time = 0;	/* force revalidate of dir as well */
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
@@ -562,10 +558,8 @@ int cifs_mkdir(struct inode *inode, stru
 						 -1, -1, local_nls); */
 		}
 	}
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
-
 	return rc;
 }
 
@@ -607,8 +601,7 @@ int cifs_rmdir(struct inode *inode, stru
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
 		current_fs_time(inode->i_sb);
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
@@ -708,11 +701,8 @@ int cifs_rename(struct inode *source_ino
 	}
 
 cifs_rename_exit:
-	if (fromName)
-		kfree(fromName);
-	if (toName)
-		kfree(toName);
-
+	kfree(fromName);
+	kfree(toName);
 	FreeXid(xid);
 	return rc;
 }
@@ -762,8 +752,7 @@ int cifs_revalidate(struct dentry *diren
 		   lookupCacheEnabled) {
 		if ((S_ISREG(direntry->d_inode->i_mode) == 0) ||
 		    (direntry->d_inode->i_nlink == 1)) {
-			if (full_path)
-				kfree(full_path);
+			kfree(full_path);
 			FreeXid(xid);
 			return rc;
 		} else {
@@ -836,10 +825,8 @@ int cifs_revalidate(struct dentry *diren
 	}
 /*	up(&direntry->d_inode->i_sem); */
 	
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
-
 	return rc;
 }
 
@@ -1083,8 +1070,7 @@ int cifs_setattr(struct dentry *direntry
 	   that */
 	if (!rc)
 		rc = inode_setattr(direntry->d_inode, attrs);
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }

