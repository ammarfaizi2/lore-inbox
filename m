Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVDBW5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDBW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDBW4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:56:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:55970 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261319AbVDBWwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:52:25 -0500
Date: Sun, 3 Apr 2005 00:54:40 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][3/7] cifs: dir.c cleanup - comments
Message-ID: <Pine.LNX.4.62.0504030053030.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beautify comments in fs/cifs/dir.c and make them style-wise consistent with
the other files.

Signed-of-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch2	2005-04-02 23:51:24.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-02 23:58:37.000000000 +0200
@@ -33,7 +33,8 @@
 
 void renew_parental_timestamps(struct dentry *direntry)
 {
-	/* BB check if there is a way to get the kernel to do this or if we really need this */
+	/* BB check if there is a way to get the kernel to do this or if we 
+	   really need this */
 	do {
 		direntry->d_time = jiffies;
 		direntry = direntry->d_parent;
@@ -49,9 +50,8 @@ char *build_path_from_dentry(struct dent
 
 	if (direntry == NULL)
 		return NULL;	/* not much we can do if dentry is freed and
-		we need to reopen the file after it was closed implicitly
-		when the server crashed */
-
+				   we need to reopen the file after it was
+				   closed implicitly when the server crashed */
 cifs_bp_rename_retry:
 	for (temp = direntry; !IS_ROOT(temp); ) {
 		namelen += (1 + temp->d_name.len);
@@ -87,9 +87,10 @@ cifs_bp_rename_retry:
 	if (namelen != 0) {
 		cERROR(1, ("We did not end path lookup where we expected "
 			   "namelen is %d", namelen));
-		/* presumably this is only possible if we were racing with a rename 
-		of one of the parent directories  (we can not lock the dentries
-		above us to prevent this, but retrying should be harmless) */
+		/* presumably this is only possible if we were racing with a
+		   rename of one of the parent directories (we can not lock the
+		   dentries above us to prevent this, but retrying should be
+		   harmless) */
 		kfree(full_path);
 		namelen = 0;
 		goto cifs_bp_rename_retry;
@@ -106,10 +107,9 @@ char *build_wildcard_path_from_dentry(st
 	char *full_path;
 
 	if (direntry == NULL)
-		return NULL;	/* not much we can do if dentry is freed and
-		we need to reopen the file after it was closed implicitly
-		when the server crashed */
-
+		return NULL;	/* not much we can do if dentry is freed and we
+				   need to reopen the file after it was closed
+				   implicitly when the server crashed */
 cifs_bwp_rename_retry:
 	for (temp = direntry; !IS_ROOT(temp); ) {
 		namelen += (1 + temp->d_name.len);
@@ -148,9 +148,10 @@ cifs_bwp_rename_retry:
 	if (namelen != 0) {
 		cERROR(1, ("We did not end path lookup where we expected "
 			   "namelen is %d", namelen));
-		/* presumably this is only possible if we were racing with a rename 
-		of one of the parent directories  (we can not lock the dentries
-		above us to prevent this, but retrying should be harmless) */
+		/* presumably this is only possible if we were racing with a
+		   rename of one of the parent directories (we can not lock the
+		   dentries above us to prevent this, but retrying should be
+		   harmless) */
 		kfree(full_path);
 		namelen = 0;
 		goto cifs_bwp_rename_retry;
@@ -159,7 +160,7 @@ cifs_bwp_rename_retry:
 	return full_path;
 }
 
-/* Inode operations in similar order to how they appear in the Linux file fs.h */
+/* Inode operations in similar order to how they appear in Linux file fs.h */
 int cifs_create(struct inode *inode, struct dentry *direntry, int mode,
 	struct nameidata *nd)
 {
@@ -198,8 +199,8 @@ int cifs_create(struct inode *inode, str
 			desiredAccess = GENERIC_WRITE;
 			write_only = TRUE;
 		} else if ((nd->intent.open.flags & O_ACCMODE) == O_RDWR) {
-			/* GENERIC_ALL is too much permission to request */
-			/* can cause unnecessary access denied on create */
+			/* GENERIC_ALL is too much permission to request
+			   can cause unnecessary access denied on create */
 			/* desiredAccess = GENERIC_ALL; */
 			desiredAccess = GENERIC_READ | GENERIC_WRITE;
 		}
@@ -215,7 +216,8 @@ int cifs_create(struct inode *inode, str
 		}
 	}
 
-	/* BB add processing to set equivalent of mode - e.g. via CreateX with ACLs */
+	/* BB add processing to set equivalent of mode -
+	   e.g. via CreateX with ACLs */
 	if (oplockEnabled)
 		oplock = REQ_OPLOCK;
 
@@ -232,8 +234,8 @@ int cifs_create(struct inode *inode, str
 	if (rc) {
 		cFYI(1, ("cifs_create returned 0x%x ", rc));
 	} else {
-		/* If Open reported that we actually created a file
-		then we now have to set the mode if possible */
+		/* If Open reported that we actually created a file then we now
+		   have to set the mode if possible */
 		if ((cifs_sb->tcon->ses->capabilities & CAP_UNIX) &&
 		    (oplock & CIFS_CREATE_ACTION)) {
 			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
@@ -249,12 +251,14 @@ int cifs_create(struct inode *inode, str
 						    cifs_sb->local_nls);
 			}
 		} else {
-			/* BB implement via Windows security descriptors */
-			/* eg CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,-1,-1,local_nls);*/
-			/* could set r/o dos attribute if mode & 0222 == 0 */
+			/* BB implement via Windows security descriptors eg
+			   CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, -1,
+					      -1, local_nls);
+			   could set r/o dos attribute if mode & 0222 == 0 */
 		}
 
-	/* BB server might mask mode so we have to query for Unix case*/
+		/* BB server might mask mode, so we have to query for Unix
+		   case */
 		if (pTcon->ses->capabilities & CAP_UNIX) {
 			rc = cifs_get_inode_info_unix(&newinode, full_path,
 						      inode->i_sb,xid);
@@ -295,7 +299,8 @@ int cifs_create(struct inode *inode, str
 					 &pTcon->openFileList);
 				pCifsInode = CIFS_I(newinode);
 				if (pCifsInode) {
-				/* if readable file instance put first in list*/
+				/* if readable file instance put first in list
+				   */
 					if (write_only == TRUE) {
                                         	list_add_tail(&pCifsFile->flist,
 							&pCifsInode->openFileList);
@@ -394,16 +399,18 @@ struct dentry *cifs_lookup(struct inode 
 	cFYI(1, (" parent inode = 0x%p name is: %s and dentry = 0x%p",
 		 parent_dir_inode, direntry->d_name.name, direntry));
 
-	/* BB Add check of incoming data - e.g. frame not longer than maximum SMB - let server check the namelen BB */
+	/* BB Add check of incoming data -
+	   e.g. frame not longer than maximum SMB -
+	   let server check the namelen BB */
 
 	/* check whether path exists */
 
 	cifs_sb = CIFS_SB(parent_dir_inode->i_sb);
 	pTcon = cifs_sb->tcon;
 
-	/* can not grab the rename sem here since it would
-	deadlock in the cases (beginning of sys_rename itself)
-	in which we already have the sb rename sem */
+	/* can not grab the rename sem here since it would deadlock in the
+	   cases (beginning of sys_rename itself) in which we already have the
+	   sb rename sem */
 	full_path = build_path_from_dentry(direntry);
 	if (full_path == NULL) {
 		FreeXid(xid);
@@ -428,7 +435,8 @@ struct dentry *cifs_lookup(struct inode 
 		direntry->d_op = &cifs_dentry_ops;
 		d_add(direntry, newInode);
 
-		/* since paths are not looked up by component - the parent directories are presumed to be good here */
+		/* since paths are not looked up by component -
+		   the parent directories are presumed to be good here */
 		renew_parental_timestamps(direntry);
 
 	} else if (rc == -ENOENT) {
@@ -437,9 +445,9 @@ struct dentry *cifs_lookup(struct inode 
 	} else {
 		cERROR(1, ("Error 0x%x or on cifs_get_inode_info in lookup",
 			   rc));
-		/* BB special case check for Access Denied - watch security 
-		exposure of returning dir info implicitly via different rc 
-		if file exists or not but no access BB */
+		/* BB special case check for Access Denied - watch security
+		   exposure of returning dir info implicitly via different rc
+		   if file exists or not but no access BB */
 	}
 
 	if (full_path)
@@ -483,7 +491,9 @@ static int cifs_d_revalidate(struct dent
 {
 	int isValid = 1;
 
-/*	lock_kernel(); *//* surely we do not want to lock the kernel for a whole network round trip which could take seconds */
+/*	lock_kernel(); */	/* surely we do not want to lock the kernel for
+				   a whole network round trip which could take
+				   seconds */
 
 	if (direntry->d_inode) {
 		if (cifs_revalidate(direntry)) {
@@ -507,10 +517,11 @@ static int cifs_d_revalidate(struct dent
 	cFYI(1, ("In cifs d_delete, name = %s", direntry->d_name.name));
 
 	return rc;
-}     */
+} */
 
 struct dentry_operations cifs_dentry_ops = {
 	.d_revalidate	= cifs_d_revalidate,
 /*	d_delete:	cifs_d_delete, */ /* not needed except for debugging */
-	/* no need for d_hash, d_compare, d_release, d_iput ... yet. BB confirm this BB */
+	/* BB no need for d_hash, d_compare, d_release, d_iput ... yet.
+	   confirm this BB */
 };
