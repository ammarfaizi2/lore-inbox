Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262301AbSI1R40>; Sat, 28 Sep 2002 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262306AbSI1R40>; Sat, 28 Sep 2002 13:56:26 -0400
Received: from mx1.airmail.net ([209.196.77.98]:21254 "EHLO mx1.airmail.net")
	by vger.kernel.org with ESMTP id <S262301AbSI1R4T>;
	Sat, 28 Sep 2002 13:56:19 -0400
Date: Sat, 28 Sep 2002 13:01:37 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patch for fs/proc
Message-ID: <20020928180137.GF22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small set of patches for fs/proc to use C99 initializers.
The patches are all against 2.5.39.

Art Haas

--- linux-2.5.39/fs/proc/base.c.old	2002-09-16 09:34:08.000000000 -0500
+++ linux-2.5.39/fs/proc/base.c	2002-09-28 10:36:29.000000000 -0500
@@ -310,7 +310,7 @@
 }
 
 static struct file_operations proc_maps_operations = {
-	read:		pid_maps_read,
+	.read		= pid_maps_read,
 };
 
 extern struct seq_operations mounts_op;
@@ -347,10 +347,10 @@
 }
 
 static struct file_operations proc_mounts_operations = {
-	open:		mounts_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	mounts_release,
+	.open		= mounts_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= mounts_release,
 };
 
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
@@ -390,7 +390,7 @@
 }
 
 static struct file_operations proc_info_file_operations = {
-	read:		proc_info_read,
+	.read		= proc_info_read,
 };
 
 #define MAY_PTRACE(p) \
@@ -509,13 +509,13 @@
 #endif
 
 static struct file_operations proc_mem_operations = {
-	read:		mem_read,
-	write:		mem_write,
-	open:		mem_open,
+	.read		= mem_read,
+	.write		= mem_write,
+	.open		= mem_open,
 };
 
 static struct inode_operations proc_mem_inode_operations = {
-	permission:	proc_permission,
+	.permission	= proc_permission,
 };
 
 static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
@@ -587,8 +587,8 @@
 }
 
 static struct inode_operations proc_pid_link_inode_operations = {
-	readlink:	proc_pid_readlink,
-	follow_link:	proc_pid_follow_link
+	.readlink	= proc_pid_readlink,
+	.follow_link	= proc_pid_follow_link
 };
 
 #define NUMBUF 10
@@ -823,21 +823,21 @@
 
 static struct dentry_operations pid_fd_dentry_operations =
 {
-	d_revalidate:	pid_fd_revalidate,
-	d_delete:	pid_delete_dentry,
+	.d_revalidate	= pid_fd_revalidate,
+	.d_delete	= pid_delete_dentry,
 };
 
 static struct dentry_operations pid_dentry_operations =
 {
-	d_revalidate:	pid_revalidate,
-	d_delete:	pid_delete_dentry,
+	.d_revalidate	= pid_revalidate,
+	.d_delete	= pid_delete_dentry,
 };
 
 static struct dentry_operations pid_base_dentry_operations =
 {
-	d_revalidate:	pid_revalidate,
-	d_iput:		pid_base_iput,
-	d_delete:	pid_delete_dentry,
+	.d_revalidate	= pid_revalidate,
+	.d_iput		= pid_base_iput,
+	.d_delete	= pid_delete_dentry,
 };
 
 /* Lookups */
@@ -918,16 +918,16 @@
 }
 
 static struct file_operations proc_fd_operations = {
-	read:		generic_read_dir,
-	readdir:	proc_readfd,
+	.read		= generic_read_dir,
+	.readdir	= proc_readfd,
 };
 
 /*
  * proc directories can do almost nothing..
  */
 static struct inode_operations proc_fd_inode_operations = {
-	lookup:		proc_lookupfd,
-	permission:	proc_permission,
+	.lookup		= proc_lookupfd,
+	.permission	= proc_permission,
 };
 
 /* SMP-safe */
