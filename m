Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUL1Xnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUL1Xnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUL1Xnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:43:55 -0500
Received: from mail.dif.dk ([193.138.115.101]:19387 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261171AbUL1Xlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:41:32 -0500
Date: Wed, 29 Dec 2004 00:52:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
In-Reply-To: <1104104286.16545.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
 <1104104286.16545.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The style used in fs/cifs/file.c is not very consistent and (to me at 
least) seems to diverge a bit from CodingStyle and there's some 
whitespace damage in there as well.
This patch attempts to make the style a bit more consistent and readable 
and tries to clean up the whitespace damage. 
The patch is cut on top of my copy_to_user fix patch that was just posted 
a few minutes ago.
This patch makes no actual code changes.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10/fs/cifs/file.c-orig linux-2.6.10/fs/cifs/file.c
--- linux-2.6.10/fs/cifs/file.c-orig	2004-12-29 00:34:45.000000000 +0100
+++ linux-2.6.10/fs/cifs/file.c	2004-12-29 00:38:16.000000000 +0100
@@ -46,12 +46,12 @@ cifs_open(struct inode *inode, struct fi
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
 
@@ -63,7 +63,7 @@ cifs_open(struct inode *inode, struct fi
 		pCifsInode = CIFS_I(file->f_dentry->d_inode);
 		read_lock(&GlobalSMBSeslock);
 		list_for_each(tmp, &pCifsInode->openFileList) {            
-			pCifsFile = list_entry(tmp,struct cifsFileInfo, flist);           
+			pCifsFile = list_entry(tmp, struct cifsFileInfo, flist);           
 			if((pCifsFile->pfile == NULL)&& (pCifsFile->pid == current->tgid)){
 			/* mode set in cifs_create */
 				pCifsFile->pfile = file; /* needed for writepage */
@@ -72,25 +72,25 @@ cifs_open(struct inode *inode, struct fi
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
@@ -126,11 +126,11 @@ cifs_open(struct inode *inode, struct fi
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
@@ -149,8 +149,8 @@ cifs_open(struct inode *inode, struct fi
 	/* BB we can not do this if this is the second open of a file 
 	and the first handle has writebehind data, we might be 
 	able to simply do a filemap_fdatawrite/filemap_fdatawait first */
-	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-	if(buf== NULL) {
+	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
+	if (buf== NULL) {
 		if (full_path)
 			kfree(full_path);
 		FreeXid(xid);
@@ -163,48 +163,48 @@ cifs_open(struct inode *inode, struct fi
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
+						if (timespec_equal(&file->f_dentry->d_inode->i_mtime,&temp) && 
 							(file->f_dentry->d_inode->i_size == (loff_t)le64_to_cpu(buf->EndOfFile))) {
-							cFYI(1,("inode unchanged on server"));
+							cFYI(1, ("inode unchanged on server"));
 						} else {
-							if(file->f_dentry->d_inode->i_mapping) {
+							if (file->f_dentry->d_inode->i_mapping) {
 							/* BB no need to lock inode until after invalidate*/
 							/* since namei code should already have it locked?*/
 								filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
@@ -217,22 +217,22 @@ cifs_open(struct inode *inode, struct fi
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
 				if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)                
@@ -260,7 +260,8 @@ cifs_open(struct inode *inode, struct fi
 
 /* Try to reaquire byte range locks that were released when session */
 /* to server was lost */
-static int cifs_relock_file(struct cifsFileInfo * cifsFile)
+static int 
+cifs_relock_file(struct cifsFileInfo *cifsFile)
 {
 	int rc = 0;
 
@@ -269,7 +270,8 @@ static int cifs_relock_file(struct cifsF
 	return rc;
 }
 
-static int cifs_reopen_file(struct inode *inode, struct file *file, int can_flush)
+static int 
+cifs_reopen_file(struct inode *inode, struct file *file, int can_flush)
 {
 	int rc = -EACCES;
 	int xid, oplock;
@@ -285,21 +287,21 @@ static int cifs_reopen_file(struct inode
 	if(inode == NULL)
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
@@ -310,7 +312,7 @@ those that already have the rename sem c
 to get called and if the server was down that means we end up here,
 and we can never tell if the caller already has the rename_sem */
 	full_path = build_path_from_dentry(file->f_dentry);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		up(&pCifsFile->fh_sem);
 		FreeXid(xid);
 		return -ENOMEM;
@@ -340,8 +342,8 @@ and we can never tell if the caller alre
 	 and server version of file size can be stale. If we 
 	 knew for sure that inode was not dirty locally we could do this */
 
-/*	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-	if(buf==0) {
+/*	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
+	if (buf==0) {
 		up(&pCifsFile->fh_sem);
 		if (full_path)
 			kfree(full_path);
@@ -359,8 +361,8 @@ and we can never tell if the caller alre
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
@@ -379,11 +381,11 @@ and we can never tell if the caller alre
 			invalidate the current end of file on the server
 			we can not go to the server to get the new
 			inod info */
-			if((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
+			if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
 				pCifsInode->clientCanCacheAll =  TRUE;
 				pCifsInode->clientCanCacheRead = TRUE;
-				cFYI(1,("Exclusive Oplock granted on inode %p",file->f_dentry->d_inode));
-			} else if((oplock & 0xF) == OPLOCK_READ) {
+				cFYI(1, ("Exclusive Oplock granted on inode %p", file->f_dentry->d_inode));
+			} else if ((oplock & 0xF) == OPLOCK_READ) {
 				pCifsInode->clientCanCacheRead = TRUE;
 				pCifsInode->clientCanCacheAll =  FALSE;
 			} else {
@@ -408,7 +410,7 @@ cifs_close(struct inode *inode, struct f
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	struct cifsFileInfo *pSMBFile =
-		(struct cifsFileInfo *) file->private_data;
+		(struct cifsFileInfo *)file->private_data;
 
 	xid = GetXid();
 
@@ -417,7 +419,7 @@ cifs_close(struct inode *inode, struct f
 	if (pSMBFile) {
 		pSMBFile->closePend    = TRUE;
 		write_lock(&file->f_owner.lock);
-		if(pTcon) {
+		if (pTcon) {
 			/* no sense reconnecting to close a file that is
 				already closed */
 			if (pTcon->tidStatus != CifsNeedReconnect) {
@@ -429,21 +431,21 @@ cifs_close(struct inode *inode, struct f
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
@@ -455,8 +457,8 @@ cifs_closedir(struct inode *inode, struc
 	int rc = 0;
 	int xid;
 	struct cifsFileInfo *pCFileStruct =
-	    (struct cifsFileInfo *) file->private_data;
-	char * ptmp;
+	    (struct cifsFileInfo *)file->private_data;
+	char *ptmp;
 
 	cFYI(1, ("Closedir inode = 0x%p with ", inode));
 
@@ -464,27 +466,27 @@ cifs_closedir(struct inode *inode, struc
 
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
@@ -531,7 +533,7 @@ cifs_lock(struct file *file, int cmd, st
 	if (pfLock->fl_flags & FL_LEASE)
 		cFYI(1, ("Lease on file - not implemented yet"));
 	if (pfLock->fl_flags & (~(FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS | FL_LEASE)))
-		cFYI(1, ("Unknown lock flags 0x%x",pfLock->fl_flags));
+		cFYI(1, ("Unknown lock flags 0x%x", pfLock->fl_flags));
 
 	if (pfLock->fl_type == F_WRLCK) {
 		cFYI(1, ("F_WRLCK "));
@@ -563,7 +565,7 @@ cifs_lock(struct file *file, int cmd, st
 
 	if (IS_GETLK(cmd)) {
 		rc = CIFSSMBLock(xid, pTcon,
-				 ((struct cifsFileInfo *) file->
+				 ((struct cifsFileInfo *)file->
 				  private_data)->netfid,
 				 length,
 				 pfLock->fl_start, 0, 1, lockType,
@@ -604,8 +606,8 @@ cifs_lock(struct file *file, int cmd, st
 }
 
 ssize_t
-cifs_user_write(struct file * file, const char __user * write_data,
-	   size_t write_size, loff_t * poffset)
+cifs_user_write(struct file *file, const char __user *write_data,
+		size_t write_size, loff_t *poffset)
 {
 	int rc = 0;
 	unsigned int bytes_written = 0;
@@ -613,13 +615,13 @@ cifs_user_write(struct file * file, cons
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
+	if (cifs_sb == NULL) {
 		return -EBADF;
 	}
 	pTcon = cifs_sb->tcon;
@@ -648,8 +650,8 @@ cifs_user_write(struct file * file, cons
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
@@ -657,7 +659,7 @@ cifs_user_write(struct file * file, cons
 			while we blocked so return what we managed to write */
 				return total_written;
 			} 
-			if(open_file->closePend) {
+			if (open_file->closePend) {
 				FreeXid(xid);
 				if(total_written)
 					return total_written;
@@ -665,7 +667,7 @@ cifs_user_write(struct file * file, cons
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if((file->f_dentry == NULL) ||
+				if ((file->f_dentry == NULL) ||
 				   (file->f_dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
@@ -675,7 +677,7 @@ cifs_user_write(struct file * file, cons
 				reopen_file not to flush data to server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,FALSE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -692,13 +694,14 @@ cifs_user_write(struct file * file, cons
 				FreeXid(xid);
 				return rc;
 			}
-		} else
+		} else {
 			*poffset += bytes_written;
+		}
 		long_op = FALSE; /* subsequent writes fast - 15 seconds is plenty */
 	}
 
 #ifdef CONFIG_CIFS_STATS
-	if(total_written > 0) {
+	if (total_written > 0) {
 		atomic_inc(&pTcon->num_writes);
 		spin_lock(&pTcon->stat_lock);
 		pTcon->bytes_written += total_written;
@@ -707,8 +710,8 @@ cifs_user_write(struct file * file, cons
 #endif		
 
 	/* since the write may have blocked check these pointers again */
-	if(file->f_dentry) {
-		if(file->f_dentry->d_inode) {
+	if (file->f_dentry) {
+		if (file->f_dentry->d_inode) {
 			file->f_dentry->d_inode->i_ctime = file->f_dentry->d_inode->i_mtime =
 				CURRENT_TIME;
 			if (total_written > 0) {
@@ -723,8 +726,8 @@ cifs_user_write(struct file * file, cons
 }
 
 static ssize_t
-cifs_write(struct file * file, const char *write_data,
-	   size_t write_size, loff_t * poffset)
+cifs_write(struct file *file, const char *write_data,
+	   size_t write_size, loff_t *poffset)
 {
 	int rc = 0;
 	unsigned int bytes_written = 0;
@@ -732,13 +735,13 @@ cifs_write(struct file * file, const cha
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
+	if (cifs_sb == NULL) {
 		return -EBADF;
 	}
 	pTcon = cifs_sb->tcon;
@@ -750,11 +753,11 @@ cifs_write(struct file * file, const cha
 	if (file->private_data == NULL) {
 		return -EBADF;
 	} else {
-		open_file = (struct cifsFileInfo *) file->private_data;
+		open_file = (struct cifsFileInfo *)file->private_data;
 	}
 	
 	xid = GetXid();
-	if(file->f_dentry->d_inode == NULL) {
+	if (file->f_dentry->d_inode == NULL) {
 		FreeXid(xid);
 		return -EBADF;
 	}
@@ -767,8 +770,8 @@ cifs_write(struct file * file, const cha
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
@@ -776,7 +779,7 @@ cifs_write(struct file * file, const cha
 			while we blocked so return what we managed to write */
 				return total_written;
 			} 
-			if(open_file->closePend) {
+			if (open_file->closePend) {
 				FreeXid(xid);
 				if(total_written)
 					return total_written;
@@ -784,7 +787,7 @@ cifs_write(struct file * file, const cha
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if((file->f_dentry == NULL) ||
+				if ((file->f_dentry == NULL) ||
 				   (file->f_dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
@@ -794,7 +797,7 @@ cifs_write(struct file * file, const cha
 				reopen_file not to flush data to server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,FALSE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -811,13 +814,14 @@ cifs_write(struct file * file, const cha
 				FreeXid(xid);
 				return rc;
 			}
-		} else
+		} else {
 			*poffset += bytes_written;
+		}
 		long_op = FALSE; /* subsequent writes fast - 15 seconds is plenty */
 	}
 
 #ifdef CONFIG_CIFS_STATS
-	if(total_written > 0) {
+	if (total_written > 0) {
 		atomic_inc(&pTcon->num_writes);
 		spin_lock(&pTcon->stat_lock);
 		pTcon->bytes_written += total_written;
@@ -826,8 +830,8 @@ cifs_write(struct file * file, const cha
 #endif		
 
 	/* since the write may have blocked check these pointers again */
-	if(file->f_dentry) {
-		if(file->f_dentry->d_inode) {
+	if (file->f_dentry) {
+		if (file->f_dentry->d_inode) {
 			file->f_dentry->d_inode->i_ctime = file->f_dentry->d_inode->i_mtime =
 				CURRENT_TIME;
 			if (total_written > 0) {
@@ -842,11 +846,11 @@ cifs_write(struct file * file, const cha
 }
 
 static int
-cifs_partialpagewrite(struct page *page,unsigned from, unsigned to)
+cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 {
 	struct address_space *mapping = page->mapping;
 	loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
-	char * write_data;
+	char *write_data;
 	int rc = -EFAULT;
 	int bytes_written = 0;
 	struct cifs_sb_info *cifs_sb;
@@ -859,7 +863,7 @@ cifs_partialpagewrite(struct page *page,
 
 	if (!mapping) {
 		return -EFAULT;
-	} else if(!mapping->host) {
+	} else if (!mapping->host) {
 		return -EFAULT;
 	}
 
@@ -871,19 +875,19 @@ cifs_partialpagewrite(struct page *page,
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
 		
 
@@ -891,11 +895,11 @@ cifs_partialpagewrite(struct page *page,
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
@@ -906,8 +910,8 @@ cifs_partialpagewrite(struct page *page,
 			inode->i_atime = inode->i_mtime = CURRENT_TIME;
 			if ((bytes_written > 0) && (offset)) {
 				rc = 0;
-			} else if(bytes_written < 0) {
-				if(rc == -EBADF) {
+			} else if (bytes_written < 0) {
+				if (rc == -EBADF) {
 				/* have seen a case in which
 				kernel seemed to have closed/freed a file
 				even with writes active so we might as well
@@ -921,14 +925,14 @@ cifs_partialpagewrite(struct page *page,
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
 
@@ -951,7 +955,7 @@ cifs_writepages(struct address_space *ma
 #endif
 
 static int
-cifs_writepage(struct page* page, struct writeback_control *wbc)
+cifs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	int rc = -EFAULT;
 	int xid;
@@ -960,10 +964,10 @@ cifs_writepage(struct page* page, struct
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
@@ -979,10 +983,10 @@ cifs_commit_write(struct file *file, str
 	int rc = 0;
 	struct inode *inode = page->mapping->host;
 	loff_t position = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-	char * page_data;
+	char *page_data;
 
 	xid = GetXid();
-	cFYI(1,("commit write for page %p up to position %lld for %d",page,position,to));
+	cFYI(1, ("commit write for page %p up to position %lld for %d", page, position, to));
 	if (position > inode->i_size){
 		i_size_write(inode, position);
 		/*if (file->private_data == NULL) {
@@ -991,31 +995,31 @@ cifs_commit_write(struct file *file, str
 			open_file = (struct cifsFileInfo *)file->private_data;
 			cifs_sb = CIFS_SB(inode->i_sb);
 			rc = -EAGAIN;
-			while(rc == -EAGAIN) {
-				if((open_file->invalidHandle) && 
-				  (!open_file->closePend)) {
-					rc = cifs_reopen_file(file->f_dentry->d_inode,file);
-					if(rc != 0)
+			while (rc == -EAGAIN) {
+				if ((open_file->invalidHandle) && 
+				   (!open_file->closePend)) {
+					rc = cifs_reopen_file(file->f_dentry->d_inode, file);
+					if (rc != 0)
 						break;
 				}
-				if(!open_file->closePend) {
+				if (!open_file->closePend) {
 					rc = CIFSSMBSetFileSize(xid, cifs_sb->tcon, 
 						position, open_file->netfid,
-						open_file->pid,FALSE);
+						open_file->pid, FALSE);
 				} else {
 					rc = -EBADF;
 					break;
 				}
 			}
-			cFYI(1,(" SetEOF (commit write) rc = %d",rc));
+			cFYI(1, (" SetEOF (commit write) rc = %d", rc));
 		}*/
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
@@ -1023,12 +1027,12 @@ cifs_commit_write(struct file *file, str
 		partialpage_write since in this function
 		the file handle is known which we might as well
 		leverage */
-		/* BB check if anything else missing out of ppw */
-		/* such as updating last write time */
+		/* BB check if anything else missing out of ppw
+		   such as updating last write time */
 		page_data = kmap(page);
-		rc = cifs_write(file, page_data+offset,to-offset,
+		rc = cifs_write(file, page_data+offset, to-offset,
                                         &position);
-		if(rc > 0)
+		if (rc > 0)
 			rc = 0;
 		/* else if rc < 0 should we set writebehind rc? */
 		kunmap(page);
@@ -1045,7 +1049,7 @@ cifs_fsync(struct file *file, struct den
 {
 	int xid;
 	int rc = 0;
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_dentry->d_inode;
 
 	xid = GetXid();
 
@@ -1053,7 +1057,7 @@ cifs_fsync(struct file *file, struct den
 		dentry->d_name.name, datasync));
 	
 	rc = filemap_fdatawrite(inode->i_mapping);
-	if(rc == 0)
+	if (rc == 0)
 		CIFS_I(inode)->write_behind_rc = 0;
 	FreeXid(xid);
 	return rc;
@@ -1068,7 +1072,7 @@ cifs_sync_page(struct page *page)
 	unsigned int rpages = 0;
 	int rc = 0;
 
-	cFYI(1,("sync page %p",page));
+	cFYI(1, ("sync page %p", page));
 	mapping = page->mapping;
 	if (!mapping)
 		return 0;
@@ -1091,33 +1095,33 @@ cifs_sync_page(struct page *page)
  * for write behind errors.
  *
  */
-int cifs_flush(struct file *file)
+int 
+cifs_flush(struct file *file)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_dentry->d_inode;
 	int rc = 0;
 
-	/* Rather than do the steps manually: */
-	/* lock the inode for writing */
-	/* loop through pages looking for write behind data (dirty pages) */
-	/* coalesce into contiguous 16K (or smaller) chunks to write to server */
-	/* send to server (prefer in parallel) */
-	/* deal with writebehind errors */
-	/* unlock inode for writing */
-	/* filemapfdatawrite appears easier for the time being */
+	/* Rather than do the steps manually:
+	   lock the inode for writing
+	   loop through pages looking for write behind data (dirty pages)
+	   coalesce into contiguous 16K (or smaller) chunks to write to server
+	   send to server (prefer in parallel)
+	   deal with writebehind errors
+	   unlock inode for writing
+	   filemapfdatawrite appears easier for the time being */
 
 	rc = filemap_fdatawrite(inode->i_mapping);
-	if(rc == 0) /* reset wb rc if we were able to write out dirty pages */
+	if (rc == 0) /* reset wb rc if we were able to write out dirty pages */
 		CIFS_I(inode)->write_behind_rc = 0;
 		
-	cFYI(1,("Flush inode %p file %p rc %d",inode,file,rc));
+	cFYI(1, ("Flush inode %p file %p rc %d", inode, file, rc));
 
 	return rc;
 }
 
-
 ssize_t
-cifs_user_read(struct file * file, char __user *read_data, size_t read_size,
-	  loff_t * poffset)
+cifs_user_read(struct file *file, char __user *read_data, size_t read_size,
+	  loff_t *poffset)
 {
 	int rc = -EACCES;
 	unsigned int bytes_read = 0;
@@ -1126,10 +1130,10 @@ cifs_user_read(struct file * file, char 
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
@@ -1145,7 +1149,7 @@ cifs_user_read(struct file * file, char 
 		cFYI(1,("attempting read on write only file instance"));
 	}
 
-	for (total_read = 0,current_offset=read_data; read_size > total_read;
+	for (total_read = 0,current_offset = read_data; read_size > total_read;
 				total_read += bytes_read,current_offset+=bytes_read) {
 		unsigned residue;
 		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
@@ -1155,7 +1159,7 @@ cifs_user_read(struct file * file, char 
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -1199,8 +1203,8 @@ cifs_user_read(struct file * file, char 
 }
 
 static ssize_t
-cifs_read(struct file * file, char *read_data, size_t read_size,
-	  loff_t * poffset)
+cifs_read(struct file *file, char *read_data, size_t read_size,
+	  loff_t *poffset)
 {
 	int rc = -EACCES;
 	unsigned int bytes_read = 0;
@@ -1209,7 +1213,7 @@ cifs_read(struct file * file, char *read
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int xid;
-	char * current_offset;
+	char *current_offset;
 	struct cifsFileInfo * open_file;
 
 	xid = GetXid();
@@ -1222,19 +1226,19 @@ cifs_read(struct file * file, char *read
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
+			total_read += bytes_read, current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read, cifs_sb->rsize);
 		rc = -EAGAIN;
-		while(rc == -EAGAIN) {
+		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -1264,13 +1268,14 @@ cifs_read(struct file * file, char *read
 	return total_read;
 }
 
-int cifs_file_mmap(struct file * file, struct vm_area_struct * vma)
+int 
+cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
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
 		if(cifs_sb != NULL) {
@@ -1283,7 +1288,7 @@ int cifs_file_mmap(struct file * file, s
 	xid = GetXid();
 	rc = cifs_revalidate(dentry);
 	if (rc) {
-		cFYI(1,("Validation prior to mmap failed, error=%d", rc));
+		cFYI(1, ("Validation prior to mmap failed, error=%d", rc));
 		FreeXid(xid);
 		return rc;
 	}
@@ -1292,15 +1297,15 @@ int cifs_file_mmap(struct file * file, s
 	return rc;
 }
 
-static void cifs_copy_cache_pages(struct address_space *mapping, 
-		struct list_head *pages, int bytes_read, 
-		char *data,struct pagevec * plru_pvec)
+static void
+cifs_copy_cache_pages(struct address_space *mapping, struct list_head *pages,
+		      int bytes_read, char *data, struct pagevec *plru_pvec)
 {
 	struct page *page;
-	char * target;
+	char *target;
 
 	while (bytes_read > 0) {
-		if(list_empty(pages))
+		if (list_empty(pages))
 			break;
 
 		page = list_entry(pages->prev, struct page, lru);
@@ -1308,16 +1313,16 @@ static void cifs_copy_cache_pages(struct
 
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
+			memset(target + bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
 			bytes_read = 0;
 		} else {
 			memcpy(target,data,PAGE_CACHE_SIZE);
@@ -1335,7 +1340,6 @@ static void cifs_copy_cache_pages(struct
 	return;
 }
 
-
 static int
 cifs_readpages(struct file *file, struct address_space *mapping,
 		struct list_head *page_list, unsigned num_pages)
@@ -1343,15 +1347,15 @@ cifs_readpages(struct file *file, struct
 	int rc = -EACCES;
 	int xid;
 	loff_t offset;
-	struct page * page;
+	struct page *page;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	int bytes_read = 0;
-	unsigned int read_size,i;
-	char * smb_read_data = NULL;
-	struct smb_com_read_rsp * pSMBr;
+	unsigned int read_size, i;
+	char *smb_read_data = NULL;
+	struct smb_com_read_rsp *pSMBr;
 	struct pagevec lru_pvec;
-	struct cifsFileInfo * open_file;
+	struct cifsFileInfo *open_file;
 
 	xid = GetXid();
 	if (file->private_data == NULL) {
@@ -1364,12 +1368,12 @@ cifs_readpages(struct file *file, struct
 
 	pagevec_init(&lru_pvec, 0);
 
-	for(i = 0;i<num_pages;) {
+	for(i = 0; i < num_pages; ) {
 		unsigned contig_pages;
-		struct page * tmp_page;
+		struct page *tmp_page;
 		unsigned long expected_index;
 
-		if(list_empty(page_list)) {
+		if (list_empty(page_list)) {
 			break;
 		}
 		page = list_entry(page_list->prev, struct page, lru);
@@ -1379,14 +1383,14 @@ cifs_readpages(struct file *file, struct
 		contig_pages = 0;
 		expected_index = list_entry(page_list->prev,struct page,lru)->index;
 		list_for_each_entry_reverse(tmp_page,page_list,lru) {
-			if(tmp_page->index == expected_index) {
+			if (tmp_page->index == expected_index) {
 				contig_pages++;
 				expected_index++;
 			} else {
 				break; 
 			}
 		}
-		if(contig_pages + i >  num_pages) {
+		if (contig_pages + i >  num_pages) {
 			contig_pages = num_pages - i;
 		}
 
@@ -1394,14 +1398,14 @@ cifs_readpages(struct file *file, struct
 
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
 
@@ -1410,15 +1414,15 @@ cifs_readpages(struct file *file, struct
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
@@ -1439,7 +1443,7 @@ cifs_readpages(struct file *file, struct
 			pTcon->bytes_read += bytes_read;
 			spin_unlock(&pTcon->stat_lock);
 #endif
-			if((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
+			if ((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
 				i++; /* account for partial page */
 
 				/* server copy of file can have smaller size than client */
@@ -1454,7 +1458,8 @@ cifs_readpages(struct file *file, struct
 				break; */
 			}
 		} else {
-			cFYI(1,("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list",bytes_read,offset)); 
+			cFYI(1, ("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list", 
+				bytes_read, offset)); 
 			/* BB turn off caching and do new lookup on file size at server? */
 			while (!list_empty(page_list) && (i < num_pages)) {
 				page = list_entry(page_list->prev, struct page, lru);
@@ -1463,7 +1468,7 @@ cifs_readpages(struct file *file, struct
 			}
 			break;
 		}
-		if(smb_read_data) {
+		if (smb_read_data) {
 			cifs_buf_release(smb_read_data);
 			smb_read_data = NULL;
 		}
@@ -1473,7 +1478,7 @@ cifs_readpages(struct file *file, struct
 	pagevec_lru_add(&lru_pvec);
 
 /* need to free smb_read_data buf before exit */
-	if(smb_read_data) {
+	if (smb_read_data) {
 		cifs_buf_release(smb_read_data);
 		smb_read_data = NULL;
 	} 
@@ -1482,7 +1487,8 @@ cifs_readpages(struct file *file, struct
 	return rc;
 }
 
-static int cifs_readpage_worker(struct file *file, struct page *page, loff_t * poffset)
+static int 
+cifs_readpage_worker(struct file *file, struct page *page, loff_t *poffset)
 {
 	char * read_data;
 	int rc;
@@ -1496,7 +1502,7 @@ static int cifs_readpage_worker(struct f
 	if (rc < 0)
 		goto io_error;
 	else {
-		cFYI(1,("Bytes read %d ",rc));
+		cFYI(1, ("Bytes read %d ", rc));
 	}
                                                                                                                            
 	file->f_dentry->d_inode->i_atime = CURRENT_TIME;
@@ -1528,9 +1534,9 @@ cifs_readpage(struct file *file, struct 
 		return -EBADF;
 	}
 
-	cFYI(1,("readpage %p at offset %d 0x%x\n",page,(int)offset,(int)offset));
+	cFYI(1, ("readpage %p at offset %d 0x%x\n", page, (int)offset, (int)offset));
 
-	rc = cifs_readpage_worker(file,page,&offset);
+	rc = cifs_readpage_worker(file, page, &offset);
 
 	unlock_page(page);
 
@@ -1545,34 +1551,35 @@ cifs_readpage(struct file *file, struct 
    but this is tricky to do without racing with writebehind
    page caching in the current Linux kernel design */
    
-int is_size_safe_to_change(struct cifsInodeInfo * cifsInode)
+int 
+is_size_safe_to_change(struct cifsInodeInfo *cifsInode)
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
+		if ((open_file->pfile) && 
+		   ((open_file->pfile->f_flags & O_RDWR) || 
+		   (open_file->pfile->f_flags & O_WRONLY))) {
 			 rc = FALSE;
 			 break;
 		}
-		if(tmp->next == NULL) {
-			cFYI(1,("File instance %p removed",tmp));
+		if (tmp->next == NULL) {
+			cFYI(1, ("File instance %p removed", tmp));
 			break;
 		}
 	}
@@ -1580,10 +1587,9 @@ int is_size_safe_to_change(struct cifsIn
 	return rc;
 }
 
-
 void
-fill_in_inode(struct inode *tmp_inode,
-	      FILE_DIRECTORY_INFO * pfindData, int *pobject_type)
+fill_in_inode(struct inode *tmp_inode, FILE_DIRECTORY_INFO *pfindData, 
+	      int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(tmp_inode->i_sb);
@@ -1604,8 +1610,8 @@ fill_in_inode(struct inode *tmp_inode,
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
@@ -1634,11 +1640,11 @@ fill_in_inode(struct inode *tmp_inode,
 	}/* could add code here - to validate if device or weird share type? */
 
 	/* can not fill in nlink here as in qpathinfo version and Unx search */
-	if(atomic_read(&cifsInfo->inUse) == 0) {
+	if (atomic_read(&cifsInfo->inUse) == 0) {
 		atomic_set(&cifsInfo->inUse,1);
 	}
 
-	if(is_size_safe_to_change(cifsInfo)) {
+	if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the 
 		client is writing to it due to potential races */
 		i_size_write(tmp_inode,end_of_file);
@@ -1674,8 +1680,8 @@ fill_in_inode(struct inode *tmp_inode,
 }
 
 void
-unix_fill_in_inode(struct inode *tmp_inode,
-		   FILE_UNIX_INFO * pfindData, int *pobject_type)
+unix_fill_in_inode(struct inode *tmp_inode, FILE_UNIX_INFO *pfindData,
+		   int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	__u32 type = le32_to_cpu(pfindData->Type);
@@ -1724,10 +1730,10 @@ unix_fill_in_inode(struct inode *tmp_ino
 	tmp_inode->i_nlink = le64_to_cpu(pfindData->Nlinks);
 
 
-	if(is_size_safe_to_change(cifsInfo)) {
+	if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the 
 		client is writing to it due to potential races */
-		i_size_write(tmp_inode,end_of_file);
+		i_size_write(tmp_inode, end_of_file);
 
 	/* 512 bytes (2**9) is the fake blocksize that must be used */
 	/* for this calculation, not the real blocksize */
@@ -1775,24 +1781,24 @@ construct_dentry(struct qstr *qstring, s
 		cFYI(0, (" existing dentry with inode 0x%p", tmp_dentry->d_inode));
 		*ptmp_inode = tmp_dentry->d_inode;
 		/* BB overwrite the old name? i.e. tmp_dentry->d_name and tmp_dentry->d_name.len ?? */
-		if(*ptmp_inode == NULL) {
+		if (*ptmp_inode == NULL) {
 	                *ptmp_inode = new_inode(file->f_dentry->d_sb);
-			if(*ptmp_inode == NULL)
+			if (*ptmp_inode == NULL)
 				return rc;
 			rc = 1;
 			d_instantiate(tmp_dentry, *ptmp_inode);
 		}
 	} else {
 		tmp_dentry = d_alloc(file->f_dentry, qstring);
-		if(tmp_dentry == NULL) {
-			cERROR(1,("Failed allocating dentry"));
+		if (tmp_dentry == NULL) {
+			cERROR(1, ("Failed allocating dentry"));
 			*ptmp_inode = NULL;
 			return rc;
 		}
 			
 		*ptmp_inode = new_inode(file->f_dentry->d_sb);
 		tmp_dentry->d_op = &cifs_dentry_ops;
-		if(*ptmp_inode == NULL)
+		if (*ptmp_inode == NULL)
 			return rc;
 		rc = 1;
 		d_instantiate(tmp_dentry, *ptmp_inode);
@@ -1804,9 +1810,10 @@ construct_dentry(struct qstr *qstring, s
 	return rc; 
 }
 
-static void reset_resume_key(struct file * dir_file, 
-				unsigned char * filename, 
-				unsigned int len,int Unicode,struct nls_table * nls_tab) {
+static void 
+reset_resume_key(struct file *dir_file, unsigned char *filename,
+		 unsigned int len, int Unicode, struct nls_table *nls_tab)
+{
 	struct cifsFileInfo *cifsFile;
 
 	cifsFile = (struct cifsFileInfo *)dir_file->private_data;
@@ -1816,47 +1823,45 @@ static void reset_resume_key(struct file
 		kfree(cifsFile->search_resume_name);
 	}
 
-	if(Unicode) 
+	if (Unicode) 
 		len *= 2;
-	cifsFile->resume_name_length = len;
 
+	cifsFile->resume_name_length = len;
 	cifsFile->search_resume_name = 
 		kmalloc(cifsFile->resume_name_length, GFP_KERNEL);
 
 	if(cifsFile->search_resume_name == NULL) {
-		cERROR(1,("failed new resume key allocate, length %d",
+		cERROR(1, ("failed new resume key allocate, length %d",
 				  cifsFile->resume_name_length));
 		return;
 	}
-	if(Unicode)
-		cifs_strtoUCS((wchar_t *) cifsFile->search_resume_name,
+	if (Unicode)
+		cifs_strtoUCS((wchar_t *)cifsFile->search_resume_name,
 			filename, len, nls_tab);
 	else
 		memcpy(cifsFile->search_resume_name, filename, 
 		   cifsFile->resume_name_length);
-	cFYI(1,("Reset resume key to: %s with len %d",filename,len));
+	cFYI(1, ("Reset resume key to: %s with len %d", filename, len));
 	return;
 }
 
-
-
 static int
-cifs_filldir(struct qstr *pqstring, FILE_DIRECTORY_INFO * pfindData,
+cifs_filldir(struct qstr *pqstring, FILE_DIRECTORY_INFO *pfindData,
 	     struct file *file, filldir_t filldir, void *direntry)
 {
 	struct inode *tmp_inode;
 	struct dentry *tmp_dentry;
-	int object_type,rc;
+	int object_type, rc;
 
 	pqstring->name = pfindData->FileName;
 	/* pqstring->len is already set by caller */
 
 	rc = construct_dentry(pqstring, file, &tmp_inode, &tmp_dentry);
-	if((tmp_inode == NULL) || (tmp_dentry == NULL)) {
+	if ((tmp_inode == NULL) || (tmp_dentry == NULL)) {
 		return -ENOMEM;
 	}
 	fill_in_inode(tmp_inode, pfindData, &object_type);
-	if(rc) {
+	if (rc) {
 		/* We have no reliable way to get inode numbers
 		from servers w/o Unix extensions yet so we can not set
 		i_ino from pfindData yet */
@@ -1866,19 +1871,18 @@ cifs_filldir(struct qstr *pqstring, FILE
 	} /* else if inode number changed do we rehash it? */
 	rc = filldir(direntry, pfindData->FileName, pqstring->len, file->f_pos,
 		tmp_inode->i_ino, object_type);
-	if(rc) {
+	if (rc) {
 		/* due to readdir error we need to recalculate resume 
 		key so next readdir will restart on right entry */
-		cFYI(1,("Error %d on filldir of %s",rc ,pfindData->FileName));
+		cFYI(1, ("Error %d on filldir of %s", rc, pfindData->FileName));
 	}
 	dput(tmp_dentry);
 	return rc;
 }
 
 static int
-cifs_filldir_unix(struct qstr *pqstring,
-		  FILE_UNIX_INFO * pUnixFindData, struct file *file,
-		  filldir_t filldir, void *direntry)
+cifs_filldir_unix(struct qstr *pqstring, FILE_UNIX_INFO *pUnixFindData, 
+		  struct file *file, filldir_t filldir, void *direntry)
 {
 	struct inode *tmp_inode;
 	struct dentry *tmp_dentry;
@@ -1888,13 +1892,13 @@ cifs_filldir_unix(struct qstr *pqstring,
 	pqstring->len = strnlen(pUnixFindData->FileName, MAX_PATHCONF);
 
 	rc = construct_dentry(pqstring, file, &tmp_inode, &tmp_dentry);
-	if((tmp_inode == NULL) || (tmp_dentry == NULL)) {
+	if ((tmp_inode == NULL) || (tmp_dentry == NULL)) {
 		return -ENOMEM;
 	} 
-	if(rc) {
+	if (rc) {
 		struct cifs_sb_info *cifs_sb = CIFS_SB(tmp_inode->i_sb);
 
-		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
+		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 			tmp_inode->i_ino = 
 				(unsigned long)pUnixFindData->UniqueId;
 		}
@@ -1903,10 +1907,10 @@ cifs_filldir_unix(struct qstr *pqstring,
 	unix_fill_in_inode(tmp_inode, pUnixFindData, &object_type);
 	rc = filldir(direntry, pUnixFindData->FileName, pqstring->len,
 		file->f_pos, tmp_inode->i_ino, object_type);
-	if(rc) {
+	if (rc) {
 		/* due to readdir error we need to recalculate resume 
 			key so next readdir will restart on right entry */
-		cFYI(1,("Error %d on filldir of %s",rc ,pUnixFindData->FileName));
+		cFYI(1, ("Error %d on filldir of %s", rc, pUnixFindData->FileName));
 	}
 	dput(tmp_dentry);
 	return rc;
@@ -1935,14 +1939,14 @@ cifs_readdir(struct file *file, void *di
 
 
     /* BB removeme begin */
-	if(!experimEnabled)
-		return cifs_readdir2(file,direntry,filldir);
+	if (!experimEnabled)
+		return cifs_readdir2(file, direntry, filldir);
     /* BB removeme end */
 
 
 	xid = GetXid();
 
-	if(file->f_dentry == NULL) {
+	if (file->f_dentry == NULL) {
 		rc = -EIO;
 		FreeXid(xid);
 		return rc;
@@ -1950,14 +1954,14 @@ cifs_readdir(struct file *file, void *di
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 	bufsize = pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE;
-	if(bufsize > CIFSMaxBufSize) {
+	if (bufsize > CIFSMaxBufSize) {
 		rc = -EIO;
 		FreeXid(xid);
 		return rc;
 	}
 	data = kmalloc(bufsize, GFP_KERNEL);
-	pfindData = (FILE_DIRECTORY_INFO *) data;
-	if(data == NULL) {
+	pfindData = (FILE_DIRECTORY_INFO *)data;
+	if (data == NULL) {
 		rc = -ENOMEM;
 		FreeXid(xid);
 		return rc;
@@ -1966,14 +1970,14 @@ cifs_readdir(struct file *file, void *di
 	full_path = build_wildcard_path_from_dentry(file->f_dentry);
 	up(&file->f_dentry->d_sb->s_vfs_rename_sem);
 
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		kfree(data);
 		FreeXid(xid);
 		return -ENOMEM;
 	}
 	cFYI(1, ("Full path: %s start at: %lld ", full_path, file->f_pos));
 
-	switch ((int) file->f_pos) {
+	switch ((int)file->f_pos) {
 	case 0:
 		if (filldir(direntry, ".", 1, file->f_pos,
 		     file->f_dentry->d_inode->i_ino, DT_DIR) < 0) {
@@ -1993,7 +1997,7 @@ cifs_readdir(struct file *file, void *di
 	case 2:
 		if (file->private_data != NULL) {
 			cifsFile =
-				(struct cifsFileInfo *) file->private_data;
+				(struct cifsFileInfo *)file->private_data;
 			if (cifsFile->srch_inf.endOfSearch) {
 				if(cifsFile->srch_inf.emptyDir) {
 					cFYI(1, ("End of search, empty dir"));
@@ -2004,7 +2008,7 @@ cifs_readdir(struct file *file, void *di
 				cifsFile->invalidHandle = TRUE;
 				CIFSFindClose(xid, pTcon, cifsFile->netfid);
 			}
-			if(cifsFile->search_resume_name) {
+			if (cifsFile->search_resume_name) {
 				kfree(cifsFile->search_resume_name);
 				cifsFile->search_resume_name = NULL;
 			}
@@ -2019,9 +2023,9 @@ cifs_readdir(struct file *file, void *di
 		if (rc == 0) {
 			__u16 count = le16_to_cpu(findParms.SearchCount);
 			searchHandle = findParms.SearchHandle;
-			if(file->private_data == NULL)
+			if (file->private_data == NULL)
 				file->private_data =
-					kmalloc(sizeof(struct cifsFileInfo),GFP_KERNEL);
+					kmalloc(sizeof(struct cifsFileInfo), GFP_KERNEL);
 			if (file->private_data) {
 				memset(file->private_data, 0,
 				       sizeof (struct cifsFileInfo));
@@ -2037,30 +2041,30 @@ cifs_readdir(struct file *file, void *di
 
 			renew_parental_timestamps(file->f_dentry);
 			lastFindData = 
-				(FILE_DIRECTORY_INFO *) ((char *) pfindData + 
+				(FILE_DIRECTORY_INFO *)((char *) pfindData + 
 					le16_to_cpu(findParms.LastNameOffset));
-			if((char *)lastFindData > (char *)pfindData + bufsize) {
-				cFYI(1,("last search entry past end of packet"));
+			if ((char *)lastFindData > (char *)pfindData + bufsize) {
+				cFYI(1, ("last search entry past end of packet"));
 				rc = -EIO;
 				break;
 			}
 			/* Offset of resume key same for levels 257 and 514 */
 			cifsFile->srch_inf.resume_key = lastFindData->FileIndex;
-			if(UnixSearch == FALSE) {
+			if (UnixSearch == FALSE) {
 				cifsFile->resume_name_length = 
 					le32_to_cpu(lastFindData->FileNameLength);
-				if(cifsFile->resume_name_length > bufsize - 64) {
-					cFYI(1,("Illegal resume file name length %d",
+				if (cifsFile->resume_name_length > bufsize - 64) {
+					cFYI(1, ("Illegal resume file name length %d",
 						cifsFile->resume_name_length));
 					rc = -ENOMEM;
 					break;
 				}
 				cifsFile->search_resume_name = 
 					kmalloc(cifsFile->resume_name_length, GFP_KERNEL);
-				cFYI(1,("Last file: %s with name %d bytes long",
+				cFYI(1, ("Last file: %s with name %d bytes long",
 					lastFindData->FileName,
 					cifsFile->resume_name_length));
-				if(cifsFile->search_resume_name == NULL) {
+				if (cifsFile->search_resume_name == NULL) {
 					rc = -ENOMEM;
 					break;
 				}
@@ -2070,30 +2074,30 @@ cifs_readdir(struct file *file, void *di
 			} else {
 				pfindDataUnix = (FILE_UNIX_INFO *)lastFindData;
 				if (Unicode == TRUE) {
-					for(i=0;(pfindDataUnix->FileName[i] 
+					for(i = 0; (pfindDataUnix->FileName[i] 
 						    | pfindDataUnix->FileName[i+1]);
-						i+=2) {
-						if(i > bufsize-64)
+						i += 2) {
+						if (i > bufsize - 64)
 							break;
 					}
 					cifsFile->resume_name_length = i + 2;
 				} else {
 					cifsFile->resume_name_length = 
 						strnlen(pfindDataUnix->FileName,
-							bufsize-63);
+							bufsize - 63);
 				}
-				if(cifsFile->resume_name_length > bufsize - 64) {
-					cFYI(1,("Illegal resume file name length %d",
+				if (cifsFile->resume_name_length > bufsize - 64) {
+					cFYI(1, ("Illegal resume file name length %d",
 						cifsFile->resume_name_length));
 					rc = -ENOMEM;
 					break;
 				}
 				cifsFile->search_resume_name = 
 					kmalloc(cifsFile->resume_name_length, GFP_KERNEL);
-				cFYI(1,("Last file: %s with name %d bytes long",
+				cFYI(1, ("Last file: %s with name %d bytes long",
 					pfindDataUnix->FileName,
 					cifsFile->resume_name_length));
-				if(cifsFile->search_resume_name == NULL) {
+				if (cifsFile->search_resume_name == NULL) {
 					rc = -ENOMEM;
 					break;
 				}
@@ -2127,7 +2131,7 @@ cifs_readdir(struct file *file, void *di
 							/* do not end search if
 								kernel not ready to take
 								remaining entries yet */
-							reset_resume_key(file, pfindData->FileName,qstring.len,
+							reset_resume_key(file, pfindData->FileName, qstring.len,
 								Unicode, cifs_sb->local_nls);
 							findParms.EndofSearch = 0;
 							break;
@@ -2136,7 +2140,7 @@ cifs_readdir(struct file *file, void *di
 					}
 				} else {	/* UnixSearch */
 					pfindDataUnix =
-					    (FILE_UNIX_INFO *) pfindData;
+					    (FILE_UNIX_INFO *)pfindData;
 					if (Unicode == TRUE)
 						qstring.len =
 							cifs_strfromUCS_le
@@ -2158,7 +2162,7 @@ cifs_readdir(struct file *file, void *di
 						    FileName[0] != '.')
 						|| (pfindDataUnix->
 						    FileName[1] != '.'))) {
-						if(cifs_filldir_unix(&qstring,
+						if (cifs_filldir_unix(&qstring,
 								  pfindDataUnix,
 								  file,
 								  filldir,
@@ -2168,7 +2172,7 @@ cifs_readdir(struct file *file, void *di
 								remaining entries yet */
 							findParms.EndofSearch = 0;
 							reset_resume_key(file, pfindDataUnix->FileName,
-								qstring.len,Unicode,cifs_sb->local_nls);
+								qstring.len, Unicode, cifs_sb->local_nls);
 							break;
 						}
 						file->f_pos++;
@@ -2213,7 +2217,7 @@ cifs_readdir(struct file *file, void *di
 				cifsFile->resume_name_length,
 				cifsFile->srch_inf.resume_key,
 				&Unicode, &UnixSearch);
-			cFYI(1,("Count: %d  End: %d ",
+			cFYI(1, ("Count: %d  End: %d ",
 			      le16_to_cpu(findNextParms.SearchCount),
 			      le16_to_cpu(findNextParms.EndofSearch)));
 			if ((rc == 0) && (findNextParms.SearchCount != 0)) {
@@ -2222,8 +2226,8 @@ cifs_readdir(struct file *file, void *di
 				lastFindData = 
 					(FILE_DIRECTORY_INFO *) ((char *) pfindData 
 					+ le16_to_cpu(findNextParms.LastNameOffset));
-				if((char *)lastFindData > (char *)pfindData + bufsize) {
-					cFYI(1,("last search entry past end of packet"));
+				if ((char *)lastFindData > (char *)pfindData + bufsize) {
+					cFYI(1, ("last search entry past end of packet"));
 					rc = -EIO;
 					break;
 				}
@@ -2233,8 +2237,8 @@ cifs_readdir(struct file *file, void *di
 				if(UnixSearch == FALSE) {
 					cifsFile->resume_name_length = 
 						le32_to_cpu(lastFindData->FileNameLength);
-					if(cifsFile->resume_name_length > bufsize - 64) {
-						cFYI(1,("Illegal resume file name length %d",
+					if (cifsFile->resume_name_length > bufsize - 64) {
+						cFYI(1, ("Illegal resume file name length %d",
 							cifsFile->resume_name_length));
 						rc = -ENOMEM;
 						break;
@@ -2242,14 +2246,14 @@ cifs_readdir(struct file *file, void *di
 					/* Free the memory allocated by previous findfirst 
 					or findnext call - we can not reuse the memory since
 					the resume name may not be same string length */
-					if(cifsFile->search_resume_name)
+					if (cifsFile->search_resume_name)
 						kfree(cifsFile->search_resume_name);
 					cifsFile->search_resume_name = 
 						kmalloc(cifsFile->resume_name_length, GFP_KERNEL);
-					cFYI(1,("Last file: %s with name %d bytes long",
+					cFYI(1, ("Last file: %s with name %d bytes long",
 						lastFindData->FileName,
 						cifsFile->resume_name_length));
-					if(cifsFile->search_resume_name == NULL) {
+					if (cifsFile->search_resume_name == NULL) {
 						rc = -ENOMEM;
 						break;
 					}
@@ -2260,10 +2264,10 @@ cifs_readdir(struct file *file, void *di
 				} else {
 					pfindDataUnix = (FILE_UNIX_INFO *)lastFindData;
 					if (Unicode == TRUE) {
-						for(i=0;(pfindDataUnix->FileName[i] 
+						for (i=0; (pfindDataUnix->FileName[i] 
 								| pfindDataUnix->FileName[i+1]);
-							i+=2) {
-							if(i > bufsize-64)
+							i += 2) {
+							if (i > bufsize - 64)
 								break;
 						}
 						cifsFile->resume_name_length = i + 2;
@@ -2273,8 +2277,8 @@ cifs_readdir(struct file *file, void *di
 							 FileName,
 							 MAX_PATHCONF);
 					}
-					if(cifsFile->resume_name_length > bufsize - 64) {
-						cFYI(1,("Illegal resume file name length %d",
+					if (cifsFile->resume_name_length > bufsize - 64) {
+						cFYI(1, ("Illegal resume file name length %d",
 								cifsFile->resume_name_length));
 						rc = -ENOMEM;
 						break;
@@ -2282,14 +2286,14 @@ cifs_readdir(struct file *file, void *di
 					/* Free the memory allocated by previous findfirst 
 					or findnext call - we can not reuse the memory since
 					the resume name may not be same string length */
-					if(cifsFile->search_resume_name)
+					if (cifsFile->search_resume_name)
 						kfree(cifsFile->search_resume_name);
 					cifsFile->search_resume_name = 
 						kmalloc(cifsFile->resume_name_length, GFP_KERNEL);
-					cFYI(1,("fnext last file: %s with name %d bytes long",
+					cFYI(1, ("fnext last file: %s with name %d bytes long",
 						pfindDataUnix->FileName,
 						cifsFile->resume_name_length));
-					if(cifsFile->search_resume_name == NULL) {
+					if (cifsFile->search_resume_name == NULL) {
 						rc = -ENOMEM;
 						break;
 					}
@@ -2368,8 +2372,8 @@ cifs_readdir(struct file *file, void *di
 								kernel not ready to take
 								remaining entries yet */
 								findNextParms.EndofSearch = 0;
-								reset_resume_key(file, pfindDataUnix->FileName,qstring.len,
-									Unicode,cifs_sb->local_nls);
+								reset_resume_key(file, pfindDataUnix->FileName, qstring.len,
+									Unicode, cifs_sb->local_nls);
 								break;
 							}
 							file->f_pos++;
@@ -2394,16 +2398,18 @@ cifs_readdir(struct file *file, void *di
 		kfree(data);
 	if (full_path)
 		kfree(full_path);
-	FreeXid(xid);
 
+	FreeXid(xid);
 	return rc;
 }
-int cifs_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
+
+int 
+cifs_prepare_write(struct file *file, struct page *page, unsigned from, 
+		   unsigned to)
 {
 	int rc = 0;
         loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
-	cFYI(1,("prepare write for page %p from %d to %d",page,from,to));
+	cFYI(1, ("prepare write for page %p from %d to %d",page,from,to));
 	if (!PageUptodate(page)) {
 	/*	if (to - from != PAGE_CACHE_SIZE) {
 			void *kaddr = kmap_atomic(page, KM_USER0);
@@ -2414,12 +2420,12 @@ int cifs_prepare_write(struct file *file
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
 		file handle if there is one - how would we lock it
@@ -2432,7 +2438,6 @@ int cifs_prepare_write(struct file *file
 	return 0;
 }
 
-
 struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
 	.readpages = cifs_readpages,
