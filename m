Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVAONbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVAONbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVAONbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:31:12 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:60327 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262277AbVAON06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:26:58 -0500
Subject: [PATCH 2/6] cifs: remove dead code
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105795546.9555.2.camel@localhost>
References: <1105795546.9555.2.camel@localhost>
Date: Sat, 15 Jan 2005 15:26:54 +0200
Message-Id: <1105795614.9555.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes commented out code.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 asn1.c        |  122 ----------------------------------------------------------
 cifsencrypt.c |    5 --
 cifsfs.c      |   25 -----------
 cifssmb.c     |   48 +---------------------
 connect.c     |   25 -----------
 dir.c         |   18 --------
 fcntl.c       |    5 --
 file.c        |  105 -------------------------------------------------
 inode.c       |   27 ------------
 link.c        |   13 ------
 misc.c        |    6 --
 readdir.c     |   62 -----------------------------
 transport.c   |    2 
 13 files changed, 6 insertions(+), 457 deletions(-)

Index: 2.6/fs/cifs/asn1.c
===================================================================
--- 2.6.orig/fs/cifs/asn1.c	2005-01-12 23:39:37.335242560 +0200
+++ 2.6/fs/cifs/asn1.c	2005-01-12 23:39:40.806714816 +0200
@@ -236,128 +236,6 @@
 	}
 }
 
-/* static unsigned char asn1_null_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc)
-{
-	ctx->pointer = eoc;
-	return 1;
-}
-
-static unsigned char asn1_long_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc, long *integer)
-{
-	unsigned char ch;
-	unsigned int len;
-
-	if (!asn1_octet_decode(ctx, &ch))
-		return 0;
-
-	*integer = (signed char) ch;
-	len = 1;
-
-	while (ctx->pointer < eoc) {
-		if (++len > sizeof(long)) {
-			ctx->error = ASN1_ERR_DEC_BADVALUE;
-			return 0;
-		}
-
-		if (!asn1_octet_decode(ctx, &ch))
-			return 0;
-
-		*integer <<= 8;
-		*integer |= ch;
-	}
-	return 1;
-}
-
-static unsigned char asn1_uint_decode(struct asn1_ctx *ctx,
-				      unsigned char *eoc,
-				      unsigned int *integer)
-{
-	unsigned char ch;
-	unsigned int len;
-
-	if (!asn1_octet_decode(ctx, &ch))
-		return 0;
-
-	*integer = ch;
-	if (ch == 0)
-		len = 0;
-	else
-		len = 1;
-
-	while (ctx->pointer < eoc) {
-		if (++len > sizeof(unsigned int)) {
-			ctx->error = ASN1_ERR_DEC_BADVALUE;
-			return 0;
-		}
-
-		if (!asn1_octet_decode(ctx, &ch))
-			return 0;
-
-		*integer <<= 8;
-		*integer |= ch;
-	}
-	return 1;
-}
-
-static unsigned char asn1_ulong_decode(struct asn1_ctx *ctx,
-				       unsigned char *eoc,
-				       unsigned long *integer)
-{
-	unsigned char ch;
-	unsigned int len;
-
-	if (!asn1_octet_decode(ctx, &ch))
-		return 0;
-
-	*integer = ch;
-	if (ch == 0)
-		len = 0;
-	else
-		len = 1;
-
-	while (ctx->pointer < eoc) {
-		if (++len > sizeof(unsigned long)) {
-			ctx->error = ASN1_ERR_DEC_BADVALUE;
-			return 0;
-		}
-
-		if (!asn1_octet_decode(ctx, &ch))
-			return 0;
-
-		*integer <<= 8;
-		*integer |= ch;
-	}
-	return 1;
-} 
-
-static unsigned char
-asn1_octets_decode(struct asn1_ctx *ctx,
-		   unsigned char *eoc,
-		   unsigned char **octets, unsigned int *len)
-{
-	unsigned char *ptr;
-
-	*len = 0;
-
-	*octets = kmalloc(eoc - ctx->pointer, GFP_ATOMIC);
-	if (*octets == NULL) {
-		return 0;
-	}
-
-	ptr = *octets;
-	while (ctx->pointer < eoc) {
-		if (!asn1_octet_decode(ctx, (unsigned char *) ptr++)) {
-			kfree(*octets);
-			*octets = NULL;
-			return 0;
-		}
-		(*len)++;
-	}
-	return 1;
-} */
-
 static unsigned char
 asn1_subid_decode(struct asn1_ctx *ctx, unsigned long *subid)
 {
Index: 2.6/fs/cifs/cifsencrypt.c
===================================================================
--- 2.6.orig/fs/cifs/cifsencrypt.c	2005-01-12 23:39:37.336242408 +0200
+++ 2.6/fs/cifs/cifsencrypt.c	2005-01-12 23:39:40.807714664 +0200
@@ -120,9 +120,6 @@
 	if(rc)
 		return rc;
 
-	
-/*	cifs_dump_mem("what we think it should be: ",what_we_think_sig_should_be,16); */
-
 	if(memcmp(server_response_sig, what_we_think_sig_should_be, 8))
 		return -EACCES;
 	else
@@ -198,11 +195,9 @@
 {
 	struct HMACMD5Context context;
 	memcpy(v2_session_response + 8, ses->server->cryptKey,8);
-	/* gen_blob(v2_session_response + 16); */
 	hmac_md5_init_limK_to_64(ses->mac_signing_key, 16, &context);
 
 	hmac_md5_update(ses->server->cryptKey,8,&context);
-/*	hmac_md5_update(v2_session_response+16)client thing,8,&context); */ /* BB fix */
 
 	hmac_md5_final(v2_session_response,&context);
 }
Index: 2.6/fs/cifs/cifsfs.c
===================================================================
--- 2.6.orig/fs/cifs/cifsfs.c	2005-01-12 23:39:37.337242256 +0200
+++ 2.6/fs/cifs/cifsfs.c	2005-01-12 23:39:40.808714512 +0200
@@ -109,8 +109,6 @@
 
 	sb->s_magic = CIFS_MAGIC_NUMBER;
 	sb->s_op = &cifs_super_ops;
-/*	if(cifs_sb->tcon->ses->server->maxBuf > MAX_CIFS_HDR_SIZE + 512)
-	    sb->s_blocksize = cifs_sb->tcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE; */
 #ifdef CONFIG_CIFS_QUOTA
 	sb->s_qcop = &cifs_quotactl_ops;
 #endif
@@ -191,10 +189,6 @@
 
 	rc = CIFSSMBQFSInfo(xid, pTcon, buf, cifs_sb->local_nls);
 
-	/*     
-	   int f_type;
-	   __fsid_t f_fsid;
-	   int f_namelen;  */
 	/* BB get from info put in tcon struct at mount time with call to QFSAttrInfo */
 	FreeXid(xid);
 	return 0;		/* always return success? what if volume is no longer available? */
@@ -400,12 +394,7 @@
 	.statfs = cifs_statfs,
 	.alloc_inode = cifs_alloc_inode,
 	.destroy_inode = cifs_destroy_inode,
-/*	.drop_inode	    = generic_delete_inode, 
-	.delete_inode	= cifs_delete_inode,  *//* Do not need the above two functions     
-   unless later we add lazy close of inodes or unless the kernel forgets to call
-   us with the same number of releases (closes) as opens */
 	.show_options = cifs_show_options,
-/*    .umount_begin   = cifs_umount_begin, *//* consider adding in the future */
 	.remount_fs = cifs_remount,
 };
 
