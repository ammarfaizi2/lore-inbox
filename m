Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVABL7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVABL7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 06:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVABL7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 06:59:41 -0500
Received: from mail.dif.dk ([193.138.115.101]:23006 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261240AbVABL7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 06:59:37 -0500
Date: Sun, 2 Jan 2005 13:10:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>
Cc: samba-technical <samba-technical@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Clayton <chris_clayton@f1internet.com>,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: [Patch] More unnecessary assignments in fs/cifs/file.c (fwd)
Message-ID: <Pine.LNX.4.61.0501021209180.3494@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve, 

Chris Clayton send me the patch below and asked if I could forward it for 
him.
Since Chris' original patch was whitespace damaged I've rediffed it 
against 2.6.10-bk4 

I've kept Chris' comments on the patch below but substituted his original 
with my re-diffed version and added my own Signed-off-by line since the 
patch looks good to me.


---------- Forwarded message ----------
Date: Fri, 31 Dec 2004 16:58:33 +0000
From: Chris Clayton <chris_clayton@f1internet.com>
To: juhl-lkml@dif.dk
Subject: [Patch] More unnecessary assignments in fs/cifs/file.c

<text irrelevant to the patch snipped>

I saw the patch you submitted ealier this week to remove two unnecessary 
assignments from fs/cifs/file.c. Whilst looking over the original source 
file, I think I've spotted two more of these assignments. The patch below is 
against virgin 2.6.10 (i.e it doesn't have your earlier whitespace patch 
applied), so you may have to fix it up a bit to get it to apply to your tree.

Thanks,

Chris

Signed-off-by: Chris Clayton  <chris_clayton@f1internet.com>
Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.10-bk4-orig/fs/cifs/file.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10-bk4/fs/cifs/file.c	2005-01-02 12:56:13.000000000 +0100
@@ -73,9 +73,8 @@ cifs_open(struct inode *inode, struct fi
 		}
 		read_unlock(&GlobalSMBSeslock);
 		if(file->private_data != NULL) {
-			rc = 0;
 			FreeXid(xid);
-			return rc;
+			return 0;
 		} else {
 			if(file->f_flags & O_EXCL)
 				cERROR(1,("could not find file instance for new file %p ",file));
@@ -1952,9 +1951,8 @@ cifs_readdir(struct file *file, void *di
 	data = kmalloc(bufsize, GFP_KERNEL);
 	pfindData = (FILE_DIRECTORY_INFO *) data;
 	if(data == NULL) {
-		rc = -ENOMEM;
 		FreeXid(xid);
-		return rc;
+		return -ENOMEM;
 	}
 	down(&file->f_dentry->d_sb->s_vfs_rename_sem);
 	full_path = build_wildcard_path_from_dentry(file->f_dentry);



