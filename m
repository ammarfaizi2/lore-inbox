Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVCVUW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVCVUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCVUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:22:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:63666 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261844AbVCVUSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:18:39 -0500
Date: Tue, 22 Mar 2005 21:20:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][3/6] cifs: readdir.c cleanup - whitespace part 3
Message-ID: <Pine.LNX.4.62.0503222115380.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Purpose of this patch is to beautify comments. It uses a consistent form:

/* line 1
   line 2
   line n */

for multi-line comments, and makes sure there's a space after the initial 
/* and before the terminating */ for single-line comments. 
In some cases multi- and single-line comment blocks follow eachother 
immidiately - usually they have been merged, but in some cases the two 
blocks describe something not 100% related, and have then been left alone.
A few other, minor, related changes as well.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1/fs/cifs/readdir.c.with_patch2	2005-03-22 17:06:21.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/cifs/readdir.c	2005-03-22 17:28:57.000000000 +0100
@@ -31,7 +31,7 @@
 #include "cifs_fs_sb.h"
 #include "cifsfs.h"
 
-/* BB fixme - add debug wrappers around this function to disable it fixme BB */
+/* BB fixme - add debug wrappers around this function to disable it */
 /* static void dump_cifs_file_struct(struct file *file, char *label)
 {
 	struct cifsFileInfo *cf;
@@ -54,8 +54,8 @@
 	}
 } */
 