@@ -463,11 +452,6 @@
 		return generic_file_read(file,read_data,read_size,poffset);
 	} else {
 		/* BB do we need to lock inode from here until after invalidate? */
-/*		if(file->f_dentry->d_inode->i_mapping) {
-			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
-			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
-		}*/
-/*		cifs_revalidate(file->f_dentry);*/ /* BB fixme */
 
 		/* BB we should make timer configurable - perhaps 
 		   by simply calling cifs_revalidate here */
@@ -519,7 +503,6 @@
 	.name = "cifs",
 	.get_sb = cifs_get_sb,
 	.kill_sb = kill_anon_super,
-	/*  .fs_flags */
 };
 struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
@@ -531,7 +514,6 @@
 	.rmdir = cifs_rmdir,
 	.rename = cifs_rename,
 	.permission = cifs_permission,
-/*	revalidate:cifs_revalidate,   */
 	.setattr = cifs_setattr,
 	.symlink = cifs_symlink,
 	.mknod   = cifs_mknod,
@@ -544,7 +526,6 @@
 };
 
 struct inode_operations cifs_file_inode_ops = {
-/*	revalidate:cifs_revalidate, */
 	.setattr = cifs_setattr,
 	.getattr = cifs_getattr, /* do we need this anymore? */
 	.rename = cifs_rename,
@@ -562,9 +543,6 @@
 	.follow_link = cifs_follow_link,
 	.put_link = cifs_put_link,
 	.permission = cifs_permission,
-	/* BB add the following two eventually */
-	/* revalidate: cifs_revalidate,
-	   setattr:    cifs_notify_change, *//* BB do we need notify change */
 #ifdef CONFIG_CIFS_XATTR
 	.setxattr = cifs_setxattr,
 	.getxattr = cifs_getxattr,
@@ -641,7 +619,6 @@
 	} else {
 		CIFSMaxBufSize &= 0x1FE00; /* Round size to even 512 byte mult*/
 	}
-/*	cERROR(1,("CIFSMaxBufSize %d 0x%x",CIFSMaxBufSize,CIFSMaxBufSize)); */
 	cifs_req_cachep = kmem_cache_create("cifs_request",
 					    CIFSMaxBufSize +
 					    MAX_CIFS_HDR_SIZE, 0,
@@ -794,7 +771,6 @@
 				deadlock when oplock received on delete 
 				since vfs_unlink holds the i_sem across
 				the call */
-				/* down(&inode->i_sem);*/
 				if (S_ISREG(inode->i_mode)) {
 					rc = filemap_fdatawrite(inode->i_mapping);
 					if(CIFS_I(inode)->clientCanCacheRead == 0) {
@@ -803,7 +779,6 @@
 					}
 				} else
 					rc = 0;
-				/* up(&inode->i_sem);*/
 				if (rc)
 					CIFS_I(inode)->write_behind_rc = rc;
 				cFYI(1,("Oplock flush inode %p rc %d",inode,rc));
Index: 2.6/fs/cifs/cifssmb.c
===================================================================
--- 2.6.orig/fs/cifs/cifssmb.c	2005-01-12 23:39:39.111972456 +0200
+++ 2.6/fs/cifs/cifssmb.c	2005-01-12 23:39:40.817713144 +0200
@@ -739,8 +739,6 @@
 	if (tcon->ses->capabilities & CAP_UNIX)
 		pSMB->FileAttributes |= cpu_to_le32(ATTR_POSIX_SEMANTICS);
 
-	/* if ((omode & S_IWUGO) == 0)
-		pSMB->FileAttributes |= cpu_to_le32(ATTR_READONLY);*/
 	/*  Above line causes problems due to vfs splitting create into two
 		pieces - need to set mode after file created not while it is
 		being created */
@@ -838,10 +836,6 @@
 			pReadData =
 			    (char *) (&pSMBr->hdr.Protocol) +
 			    le16_to_cpu(pSMBr->DataOffset);
-/*			if(rc = copy_to_user(buf, pReadData, data_length)) {
-				cERROR(1,("Faulting on read rc = %d",rc));
-				rc = -EFAULT;
-			}*/ /* can not use copy_to_user when using page cache*/
 			if(*buf)
 			    memcpy(*buf,pReadData,data_length);
 		}
@@ -979,13 +973,7 @@
 	pSMB->hdr.smb_buf_length += byte_count;
 	pSMB->ByteCount = cpu_to_le16(byte_count);
 
-/*	rc = SendReceive2(xid, tcon->ses, (struct smb_hdr *) pSMB,
-			 (struct smb_hdr *) pSMBr, buf, buflen, &bytes_returned, long_op); */  /* BB fixme BB */
-	if (rc) {
-		cFYI(1, ("Send error in write2 (large write) = %d", rc));
-		*nbytes = 0;
-	} else
-		*nbytes = le16_to_cpu(pSMBr->Count);
+	*nbytes = le16_to_cpu(pSMBr->Count);
 
 	if (pSMB)
 		cifs_small_buf_release(pSMB);
