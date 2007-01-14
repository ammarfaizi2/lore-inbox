Return-Path: <linux-kernel-owner+w=401wt.eu-S1751042AbXANBEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXANBEb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbXANBEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:04:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52798 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXANBE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:04:26 -0500
Subject: [patch 12/12] mark struct inode_operations const 3
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:58:36 -0800
Message-Id: <1168736316.3123.341.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 12/12] mark struct inode_operations const

Many struct inode_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.20-rc4/fs/proc/base.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/proc/base.c
+++ linux-2.6.20-rc4/fs/proc/base.c
@@ -93,7 +93,7 @@ struct pid_entry {
 	int len;
 	char *name;
 	mode_t mode;
-	struct inode_operations *iop;
+	const struct inode_operations *iop;
 	const struct file_operations *fop;
 	union proc_op op;
 };
@@ -352,7 +352,7 @@ static int proc_setattr(struct dentry *d
 	return error;
 }
 
-static struct inode_operations proc_def_inode_operations = {
+static const struct inode_operations proc_def_inode_operations = {
 	.setattr	= proc_setattr,
 };
 
@@ -978,7 +978,7 @@ out:
 	return error;
 }
 
-static struct inode_operations proc_pid_link_inode_operations = {
+static const struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
 	.follow_link	= proc_pid_follow_link,
 	.setattr	= proc_setattr,
@@ -1414,7 +1414,7 @@ static const struct file_operations proc
 /*
  * proc directories can do almost nothing..
  */
-static struct inode_operations proc_fd_inode_operations = {
+static const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.setattr	= proc_setattr,
 };
@@ -1654,7 +1654,7 @@ static struct dentry *proc_attr_dir_look
 				  attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }
 
