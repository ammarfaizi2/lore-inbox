Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVCZOBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVCZOBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVCZOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:01:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:51092 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262073AbVCZN50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:57:26 -0500
Date: Sat, 26 Mar 2005 14:59:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2/6] cifs: inode.c cleanup - spaces (whitespace changes
 only)
Message-ID: <Pine.LNX.4.62.0503261457580.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing between function arguments, when declaring variables, 
after if statements etc. Also remove trailing whitespace, excessive nr of 
blank lines and break up lines longer than 80 characters.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/inode.c.with_patch1	2005-03-26 00:36:57.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 13:22:23.000000000 +0100
@@ -42,23 +42,23 @@ int cifs_get_inode_info_unix(struct inod
 
 	pTcon = cifs_sb->tcon;
 	cFYI(1, (" Getting info on %s ", search_path));
-	/* we could have done a find first instead but this returns more info */
+	/* could have done a find first instead but this returns more info */
 	rc = CIFSSMBUnixQPathInfo(xid, pTcon, search_path, &findData,
 				  cifs_sb->local_nls);
-	/* dump_mem("\nUnixQPathInfo return data", &findData, sizeof(findData)); */
+/*	dump_mem("\nUnixQPathInfo return data", &findData,
+		 sizeof(findData)); */
 	if (rc) {
 		if (rc == -EREMOTE) {
 			tmp_path =
-			    kmalloc(strnlen
-				    (pTcon->treeName,
-				     MAX_TREE_SIZE + 1) +
+			    kmalloc(strnlen(pTcon->treeName,
+					    MAX_TREE_SIZE + 1) +
 				    strnlen(search_path, MAX_PATHCONF) + 1,
 				    GFP_KERNEL);
 			if (tmp_path == NULL) {
 				return -ENOMEM;
 			}
         /* have to skip first of the double backslash of UNC name */
-			strncpy(tmp_path, pTcon->treeName, MAX_TREE_SIZE);	
+			strncpy(tmp_path, pTcon->treeName, MAX_TREE_SIZE);
 			strncat(tmp_path, search_path, MAX_PATHCONF);
 			rc = connect_to_dfs_path(xid, pTcon->ses,
 						 /* treename + */ tmp_path,
@@ -69,7 +69,6 @@ int cifs_get_inode_info_unix(struct inod
 		} else if (rc) {
 			return rc;
 		}
-
 	} else {
 		struct cifsInodeInfo *cifsInfo;
 		__u32 type = le32_to_cpu(findData.Type);
@@ -85,19 +84,20 @@ int cifs_get_inode_info_unix(struct inod
 			/* Are there sanity checks we can use to ensure that
 			the server is really filling in that field? */
 			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
-				(*pinode)->i_ino = 
+				(*pinode)->i_ino =
 					(unsigned long)findData.UniqueId;
 			} /* note ino incremented to unique num in new_inode */
 			insert_inode_hash(*pinode);
 		}
-			
+
 		inode = *pinode;
 		cifsInfo = CIFS_I(inode);
 
 		cFYI(1, (" Old time %ld ", cifsInfo->time));
 		cifsInfo->time = jiffies;
 		cFYI(1, (" New time %ld ", cifsInfo->time));
-		atomic_set(&cifsInfo->inUse,1);	/* ok to set on every refresh of inode */
+		atomic_set(&cifsInfo->inUse, 1);	/* ok to set on every
+							   refresh of inode */
 
 		inode->i_atime =
 		    cifs_NTtimeToUnix(le64_to_cpu(findData.LastAccessTime));
@@ -130,23 +130,22 @@ int cifs_get_inode_info_unix(struct inod
 		inode->i_gid = le64_to_cpu(findData.Gid);
 		inode->i_nlink = le64_to_cpu(findData.Nlinks);
 
-		if(is_size_safe_to_change(cifsInfo)) {
-		/* can not safely change the file size here if the 
+		if (is_size_safe_to_change(cifsInfo)) {
+		/* can not safely change the file size here if the
 		   client is writing to it due to potential races */
 
 			i_size_write(inode, end_of_file);
 /* blksize needs to be multiple of two. So safer to default to blksize
 	and blkbits set in superblock so 2**blkbits and blksize will match */
-/*		inode->i_blksize =
-		    (pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE) & 0xFFFFFE00;*/
+/*		inode->i_blksize = (pTcon->ses->server->maxBuf -
+				    MAX_CIFS_HDR_SIZE) & 0xFFFFFE00; */
 
 		/* This seems incredibly stupid but it turns out that
 		i_blocks is not related to (i_size / i_blksize), instead a
 		size of 512 is required to be used for calculating num blocks */
-		 
 
-/*		inode->i_blocks = 
-	                (inode->i_blksize - 1 + num_of_bytes) >> inode->i_blkbits;*/
+/*		inode->i_blocks = (inode->i_blksize - 1 + num_of_bytes) >>
+				   inode->i_blkbits; */
 
 		/* 512 bytes (2**9) is the fake blocksize that must be used */
 		/* for this calculation */
@@ -154,10 +153,10 @@ int cifs_get_inode_info_unix(struct inod
 		}
 
 		if (num_of_bytes < end_of_file)
-			cFYI(1, ("Server inconsistency Error: it says allocation size less than end of file "));
-		cFYI(1,
-		     ("Size %ld and blocks %ld ",
-		      (unsigned long) inode->i_size, inode->i_blocks));
+			cFYI(1, ("Server inconsistency Error: it says "
+				 "allocation size less than end of file "));
+		cFYI(1, ("Size %ld and blocks %ld ",
+			 (unsigned long)inode->i_size, inode->i_blocks));
 		if (S_ISREG(inode->i_mode)) {
 			cFYI(1, (" File inode "));
 			inode->i_op = &cifs_file_inode_ops;
@@ -170,7 +169,7 @@ int cifs_get_inode_info_unix(struct inod
 		} else if (S_ISLNK(inode->i_mode)) {
 			cFYI(1, (" Symbolic Link inode "));
 			inode->i_op = &cifs_symlink_inode_ops;
-/* tmp_inode->i_fop = *//* do not need to set to anything */
+		/* tmp_inode->i_fop = */ /* do not need to set to anything */
 		} else {
 			cFYI(1, (" Init special inode "));
 			init_special_inode(inode, inode->i_mode,
@@ -192,36 +191,35 @@ int cifs_get_inode_info(struct inode **p
 	char *buf = NULL;
 
 	pTcon = cifs_sb->tcon;
-	cFYI(1,("Getting info on %s ", search_path));
+	cFYI(1, ("Getting info on %s ", search_path));
 
-	if((pfindData == NULL) && (*pinode != NULL)) {
-		if(CIFS_I(*pinode)->clientCanCacheRead) {
-			cFYI(1,("No need to revalidate inode sizes on cached file "));
+	if ((pfindData == NULL) && (*pinode != NULL)) {
+		if (CIFS_I(*pinode)->clientCanCacheRead) {
+			cFYI(1, ("No need to revalidate inode sizes on "
+				 "cached file "));
 			return rc;
 		}
 	}
 
 	/* if file info not passed in then get it from server */
-	if(pfindData == NULL) {
+	if (pfindData == NULL) {
 		buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-		if(buf == NULL)
+		if (buf == NULL)
 			return -ENOMEM;
 		pfindData = (FILE_ALL_INFO *)buf;
 	/* could do find first instead but this returns more info */
 		rc = CIFSSMBQPathInfo(xid, pTcon, search_path, pfindData,
-			      cifs_sb->local_nls);
+				      cifs_sb->local_nls);
 	}
 	/* dump_mem("\nQPathInfo return data",&findData, sizeof(findData)); */
 	if (rc) {
 		if (rc == -EREMOTE) {
 			tmp_path =
-			    kmalloc(strnlen
-				    (pTcon->treeName,
-				     MAX_TREE_SIZE + 1) +
-				    strnlen(search_path, MAX_PATHCONF) + 1,
+			    kmalloc(strnlen(pTcon->treeName, MAX_TREE_SIZE + 1)
+				    + strnlen(search_path, MAX_PATHCONF) + 1,
 				    GFP_KERNEL);
 			if (tmp_path == NULL) {
-				if(buf)
+				if (buf)
 					kfree(buf);
 				return -ENOMEM;
 			}
@@ -234,7 +232,7 @@ int cifs_get_inode_info(struct inode **p
 			kfree(tmp_path);
 			/* BB fix up inode etc. */
 		} else if (rc) {
-			if(buf)
+			if (buf)
 				kfree(buf);
 			return rc;
 		}
@@ -245,7 +243,7 @@ int cifs_get_inode_info(struct inode **p
 		/* get new inode */
 		if (*pinode == NULL) {
 			*pinode = new_inode(sb);
-			if(*pinode == NULL)
+			if (*pinode == NULL)
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? */
 			/* Are there sanity checks we can use to ensure that
@@ -257,10 +255,12 @@ int cifs_get_inode_info(struct inode **p
 			Are there Windows server or network appliances
 			for which IndexNumber field is not guaranteed unique? */
 		
-			/* if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
+/*			if (cifs_sb->mnt_cifs_flags &
+			    CIFS_MOUNT_SERVER_INUM) {
 				(*pinode)->i_ino = 
 					(unsigned long)pfindData->IndexNumber;
-			} */ /*NB: ino incremented to unique num in new_inode*/
+			} */ /* NB:
+				ino incremented to unique num in new_inode */
 
 			insert_inode_hash(*pinode);
 		}
@@ -273,8 +273,8 @@ int cifs_get_inode_info(struct inode **p
 
 /* blksize needs to be multiple of two. So safer to default to blksize
         and blkbits set in superblock so 2**blkbits and blksize will match */
-/*		inode->i_blksize =
-		    (pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE) & 0xFFFFFE00;*/
+/*		inode->i_blksize = (pTcon->ses->server->maxBuf -
+				    MAX_CIFS_HDR_SIZE) & 0xFFFFFE00; */
 
 		/* Linux can not store file creation time unfortunately so we ignore it */
 		inode->i_atime =
@@ -283,11 +283,10 @@ int cifs_get_inode_info(struct inode **p
 		    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastWriteTime));
 		inode->i_ctime =
 		    cifs_NTtimeToUnix(le64_to_cpu(pfindData->ChangeTime));
-		cFYI(0,
-		     (" Attributes came in as 0x%x ", attr));
+		cFYI(0, (" Attributes came in as 0x%x ", attr));
 
 		/* set default mode. will override for dirs below */
-		if(atomic_read(&cifsInfo->inUse) == 0)
+		if (atomic_read(&cifsInfo->inUse) == 0)
 			/* new inode, can safely set these fields */
 			inode->i_mode = cifs_sb->mnt_file_mode;
 
@@ -301,34 +300,33 @@ int cifs_get_inode_info(struct inode **p
 		} else {
 			inode->i_mode |= S_IFREG;
 			/* treat the dos attribute of read-only as read-only mode e.g. 555 */
-			if(cifsInfo->cifsAttrs & ATTR_READONLY)
+			if (cifsInfo->cifsAttrs & ATTR_READONLY)
 				inode->i_mode &= ~(S_IWUGO);
    /* BB add code here - validate if device or weird share or device type? */
 		}
-		if(is_size_safe_to_change(cifsInfo)) {
+		if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the 
 		client is writing to it due to potential races */
-
 			i_size_write(inode,le64_to_cpu(pfindData->EndOfFile));
 
 		/* 512 bytes (2**9) is the fake blocksize that must be used */
 		/* for this calculation */
-			inode->i_blocks = (512 - 1 + le64_to_cpu(pfindData->AllocationSize))
-				 >> 9;
+			inode->i_blocks = (512 - 1 + le64_to_cpu(
+					   pfindData->AllocationSize)) >> 9;
 		}
 
 		inode->i_nlink = le32_to_cpu(pfindData->NumberOfLinks);
 
 		/* BB fill in uid and gid here? with help from winbind? 
 			or retrieve from NTFS stream extended attribute */
-		if(atomic_read(&cifsInfo->inUse) == 0) {
+		if (atomic_read(&cifsInfo->inUse) == 0) {
 			inode->i_uid = cifs_sb->mnt_uid;
 			inode->i_gid = cifs_sb->mnt_gid;
 			/* set so we do not keep refreshing these fields with
 			bad data after user has changed them in memory */
 			atomic_set(&cifsInfo->inUse,1);
 		}
-		
+
 		if (S_ISREG(inode->i_mode)) {
 			cFYI(1, (" File inode "));
 			inode->i_op = &cifs_file_inode_ops;
@@ -346,7 +344,7 @@ int cifs_get_inode_info(struct inode **p
 					   inode->i_rdev);
 		}
 	}
-	if(buf)
+	if (buf)
 	    kfree(buf);
 	return rc;
 }
@@ -374,7 +372,7 @@ int cifs_unlink(struct inode *inode, str
 	struct cifsTconInfo *pTcon;
 	char *full_path = NULL;
 	struct cifsInodeInfo *cifsInode;
-	FILE_BASIC_INFO * pinfo_buf;
+	FILE_BASIC_INFO *pinfo_buf;
 
 	cFYI(1, (" cifs_unlink, inode = 0x%p with ", inode));
 
@@ -388,7 +386,7 @@ int cifs_unlink(struct inode *inode, str
 /*	down(&direntry->d_sb->s_vfs_rename_sem);*/
 	full_path = build_path_from_dentry(direntry);
 /*	up(&direntry->d_sb->s_vfs_rename_sem);*/
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
@@ -402,33 +400,35 @@ int cifs_unlink(struct inode *inode, str
 		int oplock = FALSE;
 		__u16 netfid;
 
-		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, DELETE, 
-				CREATE_NOT_DIR | CREATE_DELETE_ON_CLOSE,
-				&netfid, &oplock, NULL, cifs_sb->local_nls);
-		if(rc==0) {
-			CIFSSMBRenameOpenFile(xid,pTcon,netfid,
-				NULL, cifs_sb->local_nls);
+		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, DELETE,
+				 CREATE_NOT_DIR | CREATE_DELETE_ON_CLOSE,
+				 &netfid, &oplock, NULL, cifs_sb->local_nls);
+		if (rc==0) {
+			CIFSSMBRenameOpenFile(xid, pTcon, netfid, NULL,
+					      cifs_sb->local_nls);
 			CIFSSMBClose(xid, pTcon, netfid);
 			direntry->d_inode->i_nlink--;
 		}
 	} else if (rc == -EACCES) {
 		/* try only if r/o attribute set in local lookup data? */
 		pinfo_buf = (FILE_BASIC_INFO *)kmalloc(sizeof(FILE_BASIC_INFO),
-			GFP_KERNEL);
-		if(pinfo_buf) {
-			memset(pinfo_buf,0,sizeof(FILE_BASIC_INFO));        
+						       GFP_KERNEL);
+		if (pinfo_buf) {
+			memset(pinfo_buf, 0, sizeof(FILE_BASIC_INFO));
 		/* ATTRS set to normal clears r/o bit */
 			pinfo_buf->Attributes = cpu_to_le32(ATTR_NORMAL);
-			if(!(pTcon->ses->flags & CIFS_SES_NT4))
+			if (!(pTcon->ses->flags & CIFS_SES_NT4))
 				rc = CIFSSMBSetTimes(xid, pTcon, full_path,
-					pinfo_buf, cifs_sb->local_nls);
+						     pinfo_buf,
+						     cifs_sb->local_nls);
 			else
 				rc = -EOPNOTSUPP;
 
-			if(rc == -EOPNOTSUPP) {
+			if (rc == -EOPNOTSUPP) {
 				int oplock = FALSE;
 				__u16 netfid;
-			/*	rc = CIFSSMBSetAttrLegacy(xid, pTcon, full_path,
+			/*	rc = CIFSSMBSetAttrLegacy(xid, pTcon,
+							  full_path,
 							  (__u16)ATTR_NORMAL,
 							  cifs_sb->local_nls); 
 			For some strange reason it seems that NT4 eats the
@@ -438,33 +438,38 @@ int cifs_unlink(struct inode *inode, str
 			/* BB could scan to see if we already have it open */
 			/* and pass in pid of opener to function */
 				rc = CIFSSMBOpen(xid, pTcon, full_path,
-						FILE_OPEN, SYNCHRONIZE |
-						 FILE_WRITE_ATTRIBUTES,
-						0, &netfid,
-						&oplock, NULL,
-						cifs_sb->local_nls);
-				if(rc==0) {
+						 FILE_OPEN, SYNCHRONIZE |
+						 FILE_WRITE_ATTRIBUTES, 0,
+						 &netfid, &oplock, NULL,
+						 cifs_sb->local_nls);
+				if (rc==0) {
 					rc = CIFSSMBSetFileTimes(xid, pTcon,
-							pinfo_buf, netfid);
+								 pinfo_buf,
+								 netfid);
 					CIFSSMBClose(xid, pTcon, netfid);
 				}
 			}
-			kfree(pinfo_buf); 
-				
+			kfree(pinfo_buf);
 		}
-		if(rc==0) {
-			rc = CIFSSMBDelFile(xid, pTcon, full_path, cifs_sb->local_nls);
+		if (rc==0) {
+			rc = CIFSSMBDelFile(xid, pTcon, full_path,
+					    cifs_sb->local_nls);
 			if (!rc) {
 				direntry->d_inode->i_nlink--;
 			} else if (rc == -ETXTBSY) {
 				int oplock = FALSE;
 				__u16 netfid;
 
-				rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, DELETE,
-						CREATE_NOT_DIR | CREATE_DELETE_ON_CLOSE,
-						&netfid, &oplock, NULL, cifs_sb->local_nls);
-				if(rc==0) {
-					CIFSSMBRenameOpenFile(xid,pTcon,netfid,NULL,cifs_sb->local_nls);
+				rc = CIFSSMBOpen(xid, pTcon, full_path,
+						 FILE_OPEN, DELETE,
+						 CREATE_NOT_DIR |
+						 CREATE_DELETE_ON_CLOSE,
+						 &netfid, &oplock, NULL,
+						 cifs_sb->local_nls);
+				if (rc==0) {
+					CIFSSMBRenameOpenFile(xid, pTcon,
+						netfid, NULL,
+						cifs_sb->local_nls);
 					CIFSSMBClose(xid, pTcon, netfid);
 		                        direntry->d_inode->i_nlink--;
 				}
@@ -475,7 +480,7 @@ int cifs_unlink(struct inode *inode, str
 	cifsInode = CIFS_I(direntry->d_inode);
 	cifsInode->time = 0;	/* will force revalidate to get info when needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
-	    current_fs_time(inode->i_sb);
+		current_fs_time(inode->i_sb);
 	cifsInode = CIFS_I(inode);
 	cifsInode->time = 0;	/* force revalidate of dir as well */
 
@@ -504,7 +509,7 @@ int cifs_mkdir(struct inode *inode, stru
 	down(&inode->i_sb->s_vfs_rename_sem);
 	full_path = build_path_from_dentry(direntry);
 	up(&inode->i_sb->s_vfs_rename_sem);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
@@ -519,29 +524,30 @@ int cifs_mkdir(struct inode *inode, stru
 			rc = cifs_get_inode_info_unix(&newinode, full_path,
 						      inode->i_sb,xid);
 		else
-			rc = cifs_get_inode_info(&newinode, full_path,NULL,
+			rc = cifs_get_inode_info(&newinode, full_path, NULL,
 						 inode->i_sb,xid);
 
 		direntry->d_op = &cifs_dentry_ops;
 		d_instantiate(direntry, newinode);
-		if(direntry->d_inode)
+		if (direntry->d_inode)
 			direntry->d_inode->i_nlink = 2;
 		if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)
 			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
-				CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
-						(__u64)current->euid,  
-						(__u64)current->egid,
-						0 /* dev_t */,
-						cifs_sb->local_nls);
+				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
+						    mode,
+						    (__u64)current->euid,
+						    (__u64)current->egid,
+						    0 /* dev_t */,
+						    cifs_sb->local_nls);
 			} else {
-				CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
-						(__u64)-1,  
-						(__u64)-1,
-						0 /* dev_t */,
-						cifs_sb->local_nls);
+				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
+						    mode, (__u64)-1,
+						    (__u64)-1, 0 /* dev_t */,
+						    cifs_sb->local_nls);
 			}
 		else { /* BB to be implemented via Windows secrty descriptors*/
-		/* eg CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,-1,-1,local_nls);*/
+		/* eg CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, -1, -1,
+					 local_nls); */
 		}
 	}
 	if (full_path)
@@ -570,7 +576,7 @@ int cifs_rmdir(struct inode *inode, stru
 	down(&inode->i_sb->s_vfs_rename_sem);
 	full_path = build_path_from_dentry(direntry);
 	up(&inode->i_sb->s_vfs_rename_sem);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
@@ -586,7 +592,7 @@ int cifs_rmdir(struct inode *inode, stru
 	cifsInode = CIFS_I(direntry->d_inode);
 	cifsInode->time = 0;	/* force revalidate to go get info when needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
-	    current_fs_time(inode->i_sb);
+		current_fs_time(inode->i_sb);
 
 	if (full_path)
 		kfree(full_path);
@@ -612,7 +618,7 @@ int cifs_rename(struct inode *source_ino
 	pTcon = cifs_sb_source->tcon;
 
 	if (pTcon != cifs_sb_target->tcon) {
-		FreeXid(xid);    
+		FreeXid(xid);
 		return -EXDEV;	/* BB actually could be allowed if same server, but
                      different share. Might eventually add support for this */
 	}
@@ -621,33 +627,33 @@ int cifs_rename(struct inode *source_ino
 	to grab it again here to protect the path integrity */
 	fromName = build_path_from_dentry(source_direntry);
 	toName = build_path_from_dentry(target_direntry);
-	if((fromName == NULL) || (toName == NULL)) {
+	if ((fromName == NULL) || (toName == NULL)) {
 		rc = -ENOMEM;
 		goto cifs_rename_exit;
 	}
 
 	rc = CIFSSMBRename(xid, pTcon, fromName, toName,
 			   cifs_sb_source->local_nls);
-	if(rc == -EEXIST) {
+	if (rc == -EEXIST) {
 		/* check if they are the same file 
 		because rename of hardlinked files is a noop */
-		FILE_UNIX_BASIC_INFO * info_buf_source;
-		FILE_UNIX_BASIC_INFO * info_buf_target;
+		FILE_UNIX_BASIC_INFO *info_buf_source;
+		FILE_UNIX_BASIC_INFO *info_buf_target;
 
-		info_buf_source = 
-			kmalloc(2 * sizeof(FILE_UNIX_BASIC_INFO),GFP_KERNEL);
-		if(info_buf_source != NULL) {
-			info_buf_target = info_buf_source+1;
-			rc = CIFSSMBUnixQPathInfo(xid, pTcon, fromName, 
+		info_buf_source =
+			kmalloc(2 * sizeof(FILE_UNIX_BASIC_INFO), GFP_KERNEL);
+		if (info_buf_source != NULL) {
+			info_buf_target = info_buf_source + 1;
+			rc = CIFSSMBUnixQPathInfo(xid, pTcon, fromName,
 				info_buf_source, cifs_sb_source->local_nls);
-			if(rc == 0) {
-				rc = CIFSSMBUnixQPathInfo(xid,pTcon,toName,
+			if (rc == 0) {
+				rc = CIFSSMBUnixQPathInfo(xid, pTcon, toName,
 						info_buf_target,
 						cifs_sb_target->local_nls);
 			}
-			if((rc == 0) && 
-				(info_buf_source->UniqueId == 
-				 info_buf_target->UniqueId)) {
+			if ((rc == 0) &&
+			    (info_buf_source->UniqueId ==
+			     info_buf_target->UniqueId)) {
 			/* do not rename since the files are hardlinked 
 			   which is a noop */
 			} else {
@@ -656,18 +662,19 @@ int cifs_rename(struct inode *source_ino
 			so delete the target manually before renaming to
 			follow POSIX rather than Windows semantics */
 				cifs_unlink(target_inode, target_direntry);
-				rc = CIFSSMBRename(xid, pTcon, fromName, toName,
-					cifs_sb_source->local_nls);
+				rc = CIFSSMBRename(xid, pTcon, fromName,
+						   toName,
+						   cifs_sb_source->local_nls);
 			}
 			kfree(info_buf_source);
 		} /* if we can not get memory just leave rc as EEXIST */
 	}
 
 	if (rc) {
-		cFYI(1,("rename rc %d",rc)); /* BB removeme BB */
+		cFYI(1, ("rename rc %d", rc)); /* BB removeme BB */
 	}
 
-	if((rc == -EIO)||(rc == -EEXIST)) {
+	if ((rc == -EIO) || (rc == -EEXIST)) {
 		int oplock = FALSE;
 		__u16 netfid;
 
@@ -676,11 +683,11 @@ int cifs_rename(struct inode *source_ino
 		need to test renaming open directory, also GENERIC_READ
 		might not right be right access to request */
 		rc = CIFSSMBOpen(xid, pTcon, fromName, FILE_OPEN, GENERIC_READ,
-					CREATE_NOT_DIR,
-					&netfid, &oplock, NULL, cifs_sb_source->local_nls);
-		if(rc==0) {
-			CIFSSMBRenameOpenFile(xid,pTcon,netfid,
-					toName, cifs_sb_source->local_nls);
+				 CREATE_NOT_DIR, &netfid, &oplock, NULL,
+				 cifs_sb_source->local_nls);
+		if (rc==0) {
+			CIFSSMBRenameOpenFile(xid, pTcon, netfid, toName,
+					      cifs_sb_source->local_nls);
 			CIFSSMBClose(xid, pTcon, netfid);
 		}
 	}
@@ -706,16 +713,16 @@ int cifs_revalidate(struct dentry *diren
 	struct timespec local_mtime;
 	int invalidate_inode = FALSE;
 
-	if(direntry->d_inode == NULL)
+	if (direntry->d_inode == NULL)
 		return -ENOENT;
 
 	cifsInode = CIFS_I(direntry->d_inode);
 
-	if(cifsInode == NULL)
+	if (cifsInode == NULL)
 		return -ENOENT;
 
 	/* no sense revalidating inode info on file that no one can write */
-	if(CIFS_I(direntry->d_inode)->clientCanCacheRead)
+	if (CIFS_I(direntry->d_inode)->clientCanCacheRead)
 		return rc;
 
 	xid = GetXid();
@@ -725,48 +732,48 @@ int cifs_revalidate(struct dentry *diren
 	/* can not safely grab the rename sem here if
 	rename calls revalidate since that would deadlock */
 	full_path = build_path_from_dentry(direntry);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
-	cFYI(1,
-	     ("Revalidate: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld",
-	      full_path, direntry->d_inode,
-	      direntry->d_inode->i_count.counter, direntry,
-	      direntry->d_time, jiffies));
+	cFYI(1, ("Revalidate: %s inode 0x%p count %d dentry: 0x%p d_time %ld "
+		 "jiffies %ld", full_path, direntry->d_inode,
+		 direntry->d_inode->i_count.counter, direntry,
+		 direntry->d_time, jiffies));
 
-	if (cifsInode->time == 0){
+	if (cifsInode->time == 0) {
 		/* was set to zero previously to force revalidate */
-	} else if (time_before(jiffies, cifsInode->time + HZ) && lookupCacheEnabled) {
-	    if((S_ISREG(direntry->d_inode->i_mode) == 0) || 
-			(direntry->d_inode->i_nlink == 1)) {  
+	} else if (time_before(jiffies, cifsInode->time + HZ) &&
+		   lookupCacheEnabled) {
+		if ((S_ISREG(direntry->d_inode->i_mode) == 0) ||
+		    (direntry->d_inode->i_nlink == 1)) {
 			if (full_path)
 				kfree(full_path);
 			FreeXid(xid);
 			return rc;
 		} else {
-			cFYI(1,("Have to revalidate file due to hardlinks"));
-		}            
+			cFYI(1, ("Have to revalidate file due to hardlinks"));
+		}
 	}
-	
+
 	/* save mtime and size */
 	local_mtime = direntry->d_inode->i_mtime;
-	local_size  = direntry->d_inode->i_size;
+	local_size = direntry->d_inode->i_size;
 
 	if (cifs_sb->tcon->ses->capabilities & CAP_UNIX) {
 		rc = cifs_get_inode_info_unix(&direntry->d_inode, full_path,
-					 direntry->d_sb,xid);
-		if(rc) {
-			cFYI(1,("error on getting revalidate info %d",rc));
-/*			if(rc != -ENOENT)
+					      direntry->d_sb,xid);
+		if (rc) {
+			cFYI(1, ("error on getting revalidate info %d", rc));
+/*			if (rc != -ENOENT)
 				rc = 0; */ /* BB should we cache info on certain errors? */
 		}
 	} else {
 		rc = cifs_get_inode_info(&direntry->d_inode, full_path, NULL,
-				    direntry->d_sb,xid);
-		if(rc) {
-			cFYI(1,("error on getting revalidate info %d",rc));
-/*			if(rc != -ENOENT)
+					 direntry->d_sb,xid);
+		if (rc) {
+			cFYI(1, ("error on getting revalidate info %d", rc));
+/*			if (rc != -ENOENT)
 				rc = 0; */  /* BB should we cache info on certain errors? */
 		}
 	}
@@ -775,12 +782,12 @@ int cifs_revalidate(struct dentry *diren
 	/* if not oplocked, we invalidate inode pages if mtime 
 	   or file size had changed on server */
 
-	if(timespec_equal(&local_mtime,&direntry->d_inode->i_mtime) && 
-		(local_size == direntry->d_inode->i_size)) {
-		cFYI(1,("cifs_revalidate - inode unchanged"));
+	if (timespec_equal(&local_mtime,&direntry->d_inode->i_mtime) && 
+	    (local_size == direntry->d_inode->i_size)) {
+		cFYI(1, ("cifs_revalidate - inode unchanged"));
 	} else {
 		/* file may have changed on server */
-		if(cifsInode->clientCanCacheRead) {
+		if (cifsInode->clientCanCacheRead) {
 			/* no need to invalidate inode pages since we were
 			   the only ones who could have modified the file and
 			   the server copy is staler than ours */
@@ -795,17 +802,18 @@ int cifs_revalidate(struct dentry *diren
 		the i_sem here as well */
 /*	down(&direntry->d_inode->i_sem);*/
 	/* need to write out dirty pages here  */
-	if(direntry->d_inode->i_mapping) {
+	if (direntry->d_inode->i_mapping) {
 		/* do we need to lock inode until after invalidate completes below? */
 		filemap_fdatawrite(direntry->d_inode->i_mapping);
 	}
-	if(invalidate_inode) {
-		if(direntry->d_inode->i_mapping)
+	if (invalidate_inode) {
+		if (direntry->d_inode->i_mapping)
 			filemap_fdatawait(direntry->d_inode->i_mapping);
 		/* may eventually have to do this for open files too */
-		if(list_empty(&(cifsInode->openFileList))) {
+		if (list_empty(&(cifsInode->openFileList))) {
 			/* Has changed on server - flush read ahead pages */
-			cFYI(1,("Invalidating read ahead data on closed file"));
+			cFYI(1, ("Invalidating read ahead data on "
+				 "closed file"));
 			invalidate_remote_inode(direntry->d_inode);
 		}
 	}
@@ -830,7 +838,7 @@ int cifs_getattr(struct vfsmount *mnt, s
 static int cifs_truncate_page(struct address_space *mapping, loff_t from)
 {
 	pgoff_t index = from >> PAGE_CACHE_SHIFT;
-	unsigned offset = from & (PAGE_CACHE_SIZE-1);
+	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
 	struct page *page;
 	char *kaddr;
 	int rc = 0;
@@ -863,20 +871,19 @@ int cifs_setattr(struct dentry *direntry
 	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
 	__u64 gid = 0xFFFFFFFFFFFFFFFFULL;
 	struct cifsInodeInfo *cifsInode;
-	struct list_head * tmp;
+	struct list_head *tmp;
 
 	xid = GetXid();
 
-	cFYI(1,
-	     (" In cifs_setattr, name = %s attrs->iavalid 0x%x ",
-	      direntry->d_name.name, attrs->ia_valid));
+	cFYI(1, (" In cifs_setattr, name = %s attrs->iavalid 0x%x ",
+		 direntry->d_name.name, attrs->ia_valid));
 	cifs_sb = CIFS_SB(direntry->d_inode->i_sb);
 	pTcon = cifs_sb->tcon;
 
 	down(&direntry->d_sb->s_vfs_rename_sem);
 	full_path = build_path_from_dentry(direntry);
 	up(&direntry->d_sb->s_vfs_rename_sem);
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
 	}
@@ -885,11 +892,11 @@ int cifs_setattr(struct dentry *direntry
 	/* BB check if we need to refresh inode from server now ? BB */
 
 	/* need to flush data before changing file size on server */
-	filemap_fdatawrite(direntry->d_inode->i_mapping); 
+	filemap_fdatawrite(direntry->d_inode->i_mapping);
 	filemap_fdatawait(direntry->d_inode->i_mapping);
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		read_lock(&GlobalSMBSeslock); 
+		read_lock(&GlobalSMBSeslock);
 		/* To avoid spurious oplock breaks from server, in the case
 			of inodes that we already have open, avoid doing path
 			based setting of file size if we can do it by handle.
@@ -897,22 +904,25 @@ int cifs_setattr(struct dentry *direntry
 			timeouts when the local oplock break takes longer to flush
 			writebehind data than the SMB timeout for the SetPathInfo 
 			request would allow */
-		list_for_each(tmp, &cifsInode->openFileList) {            
-			open_file = list_entry(tmp,struct cifsFileInfo, flist);
+		list_for_each(tmp, &cifsInode->openFileList) {
+			open_file = list_entry(tmp, struct cifsFileInfo,
+					       flist);
 			/* We check if file is open for writing first */
-			if((open_file->pfile) &&
-				((open_file->pfile->f_flags & O_RDWR) || 
-				 (open_file->pfile->f_flags & O_WRONLY))) {
-				if(open_file->invalidHandle == FALSE) {
+			if ((open_file->pfile) &&
+			    ((open_file->pfile->f_flags & O_RDWR) ||
+			    (open_file->pfile->f_flags & O_WRONLY))) {
+				if (open_file->invalidHandle == FALSE) {
 					/* we found a valid, writeable network file 
 					handle to use to try to set the file size */
 					__u16 nfid = open_file->netfid;
 					__u32 npid = open_file->pid;
 					read_unlock(&GlobalSMBSeslock);
 					found = TRUE;
-					rc = CIFSSMBSetFileSize(xid, pTcon, attrs->ia_size,
-					   nfid,npid,FALSE);
-					cFYI(1,("SetFileSize by handle (setattrs) rc = %d",rc));
+					rc = CIFSSMBSetFileSize(xid, pTcon,
+						attrs->ia_size, nfid, npid,
+						FALSE);
+					cFYI(1, ("SetFileSize by handle "
+						 "(setattrs) rc = %d", rc));
 				/* Do not need reopen and retry on EAGAIN since we will
 					retry by pathname below */
 
@@ -921,26 +931,27 @@ int cifs_setattr(struct dentry *direntry
 				}
 			}
 		}
-		if(found == FALSE) {
+		if (found == FALSE)
 			read_unlock(&GlobalSMBSeslock);
-		}
 
-
-		if(rc != 0) {
+		if (rc != 0) {
 			/* Set file size by pathname rather than by handle either
 			because no valid, writeable file handle for it was found or
 			because there was an error setting it by handle */
-			rc = CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size,FALSE,
-				   cifs_sb->local_nls);
-			cFYI(1,(" SetEOF by path (setattrs) rc = %d",rc));
+			rc = CIFSSMBSetEOF(xid, pTcon, full_path,
+					   attrs->ia_size, FALSE,
+					   cifs_sb->local_nls);
+			cFYI(1, (" SetEOF by path (setattrs) rc = %d", rc));
 		}
-        
+
 	/*  Server is ok setting allocation size implicitly - no need to call: */
-	/*CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE, cifs_sb->local_nls);*/
+	/* CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
+			 cifs_sb->local_nls); */
 
 		if (rc == 0) {
 			rc = vmtruncate(direntry->d_inode, attrs->ia_size);
-			cifs_truncate_page(direntry->d_inode->i_mapping, direntry->d_inode->i_size);
+			cifs_truncate_page(direntry->d_inode->i_mapping,
+					   direntry->d_inode->i_size);
 		}
 	}
 	if (attrs->ia_valid & ATTR_UID) {
@@ -964,19 +975,23 @@ int cifs_setattr(struct dentry *direntry
 	if ((cifs_sb->tcon->ses->capabilities & CAP_UNIX)
 	    && (attrs->ia_valid & (ATTR_MODE | ATTR_GID | ATTR_UID)))
 		rc = CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode, uid, gid,
-				0 /* dev_t */, cifs_sb->local_nls);
+					 0 /* dev_t */, cifs_sb->local_nls);
 	else if (attrs->ia_valid & ATTR_MODE) {
-		if((mode & S_IWUGO) == 0) /* not writeable */ {
-			if((cifsInode->cifsAttrs & ATTR_READONLY) == 0)
-				time_buf.Attributes = 
-					cpu_to_le32(cifsInode->cifsAttrs | ATTR_READONLY);
-		} else if((mode & S_IWUGO) == S_IWUGO) {
-			if(cifsInode->cifsAttrs & ATTR_READONLY)
-				time_buf.Attributes = 
-					cpu_to_le32(cifsInode->cifsAttrs & (~ATTR_READONLY));
-		}
-		/* BB to be implemented - via Windows security descriptors or streams */
-		/* CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,uid,gid,cifs_sb->local_nls);*/
+		if ((mode & S_IWUGO) == 0) /* not writeable */ {
+			if ((cifsInode->cifsAttrs & ATTR_READONLY) == 0)
+				time_buf.Attributes =
+					cpu_to_le32(cifsInode->cifsAttrs |
+						    ATTR_READONLY);
+		} else if ((mode & S_IWUGO) == S_IWUGO) {
+			if (cifsInode->cifsAttrs & ATTR_READONLY)
+				time_buf.Attributes =
+					cpu_to_le32(cifsInode->cifsAttrs &
+						    (~ATTR_READONLY));
+		}
+		/* BB to be implemented -
+		   via Windows security descriptors or streams */
+		/* CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, uid, gid,
+				      cifs_sb->local_nls); */
 	}
 
 	if (attrs->ia_valid & ATTR_ATIME) {
@@ -1007,32 +1022,34 @@ int cifs_setattr(struct dentry *direntry
 		time_buf.CreationTime = 0;	/* do not change */
 		/* In the future we should experiment - try setting timestamps
 			 via Handle (SetFileInfo) instead of by path */
-		if(!(pTcon->ses->flags & CIFS_SES_NT4))
+		if (!(pTcon->ses->flags & CIFS_SES_NT4))
 			rc = CIFSSMBSetTimes(xid, pTcon, full_path, &time_buf,
-				cifs_sb->local_nls);
+					     cifs_sb->local_nls);
 		else
 			rc = -EOPNOTSUPP;
 
-		if(rc == -EOPNOTSUPP) {
+		if (rc == -EOPNOTSUPP) {
 			int oplock = FALSE;
 			__u16 netfid;
 
-			cFYI(1,("calling SetFileInfo since SetPathInfo for times not supported by this server"));
+			cFYI(1, ("calling SetFileInfo since SetPathInfo for "
+				 "times not supported by this server"));
 		    /* BB we could scan to see if we already have it open */
 		    /* and pass in pid of opener to function */
-			rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, 
-				SYNCHRONIZE | FILE_WRITE_ATTRIBUTES,
-				CREATE_NOT_DIR, &netfid, &oplock, NULL, cifs_sb->local_nls);
-			if(rc==0) {
-				rc = CIFSSMBSetFileTimes(xid, pTcon, 
-						&time_buf, netfid);
+			rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN,
+					 SYNCHRONIZE | FILE_WRITE_ATTRIBUTES,
+					 CREATE_NOT_DIR, &netfid, &oplock,
+					 NULL, cifs_sb->local_nls);
+			if (rc==0) {
+				rc = CIFSSMBSetFileTimes(xid, pTcon, &time_buf,
+							 netfid);
 				CIFSSMBClose(xid, pTcon, netfid);
 			} else {
 			/* BB For even older servers we could convert time_buf
 			into old DOS style which uses two second granularity */
 
 			/* rc = CIFSSMBSetTimesLegacy(xid, pTcon, full_path,
-        	        &time_buf, cifs_sb->local_nls); */
+        	        		&time_buf, cifs_sb->local_nls); */
 			}
 		}
 	}