@@ -1774,9 +1762,6 @@
 	ace->e_perm = (__u16)cifs_ace->cifs_e_perm; 
 	ace->e_tag  = (__u16)cifs_ace->cifs_e_tag;
 	ace->e_id   = (__u32)le64_to_cpu(cifs_ace->cifs_uid);
-	/* cFYI(1,("perm %d tag %d id %d",ace->e_perm,ace->e_tag,ace->e_id)); */
-
-	return;
 }
 
 /* Convert ACL from CIFS POSIX wire format to local Linux POSIX ACL xattr */
@@ -1846,7 +1831,6 @@
 		cifs_ace->cifs_uid = cpu_to_le64(-1);
 	} else 
 		cifs_ace->cifs_uid = (__u64)cpu_to_le32(local_ace->e_id);
-        /*cFYI(1,("perm %d tag %d id %d",ace->e_perm,ace->e_tag,ace->e_id));*/
 	return rc;
 }
 
@@ -2079,7 +2063,6 @@
 	int name_len;
 	__u16 params, byte_count;
 
-/* cFYI(1, ("In QPathInfo path %s", searchName)); */ /* BB fixme BB */
 QPathInfoRetry:
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
 		      (void **) &pSMBr);
@@ -2537,7 +2520,6 @@
 			psrch_inf->entries_in_buffer  = le16_to_cpu(parms->SearchCount);
 			psrch_inf->index_of_last_entry = 
 				psrch_inf->entries_in_buffer;
-/*cFYI(1,("entries in buf %d index_of_last %d",psrch_inf->entries_in_buffer,psrch_inf->index_of_last_entry));  */
 			*pnetfid = parms->SearchHandle;
 		} else {
 			if(pSMB)
@@ -2590,15 +2572,6 @@
 	pSMB->SearchHandle = searchHandle;      /* always kept as le */
 	pSMB->SearchCount =
 		cpu_to_le16(CIFSMaxBufSize / sizeof (FILE_UNIX_INFO));
-	/* test for Unix extensions */
-/*	if (tcon->ses->capabilities & CAP_UNIX) {
-		pSMB->InformationLevel = cpu_to_le16(SMB_FIND_FILE_UNIX);
-		psrch_inf->info_level = SMB_FIND_FILE_UNIX;
-	} else {
-		pSMB->InformationLevel =
-		   cpu_to_le16(SMB_FIND_FILE_DIRECTORY_INFO);
-		psrch_inf->info_level = SMB_FIND_FILE_DIRECTORY_INFO;
-	} */
 	pSMB->InformationLevel = cpu_to_le16(psrch_inf->info_level);
 	pSMB->ResumeKey = psrch_inf->resume_key;
 	pSMB->SearchFlags =
@@ -2653,8 +2626,6 @@
 			psrch_inf->entries_in_buffer  = le16_to_cpu(parms->SearchCount);
 			psrch_inf->index_of_last_entry +=
 				psrch_inf->entries_in_buffer;
-/*  cFYI(1,("fnxt2 entries in buf %d index_of_last %d",psrch_inf->entries_in_buffer,psrch_inf->index_of_last_entry)); */
-
 			/* BB fixme add unlock here */
 		}
 
@@ -3798,8 +3769,6 @@
 	}
 	if (pSMB)
 		cifs_buf_release(pSMB);
-/*		if (rc == -EAGAIN)
-			goto NotifyRetry; */
 	return rc;	
 }
 #ifdef CONFIG_CIFS_XATTR
@@ -3875,11 +3844,7 @@
 		of these trans2 responses */
 		if (rc || (pSMBr->ByteCount < 4)) 
 			rc = -EIO;	/* bad smb */
