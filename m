Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVCNEBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVCNEBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVCNEBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:01:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:45285 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261865AbVCND4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:56:48 -0500
Date: Mon, 14 Mar 2005 04:58:02 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Domen Puncer <domen@coderock.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org
Subject: [PATCH][-mm][1/2] cifs: whitespace cleanups for file.c
Message-ID: <Pine.LNX.4.62.0503140443520.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steven,

Here's the first of two patches with cleanups for fs/cifs/file.c

This one contains more or less the changes in the whitespace patch I've 
send you previously. There shouldn't be any major controversial changes in 
this one, and I've cut it against current -mm as requested.
It changes 'if()' into 'if ()'. Gets rid of extra blank lines. Changes 
function definitions so they have their return type on the same line as 
the function name and breaks the argument lists so that they fit in the 
first 80 columns of text. Make some comments look a bit nicer. Makes sure 
there are spaces after ',' between function arguments, and a few other 
similar things.

Please note that I have no machines available at the moment that I can 
actually test cifs against, so the only testing this patch has seen has 
been me eyeballing the changes and checking that the patched file compiles 
cleanly.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm3-orig/fs/cifs/file.c linux-2.6.11-mm3/fs/cifs/file.c
--- linux-2.6.11-mm3-orig/fs/cifs/file.c	2005-03-13 00:52:43.000000000 +0100
+++ linux-2.6.11-mm3/fs/cifs/file.c	2005-03-13 16:40:07.000000000 +0100
@@ -35,8 +35,7 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 
-int
-cifs_open(struct inode *inode, struct file *file)
+int cifs_open(struct inode *inode, struct file *file)
 {
 	int rc = -EACCES;
 	int xid, oplock;
@@ -44,12 +43,12 @@ cifs_open(struct inode *inode, struct fi
 	struct cifsTconInfo *pTcon;
 	struct cifsFileInfo *pCifsFile;
 	struct cifsInodeInfo *pCifsInode;
-	struct list_head * tmp;
+	struct list_head *tmp;
 	char *full_path = NULL;
 	int desiredAccess = 0x20197;
 	int disposition;
 	__u16 netfid;
-	FILE_ALL_INFO * buf = NULL;
+	FILE_ALL_INFO *buf = NULL;
 
 	xid = GetXid();
 
@@ -61,8 +60,8 @@ cifs_open(struct inode *inode, struct fi
 		pCifsInode = CIFS_I(file->f_dentry->d_inode);
 		read_lock(&GlobalSMBSeslock);
 		list_for_each(tmp, &pCifsInode->openFileList) {            
-			pCifsFile = list_entry(tmp,struct cifsFileInfo, flist);           
-			if((pCifsFile->pfile == NULL)&& (pCifsFile->pid == current->tgid)){
+			pCifsFile = list_entry(tmp, struct cifsFileInfo, flist);           
+			if ((pCifsFile->pfile == NULL) && (pCifsFile->pid == current->tgid)) {
 			/* mode set in cifs_create */
 				pCifsFile->pfile = file; /* needed for writepage */
 				file->private_data = pCifsFile;
@@ -70,25 +69,25 @@ cifs_open(struct inode *inode, struct fi
 			}
 		}
 		read_unlock(&GlobalSMBSeslock);
-		if(file->private_data != NULL) {
+		if (file->private_data != NULL) {
 			rc = 0;
 			FreeXid(xid);
 			return rc;
 		} else {
-			if(file->f_flags & O_EXCL)
-				cERROR(1,("could not find file instance for new file %p ",file));
+			if (file->f_flags & O_EXCL)
+				cERROR(1, ("could not find file instance for new file %p ", file));
 		}
 	}
 
 	down(&inode->i_sb->s_vfs_rename_sem);
 	full_path = build_path_from_dentry(file->f_dentry);
 	up(&inode->i_sb->s_vfs_rename_sem);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
 
-	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s", inode, file->f_flags,full_path));
+	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s", inode, file->f_flags, full_path));
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		desiredAccess = GENERIC_READ;
 	else if ((file->f_flags & O_ACCMODE) == O_WRONLY)
@@ -124,11 +123,11 @@ cifs_open(struct inode *inode, struct fi
  *	 O_FASYNC, O_NOFOLLOW, O_NONBLOCK need further investigation
  *********************************************************************/
 
-	if((file->f_flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+	if ((file->f_flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 		disposition = FILE_CREATE;
-	else if((file->f_flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
+	else if ((file->f_flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
 		disposition = FILE_OVERWRITE_IF;
-	else if((file->f_flags & O_CREAT) == O_CREAT)
+	else if ((file->f_flags & O_CREAT) == O_CREAT)
 		disposition = FILE_OPEN_IF;
 	else
 		disposition = FILE_OPEN;
@@ -147,8 +146,8 @@ cifs_open(struct inode *inode, struct fi
 	/* BB we can not do this if this is the second open of a file 
 	and the first handle has writebehind data, we might be 
 	able to simply do a filemap_fdatawrite/filemap_fdatawait first */
-	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-	if(buf== NULL) {
+	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
+	if (buf == NULL) {
 		if (full_path)
 			kfree(full_path);
 		FreeXid(xid);
@@ -161,88 +160,89 @@ cifs_open(struct inode *inode, struct fi
 		cFYI(1, ("oplock: %d ", oplock));	
 	} else {
 		file->private_data =
-			kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
+			kmalloc(sizeof(struct cifsFileInfo), GFP_KERNEL);
 		if (file->private_data) {
 			memset(file->private_data, 0, sizeof(struct cifsFileInfo));
-			pCifsFile = (struct cifsFileInfo *) file->private_data;
+			pCifsFile = (struct cifsFileInfo *)file->private_data;
 			pCifsFile->netfid = netfid;
 			pCifsFile->pid = current->tgid;
 			init_MUTEX(&pCifsFile->fh_sem);
 			pCifsFile->pfile = file; /* needed for writepage */
 			pCifsFile->pInode = inode;
 			pCifsFile->invalidHandle = FALSE;
-			pCifsFile->closePend     = FALSE;
+			pCifsFile->closePend = FALSE;
 			write_lock(&file->f_owner.lock);
 			write_lock(&GlobalSMBSeslock);
-			list_add(&pCifsFile->tlist,&pTcon->openFileList);
+			list_add(&pCifsFile->tlist, &pTcon->openFileList);
 			pCifsInode = CIFS_I(file->f_dentry->d_inode);
-			if(pCifsInode) {
+			if (pCifsInode) {
 				/* want handles we can use to read with first */
 				/* in the list so we do not have to walk the */
 				/* list to search for one in prepare_write */
 				if ((file->f_flags & O_ACCMODE) == O_WRONLY) {
-					list_add_tail(&pCifsFile->flist,&pCifsInode->openFileList);
+					list_add_tail(&pCifsFile->flist, &pCifsInode->openFileList);
 				} else {
-					list_add(&pCifsFile->flist,&pCifsInode->openFileList);
+					list_add(&pCifsFile->flist, &pCifsInode->openFileList);
 				}
 				write_unlock(&GlobalSMBSeslock);
 				write_unlock(&file->f_owner.lock);
-				if(pCifsInode->clientCanCacheRead) {
+				if (pCifsInode->clientCanCacheRead) {
 					/* we have the inode open somewhere else
 					   no need to discard cache data */
 				} else {
-					if(buf) {
+					if (buf) {
 					/* BB need same check in cifs_create too? */
 
 					/* if not oplocked, invalidate inode pages if mtime 
 					   or file size changed */
 						struct timespec temp;
 						temp = cifs_NTtimeToUnix(le64_to_cpu(buf->LastWriteTime));
-						if(timespec_equal(&file->f_dentry->d_inode->i_mtime,&temp) && 
+						if (timespec_equal(&file->f_dentry->d_inode->i_mtime, &temp) && 
 							(file->f_dentry->d_inode->i_size == (loff_t)le64_to_cpu(buf->EndOfFile))) {
-							cFYI(1,("inode unchanged on server"));
+							cFYI(1, ("inode unchanged on server"));
 						} else {
-							if(file->f_dentry->d_inode->i_mapping) {
+							if (file->f_dentry->d_inode->i_mapping) {
 							/* BB no need to lock inode until after invalidate*/
 							/* since namei code should already have it locked?*/
 								filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
 								filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
 							}
-							cFYI(1,("invalidating remote inode since open detected it changed"));
+							cFYI(1, ("invalidating remote inode since open detected it changed"));
 							invalidate_remote_inode(file->f_dentry->d_inode);
 						}
 					}
 				}
 				if (pTcon->ses->capabilities & CAP_UNIX)
 					rc = cifs_get_inode_info_unix(&file->f_dentry->d_inode,
-						full_path, inode->i_sb,xid);
+						full_path, inode->i_sb, xid);
 				else
 					rc = cifs_get_inode_info(&file->f_dentry->d_inode,
-						full_path, buf, inode->i_sb,xid);
+						full_path, buf, inode->i_sb, xid);
 
-				if((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
+				if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
 					pCifsInode->clientCanCacheAll = TRUE;
 					pCifsInode->clientCanCacheRead = TRUE;
-					cFYI(1,("Exclusive Oplock granted on inode %p",file->f_dentry->d_inode));
-				} else if((oplock & 0xF) == OPLOCK_READ)
+					cFYI(1, ("Exclusive Oplock granted on inode %p", file->f_dentry->d_inode));
+				} else if ((oplock & 0xF) == OPLOCK_READ)
 					pCifsInode->clientCanCacheRead = TRUE;
 			} else {
 				write_unlock(&GlobalSMBSeslock);
 				write_unlock(&file->f_owner.lock);
 			}
-			if(oplock & CIFS_CREATE_ACTION) {           
+			if (oplock & CIFS_CREATE_ACTION) {           
 				/* time to set mode which we can not set earlier due
 				 to problems creating new read-only files */
-				if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)                
+				if (cifs_sb->tcon->ses->capabilities & CAP_UNIX) {
 					CIFSSMBUnixSetPerms(xid, pTcon, full_path, inode->i_mode,
 						(__u64)-1, 
 						(__u64)-1,
 						0 /* dev */,
 						cifs_sb->local_nls);
-				else {/* BB implement via Windows security descriptors */
-			/* eg CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,-1,-1,local_nls);*/
-			/* in the meantime could set r/o dos attribute when perms are eg:
-					mode & 0222 == 0 */
+				} else {
+					/* BB implement via Windows security descriptors eg */
+					/* CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, -1, -1, local_nls); */
+					/* in the meantime could set r/o dos attribute when perms are eg: */
+					/* mode & 0222 == 0 */
 				}
 			}
 		}
@@ -258,7 +258,7 @@ cifs_open(struct inode *inode, struct fi
 
 /* Try to reaquire byte range locks that were released when session */
 /* to server was lost */
-static int cifs_relock_file(struct cifsFileInfo * cifsFile)
+static int cifs_relock_file(struct cifsFileInfo *cifsFile)
 {
 	int rc = 0;
 
@@ -267,7 +267,8 @@ static int cifs_relock_file(struct cifsF
 	return rc;
 }
 
-static int cifs_reopen_file(struct inode *inode, struct file *file, int can_flush)
+static int cifs_reopen_file(struct inode *inode, struct file *file, 
+	int can_flush)
 {
 	int rc = -EACCES;
 	int xid, oplock;
@@ -280,24 +281,24 @@ static int cifs_reopen_file(struct inode
 	int disposition = FILE_OPEN;
 	__u16 netfid;
 
-	if(inode == NULL)
+	if (inode == NULL)
 		return -EBADF;
 	if (file->private_data) {
-		pCifsFile = (struct cifsFileInfo *) file->private_data;
+		pCifsFile = (struct cifsFileInfo *)file->private_data;
 	} else
 		return -EBADF;
 
 	xid = GetXid();
 	down(&pCifsFile->fh_sem);
-	if(pCifsFile->invalidHandle == FALSE) {
+	if (pCifsFile->invalidHandle == FALSE) {
 		up(&pCifsFile->fh_sem);
 		FreeXid(xid);
 		return 0;
 	}
 
-	if(file->f_dentry == NULL) {
+	if (file->f_dentry == NULL) {
 		up(&pCifsFile->fh_sem);
-		cFYI(1,("failed file reopen, no valid name if dentry freed"));
+		cFYI(1, ("failed file reopen, no valid name if dentry freed"));
 		FreeXid(xid);
 		return -EBADF;
 	}
@@ -308,7 +309,7 @@ those that already have the rename sem c
 to get called and if the server was down that means we end up here,
 and we can never tell if the caller already has the rename_sem */
 	full_path = build_path_from_dentry(file->f_dentry);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		up(&pCifsFile->fh_sem);
 		FreeXid(xid);
 		return -ENOMEM;
@@ -338,14 +339,14 @@ and we can never tell if the caller alre
 	 and server version of file size can be stale. If we 
 	 knew for sure that inode was not dirty locally we could do this */
 
-/*	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-	if(buf==0) {
+/*	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
+	if (buf == 0) {
 		up(&pCifsFile->fh_sem);
 		if (full_path)
 			kfree(full_path);
 		FreeXid(xid);
 		return -ENOMEM;
-	}*/
+	} */
 	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,
 				CREATE_NOT_DIR, &netfid, &oplock, NULL, cifs_sb->local_nls);
 	if (rc) {
@@ -357,8 +358,8 @@ and we can never tell if the caller alre
 		pCifsFile->invalidHandle = FALSE;
 		up(&pCifsFile->fh_sem);
 		pCifsInode = CIFS_I(inode);
-		if(pCifsInode) {
-			if(can_flush) {
+		if (pCifsInode) {
+			if (can_flush) {
 				filemap_fdatawrite(inode->i_mapping);
 				filemap_fdatawait(inode->i_mapping);
 			/* temporarily disable caching while we
@@ -367,26 +368,26 @@ and we can never tell if the caller alre
 				pCifsInode->clientCanCacheRead = FALSE;
 				if (pTcon->ses->capabilities & CAP_UNIX)
 					rc = cifs_get_inode_info_unix(&inode,
-						full_path, inode->i_sb,xid);
+						full_path, inode->i_sb, xid);
 				else
 					rc = cifs_get_inode_info(&inode,
-						full_path, NULL, inode->i_sb,xid);
+						full_path, NULL, inode->i_sb, xid);
 			} /* else we are writing out data to server already
 			and could deadlock if we tried to flush data, and 
 			since we do not know if we have data that would
 			invalidate the current end of file on the server
 			we can not go to the server to get the new
 			inod info */
-			if((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-				pCifsInode->clientCanCacheAll =  TRUE;
+			if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
+				pCifsInode->clientCanCacheAll = TRUE;
 				pCifsInode->clientCanCacheRead = TRUE;
-				cFYI(1,("Exclusive Oplock granted on inode %p",file->f_dentry->d_inode));
-			} else if((oplock & 0xF) == OPLOCK_READ) {
+				cFYI(1, ("Exclusive Oplock granted on inode %p", file->f_dentry->d_inode));
+			} else if ((oplock & 0xF) == OPLOCK_READ) {
 				pCifsInode->clientCanCacheRead = TRUE;
-				pCifsInode->clientCanCacheAll =  FALSE;
+				pCifsInode->clientCanCacheAll = FALSE;
 			} else {
 				pCifsInode->clientCanCacheRead = FALSE;
-				pCifsInode->clientCanCacheAll =  FALSE;
+				pCifsInode->clientCanCacheAll = FALSE;
 			}
 			cifs_relock_file(pCifsFile);
 		}
@@ -398,63 +399,61 @@ and we can never tell if the caller alre
 	return rc;
 }
 
-int
-cifs_close(struct inode *inode, struct file *file)
+int cifs_close(struct inode *inode, struct file *file)
 {
 	int rc = 0;
 	int xid;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	struct cifsFileInfo *pSMBFile =
-		(struct cifsFileInfo *) file->private_data;
+		(struct cifsFileInfo *)file->private_data;
 
 	xid = GetXid();
 
 	cifs_sb = CIFS_SB(inode->i_sb);
 	pTcon = cifs_sb->tcon;
 	if (pSMBFile) {
-		pSMBFile->closePend    = TRUE;
+		pSMBFile->closePend = TRUE;
 		write_lock(&file->f_owner.lock);
-		if(pTcon) {
+		if (pTcon) {
 			/* no sense reconnecting to close a file that is
 				already closed */
 			if (pTcon->tidStatus != CifsNeedReconnect) {
 				write_unlock(&file->f_owner.lock);
-				rc = CIFSSMBClose(xid,pTcon,pSMBFile->netfid);
+				rc = CIFSSMBClose(xid, pTcon, pSMBFile->netfid);
 				write_lock(&file->f_owner.lock);
 			}
 		}
 		list_del(&pSMBFile->flist);
 		list_del(&pSMBFile->tlist);
 		write_unlock(&file->f_owner.lock);
-		if(pSMBFile->search_resume_name)
+		if (pSMBFile->search_resume_name)
 			kfree(pSMBFile->search_resume_name);
 		kfree(file->private_data);
 		file->private_data = NULL;
 	} else
 		rc = -EBADF;
 
-	if(list_empty(&(CIFS_I(inode)->openFileList))) {
-		cFYI(1,("closing last open instance for inode %p",inode));
+	if (list_empty(&(CIFS_I(inode)->openFileList))) {
+		cFYI(1, ("closing last open instance for inode %p", inode));
 		/* if the file is not open we do not know if we can cache
 		info on this inode, much less write behind and read ahead */
 		CIFS_I(inode)->clientCanCacheRead = FALSE;
 		CIFS_I(inode)->clientCanCacheAll  = FALSE;
 	}
-	if((rc ==0) && CIFS_I(inode)->write_behind_rc)
+	if ((rc ==0) && CIFS_I(inode)->write_behind_rc)
 		rc = CIFS_I(inode)->write_behind_rc;
 	FreeXid(xid);
 	return rc;
 }
 
-int
-cifs_closedir(struct inode *inode, struct file *file)
+int cifs_closedir(struct inode *inode, struct file *file)
 {
 	int rc = 0;
 	int xid;
 	struct cifsFileInfo *pCFileStruct =
-	    (struct cifsFileInfo *) file->private_data;
-	char * ptmp;
+	    (struct cifsFileInfo *)file->private_data;
+	char *ptmp;
 
 	cFYI(1, ("Closedir inode = 0x%p with ", inode));
 
@@ -462,27 +461,27 @@ cifs_closedir(struct inode *inode, struc
 
 	if (pCFileStruct) {
 		struct cifsTconInfo *pTcon;
-		struct cifs_sb_info * cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+		struct cifs_sb_info *cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 
 		pTcon = cifs_sb->tcon;
 
 		cFYI(1, ("Freeing private data in close dir"));
-		if(pCFileStruct->srch_inf.endOfSearch == FALSE) {
+		if (pCFileStruct->srch_inf.endOfSearch == FALSE) {
 			pCFileStruct->invalidHandle = TRUE;
 			rc = CIFSFindClose(xid, pTcon, pCFileStruct->netfid);
-			cFYI(1,("Closing uncompleted readdir with rc %d",rc));
+			cFYI(1, ("Closing uncompleted readdir with rc %d", rc));
 			/* not much we can do if it fails anywway, ignore rc */
 			rc = 0;
 		}
 		ptmp = pCFileStruct->srch_inf.ntwrk_buf_start;
-		if(ptmp) {
-			cFYI(1,("freeing smb buf in srch struct in closedir")); /* BB removeme BB */
+		if (ptmp) {
+			cFYI(1, ("freeing smb buf in srch struct in closedir")); /* BB removeme BB */
 			pCFileStruct->srch_inf.ntwrk_buf_start = NULL;
 			cifs_buf_release(ptmp);
 		}
 		ptmp = pCFileStruct->search_resume_name;
-		if(ptmp) {
-			cFYI(1,("freeing resume name in closedir")); /* BB removeme BB */
+		if (ptmp) {
+			cFYI(1, ("freeing resume name in closedir")); /* BB removeme BB */
 			pCFileStruct->search_resume_name = NULL;
 			kfree(ptmp);
 		}
@@ -494,8 +493,7 @@ cifs_closedir(struct inode *inode, struc
 	return rc;
 }
 
-int
-cifs_lock(struct file *file, int cmd, struct file_lock *pfLock)
+int cifs_lock(struct file *file, int cmd, struct file_lock *pfLock)
 {
 	int rc, xid;
 	__u32 lockType = LOCKING_ANDX_LARGE_FILES;
@@ -505,10 +503,9 @@ cifs_lock(struct file *file, int cmd, st
 	int wait_flag = FALSE;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
-	length = 1 + pfLock->fl_end - pfLock->fl_start;
 
+	length = 1 + pfLock->fl_end - pfLock->fl_start;
 	rc = -EACCES;
-
 	xid = GetXid();
 
 	cFYI(1,
@@ -529,7 +526,7 @@ cifs_lock(struct file *file, int cmd, st
 	if (pfLock->fl_flags & FL_LEASE)
 		cFYI(1, ("Lease on file - not implemented yet"));
 	if (pfLock->fl_flags & (~(FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS | FL_LEASE)))
-		cFYI(1, ("Unknown lock flags 0x%x",pfLock->fl_flags));
+		cFYI(1, ("Unknown lock flags 0x%x", pfLock->fl_flags));
 
 	if (pfLock->fl_type == F_WRLCK) {
 		cFYI(1, ("F_WRLCK "));
@@ -561,7 +558,7 @@ cifs_lock(struct file *file, int cmd, st
 
 	if (IS_GETLK(cmd)) {
 		rc = CIFSSMBLock(xid, pTcon,
-				 ((struct cifsFileInfo *) file->
+				 ((struct cifsFileInfo *)file->
 				  private_data)->netfid,
 				 length,
 				 pfLock->fl_start, 0, 1, lockType,
@@ -601,9 +598,8 @@ cifs_lock(struct file *file, int cmd, st
 	return rc;
 }
 
-ssize_t
-cifs_user_write(struct file * file, const char __user * write_data,
-	   size_t write_size, loff_t * poffset)
+ssize_t cifs_user_write(struct file *file, const char __user *write_data,
+	size_t write_size, loff_t *poffset)
 {
 	int rc = 0;
 	unsigned int bytes_written = 0;
@@ -611,29 +607,28 @@ cifs_user_write(struct file * file, cons
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int xid, long_op;
-	struct cifsFileInfo * open_file;
+	struct cifsFileInfo *open_file;
 
-	if(file->f_dentry == NULL)
+	if (file->f_dentry == NULL)
 		return -EBADF;
 
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
-	if(cifs_sb == NULL) {
+	if (cifs_sb == NULL)
 		return -EBADF;
-	}
+
 	pTcon = cifs_sb->tcon;
 
-	/*cFYI(1,
+	/* cFYI(1,
 	   (" write %d bytes to offset %lld of %s", write_size,
 	   *poffset, file->f_dentry->d_name.name)); */
 
-	if (file->private_data == NULL) {
+	if (file->private_data == NULL)
 		return -EBADF;
-	} else {
+	else
 		open_file = (struct cifsFileInfo *) file->private_data;
-	}
 	
 	xid = GetXid();
-	if(file->f_dentry->d_inode == NULL) {
+	if (file->f_dentry->d_inode == NULL) {
 		FreeXid(xid);
 		return -EBADF;
 	}
@@ -646,8 +641,8 @@ cifs_user_write(struct file * file, cons
 	for (total_written = 0; write_size > total_written;
 	     total_written += bytes_written) {
 		rc = -EAGAIN;
-		while(rc == -EAGAIN) {
-			if(file->private_data == NULL) {
+		while (rc == -EAGAIN) {
+			if (file->private_data == NULL) {
 				/* file has been closed on us */
 				FreeXid(xid);
 			/* if we have gotten here we have written some data
@@ -655,16 +650,16 @@ cifs_user_write(struct file * file, cons
 			while we blocked so return what we managed to write */
 				return total_written;
 			} 
-			if(open_file->closePend) {
+			if (open_file->closePend) {
 				FreeXid(xid);
-				if(total_written)
+				if (total_written)
 					return total_written;
 				else
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if((file->f_dentry == NULL) ||
-				   (file->f_dentry->d_inode == NULL)) {
+				if ((file->f_dentry == NULL) ||
+				    (file->f_dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
 				}
@@ -672,14 +667,14 @@ cifs_user_write(struct file * file, cons
 				 filemap_fdatawait from here so tell
 				reopen_file not to flush data to server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file,FALSE);
-				if(rc != 0)
+					file, FALSE);
+				if (rc != 0)
 					break;
 			}
 
 			rc = CIFSSMBWrite(xid, pTcon,
 				open_file->netfid,
-				min_t(const int,cifs_sb->wsize,write_size - total_written),
+				min_t(const int, cifs_sb->wsize, write_size - total_written),
 				*poffset, &bytes_written,
 				NULL, write_data + total_written, long_op);
 		}
@@ -696,7 +691,7 @@ cifs_user_write(struct file * file, cons
 	}
 
 #ifdef CONFIG_CIFS_STATS
-	if(total_written > 0) {
+	if (total_written > 0) {
 		atomic_inc(&pTcon->num_writes);
 		spin_lock(&pTcon->stat_lock);
 		pTcon->bytes_written += total_written;
@@ -705,8 +700,8 @@ cifs_user_write(struct file * file, cons
 #endif		
 
 	/* since the write may have blocked check these pointers again */
-	if(file->f_dentry) {
-		if(file->f_dentry->d_inode) {
+	if (file->f_dentry) {
+		if (file->f_dentry->d_inode) {
 			struct inode *inode = file->f_dentry->d_inode;
 			inode->i_ctime = inode->i_mtime =
 				current_fs_time(inode->i_sb);
@@ -721,9 +716,8 @@ cifs_user_write(struct file * file, cons
 	return total_written;
 }
 
-static ssize_t
-cifs_write(struct file * file, const char *write_data,
-	   size_t write_size, loff_t * poffset)
+static ssize_t cifs_write(struct file *file, const char *write_data,
+	size_t write_size, loff_t *poffset)
 {
 	int rc = 0;
 	unsigned int bytes_written = 0;
@@ -731,29 +725,28 @@ cifs_write(struct file * file, const cha
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int xid, long_op;
-	struct cifsFileInfo * open_file;
+	struct cifsFileInfo *open_file;
 
-	if(file->f_dentry == NULL)
+	if (file->f_dentry == NULL)
 		return -EBADF;
 
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
-	if(cifs_sb == NULL) {
+	if (cifs_sb == NULL)
 		return -EBADF;
-	}
+
 	pTcon = cifs_sb->tcon;
 
-	/*cFYI(1,
+	/* cFYI(1,
 	   (" write %d bytes to offset %lld of %s", write_size,
 	   *poffset, file->f_dentry->d_name.name)); */
 
-	if (file->private_data == NULL) {
+	if (file->private_data == NULL)
 		return -EBADF;
-	} else {
-		open_file = (struct cifsFileInfo *) file->private_data;
-	}
+	else
+		open_file = (struct cifsFileInfo *)file->private_data;
 	
 	xid = GetXid();
-	if(file->f_dentry->d_inode == NULL) {
+	if (file->f_dentry->d_inode == NULL) {
 		FreeXid(xid);
 		return -EBADF;
 	}
@@ -766,41 +759,41 @@ cifs_write(struct file * file, const cha
 	for (total_written = 0; write_size > total_written;
 	     total_written += bytes_written) {
 		rc = -EAGAIN;
-		while(rc == -EAGAIN) {
-			if(file->private_data == NULL) {
+		while (rc == -EAGAIN) {
+			if (file->private_data == NULL) {
 				/* file has been closed on us */
 				FreeXid(xid);
 			/* if we have gotten here we have written some data
-			and blocked, and the file has been freed on us
-			while we blocked so return what we managed to write */
+			   and blocked, and the file has been freed on us
+			   while we blocked so return what we managed to write */
 				return total_written;
 			} 
-			if(open_file->closePend) {
+			if (open_file->closePend) {
 				FreeXid(xid);
-				if(total_written)
+				if (total_written)
 					return total_written;
 				else
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if((file->f_dentry == NULL) ||
+				if ((file->f_dentry == NULL) ||
 				   (file->f_dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
 				}
 				/* we could deadlock if we called
-				 filemap_fdatawait from here so tell
-				reopen_file not to flush data to server now */
+				   filemap_fdatawait from here so tell
+				   reopen_file not to flush data to server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file,FALSE);
-				if(rc != 0)
+					file, FALSE);
+				if (rc != 0)
 					break;
 			}
 
 			rc = CIFSSMBWrite(xid, pTcon,
 				 open_file->netfid,
-				 min_t(const int,cifs_sb->wsize,write_size - total_written),
-				 *poffset,&bytes_written,
+				 min_t(const int, cifs_sb->wsize, write_size - total_written),
+				 *poffset, &bytes_written,
 				 write_data + total_written, NULL, long_op);
 		}
 		if (rc || (bytes_written == 0)) {
@@ -816,7 +809,7 @@ cifs_write(struct file * file, const cha
 	}
 
 #ifdef CONFIG_CIFS_STATS
-	if(total_written > 0) {
+	if (total_written > 0) {
 		atomic_inc(&pTcon->num_writes);
 		spin_lock(&pTcon->stat_lock);
 		pTcon->bytes_written += total_written;
@@ -825,10 +818,10 @@ cifs_write(struct file * file, const cha
 #endif		
 
 	/* since the write may have blocked check these pointers again */
-	if(file->f_dentry) {
-		if(file->f_dentry->d_inode) {
-			file->f_dentry->d_inode->i_ctime = file->f_dentry->d_inode->i_mtime =
-				CURRENT_TIME;
+	if (file->f_dentry) {
+		if (file->f_dentry->d_inode) {
+			file->f_dentry->d_inode->i_ctime = 
+			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
 			if (total_written > 0) {
 				if (*poffset > file->f_dentry->d_inode->i_size)
 					i_size_write(file->f_dentry->d_inode, *poffset);
@@ -840,12 +833,11 @@ cifs_write(struct file * file, const cha
 	return total_written;
 }
 
-static int
-cifs_partialpagewrite(struct page *page,unsigned from, unsigned to)
+static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 {
 	struct address_space *mapping = page->mapping;
 	loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
-	char * write_data;
+	char *write_data;
 	int rc = -EFAULT;
 	int bytes_written = 0;
 	struct cifs_sb_info *cifs_sb;
@@ -856,11 +848,10 @@ cifs_partialpagewrite(struct page *page,
 	struct list_head *tmp;
 	struct list_head *tmp1;
 
-	if (!mapping) {
+	if (!mapping)
 		return -EFAULT;
-	} else if(!mapping->host) {
+	else if (!mapping->host)
 		return -EFAULT;
-	}
 
 	inode = page->mapping->host;
 	cifs_sb = CIFS_SB(inode->i_sb);
@@ -870,19 +861,19 @@ cifs_partialpagewrite(struct page *page,
 	write_data = kmap(page);
 	write_data += from;
 
-	if((to > PAGE_CACHE_SIZE) || (from > to)) {
+	if ((to > PAGE_CACHE_SIZE) || (from > to)) {
 		kunmap(page);
 		return -EIO;
 	}
 
 	/* racing with truncate? */
-	if(offset > mapping->host->i_size) {
+	if (offset > mapping->host->i_size) {
 		kunmap(page);
 		return 0; /* don't care */
 	}
 
 	/* check to make sure that we are not extending the file */
-	if(mapping->host->i_size - offset < (loff_t)to)
+	if (mapping->host->i_size - offset < (loff_t)to)
 		to = (unsigned)(mapping->host->i_size - offset); 
 		
 
@@ -890,11 +881,11 @@ cifs_partialpagewrite(struct page *page,
 	read_lock(&GlobalSMBSeslock); 
 	/* BB we should start at the end */
 	list_for_each_safe(tmp, tmp1, &cifsInode->openFileList) {            
-		open_file = list_entry(tmp,struct cifsFileInfo, flist);
-		if(open_file->closePend)
+		open_file = list_entry(tmp, struct cifsFileInfo, flist);
+		if (open_file->closePend)
 			continue;
 		/* We check if file is open for writing first */
-		if((open_file->pfile) && 
+		if ((open_file->pfile) && 
 		   ((open_file->pfile->f_flags & O_RDWR) || 
 			(open_file->pfile->f_flags & O_WRONLY))) {
 			read_unlock(&GlobalSMBSeslock);
@@ -905,8 +896,8 @@ cifs_partialpagewrite(struct page *page,
 			inode->i_atime = inode->i_mtime = current_fs_time(inode->i_sb);
 			if ((bytes_written > 0) && (offset)) {
 				rc = 0;
-			} else if(bytes_written < 0) {
-				if(rc == -EBADF) {
+			} else if (bytes_written < 0) {
+				if (rc == -EBADF) {
 				/* have seen a case in which
 				kernel seemed to have closed/freed a file
 				even with writes active so we might as well
@@ -920,14 +911,14 @@ cifs_partialpagewrite(struct page *page,
 				and tried to write to it we are done, no
 				sense continuing to loop looking for another */
 		}
-		if(tmp->next == NULL) {
-			cFYI(1,("File instance %p removed",tmp));
+		if (tmp->next == NULL) {
+			cFYI(1, ("File instance %p removed", tmp));
 			break;
 		}
 	}
 	read_unlock(&GlobalSMBSeslock);
-	if(open_file == NULL) {
-		cFYI(1,("No writeable filehandles for inode"));
+	if (open_file == NULL) {
+		cFYI(1, ("No writeable filehandles for inode"));
 		rc = -EIO;
 	}
 
@@ -936,25 +927,24 @@ cifs_partialpagewrite(struct page *page,
 }
 
 #if 0
-static int
-cifs_writepages(struct address_space *mapping, struct writeback_control *wbc)
+static int cifs_writepages(struct address_space *mapping,
+	struct writeback_control *wbc)
 {
 	int rc = -EFAULT;
 	int xid;
 
 	xid = GetXid();
 
-    /* Find contiguous pages then iterate through repeating */
-/* call 16K write then Setpageuptodate or if LARGE_WRITE_X
-support then send larger writes via kevec so as to eliminate
-a memcpy */
+	/* Find contiguous pages then iterate through repeating */
+	/* call 16K write then Setpageuptodate or if LARGE_WRITE_X */
+	/* support then send larger writes via kevec so as to eliminate */
+	/* a memcpy */
 	FreeXid(xid);
 	return rc;
 }
 #endif
 
-static int
-cifs_writepage(struct page* page, struct writeback_control *wbc)
+static int cifs_writepage(struct page* page, struct writeback_control *wbc)
 {
 	int rc = -EFAULT;
 	int xid;
@@ -963,10 +953,10 @@ cifs_writepage(struct page* page, struct
 /* BB add check for wbc flags */
 	page_cache_get(page);
         if (!PageUptodate(page)) {
-		cFYI(1,("ppw - page not up to date"));
+		cFYI(1, ("ppw - page not up to date"));
 	}
 	
-	rc = cifs_partialpagewrite(page,0,PAGE_CACHE_SIZE);
+	rc = cifs_partialpagewrite(page, 0, PAGE_CACHE_SIZE);
 	SetPageUptodate(page); /* BB add check for error and Clearuptodate? */
 	unlock_page(page);
 	page_cache_release(page);	
@@ -974,34 +964,33 @@ cifs_writepage(struct page* page, struct
 	return rc;
 }
 
-static int
-cifs_commit_write(struct file *file, struct page *page, unsigned offset,
-		  unsigned to)
+static int cifs_commit_write(struct file *file, struct page *page,
+	unsigned offset, unsigned to)
 {
 	int xid;
 	int rc = 0;
 	struct inode *inode = page->mapping->host;
 	loff_t position = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-	char * page_data;
+	char *page_data;
 
 	xid = GetXid();
-	cFYI(1,("commit write for page %p up to position %lld for %d",page,position,to));
-	if (position > inode->i_size){
+	cFYI(1, ("commit write for page %p up to position %lld for %d", page, position, to));
+	if (position > inode->i_size) {
 		i_size_write(inode, position);
-		/*if (file->private_data == NULL) {
+		/* if (file->private_data == NULL) {
 			rc = -EBADF;
 		} else {
 			open_file = (struct cifsFileInfo *)file->private_data;
 			cifs_sb = CIFS_SB(inode->i_sb);
 			rc = -EAGAIN;
-			while(rc == -EAGAIN) {
-				if((open_file->invalidHandle) && 
-				  (!open_file->closePend)) {
+			while (rc == -EAGAIN) {
+				if ((open_file->invalidHandle) && 
+				    (!open_file->closePend)) {
 					rc = cifs_reopen_file(file->f_dentry->d_inode,file);
-					if(rc != 0)
+					if (rc != 0)
 						break;
 				}
-				if(!open_file->closePend) {
+				if (!open_file->closePend) {
 					rc = CIFSSMBSetFileSize(xid, cifs_sb->tcon, 
 						position, open_file->netfid,
 						open_file->pid,FALSE);
@@ -1010,15 +999,15 @@ cifs_commit_write(struct file *file, str
 					break;
 				}
 			}
-			cFYI(1,(" SetEOF (commit write) rc = %d",rc));
-		}*/
+			cFYI(1, (" SetEOF (commit write) rc = %d", rc));
+		} */
 	}
 	if (!PageUptodate(page)) {
 		position =  ((loff_t)page->index << PAGE_CACHE_SHIFT) + offset;
 		/* can not rely on (or let) writepage write this data */
-		if(to < offset) {
-			cFYI(1,("Illegal offsets, can not copy from %d to %d",
-				offset,to));
+		if (to < offset) {
+			cFYI(1, ("Illegal offsets, can not copy from %d to %d",
+				offset, to));
 			FreeXid(xid);
 			return rc;
 		}
@@ -1029,9 +1018,9 @@ cifs_commit_write(struct file *file, str
 		/* BB check if anything else missing out of ppw */
 		/* such as updating last write time */
 		page_data = kmap(page);
-		rc = cifs_write(file, page_data+offset,to-offset,
-                                        &position);
-		if(rc > 0)
+		rc = cifs_write(file, page_data + offset, to-offset,
+				&position);
+		if (rc > 0)
 			rc = 0;
 		/* else if rc < 0 should we set writebehind rc? */
 		kunmap(page);
@@ -1043,12 +1032,11 @@ cifs_commit_write(struct file *file, str
 	return rc;
 }
 
-int
-cifs_fsync(struct file *file, struct dentry *dentry, int datasync)
+int cifs_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
 	int xid;
 	int rc = 0;
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_dentry->d_inode;
 
 	xid = GetXid();
 
@@ -1056,14 +1044,13 @@ cifs_fsync(struct file *file, struct den
 		dentry->d_name.name, datasync));
 	
 	rc = filemap_fdatawrite(inode->i_mapping);
-	if(rc == 0)
+	if (rc == 0)
 		CIFS_I(inode)->write_behind_rc = 0;
 	FreeXid(xid);
 	return rc;
 }
 
-/* static int
-cifs_sync_page(struct page *page)
+/* static int cifs_sync_page(struct page *page)
 {
 	struct address_space *mapping;
 	struct inode *inode;
@@ -1071,18 +1058,18 @@ cifs_sync_page(struct page *page)
 	unsigned int rpages = 0;
 	int rc = 0;
 
-	cFYI(1,("sync page %p",page));
+	cFYI(1, ("sync page %p",page));
 	mapping = page->mapping;
 	if (!mapping)
 		return 0;
 	inode = mapping->host;
 	if (!inode)
-		return 0;*/
+		return 0; */
 
 /*	fill in rpages then 
-    result = cifs_pagein_inode(inode, index, rpages); *//* BB finish */
+	result = cifs_pagein_inode(inode, index, rpages); *//* BB finish */
 
-/*   cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
+/*	cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
 
 	if (rc < 0)
 		return rc;
@@ -1109,18 +1096,16 @@ int cifs_flush(struct file *file)
 	/* filemapfdatawrite appears easier for the time being */
 
 	rc = filemap_fdatawrite(inode->i_mapping);
-	if(rc == 0) /* reset wb rc if we were able to write out dirty pages */
+	if (rc == 0) /* reset wb rc if we were able to write out dirty pages */
 		CIFS_I(inode)->write_behind_rc = 0;
 		
-	cFYI(1,("Flush inode %p file %p rc %d",inode,file,rc));
+	cFYI(1, ("Flush inode %p file %p rc %d",inode,file,rc));
 
 	return rc;
 }
 
-
-ssize_t
-cifs_user_read(struct file * file, char __user *read_data, size_t read_size,
-	  loff_t * poffset)
+ssize_t cifs_user_read(struct file *file, char __user *read_data,
+	size_t read_size, loff_t *poffset)
 {
 	int rc = -EACCES;
 	unsigned int bytes_read = 0;
@@ -1129,10 +1114,10 @@ cifs_user_read(struct file * file, char 
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int xid;
-	struct cifsFileInfo * open_file;
-	char * smb_read_data;
-	char __user * current_offset;
-	struct smb_com_read_rsp * pSMBr;
+	struct cifsFileInfo *open_file;
+	char *smb_read_data;
+	char __user *current_offset;
+	struct smb_com_read_rsp *pSMBr;
 
 	xid = GetXid();
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
@@ -1144,19 +1129,19 @@ cifs_user_read(struct file * file, char 
 	}
 	open_file = (struct cifsFileInfo *)file->private_data;
 
-	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
-		cFYI(1,("attempting read on write only file instance"));
+	if ((file->f_flags & O_ACCMODE) == O_WRONLY) {
+		cFYI(1, ("attempting read on write only file instance"));
 	}
-	for (total_read = 0,current_offset=read_data; read_size > total_read;
-				total_read += bytes_read,current_offset+=bytes_read) {
-		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
+	for (total_read = 0, current_offset = read_data; read_size > total_read;
+				total_read += bytes_read, current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read, cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
-		while(rc == -EAGAIN) {
+		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file,TRUE);
-				if(rc != 0)
+					file, TRUE);
+				if (rc != 0)
 					break;
 			}
 
@@ -1166,13 +1151,13 @@ cifs_user_read(struct file * file, char 
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			if(copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			if (copy_to_user(current_offset,smb_read_data + 4 /* RFC1001 hdr*/
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read)) {
 				rc = -EFAULT;
 				FreeXid(xid);
 				return rc;
             }
-			if(smb_read_data) {
+			if (smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}
@@ -1198,9 +1183,8 @@ cifs_user_read(struct file * file, char 
 	return total_read;
 }
 
-static ssize_t
-cifs_read(struct file * file, char *read_data, size_t read_size,
-	  loff_t * poffset)
+static ssize_t cifs_read(struct file *file, char *read_data, size_t read_size,
+	loff_t *poffset)
 {
 	int rc = -EACCES;
 	unsigned int bytes_read = 0;
@@ -1209,8 +1193,8 @@ cifs_read(struct file * file, char *read
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int xid;
-	char * current_offset;
-	struct cifsFileInfo * open_file;
+	char *current_offset;
+	struct cifsFileInfo *open_file;
 
 	xid = GetXid();
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
@@ -1222,19 +1206,18 @@ cifs_read(struct file * file, char *read
 	}
 	open_file = (struct cifsFileInfo *)file->private_data;
 
-	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
-		cFYI(1,("attempting read on write only file instance"));
-	}
+	if ((file->f_flags & O_ACCMODE) == O_WRONLY)
+		cFYI(1, ("attempting read on write only file instance"));
 
-	for (total_read = 0,current_offset=read_data; read_size > total_read;
-				total_read += bytes_read,current_offset+=bytes_read) {
-		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
+	for (total_read = 0, current_offset = read_data; read_size > total_read;
+				total_read += bytes_read, current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read, cifs_sb->rsize);
 		rc = -EAGAIN;
-		while(rc == -EAGAIN) {
+		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file,TRUE);
-				if(rc != 0)
+					file, TRUE);
+				if (rc != 0)
 					break;
 			}
 
@@ -1264,17 +1247,17 @@ cifs_read(struct file * file, char *read
 	return total_read;
 }
 
-int cifs_file_mmap(struct file * file, struct vm_area_struct * vma)
+int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct dentry * dentry = file->f_dentry;
-	int	rc, xid;
+	struct dentry *dentry = file->f_dentry;
+	int rc, xid;
 
 #ifdef CIFS_EXPERIMENTAL   /* BB fixme reenable when cifs_read_wrapper fixed */
-	if(dentry->d_sb) {
+	if (dentry->d_sb) {
 		struct cifs_sb_info *cifs_sb;
 		cifs_sb = CIFS_SB(sb);
-		if(cifs_sb != NULL) {
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
+		if (cifs_sb != NULL) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
 				return -ENODEV
 		}
 	}
@@ -1283,7 +1266,7 @@ int cifs_file_mmap(struct file * file, s
 	xid = GetXid();
 	rc = cifs_revalidate(dentry);
 	if (rc) {
-		cFYI(1,("Validation prior to mmap failed, error=%d", rc));
+		cFYI(1, ("Validation prior to mmap failed, error=%d", rc));
 		FreeXid(xid);
 		return rc;
 	}
@@ -1293,14 +1276,14 @@ int cifs_file_mmap(struct file * file, s
 }
 
 static void cifs_copy_cache_pages(struct address_space *mapping, 
-		struct list_head *pages, int bytes_read, 
-		char *data,struct pagevec * plru_pvec)
+	struct list_head *pages, int bytes_read, char *data,
+	struct pagevec *plru_pvec)
 {
 	struct page *page;
-	char * target;
+	char *target;
 
 	while (bytes_read > 0) {
-		if(list_empty(pages))
+		if (list_empty(pages))
 			break;
 
 		page = list_entry(pages->prev, struct page, lru);
@@ -1308,22 +1291,22 @@ static void cifs_copy_cache_pages(struct
 
 		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
 			page_cache_release(page);
-			cFYI(1,("Add page cache failed"));
+			cFYI(1, ("Add page cache failed"));
 			continue;
 		}
 
 		target = kmap_atomic(page,KM_USER0);
 
-		if(PAGE_CACHE_SIZE > bytes_read) {
-			memcpy(target,data,bytes_read);
+		if (PAGE_CACHE_SIZE > bytes_read) {
+			memcpy(target, data, bytes_read);
 			/* zero the tail end of this partial page */
-			memset(target+bytes_read,0,PAGE_CACHE_SIZE-bytes_read);
+			memset(target +bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
 			bytes_read = 0;
 		} else {
-			memcpy(target,data,PAGE_CACHE_SIZE);
+			memcpy(target, data, PAGE_CACHE_SIZE);
 			bytes_read -= PAGE_CACHE_SIZE;
 		}
-		kunmap_atomic(target,KM_USER0);
+		kunmap_atomic(target, KM_USER0);
 
 		flush_dcache_page(page);
 		SetPageUptodate(page);
@@ -1335,23 +1318,21 @@ static void cifs_copy_cache_pages(struct
 	return;
 }
 
-
-static int
-cifs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *page_list, unsigned num_pages)
+static int cifs_readpages(struct file *file, struct address_space *mapping,
+	struct list_head *page_list, unsigned num_pages)
 {
 	int rc = -EACCES;
 	int xid;
 	loff_t offset;
-	struct page * page;
+	struct page *page;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int bytes_read = 0;
 	unsigned int read_size,i;
-	char * smb_read_data = NULL;
-	struct smb_com_read_rsp * pSMBr;
+	char *smb_read_data = NULL;
+	struct smb_com_read_rsp *pSMBr;
 	struct pagevec lru_pvec;
-	struct cifsFileInfo * open_file;
+	struct cifsFileInfo *open_file;
 
 	xid = GetXid();
 	if (file->private_data == NULL) {
@@ -1364,14 +1345,14 @@ cifs_readpages(struct file *file, struct
 
 	pagevec_init(&lru_pvec, 0);
 
-	for(i = 0;i<num_pages;) {
+	for (i = 0; i < num_pages; ) {
 		unsigned contig_pages;
-		struct page * tmp_page;
+		struct page *tmp_page;
 		unsigned long expected_index;
 
-		if(list_empty(page_list)) {
+		if (list_empty(page_list))
 			break;
-		}
+
 		page = list_entry(page_list->prev, struct page, lru);
 		offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
 
@@ -1379,29 +1360,27 @@ cifs_readpages(struct file *file, struct
 		contig_pages = 0;
 		expected_index = list_entry(page_list->prev,struct page,lru)->index;
 		list_for_each_entry_reverse(tmp_page,page_list,lru) {
-			if(tmp_page->index == expected_index) {
+			if (tmp_page->index == expected_index) {
 				contig_pages++;
 				expected_index++;
-			} else {
+			} else
 				break; 
-			}
 		}
-		if(contig_pages + i >  num_pages) {
+		if (contig_pages + i >  num_pages)
 			contig_pages = num_pages - i;
-		}
 
 		/* for reads over a certain size could initiate async read ahead */
 
 		read_size = contig_pages * PAGE_CACHE_SIZE;
 		/* Read size needs to be in multiples of one page */
-		read_size = min_t(const unsigned int,read_size,cifs_sb->rsize & PAGE_CACHE_MASK);
+		read_size = min_t(const unsigned int, read_size, cifs_sb->rsize & PAGE_CACHE_MASK);
 
 		rc = -EAGAIN;
-		while(rc == -EAGAIN) {
+		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file, TRUE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -1410,15 +1389,15 @@ cifs_readpages(struct file *file, struct
 				read_size, offset,
 				&bytes_read, &smb_read_data);
 			/* BB need to check return code here */
-			if(rc== -EAGAIN) {
-				if(smb_read_data) {
+			if (rc== -EAGAIN) {
+				if (smb_read_data) {
 					cifs_buf_release(smb_read_data);
 					smb_read_data = NULL;
 				}
 			}
 		}
 		if ((rc < 0) || (smb_read_data == NULL)) {
-			cFYI(1,("Read error in readpages: %d",rc));
+			cFYI(1, ("Read error in readpages: %d", rc));
 			/* clean up remaing pages off list */
 			while (!list_empty(page_list) && (i < num_pages)) {
 				page = list_entry(page_list->prev, struct page, lru);
@@ -1439,22 +1418,22 @@ cifs_readpages(struct file *file, struct
 			pTcon->bytes_read += bytes_read;
 			spin_unlock(&pTcon->stat_lock);
 #endif
-			if((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
+			if ((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
 				i++; /* account for partial page */
 
 				/* server copy of file can have smaller size than client */
 				/* BB do we need to verify this common case ? this case is ok - 
 				if we are at server EOF we will hit it on next read */
 
-			/* while(!list_empty(page_list) && (i < num_pages)) {
-					page = list_entry(page_list->prev,struct page, list);
+			/* while (!list_empty(page_list) && (i < num_pages)) {
+					page = list_entry(page_list->prev, struct page, list);
 					list_del(&page->list);
 					page_cache_release(page);
 				}
 				break; */
 			}
 		} else {
-			cFYI(1,("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list",bytes_read,offset)); 
+			cFYI(1, ("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list", bytes_read, offset)); 
 			/* BB turn off caching and do new lookup on file size at server? */
 			while (!list_empty(page_list) && (i < num_pages)) {
 				page = list_entry(page_list->prev, struct page, lru);
@@ -1463,7 +1442,7 @@ cifs_readpages(struct file *file, struct
 			}
 			break;
 		}
-		if(smb_read_data) {
+		if (smb_read_data) {
 			cifs_buf_release(smb_read_data);
 			smb_read_data = NULL;
 		}
@@ -1473,7 +1452,7 @@ cifs_readpages(struct file *file, struct
 	pagevec_lru_add(&lru_pvec);
 
 /* need to free smb_read_data buf before exit */
-	if(smb_read_data) {
+	if (smb_read_data) {
 		cifs_buf_release(smb_read_data);
 		smb_read_data = NULL;
 	} 
@@ -1482,9 +1461,10 @@ cifs_readpages(struct file *file, struct
 	return rc;
 }
 
-static int cifs_readpage_worker(struct file *file, struct page *page, loff_t * poffset)
+static int cifs_readpage_worker(struct file *file, struct page *page,
+	loff_t *poffset)
 {
-	char * read_data;
+	char *read_data;
 	int rc;
 
 	page_cache_get(page);
@@ -1495,16 +1475,15 @@ static int cifs_readpage_worker(struct f
                                                                                                                            
 	if (rc < 0)
 		goto io_error;
-	else {
-		cFYI(1,("Bytes read %d ",rc));
-	}
+	else
+		cFYI(1, ("Bytes read %d ",rc));
                                                                                                                            
 	file->f_dentry->d_inode->i_atime =
 		current_fs_time(file->f_dentry->d_inode->i_sb);
                                                                                                                            
-	if(PAGE_CACHE_SIZE > rc) {
-		memset(read_data+rc, 0, PAGE_CACHE_SIZE - rc);
-	}
+	if (PAGE_CACHE_SIZE > rc)
+		memset(read_data + rc, 0, PAGE_CACHE_SIZE - rc);
+
 	flush_dcache_page(page);
 	SetPageUptodate(page);
 	rc = 0;
@@ -1515,8 +1494,7 @@ io_error:
 	return rc;
 }
 
-static int
-cifs_readpage(struct file *file, struct page *page)
+static int cifs_readpage(struct file *file, struct page *page)
 {
 	loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
 	int rc = -EACCES;
@@ -1529,9 +1507,9 @@ cifs_readpage(struct file *file, struct 
 		return -EBADF;
 	}
 
-	cFYI(1,("readpage %p at offset %d 0x%x\n",page,(int)offset,(int)offset));
+	cFYI(1, ("readpage %p at offset %d 0x%x\n", page, (int)offset, (int)offset));
 
-	rc = cifs_readpage_worker(file,page,&offset);
+	rc = cifs_readpage_worker(file, page, &offset);
 
 	unlock_page(page);
 
@@ -1546,34 +1524,34 @@ cifs_readpage(struct file *file, struct 
    but this is tricky to do without racing with writebehind
    page caching in the current Linux kernel design */
    
-int is_size_safe_to_change(struct cifsInodeInfo * cifsInode)
+int is_size_safe_to_change(struct cifsInodeInfo *cifsInode)
 {
 	struct list_head *tmp;
 	struct list_head *tmp1;
 	struct cifsFileInfo *open_file = NULL;
 	int rc = TRUE;
 
-	if(cifsInode == NULL)
+	if (cifsInode == NULL)
 		return rc;
 
 	read_lock(&GlobalSMBSeslock); 
 	list_for_each_safe(tmp, tmp1, &cifsInode->openFileList) {            
-		open_file = list_entry(tmp,struct cifsFileInfo, flist);
-		if(open_file == NULL)
+		open_file = list_entry(tmp, struct cifsFileInfo, flist);
+		if (open_file == NULL)
 			break;
-		if(open_file->closePend)
+		if (open_file->closePend)
 			continue;
 	/* We check if file is open for writing,   
 	BB we could supplement this with a check to see if file size
 	changes have been flushed to server - ie inode metadata dirty */
-		if((open_file->pfile) && 
-	   ((open_file->pfile->f_flags & O_RDWR) || 
-		(open_file->pfile->f_flags & O_WRONLY))) {
-			 rc = FALSE;
-			 break;
+		if ((open_file->pfile) && 
+		    ((open_file->pfile->f_flags & O_RDWR) || 
+		    (open_file->pfile->f_flags & O_WRONLY))) {
+			rc = FALSE;
+			break;
 		}
-		if(tmp->next == NULL) {
-			cFYI(1,("File instance %p removed",tmp));
+		if (tmp->next == NULL) {
+			cFYI(1, ("File instance %p removed", tmp));
 			break;
 		}
 	}
@@ -1581,10 +1559,8 @@ int is_size_safe_to_change(struct cifsIn
 	return rc;
 }
 
-
-void
-fill_in_inode(struct inode *tmp_inode,
-	      FILE_DIRECTORY_INFO * pfindData, int *pobject_type)
+void fill_in_inode(struct inode *tmp_inode, FILE_DIRECTORY_INFO *pfindData,
+	int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(tmp_inode->i_sb);
@@ -1605,44 +1581,42 @@ fill_in_inode(struct inode *tmp_inode,
 	/* treat dos attribute of read-only as read-only mode bit e.g. 555? */
 	/* 2767 perms - indicate mandatory locking */
 		/* BB fill in uid and gid here? with help from winbind? 
-			or retrieve from NTFS stream extended attribute */
-	if(atomic_read(&cifsInfo->inUse) == 0) {
+		   or retrieve from NTFS stream extended attribute */
+	if (atomic_read(&cifsInfo->inUse) == 0) {
 		tmp_inode->i_uid = cifs_sb->mnt_uid;
 		tmp_inode->i_gid = cifs_sb->mnt_gid;
 		/* set default mode. will override for dirs below */
 		tmp_inode->i_mode = cifs_sb->mnt_file_mode;
 	}
 
-	cFYI(0,
-	     ("CIFS FFIRST: Attributes came in as 0x%x",
-	      attr));
+	cFYI(0, ("CIFS FFIRST: Attributes came in as 0x%x", attr));
 	if (attr & ATTR_DIRECTORY) {
 		*pobject_type = DT_DIR;
 		/* override default perms since we do not lock dirs */
-		if(atomic_read(&cifsInfo->inUse) == 0) {
+		if (atomic_read(&cifsInfo->inUse) == 0) {
 			tmp_inode->i_mode = cifs_sb->mnt_dir_mode;
 		}
 		tmp_inode->i_mode |= S_IFDIR;
 /* we no longer mark these because we could not follow them */
 /*        } else if (attr & ATTR_REPARSE) {
                 *pobject_type = DT_LNK;
-                tmp_inode->i_mode |= S_IFLNK;*/
+                tmp_inode->i_mode |= S_IFLNK; */
 	} else {
 		*pobject_type = DT_REG;
 		tmp_inode->i_mode |= S_IFREG;
-		if(attr & ATTR_READONLY)
+		if (attr & ATTR_READONLY)
 			tmp_inode->i_mode &= ~(S_IWUGO);
-	}/* could add code here - to validate if device or weird share type? */
+	} /* could add code here - to validate if device or weird share type? */
 
 	/* can not fill in nlink here as in qpathinfo version and Unx search */
-	if(atomic_read(&cifsInfo->inUse) == 0) {
-		atomic_set(&cifsInfo->inUse,1);
+	if (atomic_read(&cifsInfo->inUse) == 0) {
+		atomic_set(&cifsInfo->inUse, 1);
 	}
 
-	if(is_size_safe_to_change(cifsInfo)) {
+	if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the 
 		client is writing to it due to potential races */
-		i_size_write(tmp_inode,end_of_file);
+		i_size_write(tmp_inode, end_of_file);
 
 	/* 512 bytes (2**9) is the fake blocksize that must be used */
 	/* for this calculation, even though the reported blocksize is larger */
@@ -1653,7 +1627,7 @@ fill_in_inode(struct inode *tmp_inode,
 		cFYI(1, ("Possible sparse file: allocation size less than end of file "));
 	cFYI(1,
 	     ("File Size %ld and blocks %ld and blocksize %ld",
-	      (unsigned long) tmp_inode->i_size, tmp_inode->i_blocks,
+	      (unsigned long)tmp_inode->i_size, tmp_inode->i_blocks,
 	      tmp_inode->i_blksize));
 	if (S_ISREG(tmp_inode->i_mode)) {
 		cFYI(1, (" File inode "));
@@ -1674,9 +1648,8 @@ fill_in_inode(struct inode *tmp_inode,
 	}
 }
 
-void
-unix_fill_in_inode(struct inode *tmp_inode,
-		   FILE_UNIX_INFO * pfindData, int *pobject_type)
+void unix_fill_in_inode(struct inode *tmp_inode, FILE_UNIX_INFO *pfindData,
+	int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	__u32 type = le32_to_cpu(pfindData->Type);
@@ -1724,8 +1697,7 @@ unix_fill_in_inode(struct inode *tmp_ino
 	tmp_inode->i_gid = le64_to_cpu(pfindData->Gid);
 	tmp_inode->i_nlink = le64_to_cpu(pfindData->Nlinks);
 
-
-	if(is_size_safe_to_change(cifsInfo)) {
+	if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the 
 		client is writing to it due to potential races */
 		i_size_write(tmp_inode,end_of_file);
@@ -1756,11 +1728,11 @@ unix_fill_in_inode(struct inode *tmp_ino
 }
 
 static int cifs_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
+	unsigned from, unsigned to)
 {
 	int rc = 0;
         loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
-	cFYI(1,("prepare write for page %p from %d to %d",page,from,to));
+	cFYI(1, ("prepare write for page %p from %d to %d",page,from,to));
 	if (!PageUptodate(page)) {
 	/*	if (to - from != PAGE_CACHE_SIZE) {
 			void *kaddr = kmap_atomic(page, KM_USER0);
@@ -1771,17 +1743,17 @@ static int cifs_prepare_write(struct fil
 		} */
 		/* If we are writing a full page it will be up to date,
 		no need to read from the server */
-		if((to==PAGE_CACHE_SIZE) && (from == 0))
+		if ((to == PAGE_CACHE_SIZE) && (from == 0))
 			SetPageUptodate(page);
 
 		/* might as well read a page, it is fast enough */
-		if((file->f_flags & O_ACCMODE) != O_WRONLY) {
-			rc = cifs_readpage_worker(file,page,&offset);
+		if ((file->f_flags & O_ACCMODE) != O_WRONLY) {
+			rc = cifs_readpage_worker(file, page, &offset);
 		} else {
 		/* should we try using another
-		file handle if there is one - how would we lock it
-		to prevent close of that handle racing with this read? */
-		/* In any case this will be written out by commit_write */
+		   file handle if there is one - how would we lock it
+		   to prevent close of that handle racing with this read?
+		   In any case this will be written out by commit_write */
 		}
 	}
 
@@ -1789,14 +1761,13 @@ static int cifs_prepare_write(struct fil
 	return 0;
 }
 
-
 struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
 	.readpages = cifs_readpages,
 	.writepage = cifs_writepage,
-	.prepare_write = cifs_prepare_write, 
+	.prepare_write = cifs_prepare_write,
 	.commit_write = cifs_commit_write,
 	.set_page_dirty = __set_page_dirty_nobuffers,
-   /* .sync_page = cifs_sync_page, */
-	/*.direct_IO = */
+	/* .sync_page = cifs_sync_page, */
+	/* .direct_IO = */
 };