@@ -1032,12 +1032,12 @@
 }
 
 static struct file_operations proc_base_operations = {
-	read:		generic_read_dir,
-	readdir:	proc_base_readdir,
+	.read		= generic_read_dir,
+	.readdir	= proc_base_readdir,
 };
 
 static struct inode_operations proc_base_inode_operations = {
-	lookup:		proc_base_lookup,
+	.lookup		= proc_base_lookup,
 };
 
 /*
@@ -1058,8 +1058,8 @@
 }	
 
 static struct inode_operations proc_self_inode_operations = {
-	readlink:	proc_self_readlink,
-	follow_link:	proc_self_follow_link,
+	.readlink	= proc_self_readlink,
+	.follow_link	= proc_self_follow_link,
 };
 
 /* SMP-safe */
--- linux-2.5.39/fs/proc/generic.c.old	2002-07-05 18:42:38.000000000 -0500
+++ linux-2.5.39/fs/proc/generic.c	2002-09-28 10:36:29.000000000 -0500
@@ -33,9 +33,9 @@
 }
 
 static struct file_operations proc_file_operations = {
-	llseek:		proc_file_lseek,
-	read:		proc_file_read,
-	write:		proc_file_write,
+	.llseek		= proc_file_lseek,
+	.read		= proc_file_read,
+	.write		= proc_file_write,
 };
 
 #ifndef MIN
@@ -230,8 +230,8 @@
 }
 
 static struct inode_operations proc_link_inode_operations = {
-	readlink:	proc_readlink,
-	follow_link:	proc_follow_link,
+	.readlink	= proc_readlink,
+	.follow_link	= proc_follow_link,
 };
 
 /*
@@ -247,7 +247,7 @@
 
 static struct dentry_operations proc_dentry_operations =
 {
-	d_delete:	proc_delete_dentry,
+	.d_delete	= proc_delete_dentry,
 };
 
 /*
@@ -359,15 +359,15 @@
  * the /proc directory.
  */
 static struct file_operations proc_dir_operations = {
-	read:			generic_read_dir,
-	readdir:		proc_readdir,
+	.read			= generic_read_dir,
+	.readdir		= proc_readdir,
 };
 
 /*
  * proc directories can do almost nothing..
  */
 static struct inode_operations proc_dir_inode_operations = {
-	lookup:		proc_lookup,
+	.lookup		= proc_lookup,
 };
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
--- linux-2.5.39/fs/proc/inode.c.old	2002-09-16 09:34:08.000000000 -0500
+++ linux-2.5.39/fs/proc/inode.c	2002-09-28 10:36:29.000000000 -0500
@@ -130,12 +130,12 @@
 }
 
 static struct super_operations proc_sops = { 
-	alloc_inode:	proc_alloc_inode,
-	destroy_inode:	proc_destroy_inode,
-	read_inode:	proc_read_inode,
-	drop_inode:	generic_delete_inode,
-	delete_inode:	proc_delete_inode,
-	statfs:		simple_statfs,
+	.alloc_inode	= proc_alloc_inode,
+	.destroy_inode	= proc_destroy_inode,
+	.read_inode	= proc_read_inode,
+	.drop_inode	= generic_delete_inode,
+	.delete_inode	= proc_delete_inode,
+	.statfs		= simple_statfs,
 };
 
 static int parse_options(char *options,uid_t *uid,gid_t *gid)
--- linux-2.5.39/fs/proc/kcore.c.old	2002-07-05 18:42:01.000000000 -0500
+++ linux-2.5.39/fs/proc/kcore.c	2002-09-28 10:36:29.000000000 -0500
@@ -30,8 +30,8 @@
 static ssize_t read_kcore(struct file *, char *, size_t, loff_t *);
 
 struct file_operations proc_kcore_operations = {
-	read:		read_kcore,
-	open:		open_kcore,
+	.read		= read_kcore,
+	.open		= open_kcore,
 };
 
 #ifdef CONFIG_KCORE_AOUT
--- linux-2.5.39/fs/proc/kmsg.c.old	2002-07-05 18:42:23.000000000 -0500
+++ linux-2.5.39/fs/proc/kmsg.c	2002-09-28 10:36:29.000000000 -0500
@@ -46,8 +46,8 @@
 
 
 struct file_operations proc_kmsg_operations = {
-	read:		kmsg_read,
-	poll:		kmsg_poll,
-	open:		kmsg_open,
-	release:	kmsg_release,
+	.read		= kmsg_read,
+	.poll		= kmsg_poll,
+	.open		= kmsg_open,
+	.release	= kmsg_release,
 };