-	   /* else if (pFindData){
-			memcpy((char *) pFindData,
-			       (char *) &pSMBr->hdr.Protocol +
-			       data_offset, kl);
-		}*/ else {
+		else {
 			/* check that length of list is not more than bcc */
 			/* check that each entry does not go beyond length
 			   of list */
@@ -3888,7 +3853,6 @@
 			__u16 data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 			struct fealist * ea_response_data;
 			rc = 0;
-			/* validate_trans2_offsets() */
 			/* BB to check if(start of smb + data_offset > &bcc+ bcc)*/
 			ea_response_data = (struct fealist *)
 				(((char *) &pSMBr->hdr.Protocol) +
@@ -4019,11 +3983,7 @@
 		of these trans2 responses */
 		if (rc || (pSMBr->ByteCount < 4)) 
 			rc = -EIO;	/* bad smb */
-	   /* else if (pFindData){
-			memcpy((char *) pFindData,
-			       (char *) &pSMBr->hdr.Protocol +
-			       data_offset, kl);
-		}*/ else {
+		else {
 			/* check that length of list is not more than bcc */
 			/* check that each entry does not go beyond length
 			   of list */
@@ -4032,7 +3992,6 @@
 			__u16 data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 			struct fealist * ea_response_data;
 			rc = -ENODATA;
-			/* validate_trans2_offsets() */
 			/* BB to check if(start of smb + data_offset > &bcc+ bcc)*/
 			ea_response_data = (struct fealist *)
 				(((char *) &pSMBr->hdr.Protocol) +
@@ -4176,7 +4135,6 @@
 	we need to ensure that it fits within the smb */
 
 	/*BB add length check that it would fit in negotiated SMB buffer size BB */
-	/* if(ea_value_len > buffer_size - 512 (enough for header)) */
 	if(ea_value_len)
 		memcpy(parm_data->list[0].name+name_len+1,ea_value,ea_value_len);
 
Index: 2.6/fs/cifs/connect.c
===================================================================
--- 2.6.orig/fs/cifs/connect.c	2005-01-12 23:39:37.344241192 +0200
+++ 2.6/fs/cifs/connect.c	2005-01-12 23:39:40.821712536 +0200
@@ -184,7 +184,6 @@
 			if(server->tcpStatus != CifsExiting)
 				server->tcpStatus = CifsGood;
 			spin_unlock(&GlobalMid_Lock);
-	/*		atomic_set(&server->inFlight,0);*/
 			wake_up(&server->response_q);
 		}
 	}
@@ -1200,8 +1199,6 @@
 
 	xid = GetXid();
 
-/* cFYI(1, ("Entering cifs_mount. Xid: %d with: %s", xid, mount_data)); */
-	
 	memset(&volume_info,0,sizeof(struct smb_vol));
 	if (cifs_parse_mount_options(mount_data, devname, &volume_info)) {
 		if(volume_info.UNC)
@@ -1518,7 +1515,6 @@
 				} else
 					cFYI(1, ("No session or bad tcon"));
 				sesInfoFree(pSesInfo);
-				/* pSesInfo = NULL; */
 			}
 		}
 	} else {
@@ -1928,7 +1924,6 @@
 	rc = SendReceive(xid, ses, smb_buffer, smb_buffer_response,
 			 &bytes_returned, 1);
 	if (rc) {
-/*    rc = map_smb_to_linux_error(smb_buffer_response);  *//* done in SendReceive now */
 	} else if ((smb_buffer_response->WordCount == 3)
 		   || (smb_buffer_response->WordCount == 4)) {
 		__u16 action = le16_to_cpu(pSMBr->resp.Action);
@@ -2137,7 +2132,7 @@
 	negotiate_flags =
 	    NTLMSSP_NEGOTIATE_UNICODE | NTLMSSP_NEGOTIATE_OEM |
 	    NTLMSSP_REQUEST_TARGET | NTLMSSP_NEGOTIATE_NTLM | 0x80000000 |
-	    /* NTLMSSP_NEGOTIATE_ALWAYS_SIGN | */ NTLMSSP_NEGOTIATE_128;
+	    NTLMSSP_NEGOTIATE_128;
 	if(sign_CIFS_PDUs)
 		negotiate_flags |= NTLMSSP_NEGOTIATE_SIGN;
 	if(ntlmv2_support)
@@ -2218,7 +2213,6 @@
 		rc = 0;
 
 	if (rc) {
-/*    rc = map_smb_to_linux_error(smb_buffer_response);  *//* done in SendReceive now */
 	} else if ((smb_buffer_response->WordCount == 3)
 		   || (smb_buffer_response->WordCount == 4)) {
 		__u16 action = le16_to_cpu(pSMBr->resp.Action);
@@ -2483,7 +2477,7 @@
 	    NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_TARGET_INFO |
 	    0x80000000 | NTLMSSP_NEGOTIATE_128;
 	if(sign_CIFS_PDUs)
-		negotiate_flags |= /* NTLMSSP_NEGOTIATE_ALWAYS_SIGN |*/ NTLMSSP_NEGOTIATE_SIGN;
+		negotiate_flags |= NTLMSSP_NEGOTIATE_SIGN;
 	if(ntlmv2_flag)
 		negotiate_flags |= NTLMSSP_NEGOTIATE_NTLMV2;
 
@@ -2548,14 +2542,6 @@
 			    cpu_to_le16(len);
 		}
 
-		/* SecurityBlob->WorkstationName.Length = cifs_strtoUCS((wchar_t *) bcc_ptr, "AMACHINE",64, nls_codepage);
-		   SecurityBlob->WorkstationName.Length *= 2;
-		   SecurityBlob->WorkstationName.MaximumLength = cpu_to_le16(SecurityBlob->WorkstationName.Length);
-		   SecurityBlob->WorkstationName.Buffer = cpu_to_le32(SecurityBlobLength);
-		   bcc_ptr += SecurityBlob->WorkstationName.Length;
-		   SecurityBlobLength += SecurityBlob->WorkstationName.Length;
-		   SecurityBlob->WorkstationName.Length = cpu_to_le16(SecurityBlob->WorkstationName.Length);  */
-
 		if ((long) bcc_ptr % 2) {
 			*bcc_ptr = 0;
 			bcc_ptr++;
@@ -2633,7 +2619,6 @@
 	rc = SendReceive(xid, ses, smb_buffer, smb_buffer_response,
 			 &bytes_returned, 1);
 	if (rc) {
-/*    rc = map_smb_to_linux_error(smb_buffer_response);  *//* done in SendReceive now */
 	} else if ((smb_buffer_response->WordCount == 3)
 		   || (smb_buffer_response->WordCount == 4)) {
 		__u16 action = le16_to_cpu(pSMBr->resp.Action);
@@ -2641,9 +2626,6 @@
 		    le16_to_cpu(pSMBr->resp.SecurityBlobLength);
 		if (action & GUEST_LOGIN)
 			cFYI(1, (" Guest login"));	/* BB do we want to set anything in SesInfo struct ? */
-/*        if(SecurityBlob2->MessageType != NtLm??){                               
-                 cFYI("Unexpected message type on auth response is %d ")); 
-        } */
 		if (ses) {
 			cFYI(1,
 			     ("Does UID on challenge %d match auth response UID %d ",
@@ -2856,8 +2838,6 @@
 
 	rc = SendReceive(xid, ses, smb_buffer, smb_buffer_response, &length, 0);
 
-	/* if (rc) rc = map_smb_to_linux_error(smb_buffer_response); */
-	/* above now done in SendReceive */
 	if ((rc == 0) && (tcon != NULL)) {
 		tcon->tidStatus = CifsGood;
 		tcon->tid = smb_buffer_response->Tid;
@@ -3017,7 +2997,6 @@
 					v2_response = kmalloc(16 + 64 /* blob */, GFP_KERNEL);
 					if(v2_response) {
 						CalcNTLMv2_response(pSesInfo,v2_response);
-/*						cifs_calculate_ntlmv2_mac_key(pSesInfo->mac_signing_key, response, ntlm_session_key, */
 						kfree(v2_response);
 					/* BB Put dummy sig in SessSetup PDU? */
 					} else
Index: 2.6/fs/cifs/dir.c
===================================================================
--- 2.6.orig/fs/cifs/dir.c	2005-01-12 23:39:37.345241040 +0200
+++ 2.6/fs/cifs/dir.c	2005-01-12 23:39:40.822712384 +0200
@@ -297,7 +297,6 @@
 				pCifsFile->closePend     = FALSE;
 				init_MUTEX(&pCifsFile->fh_sem);
 				/* put the following in at open now */
-				/* pCifsFile->pfile = file; */ 
 				write_lock(&GlobalSMBSeslock);
 				list_add(&pCifsFile->tlist,&pTcon->openFileList);
 				pCifsInode = CIFS_I(newinode);
@@ -489,11 +488,8 @@
 {
 	int isValid = 1;
 
-/*	lock_kernel(); *//* surely we do not want to lock the kernel for a whole network round trip which could take seconds */
-
 	if (direntry->d_inode) {
 		if (cifs_revalidate(direntry)) {
-			/* unlock_kernel(); */
 			return 0;
 		}
 	} else {
@@ -501,23 +497,9 @@
 		     ("In cifs_d_revalidate with no inode but name = %s and dentry 0x%p",
 		      direntry->d_name.name, direntry));
 	}
-
-/*    unlock_kernel(); */
-
 	return isValid;
 }
 
-/* static int cifs_d_delete(struct dentry *direntry)
-{
-	int rc = 0;
-
-	cFYI(1, ("In cifs d_delete, name = %s", direntry->d_name.name));
-
-	return rc;
-}     */
-
 struct dentry_operations cifs_dentry_ops = {
 	.d_revalidate = cifs_d_revalidate,
-/* d_delete:       cifs_d_delete,       *//* not needed except for debugging */
-	/* no need for d_hash, d_compare, d_release, d_iput ... yet. BB confirm this BB */
 };
Index: 2.6/fs/cifs/fcntl.c
===================================================================
--- 2.6.orig/fs/cifs/fcntl.c	2005-01-12 23:39:37.346240888 +0200
+++ 2.6/fs/cifs/fcntl.c	2005-01-12 23:39:40.823712232 +0200
@@ -58,11 +58,6 @@
 		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_SECURITY | 
 			FILE_NOTIFY_CHANGE_ATTRIBUTES;
 	}
-/*	if(fcntl_notify_flags & DN_MULTISHOT) {
-		cifs_ntfy_flags |= ;
-	} */ /* BB fixme - not sure how to handle this with CIFS yet */
-
-
 	return cifs_ntfy_flags;
 }
 
Index: 2.6/fs/cifs/file.c
===================================================================
--- 2.6.orig/fs/cifs/file.c	2005-01-12 23:39:39.114972000 +0200
+++ 2.6/fs/cifs/file.c	2005-01-12 23:39:40.826711776 +0200
@@ -340,14 +340,6 @@
 	 and server version of file size can be stale. If we 
 	 knew for sure that inode was not dirty locally we could do this */
 
-/*	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
-	if(buf==0) {
-		up(&pCifsFile->fh_sem);
-		if (full_path)
-			kfree(full_path);
-		FreeXid(xid);
-		return -ENOMEM;
-	}*/
 	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,
 				CREATE_NOT_DIR, &netfid, &oplock, NULL, cifs_sb->local_nls);
 	if (rc) {
@@ -584,7 +576,6 @@
 			rc = 0;
 
 		} else {
-			/* if rc == ERR_SHARING_VIOLATION ? */
 			rc = 0;	/* do not change lock type to unlock since range in use */
 		}
 
@@ -624,10 +615,6 @@
 	}
 	pTcon = cifs_sb->tcon;
 
-	/*cFYI(1,
-	   (" write %d bytes to offset %lld of %s", write_size,
-	   *poffset, file->f_dentry->d_name.name)); */
-
 	if (file->private_data == NULL) {
 		return -EBADF;
 	} else {
@@ -744,10 +731,6 @@
 	}
 	pTcon = cifs_sb->tcon;
 
-	/*cFYI(1,
-	   (" write %d bytes to offset %lld of %s", write_size,
-	   *poffset, file->f_dentry->d_name.name)); */
-
 	if (file->private_data == NULL) {
 		return -EBADF;
 	} else {
@@ -937,20 +920,6 @@
 	return rc;
 }
 
-#if 0
-static int
-cifs_writepages(struct address_space *mapping, struct writeback_control *wbc)
-{
-	int rc = -EFAULT;
-	int xid;
-
-	xid = GetXid();
-/* call 16K write then Setpageuptodate */
-	FreeXid(xid);
-	return rc;
-}
-#endif
-
 static int
 cifs_writepage(struct page* page, struct writeback_control *wbc)
 {
@@ -986,30 +955,6 @@
 	cFYI(1,("commit write for page %p up to position %lld for %d",page,position,to));
 	if (position > inode->i_size){
 		i_size_write(inode, position);
-		/*if (file->private_data == NULL) {
-			rc = -EBADF;
-		} else {
-			open_file = (struct cifsFileInfo *)file->private_data;
-			cifs_sb = CIFS_SB(inode->i_sb);
-			rc = -EAGAIN;
-			while(rc == -EAGAIN) {
-				if((open_file->invalidHandle) && 
-				  (!open_file->closePend)) {
-					rc = cifs_reopen_file(file->f_dentry->d_inode,file);
-					if(rc != 0)
-						break;
-				}
-				if(!open_file->closePend) {
-					rc = CIFSSMBSetFileSize(xid, cifs_sb->tcon, 
-						position, open_file->netfid,
-						open_file->pid,FALSE);
-				} else {
-					rc = -EBADF;
-					break;
-				}
-			}
-			cFYI(1,(" SetEOF (commit write) rc = %d",rc));
-		}*/
 	}
 	if (!PageUptodate(page)) {
 		position =  ((loff_t)page->index << PAGE_CACHE_SHIFT) + offset;
@@ -1031,7 +976,6 @@
                                         &position);
 		if(rc > 0)
 			rc = 0;
-		/* else if rc < 0 should we set writebehind rc? */
 		kunmap(page);
 	} else {	
 		set_page_dirty(page);
@@ -1060,33 +1004,6 @@
 	return rc;
 }
 
-/* static int
-cifs_sync_page(struct page *page)
-{
-	struct address_space *mapping;
-	struct inode *inode;
-	unsigned long index = page->index;
-	unsigned int rpages = 0;
-	int rc = 0;
-
-	cFYI(1,("sync page %p",page));
-	mapping = page->mapping;
-	if (!mapping)
-		return 0;
-	inode = mapping->host;
-	if (!inode)
-		return 0;*/
-
-/*	fill in rpages then 
-    result = cifs_pagein_inode(inode, index, rpages); *//* BB finish */
-
-/*   cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
-
-	if (rc < 0)
-		return rc;
-	return 0;
-} */
-
 /*
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
@@ -1444,13 +1361,6 @@
 				/* server copy of file can have smaller size than client */
 				/* BB do we need to verify this common case ? this case is ok - 
 				if we are at server EOF we will hit it on next read */
-
-			/* while(!list_empty(page_list) && (i < num_pages)) {
-					page = list_entry(page_list->prev,struct page, list);
-					list_del(&page->list);
-					page_cache_release(page);
-				}
-				break; */
 			}
 		} else {
 			cFYI(1,("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list",bytes_read,offset)); 
@@ -1622,10 +1532,6 @@
 			tmp_inode->i_mode = cifs_sb->mnt_dir_mode;
 		}
 		tmp_inode->i_mode |= S_IFDIR;
-/* we no longer mark these because we could not follow them */
-/*        } else if (attr & ATTR_REPARSE) {
-                *pobject_type = DT_LNK;
-                tmp_inode->i_mode |= S_IFLNK;*/
 	} else {
 		*pobject_type = DT_REG;
 		tmp_inode->i_mode |= S_IFREG;
@@ -1746,7 +1652,6 @@
 	} else if (S_ISLNK(tmp_inode->i_mode)) {
 		cFYI(1, ("Symbolic Link inode"));
 		tmp_inode->i_op = &cifs_symlink_inode_ops;
-/* tmp_inode->i_fop = *//* do not need to set to anything */
 	} else {
 		cFYI(1, ("Special inode")); 
 		init_special_inode(tmp_inode, tmp_inode->i_mode,
@@ -2179,7 +2084,6 @@
 					(FILE_DIRECTORY_INFO *) ((char *) pfindData
 						 + le32_to_cpu(pfindData->NextEntryOffset));
 				/* BB also should check to make sure that pointer is not beyond the end of the SMB */
-				/* if(pfindData > lastFindData) rc = -EIO; break; */
 			}	/* end for loop */
 			if ((findParms.EndofSearch != 0) && cifsFile) {
 				cifsFile->srch_inf.endOfSearch = TRUE;
@@ -2405,13 +2309,6 @@
         loff_t offset = (loff_t)page->index << PAGE_CACHE_SHIFT;
 	cFYI(1,("prepare write for page %p from %d to %d",page,from,to));
 	if (!PageUptodate(page)) {
-	/*	if (to - from != PAGE_CACHE_SIZE) {
-			void *kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr, 0, from);
-			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-		} */
 		/* If we are writing a full page it will be up to date,
 		no need to read from the server */
 		if((to==PAGE_CACHE_SIZE) && (from == 0))
@@ -2440,6 +2337,4 @@
 	.prepare_write = cifs_prepare_write, 
 	.commit_write = cifs_commit_write,
 	.set_page_dirty = __set_page_dirty_nobuffers,
-   /* .sync_page = cifs_sync_page, */
-	/*.direct_IO = */
 };
Index: 2.6/fs/cifs/inode.c
===================================================================
--- 2.6.orig/fs/cifs/inode.c	2005-01-12 23:39:37.350240280 +0200
+++ 2.6/fs/cifs/inode.c	2005-01-12 23:39:40.828711472 +0200
@@ -49,7 +49,6 @@
 	/* we could have done a find first instead but this returns more info */
 	rc = CIFSSMBUnixQPathInfo(xid, pTcon, search_path, &findData,
 				  cifs_sb->local_nls);
-	/* dump_mem("\nUnixQPathInfo return data", &findData, sizeof(findData)); */
 	if (rc) {
 		if (rc == -EREMOTE) {
 			tmp_path =
@@ -149,9 +148,6 @@
 		size of 512 is required to be used for calculating num blocks */
 		 
 
-/*		inode->i_blocks = 
-	                (inode->i_blksize - 1 + num_of_bytes) >> inode->i_blkbits;*/
-
 		/* 512 bytes (2**9) is the fake blocksize that must be used */
 		/* for this calculation */
 			inode->i_blocks = (512 - 1 + num_of_bytes) >> 9;
@@ -174,7 +170,6 @@
 		} else if (S_ISLNK(inode->i_mode)) {
 			cFYI(1, (" Symbolic Link inode "));
 			inode->i_op = &cifs_symlink_inode_ops;
-/* tmp_inode->i_fop = *//* do not need to set to anything */
 		} else {
 			cFYI(1, (" Init special inode "));
 			init_special_inode(inode, inode->i_mode,
@@ -215,7 +210,6 @@
 		rc = CIFSSMBQPathInfo(xid, pTcon, search_path, pfindData,
 			      cifs_sb->local_nls);
 	}
-	/* dump_mem("\nQPathInfo return data",&findData, sizeof(findData)); */
 	if (rc) {
 		if (rc == -EREMOTE) {
 			tmp_path =
@@ -261,11 +255,6 @@
 			Are there Windows server or network appliances
 			for which IndexNumber field is not guaranteed unique? */
 		
-			/* if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
-				(*pinode)->i_ino = 
-					(unsigned long)pfindData->IndexNumber;
-			} */ /*NB: ino incremented to unique num in new_inode*/
-
 			insert_inode_hash(*pinode);
 		}
 		inode = *pinode;
@@ -295,7 +284,6 @@
 			/* new inode, can safely set these fields */
 			inode->i_mode = cifs_sb->mnt_file_mode;
 
-/*		if (attr & ATTR_REPARSE)  */
 /* 		We no longer handle these as symlinks because we could not */
 /* 		follow them due to the absolute path with drive letter */
 		if (attr & ATTR_DIRECTORY) {
@@ -391,9 +379,7 @@
 
 /* Unlink can be called from rename so we can not grab
 	the sem here since we deadlock otherwise */
-/*	down(&direntry->d_sb->s_vfs_rename_sem);*/
 	full_path = build_path_from_dentry(direntry);
-/*	up(&direntry->d_sb->s_vfs_rename_sem);*/
 	if(full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
@@ -730,16 +716,12 @@
 					 direntry->d_sb,xid);
 		if(rc) {
 			cFYI(1,("error on getting revalidate info %d",rc));
-/*			if(rc != -ENOENT)
-				rc = 0; */ /* BB should we cache info on certain errors? */
 		}
 	} else {
 		rc = cifs_get_inode_info(&direntry->d_inode, full_path, NULL,
 				    direntry->d_sb,xid);
 		if(rc) {
 			cFYI(1,("error on getting revalidate info %d",rc));
-/*			if(rc != -ENOENT)
-				rc = 0; */  /* BB should we cache info on certain errors? */
 		}
 	}
 	/* should we remap certain errors, access denied?, to zero */
@@ -765,7 +747,6 @@
 		documentation indicates i_sem may be taken by the kernel 
 		on lookup and rename which could deadlock if we grab
 		the i_sem here as well */
-/*	down(&direntry->d_inode->i_sem);*/
 	/* need to write out dirty pages here  */
 	if(direntry->d_inode->i_mapping) {
 		/* do we need to lock inode until after invalidate completes below? */
@@ -780,7 +761,6 @@
 			invalidate_remote_inode(direntry->d_inode);
 		}
 	}
-/*	up(&direntry->d_inode->i_sem);*/
 	
 	if (full_path)
 		kfree(full_path);
@@ -907,7 +887,6 @@
 		}
         
 	/*  Server is ok setting allocation size implicitly - no need to call: */
-	/*CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE, cifs_sb->local_nls);*/
 
 		if (rc == 0) {
 			rc = vmtruncate(direntry->d_inode, attrs->ia_size);
@@ -917,19 +896,16 @@
 	if (attrs->ia_valid & ATTR_UID) {
 		cFYI(1, (" CIFS - UID changed to %d", attrs->ia_uid));
 		uid = attrs->ia_uid;
-		/*        entry->uid = cpu_to_le16(attr->ia_uid); */
 	}
 	if (attrs->ia_valid & ATTR_GID) {
 		cFYI(1, (" CIFS - GID changed to %d", attrs->ia_gid));
 		gid = attrs->ia_gid;
-		/*      entry->gid = cpu_to_le16(attr->ia_gid); */
 	}
 
 	time_buf.Attributes = 0;
 	if (attrs->ia_valid & ATTR_MODE) {
 		cFYI(1, (" CIFS - Mode changed to 0x%x", attrs->ia_mode));
 		mode = attrs->ia_mode;
-		/* entry->mode = cpu_to_le16(attr->ia_mode); */
 	}
 
 	if ((cifs_sb->tcon->ses->capabilities & CAP_UNIX)
@@ -947,7 +923,6 @@
 					cpu_to_le32(cifsInode->cifsAttrs & (~ATTR_READONLY));
 		}
 		/* BB to be implemented - via Windows security descriptors or streams */
-		/* CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,uid,gid,cifs_sb->local_nls);*/
 	}
 
 	if (attrs->ia_valid & ATTR_ATIME) {
@@ -987,8 +962,6 @@
 			below rather than here */
 			/* Better to return EOPNOTSUPP until function
 			below is ready */
-			/* CIFSSMBSetTimesLegacy(xid, pTcon, full_path,
-        	        FILE_INFO_STANDARD * data, cifs_sb->local_nls); */
 		}
 	}
 
Index: 2.6/fs/cifs/link.c
===================================================================
--- 2.6.orig/fs/cifs/link.c	2005-01-12 23:39:37.352239976 +0200
+++ 2.6/fs/cifs/link.c	2005-01-12 23:39:40.829711320 +0200
@@ -67,14 +67,6 @@
 			rc = -EOPNOTSUPP;  
 	}
 
-/* if (!rc)     */
-	{
-		/*   renew_parental_timestamps(old_file);
-		   inode->i_nlink++;
-		   mark_inode_dirty(inode);
-		   d_instantiate(direntry, inode); */
-		/* BB add call to either mark inode dirty or refresh its data and timestamp to current time */
-	}
 	d_drop(direntry);	/* force new lookup from server */
 	cifsInode = CIFS_I(old_file->d_inode);
 	cifsInode->time = 0;	/* will force revalidate to go get info when needed */
@@ -124,7 +116,6 @@
 					     PATH_MAX-1,
 					     cifs_sb->local_nls);
 	else {
-		/* rc = CIFSSMBQueryReparseLinkInfo */
 		/* BB Add code to Query ReparsePoint info */
 		/* BB Add MAC style xsymlink check here if enabled */
 	}
@@ -178,8 +169,6 @@
 	if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)
 		rc = CIFSUnixCreateSymLink(xid, pTcon, full_path, symname,
 					   cifs_sb->local_nls);
