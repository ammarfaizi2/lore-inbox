Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIANM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIANM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWIANM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:12:26 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:47502 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750736AbWIANMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:12:25 -0400
Message-ID: <44F83356.20207@student.ltu.se>
Date: Fri, 01 Sep 2006 15:19:18 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, sfrench@samba.org
CC: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Converting into generic boolean
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Converting:
'FALSE' into 'false'
'TRUE'  into 'true'

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Depends on "[PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Correcting error-prone boolean-statement"
Compile-tested


 asn1.c       |    4 +--
 cifsfs.c     |    4 +--
 cifsfs.h     |    8 -------
 cifsglob.h   |    8 -------
 cifssmb.c    |   20 +++++++++---------
 connect.c    |   22 ++++++++++----------
 dir.c        |   14 ++++++------
 fcntl.c      |    2 -
 file.c       |   64 +++++++++++++++++++++++++++++------------------------------
 inode.c      |   32 ++++++++++++++---------------
 link.c       |    2 -
 misc.c       |   30 +++++++++++++--------------
 netmisc.c    |    2 -
 readdir.c    |   10 ++++-----
 smbencrypt.c |    7 ------
 xattr.c      |    2 -
 16 files changed, 104 insertions(+), 127 deletions(-)


diff -Narup a/fs/cifs/asn1.c b/fs/cifs/asn1.c
--- a/fs/cifs/asn1.c	2006-09-01 01:24:45.000000000 +0200
+++ b/fs/cifs/asn1.c	2006-09-01 02:43:09.000000000 +0200
@@ -457,7 +457,7 @@ decode_negTokenInit(unsigned char *secur
 	unsigned char *sequence_end;
 	unsigned long *oid = NULL;
 	unsigned int cls, con, tag, oidlen, rc;
-	int use_ntlmssp = FALSE;
+	int use_ntlmssp = false;
 
 	*secType = NTLM; /* BB eventually make Kerberos or NLTMSSP the default */
 
@@ -554,7 +554,7 @@ decode_negTokenInit(unsigned char *secur
 						 NTLMSSP_OID_LEN);
 					kfree(oid);
 					if (rc)
-						use_ntlmssp = TRUE;
+						use_ntlmssp = true;
 				}
 			} else {
 				cFYI(1,("This should be an oid what is going on? "));
diff -Narup a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	2006-09-01 01:24:45.000000000 +0200
+++ b/fs/cifs/cifsfs.c	2006-09-01 02:15:17.000000000 +0200
@@ -253,8 +253,8 @@ cifs_alloc_inode(struct super_block *sb)
 	/* Until the file is open and we have gotten oplock
 	info back from the server, can not assume caching of
 	file data or metadata */
-	cifs_inode->clientCanCacheRead = FALSE;
-	cifs_inode->clientCanCacheAll = FALSE;
+	cifs_inode->clientCanCacheRead = false;
+	cifs_inode->clientCanCacheAll = false;
 	cifs_inode->vfs_inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
 	cifs_inode->vfs_inode.i_flags = S_NOATIME | S_NOCMTIME;
 	INIT_LIST_HEAD(&cifs_inode->openFileList);
diff -Narup a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
--- a/fs/cifs/cifsfs.h	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/cifsfs.h	2006-09-01 02:26:05.000000000 +0200
@@ -24,14 +24,6 @@
 
 #define ROOT_I 2
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 extern const struct address_space_operations cifs_addr_ops;
 extern const struct address_space_operations cifs_addr_ops_smallbuf;
 
diff -Narup a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
--- a/fs/cifs/cifsglob.h	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/cifsglob.h	2006-09-01 02:22:32.000000000 +0200
@@ -56,14 +56,6 @@
 
 #include "cifspdu.h"
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 #ifndef XATTR_DOS_ATTRIB
 #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
 #endif
diff -Narup a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
--- a/fs/cifs/cifssmb.c	2006-09-01 01:25:42.000000000 +0200
+++ b/fs/cifs/cifssmb.c	2006-09-01 02:42:14.000000000 +0200
@@ -93,7 +93,7 @@ static void mark_open_files_invalid(stru
 	list_for_each_safe(tmp, tmp1, &pTcon->openFileList) {
 		open_file = list_entry(tmp,struct cifsFileInfo, tlist);
 		if(open_file) {
-			open_file->invalidHandle = TRUE;
+			open_file->invalidHandle = true;
 		}
 	}
 	write_unlock(&GlobalSMBSeslock);
@@ -3268,9 +3268,9 @@ findFirstRetry:
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
 		if(rc == 0) {
 			if (pSMBr->hdr.Flags2 & SMBFLG2_UNICODE)
-				psrch_inf->unicode = TRUE;
+				psrch_inf->unicode = true;
 			else
-				psrch_inf->unicode = FALSE;
+				psrch_inf->unicode = false;
 
 			psrch_inf->ntwrk_buf_start = (char *)pSMBr;
 			psrch_inf->smallBuf = 0;
@@ -3281,9 +3281,9 @@ findFirstRetry:
 			       le16_to_cpu(pSMBr->t2.ParameterOffset));
 
 			if(parms->EndofSearch)
-				psrch_inf->endOfSearch = TRUE;
+				psrch_inf->endOfSearch = true;
 			else
-				psrch_inf->endOfSearch = FALSE;
+				psrch_inf->endOfSearch = false;
 
 			psrch_inf->entries_in_buffer  = le16_to_cpu(parms->SearchCount);
 			psrch_inf->index_of_last_entry = 2 /* skip . and .. */ +
@@ -3376,7 +3376,7 @@ int CIFSFindNext(const int xid, struct c
 	cifs_stats_inc(&tcon->num_fnext);
 	if (rc) {
 		if (rc == -EBADF) {
-			psrch_inf->endOfSearch = TRUE;
+			psrch_inf->endOfSearch = true;
 			rc = 0; /* search probably was closed at end of search above */
 		} else
 			cFYI(1, ("FindNext returned = %d", rc));
@@ -3386,9 +3386,9 @@ int CIFSFindNext(const int xid, struct c
 		if(rc == 0) {
 			/* BB fixme add lock for file (srch_info) struct here */
 			if (pSMBr->hdr.Flags2 & SMBFLG2_UNICODE)
-				psrch_inf->unicode = TRUE;
+				psrch_inf->unicode = true;
 			else
-				psrch_inf->unicode = FALSE;
+				psrch_inf->unicode = false;
 			response_data = (char *) &pSMBr->hdr.Protocol +
 			       le16_to_cpu(pSMBr->t2.ParameterOffset);
 			parms = (T2_FNEXT_RSP_PARMS *)response_data;
@@ -3403,9 +3403,9 @@ int CIFSFindNext(const int xid, struct c
 			psrch_inf->ntwrk_buf_start = (char *)pSMB;
 			psrch_inf->smallBuf = 0;
 			if(parms->EndofSearch)
-				psrch_inf->endOfSearch = TRUE;
+				psrch_inf->endOfSearch = true;
 			else
-				psrch_inf->endOfSearch = FALSE;
+				psrch_inf->endOfSearch = false;
                                                                                               
 			psrch_inf->entries_in_buffer  = le16_to_cpu(parms->SearchCount);
 			psrch_inf->index_of_last_entry +=
diff -Narup a/fs/cifs/connect.c b/fs/cifs/connect.c
--- a/fs/cifs/connect.c	2006-09-01 01:25:42.000000000 +0200
+++ b/fs/cifs/connect.c	2006-09-01 02:42:11.000000000 +0200
@@ -339,7 +339,7 @@ cifs_demultiplex_thread(struct TCP_Serve
 	struct task_struct *task_to_wake = NULL;
 	struct mid_q_entry *mid_entry;
 	char temp;
-	int isLargeBuf = FALSE;
+	int isLargeBuf = false;
 	int isMultiRsp;
 	int reconnect;
 
@@ -387,8 +387,8 @@ cifs_demultiplex_thread(struct TCP_Serve
 		} else /* if existing small buf clear beginning */
 			memset(smallbuf, 0, sizeof (struct smb_hdr));
 
-		isLargeBuf = FALSE;
-		isMultiRsp = FALSE;
+		isLargeBuf = false;
+		isMultiRsp = false;
 		smb_buffer = smallbuf;
 		iov.iov_base = smb_buffer;
 		iov.iov_len = 4;
@@ -511,7 +511,7 @@ cifs_demultiplex_thread(struct TCP_Serve
 		reconnect = 0;
 
 		if(pdu_length > MAX_CIFS_SMALL_BUFFER_SIZE - 4) {
-			isLargeBuf = TRUE;
+			isLargeBuf = true;
 			memcpy(bigbuf, smallbuf, 4);
 			smb_buffer = bigbuf;
 		}
@@ -575,7 +575,7 @@ cifs_demultiplex_thread(struct TCP_Serve
 			    (mid_entry->command == smb_buffer->Command)) {
 				if(check2ndT2(smb_buffer,server->maxBuf) > 0) {
 					/* We have a multipart transact2 resp */
-					isMultiRsp = TRUE;
+					isMultiRsp = true;
 					if(mid_entry->resp_buf) {
 						/* merge response - fix up 1st*/
 						if(coalesce_t2(smb_buffer, 
@@ -789,7 +789,7 @@ cifs_parse_mount_options(char *options, 
 	vol->file_mode = S_IALLUGO & ~(S_ISUID | S_IXGRP);
 
 	/* vol->retry default is 0 (i.e. "soft" limited retry not hard retry) */
-	vol->rw = TRUE;
+	vol->rw = true;
 	/* default is always to request posix paths. */
 	vol->posix_paths = 1;
 
@@ -1104,7 +1104,7 @@ cifs_parse_mount_options(char *options, 
 		} else if (strnicmp(data, "guest",5) == 0) {
 			/* ignore */
 		} else if (strnicmp(data, "rw", 2) == 0) {
-			vol->rw = TRUE;
+			vol->rw = true;
 		} else if ((strnicmp(data, "suid", 4) == 0) ||
 				   (strnicmp(data, "nosuid", 6) == 0) ||
 				   (strnicmp(data, "exec", 4) == 0) ||
@@ -1120,7 +1120,7 @@ cifs_parse_mount_options(char *options, 
 				is ok to just ignore them */
 			continue;
 		} else if (strnicmp(data, "ro", 2) == 0) {
-			vol->rw = FALSE;
+			vol->rw = false;
 		} else if (strnicmp(data, "hard", 4) == 0) {
 			vol->retry = 1;
 		} else if (strnicmp(data, "soft", 4) == 0) {
@@ -2327,7 +2327,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 	if(ses == NULL)
 		return -EINVAL;
 	domain = ses->domainName;
-	*pNTLMv2_flag = FALSE;
+	*pNTLMv2_flag = false;
 	smb_buffer = cifs_buf_get();
 	if (smb_buffer == NULL) {
 		return -ENOMEM;
@@ -2480,7 +2480,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 				       CIFS_CRYPTO_KEY_SIZE);
 				if(SecurityBlob2->NegotiateFlags & 
 					cpu_to_le32(NTLMSSP_NEGOTIATE_NTLMV2))
-					*pNTLMv2_flag = TRUE;
+					*pNTLMv2_flag = true;
 
 				if((SecurityBlob2->NegotiateFlags & 
 					cpu_to_le32(NTLMSSP_NEGOTIATE_ALWAYS_SIGN)) 
@@ -3242,7 +3242,7 @@ int cifs_setup_session(unsigned int xid,
 {
 	int rc = 0;
 	char ntlm_session_key[CIFS_SESS_KEY_SIZE];
-	int ntlmv2_flag = FALSE;
+	int ntlmv2_flag = false;
 	int first_time = 0;
 
 	/* what if server changes its buffer size after dropping the session? */
diff -Narup a/fs/cifs/dir.c b/fs/cifs/dir.c
--- a/fs/cifs/dir.c	2006-09-01 01:25:42.000000000 +0200
+++ b/fs/cifs/dir.c	2006-09-01 02:40:17.000000000 +0200
@@ -132,7 +132,7 @@ cifs_create(struct inode *inode, struct 
 	struct cifsFileInfo * pCifsFile = NULL;
 	struct cifsInodeInfo * pCifsInode;
 	int disposition = FILE_OVERWRITE_IF;
-	int write_only = FALSE;
+	int write_only = false;
 
 	xid = GetXid();
 
@@ -154,7 +154,7 @@ cifs_create(struct inode *inode, struct 
 		if (oflags & FMODE_WRITE) {
 			desiredAccess |= GENERIC_WRITE;
 			if (!(oflags & FMODE_READ))
-				write_only = TRUE;
+				write_only = true;
 		}
 
 		if((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
@@ -264,8 +264,8 @@ cifs_create(struct inode *inode, struct 
 			pCifsFile->netfid = fileHandle;
 			pCifsFile->pid = current->tgid;
 			pCifsFile->pInode = newinode;
-			pCifsFile->invalidHandle = FALSE;
-			pCifsFile->closePend     = FALSE;
+			pCifsFile->invalidHandle = false;
+			pCifsFile->closePend     = false;
 			init_MUTEX(&pCifsFile->fh_sem);
 			init_MUTEX(&pCifsFile->lock_sem);
 			INIT_LIST_HEAD(&pCifsFile->llist);
@@ -286,12 +286,12 @@ cifs_create(struct inode *inode, struct 
 						&pCifsInode->openFileList);
 				}
 				if((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-					pCifsInode->clientCanCacheAll = TRUE;
-					pCifsInode->clientCanCacheRead = TRUE;
+					pCifsInode->clientCanCacheAll = true;
+					pCifsInode->clientCanCacheRead = true;
 					cFYI(1,("Exclusive Oplock for inode %p",
 						newinode));
 				} else if((oplock & 0xF) == OPLOCK_READ)
-					pCifsInode->clientCanCacheRead = TRUE;
+					pCifsInode->clientCanCacheRead = true;
 			}
 			write_unlock(&GlobalSMBSeslock);
 		}
diff -Narup a/fs/cifs/fcntl.c b/fs/cifs/fcntl.c
--- a/fs/cifs/fcntl.c	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/fcntl.c	2006-09-01 02:23:07.000000000 +0200
@@ -71,7 +71,7 @@ int cifs_dir_notify(struct file * file, 
 {
 	int xid;
 	int rc = -EINVAL;
-	int oplock = FALSE;
+	int oplock = false;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	char *full_path = NULL;
diff -Narup a/fs/cifs/file.c b/fs/cifs/file.c
--- a/fs/cifs/file.c	2006-09-01 01:25:42.000000000 +0200
+++ b/fs/cifs/file.c	2006-09-01 02:47:22.000000000 +0200
@@ -52,8 +52,8 @@ static inline struct cifsFileInfo *cifs_
 	INIT_LIST_HEAD(&private_data->llist);
 	private_data->pfile = file; /* needed for writepage */
 	private_data->pInode = inode;
-	private_data->invalidHandle = FALSE;
-	private_data->closePend = FALSE;
+	private_data->invalidHandle = false;
+	private_data->closePend = false;
 	/* we have to track num writers to the inode, since writepages
 	does not tell us which handle the write is for so there can
 	be a close (overlapping with write) of the filehandle that
@@ -147,12 +147,12 @@ client_can_cache:
 			full_path, buf, inode->i_sb, xid);
 
 	if ((*oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-		pCifsInode->clientCanCacheAll = TRUE;
-		pCifsInode->clientCanCacheRead = TRUE;
+		pCifsInode->clientCanCacheAll = true;
+		pCifsInode->clientCanCacheRead = true;
 		cFYI(1, ("Exclusive Oplock granted on inode %p",
 			 file->f_dentry->d_inode));
 	} else if ((*oplock & 0xF) == OPLOCK_READ)
-		pCifsInode->clientCanCacheRead = TRUE;
+		pCifsInode->clientCanCacheRead = true;
 
 	return rc;
 }
@@ -246,7 +246,7 @@ int cifs_open(struct inode *inode, struc
 	if (oplockEnabled)
 		oplock = REQ_OPLOCK;
 	else
-		oplock = FALSE;
+		oplock = false;
 
 	/* BB pass O_SYNC flag through on file attributes .. BB */
 
@@ -393,7 +393,7 @@ static int cifs_reopen_file(struct inode
 	if (oplockEnabled)
 		oplock = REQ_OPLOCK;
 	else
-		oplock = FALSE;
+		oplock = false;
 
 	/* Can not refresh inode by passing in file_info buf to be returned
 	   by SMBOpen and then calling get_inode_info with returned buf 
@@ -418,7 +418,7 @@ static int cifs_reopen_file(struct inode
 		cFYI(1, ("oplock: %d", oplock));
 	} else {
 		pCifsFile->netfid = netfid;
-		pCifsFile->invalidHandle = FALSE;
+		pCifsFile->invalidHandle = false;
 		up(&pCifsFile->fh_sem);
 		pCifsInode = CIFS_I(inode);
 		if (pCifsInode) {
@@ -426,8 +426,8 @@ static int cifs_reopen_file(struct inode
 				filemap_write_and_wait(inode->i_mapping);
 			/* temporarily disable caching while we
 			   go to server to get inode info */
-				pCifsInode->clientCanCacheAll = FALSE;
-				pCifsInode->clientCanCacheRead = FALSE;
+				pCifsInode->clientCanCacheAll = false;
+				pCifsInode->clientCanCacheRead = false;
 				if (pTcon->ses->capabilities & CAP_UNIX)
 					rc = cifs_get_inode_info_unix(&inode,
 						full_path, inode->i_sb, xid);
@@ -442,16 +442,16 @@ static int cifs_reopen_file(struct inode
 			     we can not go to the server to get the new inod
 			     info */
 			if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-				pCifsInode->clientCanCacheAll = TRUE;
-				pCifsInode->clientCanCacheRead = TRUE;
+				pCifsInode->clientCanCacheAll = true;
+				pCifsInode->clientCanCacheRead = true;
 				cFYI(1, ("Exclusive Oplock granted on inode %p",
 					 file->f_dentry->d_inode));
 			} else if ((oplock & 0xF) == OPLOCK_READ) {
-				pCifsInode->clientCanCacheRead = TRUE;
-				pCifsInode->clientCanCacheAll = FALSE;
+				pCifsInode->clientCanCacheRead = true;
+				pCifsInode->clientCanCacheAll = false;
 			} else {
-				pCifsInode->clientCanCacheRead = FALSE;
-				pCifsInode->clientCanCacheAll = FALSE;
+				pCifsInode->clientCanCacheRead = false;
+				pCifsInode->clientCanCacheAll = false;
 			}
 			cifs_relock_file(pCifsFile);
 		}
@@ -478,7 +478,7 @@ int cifs_close(struct inode *inode, stru
 	if (pSMBFile) {
 		struct cifsLockInfo *li, *tmp;
 
-		pSMBFile->closePend = TRUE;
+		pSMBFile->closePend = true;
 		if (pTcon) {
 			/* no sense reconnecting to close a file that is
 			   already closed */
@@ -525,8 +525,8 @@ int cifs_close(struct inode *inode, stru
 		cFYI(1, ("closing last open instance for inode %p", inode));
 		/* if the file is not open we do not know if we can cache info
 		   on this inode, much less write behind and read ahead */
-		CIFS_I(inode)->clientCanCacheRead = FALSE;
-		CIFS_I(inode)->clientCanCacheAll  = FALSE;
+		CIFS_I(inode)->clientCanCacheRead = false;
+		CIFS_I(inode)->clientCanCacheAll  = false;
 	}
 	if ((rc ==0) && CIFS_I(inode)->write_behind_rc)
 		rc = CIFS_I(inode)->write_behind_rc;
@@ -555,7 +555,7 @@ int cifs_closedir(struct inode *inode, s
 		cFYI(1, ("Freeing private data in close dir"));
 		if (!(pCFileStruct->srch_inf.endOfSearch) &&
 		    !(pCFileStruct->invalidHandle)) {
-			pCFileStruct->invalidHandle = TRUE;
+			pCFileStruct->invalidHandle = true;
 			rc = CIFSFindClose(xid, pTcon, pCFileStruct->netfid);
 			cFYI(1, ("Closing uncompleted readdir with rc %d",
 				 rc));
@@ -606,7 +606,7 @@ int cifs_lock(struct file *file, int cmd
 	__u32 numLock = 0;
 	__u32 numUnlock = 0;
 	__u64 length;
-	int wait_flag = FALSE;
+	int wait_flag = false;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	__u16 netfid;
@@ -628,7 +628,7 @@ int cifs_lock(struct file *file, int cmd
 		cFYI(1, ("Flock"));
 	if (pfLock->fl_flags & FL_SLEEP) {
 		cFYI(1, ("Blocking lock"));
-		wait_flag = TRUE;
+		wait_flag = true;
 	}
 	if (pfLock->fl_flags & FL_ACCESS)
 		cFYI(1, ("Process suspended by mandatory locking - "
@@ -758,7 +758,7 @@ int cifs_lock(struct file *file, int cmd
 						length >= li->length) {
 					stored_rc = CIFSSMBLock(xid, pTcon, netfid,
 							li->length, li->offset,
-							1, 0, li->type, FALSE);
+							1, 0, li->type, false);
 					if (stored_rc)
 						rc = stored_rc;
 
@@ -846,7 +846,7 @@ ssize_t cifs_user_write(struct file *fil
 				   reopen_file not to flush data to server
 				   now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, FALSE);
+					file, false);
 				if (rc != 0)
 					break;
 			}
@@ -867,7 +867,7 @@ ssize_t cifs_user_write(struct file *fil
 			}
 		} else
 			*poffset += bytes_written;
-		long_op = FALSE; /* subsequent writes fast -
+		long_op = false; /* subsequent writes fast -
 				    15 seconds is plenty */
 	}
 
@@ -961,7 +961,7 @@ static ssize_t cifs_write(struct file *f
 				   reopen_file not to flush data to 
 				   server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, FALSE);
+					file, false);
 				if (rc != 0)
 					break;
 			}
@@ -1000,7 +1000,7 @@ static ssize_t cifs_write(struct file *f
 			}
 		} else
 			*poffset += bytes_written;
-		long_op = FALSE; /* subsequent writes fast - 
+		long_op = false; /* subsequent writes fast - 
 				    15 seconds is plenty */
 	}
 
@@ -1050,7 +1050,7 @@ struct cifsFileInfo *find_writable_file(
 			if((open_file->invalidHandle) && 
 			   (!open_file->closePend) /* BB fixme -since the second clause can not be true remove it BB */) {
 				rc = cifs_reopen_file(&cifs_inode->vfs_inode, 
-						      open_file->pfile, FALSE);
+						      open_file->pfile, false);
 				/* if it fails, try another handle - might be */
 				/* dangerous to hold up writepages with retry */
 				if(rc) {
@@ -1388,7 +1388,7 @@ static int cifs_commit_write(struct file
 					rc = CIFSSMBSetFileSize(xid,
 						cifs_sb->tcon, position,
 						open_file->netfid,
-						open_file->pid, FALSE);
+						open_file->pid, false);
 				} else {
 					rc = -EBADF;
 					break;
@@ -1539,7 +1539,7 @@ ssize_t cifs_user_read(struct file *file
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, TRUE);
+					file, true);
 				if (rc != 0)
 					break;
 			}
@@ -1626,7 +1626,7 @@ static ssize_t cifs_read(struct file *fi
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, TRUE);
+					file, true);
 				if (rc != 0)
 					break;
 			}
@@ -1783,7 +1783,7 @@ static int cifs_readpages(struct file *f
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, TRUE);
+					file, true);
 				if (rc != 0)
 					break;
 			}
diff -Narup a/fs/cifs/inode.c b/fs/cifs/inode.c
--- a/fs/cifs/inode.c	2006-09-01 01:24:45.000000000 +0200
+++ b/fs/cifs/inode.c	2006-09-01 02:42:07.000000000 +0200
@@ -208,7 +208,7 @@ static int decode_sfu_inode(struct inode
 			    struct cifs_sb_info *cifs_sb, int xid)
 {
 	int rc;
-	int oplock = FALSE;
+	int oplock = false;
 	__u16 netfid;
 	struct cifsTconInfo *pTcon = cifs_sb->tcon;
 	char buf[24];
@@ -595,7 +595,7 @@ int cifs_unlink(struct inode *inode, str
 	} else if (rc == -ENOENT) {
 		d_drop(direntry);
 	} else if (rc == -ETXTBSY) {
-		int oplock = FALSE;
+		int oplock = false;
 		__u16 netfid;
 
 		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, DELETE,
@@ -628,7 +628,7 @@ int cifs_unlink(struct inode *inode, str
 				rc = -EOPNOTSUPP;
 
 			if (rc == -EOPNOTSUPP) {
-				int oplock = FALSE;
+				int oplock = false;
 				__u16 netfid;
 			/*	rc = CIFSSMBSetAttrLegacy(xid, pTcon,
 							  full_path,
@@ -666,7 +666,7 @@ int cifs_unlink(struct inode *inode, str
 				if (direntry->d_inode)
 					drop_nlink(direntry->d_inode);
 			} else if (rc == -ETXTBSY) {
-				int oplock = FALSE;
+				int oplock = false;
 				__u16 netfid;
 
 				rc = CIFSSMBOpen(xid, pTcon, full_path,
@@ -919,7 +919,7 @@ int cifs_rename(struct inode *source_ino
 	}
 
 	if ((rc == -EIO) || (rc == -EEXIST)) {
-		int oplock = FALSE;
+		int oplock = false;
 		__u16 netfid;
 
 		/* BB FIXME Is Generic Read correct for rename? */
@@ -956,7 +956,7 @@ int cifs_revalidate(struct dentry *diren
 	struct cifsInodeInfo *cifsInode;
 	loff_t local_size;
 	struct timespec local_mtime;
-	int invalidate_inode = FALSE;
+	int invalidate_inode = false;
 
 	if (direntry->d_inode == NULL)
 		return -ENOENT;
@@ -1038,7 +1038,7 @@ int cifs_revalidate(struct dentry *diren
 			   only ones who could have modified the file and the
 			   server copy is staler than ours */
 		} else {
-			invalidate_inode = TRUE;
+			invalidate_inode = true;
 		}
 	}
 
@@ -1115,7 +1115,7 @@ int cifs_setattr(struct dentry *direntry
 	int rc = -EACCES;
 	struct cifsFileInfo *open_file = NULL;
 	FILE_BASIC_INFO time_buf;
-	int set_time = FALSE;
+	int set_time = false;
 	__u64 mode = 0xFFFFFFFFFFFFFFFFULL;
 	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
 	__u64 gid = 0xFFFFFFFFFFFFFFFFULL;
@@ -1165,7 +1165,7 @@ int cifs_setattr(struct dentry *direntry
 			__u16 nfid = open_file->netfid;
 			__u32 npid = open_file->pid;
 			rc = CIFSSMBSetFileSize(xid, pTcon, attrs->ia_size,
-						nfid, npid, FALSE);
+						nfid, npid, false);
 			atomic_dec(&open_file->wrtPending);
 			cFYI(1,("SetFSize for attrs rc = %d", rc));
 			if((rc == -EINVAL) || (rc == -EOPNOTSUPP)) {
@@ -1185,14 +1185,14 @@ int cifs_setattr(struct dentry *direntry
 			   it was found or because there was an error setting
 			   it by handle */
 			rc = CIFSSMBSetEOF(xid, pTcon, full_path,
-					   attrs->ia_size, FALSE,
+					   attrs->ia_size, false,
 					   cifs_sb->local_nls, 
 					   cifs_sb->mnt_cifs_flags &
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			cFYI(1, ("SetEOF by path (setattrs) rc = %d", rc));
 			if((rc == -EINVAL) || (rc == -EOPNOTSUPP)) {
 				__u16 netfid;
-				int oplock = FALSE;
+				int oplock = false;
 
 				rc = SMBLegacyOpen(xid, pTcon, full_path,
 					FILE_OPEN,
@@ -1217,7 +1217,7 @@ int cifs_setattr(struct dentry *direntry
 
 		/* Server is ok setting allocation size implicitly - no need
 		   to call:
-		CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
+		CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, true,
 			 cifs_sb->local_nls);
 		   */
 
@@ -1269,14 +1269,14 @@ int cifs_setattr(struct dentry *direntry
 	}
 
 	if (attrs->ia_valid & ATTR_ATIME) {
-		set_time = TRUE;
+		set_time = true;
 		time_buf.LastAccessTime =
 		    cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_atime));
 	} else
 		time_buf.LastAccessTime = 0;
 
 	if (attrs->ia_valid & ATTR_MTIME) {
-		set_time = TRUE;
+		set_time = true;
 		time_buf.LastWriteTime =
 		    cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_mtime));
 	} else
@@ -1287,7 +1287,7 @@ int cifs_setattr(struct dentry *direntry
 	   server times */
 	   
 	if (set_time && (attrs->ia_valid & ATTR_CTIME)) {
-		set_time = TRUE;
+		set_time = true;
 		/* Although Samba throws this field away
 		it may be useful to Windows - but we do
 		not want to set ctime unless some other
@@ -1311,7 +1311,7 @@ int cifs_setattr(struct dentry *direntry
 			rc = -EOPNOTSUPP;
 
 		if (rc == -EOPNOTSUPP) {
-			int oplock = FALSE;
+			int oplock = false;
 			__u16 netfid;
 
 			cFYI(1, ("calling SetFileInfo since SetPathInfo for "
diff -Narup a/fs/cifs/link.c b/fs/cifs/link.c
--- a/fs/cifs/link.c	2006-09-01 01:24:45.000000000 +0200
+++ b/fs/cifs/link.c	2006-09-01 02:18:22.000000000 +0200
@@ -208,7 +208,7 @@ cifs_readlink(struct dentry *direntry, c
 	struct inode *inode = direntry->d_inode;
 	int rc = -EACCES;
 	int xid;
-	int oplock = FALSE;
+	int oplock = false;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
 	char *full_path = NULL;
diff -Narup a/fs/cifs/misc.c b/fs/cifs/misc.c
--- a/fs/cifs/misc.c	2006-09-01 01:24:45.000000000 +0200
+++ b/fs/cifs/misc.c	2006-09-01 02:42:00.000000000 +0200
@@ -506,16 +506,16 @@ is_valid_oplock_break(struct smb_hdr *bu
 				pnotify->Action));  /* BB removeme BB */
 	             /*   cifs_dump_mem("Rcvd notify Data: ",buf,
 				sizeof(struct smb_hdr)+60); */
-			return TRUE;
+			return true;
 		}
 		if(pSMBr->hdr.Status.CifsError) {
 			cFYI(1,("notify err 0x%d",pSMBr->hdr.Status.CifsError));
-			return TRUE;
+			return true;
 		}
-		return FALSE;
+		return false;
 	}  
 	if(pSMB->hdr.Command != SMB_COM_LOCKING_ANDX)
-		return FALSE;
+		return false;
 	if(pSMB->hdr.Flags & SMBFLG_RESPONSE) {
 		/* no sense logging error on invalid handle on oplock
 		   break - harmless race between close request and oplock
@@ -524,20 +524,20 @@ is_valid_oplock_break(struct smb_hdr *bu
 		if ((NT_STATUS_INVALID_HANDLE) == 
 		   le32_to_cpu(pSMB->hdr.Status.CifsError)) { 
 			cFYI(1,("invalid handle on oplock break"));
-			return TRUE;
+			return true;
 		} else if (ERRbadfid == 
 		   le16_to_cpu(pSMB->hdr.Status.DosError.Error)) {
-			return TRUE;	  
+			return true;	  
 		} else {
-			return FALSE; /* on valid oplock brk we get "request" */
+			return false; /* on valid oplock brk we get "request" */
 		}
 	}
 	if(pSMB->hdr.WordCount != 8)
-		return FALSE;
+		return false;
 
 	cFYI(1,(" oplock type 0x%d level 0x%d",pSMB->LockType,pSMB->OplockLevel));
 	if(!(pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE))
-		return FALSE;    
+		return false;
 
 	/* look up tcon based on tid & uid */
 	read_lock(&GlobalSMBSeslock);
@@ -554,28 +554,28 @@ is_valid_oplock_break(struct smb_hdr *bu
 					cFYI(1,("file id match, oplock break"));
 					pCifsInode = 
 						CIFS_I(netfile->pInode);
-					pCifsInode->clientCanCacheAll = FALSE;
+					pCifsInode->clientCanCacheAll = false;
 					if(pSMB->OplockLevel == 0)
 						pCifsInode->clientCanCacheRead
-							= FALSE;
-					pCifsInode->oplockPending = TRUE;
+							= false;
+					pCifsInode->oplockPending = true;
 					AllocOplockQEntry(netfile->pInode,
 							  netfile->netfid,
 							  tcon);
 					cFYI(1,("about to wake up oplock thd"));
 					if(oplockThread)
 					    wake_up_process(oplockThread);
-					return TRUE;
+					return true;
 				}
 			}
 			read_unlock(&GlobalSMBSeslock);
 			cFYI(1,("No matching file for oplock break"));
-			return TRUE;
+			return true;
 		}
 	}
 	read_unlock(&GlobalSMBSeslock);
 	cFYI(1,("Can not process oplock break for non-existent connection"));
-	return TRUE;
+	return true;
 }
 
 void
diff -Narup a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
--- a/fs/cifs/netmisc.c	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/netmisc.c	2006-09-01 02:43:05.000000000 +0200
@@ -152,7 +152,7 @@ cifs_inet_pton(int address_family, char 
 
 	temp = *cp;
 
-	while (TRUE) {
+	while (true) {
 		if (!isdigit(temp))
 			return 0;
 
diff -Narup a/fs/cifs/readdir.c b/fs/cifs/readdir.c
--- a/fs/cifs/readdir.c	2006-09-01 01:25:42.000000000 +0200
+++ b/fs/cifs/readdir.c	2006-09-01 02:40:03.000000000 +0200
@@ -414,8 +414,8 @@ static int initiate_cifs_search(const in
 		memset(file->private_data,0,sizeof(struct cifsFileInfo));
 	}
 	cifsFile = file->private_data;
-	cifsFile->invalidHandle = TRUE;
-	cifsFile->srch_inf.endOfSearch = FALSE;
+	cifsFile->invalidHandle = true;
+	cifsFile->srch_inf.endOfSearch = false;
 
 	if(file->f_dentry == NULL)
 		return -ENOENT;
@@ -454,7 +454,7 @@ ffirst_retry:
 		cifs_sb->mnt_cifs_flags & 
 			CIFS_MOUNT_MAP_SPECIAL_CHR, CIFS_DIR_SEP(cifs_sb));
 	if(rc == 0)
-		cifsFile->invalidHandle = FALSE;
+		cifsFile->invalidHandle = false;
 	if((rc == -EOPNOTSUPP) && 
 		(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
 		cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_SERVER_INUM;
@@ -650,7 +650,7 @@ static int find_cifs_entry(const int xid
 	   (index_to_find < first_entry_in_buffer)) {
 		/* close and restart search */
 		cFYI(1,("search backing up - close and restart search"));
-		cifsFile->invalidHandle = TRUE;
+		cifsFile->invalidHandle = true;
 		CIFSFindClose(xid, pTcon, cifsFile->netfid);
 		kfree(cifsFile->search_resume_name);
 		cifsFile->search_resume_name = NULL;
@@ -1013,7 +1013,7 @@ int cifs_readdir(struct file *file, void
 				break;
 			}
 		} /* else {
-			cifsFile->invalidHandle = TRUE;
+			cifsFile->invalidHandle = true;
 			CIFSFindClose(xid, pTcon, cifsFile->netfid);
 		} 
 		kfree(cifsFile->search_resume_name);
diff -Narup a/fs/cifs/smbencrypt.c b/fs/cifs/smbencrypt.c
--- a/fs/cifs/smbencrypt.c	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/smbencrypt.c	2006-09-01 02:25:57.000000000 +0200
@@ -35,13 +35,6 @@
 #include "cifs_debug.h"
 #include "cifsencrypt.h"
 
-#ifndef FALSE
-#define FALSE 0
-#endif
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 /* following came from the other byteorder.h to avoid include conflicts */
 #define CVAL(buf,pos) (((unsigned char *)(buf))[pos])
 #define SSVALX(buf,pos,val) (CVAL(buf,pos)=(val)&0xFF,CVAL(buf,pos+1)=(val)>>8)
diff -Narup a/fs/cifs/xattr.c b/fs/cifs/xattr.c
--- a/fs/cifs/xattr.c	2006-09-01 01:24:46.000000000 +0200
+++ b/fs/cifs/xattr.c	2006-09-01 02:26:02.000000000 +0200
@@ -259,7 +259,7 @@ ssize_t cifs_getxattr(struct dentry * di
 					CIFS_MOUNT_MAP_SPECIAL_CHR);
 /*		else if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_CIFS_ACL) {
 			__u16 fid;
-			int oplock = FALSE;
+			int oplock = false;
 			rc = CIFSSMBOpen(xid, pTcon, full_path,
 					 FILE_OPEN, GENERIC_READ, 0, &fid,
 					 &oplock, NULL, cifs_sb->local_nls,


