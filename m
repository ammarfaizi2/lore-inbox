Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHTXqm>; Tue, 20 Aug 2002 19:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHTXql>; Tue, 20 Aug 2002 19:46:41 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:33241 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317610AbSHTXpq>; Tue, 20 Aug 2002 19:45:46 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 7/7: Forgot to wrap i_size intercept code in ifdef NTFS_RW...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:49:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIky-0001Kn-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! The 7th, final, changeset in the series. Wraps the i_size changes
trapping code in ifdef NTFS_RW. Forgot to do it in last changeset...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/file.c  |    2 ++
 fs/ntfs/inode.c |    4 ++++
 fs/ntfs/inode.h |    4 ++++
 3 files changed, 10 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (02/08/20 1.486.1.4)
   NTFS: Add ifdef NTFS_RW arround ntfs_truncate and ntfs_setattr.


diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Tue Aug 20 23:58:21 2002
+++ b/fs/ntfs/file.c	Tue Aug 20 23:58:21 2002
@@ -64,8 +64,10 @@
 };
 
 struct inode_operations ntfs_file_inode_ops = {
+#ifdef NTFS_RW
 	.truncate	= ntfs_truncate,
 	.setattr	= ntfs_setattr,
+#endif
 };
 
 struct file_operations ntfs_empty_file_ops = {};
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Tue Aug 20 23:58:21 2002
+++ b/fs/ntfs/inode.c	Tue Aug 20 23:58:21 2002
@@ -1928,6 +1928,8 @@
 	return 0;
 }
 
+#ifdef NTFS_RW
+
 /**
  * ntfs_truncate - called when the i_size of an ntfs inode is changed
  * @vi:		inode for which the i_size was changed
@@ -2016,4 +2018,6 @@
 
 	return err;
 }
+
+#endif
 
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Tue Aug 20 23:58:21 2002
+++ b/fs/ntfs/inode.h	Tue Aug 20 23:58:21 2002
@@ -245,9 +245,13 @@
 
 extern int ntfs_show_options(struct seq_file *sf, struct vfsmount *mnt);
 
+#ifdef NTFS_RW
+
 extern void ntfs_truncate(struct inode *vi);
 
 extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
+
+#endif
 
 #endif /* _LINUX_NTFS_FS_INODE_H */
 