-	/* else
-	   rc = CIFSCreateReparseSymLink(xid, pTcon, fromName, toName,cifs_sb_target->local_nls); */
 
 	if (rc == 0) {
 		if (pTcon->ses->capabilities & CAP_UNIX)
@@ -228,9 +217,7 @@
 
 /* BB would it be safe against deadlock to grab this sem 
       even though rename itself grabs the sem and calls lookup? */
-/*       down(&inode->i_sb->s_vfs_rename_sem);*/
 	full_path = build_path_from_dentry(direntry);
-/*       up(&inode->i_sb->s_vfs_rename_sem);*/
 
 	if(full_path == NULL) {
 		FreeXid(xid);
Index: 2.6/fs/cifs/misc.c
===================================================================
--- 2.6.orig/fs/cifs/misc.c	2005-01-12 23:39:37.353239824 +0200
+++ 2.6/fs/cifs/misc.c	2005-01-12 23:39:40.830711168 +0200
@@ -59,8 +59,6 @@
 _FreeXid(unsigned int xid)
 {
 	spin_lock(&GlobalMid_Lock);
-	/* if(GlobalTotalActiveXid == 0)
-		BUG(); */
 	GlobalTotalActiveXid--;
 	spin_unlock(&GlobalMid_Lock);
 }
@@ -175,13 +173,11 @@
 {
 
 	if (buf_to_free == NULL) {
-		/* cFYI(1, ("Null buffer passed to cifs_buf_release"));*/
 		return;
 	}
 	mempool_free(buf_to_free,cifs_req_poolp);
 
 	atomic_dec(&bufAllocCount);
-	return;
 }
 
 struct smb_hdr *
@@ -197,7 +193,6 @@
 	    (struct smb_hdr *) mempool_alloc(cifs_sm_req_poolp, SLAB_KERNEL | SLAB_NOFS);
 	if (ret_buf) {
 	/* No need to clear memory here, cleared in header assemble */
-	/*	memset(ret_buf, 0, sizeof(struct smb_hdr) + 27);*/
 		atomic_inc(&smBufAllocCount);
 	}
 	return ret_buf;
@@ -404,7 +399,6 @@
 				+ data_offset);
 			cFYI(1,("dnotify on %s with action: 0x%x",pnotify->FileName,
 				pnotify->Action));  /* BB removeme BB */
-	             /*   cifs_dump_mem("Received notify Data is: ",buf,sizeof(struct smb_hdr)+60); */
 			return TRUE;
 		}
 		if(pSMBr->hdr.Status.CifsError) {
Index: 2.6/fs/cifs/readdir.c
===================================================================
--- 2.6.orig/fs/cifs/readdir.c	2005-01-12 23:39:37.355239520 +0200
+++ 2.6/fs/cifs/readdir.c	2005-01-12 23:39:40.832710864 +0200
@@ -47,30 +47,6 @@
 	      FILE_UNIX_INFO * pfindData, int *pobject_type);
 
 
