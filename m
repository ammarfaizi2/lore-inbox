Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbTJAVIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbTJAVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:08:49 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:46090 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262557AbTJAVH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:07:57 -0400
Date: Wed, 1 Oct 2003 18:14:05 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] Take 3 of nuking kernel/ksyms.c
Message-ID: <20031001211405.GO964@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please pull from:

bk://kernel.bkbits.net/acme/ksyms-2.6

Thanks,

- Arnaldo

===================================================================


ChangeSet@1.1362, 2003-10-01 20:26:23-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/seq_file.c

ChangeSet@1.1361, 2003-10-01 20:20:46-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/exec.c

ChangeSet@1.1360, 2003-10-01 20:12:48-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/inode.c

ChangeSet@1.1359, 2003-10-01 19:56:11-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to kernel/sysctl.c

ChangeSet@1.1358, 2003-10-01 19:36:58-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/super.c

ChangeSet@1.1357, 2003-10-01 19:16:46-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/block_dev.c

 fs/block_dev.c  |   32 ++++++++++++++++++++
 fs/exec.c       |   26 ++++++++++++++++
 fs/inode.c      |   43 +++++++++++++++++++++------
 fs/seq_file.c   |   27 +++++++++++++++--
 fs/super.c      |   29 ++++++++++++++++++
 kernel/ksyms.c  |   88 --------------------------------------------------------
 kernel/sysctl.c |   17 ++++++++++
 7 files changed, 162 insertions(+), 100 deletions(-)


diff -Nru a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Wed Oct  1 20:59:02 2003
+++ b/fs/block_dev.c	Wed Oct  1 20:59:02 2003
@@ -70,6 +70,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(set_blocksize);
+
 int sb_set_blocksize(struct super_block *sb, int size)
 {
 	int bits;
@@ -82,6 +84,8 @@
 	return sb->s_blocksize;
 }
 
+EXPORT_SYMBOL(sb_set_blocksize);
+
 int sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_hardsect_size(sb->s_bdev);
@@ -90,6 +94,8 @@
 	return sb_set_blocksize(sb, size);
 }
 
+EXPORT_SYMBOL(sb_min_blocksize);
+
 static int
 blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
@@ -358,6 +364,8 @@
 	return bdev;
 }
 
