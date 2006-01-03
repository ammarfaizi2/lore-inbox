Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWACX26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWACX26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWACX2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:28:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:2012 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965080AbWACX2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:28:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 27/41] m68k: ataflop __user annotations, NULL noise removal
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etva4-0003OE-Mi@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:28:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011711 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/block/ataflop.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

1366eba39dfa2b807068d3ec49da87bcfd3aae7c
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 22bda05..577698d 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1361,7 +1361,7 @@ static int floppy_revalidate(struct gend
 		   formats, for 'permanent user-defined' parameter:
 		   restore default_params[] here if flagged valid! */
 		if (default_params[drive].blocks == 0)
-			UDT = 0;
+			UDT = NULL;
 		else
 			UDT = &default_params[drive];
 	}
@@ -1495,6 +1495,7 @@ static int fd_ioctl(struct inode *inode,
 	struct floppy_struct getprm;
 	int settype;
 	struct floppy_struct setprm;
+	void __user *argp = (void __user *)param;
 
 	switch (cmd) {
 	case FDGETPRM:
@@ -1521,7 +1522,7 @@ static int fd_ioctl(struct inode *inode,
 		getprm.head = 2;
 		getprm.track = dtp->blocks/dtp->spt/2;
 		getprm.stretch = dtp->stretch;
-		if (copy_to_user((void *)param, &getprm, sizeof(getprm)))
+		if (copy_to_user(argp, &getprm, sizeof(getprm)))
 			return -EFAULT;
 		return 0;
 	}
@@ -1540,7 +1541,7 @@ static int fd_ioctl(struct inode *inode,
 		/* get the parameters from user space */
 		if (floppy->ref != 1 && floppy->ref != -1)
 			return -EBUSY;
-		if (copy_from_user(&setprm, (void *) param, sizeof(setprm)))
+		if (copy_from_user(&setprm, argp, sizeof(setprm)))
 			return -EFAULT;
 		/* 
 		 * first of all: check for floppy change and revalidate, 
@@ -1647,7 +1648,7 @@ static int fd_ioctl(struct inode *inode,
 	case FDFMTTRK:
 		if (floppy->ref != 1 && floppy->ref != -1)
 			return -EBUSY;
-		if (copy_from_user(&fmt_desc, (void *) param, sizeof(fmt_desc)))
+		if (copy_from_user(&fmt_desc, argp, sizeof(fmt_desc)))
 			return -EFAULT;
 		return do_format(drive, type, &fmt_desc);
 	case FDCLRPRM:
-- 
0.99.9.GIT