-/* BB fixme - add debug wrappers around this function to disable it fixme BB */
-/* static void dump_cifs_file_struct(struct file * file, char * label)
-{
-	struct cifsFileInfo * cf;
-
-	if(file) {
-		cf = (struct cifsFileInfo *)file->private_data;
-		if(cf == NULL) {
-			cFYI(1,("empty cifs private file data"));
-			return;
-		}
-		if(cf->invalidHandle) {
-			cFYI(1,("invalid handle"));
-		}
-		if(cf->srch_inf.endOfSearch) {
-			cFYI(1,("end of search"));
-		}
-		if(cf->srch_inf.emptyDir) {
-			cFYI(1,("empty dir"));
-		}
-		
-	}
-} */
-
 static int initiate_cifs_search(const int xid, struct file * file)
 {
 	int rc = 0;
@@ -255,7 +231,6 @@
 	first_entry_in_buffer = 
 		cifsFile->srch_inf.index_of_last_entry - 
 			cifsFile->srch_inf.entries_in_buffer;
-/*	dump_cifs_file_struct(file, "In fce ");*/
 	if(index_to_find < first_entry_in_buffer) {
 		/* close and restart search */
 		cFYI(1,("search backing up - close and restart search"));
@@ -290,7 +265,6 @@
 		char * current_entry;
 		char * end_of_smb = cifsFile->srch_inf.ntwrk_buf_start + 
 			smbCalcSize((struct smb_hdr *)cifsFile->srch_inf.ntwrk_buf_start);
-/*	dump_cifs_file_struct(file,"found entry in fce "); */
 		first_entry_in_buffer = cifsFile->srch_inf.index_of_last_entry -
 			cifsFile->srch_inf.entries_in_buffer;
 		pos_in_buf = index_to_find - first_entry_in_buffer;
@@ -325,7 +299,6 @@
 		*num_to_ret = 0;
 	} else
 		*num_to_ret = cifsFile->srch_inf.entries_in_buffer - pos_in_buf;
-/*	dump_cifs_file_struct(file, "end fce ");*/
 
 	return rc;
 }