+EXPORT_SYMBOL(bdget);
+
 long nr_blockdev_pages(void)
 {
 	struct list_head *p;
@@ -376,6 +384,8 @@
 {
 	iput(bdev->bd_inode);
 }
+
+EXPORT_SYMBOL(bdput);
  
 int bd_acquire(struct inode *inode)
 {
@@ -444,6 +454,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(bd_claim);
+
 void bd_release(struct block_device *bdev)
 {
 	spin_lock(&bdev_lock);
@@ -454,6 +466,8 @@
 	spin_unlock(&bdev_lock);
 }
 
+EXPORT_SYMBOL(bd_release);
+
 /*
  * Tries to open block device by device number.  Use it ONLY if you
  * really do not have anything better - i.e. when you are behind a
@@ -471,6 +485,8 @@
 	return err ? ERR_PTR(err) : bdev;
 }
 
+EXPORT_SYMBOL(open_by_devnum);
+
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
@@ -500,6 +516,8 @@
 	return 1;
 }
 
+EXPORT_SYMBOL(check_disk_change);
+
 static void bd_set_size(struct block_device *bdev, loff_t size)
 {
 	unsigned bsize = bdev_hardsect_size(bdev);
@@ -632,6 +650,8 @@
 	return do_open(bdev, bdev->bd_inode, &fake_file);
 }
 
+EXPORT_SYMBOL(blkdev_get);
+
 int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
@@ -662,6 +682,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(blkdev_open);
+
 int blkdev_put(struct block_device *bdev, int kind)
 {
 	int ret = 0;
@@ -710,6 +732,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(blkdev_put);
+
 int blkdev_close(struct inode * inode, struct file * filp)
 {
 	if (inode->i_bdev->bd_holder == filp)
@@ -760,6 +784,8 @@
 	.sendfile	= generic_file_sendfile,
 };
 
+EXPORT_SYMBOL(def_blk_fops);
+
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 {
 	int res;
@@ -770,6 +796,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(ioctl_by_bdev);
+
 /**
  * lookup_bdev  - lookup a struct block_device by name
  *
@@ -854,6 +882,8 @@
 	return ERR_PTR(error);
 }
 
+EXPORT_SYMBOL(open_bdev_excl);
+
 /**
  * close_bdev_excl  -  release a blockdevice openen by open_bdev_excl()
  *
@@ -867,3 +897,5 @@
 	bd_release(bdev);
 	blkdev_put(bdev, kind);
 }
+
+EXPORT_SYMBOL(close_bdev_excl);
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Wed Oct  1 20:59:02 2003
+++ b/fs/exec.c	Wed Oct  1 20:59:02 2003
@@ -83,6 +83,8 @@
 	return 0;	
 }
 
+EXPORT_SYMBOL(register_binfmt);
+
 int unregister_binfmt(struct linux_binfmt * fmt)
 {
 	struct linux_binfmt ** tmp = &formats;
@@ -100,6 +102,8 @@
 	return -EINVAL;
 }
 
+EXPORT_SYMBOL(unregister_binfmt);
+
 static inline void put_binfmt(struct linux_binfmt * fmt)
 {
 	module_put(fmt->module);
@@ -281,6 +285,8 @@
 	return r;
 }
 
+EXPORT_SYMBOL(copy_strings_kernel);
+
 #ifdef CONFIG_MMU
 /*
  * This routine is used to map in a page into an address space: needed by
@@ -443,6 +449,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(setup_arg_pages);
+
 #define free_arg_pages(bprm) do { } while (0)
 
 #else
@@ -493,6 +501,8 @@
 	goto out;
 }
 
+EXPORT_SYMBOL(open_exec);
+
 int kernel_read(struct file *file, unsigned long offset,
 	char *addr, unsigned long count)
 {
@@ -508,6 +518,8 @@
 	return result;
 }
 
+EXPORT_SYMBOL(kernel_read);
+
 static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
@@ -822,6 +834,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(flush_old_exec);
+
 /*
  * We mustn't allow tracing of suid binaries, unless
  * the tracer has the capability to trace anything..
@@ -878,6 +892,8 @@
 	return kernel_read(bprm->file,0,bprm->buf,BINPRM_BUF_SIZE);
 }
 
+EXPORT_SYMBOL(prepare_binprm);
+
 /*
  * This function is used to produce the new IDs and capabilities
  * from the old ones and the file's capabilities.
@@ -918,6 +934,8 @@
 	security_bprm_compute_creds(bprm);
 }
 
+EXPORT_SYMBOL(compute_creds);
+
 void remove_arg_zero(struct linux_binprm *bprm)
 {
 	if (bprm->argc) {
@@ -942,6 +960,8 @@
 	}
 }
 
+EXPORT_SYMBOL(remove_arg_zero);
+
 /*
  * cycle the list of binary formats handler, until one recognizes the image
  */
@@ -1037,6 +1057,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(search_binary_handler);
+
 /*
  * sys_execve() executes a new program.
  */
@@ -1133,6 +1155,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(do_execve);
+
 int set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
@@ -1146,6 +1170,8 @@
 		module_put(old->module);
 	return 0;
 }
+
+EXPORT_SYMBOL(set_binfmt);
 
 #define CORENAME_MAX_SIZE 64
 
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Wed Oct  1 20:59:02 2003
+++ b/fs/inode.c	Wed Oct  1 20:59:02 2003
@@ -195,6 +195,8 @@
 	i_size_ordered_init(inode);
 }
 
+EXPORT_SYMBOL(inode_init_once);
+
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct inode * inode = (struct inode *) foo;
@@ -229,7 +231,6 @@
  * that the inode is no longer useful. We just
  * terminate it with extreme prejudice.
  */
- 
 void clear_inode(struct inode *inode)
 {
 	invalidate_inode_buffers(inode);
@@ -251,6 +252,8 @@
 	inode->i_state = I_CLEAR;
 }
 
+EXPORT_SYMBOL(clear_inode);
+
 /*
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
@@ -327,7 +330,6 @@
  *	fails because there are busy inodes then a non zero value is returned.
  *	If the discard is successful all the inodes have been discarded.
  */
- 
 int invalidate_inodes(struct super_block * sb)
 {
 	int busy;
@@ -346,6 +348,8 @@
 
 	return busy;
 }
