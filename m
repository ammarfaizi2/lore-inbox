Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVDBW6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDBW6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDBW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:58:32 -0500
Received: from mail.dif.dk ([193.138.115.101]:1955 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261319AbVDBW4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:56:53 -0500
Date: Sun, 3 Apr 2005 00:59:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][7/7] cifs: dir.c cleanup - long lines 2
Message-ID: <Pine.LNX.4.62.0504030058040.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lines should be less than 80chars, rework cifs_create() a bit to fit more 
easily.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch6	2005-04-03 00:17:50.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-03 00:21:00.000000000 +0200
@@ -283,44 +283,45 @@ int cifs_create(struct inode *inode, str
 		} else if (newinode) {
 			pCifsFile = kmalloc(sizeof(struct cifsFileInfo),
 					    GFP_KERNEL);
+			if (!pCifsFile)
+				goto no_file;
 
-			if (pCifsFile) {
-				memset((char *)pCifsFile, 0,
-				       sizeof(struct cifsFileInfo));
-				pCifsFile->netfid = fileHandle;
-				pCifsFile->pid = current->tgid;
-				pCifsFile->pInode = newinode;
-				pCifsFile->invalidHandle = FALSE;
-				pCifsFile->closePend = FALSE;
-				init_MUTEX(&pCifsFile->fh_sem);
-				/* put the following in at open now */
-				/* pCifsFile->pfile = file; */ 
-				write_lock(&GlobalSMBSeslock);
-				list_add(&pCifsFile->tlist,
-					 &pTcon->openFileList);
-				pCifsInode = CIFS_I(newinode);
-				if (pCifsInode) {
-				/* if readable file instance put first in list
-				   */
-					if (write_only == TRUE) {
-                                        	list_add_tail(&pCifsFile->flist,
-							&pCifsInode->openFileList);
-					} else {
-						list_add(&pCifsFile->flist,
-							&pCifsInode->openFileList);
-					}
-					if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-						pCifsInode->clientCanCacheAll = TRUE;
-						pCifsInode->clientCanCacheRead = TRUE;
-						cFYI(1, ("Exclusive Oplock granted on inode %p",
-							newinode));
-					} else if ((oplock & 0xF) == OPLOCK_READ)
-						pCifsInode->clientCanCacheRead = TRUE;
-				}
-				write_unlock(&GlobalSMBSeslock);
+			memset((char *)pCifsFile, 0,
+			       sizeof(struct cifsFileInfo));
+			pCifsFile->netfid = fileHandle;
+			pCifsFile->pid = current->tgid;
+			pCifsFile->pInode = newinode;
+			pCifsFile->invalidHandle = FALSE;
+			pCifsFile->closePend = FALSE;
+			init_MUTEX(&pCifsFile->fh_sem);
+			/* put the following in at open now */
+			/* pCifsFile->pfile = file; */ 
+			write_lock(&GlobalSMBSeslock);
+			list_add(&pCifsFile->tlist, &pTcon->openFileList);
+			pCifsInode = CIFS_I(newinode);
+			if (!pCifsInode)
+				goto no_inode;
+
+			/* if readable file instance put first in list */
+			if (write_only == TRUE) {
+				list_add_tail(&pCifsFile->flist,
+					      &pCifsInode->openFileList);
+			} else {
+				list_add(&pCifsFile->flist,
+					 &pCifsInode->openFileList);
 			}
+			if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
+				pCifsInode->clientCanCacheAll = TRUE;
+				pCifsInode->clientCanCacheRead = TRUE;
+				cFYI(1, ("Exclusive Oplock granted on inode"
+					 " %p", newinode));
+			} else if ((oplock & 0xF) == OPLOCK_READ)
+				pCifsInode->clientCanCacheRead = TRUE;
+no_inode:
+			write_unlock(&GlobalSMBSeslock);
 		}
 	}
+no_file:
 
 	kfree(buf);
 	kfree(full_path);