@@ -388,7 +361,6 @@
 		pqst->len = len;
 	}
 	pqst->hash = full_name_hash(pqst->name,pqst->len);
-/*	cFYI(1,("filldir on %s",pqst->name));  */
 	return rc;
 }
 
@@ -533,32 +505,15 @@
 		FreeXid(xid);
 		return -EIO;
 	}
-/*	dump_cifs_file_struct(file, "Begin rdir "); */
 
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 	if(pTcon == NULL)
 		return -EINVAL;
 
-/*	cFYI(1,("readdir2 pos: %lld",file->f_pos)); */
-
 	switch ((int) file->f_pos) {
 	case 0:
-		/*if (filldir(direntry, ".", 1, file->f_pos,
-		     file->f_dentry->d_inode->i_ino, DT_DIR) < 0) {
-			cERROR(1, ("Filldir for current dir failed "));
-			rc = -ENOMEM;
-			break;
-		}
-		file->f_pos++; */
 	case 1:
-		/* if (filldir(direntry, "..", 2, file->f_pos,
-		     file->f_dentry->d_parent->d_inode->i_ino, DT_DIR) < 0) {
-			cERROR(1, ("Filldir for parent dir failed "));
-			rc = -ENOMEM;
-			break;
-		}
-		file->f_pos++; */
 	case 2:
 		/* 1) If search is active, 
 			is in current search buffer? 
@@ -586,14 +541,7 @@
 				rc = 0;
 				break;
 			}
-		} /* else {
-			cifsFile->invalidHandle = TRUE;
-			CIFSFindClose(xid, pTcon, cifsFile->netfid);
-		} 
-		if(cifsFile->search_resume_name) {
-			kfree(cifsFile->search_resume_name);
-			cifsFile->search_resume_name = NULL;
-		} */
+		}
 /* BB account for . and .. in f_pos */
 		/* dump_cifs_file_struct(file, "rdir after default ");*/
 