+
+EXPORT_SYMBOL(invalidate_inodes);
  
 int __invalidate_device(struct block_device *bdev, int do_sync)
 {
@@ -372,6 +376,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(__invalidate_device);
+
 static int can_unuse(struct inode *inode)
 {
 	if (inode->i_state)
@@ -532,7 +538,6 @@
  *
  *	Allocates a new inode for given superblock.
  */
- 
 struct inode *new_inode(struct super_block *sb)
 {
 	static unsigned long last_ino;
@@ -552,6 +557,8 @@
 	return inode;
 }
 
+EXPORT_SYMBOL(new_inode);
+
 void unlock_new_inode(struct inode *inode)
 {
 	/*
@@ -565,6 +572,7 @@
 	inode->i_state &= ~(I_LOCK|I_NEW);
 	wake_up_inode(inode);
 }
+
 EXPORT_SYMBOL(unlock_new_inode);
 
 /*
@@ -685,7 +693,6 @@
  *	With a large number of inodes live on the file system this function
  *	currently becomes quite slow.
  */
- 
 ino_t iunique(struct super_block *sb, ino_t max_reserved)
 {
 	static ino_t counter;
@@ -709,6 +716,8 @@
 	
 }
 
+EXPORT_SYMBOL(iunique);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode_lock);
@@ -725,6 +734,8 @@
 	return inode;
 }
 
+EXPORT_SYMBOL(igrab);
+
 /**
  * ifind - internal function, you want ilookup5() or iget5().
  * @sb:		super block of file system to search
@@ -818,6 +829,7 @@
 
 	return ifind(sb, head, test, data);
 }
+
 EXPORT_SYMBOL(ilookup5);
 
 /**
@@ -840,6 +852,7 @@
 
 	return ifind_fast(sb, head, ino);
 }
+
 EXPORT_SYMBOL(ilookup);
 
 /**
@@ -880,6 +893,7 @@
 	 */
 	return get_new_inode(sb, head, test, set, data);
 }
+
 EXPORT_SYMBOL(iget5_locked);
 
 /**
@@ -913,6 +927,7 @@
 	 */
 	return get_new_inode_fast(sb, head, ino);
 }
+
 EXPORT_SYMBOL(iget_locked);
 
 /**
@@ -923,7 +938,6 @@
  *
  *	Add an inode to the inode hash for this superblock.
  */
- 
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
@@ -932,13 +946,14 @@
 	spin_unlock(&inode_lock);
 }
 
+EXPORT_SYMBOL(__insert_inode_hash);
+
 /**
  *	remove_inode_hash - remove an inode from the hash
  *	@inode: inode to unhash
  *
  *	Remove an inode from the superblock.
  */
- 
 void remove_inode_hash(struct inode *inode)
 {
 	spin_lock(&inode_lock);
@@ -946,6 +961,8 @@
 	spin_unlock(&inode_lock);
 }
 
+EXPORT_SYMBOL(remove_inode_hash);
+
 /*
  * Tell the filesystem that this inode is no longer of any interest and should
  * be completely destroyed.
@@ -988,6 +1005,7 @@
 		BUG();
 	destroy_inode(inode);
 }
+
 EXPORT_SYMBOL(generic_delete_inode);
 
 static void generic_forget_inode(struct inode *inode)
@@ -1059,7 +1077,6 @@
  *	Puts an inode, dropping its usage count. If the inode use count hits
  *	zero the inode is also then freed and may be destroyed.
  */
- 
 void iput(struct inode *inode)
 {
 	if (inode) {
@@ -1076,6 +1093,8 @@
 	}
 }
 
+EXPORT_SYMBOL(iput);
+
 /**
  *	bmap	- find a block number in a file
  *	@inode: inode of file
@@ -1087,7 +1106,6 @@
  *	disk block relative to the disk start that holds that block of the 
  *	file.
  */
