Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVCYR0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVCYR0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVCYR0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:26:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:15516 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261699AbVCYRXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:23:43 -0500
Date: Fri, 25 Mar 2005 18:25:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2/5] cifs: cifsfs.c cleanup - whitespace changes part2,
 spacing, excessive blank lines, trailing whitespace etc.
Message-ID: <Pine.LNX.4.62.0503251823530.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up spacing after if(), for(), while(), spaces between
function parameters, trailing whitespace on lines, excessive use of blank
lines and the like. It also deals with a few of the long lines >80col.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c.with_patch1	2005-03-25 17:01:31.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-25 17:13:37.000000000 +0100
@@ -40,7 +40,7 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 #include <linux/mm.h>
-#define CIFS_MAGIC_NUMBER 0xFF534D42	/* the first four bytes of SMB PDUs */
+#define CIFS_MAGIC_NUMBER 0xFF534D42 /* the first four bytes of SMB PDUs */
 
 #ifdef CONFIG_CIFS_QUOTA
 static struct quotactl_ops cifs_quotactl_ops;
@@ -57,20 +57,24 @@ unsigned int multiuser_mount = 0;
 unsigned int extended_security = 0;
 unsigned int ntlmv2_support = 0;
 unsigned int sign_CIFS_PDUs = 1;
-extern struct task_struct * oplockThread; /* remove sparse warning */
-struct task_struct * oplockThread = NULL;
+extern struct task_struct *oplockThread; /* remove sparse warning */
+struct task_struct *oplockThread = NULL;
 unsigned int CIFSMaxBufSize = CIFS_MAX_MSGSIZE;
 module_param(CIFSMaxBufSize, int, 0);
-MODULE_PARM_DESC(CIFSMaxBufSize,"Network buffer size (not including header). Default: 16384 Range: 8192 to 130048");
+MODULE_PARM_DESC(CIFSMaxBufSize, "Network buffer size (not including header). "
+		 "Default: 16384 Range: 8192 to 130048");
 unsigned int cifs_min_rcv = CIFS_MIN_RCV_POOL;
 module_param(cifs_min_rcv, int, 0);
-MODULE_PARM_DESC(cifs_min_rcv,"Network buffers in pool. Default: 4 Range: 1 to 64");
+MODULE_PARM_DESC(cifs_min_rcv, "Network buffers in pool. "
+		 "Default: 4 Range: 1 to 64");
 unsigned int cifs_min_small = 30;
 module_param(cifs_min_small, int, 0);
-MODULE_PARM_DESC(cifs_min_small,"Small network buffers in pool. Default: 30 Range: 2 to 256");
+MODULE_PARM_DESC(cifs_min_small, "Small network buffers in pool. "
+		 "Default: 30 Range: 2 to 256");
 unsigned int cifs_max_pending = CIFS_MAX_REQ;
 module_param(cifs_max_pending, int, 0);
-MODULE_PARM_DESC(cifs_max_pending,"Simultaneous requests to server. Default: 50 Range: 2 to 256");
+MODULE_PARM_DESC(cifs_max_pending, "Simultaneous requests to server. "
+		 "Default: 50 Range: 2 to 256");
 
 static DECLARE_COMPLETION(cifs_oplock_exited);
 