@@ -618,13 +566,6 @@
 				cERROR(1,("beyond end of smb with num to fill %d i %d",num_to_fill,i)); /* BB removeme BB */
 				break;
 			}
-/*			if((!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) || 
-			   (cifsFile->srch_inf.info_level != something that supports server inodes)) {
-				create dentry
-				create inode
-				fill in inode new_inode (which makes number locally)
-			}
-			also create local inode for per reasons unless new mount parm says otherwise */
 			rc = cifs_filldir2(current_entry, file, 
 					filldir, direntry,tmp_buf);
 			file->f_pos++;
@@ -641,7 +582,6 @@
 	} /* end switch */
 
 rddir2_exit:
-	/* dump_cifs_file_struct(file, "end rdir ");  */
 	FreeXid(xid);
 	return rc;
 }
Index: 2.6/fs/cifs/transport.c
===================================================================
--- 2.6.orig/fs/cifs/transport.c	2005-01-12 23:39:37.356239368 +0200
+++ 2.6/fs/cifs/transport.c	2005-01-12 23:39:40.833710712 +0200
@@ -285,8 +285,6 @@
 	rc = cifs_sign_smb(in_buf, ses, &midQ->sequence_number);
 
 	midQ->midState = MID_REQUEST_SUBMITTED;
-/*	rc = smb_send2(ses->server->ssocket, in_buf, in_buf->smb_buf_length, piovec,
-		      (struct sockaddr *) &(ses->server->addr.sockAddr));*/
 	if(rc < 0) {
 		DeleteMidQEntry(midQ);
 		up(&ses->server->tcpSem);