-/* Returns one if new inode created (which therefore needs to be hashed) */
-/* Might check in the future if inode number changed so we can rehash inode */
+/* Returns one if new inode created (which therefore needs to be hashed).
+   Might check in the future if inode number changed so we can rehash inode */
 static int construct_dentry(struct qstr *qstring, struct file *file,
 	struct inode **ptmp_inode, struct dentry **pnew_dentry)
 {
@@ -71,9 +71,11 @@ static int construct_dentry(struct qstr 
 	qstring->hash = full_name_hash(qstring->name, qstring->len);
 	tmp_dentry = d_lookup(file->f_dentry, qstring);
 	if (tmp_dentry) {
-		cFYI(0, (" existing dentry with inode 0x%p", tmp_dentry->d_inode));
+		cFYI(0, (" existing dentry with inode 0x%p",
+			 tmp_dentry->d_inode));
 		*ptmp_inode = tmp_dentry->d_inode;
-/* BB overwrite old name? i.e. tmp_dentry->d_name and tmp_dentry->d_name.len??*/
+		/* BB overwrite old name?
+		   i.e. tmp_dentry->d_name and tmp_dentry->d_name.len?? */
 		if (*ptmp_inode == NULL) {
 			*ptmp_inode = new_inode(file->f_dentry->d_sb);
 			if (*ptmp_inode == NULL)
@@ -129,7 +131,7 @@ static void fill_in_inode(struct inode *
 	if (atomic_read(&cifsInfo->inUse) == 0) {
 		tmp_inode->i_uid = cifs_sb->mnt_uid;
 		tmp_inode->i_gid = cifs_sb->mnt_gid;
-		/* set default mode. will override for dirs below */
+		/* set default mode. Will override for dirs below */
 		tmp_inode->i_mode = cifs_sb->mnt_file_mode;
 	}
 
@@ -150,25 +152,26 @@ static void fill_in_inode(struct inode *
 		tmp_inode->i_mode |= S_IFREG;
 		if (attr & ATTR_READONLY)
 			tmp_inode->i_mode &= ~(S_IWUGO);
-	} /* could add code here - to validate if device or weird share type? */
-
-	/* can not fill in nlink here as in qpathinfo version and Unx search */
+	}	/* could add code here -
+		   to validate if device or weird share type? */
+	/* cannot fill in nlink here as in qpathinfo version and Unx search */
 	if (atomic_read(&cifsInfo->inUse) == 0) {
 		atomic_set(&cifsInfo->inUse, 1);
 	}
 
 	if (is_size_safe_to_change(cifsInfo)) {
-		/* can not safely change the file size here if the 
+		/* can not safely change the file size here if the
 		client is writing to it due to potential races */
 		i_size_write(tmp_inode, end_of_file);
 
-	/* 512 bytes (2**9) is the fake blocksize that must be used */
-	/* for this calculation, even though the reported blocksize is larger */
+	/* 512 bytes (2**9) is the fake blocksize that must be used for this
+	   calculation, even though the reported blocksize is larger */
 		tmp_inode->i_blocks = (512 - 1 + allocation_size) >> 9;
 	}
 
 	if (allocation_size < end_of_file)
-		cFYI(1, ("Possible sparse file: allocation size less than end of file "));
+		cFYI(1, ("Possible sparse file: "
+			 "allocation size less than end of file "));
 	cFYI(1,
 	     ("File Size %ld and blocks %ld and blocksize %ld",
 	      (unsigned long)tmp_inode->i_size, tmp_inode->i_blocks,
@@ -242,12 +245,12 @@ static void unix_fill_in_inode(struct in
 	tmp_inode->i_nlink = le64_to_cpu(pfindData->Nlinks);
 
 	if (is_size_safe_to_change(cifsInfo)) {
-		/* can not safely change the file size here if the 
-		client is writing to it due to potential races */
+		/* can not safely change the file size here if the client is
+		   writing to it due to potential races */
 		i_size_write(tmp_inode, end_of_file);
 
-	/* 512 bytes (2**9) is the fake blocksize that must be used */
-	/* for this calculation, not the real blocksize */
+	/* 512 bytes (2**9) is the fake blocksize that must be used for this
+	   calculation, not the real blocksize */
 		tmp_inode->i_blocks = (512 - 1 + num_of_bytes) >> 9;
 	}
 
@@ -263,7 +266,7 @@ static void unix_fill_in_inode(struct in
 	} else if (S_ISLNK(tmp_inode->i_mode)) {
 		cFYI(1, ("Symbolic Link inode"));
 		tmp_inode->i_op = &cifs_symlink_inode_ops;
-/* tmp_inode->i_fop = *//* do not need to set to anything */
+	/* tmp_inode->i_fop = */ /* do not need to set to anything */
 	} else {
 		cFYI(1, ("Special inode")); 
 		init_special_inode(tmp_inode, tmp_inode->i_mode,
@@ -319,7 +322,7 @@ static int initiate_cifs_search(const in
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_UNIX;
 	} else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
-	} else /* not srvinos - BB fixme add check for backlevel? */ {
+	} else { /* not srvinos - BB fixme add check for backlevel? */
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_DIRECTORY_INFO;
 	}
 
@@ -357,8 +360,9 @@ static char *nxt_dir_entry(char *old_ent
 	cFYI(1, ("new entry %p old entry %p", new_entry, old_entry));
 	/* validate that new_entry is not past end of SMB */
 	if (new_entry >= end_of_smb) {
-		cFYI(1, ("search entry %p began after end of SMB %p old entry %p",
-			new_entry, end_of_smb, old_entry)); 
+		cFYI(1, ("search entry %p began after end of SMB %p "
+			 "old entry %p",
+			 new_entry, end_of_smb, old_entry)); 
 		return NULL;
 	} else
 		return new_entry;
@@ -367,7 +371,7 @@ static char *nxt_dir_entry(char *old_ent
 
 #define UNICODE_DOT cpu_to_le16(0x2e)
 
-/* return 0 if no match and 1 for . (current directory) and 2 for .. (parent) */
+/* return 0 if no match, 1 for . (current directory) and 2 for .. (parent) */
 static int cifs_entry_is_dot(char *current_entry, struct cifsFileInfo *cfile)
 {
 	int rc = 0;
@@ -404,7 +408,8 @@ static int cifs_entry_is_dot(char *curre
 		filename = &pFindData->FileName[0];
 		len = le32_to_cpu(pFindData->FileNameLength);
 	} else {
-		cFYI(1, ("Unknown findfirst level %d", cfile->srch_inf.info_level));
+		cFYI(1, ("Unknown findfirst level %d",
+			 cfile->srch_inf.info_level));
 	}
 
 	if (filename) {
@@ -420,12 +425,13 @@ static int cifs_entry_is_dot(char *curre
 				    && (ufilename[1] == UNICODE_DOT))
 					rc = 2;
 			}
-		} else /* ASCII */ {
+		} else { /* ASCII */
 			if (len == 1) {
 				if (filename[0] == '.')
 					rc = 1;
 			} else if (len == 2) {
-				if ((filename[0] == '.') && (filename[1] == '.'))
+				if ((filename[0] == '.') &&
+				    (filename[1] == '.'))
 					rc = 2;
 			}
 		}
@@ -437,8 +443,8 @@ static int cifs_entry_is_dot(char *curre
 /* find the corresponding entry in the search */
 /* Note that the SMB server returns search entries for . and .. which
    complicates logic here if we choose to parse for them and we do not
-   assume that they are located in the findfirst return buffer.*/
-/* We start counting in the buffer with entry 2 and increment for every
+   assume that they are located in the findfirst return buffer.
+   We start counting in the buffer with entry 2 and increment for every
    entry (do not increment for . or .. entry) */
 static int find_cifs_entry(const int xid, struct cifsTconInfo *pTcon,
 	struct file *file, char **ppCurrentEntry, int *num_to_ret)
@@ -447,17 +453,19 @@ static int find_cifs_entry(const int xid
 	int pos_in_buf = 0;
 	loff_t first_entry_in_buffer;
 	loff_t index_to_find = file->f_pos;
-	struct cifsFileInfo *cifsFile = (struct cifsFileInfo *)file->private_data;
+	struct cifsFileInfo *cifsFile =
+		(struct cifsFileInfo *)file->private_data;
 
 	/* check if index in the buffer */
-	if ((cifsFile == NULL) || (ppCurrentEntry == NULL) || (num_to_ret == NULL))
+	if ((cifsFile == NULL) || (ppCurrentEntry == NULL) ||
+	    (num_to_ret == NULL))
 		return -ENOENT;
 	
 	*ppCurrentEntry = NULL;
 	first_entry_in_buffer = 
 		cifsFile->srch_inf.index_of_last_entry - 
 			cifsFile->srch_inf.entries_in_buffer;
-/*	dump_cifs_file_struct(file, "In fce ");*/
+	/* dump_cifs_file_struct(file, "In fce "); */
 	if (index_to_find < first_entry_in_buffer) {
 		/* close and restart search */
 		cFYI(1, ("search backing up - close and restart search"));
@@ -473,7 +481,8 @@ static int find_cifs_entry(const int xid
 		}
 		rc = initiate_cifs_search(xid, file);
 		if (rc) {
-			cFYI(1, ("error %d reinitiating a search on rewind", rc));
+			cFYI(1, ("error %d reinitiating a search on rewind",
+				 rc));
 			return rc;
 		}
 	}
@@ -481,27 +490,31 @@ static int find_cifs_entry(const int xid
 	while ((index_to_find >= cifsFile->srch_inf.index_of_last_entry) && 
 	       (rc == 0) && (cifsFile->srch_inf.endOfSearch == FALSE)) {
 	 	cFYI(1, ("calling findnext2"));
-		rc = CIFSFindNext(xid, pTcon, cifsFile->netfid, &cifsFile->srch_inf);
+		rc = CIFSFindNext(xid, pTcon, cifsFile->netfid,
+				  &cifsFile->srch_inf);
 		if (rc)
 			return -ENOENT;
 	}
 	if (index_to_find < cifsFile->srch_inf.index_of_last_entry) {
-		/* we found the buffer that contains the entry */
-		/* scan and find it */
+		/* we found the buffer that contains the entry
+		   scan and find it */
 		int i;
 		char *current_entry;
 		char *end_of_smb = cifsFile->srch_inf.ntwrk_buf_start + 
 			smbCalcSize((struct smb_hdr *)cifsFile->srch_inf.ntwrk_buf_start);
-/*	dump_cifs_file_struct(file,"found entry in fce "); */
+		/* dump_cifs_file_struct(file,"found entry in fce "); */
 		first_entry_in_buffer = cifsFile->srch_inf.index_of_last_entry -
 			cifsFile->srch_inf.entries_in_buffer;
 		pos_in_buf = index_to_find - first_entry_in_buffer;
 		cFYI(1, ("found entry - pos_in_buf %d", pos_in_buf)); 
 		current_entry = cifsFile->srch_inf.srch_entries_start;
-		for (i = 0; (i < (pos_in_buf)) && (current_entry != NULL); i++) {
-			/* go entry to next entry figuring out which we need to start with */
-			/* if ( . or ..)
-			   	skip */
+		for (i = 0; (i < (pos_in_buf)) &&
+		     (current_entry != NULL); i++) {
+			/* go entry to next entry figuring out which we need
+			   to start with
+			   if ( . or ..)
+			   	skip
+			*/
 			rc = cifs_entry_is_dot(current_entry, cifsFile);
 			if (rc == 1) /* is . or .. so skip */ {
 				cFYI(1, ("Entry is .")); /* BB removeme BB */
@@ -513,7 +526,9 @@ static int find_cifs_entry(const int xid
 			current_entry = nxt_dir_entry(current_entry, end_of_smb);
 		}
 		if ((current_entry == NULL) && (i < pos_in_buf)) {
-			cERROR(1, ("reached end of buf searching for pos in buf %d index to find %lld rc %d", pos_in_buf, index_to_find, rc)); /* BB removeme BB */
+   /* BB removeme BB */	cERROR(1, ("reached end of buf searching for pos in buf"
+				   " %d index to find %lld rc %d",
+				   pos_in_buf, index_to_find, rc));
 		}
 		rc = 0;
 		*ppCurrentEntry = current_entry;
@@ -523,11 +538,12 @@ static int find_cifs_entry(const int xid
 	}
 
 	if (pos_in_buf >= cifsFile->srch_inf.entries_in_buffer) {
-		cFYI(1, ("can not return entries when pos_in_buf beyond last entry"));
+		cFYI(1, ("can not return entries when pos_in_buf "
+			 "beyond last entry"));
 		*num_to_ret = 0;
 	} else
 		*num_to_ret = cifsFile->srch_inf.entries_in_buffer - pos_in_buf;
-/*	dump_cifs_file_struct(file, "end fce "); */
+	/* dump_cifs_file_struct(file, "end fce "); */
 
 	return rc;
 }
@@ -554,7 +570,7 @@ static int cifs_get_name_from_search_buf
 			len = strnlen(filename, PATH_MAX);
 		}
 
-		/* BB fixme - hash low and high 32 bits if not 64 bit arch BB fixme */
+		/* BB fixme - hash low and high 32 bits if not 64 bit arch */
 		*pinum = pFindData->UniqueId;
 	} else if (level == SMB_FIND_FILE_DIRECTORY_INFO) {
 		FILE_DIRECTORY_INFO *pFindData =
@@ -584,13 +600,15 @@ static int cifs_get_name_from_search_buf
 	if (unicode) {
 		/* BB fixme - test with long names */
 		/* Note converted filename can be longer than in unicode */
-		pqst->len = cifs_strfromUCS_le((char *)pqst->name, (wchar_t *)filename, len / 2, nlt);
+		pqst->len = cifs_strfromUCS_le((char *)pqst->name,
+					       (wchar_t *)filename,
+					       len / 2, nlt);
 	} else {
 		pqst->name = filename;
 		pqst->len = len;
 	}
 	pqst->hash = full_name_hash(pqst->name, pqst->len);
-/*	cFYI(1, ("filldir on %s", pqst->name)); */
+	/* cFYI(1, ("filldir on %s", pqst->name)); */
 	return rc;
 }
 
@@ -606,9 +624,9 @@ static int cifs_filldir(char *pfindEntry
 	struct inode *tmp_inode;
 	struct dentry *tmp_dentry;
 
-	/* get filename and len into qstring */
-	/* get dentry */
-	/* decide whether to create and populate ionde */
+	/* get filename and len into qstring
+	   get dentry
+	   decide whether to create and populate ionde */
 	if ((direntry == NULL) || (file == NULL))
 		return -EINVAL;
 
@@ -626,7 +644,7 @@ static int cifs_filldir(char *pfindEntry
 	rc = cifs_get_name_from_search_buf(&qstring,pfindEntry,
 			pCifsF->srch_inf.info_level,
 			pCifsF->srch_inf.unicode, cifs_sb->local_nls,
-			&inum /* returned */);
+			&inum /* returned */ );
 
 	if (rc)
 		return rc;
@@ -638,19 +656,23 @@ static int cifs_filldir(char *pfindEntry
 	if (rc) {
 		/* inode created, we need to hash it with right inode number */
 		if (inum != 0) {
-			/* BB fixme - hash the 2 32 quantities bits together if necessary BB */
+			/* BB fixme - hash the 2 32 quantities bits together
+			   if necessary */
 			tmp_inode->i_ino = inum;
 		}
 		insert_inode_hash(tmp_inode);
 	}
 
 	if (pCifsF->srch_inf.info_level == SMB_FIND_FILE_UNIX) {
-		unix_fill_in_inode(tmp_inode, (FILE_UNIX_INFO *)pfindEntry,&obj_type);
+		unix_fill_in_inode(tmp_inode,
+				   (FILE_UNIX_INFO *)pfindEntry,&obj_type);
 	} else {
-		fill_in_inode(tmp_inode, (FILE_DIRECTORY_INFO *)pfindEntry,&obj_type);
+		fill_in_inode(tmp_inode,
+			      (FILE_DIRECTORY_INFO *)pfindEntry,&obj_type);
 	}
 	
-	rc = filldir(direntry, qstring.name, qstring.len, file->f_pos, tmp_inode->i_ino, obj_type);
+	rc = filldir(direntry, qstring.name, qstring.len, file->f_pos,
+		     tmp_inode->i_ino, obj_type);
 	if (rc) {
 		cFYI(1, ("filldir rc = %d", rc));
 	}
@@ -735,14 +757,14 @@ int cifs_readdir(struct file *file, void
 		FreeXid(xid);
 		return -EIO;
 	}
-/*	dump_cifs_file_struct(file, "Begin rdir "); */
+	/* dump_cifs_file_struct(file, "Begin rdir "); */
 
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 	if (pTcon == NULL)
 		return -EINVAL;
 
-/*	cFYI(1, ("readdir2 pos: %lld", file->f_pos)); */
+	/* cFYI(1, ("readdir2 pos: %lld", file->f_pos)); */
 
 	switch ((int)file->f_pos) {
 	case 0:
@@ -816,32 +838,40 @@ int cifs_readdir(struct file *file, void
 		tmp_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 		for (i = 0; (i < num_to_fill) && (rc == 0); i++) {
 			if (current_entry == NULL) {
-				cERROR(1, ("beyond end of smb with num to fill %d i %d", num_to_fill,i)); /* BB removeme BB */
+	/* BB removeme BB */	cERROR(1, ("beyond end of smb with num to fill "
+					   "%d i %d", num_to_fill,i));
 				break;
 			}
-/*			if ((!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) || 
-			    (cifsFile->srch_inf.info_level != something that supports server inodes)) {
-				create dentry
-				create inode
-				fill in inode new_inode (which makes number locally)
+			/* if ((!(cifs_sb->mnt_cifs_flags &
+				  CIFS_MOUNT_SERVER_INUM)) ||
+			       (cifsFile->srch_inf.info_level !=
+				something that supports server inodes)) {
+				  create dentry
+				  create inode
+				  fill in inode new_inode
+				    (which makes number locally)
 			}
-			also create local inode for per reasons unless new mount parm says otherwise */
+			also create local inode for per reasons unless
+			new mount parm says otherwise */
 			rc = cifs_filldir(current_entry, file, filldir,
 					  direntry, tmp_buf);
 			file->f_pos++;
-			if (file->f_pos == cifsFile->srch_inf.index_of_last_entry) {
-				cFYI(1, ("last entry in buf at pos %lld %s", file->f_pos, tmp_buf)); /* BB removeme BB */
+			if (file->f_pos ==
+			    cifsFile->srch_inf.index_of_last_entry) {
+	/* BB removeme BB */	cFYI(1, ("last entry in buf at pos %lld %s",
+					 file->f_pos, tmp_buf));
 				cifs_save_resume_key(current_entry, cifsFile);
 				break;
 			} else 
-				current_entry = nxt_dir_entry(current_entry, end_of_smb);
+				current_entry = nxt_dir_entry(current_entry,
+							      end_of_smb);
 		}
 		if (tmp_buf != NULL)
 			kfree(tmp_buf);
 		break;
 	} /* end switch */
 rddir2_exit:
-	/* dump_cifs_file_struct(file, "end rdir ");  */
+	/* dump_cifs_file_struct(file, "end rdir "); */
 	FreeXid(xid);
 	return rc;
 }