-static struct inode_operations proc_attr_dir_inode_operations = {
+static const struct inode_operations proc_attr_dir_inode_operations = {
 	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
 	.setattr	= proc_setattr,
@@ -1680,7 +1680,7 @@ static void *proc_self_follow_link(struc
 	return ERR_PTR(vfs_follow_link(nd,tmp));
 }
 
-static struct inode_operations proc_self_inode_operations = {
+static const struct inode_operations proc_self_inode_operations = {
 	.readlink	= proc_self_readlink,
 	.follow_link	= proc_self_follow_link,
 };
@@ -1829,7 +1829,7 @@ static int proc_pid_io_accounting(struct
  * Thread groups
  */
 static const struct file_operations proc_task_operations;
-static struct inode_operations proc_task_inode_operations;
+static const struct inode_operations proc_task_inode_operations;
 
 static struct pid_entry tgid_base_stuff[] = {
 	DIR("task",       S_IRUGO|S_IXUGO, task),
@@ -1898,7 +1898,7 @@ static struct dentry *proc_tgid_base_loo
 				  tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
-static struct inode_operations proc_tgid_base_inode_operations = {
+static const struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 	.getattr	= pid_getattr,
 	.setattr	= proc_setattr,
@@ -2176,7 +2176,7 @@ static const struct file_operations proc
 	.readdir	= proc_tid_base_readdir,
 };
 
-static struct inode_operations proc_tid_base_inode_operations = {
+static const struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
 	.setattr	= proc_setattr,
@@ -2392,7 +2392,7 @@ static int proc_task_getattr(struct vfsm
 	return 0;
 }
 
-static struct inode_operations proc_task_inode_operations = {
+static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
 	.setattr	= proc_setattr,
Index: linux-2.6.20-rc4/fs/proc/generic.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/proc/generic.c
+++ linux-2.6.20-rc4/fs/proc/generic.c
@@ -265,7 +265,7 @@ static int proc_getattr(struct vfsmount 
 	return 0;
 }
 
-static struct inode_operations proc_file_inode_operations = {
+static const struct inode_operations proc_file_inode_operations = {
 	.setattr	= proc_notify_change,
 };
 
@@ -357,7 +357,7 @@ static void *proc_follow_link(struct den
 	return NULL;
 }
 
-static struct inode_operations proc_link_inode_operations = {
+static const struct inode_operations proc_link_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= proc_follow_link,
 };
@@ -505,7 +505,7 @@ static const struct file_operations proc
 /*
  * proc directories can do almost nothing..
  */
-static struct inode_operations proc_dir_inode_operations = {
+static const struct inode_operations proc_dir_inode_operations = {
 	.lookup		= proc_lookup,
 	.getattr	= proc_getattr,
 	.setattr	= proc_notify_change,
Index: linux-2.6.20-rc4/fs/proc/root.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/proc/root.c
+++ linux-2.6.20-rc4/fs/proc/root.c
@@ -144,7 +144,7 @@ static const struct file_operations proc
 /*
  * proc root can do almost nothing..
  */
-static struct inode_operations proc_root_inode_operations = {
+static const struct inode_operations proc_root_inode_operations = {
 	.lookup		= proc_root_lookup,
 	.getattr	= proc_root_getattr,
 };
Index: linux-2.6.20-rc4/fs/qnx4/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/qnx4/dir.c
+++ linux-2.6.20-rc4/fs/qnx4/dir.c
@@ -87,7 +87,7 @@ const struct file_operations qnx4_dir_op
 	.fsync		= file_fsync,
 };
 
-struct inode_operations qnx4_dir_inode_operations =
+const struct inode_operations qnx4_dir_inode_operations =
 {
 	.lookup		= qnx4_lookup,
 #ifdef CONFIG_QNX4FS_RW
Index: linux-2.6.20-rc4/fs/qnx4/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/qnx4/file.c
+++ linux-2.6.20-rc4/fs/qnx4/file.c
@@ -33,7 +33,7 @@ const struct file_operations qnx4_file_o
 #endif
 };
 
-struct inode_operations qnx4_file_inode_operations =
+const struct inode_operations qnx4_file_inode_operations =
 {
 #ifdef CONFIG_QNX4FS_RW
 	.truncate	= qnx4_truncate,
Index: linux-2.6.20-rc4/fs/ramfs/file-mmu.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ramfs/file-mmu.c
+++ linux-2.6.20-rc4/fs/ramfs/file-mmu.c
@@ -45,6 +45,6 @@ const struct file_operations ramfs_file_
 	.llseek		= generic_file_llseek,
 };
 
-struct inode_operations ramfs_file_inode_operations = {
+const struct inode_operations ramfs_file_inode_operations = {
 	.getattr	= simple_getattr,
 };
Index: linux-2.6.20-rc4/fs/ramfs/file-nommu.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ramfs/file-nommu.c
+++ linux-2.6.20-rc4/fs/ramfs/file-nommu.c
@@ -47,7 +47,7 @@ const struct file_operations ramfs_file_
 	.llseek			= generic_file_llseek,
 };
 
-struct inode_operations ramfs_file_inode_operations = {
+const struct inode_operations ramfs_file_inode_operations = {
 	.setattr		= ramfs_nommu_setattr,
 	.getattr		= simple_getattr,
 };
Index: linux-2.6.20-rc4/fs/ramfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ramfs/inode.c
+++ linux-2.6.20-rc4/fs/ramfs/inode.c
@@ -41,7 +41,7 @@
 #define RAMFS_MAGIC	0x858458f6
 
 static struct super_operations ramfs_ops;
-static struct inode_operations ramfs_dir_inode_operations;
+static const struct inode_operations ramfs_dir_inode_operations;
 
 static struct backing_dev_info ramfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -143,7 +143,7 @@ static int ramfs_symlink(struct inode * 
 	return error;
 }
 
-static struct inode_operations ramfs_dir_inode_operations = {
+static const struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
 	.link		= simple_link,
Index: linux-2.6.20-rc4/fs/ramfs/internal.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ramfs/internal.h
+++ linux-2.6.20-rc4/fs/ramfs/internal.h
@@ -12,4 +12,4 @@
 
 extern const struct address_space_operations ramfs_aops;
 extern const struct file_operations ramfs_file_operations;
-extern struct inode_operations ramfs_file_inode_operations;
+extern const struct inode_operations ramfs_file_inode_operations;
Index: linux-2.6.20-rc4/fs/reiserfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/reiserfs/file.c
+++ linux-2.6.20-rc4/fs/reiserfs/file.c
@@ -1538,7 +1538,7 @@ const struct file_operations reiserfs_fi
 	.splice_write = generic_file_splice_write,
 };
 
-struct inode_operations reiserfs_file_inode_operations = {
+const struct inode_operations reiserfs_file_inode_operations = {
 	.truncate = reiserfs_vfs_truncate_file,
 	.setattr = reiserfs_setattr,
 	.setxattr = reiserfs_setxattr,
Index: linux-2.6.20-rc4/fs/reiserfs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/reiserfs/namei.c
+++ linux-2.6.20-rc4/fs/reiserfs/namei.c
@@ -1525,7 +1525,7 @@ static int reiserfs_rename(struct inode 
 /*
  * directories can handle most operations...
  */
-struct inode_operations reiserfs_dir_inode_operations = {
+const struct inode_operations reiserfs_dir_inode_operations = {
 	//&reiserfs_dir_operations,   /* default_file_ops */
 	.create = reiserfs_create,
 	.lookup = reiserfs_lookup,
@@ -1548,7 +1548,7 @@ struct inode_operations reiserfs_dir_ino
  * symlink operations.. same as page_symlink_inode_operations, with xattr
  * stuff added
  */
-struct inode_operations reiserfs_symlink_inode_operations = {
+const struct inode_operations reiserfs_symlink_inode_operations = {
 	.readlink = generic_readlink,
 	.follow_link = page_follow_link_light,
 	.put_link = page_put_link,
@@ -1564,7 +1564,7 @@ struct inode_operations reiserfs_symlink
 /*
  * special file operations.. just xattr/acl stuff
  */
-struct inode_operations reiserfs_special_inode_operations = {
+const struct inode_operations reiserfs_special_inode_operations = {
 	.setattr = reiserfs_setattr,
 	.setxattr = reiserfs_setxattr,
 	.getxattr = reiserfs_getxattr,
Index: linux-2.6.20-rc4/fs/romfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/romfs/inode.c
+++ linux-2.6.20-rc4/fs/romfs/inode.c
@@ -468,7 +468,7 @@ static const struct file_operations romf
 	.readdir	= romfs_readdir,
 };
 
-static struct inode_operations romfs_dir_inode_operations = {
+static const struct inode_operations romfs_dir_inode_operations = {
 	.lookup		= romfs_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/smbfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/smbfs/dir.c
+++ linux-2.6.20-rc4/fs/smbfs/dir.c
@@ -42,7 +42,7 @@ const struct file_operations smb_dir_ope
 	.open		= smb_dir_open,
 };
 
-struct inode_operations smb_dir_inode_operations =
+const struct inode_operations smb_dir_inode_operations =
 {
 	.create		= smb_create,
 	.lookup		= smb_lookup,
@@ -54,7 +54,7 @@ struct inode_operations smb_dir_inode_op
 	.setattr	= smb_notify_change,
 };
 
-struct inode_operations smb_dir_inode_operations_unix =
+const struct inode_operations smb_dir_inode_operations_unix =
 {
 	.create		= smb_create,
 	.lookup		= smb_lookup,
Index: linux-2.6.20-rc4/fs/smbfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/smbfs/file.c
+++ linux-2.6.20-rc4/fs/smbfs/file.c
@@ -418,7 +418,7 @@ const struct file_operations smb_file_op
 	.sendfile	= smb_file_sendfile,
 };
 
-struct inode_operations smb_file_inode_operations =
+const struct inode_operations smb_file_inode_operations =
 {
 	.permission	= smb_file_permission,
 	.getattr	= smb_getattr,
Index: linux-2.6.20-rc4/fs/smbfs/proto.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/smbfs/proto.h
+++ linux-2.6.20-rc4/fs/smbfs/proto.h
@@ -36,8 +36,8 @@ extern int smb_proc_link(struct smb_sb_i
 extern void smb_install_null_ops(struct smb_ops *ops);
 /* dir.c */
 extern const struct file_operations smb_dir_operations;
-extern struct inode_operations smb_dir_inode_operations;
-extern struct inode_operations smb_dir_inode_operations_unix;
+extern const struct inode_operations smb_dir_inode_operations;
+extern const struct inode_operations smb_dir_inode_operations_unix;
 extern void smb_new_dentry(struct dentry *dentry);
 extern void smb_renew_times(struct dentry *dentry);
 /* cache.c */
@@ -65,7 +65,7 @@ extern int smb_notify_change(struct dent
 /* file.c */
 extern const struct address_space_operations smb_file_aops;
 extern const struct file_operations smb_file_operations;
-extern struct inode_operations smb_file_inode_operations;
+extern const struct inode_operations smb_file_inode_operations;
 /* ioctl.c */
 extern int smb_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg);
 /* smbiod.c */
@@ -84,4 +84,4 @@ extern int smb_request_send_server(struc
 extern int smb_request_recv(struct smb_sb_info *server);
 /* symlink.c */
 extern int smb_symlink(struct inode *inode, struct dentry *dentry, const char *oldname);
-extern struct inode_operations smb_link_inode_operations;
+extern const struct inode_operations smb_link_inode_operations;
Index: linux-2.6.20-rc4/fs/smbfs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/smbfs/symlink.c
+++ linux-2.6.20-rc4/fs/smbfs/symlink.c
@@ -62,7 +62,7 @@ static void smb_put_link(struct dentry *
 		__putname(s);
 }
 
-struct inode_operations smb_link_inode_operations =
+const struct inode_operations smb_link_inode_operations =
 {
 	.readlink	= generic_readlink,
 	.follow_link	= smb_follow_link,
Index: linux-2.6.20-rc4/fs/sysfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysfs/dir.c
+++ linux-2.6.20-rc4/fs/sysfs/dir.c
@@ -267,7 +267,7 @@ static struct dentry * sysfs_lookup(stru
 	return ERR_PTR(err);
 }
 
-struct inode_operations sysfs_dir_inode_operations = {
+const struct inode_operations sysfs_dir_inode_operations = {
 	.lookup		= sysfs_lookup,
 	.setattr	= sysfs_setattr,
 };
Index: linux-2.6.20-rc4/fs/sysfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysfs/inode.c
+++ linux-2.6.20-rc4/fs/sysfs/inode.c
@@ -28,7 +28,7 @@ static struct backing_dev_info sysfs_bac
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-static struct inode_operations sysfs_inode_operations ={
+static const struct inode_operations sysfs_inode_operations ={
 	.setattr	= sysfs_setattr,
 };
 
Index: linux-2.6.20-rc4/fs/sysfs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysfs/symlink.c
+++ linux-2.6.20-rc4/fs/sysfs/symlink.c
@@ -180,7 +180,7 @@ static void sysfs_put_link(struct dentry
 		free_page((unsigned long)page);
 }
 
-struct inode_operations sysfs_symlink_inode_operations = {
+const struct inode_operations sysfs_symlink_inode_operations = {
 	.readlink = generic_readlink,
 	.follow_link = sysfs_follow_link,
 	.put_link = sysfs_put_link,
Index: linux-2.6.20-rc4/fs/sysfs/sysfs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysfs/sysfs.h
+++ linux-2.6.20-rc4/fs/sysfs/sysfs.h
@@ -25,8 +25,8 @@ extern struct super_block * sysfs_sb;
 extern const struct file_operations sysfs_dir_operations;
 extern const struct file_operations sysfs_file_operations;
 extern const struct file_operations bin_fops;
-extern struct inode_operations sysfs_dir_inode_operations;
-extern struct inode_operations sysfs_symlink_inode_operations;
+extern const struct inode_operations sysfs_dir_inode_operations;
+extern const struct inode_operations sysfs_symlink_inode_operations;
 
 struct sysfs_symlink {
 	char * link_name;
Index: linux-2.6.20-rc4/fs/sysv/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysv/file.c
+++ linux-2.6.20-rc4/fs/sysv/file.c
@@ -30,7 +30,7 @@ const struct file_operations sysv_file_o
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations sysv_file_inode_operations = {
+const struct inode_operations sysv_file_inode_operations = {
 	.truncate	= sysv_truncate,
 	.getattr	= sysv_getattr,
 };
Index: linux-2.6.20-rc4/fs/sysv/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysv/inode.c
+++ linux-2.6.20-rc4/fs/sysv/inode.c
@@ -142,7 +142,7 @@ static inline void write3byte(struct sys
 	}
 }
 
-static struct inode_operations sysv_symlink_inode_operations = {
+static const struct inode_operations sysv_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/sysv/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysv/namei.c
+++ linux-2.6.20-rc4/fs/sysv/namei.c
@@ -292,7 +292,7 @@ out:
 /*
  * directories can handle most operations...
  */
-struct inode_operations sysv_dir_inode_operations = {
+const struct inode_operations sysv_dir_inode_operations = {
 	.create		= sysv_create,
 	.lookup		= sysv_lookup,
 	.link		= sysv_link,
Index: linux-2.6.20-rc4/fs/sysv/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysv/symlink.c
+++ linux-2.6.20-rc4/fs/sysv/symlink.c
@@ -14,7 +14,7 @@ static void *sysv_follow_link(struct den
 	return NULL;
 }
 
-struct inode_operations sysv_fast_symlink_inode_operations = {
+const struct inode_operations sysv_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= sysv_follow_link,
 };
Index: linux-2.6.20-rc4/fs/sysv/sysv.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/sysv/sysv.h
+++ linux-2.6.20-rc4/fs/sysv/sysv.h
@@ -159,9 +159,9 @@ extern struct sysv_dir_entry *sysv_dotdo
 extern ino_t sysv_inode_by_name(struct dentry *);
 
 
-extern struct inode_operations sysv_file_inode_operations;
-extern struct inode_operations sysv_dir_inode_operations;
-extern struct inode_operations sysv_fast_symlink_inode_operations;
+extern const struct inode_operations sysv_file_inode_operations;
+extern const struct inode_operations sysv_dir_inode_operations;
+extern const struct inode_operations sysv_fast_symlink_inode_operations;
 extern const struct file_operations sysv_file_operations;
 extern const struct file_operations sysv_dir_operations;
 extern const struct address_space_operations sysv_aops;
Index: linux-2.6.20-rc4/fs/udf/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/udf/file.c
+++ linux-2.6.20-rc4/fs/udf/file.c
@@ -263,6 +263,6 @@ const struct file_operations udf_file_op
 	.sendfile		= generic_file_sendfile,
 };
 
-struct inode_operations udf_file_inode_operations = {
+const struct inode_operations udf_file_inode_operations = {
 	.truncate		= udf_truncate,
 };
Index: linux-2.6.20-rc4/fs/udf/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/udf/namei.c
+++ linux-2.6.20-rc4/fs/udf/namei.c
@@ -1308,7 +1308,7 @@ end_rename:
 	return retval;
 }
 
-struct inode_operations udf_dir_inode_operations = {
+const struct inode_operations udf_dir_inode_operations = {
 	.lookup				= udf_lookup,
 	.create				= udf_create,
 	.link				= udf_link,
Index: linux-2.6.20-rc4/fs/udf/udfdecl.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/udf/udfdecl.h
+++ linux-2.6.20-rc4/fs/udf/udfdecl.h
@@ -42,9 +42,9 @@ struct task_struct;
 struct buffer_head;
 struct super_block;
 
-extern struct inode_operations udf_dir_inode_operations;
+extern const struct inode_operations udf_dir_inode_operations;
 extern const struct file_operations udf_dir_operations;
-extern struct inode_operations udf_file_inode_operations;
+extern const struct inode_operations udf_file_inode_operations;
 extern const struct file_operations udf_file_operations;
 extern const struct address_space_operations udf_aops;
 extern const struct address_space_operations udf_adinicb_aops;
Index: linux-2.6.20-rc4/fs/ufs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ufs/namei.c
+++ linux-2.6.20-rc4/fs/ufs/namei.c
@@ -355,7 +355,7 @@ out:
 	return err;
 }
 
-struct inode_operations ufs_dir_inode_operations = {
+const struct inode_operations ufs_dir_inode_operations = {
 	.create		= ufs_create,
 	.lookup		= ufs_lookup,
 	.link		= ufs_link,
Index: linux-2.6.20-rc4/fs/ufs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ufs/symlink.c
+++ linux-2.6.20-rc4/fs/ufs/symlink.c
@@ -36,7 +36,7 @@ static void *ufs_follow_link(struct dent
 	return NULL;
 }
 
-struct inode_operations ufs_fast_symlink_inode_operations = {
+const struct inode_operations ufs_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ufs_follow_link,
 };
Index: linux-2.6.20-rc4/fs/ufs/truncate.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ufs/truncate.c
+++ linux-2.6.20-rc4/fs/ufs/truncate.c
@@ -502,6 +502,6 @@ static int ufs_setattr(struct dentry *de
 	return inode_setattr(inode, attr);
 }
 
-struct inode_operations ufs_file_inode_operations = {
+const struct inode_operations ufs_file_inode_operations = {
 	.setattr = ufs_setattr,
 };
Index: linux-2.6.20-rc4/fs/vfat/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/vfat/namei.c
+++ linux-2.6.20-rc4/fs/vfat/namei.c
@@ -996,7 +996,7 @@ error_inode:
 	goto out;
 }
 
-static struct inode_operations vfat_dir_inode_operations = {
+static const struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
 	.unlink		= vfat_unlink,
Index: linux-2.6.20-rc4/fs/xfs/linux-2.6/xfs_iops.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/xfs/linux-2.6/xfs_iops.c
+++ linux-2.6.20-rc4/fs/xfs/linux-2.6/xfs_iops.c
@@ -815,7 +815,7 @@ xfs_vn_removexattr(
 }
 
 
-struct inode_operations xfs_inode_operations = {
+const struct inode_operations xfs_inode_operations = {
 	.permission		= xfs_vn_permission,
 	.truncate		= xfs_vn_truncate,
 	.getattr		= xfs_vn_getattr,
@@ -826,7 +826,7 @@ struct inode_operations xfs_inode_operat
 	.removexattr		= xfs_vn_removexattr,
 };
 
-struct inode_operations xfs_dir_inode_operations = {
+const struct inode_operations xfs_dir_inode_operations = {
 	.create			= xfs_vn_create,
 	.lookup			= xfs_vn_lookup,
 	.link			= xfs_vn_link,
@@ -845,7 +845,7 @@ struct inode_operations xfs_dir_inode_op
 	.removexattr		= xfs_vn_removexattr,
 };
 
-struct inode_operations xfs_symlink_inode_operations = {
+const struct inode_operations xfs_symlink_inode_operations = {
 	.readlink		= generic_readlink,
 	.follow_link		= xfs_vn_follow_link,
 	.put_link		= xfs_vn_put_link,
Index: linux-2.6.20-rc4/fs/xfs/linux-2.6/xfs_iops.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/xfs/linux-2.6/xfs_iops.h
+++ linux-2.6.20-rc4/fs/xfs/linux-2.6/xfs_iops.h
@@ -18,9 +18,9 @@
 #ifndef __XFS_IOPS_H__
 #define __XFS_IOPS_H__
 
-extern struct inode_operations xfs_inode_operations;
-extern struct inode_operations xfs_dir_inode_operations;
-extern struct inode_operations xfs_symlink_inode_operations;
+extern const struct inode_operations xfs_inode_operations;
+extern const struct inode_operations xfs_dir_inode_operations;
+extern const struct inode_operations xfs_symlink_inode_operations;
 
 extern const struct file_operations xfs_file_operations;
 extern const struct file_operations xfs_dir_file_operations;
Index: linux-2.6.20-rc4/include/linux/coda_linux.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/coda_linux.h
+++ linux-2.6.20-rc4/include/linux/coda_linux.h
@@ -23,9 +23,9 @@
 #include <linux/coda_fs_i.h>
 
 /* operations */
-extern struct inode_operations coda_dir_inode_operations;
-extern struct inode_operations coda_file_inode_operations;
-extern struct inode_operations coda_ioctl_inode_operations;
+extern const struct inode_operations coda_dir_inode_operations;
+extern const struct inode_operations coda_file_inode_operations;
+extern const struct inode_operations coda_ioctl_inode_operations;
 
 extern const struct address_space_operations coda_file_aops;
 extern const struct address_space_operations coda_symlink_aops;
Index: linux-2.6.20-rc4/include/linux/efs_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/efs_fs.h
+++ linux-2.6.20-rc4/include/linux/efs_fs.h
@@ -36,7 +36,7 @@ static inline struct efs_sb_info *SUPER_
 
 struct statfs;
 
-extern struct inode_operations efs_dir_inode_operations;
+extern const struct inode_operations efs_dir_inode_operations;
 extern const struct file_operations efs_dir_operations;
 extern const struct address_space_operations efs_symlink_aops;
 
Index: linux-2.6.20-rc4/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/ext3_fs.h
+++ linux-2.6.20-rc4/include/linux/ext3_fs.h
@@ -868,16 +868,16 @@ do {								\
 extern const struct file_operations ext3_dir_operations;
 
 /* file.c */
-extern struct inode_operations ext3_file_inode_operations;
+extern const struct inode_operations ext3_file_inode_operations;
 extern const struct file_operations ext3_file_operations;
 
 /* namei.c */
-extern struct inode_operations ext3_dir_inode_operations;
-extern struct inode_operations ext3_special_inode_operations;
+extern const struct inode_operations ext3_dir_inode_operations;
+extern const struct inode_operations ext3_special_inode_operations;
 
 /* symlink.c */
-extern struct inode_operations ext3_symlink_inode_operations;
-extern struct inode_operations ext3_fast_symlink_inode_operations;
+extern const struct inode_operations ext3_symlink_inode_operations;
+extern const struct inode_operations ext3_fast_symlink_inode_operations;
 
 
 #endif	/* __KERNEL__ */
Index: linux-2.6.20-rc4/include/linux/ext4_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/ext4_fs.h
+++ linux-2.6.20-rc4/include/linux/ext4_fs.h
@@ -955,16 +955,16 @@ do {								\
 extern const struct file_operations ext4_dir_operations;
 
 /* file.c */
-extern struct inode_operations ext4_file_inode_operations;
+extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
 
 /* namei.c */
-extern struct inode_operations ext4_dir_inode_operations;
-extern struct inode_operations ext4_special_inode_operations;
+extern const struct inode_operations ext4_dir_inode_operations;
+extern const struct inode_operations ext4_special_inode_operations;
 
 /* symlink.c */
-extern struct inode_operations ext4_symlink_inode_operations;
-extern struct inode_operations ext4_fast_symlink_inode_operations;
+extern const struct inode_operations ext4_symlink_inode_operations;
+extern const struct inode_operations ext4_fast_symlink_inode_operations;
 
 /* extents.c */
 extern int ext4_ext_tree_init(handle_t *handle, struct inode *);
Index: linux-2.6.20-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/fs.h
+++ linux-2.6.20-rc4/include/linux/fs.h
@@ -549,7 +549,7 @@ struct inode {
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct mutex		i_mutex;
 	struct rw_semaphore	i_alloc_sem;
-	struct inode_operations	*i_op;
+	const struct inode_operations	*i_op;
 	const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct super_block	*i_sb;
 	struct file_lock	*i_flock;
@@ -1821,7 +1821,7 @@ extern void page_put_link(struct dentry 
 extern int __page_symlink(struct inode *inode, const char *symname, int len,
 		gfp_t gfp_mask);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
-extern struct inode_operations page_symlink_inode_operations;
+extern const struct inode_operations page_symlink_inode_operations;
 extern int generic_readlink(struct dentry *, char __user *, int);
 extern void generic_fillattr(struct inode *, struct kstat *);
 extern int vfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
@@ -1866,7 +1866,7 @@ extern int simple_commit_write(struct fi
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
 extern const struct file_operations simple_dir_operations;
-extern struct inode_operations simple_dir_inode_operations;
+extern const struct inode_operations simple_dir_inode_operations;
 struct tree_descr { char *name; const struct file_operations *ops; int mode; };
 struct dentry *d_alloc_name(struct dentry *, const char *);
 extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
Index: linux-2.6.20-rc4/include/linux/msdos_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/msdos_fs.h
+++ linux-2.6.20-rc4/include/linux/msdos_fs.h
@@ -234,7 +234,7 @@ struct msdos_sb_info {
 	struct fat_mount_options options;
 	struct nls_table *nls_disk;  /* Codepage used on disk */
 	struct nls_table *nls_io;    /* Charset used for input and display */
-	void *dir_ops;		     /* Opaque; default directory operations */
+	const void *dir_ops;		     /* Opaque; default directory operations */
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
 
@@ -399,7 +399,7 @@ extern int fat_count_free_clusters(struc
 extern int fat_generic_ioctl(struct inode *inode, struct file *filp,
 			     unsigned int cmd, unsigned long arg);
 extern const struct file_operations fat_file_operations;
-extern struct inode_operations fat_file_inode_operations;
+extern const struct inode_operations fat_file_inode_operations;
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 extern void fat_truncate(struct inode *inode);
 extern int fat_getattr(struct vfsmount *mnt, struct dentry *dentry,
@@ -413,7 +413,7 @@ extern struct inode *fat_build_inode(str
 			struct msdos_dir_entry *de, loff_t i_pos);
 extern int fat_sync_inode(struct inode *inode);
 extern int fat_fill_super(struct super_block *sb, void *data, int silent,
-			struct inode_operations *fs_dir_inode_ops, int isvfat);
+			const struct inode_operations *fs_dir_inode_ops, int isvfat);
 
 extern int fat_flush_inodes(struct super_block *sb, struct inode *i1,
 		            struct inode *i2);
Index: linux-2.6.20-rc4/include/linux/ncp_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/ncp_fs.h
+++ linux-2.6.20-rc4/include/linux/ncp_fs.h
@@ -204,7 +204,7 @@ void ncp_update_inode(struct inode *, st
 void ncp_update_inode2(struct inode *, struct ncp_entry_info *);
 
 /* linux/fs/ncpfs/dir.c */
-extern struct inode_operations ncp_dir_inode_operations;
+extern const struct inode_operations ncp_dir_inode_operations;
 extern const struct file_operations ncp_dir_operations;
 int ncp_conn_logged_in(struct super_block *);
 int ncp_date_dos2unix(__le16 time, __le16 date);
@@ -226,7 +226,7 @@ void ncp_lock_server(struct ncp_server *
 void ncp_unlock_server(struct ncp_server *server);
 
 /* linux/fs/ncpfs/file.c */
-extern struct inode_operations ncp_file_inode_operations;
+extern const struct inode_operations ncp_file_inode_operations;
 extern const struct file_operations ncp_file_operations;
 int ncp_make_open(struct inode *, int);
 
Index: linux-2.6.20-rc4/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/nfs_fs.h
+++ linux-2.6.20-rc4/include/linux/nfs_fs.h
@@ -330,9 +330,9 @@ static inline void nfs_fattr_init(struct
 /*
  * linux/fs/nfs/file.c
  */
-extern struct inode_operations nfs_file_inode_operations;
+extern const struct inode_operations nfs_file_inode_operations;
 #ifdef CONFIG_NFS_V3
-extern struct inode_operations nfs3_file_inode_operations;
+extern const struct inode_operations nfs3_file_inode_operations;
 #endif /* CONFIG_NFS_V3 */
 extern const struct file_operations nfs_file_operations;
 extern const struct address_space_operations nfs_file_aops;
@@ -379,9 +379,9 @@ extern ssize_t nfs_file_direct_write(str
 /*
  * linux/fs/nfs/dir.c
  */
-extern struct inode_operations nfs_dir_inode_operations;
+extern const struct inode_operations nfs_dir_inode_operations;
 #ifdef CONFIG_NFS_V3
-extern struct inode_operations nfs3_dir_inode_operations;
+extern const struct inode_operations nfs3_dir_inode_operations;
 #endif /* CONFIG_NFS_V3 */
 extern const struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
@@ -391,7 +391,7 @@ extern int nfs_instantiate(struct dentry
 /*
  * linux/fs/nfs/symlink.c
  */
-extern struct inode_operations nfs_symlink_inode_operations;
+extern const struct inode_operations nfs_symlink_inode_operations;
 
 /*
  * linux/fs/nfs/sysctl.c
@@ -408,8 +408,8 @@ extern void nfs_unregister_sysctl(void);
  * linux/fs/nfs/namespace.c
  */
 extern struct list_head nfs_automount_list;
-extern struct inode_operations nfs_mountpoint_inode_operations;
-extern struct inode_operations nfs_referral_inode_operations;
+extern const struct inode_operations nfs_mountpoint_inode_operations;
+extern const struct inode_operations nfs_referral_inode_operations;
 extern int nfs_mountpoint_expiry_timeout;
 extern void nfs_release_automount_timer(void);
 
Index: linux-2.6.20-rc4/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/nfs_xdr.h
+++ linux-2.6.20-rc4/include/linux/nfs_xdr.h
@@ -767,8 +767,8 @@ struct nfs_access_entry;
 struct nfs_rpc_ops {
 	int	version;		/* Protocol version */
 	struct dentry_operations *dentry_ops;
-	struct inode_operations *dir_inode_ops;
-	struct inode_operations *file_inode_ops;
+	const struct inode_operations *dir_inode_ops;
+	const struct inode_operations *file_inode_ops;
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
Index: linux-2.6.20-rc4/include/linux/phonedev.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/phonedev.h
+++ linux-2.6.20-rc4/include/linux/phonedev.h
@@ -9,7 +9,7 @@
 
 struct phone_device {
 	struct phone_device *next;
-	struct file_operations *f_op;
+	const struct file_operations *f_op;
 	int (*open) (struct phone_device *, struct file *);
 	int board;		/* Device private index */
 	int minor;
Index: linux-2.6.20-rc4/include/linux/proc_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/proc_fs.h
+++ linux-2.6.20-rc4/include/linux/proc_fs.h
@@ -55,7 +55,7 @@ struct proc_dir_entry {
 	uid_t uid;
 	gid_t gid;
 	loff_t size;
-	struct inode_operations * proc_iops;
+	const struct inode_operations * proc_iops;
 	const struct file_operations * proc_fops;
 	get_info_t *get_info;
 	struct module *owner;
Index: linux-2.6.20-rc4/include/linux/qnx4_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/qnx4_fs.h
+++ linux-2.6.20-rc4/include/linux/qnx4_fs.h
@@ -116,8 +116,8 @@ extern unsigned long qnx4_block_map(stru
 
 extern struct buffer_head *qnx4_bread(struct inode *, int, int);
 
-extern struct inode_operations qnx4_file_inode_operations;
-extern struct inode_operations qnx4_dir_inode_operations;
+extern const struct inode_operations qnx4_file_inode_operations;
+extern const struct inode_operations qnx4_dir_inode_operations;
 extern const struct file_operations qnx4_file_operations;
 extern const struct file_operations qnx4_dir_operations;
 extern int qnx4_is_free(struct super_block *sb, long block);
Index: linux-2.6.20-rc4/include/linux/reiserfs_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/reiserfs_fs.h
+++ linux-2.6.20-rc4/include/linux/reiserfs_fs.h
@@ -1949,9 +1949,9 @@ int reiserfs_global_version_in_proc(char
 #endif
 
 /* dir.c */
-extern struct inode_operations reiserfs_dir_inode_operations;
-extern struct inode_operations reiserfs_symlink_inode_operations;
-extern struct inode_operations reiserfs_special_inode_operations;
+extern const struct inode_operations reiserfs_dir_inode_operations;
+extern const struct inode_operations reiserfs_symlink_inode_operations;
+extern const struct inode_operations reiserfs_special_inode_operations;
 extern const struct file_operations reiserfs_dir_operations;
 
 /* tail_conversion.c */
@@ -1963,7 +1963,7 @@ int indirect2direct(struct reiserfs_tran
 void reiserfs_unmap_buffer(struct buffer_head *);
 
 /* file.c */
-extern struct inode_operations reiserfs_file_inode_operations;
+extern const struct inode_operations reiserfs_file_inode_operations;
 extern const struct file_operations reiserfs_file_operations;
 extern const struct address_space_operations reiserfs_address_space_operations;
 
Index: linux-2.6.20-rc4/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/ufs_fs.h
+++ linux-2.6.20-rc4/include/linux/ufs_fs.h
@@ -959,7 +959,7 @@ extern struct ufs_cg_private_info * ufs_
 extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
-extern struct inode_operations ufs_dir_inode_operations;
+extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, struct dentry *);
 extern int ufs_make_empty(struct inode *, struct inode *);
@@ -971,7 +971,7 @@ extern void ufs_set_link(struct inode *d
 			 struct page *page, struct inode *inode);
 
 /* file.c */
-extern struct inode_operations ufs_file_inode_operations;
+extern const struct inode_operations ufs_file_inode_operations;
 extern const struct file_operations ufs_file_operations;
 
 extern const struct address_space_operations ufs_aops;
@@ -998,7 +998,7 @@ extern void ufs_error (struct super_bloc
 extern void ufs_panic (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
 
 /* symlink.c */
-extern struct inode_operations ufs_fast_symlink_inode_operations;
+extern const struct inode_operations ufs_fast_symlink_inode_operations;
 
 /* truncate.c */
 extern int ufs_truncate (struct inode *, loff_t);