--- linux-2.5.39/fs/proc/proc_misc.c.old	2002-09-20 12:36:46.000000000 -0500
+++ linux-2.5.39/fs/proc/proc_misc.c	2002-09-28 10:36:29.000000000 -0500
@@ -232,10 +232,10 @@
 	return seq_open(file, &cpuinfo_op);
 }
 static struct file_operations proc_cpuinfo_operations = {
-	open:		cpuinfo_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= cpuinfo_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 #ifdef CONFIG_PROC_HARDWARE
@@ -262,10 +262,10 @@
 	return seq_open(file, &partitions_op);
 }
 static struct file_operations proc_partitions_operations = {
-	open:		partitions_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= partitions_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 #ifdef CONFIG_MODULES
@@ -275,10 +275,10 @@
 	return seq_open(file, &modules_op);
 }
 static struct file_operations proc_modules_operations = {
-	open:		modules_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= modules_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 extern struct seq_operations ksyms_op;
 static int ksyms_open(struct inode *inode, struct file *file)
@@ -286,10 +286,10 @@
 	return seq_open(file, &ksyms_op);
 }
 static struct file_operations proc_ksyms_operations = {
-	open:		ksyms_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= ksyms_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 #endif
 
@@ -300,11 +300,11 @@
 	return seq_open(file, &slabinfo_op);
 }
 static struct file_operations proc_slabinfo_operations = {
-	open:		slabinfo_open,
-	read:		seq_read,
-	write:		slabinfo_write,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= slabinfo_open,
+	.read		= seq_read,
+	.write		= slabinfo_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 static int kstat_read_proc(char *page, char **start, off_t off,
@@ -442,10 +442,10 @@
 	return res;
 }
 static struct file_operations proc_interrupts_operations = {
-	open:		interrupts_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	single_release,
+	.open		= interrupts_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
 };
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
@@ -573,8 +573,8 @@
 }
 
 static struct file_operations proc_profile_operations = {
-	read:		read_profile,
-	write:		write_profile,
+	.read		= read_profile,
+	.write		= write_profile,
 };
 
 struct proc_dir_entry *proc_root_kcore;
--- linux-2.5.39/fs/proc/root.c.old	2002-07-05 18:42:33.000000000 -0500
+++ linux-2.5.39/fs/proc/root.c	2002-09-28 10:36:29.000000000 -0500
@@ -31,9 +31,9 @@
 }
 
 static struct file_system_type proc_fs_type = {
-	name:		"proc",
-	get_sb:		proc_get_sb,
-	kill_sb:	kill_anon_super,
+	.name		= "proc",
+	.get_sb		= proc_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 extern int __init proc_init_inodecache(void);
@@ -122,29 +122,29 @@
  * directory handling functions for that..
  */
 static struct file_operations proc_root_operations = {
-	read:		 generic_read_dir,
-	readdir:	 proc_root_readdir,
+	.read		 = generic_read_dir,
+	.readdir	 = proc_root_readdir,
 };
 
 /*
  * proc root can do almost nothing..
  */
 static struct inode_operations proc_root_inode_operations = {
-	lookup:		proc_root_lookup,
+	.lookup		= proc_root_lookup,
 };
 
 /*
  * This is the root "inode" in the /proc tree..
  */
 struct proc_dir_entry proc_root = {
-	low_ino:	PROC_ROOT_INO, 
-	namelen:	5, 
-	name:		"/proc",
-	mode:		S_IFDIR | S_IRUGO | S_IXUGO, 
-	nlink:		2, 
-	proc_iops:	&proc_root_inode_operations, 
-	proc_fops:	&proc_root_operations,
-	parent:		&proc_root,
+	.low_ino	= PROC_ROOT_INO, 
+	.namelen	= 5, 
+	.name		= "/proc",
+	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
+	.nlink		= 2, 
+	.proc_iops	= &proc_root_inode_operations, 
+	.proc_fops	= &proc_root_operations,
+	.parent		= &proc_root,
 };
 
 #ifdef CONFIG_SYSCTL
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
