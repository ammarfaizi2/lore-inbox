Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCZOCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCZOCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVCZOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:02:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:62612 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262077AbVCZN7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:59:23 -0500
Date: Sat, 26 Mar 2005 15:01:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][3/6] cifs: inode.c cleanup - comments
Message-ID: <Pine.LNX.4.62.0503261459270.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comments to follow consistent style established by previous cleanups. 
Tiny changes have been made to a few comments to make them 
either fit on one line, or add a question mark or similar. 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/inode.c.with_patch2	2005-03-26 13:53:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 13:54:08.000000000 +0100
@@ -57,7 +57,8 @@ int cifs_get_inode_info_unix(struct inod
 			if (tmp_path == NULL) {
 				return -ENOMEM;
 			}
-        /* have to skip first of the double backslash of UNC name */
+        		/* have to skip first of the double backslash of
+			   UNC name */
 			strncpy(tmp_path, pTcon->treeName, MAX_TREE_SIZE);
 			strncat(tmp_path, search_path, MAX_PATHCONF);
 			rc = connect_to_dfs_path(xid, pTcon->ses,
@@ -82,7 +83,7 @@ int cifs_get_inode_info_unix(struct inod
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? */
 			/* Are there sanity checks we can use to ensure that
-			the server is really filling in that field? */
+			   the server is really filling in that field? */
 			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 				(*pinode)->i_ino =
 					(unsigned long)findData.UniqueId;
@@ -131,24 +132,26 @@ int cifs_get_inode_info_unix(struct inod
 		inode->i_nlink = le64_to_cpu(findData.Nlinks);
 
 		if (is_size_safe_to_change(cifsInfo)) {
-		/* can not safely change the file size here if the
-		   client is writing to it due to potential races */
+		/* can not safely change the file size here if the client is
+		   writing to it due to potential races */
 
 			i_size_write(inode, end_of_file);
-/* blksize needs to be multiple of two. So safer to default to blksize
-	and blkbits set in superblock so 2**blkbits and blksize will match */
-/*		inode->i_blksize = (pTcon->ses->server->maxBuf -
-				    MAX_CIFS_HDR_SIZE) & 0xFFFFFE00; */
-
-		/* This seems incredibly stupid but it turns out that
-		i_blocks is not related to (i_size / i_blksize), instead a
-		size of 512 is required to be used for calculating num blocks */
+			/* blksize needs to be multiple of two. So safer to
+			   default to blksize and blkbits set in superblock so
+			   2**blkbits and blksize will match */
+/*			inode->i_blksize = (pTcon->ses->server->maxBuf -
+					    MAX_CIFS_HDR_SIZE) & 0xFFFFFE00; */
+
+			/* This seems incredibly stupid but it turns out that
+			   i_blocks is not related to (i_size / i_blksize),
+			   instead a size of 512 is required to be used for
+			   calculating num blocks */
 
-/*		inode->i_blocks = (inode->i_blksize - 1 + num_of_bytes) >>
-				   inode->i_blkbits; */
+/*			inode->i_blocks = (inode->i_blksize - 1 + num_of_bytes)
+					  >> inode->i_blkbits; */
 
-		/* 512 bytes (2**9) is the fake blocksize that must be used */
-		/* for this calculation */
+			/* 512 bytes (2**9) is the fake blocksize that must be
+			   used for this calculation */
 			inode->i_blocks = (512 - 1 + num_of_bytes) >> 9;
 		}
 
@@ -207,7 +210,7 @@ int cifs_get_inode_info(struct inode **p
 		if (buf == NULL)
 			return -ENOMEM;
 		pfindData = (FILE_ALL_INFO *)buf;
-	/* could do find first instead but this returns more info */
+		/* could do find first instead but this returns more info */
 		rc = CIFSSMBQPathInfo(xid, pTcon, search_path, pfindData,
 				      cifs_sb->local_nls);
 	}
@@ -247,13 +250,13 @@ int cifs_get_inode_info(struct inode **p
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? */
 			/* Are there sanity checks we can use to ensure that
-			the server is really filling in that field? */
+			   the server is really filling in that field? */
 
-			/* We can not use the IndexNumber from either
-			Windows or Samba as it is frequently set to zero */
-			/* There may be higher info levels that work but
-			Are there Windows server or network appliances
-			for which IndexNumber field is not guaranteed unique? */
+			/* We can not use the IndexNumber from either Windows
+			   or Samba as it is frequently set to zero */
+			/* There may be higher info levels that work but are
+			   there Windows server or network appliances for which
+			   IndexNumber field is not guaranteed unique? */
 		
 /*			if (cifs_sb->mnt_cifs_flags &
 			    CIFS_MOUNT_SERVER_INUM) {
@@ -271,12 +274,14 @@ int cifs_get_inode_info(struct inode **p
 		cifsInfo->time = jiffies;
 		cFYI(1, (" New time %ld ", cifsInfo->time));
 
-/* blksize needs to be multiple of two. So safer to default to blksize
-        and blkbits set in superblock so 2**blkbits and blksize will match */
+		/* blksize needs to be multiple of two. So safer to default to
+		   blksize and blkbits set in superblock so 2**blkbits and
+		   blksize will match */
 /*		inode->i_blksize = (pTcon->ses->server->maxBuf -
 				    MAX_CIFS_HDR_SIZE) & 0xFFFFFE00; */
 
-		/* Linux can not store file creation time unfortunately so we ignore it */
+		/* Linux can not store file creation time unfortunately so we
+		   ignore it */
 		inode->i_atime =
 		    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastAccessTime));
 		inode->i_mtime =
@@ -291,26 +296,29 @@ int cifs_get_inode_info(struct inode **p
 			inode->i_mode = cifs_sb->mnt_file_mode;
 
 /*		if (attr & ATTR_REPARSE)  */
-/* 		We no longer handle these as symlinks because we could not */
-/* 		follow them due to the absolute path with drive letter */
+		/* We no longer handle these as symlinks because we could not
+		   follow them due to the absolute path with drive letter */
 		if (attr & ATTR_DIRECTORY) {
-	/* override default perms since we do not do byte range locking on dirs */
+		/* override default perms since we do not do byte range locking
+		   on dirs */
 			inode->i_mode = cifs_sb->mnt_dir_mode;
 			inode->i_mode |= S_IFDIR;
 		} else {
 			inode->i_mode |= S_IFREG;
-			/* treat the dos attribute of read-only as read-only mode e.g. 555 */
+			/* treat the dos attribute of read-only as read-only
+			   mode e.g. 555 */
 			if (cifsInfo->cifsAttrs & ATTR_READONLY)
 				inode->i_mode &= ~(S_IWUGO);
-   /* BB add code here - validate if device or weird share or device type? */
+		/* BB add code here -
+		   validate if device or weird share or device type? */
 		}
 		if (is_size_safe_to_change(cifsInfo)) {
-		/* can not safely change the file size here if the 
-		client is writing to it due to potential races */
+			/* can not safely change the file size here if the
+			   client is writing to it due to potential races */
 			i_size_write(inode,le64_to_cpu(pfindData->EndOfFile));
 
-		/* 512 bytes (2**9) is the fake blocksize that must be used */
-		/* for this calculation */
+			/* 512 bytes (2**9) is the fake blocksize that must be
+			   used for this calculation */
 			inode->i_blocks = (512 - 1 + le64_to_cpu(
 					   pfindData->AllocationSize)) >> 9;
 		}
@@ -318,12 +326,12 @@ int cifs_get_inode_info(struct inode **p
 		inode->i_nlink = le32_to_cpu(pfindData->NumberOfLinks);
 
 		/* BB fill in uid and gid here? with help from winbind? 
-			or retrieve from NTFS stream extended attribute */
+		   or retrieve from NTFS stream extended attribute */
 		if (atomic_read(&cifsInfo->inUse) == 0) {
 			inode->i_uid = cifs_sb->mnt_uid;
 			inode->i_gid = cifs_sb->mnt_gid;
 			/* set so we do not keep refreshing these fields with
-			bad data after user has changed them in memory */
+			   bad data after user has changed them in memory */
 			atomic_set(&cifsInfo->inUse,1);
 		}
 
@@ -349,8 +357,9 @@ int cifs_get_inode_info(struct inode **p
 	return rc;
 }
 
+/* gets root inode */
 void cifs_read_inode(struct inode *inode)
-{				/* gets root inode */
+{
 	int xid;
 	struct cifs_sb_info *cifs_sb;
 
@@ -381,8 +390,8 @@ int cifs_unlink(struct inode *inode, str
 	cifs_sb = CIFS_SB(inode->i_sb);
 	pTcon = cifs_sb->tcon;
 
-/* Unlink can be called from rename so we can not grab
-	the sem here since we deadlock otherwise */
+	/* Unlink can be called from rename so we can not grab the sem here
+	   since we deadlock otherwise */
 /*	down(&direntry->d_sb->s_vfs_rename_sem);*/
 	full_path = build_path_from_dentry(direntry);
 /*	up(&direntry->d_sb->s_vfs_rename_sem);*/
@@ -415,7 +424,7 @@ int cifs_unlink(struct inode *inode, str
 						       GFP_KERNEL);
 		if (pinfo_buf) {
 			memset(pinfo_buf, 0, sizeof(FILE_BASIC_INFO));
-		/* ATTRS set to normal clears r/o bit */
+			/* ATTRS set to normal clears r/o bit */
 			pinfo_buf->Attributes = cpu_to_le32(ATTR_NORMAL);
 			if (!(pTcon->ses->flags & CIFS_SES_NT4))
 				rc = CIFSSMBSetTimes(xid, pTcon, full_path,
@@ -431,12 +440,13 @@ int cifs_unlink(struct inode *inode, str
 							  full_path,
 							  (__u16)ATTR_NORMAL,
 							  cifs_sb->local_nls); 
-			For some strange reason it seems that NT4 eats the
-			old setattr call without actually setting the attributes
-			so on to the third attempted workaround ... */
+			   For some strange reason it seems that NT4 eats the
+			   old setattr call without actually setting the
+			   attributes so on to the third attempted workaround
+			   */
 
-			/* BB could scan to see if we already have it open */
-			/* and pass in pid of opener to function */
+			/* BB could scan to see if we already have it open
+			   and pass in pid of opener to function */
 				rc = CIFSSMBOpen(xid, pTcon, full_path,
 						 FILE_OPEN, SYNCHRONIZE |
 						 FILE_WRITE_ATTRIBUTES, 0,
@@ -478,7 +488,8 @@ int cifs_unlink(struct inode *inode, str
 		}
 	}
 	cifsInode = CIFS_I(direntry->d_inode);
-	cifsInode->time = 0;	/* will force revalidate to get info when needed */
+	cifsInode->time = 0;	/* will force revalidate to get info when
+				   needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
 		current_fs_time(inode->i_sb);
 	cifsInode = CIFS_I(inode);
@@ -545,9 +556,10 @@ int cifs_mkdir(struct inode *inode, stru
 						    (__u64)-1, 0 /* dev_t */,
 						    cifs_sb->local_nls);
 			}
-		else { /* BB to be implemented via Windows secrty descriptors*/
-		/* eg CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, -1, -1,
-					 local_nls); */
+		else {
+			/* BB to be implemented via Windows secrty descriptors
+			   eg CIFSSMBWinSetPerms(xid, pTcon, full_path, mode,
+						 -1, -1, local_nls); */
 		}
 	}
 	if (full_path)
@@ -590,7 +602,8 @@ int cifs_rmdir(struct inode *inode, stru
 	}
 
 	cifsInode = CIFS_I(direntry->d_inode);
-	cifsInode->time = 0;	/* force revalidate to go get info when needed */
+	cifsInode->time = 0;	/* force revalidate to go get info when
+				   needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
 		current_fs_time(inode->i_sb);
 
@@ -619,12 +632,13 @@ int cifs_rename(struct inode *source_ino
 
 	if (pTcon != cifs_sb_target->tcon) {
 		FreeXid(xid);
-		return -EXDEV;	/* BB actually could be allowed if same server, but
-                     different share. Might eventually add support for this */
+		return -EXDEV;	/* BB actually could be allowed if same server,
+				   but different share.
+				   Might eventually add support for this */
 	}
 
-	/* we already  have the rename sem so we do not need
-	to grab it again here to protect the path integrity */
+	/* we already  have the rename sem so we do not need to grab it again
+	   here to protect the path integrity */
 	fromName = build_path_from_dentry(source_direntry);
 	toName = build_path_from_dentry(target_direntry);
 	if ((fromName == NULL) || (toName == NULL)) {
@@ -635,8 +649,8 @@ int cifs_rename(struct inode *source_ino
 	rc = CIFSSMBRename(xid, pTcon, fromName, toName,
 			   cifs_sb_source->local_nls);
 	if (rc == -EEXIST) {
-		/* check if they are the same file 
-		because rename of hardlinked files is a noop */
+		/* check if they are the same file because rename of hardlinked
+		   files is a noop */
 		FILE_UNIX_BASIC_INFO *info_buf_source;
 		FILE_UNIX_BASIC_INFO *info_buf_target;
 
@@ -654,13 +668,14 @@ int cifs_rename(struct inode *source_ino
 			if ((rc == 0) &&
 			    (info_buf_source->UniqueId ==
 			     info_buf_target->UniqueId)) {
-			/* do not rename since the files are hardlinked 
-			   which is a noop */
+			/* do not rename since the files are hardlinked which
+			   is a noop */
 			} else {
 			/* we either can not tell the files are hardlinked
-			(as with Windows servers) or files are not hardlinked 
-			so delete the target manually before renaming to
-			follow POSIX rather than Windows semantics */
+			   (as with Windows servers) or files are not
+			   hardlinked so delete the target manually before
+			   renaming to follow POSIX rather than Windows
+			   semantics */
 				cifs_unlink(target_inode, target_direntry);
 				rc = CIFSSMBRename(xid, pTcon, fromName,
 						   toName,
@@ -680,8 +695,8 @@ int cifs_rename(struct inode *source_ino
 
 		/* BB FIXME Is Generic Read correct for rename? */
 		/* if renaming directory - we should not say CREATE_NOT_DIR,
-		need to test renaming open directory, also GENERIC_READ
-		might not right be right access to request */
+		   need to test renaming open directory, also GENERIC_READ
+		   might not right be right access to request */
 		rc = CIFSSMBOpen(xid, pTcon, fromName, FILE_OPEN, GENERIC_READ,
 				 CREATE_NOT_DIR, &netfid, &oplock, NULL,
 				 cifs_sb_source->local_nls);
@@ -729,8 +744,8 @@ int cifs_revalidate(struct dentry *diren
 
 	cifs_sb = CIFS_SB(direntry->d_sb);
 
-	/* can not safely grab the rename sem here if
-	rename calls revalidate since that would deadlock */
+	/* can not safely grab the rename sem here if rename calls revalidate
+	   since that would deadlock */
 	full_path = build_path_from_dentry(direntry);
 	if (full_path == NULL) {
 		FreeXid(xid);
@@ -766,7 +781,8 @@ int cifs_revalidate(struct dentry *diren
 		if (rc) {
 			cFYI(1, ("error on getting revalidate info %d", rc));
 /*			if (rc != -ENOENT)
-				rc = 0; */ /* BB should we cache info on certain errors? */
+				rc = 0; */	/* BB should we cache info on
+						   certain errors? */
 		}
 	} else {
 		rc = cifs_get_inode_info(&direntry->d_inode, full_path, NULL,
@@ -774,13 +790,14 @@ int cifs_revalidate(struct dentry *diren
 		if (rc) {
 			cFYI(1, ("error on getting revalidate info %d", rc));
 /*			if (rc != -ENOENT)
-				rc = 0; */  /* BB should we cache info on certain errors? */
+				rc = 0; */	/* BB should we cache info on
+						   certain errors? */
 		}
 	}
 	/* should we remap certain errors, access denied?, to zero */
 
-	/* if not oplocked, we invalidate inode pages if mtime 
-	   or file size had changed on server */
+	/* if not oplocked, we invalidate inode pages if mtime or file size
+	   had changed on server */
 
 	if (timespec_equal(&local_mtime,&direntry->d_inode->i_mtime) && 
 	    (local_size == direntry->d_inode->i_size)) {
@@ -788,22 +805,22 @@ int cifs_revalidate(struct dentry *diren
 	} else {
 		/* file may have changed on server */
 		if (cifsInode->clientCanCacheRead) {
-			/* no need to invalidate inode pages since we were
-			   the only ones who could have modified the file and
-			   the server copy is staler than ours */
+			/* no need to invalidate inode pages since we were the
+			   only ones who could have modified the file and the
+			   server copy is staler than ours */
 		} else {
 			invalidate_inode = TRUE;
 		}
 	}
 
-	/* can not grab this sem since kernel filesys locking
-		documentation indicates i_sem may be taken by the kernel 
-		on lookup and rename which could deadlock if we grab
-		the i_sem here as well */
+	/* can not grab this sem since kernel filesys locking documentation
+	   indicates i_sem may be taken by the kernel on lookup and rename
+	   which could deadlock if we grab the i_sem here as well */
 /*	down(&direntry->d_inode->i_sem);*/
 	/* need to write out dirty pages here  */
 	if (direntry->d_inode->i_mapping) {
-		/* do we need to lock inode until after invalidate completes below? */
+		/* do we need to lock inode until after invalidate completes
+		   below? */
 		filemap_fdatawrite(direntry->d_inode->i_mapping);
 	}
 	if (invalidate_inode) {
@@ -817,7 +834,7 @@ int cifs_revalidate(struct dentry *diren
 			invalidate_remote_inode(direntry->d_inode);
 		}
 	}
-/*	up(&direntry->d_inode->i_sem);*/
+/*	up(&direntry->d_inode->i_sem); */
 	
 	if (full_path)
 		kfree(full_path);
@@ -897,13 +914,13 @@ int cifs_setattr(struct dentry *direntry
 
 	if (attrs->ia_valid & ATTR_SIZE) {
 		read_lock(&GlobalSMBSeslock);
-		/* To avoid spurious oplock breaks from server, in the case
-			of inodes that we already have open, avoid doing path
-			based setting of file size if we can do it by handle.
-			This keeps our caching token (oplock) and avoids
-			timeouts when the local oplock break takes longer to flush
-			writebehind data than the SMB timeout for the SetPathInfo 
-			request would allow */
+		/* To avoid spurious oplock breaks from server, in the case of
+		   inodes that we already have open, avoid doing path based
+		   setting of file size if we can do it by handle.
+		   This keeps our caching token (oplock) and avoids timeouts
+		   when the local oplock break takes longer to flush
+		   writebehind data than the SMB timeout for the SetPathInfo
+		   request would allow */
 		list_for_each(tmp, &cifsInode->openFileList) {
 			open_file = list_entry(tmp, struct cifsFileInfo,
 					       flist);
@@ -912,8 +929,9 @@ int cifs_setattr(struct dentry *direntry
 			    ((open_file->pfile->f_flags & O_RDWR) ||
 			    (open_file->pfile->f_flags & O_WRONLY))) {
 				if (open_file->invalidHandle == FALSE) {
-					/* we found a valid, writeable network file 
-					handle to use to try to set the file size */
+					/* we found a valid, writeable network
+					   file handle to use to try to set the
+					   file size */
 					__u16 nfid = open_file->netfid;
 					__u32 npid = open_file->pid;
 					read_unlock(&GlobalSMBSeslock);
@@ -923,11 +941,14 @@ int cifs_setattr(struct dentry *direntry
 						FALSE);
 					cFYI(1, ("SetFileSize by handle "
 						 "(setattrs) rc = %d", rc));
-				/* Do not need reopen and retry on EAGAIN since we will
-					retry by pathname below */
-
-					break;  /* now that we found one valid file handle no
-						sense continuing to loop trying others */
+					/* Do not need reopen and retry on
+					   EAGAIN since we will retry by
+					   pathname below */
+
+					/* now that we found one valid file
+					   handle no sense continuing to loop
+					   trying others, so break here */
+					break;
 				}
 			}
 		}
@@ -935,18 +956,21 @@ int cifs_setattr(struct dentry *direntry
 			read_unlock(&GlobalSMBSeslock);
 
 		if (rc != 0) {
-			/* Set file size by pathname rather than by handle either
-			because no valid, writeable file handle for it was found or
-			because there was an error setting it by handle */
+			/* Set file size by pathname rather than by handle
+			   either because no valid, writeable file handle for
+			   it was found or because there was an error setting
+			   it by handle */
 			rc = CIFSSMBSetEOF(xid, pTcon, full_path,
 					   attrs->ia_size, FALSE,
 					   cifs_sb->local_nls);
 			cFYI(1, (" SetEOF by path (setattrs) rc = %d", rc));
 		}
 
-	/*  Server is ok setting allocation size implicitly - no need to call: */
-	/* CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
-			 cifs_sb->local_nls); */
+		/* Server is ok setting allocation size implicitly - no need
+		   to call:
+		CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
+			 cifs_sb->local_nls);
+		   */
 
 		if (rc == 0) {
 			rc = vmtruncate(direntry->d_inode, attrs->ia_size);
@@ -957,12 +981,12 @@ int cifs_setattr(struct dentry *direntry
 	if (attrs->ia_valid & ATTR_UID) {
 		cFYI(1, (" CIFS - UID changed to %d", attrs->ia_uid));
 		uid = attrs->ia_uid;
-		/*        entry->uid = cpu_to_le16(attr->ia_uid); */
+		/* entry->uid = cpu_to_le16(attr->ia_uid); */
 	}
 	if (attrs->ia_valid & ATTR_GID) {
 		cFYI(1, (" CIFS - GID changed to %d", attrs->ia_gid));
 		gid = attrs->ia_gid;
-		/*      entry->gid = cpu_to_le16(attr->ia_gid); */
+		/* entry->gid = cpu_to_le16(attr->ia_gid); */
 	}
 
 	time_buf.Attributes = 0;
@@ -1010,18 +1034,18 @@ int cifs_setattr(struct dentry *direntry
 
 	if (attrs->ia_valid & ATTR_CTIME) {
 		set_time = TRUE;
-		cFYI(1, (" CIFS - CTIME changed ")); /* BB probably do not need */
+		cFYI(1, (" CIFS - CTIME changed ")); /* BB probably no need */
 		time_buf.ChangeTime =
 		    cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_ctime));
 	} else
 		time_buf.ChangeTime = 0;
 
 	if (set_time || time_buf.Attributes) {
-		/* BB what if setting one attribute fails  
-			(such as size) but time setting works */
+		/* BB what if setting one attribute fails (such as size) but
+		   time setting works? */
 		time_buf.CreationTime = 0;	/* do not change */
 		/* In the future we should experiment - try setting timestamps
-			 via Handle (SetFileInfo) instead of by path */
+		   via Handle (SetFileInfo) instead of by path */
 		if (!(pTcon->ses->flags & CIFS_SES_NT4))
 			rc = CIFSSMBSetTimes(xid, pTcon, full_path, &time_buf,
 					     cifs_sb->local_nls);
@@ -1034,8 +1058,8 @@ int cifs_setattr(struct dentry *direntry
 
 			cFYI(1, ("calling SetFileInfo since SetPathInfo for "
 				 "times not supported by this server"));
-		    /* BB we could scan to see if we already have it open */
-		    /* and pass in pid of opener to function */
+			/* BB we could scan to see if we already have it open
+			   and pass in pid of opener to function */
 			rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN,
 					 SYNCHRONIZE | FILE_WRITE_ATTRIBUTES,
 					 CREATE_NOT_DIR, &netfid, &oplock,
@@ -1046,7 +1070,8 @@ int cifs_setattr(struct dentry *direntry
 				CIFSSMBClose(xid, pTcon, netfid);
 			} else {
 			/* BB For even older servers we could convert time_buf
-			into old DOS style which uses two second granularity */
+			   into old DOS style which uses two second
+			   granularity */
 
 			/* rc = CIFSSMBSetTimesLegacy(xid, pTcon, full_path,
         	        		&time_buf, cifs_sb->local_nls); */
@@ -1054,7 +1079,8 @@ int cifs_setattr(struct dentry *direntry
 		}
 	}
 
-	/* do not  need local check to inode_check_ok since the server does that */
+	/* do not need local check to inode_check_ok since the server does
+	   that */
 	if (!rc)
 		rc = inode_setattr(direntry->d_inode, attrs);
 	if (full_path)
@@ -1067,5 +1093,5 @@ void cifs_delete_inode(struct inode *ino
 {
 	cFYI(1, ("In cifs_delete_inode, inode = 0x%p ", inode));
 	/* may have to add back in if and when safe distributed caching of
-		directories added e.g. via FindNotify */
+	   directories added e.g. via FindNotify */
 }