- 
 sector_t bmap(struct inode * inode, sector_t block)
 {
 	sector_t res = 0;
@@ -1096,6 +1114,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(bmap);
+
 /*
  * Return true if the filesystem which backs this inode considers the two
  * passed timespecs to be sufficiently different to warrant flushing the
@@ -1117,7 +1137,6 @@
  *	This function automatically handles read only file systems and media,
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
- 
 void update_atime(struct inode *inode)
 {
 	struct timespec now;
@@ -1139,6 +1158,8 @@
 	}
 }
 
+EXPORT_SYMBOL(update_atime);
+
 /**
  *	inode_update_time	-	update mtime and ctime time
  *	@inode: inode accessed
@@ -1170,6 +1191,7 @@
 	if (sync_it)
 		mark_inode_dirty_sync(inode);
 }
+
 EXPORT_SYMBOL(inode_update_time);
 
 int inode_needs_sync(struct inode *inode)
@@ -1180,6 +1202,7 @@
 		return 1;
 	return 0;
 }
+
 EXPORT_SYMBOL(inode_needs_sync);
 
 /*
@@ -1375,3 +1398,5 @@
 		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n",
 		       mode);
 }
+
+EXPORT_SYMBOL(init_special_inode);
diff -Nru a/fs/seq_file.c b/fs/seq_file.c
--- a/fs/seq_file.c	Wed Oct  1 20:59:02 2003
+++ b/fs/seq_file.c	Wed Oct  1 20:59:02 2003
@@ -6,6 +6,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
@@ -37,6 +38,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(seq_open);
+
 /**
  *	seq_read -	->read() method for sequential files.
  *	@file, @buf, @size, @ppos: see file_operations method
@@ -144,6 +147,8 @@
 	goto Done;
 }
 
+EXPORT_SYMBOL(seq_read);
+
 static int traverse(struct seq_file *m, loff_t offset)
 {
 	loff_t pos = 0;
@@ -228,6 +233,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(seq_lseek);
+
 /**
  *	seq_release -	free the structures associated with sequential file.
  *	@file: file in question
@@ -244,6 +251,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(seq_release);
+
 /**
  *	seq_escape -	print string into buffer, escaping some characters
  *	@m:	target buffer
@@ -279,6 +288,8 @@
         return 0;
 }
 
+EXPORT_SYMBOL(seq_escape);
+
 int seq_printf(struct seq_file *m, const char *f, ...)
 {
 	va_list args;
@@ -297,9 +308,11 @@
 	return -1;
 }
 
+EXPORT_SYMBOL(seq_printf);
+
 int seq_path(struct seq_file *m,
-		struct vfsmount *mnt, struct dentry *dentry,
-		char *esc)
+	     struct vfsmount *mnt, struct dentry *dentry,
+	     char *esc)
 {
 	if (m->count < m->size) {
 		char *s = m->buf + m->count;
@@ -328,6 +341,8 @@
 	return -1;
 }
 
+EXPORT_SYMBOL(seq_path);
+
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
 	return NULL + (*pos == 0);
@@ -343,7 +358,8 @@
 {
 }
 
-int single_open(struct file *file, int (*show)(struct seq_file *, void*), void *data)
+int single_open(struct file *file, int (*show)(struct seq_file *, void *),
+		void *data)
 {
 	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL);
 	int res = -ENOMEM;
@@ -362,6 +378,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(single_open);
+
 int single_release(struct inode *inode, struct file *file)
 {
 	struct seq_operations *op = ((struct seq_file *)file->private_data)->op;
@@ -370,6 +388,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(single_release);
+
 int seq_release_private(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
@@ -379,3 +399,4 @@
 	return seq_release(inode, file);
 }
 
+EXPORT_SYMBOL(seq_release_private);
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Wed Oct  1 20:59:02 2003
+++ b/fs/super.c	Wed Oct  1 20:59:02 2003
@@ -21,6 +21,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/acct.h>
@@ -134,6 +135,8 @@
 	}
 }
 
+EXPORT_SYMBOL(deactivate_super);
+
 /**
  *	grab_super	- acquire an active reference
  *	@s	- reference we are trying to make active
@@ -214,6 +217,8 @@
 	up_write(&sb->s_umount);
 }
 
+EXPORT_SYMBOL(generic_shutdown_super);
+
 /**
  *	sget	-	find or create a superblock
  *	@type:	filesystem type superblock should belong to
@@ -259,12 +264,16 @@
 	return s;
 }
 
+EXPORT_SYMBOL(sget);
+
 void drop_super(struct super_block *sb)
 {
 	up_read(&sb->s_umount);
 	put_super(sb);
 }
 
+EXPORT_SYMBOL(drop_super);
+
 static inline void write_super(struct super_block *sb)
 {
 	lock_super(sb);
@@ -382,6 +391,8 @@
 	spin_unlock(&sb_lock);
 	return NULL;
 }
+
+EXPORT_SYMBOL(get_super);
  
 struct super_block * user_get_super(dev_t dev)
 {
@@ -405,6 +416,8 @@
 	return NULL;
 }
 
+EXPORT_SYMBOL(user_get_super);
+
 asmlinkage long sys_ustat(unsigned dev, struct ustat __user * ubuf)
 {
         struct super_block *s;
@@ -534,6 +547,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(set_anon_super);
+
 void kill_anon_super(struct super_block *sb)
 {
 	int slot = MINOR(sb->s_dev);
@@ -543,6 +558,8 @@
 	spin_unlock(&unnamed_dev_lock);
 }
 
+EXPORT_SYMBOL(kill_anon_super);
+
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)
@@ -550,6 +567,8 @@
 	kill_anon_super(sb);
 }
 
+EXPORT_SYMBOL(kill_litter_super);
+
 static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
@@ -608,6 +627,8 @@
 	return s;
 }
 
+EXPORT_SYMBOL(get_sb_bdev);
+
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
@@ -616,6 +637,8 @@
 	close_bdev_excl(bdev, BDEV_FS);
 }
 
+EXPORT_SYMBOL(kill_block_super);
+
 struct super_block *get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -638,6 +661,8 @@
 	return s;
 }
 
+EXPORT_SYMBOL(get_sb_nodev);
+
 static int compare_single(struct super_block *s, void *p)
 {
 	return 1;
@@ -667,6 +692,8 @@
 	return s;
 }
 
+EXPORT_SYMBOL(get_sb_single);
+
 struct vfsmount *
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
@@ -709,3 +736,5 @@
 {
 	return do_kern_mount(type->name, 0, type->name, NULL);
 }
+
+EXPORT_SYMBOL(kern_mount);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Oct  1 20:59:02 2003
+++ b/kernel/ksyms.c	Wed Oct  1 20:59:02 2003
@@ -45,7 +45,6 @@
 #include <linux/uio.h>
 #include <linux/tty.h>
 #include <linux/in6.h>
-#include <linux/seq_file.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>
@@ -138,18 +137,9 @@
 EXPORT_SYMBOL(get_user_pages);
 
 /* filesystem internal functions */
-EXPORT_SYMBOL(def_blk_fops);
-EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
-EXPORT_SYMBOL(user_get_super);
-EXPORT_SYMBOL(get_super);
-EXPORT_SYMBOL(drop_super);
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(fget);
-EXPORT_SYMBOL(igrab);
-EXPORT_SYMBOL(iunique);
-EXPORT_SYMBOL(iput);
-EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
@@ -161,9 +151,6 @@
 EXPORT_SYMBOL(filp_close);
 EXPORT_SYMBOL(put_filp);
 EXPORT_SYMBOL(files_lock);
-EXPORT_SYMBOL(check_disk_change);
-EXPORT_SYMBOL(invalidate_inodes);
-EXPORT_SYMBOL(__invalidate_device);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
@@ -171,16 +158,6 @@
 EXPORT_SYMBOL(inode_change_ok);
 EXPORT_SYMBOL(write_inode_now);
 EXPORT_SYMBOL(notify_change);
-EXPORT_SYMBOL(set_blocksize);
-EXPORT_SYMBOL(sb_set_blocksize);
-EXPORT_SYMBOL(sb_min_blocksize);
-EXPORT_SYMBOL(bdget);
-EXPORT_SYMBOL(bdput);
-EXPORT_SYMBOL(bd_claim);
-EXPORT_SYMBOL(bd_release);
-EXPORT_SYMBOL(open_bdev_excl);
-EXPORT_SYMBOL(close_bdev_excl);
-EXPORT_SYMBOL(open_by_devnum);
 EXPORT_SYMBOL(blockdev_direct_IO);
 EXPORT_SYMBOL(file_ra_state_init);
 EXPORT_SYMBOL(generic_ro_fops);
@@ -214,16 +191,6 @@
 EXPORT_SYMBOL(lock_may_write);
 EXPORT_SYMBOL(fd_install);
 EXPORT_SYMBOL(put_unused_fd);
-EXPORT_SYMBOL(get_sb_bdev);
-EXPORT_SYMBOL(kill_block_super);
-EXPORT_SYMBOL(get_sb_nodev);
-EXPORT_SYMBOL(get_sb_single);
-EXPORT_SYMBOL(kill_anon_super);
-EXPORT_SYMBOL(kill_litter_super);
-EXPORT_SYMBOL(generic_shutdown_super);
-EXPORT_SYMBOL(deactivate_super);
-EXPORT_SYMBOL(sget);
-EXPORT_SYMBOL(set_anon_super);
 EXPORT_SYMBOL(do_select);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
@@ -239,11 +206,6 @@
 EXPORT_SYMBOL(tty_std_termios);
 
 /* block device driver support */
-EXPORT_SYMBOL(bmap);
-EXPORT_SYMBOL(blkdev_open);
-EXPORT_SYMBOL(blkdev_get);
-EXPORT_SYMBOL(blkdev_put);
-EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(iov_shorten);
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
@@ -255,32 +217,9 @@
 /* filesystem registration */
 EXPORT_SYMBOL(register_filesystem);
 EXPORT_SYMBOL(unregister_filesystem);
-EXPORT_SYMBOL(kern_mount);
 EXPORT_SYMBOL(__mntput);
 EXPORT_SYMBOL(may_umount);
 
-/* executable format registration */
-EXPORT_SYMBOL(register_binfmt);
-EXPORT_SYMBOL(unregister_binfmt);
-EXPORT_SYMBOL(search_binary_handler);
-EXPORT_SYMBOL(prepare_binprm);
-EXPORT_SYMBOL(compute_creds);
-EXPORT_SYMBOL(remove_arg_zero);
-EXPORT_SYMBOL(set_binfmt);
-
-/* sysctl table registration */
-EXPORT_SYMBOL(register_sysctl_table);
-EXPORT_SYMBOL(unregister_sysctl_table);
-EXPORT_SYMBOL(sysctl_string);
-EXPORT_SYMBOL(sysctl_intvec);
-EXPORT_SYMBOL(sysctl_jiffies);
-EXPORT_SYMBOL(proc_dostring);
-EXPORT_SYMBOL(proc_dointvec);
-EXPORT_SYMBOL(proc_dointvec_jiffies);
-EXPORT_SYMBOL(proc_dointvec_minmax);
-EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
-EXPORT_SYMBOL(proc_doulongvec_minmax);
-
 /* interrupt handling */
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
@@ -373,37 +312,12 @@
 EXPORT_SYMBOL(cap_bset);
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
-EXPORT_SYMBOL(seq_escape);
-EXPORT_SYMBOL(seq_printf);
-EXPORT_SYMBOL(seq_path);
-EXPORT_SYMBOL(seq_open);
-EXPORT_SYMBOL(seq_release);
-EXPORT_SYMBOL(seq_read);
-EXPORT_SYMBOL(seq_lseek);
-EXPORT_SYMBOL(single_open);
-EXPORT_SYMBOL(single_release);
-EXPORT_SYMBOL(seq_release_private);
-
-/* Program loader interfaces */
-#ifdef CONFIG_MMU
-EXPORT_SYMBOL(setup_arg_pages);
-#endif
-EXPORT_SYMBOL(copy_strings_kernel);
-EXPORT_SYMBOL(do_execve);
-EXPORT_SYMBOL(flush_old_exec);
-EXPORT_SYMBOL(kernel_read);
-EXPORT_SYMBOL(open_exec);
 
 /* Miscellaneous access points */
 EXPORT_SYMBOL(si_meminfo);
 
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
-EXPORT_SYMBOL(clear_inode);
-EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(new_inode);
-EXPORT_SYMBOL(__insert_inode_hash);
-EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(__inode_dir_notify);
@@ -419,8 +333,6 @@
 /* all busmice */
 EXPORT_SYMBOL(fasync_helper);
 EXPORT_SYMBOL(kill_fasync);
-
-/* binfmt_aout */
 
 /* library functions */
 EXPORT_SYMBOL(strnicmp);
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Oct  1 20:59:02 2003
+++ b/kernel/sysctl.c	Wed Oct  1 20:59:02 2003
@@ -19,6 +19,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -1994,3 +1995,19 @@
 }
 
 #endif /* CONFIG_SYSCTL */
+
+/*
+ * No sense putting this after each symbol definition, twice,
+ * exception granted :-)
+ */
+EXPORT_SYMBOL(proc_dointvec);
+EXPORT_SYMBOL(proc_dointvec_jiffies);
+EXPORT_SYMBOL(proc_dointvec_minmax);
+EXPORT_SYMBOL(proc_dostring);
+EXPORT_SYMBOL(proc_doulongvec_minmax);
+EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
+EXPORT_SYMBOL(register_sysctl_table);
+EXPORT_SYMBOL(sysctl_intvec);
+EXPORT_SYMBOL(sysctl_jiffies);
+EXPORT_SYMBOL(sysctl_string);
+EXPORT_SYMBOL(unregister_sysctl_table);

