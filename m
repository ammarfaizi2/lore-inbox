Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVDGTWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVDGTWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVDGTWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:22:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:61880 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262568AbVDGTWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:22:06 -0400
Date: Thu, 7 Apr 2005 21:24:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: whitespace cleanups for fcntl.c
Message-ID: <Pine.LNX.4.62.0504072119110.2479@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>

Here's a patch with cleanups for fs/cifs/fcntl.c
This time the file is so small and the cleanups so trivial that I chose to 
just put the whole thing in a single patch - if you want it split, then 
just say so.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

---

 fcntl.c |   65 
++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 33 insertions(+), 32 deletions(-)

--- linux-2.6.12-rc2-mm1-orig/fs/cifs/fcntl.c	2005-04-05 21:21:42.000000000 +0200
+++ linux-2.6.12-rc2-mm1/fs/cifs/fcntl.c	2005-04-07 21:15:27.000000000 +0200
@@ -34,40 +34,39 @@ static __u32 convert_to_cifs_notify_flag
 	__u32 cifs_ntfy_flags = 0;
 
 	/* No way on Linux VFS to ask to monitor xattr
-	changes (and no stream support either */
-	if(fcntl_notify_flags & DN_ACCESS) {
+	   changes (and no stream support either) */
+	if (fcntl_notify_flags & DN_ACCESS) {
 		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_LAST_ACCESS;
 	}
-	if(fcntl_notify_flags & DN_MODIFY) {
+	if (fcntl_notify_flags & DN_MODIFY) {
 		/* What does this mean on directories? */
 		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_LAST_WRITE |
-			FILE_NOTIFY_CHANGE_SIZE;
+				   FILE_NOTIFY_CHANGE_SIZE;
 	}
-	if(fcntl_notify_flags & DN_CREATE) {
-		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_CREATION | 
-			FILE_NOTIFY_CHANGE_LAST_WRITE;
+	if (fcntl_notify_flags & DN_CREATE) {
+		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_CREATION |
+				   FILE_NOTIFY_CHANGE_LAST_WRITE;
 	}
-	if(fcntl_notify_flags & DN_DELETE) {
+	if (fcntl_notify_flags & DN_DELETE) {
 		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_LAST_WRITE;
 	}
-	if(fcntl_notify_flags & DN_RENAME) {
+	if (fcntl_notify_flags & DN_RENAME) {
 		/* BB review this - checking various server behaviors */
-		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_DIR_NAME | 
-			FILE_NOTIFY_CHANGE_FILE_NAME;
+		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_DIR_NAME |
+				   FILE_NOTIFY_CHANGE_FILE_NAME;
 	}
-	if(fcntl_notify_flags & DN_ATTRIB) {
-		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_SECURITY | 
-			FILE_NOTIFY_CHANGE_ATTRIBUTES;
+	if (fcntl_notify_flags & DN_ATTRIB) {
+		cifs_ntfy_flags |= FILE_NOTIFY_CHANGE_SECURITY |
+				   FILE_NOTIFY_CHANGE_ATTRIBUTES;
 	}
-/*	if(fcntl_notify_flags & DN_MULTISHOT) {
+/*	if (fcntl_notify_flags & DN_MULTISHOT) {
 		cifs_ntfy_flags |= ;
 	} */ /* BB fixme - not sure how to handle this with CIFS yet */
 
-
 	return cifs_ntfy_flags;
 }
 
-int cifs_dir_notify(struct file * file, unsigned long arg)
+int cifs_dir_notify(struct file *file, unsigned long arg)
 {
 	int xid;
 	int rc = -EINVAL;
@@ -86,32 +85,34 @@ int cifs_dir_notify(struct file * file, 
 	full_path = build_path_from_dentry(file->f_dentry);
 	up(&file->f_dentry->d_sb->s_vfs_rename_sem);
 
-	if(full_path == NULL) {
+	if (full_path == NULL) {
 		rc = -ENOMEM;
 	} else {
-		cERROR(1,("cifs dir notify on file %s with arg 0x%lx",full_path,arg)); /* BB removeme BB */
-		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN, 
+		cERROR(1, ("cifs dir notify on file %s with arg 0x%lx",
+			   full_path, arg)); /* BB removeme BB */
+		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN,
 			GENERIC_READ | SYNCHRONIZE, 0 /* create options */,
-			&netfid, &oplock,NULL, cifs_sb->local_nls);
+			&netfid, &oplock, NULL, cifs_sb->local_nls);
 		/* BB fixme - add this handle to a notify handle list */
-		if(rc) {
-			cERROR(1,("Could not open directory for notify"));  /* BB remove BB */
+		if (rc) {
+     /* BB remove BB */	cERROR(1, ("Could not open directory for notify"));
 		} else {
 			filter = convert_to_cifs_notify_flags(arg);
-			if(filter != 0) {
-				rc = CIFSSMBNotify(xid, pTcon, 0 /* no subdirs */, netfid, 
-					filter, cifs_sb->local_nls);
+			if (filter != 0) {
+				rc = CIFSSMBNotify(xid, pTcon,
+						   0 /* no subdirs */, netfid,
+						   filter, cifs_sb->local_nls);
 			} else {
 				rc = -EINVAL;
 			}
-			/* BB add code to close file eventually (at unmount
-			it would close automatically but may be a way
-			to do it easily when inode freed or when
-			notify info is cleared/changed */
-            cERROR(1,("notify rc %d",rc));
+			/* BB add code to close file eventually (at unmount it
+			   would close automatically but may be a way to do it
+			   easily when inode freed or when notify info is
+			   cleared/changed */
+			cERROR(1, ("notify rc %d", rc));
 		}
 	}
-	
+
 	FreeXid(xid);
 	return rc;
 }


