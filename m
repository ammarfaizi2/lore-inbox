Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVCYR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVCYR2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCYR1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:27:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:30620 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261703AbVCYRZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:25:06 -0500
Date: Fri, 25 Mar 2005 18:26:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][3/5] cifs: cifsfs.c cleanup - beautify comments
Message-ID: <Pine.LNX.4.62.0503251825420.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beautify comments. Make sure they follow the form established in previous
cleanup patches, and make sure they fit within 80columns.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c.with_patch2	2005-03-25 17:26:42.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-25 17:37:55.000000000 +0100
@@ -110,8 +110,8 @@ static int cifs_read_super(struct super_
 	sb->s_magic = CIFS_MAGIC_NUMBER;
 	sb->s_op = &cifs_super_ops;
 	/* if (cifs_sb->tcon->ses->server->maxBuf > MAX_CIFS_HDR_SIZE + 512)
-	    sb->s_blocksize = cifs_sb->tcon->ses->server->maxBuf -
-			      MAX_CIFS_HDR_SIZE; */
+		sb->s_blocksize = cifs_sb->tcon->ses->server->maxBuf -
+				  MAX_CIFS_HDR_SIZE; */
 #ifdef CONFIG_CIFS_QUOTA
 	sb->s_qcop = &cifs_quotactl_ops;
 #endif
@@ -176,10 +176,13 @@ static int cifs_statfs(struct super_bloc
 
 	buf->f_type = CIFS_MAGIC_NUMBER;
 	/* instead could get the real value via SMB_QUERY_FS_ATTRIBUTE_INFO */
-	buf->f_namelen = PATH_MAX;	/* PATH_MAX may be too long - it would presumably
-					   be length of total path, note that some servers may be
-					   able to support more than this, but best to be safe
-					   since Win2k and others can not handle very long filenames */
+	buf->f_namelen = PATH_MAX;	/* PATH_MAX may be too long - it would
+					   presumably be length of total path,
+					   note that some servers may be able
+					   to support more than this, but best
+					   to be safe since Win2k and others
+					   can not handle very long filenames.
+					   */
 	buf->f_files = 0; /* undefined */
 	buf->f_ffree = 0; /* unlimited */
 
@@ -188,18 +191,18 @@ static int cifs_statfs(struct super_bloc
     if (pTcon->ses->capabilities & CAP_UNIX)
 	    rc = CIFSSMBQFSPosixInfo(xid, pTcon, buf, cifs_sb->local_nls);
 
-    /* Only need to call the old QFSInfo if failed
-    on newer one */
+    /* Only need to call the old QFSInfo if failed on newer one */
     if (rc)
 #endif /* CIFS_EXPERIMENTAL */
 	rc = CIFSSMBQFSInfo(xid, pTcon, buf, cifs_sb->local_nls);
-	/*     
-	   int f_type;
+	/* int f_type;
 	   __fsid_t f_fsid;
-	   int f_namelen;  */
-	/* BB get from info put in tcon struct at mount time with call to QFSAttrInfo */
+	   int f_namelen; */
+	/* BB get from info put in tcon struct at mount time with call to
+	   QFSAttrInfo */
 	FreeXid(xid);
-	return 0; /* always return success? what if volume is no longer available? */
+	return 0; /* always return success?
+		     what if volume is no longer available? */
 }
 
 static int cifs_permission(struct inode *inode, int mask, struct nameidata *nd)
@@ -210,10 +213,10 @@ static int cifs_permission(struct inode 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM) {
 		return 0;
 	} else {
-		/* file mode might have been restricted at mount time
-		on the client (above and beyond ACL on servers) for
-		servers which do not support setting and viewing mode bits,
-		so allowing client to check permissions is useful */
+		/* file mode might have been restricted at mount time on the
+		   client (above and beyond ACL on servers) for servers which
+		   do not support setting and viewing mode bits, so allowing
+		   client to check permissions is useful */
 		return generic_permission(inode, mask, NULL);
 	}
 }
@@ -238,9 +241,8 @@ static struct inode *cifs_alloc_inode(st
 	cifs_inode->cifsAttrs = 0x20; /* default */
 	atomic_set(&cifs_inode->inUse, 0);
 	cifs_inode->time = 0;
-	/* Until the file is open and we have gotten oplock
-	info back from the server, can not assume caching of
-	file data or metadata */
+	/* Until the file is open and we have gotten oplock info back from the
+	   server, can not assume caching of file data or metadata */
 	cifs_inode->clientCanCacheRead = FALSE;
 	cifs_inode->clientCanCacheAll = FALSE;
 	cifs_inode->vfs_inode.i_blksize = CIFS_MAX_MSGSIZE;
@@ -257,8 +259,7 @@ static void cifs_destroy_inode(struct in
 
 /*
  * cifs_show_options() is for displaying mount options in /proc/mounts.
- * Not all settable options are displayed but most of the important
- * ones are.
+ * Not all settable options are displayed but most of the important ones are.
  */
 static int cifs_show_options(struct seq_file *s, struct vfsmount *m)
 {
@@ -396,9 +397,9 @@ struct super_operations cifs_super_ops =
 	.destroy_inode	= cifs_destroy_inode,
 /*	.drop_inode	= generic_delete_inode,
 	.delete_inode	= cifs_delete_inode, */
-/* Do not need the above two functions
-   unless later we add lazy close of inodes or unless the kernel forgets to call
-   us with the same number of releases (closes) as opens */
+/* Do not need the above two functions unless later we add lazy close of
+   inodes or unless the kernel forgets to call us with the same number of
+   releases (closes) as opens */
 	.show_options	= cifs_show_options,
 /*	.umount_begin	= cifs_umount_begin, */ /* consider adding in future */
 	.remount_fs	= cifs_remount,
@@ -455,15 +456,16 @@ static ssize_t cifs_read_wrapper(struct 
 	if (CIFS_I(file->f_dentry->d_inode)->clientCanCacheRead) {
 		return generic_file_read(file, read_data, read_size, poffset);
 	} else {
-		/* BB do we need to lock inode from here until after invalidate? */
-/*		if (file->f_dentry->d_inode->i_mapping) {
+		/* BB do we need to lock inode from here until after
+		   invalidate? */
+		/* if (file->f_dentry->d_inode->i_mapping) {
 			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
 			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
 		} */
-/*		cifs_revalidate(file->f_dentry); */ /* BB fixme */
+		/* cifs_revalidate(file->f_dentry); */ /* BB fixme */
 
-		/* BB we should make timer configurable - perhaps
-		   by simply calling cifs_revalidate here */
+		/* BB we should make timer configurable - perhaps by simply
+		   calling cifs_revalidate here */
 		/* invalidate_remote_inode(file->f_dentry->d_inode); */
 		return generic_file_read(file, read_data, read_size, poffset);
 	}
@@ -483,7 +485,8 @@ static ssize_t cifs_write_wrapper(struct
 
 	cFYI(1, ("In write_wrapper size %zd at %lld", write_size, *poffset));
 
-#ifdef CONFIG_CIFS_EXPERIMENTAL    /* BB fixme - fix user char * to kernel char * mapping here BB */
+#ifdef CONFIG_CIFS_EXPERIMENTAL /* BB fixme - fix user char* to kernel char*
+				   mapping here BB */
 	/* check whether we can cache writes locally */
 	if (file->f_dentry->d_sb) {
 		struct cifs_sb_info *cifs_sb;
@@ -628,9 +631,11 @@ static int cifs_init_request_bufs(void)
 	} else if (CIFSMaxBufSize > 1024 * 127) {
 		CIFSMaxBufSize = 1024 * 127;
 	} else {
-		CIFSMaxBufSize &= 0x1FE00; /* Round size to even 512 byte mult */
+		CIFSMaxBufSize &= 0x1FE00; /* Round to even 512 byte mult */
 	}
-/*	cERROR(1, ("CIFSMaxBufSize %d 0x%x", CIFSMaxBufSize, CIFSMaxBufSize)); */
+	/*
+	cERROR(1, ("CIFSMaxBufSize %d 0x%x", CIFSMaxBufSize, CIFSMaxBufSize));
+	*/
 	cifs_req_cachep = kmem_cache_create("cifs_request",
 					    CIFSMaxBufSize +
 					    MAX_CIFS_HDR_SIZE, 0,
@@ -653,13 +658,13 @@ static int cifs_init_request_bufs(void)
 		return -ENOMEM;
 	}
 	/* 256 (MAX_CIFS_HDR_SIZE bytes is enough for most SMB responses and
-	almost all handle based requests (but not write response, nor is it
-	sufficient for path based requests).  A smaller size would have
-	been more efficient (compacting multiple slab items on one 4k page)
-	for the case in which debug was on, but this larger size allows
-	more SMBs to use small buffer alloc and is still much more
-	efficient to alloc 1 per page off the slab compared to 17K (5page)
-	alloc of large cifs buffers even when page debugging is on */
+	   almost all handle based requests (but not write response, nor is it
+	   sufficient for path based requests).  A smaller size would have
+	   been more efficient (compacting multiple slab items on one 4k page)
+	   for the case in which debug was on, but this larger size allows
+	   more SMBs to use small buffer alloc and is still much more
+	   efficient to alloc 1 per page off the slab compared to 17K (5page)
+	   alloc of large cifs buffers even when page debugging is on */
 	cifs_sm_req_cachep = kmem_cache_create("cifs_small_rq",
 					       MAX_CIFS_HDR_SIZE, 0,
 					       SLAB_HWCACHE_ALIGN, NULL, NULL);
@@ -774,9 +779,9 @@ static int cifs_oplock_thread(void *dumm
 				spin_unlock(&GlobalMid_Lock);
 				DeleteOplockQEntry(oplock_item);
 				/* can not grab inode sem here since it would
-				deadlock when oplock received on delete
-				since vfs_unlink holds the i_sem across
-				the call */
+				   deadlock when oplock received on delete
+				   since vfs_unlink holds the i_sem across the
+				   call */
 				/* down(&inode->i_sem); */
 				if (S_ISREG(inode->i_mode)) {
 					rc = filemap_fdatawrite(inode->i_mapping);
@@ -791,17 +796,18 @@ static int cifs_oplock_thread(void *dumm
 					CIFS_I(inode)->write_behind_rc = rc;
 				cFYI(1, ("Oplock flush inode %p rc %d", inode, rc));
 
-				/* releasing a stale oplock after recent reconnection
-				of smb session using a now incorrect file
-				handle is not a data integrity issue but do
-				not bother sending an oplock release if session
-				to server still is disconnected since oplock
-				already released by the server in that case */
+				/* releasing a stale oplock after recent
+				   reconnection of smb session using a now
+				   incorrect file handle is not a data
+				   integrity issue but do not bother sending an
+				   oplock release if session to server still is
+				   disconnected since oplock already released
+				   by the server in that case */
 				if (pTcon->tidStatus != CifsNeedReconnect) {
 				    rc = CIFSSMBLock(0, pTcon, netfid,
 					    0 /* len */ , 0 /* offset */, 0,
 					    0, LOCKING_ANDX_OPLOCK_RELEASE,
-					    0 /* wait flag */ );
+					    0 /* wait flag */);
 					cFYI(1, ("Oplock release rc = %d ", rc));
 				}
 			} else
@@ -817,7 +823,7 @@ static int __init init_cifs(void)
 #ifdef CONFIG_PROC_FS
 	cifs_proc_init();
 #endif
-	INIT_LIST_HEAD(&GlobalServerList);	/* BB not implemented yet */
+	INIT_LIST_HEAD(&GlobalServerList); /* BB not implemented yet */
 	INIT_LIST_HEAD(&GlobalSMBSessionList);
 	INIT_LIST_HEAD(&GlobalTreeConnectionList);
 	INIT_LIST_HEAD(&GlobalOplock_Q);

