Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRIHJP4>; Sat, 8 Sep 2001 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRIHJPq>; Sat, 8 Sep 2001 05:15:46 -0400
Received: from HINux.hin.no ([158.39.26.220]:22963 "EHLO hinux.hin.no")
	by vger.kernel.org with ESMTP id <S268145AbRIHJPh> convert rfc822-to-8bit;
	Sat, 8 Sep 2001 05:15:37 -0400
Subject: [PATCH] 2.4.10-pre5 fs/dquot.c
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Sep 2001 11:20:51 -0100
Message-Id: <999951651.23500.1.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another fix.. just in case it hasn't already been submitted. :]

Best regards,
Ole André

---

--- linux/fs/dquot.c-orig	Sat Sep  8 11:17:13 2001
+++ linux/fs/dquot.c	Sat Sep  8 11:15:42 2001
@@ -671,8 +671,8 @@
 		struct file *filp = list_entry(p, struct file, f_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
-			struct vfsmount *mnt = mntget(file->f_vfsmnt);
-			struct dentry *dentry = dget(file->f_dentry);
+			struct vfsmount *mnt = mntget(filp->f_vfsmnt);
+			struct dentry *dentry = dget(filp->f_dentry);
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
 			inode->i_flags |= S_QUOTA;

