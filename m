Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318719AbSH1Fco>; Wed, 28 Aug 2002 01:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSH1Fco>; Wed, 28 Aug 2002 01:32:44 -0400
Received: from dp.samba.org ([66.70.73.150]:5524 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318719AbSH1Fc3>;
	Wed, 28 Aug 2002 01:32:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, viro@math.psu.edu
Subject: [PATCH] Designated initializers for generic fs bits
Date: Wed, 28 Aug 2002 15:32:24 +1000
Message-Id: <20020828003711.1B8C52C0B7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Designated initializers for core fs code.
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/bad_inode.c .23095-linux-2.5.32.updated/fs/bad_inode.c
--- .23095-linux-2.5.32/fs/bad_inode.c	2002-05-25 14:34:50.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/bad_inode.c	2002-08-28 14:34:14.000000000 +1000
@@ -30,37 +30,37 @@ static int return_EIO(void)
 
 static struct file_operations bad_file_ops =
 {
-	llseek:		EIO_ERROR,
-	read:		EIO_ERROR,
-	write:		EIO_ERROR,
-	readdir:	EIO_ERROR,
-	poll:		EIO_ERROR,
-	ioctl:		EIO_ERROR,
-	mmap:		EIO_ERROR,
-	open:		EIO_ERROR,
-	flush:		EIO_ERROR,
-	release:	EIO_ERROR,
-	fsync:		EIO_ERROR,
-	fasync:		EIO_ERROR,
-	lock:		EIO_ERROR,
+	.llseek		= EIO_ERROR,
+	.read		= EIO_ERROR,
+	.write		= EIO_ERROR,
+	.readdir	= EIO_ERROR,
+	.poll		= EIO_ERROR,
+	.ioctl		= EIO_ERROR,
+	.mmap		= EIO_ERROR,
+	.open		= EIO_ERROR,
+	.flush		= EIO_ERROR,
+	.release	= EIO_ERROR,
+	.fsync		= EIO_ERROR,
+	.fasync		= EIO_ERROR,
+	.lock		= EIO_ERROR,
 };
 
 struct inode_operations bad_inode_ops =
 {
-	create:		EIO_ERROR,
-	lookup:		EIO_ERROR,
-	link:		EIO_ERROR,
-	unlink:		EIO_ERROR,
-	symlink:	EIO_ERROR,
-	mkdir:		EIO_ERROR,
-	rmdir:		EIO_ERROR,
-	mknod:		EIO_ERROR,
-	rename:		EIO_ERROR,
-	readlink:	EIO_ERROR,
-	follow_link:	bad_follow_link,
-	truncate:	EIO_ERROR,
-	permission:	EIO_ERROR,
-	getattr:	EIO_ERROR,
+	.create		= EIO_ERROR,
+	.lookup		= EIO_ERROR,
+	.link		= EIO_ERROR,
+	.unlink		= EIO_ERROR,
+	.symlink	= EIO_ERROR,
+	.mkdir		= EIO_ERROR,
+	.rmdir		= EIO_ERROR,
+	.mknod		= EIO_ERROR,
+	.rename		= EIO_ERROR,
+	.readlink	= EIO_ERROR,
+	.follow_link	= bad_follow_link,
+	.truncate	= EIO_ERROR,
+	.permission	= EIO_ERROR,
+	.getattr	= EIO_ERROR,
 };
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/binfmt_aout.c .23095-linux-2.5.32.updated/fs/binfmt_aout.c
--- .23095-linux-2.5.32/fs/binfmt_aout.c	2002-05-25 14:34:50.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/binfmt_aout.c	2002-08-28 14:34:14.000000000 +1000
@@ -37,11 +37,11 @@ static int aout_core_dump(long signr, st
 extern void dump_thread(struct pt_regs *, struct user *);
 
 static struct linux_binfmt aout_format = {
-	module:		THIS_MODULE,
-	load_binary:	load_aout_binary,
-	load_shlib:	load_aout_library,
-	core_dump:	aout_core_dump,
-	min_coredump:	PAGE_SIZE
+	.module		= THIS_MODULE,
+	.load_binary	= load_aout_binary,
+	.load_shlib	= load_aout_library,
+	.core_dump	= aout_core_dump,
+	.min_coredump	= PAGE_SIZE
 };
 
 static void set_brk(unsigned long start, unsigned long end)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/binfmt_elf.c .23095-linux-2.5.32.updated/fs/binfmt_elf.c
--- .23095-linux-2.5.32/fs/binfmt_elf.c	2002-08-02 11:15:09.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/binfmt_elf.c	2002-08-28 14:34:14.000000000 +1000
@@ -75,11 +75,11 @@ static int elf_core_dump(long signr, str
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
 
 static struct linux_binfmt elf_format = {
-		module:		THIS_MODULE,
-		load_binary:	load_elf_binary,
-		load_shlib:	load_elf_library,
-		core_dump:	elf_core_dump,
-		min_coredump:	ELF_EXEC_PAGESIZE
+		.module		= THIS_MODULE,
+		.load_binary	= load_elf_binary,
+		.load_shlib	= load_elf_library,
+		.core_dump	= elf_core_dump,
+		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/binfmt_em86.c .23095-linux-2.5.32.updated/fs/binfmt_em86.c
--- .23095-linux-2.5.32/fs/binfmt_em86.c	2002-06-03 12:21:26.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/binfmt_em86.c	2002-08-28 14:34:14.000000000 +1000
@@ -96,8 +96,8 @@ static int load_em86(struct linux_binprm
 }
 
 struct linux_binfmt em86_format = {
-	module:		THIS_MODULE,
-	load_binary:	load_em86,
+	.module		= THIS_MODULE,
+	.load_binary	= load_em86,
 };
 
 static int __init init_em86_binfmt(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/binfmt_misc.c .23095-linux-2.5.32.updated/fs/binfmt_misc.c
--- .23095-linux-2.5.32/fs/binfmt_misc.c	2002-06-10 16:03:53.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/binfmt_misc.c	2002-08-28 14:34:14.000000000 +1000
@@ -485,8 +485,8 @@ static ssize_t bm_entry_write(struct fil
 }
 
 static struct file_operations bm_entry_operations = {
-	read:		bm_entry_read,
-	write:		bm_entry_write,
+	.read		= bm_entry_read,
+	.write		= bm_entry_write,
 };
 
 static struct file_system_type bm_fs_type;
@@ -566,7 +566,7 @@ out:
 }
 
 static struct file_operations bm_register_operations = {
-	write:		bm_register_write,
+	.write		= bm_register_write,
 };
 
 /* /status */
@@ -613,16 +613,16 @@ static ssize_t bm_status_write(struct fi
 }
 
 static struct file_operations bm_status_operations = {
-	read:		bm_status_read,
-	write:		bm_status_write,
+	.read		= bm_status_read,
+	.write		= bm_status_write,
 };
 
 /* Superblock handling */
 
 static struct super_operations s_ops = {
-	statfs:		simple_statfs,
-	drop_inode:	generic_delete_inode,
-	clear_inode:	bm_clear_inode,
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.clear_inode	= bm_clear_inode,
 };
 
 static int bm_fill_super(struct super_block * sb, void * data, int silent)
@@ -688,15 +688,15 @@ static struct super_block *bm_get_sb(str
 }
 
 static struct linux_binfmt misc_format = {
-	module: THIS_MODULE,
-	load_binary: load_misc_binary,
+	.module = THIS_MODULE,
+	.load_binary = load_misc_binary,
 };
 
 static struct file_system_type bm_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"binfmt_misc",
-	get_sb:		bm_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner		= THIS_MODULE,
+	.name		= "binfmt_misc",
+	.get_sb		= bm_get_sb,
+	.kill_sb	= kill_litter_super,
 };
 
 static int __init init_misc_binfmt(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/binfmt_script.c .23095-linux-2.5.32.updated/fs/binfmt_script.c
--- .23095-linux-2.5.32/fs/binfmt_script.c	2002-06-03 12:21:26.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/binfmt_script.c	2002-08-28 14:34:14.000000000 +1000
@@ -95,8 +95,8 @@ static int load_script(struct linux_binp
 }
 
 struct linux_binfmt script_format = {
-	module:		THIS_MODULE,
-	load_binary:	load_script,
+	.module		= THIS_MODULE,
+	.load_binary	= load_script,
 };
 
 static int __init init_script_binfmt(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/block_dev.c .23095-linux-2.5.32.updated/fs/block_dev.c
--- .23095-linux-2.5.32/fs/block_dev.c	2002-08-28 09:29:49.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/block_dev.c	2002-08-28 14:38:06.000000000 +1000
@@ -198,9 +198,9 @@ static struct super_block *bd_get_sb(str
 }
 
 static struct file_system_type bd_type = {
-	name:		"bdev",
-	get_sb:		bd_get_sb,
-	kill_sb:	kill_anon_super,
+	.name		= "bdev",
+	.get_sb		= bd_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static struct vfsmount *bd_mnt;
@@ -859,26 +859,26 @@ static int blkdev_ioctl(struct inode *in
 }
 
 struct address_space_operations def_blk_aops = {
-	readpage: blkdev_readpage,
-	writepage: blkdev_writepage,
-	sync_page: block_sync_page,
-	prepare_write: blkdev_prepare_write,
-	commit_write: blkdev_commit_write,
-	writepages: generic_writepages,
-	vm_writeback: generic_vm_writeback,
-	direct_IO: blkdev_direct_IO,
+	.readpage	= blkdev_readpage,
+	.writepage	= blkdev_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= blkdev_prepare_write,
+	.commit_write	= blkdev_commit_write,
+	.writepages	= generic_writepages,
+	.vm_writeback	= generic_vm_writeback,
+	.direct_IO	= blkdev_direct_IO,
 };
 
 struct file_operations def_blk_fops = {
-	open:		blkdev_open,
-	release:	blkdev_close,
-	llseek:		block_llseek,
-	read:		generic_file_read,
-	write:		generic_file_write_nolock,
-	mmap:		generic_file_mmap,
-	fsync:		block_fsync,
-	ioctl:		blkdev_ioctl,
-	sendfile:	generic_file_sendfile,
+	.open		= blkdev_open,
+	.release	= blkdev_close,
+	.llseek		= block_llseek,
+	.read		= generic_file_read,
+	.write		= generic_file_write_nolock,
+	.mmap		= generic_file_mmap,
+	.fsync		= block_fsync,
+	.ioctl		= blkdev_ioctl,
+	.sendfile	= generic_file_sendfile,
 };
 
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/devices.c .23095-linux-2.5.32.updated/fs/devices.c
--- .23095-linux-2.5.32/fs/devices.c	2002-08-02 11:15:09.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/devices.c	2002-08-28 14:34:14.000000000 +1000
@@ -168,7 +168,7 @@ int chrdev_open(struct inode * inode, st
  * depending on the special file...
  */
 static struct file_operations def_chr_fops = {
-	open:		chrdev_open,
+	.open		= chrdev_open,
 };
 
 /*
@@ -199,7 +199,7 @@ static int sock_no_open(struct inode *ir
 }
 
 static struct file_operations bad_sock_fops = {
-	open:		sock_no_open
+	.open		= sock_no_open
 };
 
 void init_special_inode(struct inode *inode, umode_t mode, int rdev)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/dquot.c .23095-linux-2.5.32.updated/fs/dquot.c
--- .23095-linux-2.5.32/fs/dquot.c	2002-07-27 15:24:39.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/dquot.c	2002-08-28 14:34:14.000000000 +1000
@@ -1211,13 +1211,13 @@ warn_put_all:
  * Definitions of diskquota operations.
  */
 struct dquot_operations dquot_operations = {
-	initialize:	dquot_initialize,		/* mandatory */
-	drop:		dquot_drop,			/* mandatory */
-	alloc_space:	dquot_alloc_space,
-	alloc_inode:	dquot_alloc_inode,
-	free_space:	dquot_free_space,
-	free_inode:	dquot_free_inode,
-	transfer:	dquot_transfer
+	.initialize	= dquot_initialize,		/* mandatory */
+	.drop		= dquot_drop,			/* mandatory */
+	.alloc_space	= dquot_alloc_space,
+	.alloc_inode	= dquot_alloc_inode,
+	.free_space	= dquot_free_space,
+	.free_inode	= dquot_free_inode,
+	.transfer	= dquot_transfer
 };
 
 static inline void set_enable_flags(struct quota_info *dqopt, int type)
@@ -1471,13 +1471,13 @@ int vfs_set_dqinfo(struct super_block *s
 }
 
 struct quotactl_ops vfs_quotactl_ops = {
-	quota_on:	vfs_quota_on,
-	quota_off:	vfs_quota_off,
-	quota_sync:	vfs_quota_sync,
-	get_info:	vfs_get_dqinfo,
-	set_info:	vfs_set_dqinfo,
-	get_dqblk:	vfs_get_dqblk,
-	set_dqblk:	vfs_set_dqblk
+	.quota_on	= vfs_quota_on,
+	.quota_off	= vfs_quota_off,
+	.quota_sync	= vfs_quota_sync,
+	.get_info	= vfs_get_dqinfo,
+	.set_info	= vfs_set_dqinfo,
+	.get_dqblk	= vfs_get_dqblk,
+	.set_dqblk	= vfs_set_dqblk
 };
 
 static ctl_table fs_dqstats_table[] = {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/fifo.c .23095-linux-2.5.32.updated/fs/fifo.c
--- .23095-linux-2.5.32/fs/fifo.c	2002-02-20 17:56:39.000000000 +1100
+++ .23095-linux-2.5.32.updated/fs/fifo.c	2002-08-28 14:34:14.000000000 +1000
@@ -154,5 +154,5 @@ err_nolock_nocleanup:
  * depending on the access mode of the file...
  */
 struct file_operations def_fifo_fops = {
-	open:		fifo_open,	/* will set read or write pipe_fops */
+	.open		= fifo_open,	/* will set read or write pipe_fops */
 };
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/libfs.c .23095-linux-2.5.32.updated/fs/libfs.c
--- .23095-linux-2.5.32/fs/libfs.c	2002-07-07 02:12:23.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/libfs.c	2002-08-28 14:34:14.000000000 +1000
@@ -151,15 +151,15 @@ ssize_t generic_read_dir(struct file *fi
 }
 
 struct file_operations simple_dir_operations = {
-	open:		dcache_dir_open,
-	release:	dcache_dir_close,
-	llseek:		dcache_dir_lseek,
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= dcache_readdir,
 };
 
 struct inode_operations simple_dir_inode_operations = {
-	lookup:		simple_lookup,
+	.lookup		= simple_lookup,
 };
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/namei.c .23095-linux-2.5.32.updated/fs/namei.c
--- .23095-linux-2.5.32/fs/namei.c	2002-07-27 15:24:39.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/namei.c	2002-08-28 14:34:14.000000000 +1000
@@ -2229,6 +2229,6 @@ fail:
 }
 
 struct inode_operations page_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
 };
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/namespace.c .23095-linux-2.5.32.updated/fs/namespace.c
--- .23095-linux-2.5.32/fs/namespace.c	2002-07-27 15:24:39.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/namespace.c	2002-08-28 14:34:14.000000000 +1000
@@ -239,10 +239,10 @@ static int show_vfsmnt(struct seq_file *
 }
 
 struct seq_operations mounts_op = {
-	start:	m_start,
-	next:	m_next,
-	stop:	m_stop,
-	show:	show_vfsmnt
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_vfsmnt
 };
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/pipe.c .23095-linux-2.5.32.updated/fs/pipe.c
--- .23095-linux-2.5.32/fs/pipe.c	2002-07-17 10:25:51.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/pipe.c	2002-08-28 14:34:14.000000000 +1000
@@ -444,69 +444,69 @@ pipe_rdwr_open(struct inode *inode, stru
  * are also used in linux/fs/fifo.c to do operations on FIFOs.
  */
 struct file_operations read_fifo_fops = {
-	llseek:		no_llseek,
-	read:		pipe_read,
-	write:		bad_pipe_w,
-	poll:		fifo_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_read_open,
-	release:	pipe_read_release,
-	fasync:         pipe_read_fasync,
+	.llseek		= no_llseek,
+	.read		= pipe_read,
+	.write		= bad_pipe_w,
+	.poll		= fifo_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_read_open,
+	.release	= pipe_read_release,
+	.fasync         = pipe_read_fasync,
 };
 
 struct file_operations write_fifo_fops = {
-	llseek:		no_llseek,
-	read:		bad_pipe_r,
-	write:		pipe_write,
-	poll:		fifo_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_write_open,
-	release:	pipe_write_release,
-	fasync:         pipe_write_fasync,
+	.llseek		= no_llseek,
+	.read		= bad_pipe_r,
+	.write		= pipe_write,
+	.poll		= fifo_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_write_open,
+	.release	= pipe_write_release,
+	.fasync         = pipe_write_fasync,
 };
 
 struct file_operations rdwr_fifo_fops = {
-	llseek:		no_llseek,
-	read:		pipe_read,
-	write:		pipe_write,
-	poll:		fifo_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_rdwr_open,
-	release:	pipe_rdwr_release,
-	fasync:         pipe_rdwr_fasync,
+	.llseek		= no_llseek,
+	.read		= pipe_read,
+	.write		= pipe_write,
+	.poll		= fifo_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_rdwr_open,
+	.release	= pipe_rdwr_release,
+	.fasync         = pipe_rdwr_fasync,
 };
 
 struct file_operations read_pipe_fops = {
-	llseek:		no_llseek,
-	read:		pipe_read,
-	write:		bad_pipe_w,
-	poll:		pipe_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_read_open,
-	release:	pipe_read_release,
-	fasync:         pipe_read_fasync,
+	.llseek		= no_llseek,
+	.read		= pipe_read,
+	.write		= bad_pipe_w,
+	.poll		= pipe_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_read_open,
+	.release	= pipe_read_release,
+	.fasync         = pipe_read_fasync,
 };
 
 struct file_operations write_pipe_fops = {
-	llseek:		no_llseek,
-	read:		bad_pipe_r,
-	write:		pipe_write,
-	poll:		pipe_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_write_open,
-	release:	pipe_write_release,
-	fasync:         pipe_write_fasync,
+	.llseek		= no_llseek,
+	.read		= bad_pipe_r,
+	.write		= pipe_write,
+	.poll		= pipe_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_write_open,
+	.release	= pipe_write_release,
+	.fasync         = pipe_write_fasync,
 };
 
 struct file_operations rdwr_pipe_fops = {
-	llseek:		no_llseek,
-	read:		pipe_read,
-	write:		pipe_write,
-	poll:		pipe_poll,
-	ioctl:		pipe_ioctl,
-	open:		pipe_rdwr_open,
-	release:	pipe_rdwr_release,
-	fasync:         pipe_rdwr_fasync,
+	.llseek		= no_llseek,
+	.read		= pipe_read,
+	.write		= pipe_write,
+	.poll		= pipe_poll,
+	.ioctl		= pipe_ioctl,
+	.open		= pipe_rdwr_open,
+	.release	= pipe_rdwr_release,
+	.fasync         = pipe_rdwr_fasync,
 };
 
 struct inode* pipe_new(struct inode* inode)
@@ -541,7 +541,7 @@ static int pipefs_delete_dentry(struct d
 	return 1;
 }
 static struct dentry_operations pipefs_dentry_operations = {
-	d_delete:	pipefs_delete_dentry,
+	.d_delete	= pipefs_delete_dentry,
 };
 
 static struct inode * get_pipe_inode(void)
@@ -672,9 +672,9 @@ static struct super_block *pipefs_get_sb
 }
 
 static struct file_system_type pipe_fs_type = {
-	name:		"pipefs",
-	get_sb:		pipefs_get_sb,
-	kill_sb:	kill_anon_super,
+	.name		= "pipefs",
+	.get_sb		= pipefs_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static int __init init_pipe_fs(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/quota_v1.c .23095-linux-2.5.32.updated/fs/quota_v1.c
--- .23095-linux-2.5.32/fs/quota_v1.c	2002-06-17 23:19:24.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/quota_v1.c	2002-08-28 14:34:14.000000000 +1000
@@ -210,18 +210,18 @@ out:
 }
 
 static struct quota_format_ops v1_format_ops = {
-	check_quota_file:	v1_check_quota_file,
-	read_file_info:		v1_read_file_info,
-	write_file_info:	v1_write_file_info,
-	free_file_info:		NULL,
-	read_dqblk:		v1_read_dqblk,
-	commit_dqblk:		v1_commit_dqblk,
+	.check_quota_file	= v1_check_quota_file,
+	.read_file_info		= v1_read_file_info,
+	.write_file_info	= v1_write_file_info,
+	.free_file_info		= NULL,
+	.read_dqblk		= v1_read_dqblk,
+	.commit_dqblk		= v1_commit_dqblk,
 };
 
 static struct quota_format_type v1_quota_format = {
-	qf_fmt_id:	QFMT_VFS_OLD,
-	qf_ops:		&v1_format_ops,
-	qf_owner:	THIS_MODULE
+	.qf_fmt_id	= QFMT_VFS_OLD,
+	.qf_ops		= &v1_format_ops,
+	.qf_owner	= THIS_MODULE
 };
 
 static int __init init_v1_quota_format(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/quota_v2.c .23095-linux-2.5.32.updated/fs/quota_v2.c
--- .23095-linux-2.5.32/fs/quota_v2.c	2002-07-17 10:25:51.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/quota_v2.c	2002-08-28 14:34:14.000000000 +1000
@@ -662,18 +662,18 @@ static int v2_commit_dquot(struct dquot 
 }
 
 static struct quota_format_ops v2_format_ops = {
-	check_quota_file:	v2_check_quota_file,
-	read_file_info:		v2_read_file_info,
-	write_file_info:	v2_write_file_info,
-	free_file_info:		NULL,
-	read_dqblk:		v2_read_dquot,
-	commit_dqblk:		v2_commit_dquot,
+	.check_quota_file	= v2_check_quota_file,
+	.read_file_info		= v2_read_file_info,
+	.write_file_info	= v2_write_file_info,
+	.free_file_info		= NULL,
+	.read_dqblk		= v2_read_dquot,
+	.commit_dqblk		= v2_commit_dquot,
 };
 
 static struct quota_format_type v2_quota_format = {
-	qf_fmt_id:	QFMT_VFS_V0,
-	qf_ops:		&v2_format_ops,
-	qf_owner:	THIS_MODULE
+	.qf_fmt_id	= QFMT_VFS_V0,
+	.qf_ops		= &v2_format_ops,
+	.qf_owner	= THIS_MODULE
 };
 
 static int __init init_v2_quota_format(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23095-linux-2.5.32/fs/read_write.c .23095-linux-2.5.32.updated/fs/read_write.c
--- .23095-linux-2.5.32/fs/read_write.c	2002-08-02 11:15:09.000000000 +1000
+++ .23095-linux-2.5.32.updated/fs/read_write.c	2002-08-28 14:34:14.000000000 +1000
@@ -16,10 +16,10 @@
 #include <asm/uaccess.h>
 
 struct file_operations generic_ro_fops = {
-	llseek:		generic_file_llseek,
-	read:		generic_file_read,
-	mmap:		generic_file_mmap,
-	sendfile:	generic_file_sendfile,
+	.llseek		= generic_file_llseek,
+	.read		= generic_file_read,
+	.mmap		= generic_file_mmap,
+	.sendfile	= generic_file_sendfile,
 };
 
 loff_t generic_file_llseek(struct file *file, loff_t offset, int origin)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