@@ -88,57 +92,52 @@ static int cifs_read_super(struct super_
 	int rc = 0;
 
 	sb->s_flags |= MS_NODIRATIME; /* and probably even noatime */
-	sb->s_fs_info = kmalloc(sizeof(struct cifs_sb_info),GFP_KERNEL);
+	sb->s_fs_info = kmalloc(sizeof(struct cifs_sb_info), GFP_KERNEL);
 	cifs_sb = CIFS_SB(sb);
-	if(cifs_sb == NULL)
+	if (cifs_sb == NULL)
 		return -ENOMEM;
 	else
 		memset(cifs_sb,0,sizeof(struct cifs_sb_info));
-	
 
 	rc = cifs_mount(sb, cifs_sb, data, devname);
-
 	if (rc) {
 		if (!silent)
-			cERROR(1,
-			       ("cifs_mount failed w/return code = %d", rc));
+			cERROR(1, ("cifs_mount failed w/return code = %d",
+				   rc));
 		goto out_mount_failed;
 	}
 
 	sb->s_magic = CIFS_MAGIC_NUMBER;
 	sb->s_op = &cifs_super_ops;
-/*	if(cifs_sb->tcon->ses->server->maxBuf > MAX_CIFS_HDR_SIZE + 512)
-	    sb->s_blocksize = cifs_sb->tcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE; */
+	/* if (cifs_sb->tcon->ses->server->maxBuf > MAX_CIFS_HDR_SIZE + 512)
+	    sb->s_blocksize = cifs_sb->tcon->ses->server->maxBuf -
+			      MAX_CIFS_HDR_SIZE; */
 #ifdef CONFIG_CIFS_QUOTA
 	sb->s_qcop = &cifs_quotactl_ops;
 #endif
 	sb->s_blocksize = CIFS_MAX_MSGSIZE;
-	sb->s_blocksize_bits = 14;	/* default 2**14 = CIFS_MAX_MSGSIZE */
+	sb->s_blocksize_bits = 14; /* default 2**14 = CIFS_MAX_MSGSIZE */
 	inode = iget(sb, ROOT_I);
-
 	if (!inode) {
 		rc = -ENOMEM;
 		goto out_no_root;
 	}
 
 	sb->s_root = d_alloc_root(inode);
-
 	if (!sb->s_root) {
 		rc = -ENOMEM;
 		goto out_no_root;
 	}
-
 	return 0;
 
 out_no_root:
 	cERROR(1, ("cifs_read_super: get root inode failed"));
 	if (inode)
 		iput(inode);
-
 out_mount_failed:
-	if(cifs_sb) {
-		if(cifs_sb->local_nls)
-			unload_nls(cifs_sb->local_nls);	
+	if (cifs_sb) {
+		if (cifs_sb->local_nls)
+			unload_nls(cifs_sb->local_nls);
 		kfree(cifs_sb);
 	}
 	return rc;
@@ -151,11 +150,11 @@ static void cifs_put_super(struct super_
 
 	cFYI(1, ("In cifs_put_super"));
 	cifs_sb = CIFS_SB(sb);
-	if(cifs_sb == NULL) {
-		cFYI(1,("Empty cifs superblock info passed to unmount"));
+	if (cifs_sb == NULL) {
+		cFYI(1, ("Empty cifs superblock info passed to unmount"));
 		return;
 	}
-	rc = cifs_umount(sb, cifs_sb); 
+	rc = cifs_umount(sb, cifs_sb);
 	if (rc) {
 		cERROR(1, ("cifs_umount failed with return code %d", rc));
 	}
@@ -176,14 +175,13 @@ static int cifs_statfs(struct super_bloc
 	pTcon = cifs_sb->tcon;
 
 	buf->f_type = CIFS_MAGIC_NUMBER;
-
 	/* instead could get the real value via SMB_QUERY_FS_ATTRIBUTE_INFO */
 	buf->f_namelen = PATH_MAX;	/* PATH_MAX may be too long - it would presumably
-					   be length of total path, note that some servers may be 
+					   be length of total path, note that some servers may be
 					   able to support more than this, but best to be safe
 					   since Win2k and others can not handle very long filenames */
-	buf->f_files = 0;	/* undefined */
-	buf->f_ffree = 0;	/* unlimited */
+	buf->f_files = 0; /* undefined */
+	buf->f_ffree = 0; /* unlimited */
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL
 /* BB we could add a second check for a QFS Unix capability bit */
@@ -192,17 +190,16 @@ static int cifs_statfs(struct super_bloc
 
     /* Only need to call the old QFSInfo if failed
     on newer one */
-    if(rc)
+    if (rc)
 #endif /* CIFS_EXPERIMENTAL */
 	rc = CIFSSMBQFSInfo(xid, pTcon, buf, cifs_sb->local_nls);
-
 	/*     
 	   int f_type;
 	   __fsid_t f_fsid;
 	   int f_namelen;  */
 	/* BB get from info put in tcon struct at mount time with call to QFSAttrInfo */
 	FreeXid(xid);
-	return 0;		/* always return success? what if volume is no longer available? */
+	return 0; /* always return success? what if volume is no longer available? */
 }
 
 static int cifs_permission(struct inode *inode, int mask, struct nameidata *nd)
@@ -210,14 +207,15 @@ static int cifs_permission(struct inode 
 	struct cifs_sb_info *cifs_sb;
 
 	cifs_sb = CIFS_SB(inode->i_sb);
-
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM) {
 		return 0;
-	} else /* file mode might have been restricted at mount time 
-		on the client (above and beyond ACL on servers) for  
+	} else {
+		/* file mode might have been restricted at mount time
+		on the client (above and beyond ACL on servers) for
 		servers which do not support setting and viewing mode bits,
-		so allowing client to check permissions is useful */ 
+		so allowing client to check permissions is useful */
 		return generic_permission(inode, mask, NULL);
+	}
 }
 
 static kmem_cache_t *cifs_inode_cachep;
@@ -233,11 +231,11 @@ static struct inode *cifs_alloc_inode(st
 {
 	struct cifsInodeInfo *cifs_inode;
 	cifs_inode =
-	    (struct cifsInodeInfo *) kmem_cache_alloc(cifs_inode_cachep,
-						      SLAB_KERNEL);
+	    (struct cifsInodeInfo *)kmem_cache_alloc(cifs_inode_cachep,
+						     SLAB_KERNEL);
 	if (!cifs_inode)
 		return NULL;
-	cifs_inode->cifsAttrs = 0x20;	/* default */
+	cifs_inode->cifsAttrs = 0x20; /* default */
 	atomic_set(&cifs_inode->inUse, 0);
 	cifs_inode->time = 0;
 	/* Until the file is open and we have gotten oplock
@@ -246,7 +244,7 @@ static struct inode *cifs_alloc_inode(st
 	cifs_inode->clientCanCacheRead = FALSE;
 	cifs_inode->clientCanCacheAll = FALSE;
 	cifs_inode->vfs_inode.i_blksize = CIFS_MAX_MSGSIZE;
-	cifs_inode->vfs_inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
+	cifs_inode->vfs_inode.i_blkbits = 14; /* 2**14 = CIFS_MAX_MSGSIZE */
 
 	INIT_LIST_HEAD(&cifs_inode->openFileList);
 	return &cifs_inode->vfs_inode;
@@ -267,7 +265,6 @@ static int cifs_show_options(struct seq_
 	struct cifs_sb_info *cifs_sb;
 
 	cifs_sb = CIFS_SB(m->mnt_sb);
-
 	if (cifs_sb) {
 		if (cifs_sb->tcon) {
 			seq_printf(s, ",unc=%s", cifs_sb->tcon->treeName);
@@ -275,13 +272,13 @@ static int cifs_show_options(struct seq_
 				if (cifs_sb->tcon->ses->userName)
 					seq_printf(s, ",username=%s",
 					   cifs_sb->tcon->ses->userName);
-				if(cifs_sb->tcon->ses->domainName)
+				if (cifs_sb->tcon->ses->domainName)
 					seq_printf(s, ",domain=%s",
 					   cifs_sb->tcon->ses->domainName);
 			}
 		}
-		seq_printf(s, ",rsize=%d",cifs_sb->rsize);
-		seq_printf(s, ",wsize=%d",cifs_sb->wsize);
+		seq_printf(s, ",rsize=%d", cifs_sb->rsize);
+		seq_printf(s, ",wsize=%d", cifs_sb->wsize);
 	}
 	return 0;
 }
@@ -295,18 +292,16 @@ int cifs_xquota_set(struct super_block *
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsTconInfo *pTcon;
 	
-	if(cifs_sb)
+	if (cifs_sb)
 		pTcon = cifs_sb->tcon;
 	else
 		return -EIO;
 
-
 	xid = GetXid();
-	if(pTcon) {
-		cFYI(1,("set type: 0x%x id: %d",quota_type,qid));		
-	} else {
+	if (pTcon)
+		cFYI(1, ("set type: 0x%x id: %d", quota_type, qid));
+	else
 		return -EIO;
-	}
 
 	FreeXid(xid);
 	return rc;
@@ -320,17 +315,16 @@ int cifs_xquota_get(struct super_block *
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsTconInfo *pTcon;
 
-	if(cifs_sb)
+	if (cifs_sb)
 		pTcon = cifs_sb->tcon;
 	else
 		return -EIO;
 
 	xid = GetXid();
-	if(pTcon) {
-                cFYI(1,("set type: 0x%x id: %d",quota_type,qid));
-	} else {
+	if (pTcon)
+                cFYI(1, ("set type: 0x%x id: %d", quota_type, qid));
+	else
 		rc = -EIO;
-	}
 
 	FreeXid(xid);
 	return rc;
@@ -338,22 +332,21 @@ int cifs_xquota_get(struct super_block *
 
 int cifs_xstate_set(struct super_block *sb, unsigned int flags, int operation)
 {
-	int xid; 
+	int xid;
 	int rc = 0;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsTconInfo *pTcon;
 
-	if(cifs_sb)
+	if (cifs_sb)
 		pTcon = cifs_sb->tcon;
 	else
 		return -EIO;
 
 	xid = GetXid();
-	if(pTcon) {
-                cFYI(1,("flags: 0x%x operation: 0x%x",flags,operation));
-	} else {
+	if (pTcon)
+                cFYI(1, ("flags: 0x%x operation: 0x%x", flags, operation));
+	else
 		rc = -EIO;
-	}
 
 	FreeXid(xid);
 	return rc;
@@ -366,17 +359,16 @@ int cifs_xstate_get(struct super_block *
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsTconInfo *pTcon;
 
-	if(cifs_sb) {
+	if (cifs_sb)
 		pTcon = cifs_sb->tcon;
-	} else {
+	else
 		return -EIO;
-	}
+
 	xid = GetXid();
-	if(pTcon) {
-		cFYI(1,("pqstats %p",qstats));		
-	} else {
+	if (pTcon)
+		cFYI(1, ("pqstats %p", qstats));
+	else
 		rc = -EIO;
-	}
 
 	FreeXid(xid);
 	return rc;
@@ -397,18 +389,19 @@ static int cifs_remount(struct super_blo
 }
 
 struct super_operations cifs_super_ops = {
-	.read_inode = cifs_read_inode,
-	.put_super = cifs_put_super,
-	.statfs = cifs_statfs,
-	.alloc_inode = cifs_alloc_inode,
-	.destroy_inode = cifs_destroy_inode,
-/*	.drop_inode	    = generic_delete_inode, 
-	.delete_inode	= cifs_delete_inode,  *//* Do not need the above two functions     
+	.read_inode	= cifs_read_inode,
+	.put_super	= cifs_put_super,
+	.statfs		= cifs_statfs,
+	.alloc_inode	= cifs_alloc_inode,
+	.destroy_inode	= cifs_destroy_inode,
+/*	.drop_inode	= generic_delete_inode,
+	.delete_inode	= cifs_delete_inode, */
+/* Do not need the above two functions
    unless later we add lazy close of inodes or unless the kernel forgets to call
    us with the same number of releases (closes) as opens */
-	.show_options = cifs_show_options,
-/*    .umount_begin   = cifs_umount_begin, *//* consider adding in the future */
-	.remount_fs = cifs_remount,
+	.show_options	= cifs_show_options,
+/*	.umount_begin	= cifs_umount_begin, */ /* consider adding in future */
+	.remount_fs	= cifs_remount,
 };
 
 static struct super_block *cifs_get_sb(struct file_system_type *fs_type,
@@ -437,75 +430,75 @@ static struct super_block *cifs_get_sb(s
 static ssize_t cifs_read_wrapper(struct file *file, char __user *read_data,
 	size_t read_size, loff_t *poffset)
 {
-	if(file == NULL)
+	if (file == NULL)
 		return -EIO;
-	else if(file->f_dentry == NULL)
+	else if (file->f_dentry == NULL)
 		return -EIO;
-	else if(file->f_dentry->d_inode == NULL)
+	else if (file->f_dentry->d_inode == NULL)
 		return -EIO;
 
-	cFYI(1,("In read_wrapper size %zd at %lld",read_size,*poffset));
+	cFYI(1, ("In read_wrapper size %zd at %lld", read_size, *poffset));
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL
 	/* check whether we can cache writes locally */
-	if(file->f_dentry->d_sb) {
+	if (file->f_dentry->d_sb) {
 		struct cifs_sb_info *cifs_sb;
 		cifs_sb = CIFS_SB(file->f_dentry->d_sb);
-		if(cifs_sb != NULL) {
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
+		if (cifs_sb != NULL) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
 				return cifs_user_read(file,read_data,
-							read_size,poffset);
+						      read_size, poffset);
 		}
 	}
 #endif /* CIFS_EXPERIMENTAL */
 
-	if(CIFS_I(file->f_dentry->d_inode)->clientCanCacheRead) {
-		return generic_file_read(file,read_data,read_size,poffset);
+	if (CIFS_I(file->f_dentry->d_inode)->clientCanCacheRead) {
+		return generic_file_read(file, read_data, read_size, poffset);
 	} else {
 		/* BB do we need to lock inode from here until after invalidate? */
-/*		if(file->f_dentry->d_inode->i_mapping) {
+/*		if (file->f_dentry->d_inode->i_mapping) {
 			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
 			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
-		}*/
-/*		cifs_revalidate(file->f_dentry);*/ /* BB fixme */
+		} */
+/*		cifs_revalidate(file->f_dentry); */ /* BB fixme */
 
-		/* BB we should make timer configurable - perhaps 
+		/* BB we should make timer configurable - perhaps
 		   by simply calling cifs_revalidate here */
-		/* invalidate_remote_inode(file->f_dentry->d_inode);*/
-		return generic_file_read(file,read_data,read_size,poffset);
+		/* invalidate_remote_inode(file->f_dentry->d_inode); */
+		return generic_file_read(file, read_data, read_size, poffset);
 	}
 }
 
 static ssize_t cifs_write_wrapper(struct file *file,
-	const char __user *write_data, size_t write_size, loff_t *poffset) 
+	const char __user *write_data, size_t write_size, loff_t *poffset)
 {
 	ssize_t written;
 
-	if(file == NULL)
+	if (file == NULL)
 		return -EIO;
-	else if(file->f_dentry == NULL)
+	else if (file->f_dentry == NULL)
 		return -EIO;
-	else if(file->f_dentry->d_inode == NULL)
+	else if (file->f_dentry->d_inode == NULL)
 		return -EIO;
 
-	cFYI(1,("In write_wrapper size %zd at %lld",write_size,*poffset));
+	cFYI(1, ("In write_wrapper size %zd at %lld", write_size, *poffset));
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL    /* BB fixme - fix user char * to kernel char * mapping here BB */
 	/* check whether we can cache writes locally */
-	if(file->f_dentry->d_sb) {
+	if (file->f_dentry->d_sb) {
 		struct cifs_sb_info *cifs_sb;
 		cifs_sb = CIFS_SB(file->f_dentry->d_sb);
-		if(cifs_sb != NULL) {
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
-				return cifs_user_write(file,write_data,
-							write_size,poffset);
+		if (cifs_sb != NULL) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
+				return cifs_user_write(file, write_data,
+						       write_size, poffset);
 			}
 		}
 	}
 #endif /* CIFS_EXPERIMENTAL */
-	written = generic_file_write(file,write_data,write_size,poffset);
-	if(!CIFS_I(file->f_dentry->d_inode)->clientCanCacheAll)  {
-		if(file->f_dentry->d_inode->i_mapping) {
+	written = generic_file_write(file, write_data, write_size, poffset);
+	if (!CIFS_I(file->f_dentry->d_inode)->clientCanCacheAll)  {
+		if (file->f_dentry->d_inode->i_mapping) {
 			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
 		}
 	}
@@ -513,93 +506,93 @@ static ssize_t cifs_write_wrapper(struct
 }
 
 static struct file_system_type cifs_fs_type = {
-	.owner = THIS_MODULE,
-	.name = "cifs",
-	.get_sb = cifs_get_sb,
-	.kill_sb = kill_anon_super,
-	/*  .fs_flags */
+	.owner		= THIS_MODULE,
+	.name		= "cifs",
+	.get_sb		= cifs_get_sb,
+	.kill_sb	= kill_anon_super,
+/*	.fs_flags	= */
 };
 
 struct inode_operations cifs_dir_inode_ops = {
-	.create = cifs_create,
-	.lookup = cifs_lookup,
-	.getattr = cifs_getattr,
-	.unlink = cifs_unlink,
-	.link = cifs_hardlink,
-	.mkdir = cifs_mkdir,
-	.rmdir = cifs_rmdir,
-	.rename = cifs_rename,
-	.permission = cifs_permission,
-/*	revalidate:cifs_revalidate,   */
-	.setattr = cifs_setattr,
-	.symlink = cifs_symlink,
-	.mknod   = cifs_mknod,
+	.create		= cifs_create,
+	.lookup		= cifs_lookup,
+	.getattr	= cifs_getattr,
+	.unlink		= cifs_unlink,
+	.link		= cifs_hardlink,
+	.mkdir		= cifs_mkdir,
+	.rmdir		= cifs_rmdir,
+	.rename		= cifs_rename,
+	.permission	= cifs_permission,
+/*	revalidate:cifs_revalidate, */
+	.setattr	= cifs_setattr,
+	.symlink	= cifs_symlink,
+	.mknod		= cifs_mknod,
 #ifdef CONFIG_CIFS_XATTR
-	.setxattr = cifs_setxattr,
-	.getxattr = cifs_getxattr,
-	.listxattr = cifs_listxattr,
-	.removexattr = cifs_removexattr,
+	.setxattr	= cifs_setxattr,
+	.getxattr	= cifs_getxattr,
+	.listxattr	= cifs_listxattr,
+	.removexattr	= cifs_removexattr,
 #endif
 };
 
 struct inode_operations cifs_file_inode_ops = {
 /*	revalidate:cifs_revalidate, */
-	.setattr = cifs_setattr,
-	.getattr = cifs_getattr, /* do we need this anymore? */
-	.rename = cifs_rename,
-	.permission = cifs_permission,
+	.setattr	= cifs_setattr,
+	.getattr	= cifs_getattr, /* do we need this anymore? */
+	.rename		= cifs_rename,
+	.permission	= cifs_permission,
 #ifdef CONFIG_CIFS_XATTR
-	.setxattr = cifs_setxattr,
-	.getxattr = cifs_getxattr,
-	.listxattr = cifs_listxattr,
-	.removexattr = cifs_removexattr,
-#endif 
+	.setxattr	= cifs_setxattr,
+	.getxattr	= cifs_getxattr,
+	.listxattr	= cifs_listxattr,
+	.removexattr	= cifs_removexattr,
+#endif
 };
 
 struct inode_operations cifs_symlink_inode_ops = {
-	.readlink = generic_readlink, 
-	.follow_link = cifs_follow_link,
-	.put_link = cifs_put_link,
-	.permission = cifs_permission,
+	.readlink	= generic_readlink, 
+	.follow_link	= cifs_follow_link,
+	.put_link	= cifs_put_link,
+	.permission	= cifs_permission,
 	/* BB add the following two eventually */
 	/* revalidate: cifs_revalidate,
-	   setattr:    cifs_notify_change, *//* BB do we need notify change */
+	   setattr:    cifs_notify_change, */ /* BB do we need notify change */
 #ifdef CONFIG_CIFS_XATTR
-	.setxattr = cifs_setxattr,
-	.getxattr = cifs_getxattr,
-	.listxattr = cifs_listxattr,
-	.removexattr = cifs_removexattr,
-#endif 
+	.setxattr	= cifs_setxattr,
+	.getxattr	= cifs_getxattr,
+	.listxattr	= cifs_listxattr,
+	.removexattr	= cifs_removexattr,
+#endif
 };
 
 struct file_operations cifs_file_ops = {
-	.read = cifs_read_wrapper,
-	.write = cifs_write_wrapper, 
-	.open = cifs_open,
-	.release = cifs_close,
-	.lock = cifs_lock,
-	.fsync = cifs_fsync,
-	.flush = cifs_flush,
-	.mmap  = cifs_file_mmap,
-	.sendfile = generic_file_sendfile,
+	.read		= cifs_read_wrapper,
+	.write		= cifs_write_wrapper,
+	.open		= cifs_open,
+	.release	= cifs_close,
+	.lock		= cifs_lock,
+	.fsync		= cifs_fsync,
+	.flush		= cifs_flush,
+	.mmap		= cifs_file_mmap,
+	.sendfile	= generic_file_sendfile,
 #ifdef CONFIG_CIFS_EXPERIMENTAL
-	.dir_notify = cifs_dir_notify,
+	.dir_notify	= cifs_dir_notify,
 #endif /* CONFIG_CIFS_EXPERIMENTAL */
 };
 
 struct file_operations cifs_dir_ops = {
-	.readdir = cifs_readdir,
-	.release = cifs_closedir,
-	.read    = generic_read_dir,
+	.readdir	= cifs_readdir,
+	.release	= cifs_closedir,
+	.read		= generic_read_dir,
 #ifdef CONFIG_CIFS_EXPERIMENTAL
-	.dir_notify = cifs_dir_notify,
+	.dir_notify	= cifs_dir_notify,
 #endif /* CONFIG_CIFS_EXPERIMENTAL */
 };
 
 static void cifs_init_once(void *inode, kmem_cache_t *cachep,
 	unsigned long flags)
 {
-	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *) inode;
+	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *)inode;
 
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
@@ -628,16 +621,16 @@ static void cifs_destroy_inodecache(void
 
 static int cifs_init_request_bufs(void)
 {
-	if(CIFSMaxBufSize < 8192) {
+	if (CIFSMaxBufSize < 8192) {
 	/* Buffer size can not be smaller than 2 * PATH_MAX since maximum
 	Unicode path name has to fit in any SMB/CIFS path based frames */
 		CIFSMaxBufSize = 8192;
-	} else if (CIFSMaxBufSize > 1024*127) {
+	} else if (CIFSMaxBufSize > 1024 * 127) {
 		CIFSMaxBufSize = 1024 * 127;
 	} else {
-		CIFSMaxBufSize &= 0x1FE00; /* Round size to even 512 byte mult*/
+		CIFSMaxBufSize &= 0x1FE00; /* Round size to even 512 byte mult */
 	}
-/*	cERROR(1,("CIFSMaxBufSize %d 0x%x",CIFSMaxBufSize,CIFSMaxBufSize)); */
+/*	cERROR(1, ("CIFSMaxBufSize %d 0x%x", CIFSMaxBufSize, CIFSMaxBufSize)); */
 	cifs_req_cachep = kmem_cache_create("cifs_request",
 					    CIFSMaxBufSize +
 					    MAX_CIFS_HDR_SIZE, 0,
@@ -645,51 +638,49 @@ static int cifs_init_request_bufs(void)
 	if (cifs_req_cachep == NULL)
 		return -ENOMEM;
 
-	if(cifs_min_rcv < 1)
+	if (cifs_min_rcv < 1)
 		cifs_min_rcv = 1;
 	else if (cifs_min_rcv > 64) {
 		cifs_min_rcv = 64;
-		cERROR(1,("cifs_min_rcv set to maximum (64)"));
+		cERROR(1, ("cifs_min_rcv set to maximum (64)"));
 	}
 
-	cifs_req_poolp = mempool_create(cifs_min_rcv,
-					mempool_alloc_slab,
-					mempool_free_slab,
-					cifs_req_cachep);
+	cifs_req_poolp = mempool_create(cifs_min_rcv, mempool_alloc_slab,
+					mempool_free_slab, cifs_req_cachep);
 
-	if(cifs_req_poolp == NULL) {
+	if (cifs_req_poolp == NULL) {
 		kmem_cache_destroy(cifs_req_cachep);
 		return -ENOMEM;
 	}
 	/* 256 (MAX_CIFS_HDR_SIZE bytes is enough for most SMB responses and
 	almost all handle based requests (but not write response, nor is it
 	sufficient for path based requests).  A smaller size would have
-	been more efficient (compacting multiple slab items on one 4k page) 
+	been more efficient (compacting multiple slab items on one 4k page)
 	for the case in which debug was on, but this larger size allows
 	more SMBs to use small buffer alloc and is still much more
-	efficient to alloc 1 per page off the slab compared to 17K (5page) 
+	efficient to alloc 1 per page off the slab compared to 17K (5page)
 	alloc of large cifs buffers even when page debugging is on */
 	cifs_sm_req_cachep = kmem_cache_create("cifs_small_rq",
-			MAX_CIFS_HDR_SIZE, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+					       MAX_CIFS_HDR_SIZE, 0,
+					       SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (cifs_sm_req_cachep == NULL) {
 		mempool_destroy(cifs_req_poolp);
 		kmem_cache_destroy(cifs_req_cachep);
-		return -ENOMEM;              
+		return -ENOMEM;
 	}
 
-	if(cifs_min_small < 2)
+	if (cifs_min_small < 2)
 		cifs_min_small = 2;
 	else if (cifs_min_small > 256) {
 		cifs_min_small = 256;
-		cFYI(1,("cifs_min_small set to maximum (256)"));
+		cFYI(1, ("cifs_min_small set to maximum (256)"));
 	}
 
-	cifs_sm_req_poolp = mempool_create(cifs_min_small,
-				mempool_alloc_slab,
-				mempool_free_slab,
-				cifs_sm_req_cachep);
+	cifs_sm_req_poolp = mempool_create(cifs_min_small, mempool_alloc_slab,
+					   mempool_free_slab,
+					   cifs_sm_req_cachep);
 
-	if(cifs_sm_req_poolp == NULL) {
+	if (cifs_sm_req_poolp == NULL) {
 		mempool_destroy(cifs_req_poolp);
 		kmem_cache_destroy(cifs_req_cachep);
 		kmem_cache_destroy(cifs_sm_req_cachep);
@@ -703,34 +694,34 @@ static void cifs_destroy_request_bufs(vo
 {
 	mempool_destroy(cifs_req_poolp);
 	if (kmem_cache_destroy(cifs_req_cachep))
-		printk(KERN_WARNING
-		       "cifs_destroy_request_cache: error not all structures were freed\n");
+		printk(KERN_WARNING "cifs_destroy_request_cache: "
+		       "error not all structures were freed\n");
 	mempool_destroy(cifs_sm_req_poolp);
 	if (kmem_cache_destroy(cifs_sm_req_cachep))
-		printk(KERN_WARNING
-		      "cifs_destroy_request_cache: cifs_small_rq free error\n");
+		printk(KERN_WARNING "cifs_destroy_request_cache: "
+		       "cifs_small_rq free error\n");
 }
 
 static int cifs_init_mids(void)
 {
 	cifs_mid_cachep = kmem_cache_create("cifs_mpx_ids",
-				sizeof (struct mid_q_entry), 0,
-				SLAB_HWCACHE_ALIGN, NULL, NULL);
+					    sizeof (struct mid_q_entry), 0,
+					    SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (cifs_mid_cachep == NULL)
 		return -ENOMEM;
 
-	cifs_mid_poolp = mempool_create(3 /* a reasonable min simultan opers */,
-					mempool_alloc_slab,
-					mempool_free_slab,
+	cifs_mid_poolp = mempool_create(3 /* reasonable min simultan opers */,
+					mempool_alloc_slab, mempool_free_slab,
 					cifs_mid_cachep);
-	if(cifs_mid_poolp == NULL) {
+	if (cifs_mid_poolp == NULL) {
 		kmem_cache_destroy(cifs_mid_cachep);
 		return -ENOMEM;
 	}
 
 	cifs_oplock_cachep = kmem_cache_create("cifs_oplock_structs",
-				sizeof (struct oplock_q_entry), 0,
-				SLAB_HWCACHE_ALIGN, NULL, NULL);
+					       sizeof (struct oplock_q_entry),
+					       0, SLAB_HWCACHE_ALIGN, NULL,
+					       NULL);
 	if (cifs_oplock_cachep == NULL) {
 		kmem_cache_destroy(cifs_mid_cachep);
 		mempool_destroy(cifs_mid_poolp);
@@ -744,20 +735,20 @@ static void cifs_destroy_mids(void)
 {
 	mempool_destroy(cifs_mid_poolp);
 	if (kmem_cache_destroy(cifs_mid_cachep))
-		printk(KERN_WARNING
-		       "cifs_destroy_mids: error not all structures were freed\n");
+		printk(KERN_WARNING "cifs_destroy_mids: "
+		       "error not all structures were freed\n");
 
 	if (kmem_cache_destroy(cifs_oplock_cachep))
-		printk(KERN_WARNING
-		       "error not all oplock structures were freed\n");
+		printk(KERN_WARNING "error not all oplock structures were "
+		       "freed\n");
 }
 
 static int cifs_oplock_thread(void *dummyarg)
 {
-	struct oplock_q_entry * oplock_item;
+	struct oplock_q_entry *oplock_item;
 	struct cifsTconInfo *pTcon;
-	struct inode * inode;
-	__u16  netfid;
+	struct inode *inode;
+	__u16 netfid;
 	int rc;
 
 	daemonize("cifsoplockd");
@@ -766,58 +757,57 @@ static int cifs_oplock_thread(void *dumm
 	oplockThread = current;
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		
-		schedule_timeout(1*HZ);  
+		schedule_timeout(1 * HZ);
 		spin_lock(&GlobalMid_Lock);
-		if(list_empty(&GlobalOplock_Q)) {
+		if (list_empty(&GlobalOplock_Q)) {
 			spin_unlock(&GlobalMid_Lock);
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(39*HZ);
+			schedule_timeout(39 * HZ);
 		} else {
-			oplock_item = list_entry(GlobalOplock_Q.next, 
-				struct oplock_q_entry, qhead);
-			if(oplock_item) {
-				cFYI(1,("found oplock item to write out")); 
+			oplock_item = list_entry(GlobalOplock_Q.next,
+						 struct oplock_q_entry, qhead);
+			if (oplock_item) {
+				cFYI(1, ("found oplock item to write out"));
 				pTcon = oplock_item->tcon;
 				inode = oplock_item->pinode;
 				netfid = oplock_item->netfid;
 				spin_unlock(&GlobalMid_Lock);
 				DeleteOplockQEntry(oplock_item);
 				/* can not grab inode sem here since it would
-				deadlock when oplock received on delete 
+				deadlock when oplock received on delete
 				since vfs_unlink holds the i_sem across
 				the call */
-				/* down(&inode->i_sem);*/
+				/* down(&inode->i_sem); */
 				if (S_ISREG(inode->i_mode)) {
 					rc = filemap_fdatawrite(inode->i_mapping);
-					if(CIFS_I(inode)->clientCanCacheRead == 0) {
+					if (CIFS_I(inode)->clientCanCacheRead == 0) {
 						filemap_fdatawait(inode->i_mapping);
 						invalidate_remote_inode(inode);
 					}
 				} else
 					rc = 0;
-				/* up(&inode->i_sem);*/
+				/* up(&inode->i_sem); */
 				if (rc)
 					CIFS_I(inode)->write_behind_rc = rc;
-				cFYI(1,("Oplock flush inode %p rc %d",inode,rc));
+				cFYI(1, ("Oplock flush inode %p rc %d", inode, rc));
 
-				/* releasing a stale oplock after recent reconnection 
-				of smb session using a now incorrect file 
-				handle is not a data integrity issue but do  
-				not bother sending an oplock release if session 
-				to server still is disconnected since oplock 
+				/* releasing a stale oplock after recent reconnection
+				of smb session using a now incorrect file
+				handle is not a data integrity issue but do
+				not bother sending an oplock release if session
+				to server still is disconnected since oplock
 				already released by the server in that case */
-				if(pTcon->tidStatus != CifsNeedReconnect) {
+				if (pTcon->tidStatus != CifsNeedReconnect) {
 				    rc = CIFSSMBLock(0, pTcon, netfid,
-					    0 /* len */ , 0 /* offset */, 0, 
+					    0 /* len */ , 0 /* offset */, 0,
 					    0, LOCKING_ANDX_OPLOCK_RELEASE,
-					    0 /* wait flag */);
-					cFYI(1,("Oplock release rc = %d ",rc));
+					    0 /* wait flag */ );
+					cFYI(1, ("Oplock release rc = %d ", rc));
 				}
 			} else
 				spin_unlock(&GlobalMid_Lock);
 		}
-	} while(!signal_pending(current));
+	} while (!signal_pending(current));
 	complete_and_exit (&cifs_oplock_exited, 0);
 }
 
@@ -836,7 +826,7 @@ static int __init init_cifs(void)
  */
 	atomic_set(&sesInfoAllocCount, 0);
 	atomic_set(&tconInfoAllocCount, 0);
-	atomic_set(&tcpSesAllocCount,0);
+	atomic_set(&tcpSesAllocCount, 0);
 	atomic_set(&tcpSesReconnectCount, 0);
 	atomic_set(&tconInfoReconnectCount, 0);
 
@@ -848,12 +838,12 @@ static int __init init_cifs(void)
 	rwlock_init(&GlobalSMBSeslock);
 	spin_lock_init(&GlobalMid_Lock);
 
-	if(cifs_max_pending < 2) {
+	if (cifs_max_pending < 2) {
 		cifs_max_pending = 2;
-		cFYI(1,("cifs_max_pending set to min of 2"));
-	} else if(cifs_max_pending > 256) {
+		cFYI(1, ("cifs_max_pending set to min of 2"));
+	} else if (cifs_max_pending > 256) {
 		cifs_max_pending = 256;
-		cFYI(1,("cifs_max_pending set to max of 256"));
+		cFYI(1, ("cifs_max_pending set to max of 256"));
 	}
 
 	rc = cifs_init_inodecache();
@@ -863,13 +853,13 @@ static int __init init_cifs(void)
 			rc = cifs_init_request_bufs();
 			if (!rc) {
 				rc = register_filesystem(&cifs_fs_type);
-				if (!rc) {                
-					rc = (int)kernel_thread(cifs_oplock_thread, NULL, 
+				if (!rc) {
+					rc = (int)kernel_thread(cifs_oplock_thread, NULL,
 						CLONE_FS | CLONE_FILES | CLONE_VM);
-					if(rc > 0)
+					if (rc > 0)
 						return 0;
-					else 
-						cERROR(1,("error %d create oplock thread",rc));
+					else
+						cERROR(1, ("error %d create oplock thread", rc));
 				}
 				cifs_destroy_request_bufs();
 			}
@@ -893,16 +883,16 @@ static void __exit exit_cifs(void)
 	cifs_destroy_inodecache();
 	cifs_destroy_mids();
 	cifs_destroy_request_bufs();
-	if(oplockThread) {
+	if (oplockThread) {
 		send_sig(SIGTERM, oplockThread, 1);
 		wait_for_completion(&cifs_oplock_exited);
 	}
 }
 
 MODULE_AUTHOR("Steve French <sfrench@us.ibm.com>");
-MODULE_LICENSE("GPL");		/* combination of LGPL + GPL source behaves as GPL */
-MODULE_DESCRIPTION
-    ("VFS to access servers complying with the SNIA CIFS Specification e.g. Samba and Windows");
+MODULE_LICENSE("GPL"); /* combination of LGPL + GPL source behaves as GPL */
+MODULE_DESCRIPTION("VFS to access servers complying with the "
+		   "SNIA CIFS Specification e.g. Samba and Windows");
 MODULE_VERSION(CIFS_VERSION);
 module_init(init_cifs)
 module_exit(exit_cifs)

