Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbTJBC6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTJBC6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:58:32 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:26127 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263211AbTJBC5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:57:25 -0400
Date: Thu, 2 Oct 2003 00:03:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] today's batch of "nuking kernel/ksyms.c"
Message-ID: <20031002030338.GB1699@conectiva.com.br>
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

ChangeSet@1.1396, 2003-10-02 02:39:04-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/fcntl.c

ChangeSet@1.1395, 2003-10-02 02:32:40-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/attr.c

ChangeSet@1.1394, 2003-10-02 02:28:31-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/filesystems.c

ChangeSet@1.1393, 2003-10-02 02:14:22-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/fs-writeback.c

ChangeSet@1.1392, 2003-10-02 02:10:28-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/partitions/check.c

ChangeSet@1.1391, 2003-10-02 02:02:17-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/select.c

ChangeSet@1.1390, 2003-10-02 01:54:54-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/locks.c

ChangeSet@1.1389, 2003-10-02 01:46:05-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/namespace.c

ChangeSet@1.1388, 2003-10-02 01:31:38-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/file_table.c

ChangeSet@1.1387, 2003-10-02 01:26:03-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/open.c

ChangeSet@1.1386, 2003-10-02 01:17:47-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/stat.c

ChangeSet@1.1385, 2003-10-02 01:04:15-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/read_write.c


 fs/attr.c             |   11 +++++-
 fs/fcntl.c            |   41 ++++++++++++----------
 fs/file_table.c       |   29 +++++++++++-----
 fs/filesystems.c      |   28 ++++++++-------
 fs/fs-writeback.c     |   24 +++++++------
 fs/locks.c            |   90 +++++++++++++++++++++++++++++++-------------------
 fs/namespace.c        |   46 ++++++++++++++-----------
 fs/open.c             |   74 ++++++++++++++++++++++++++---------------
 fs/partitions/check.c |   52 +++++++++++++++++++---------
 fs/read_write.c       |   65 ++++++++++++++++++++++++++----------
 fs/select.c           |   28 ++++++++++-----
 fs/stat.c             |   57 +++++++++++++++++++++++++------
 kernel/ksyms.c        |   66 ------------------------------------
 13 files changed, 358 insertions(+), 253 deletions(-)


diff -Nru a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Thu Oct  2 02:44:46 2003
+++ b/fs/attr.c	Thu Oct  2 02:44:46 2003
@@ -5,6 +5,7 @@
  *  changes by Thomas Schoebel-Theuer
  */
 
+#include <linux/module.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -59,7 +60,9 @@
 	return retval;
 }
 
-int inode_setattr(struct inode * inode, struct iattr * attr)
+EXPORT_SYMBOL(inode_change_ok);
+
+int inode_setattr(struct inode *inode, struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 	int error = 0;
@@ -100,6 +103,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(inode_setattr);
+
 int setattr_mask(unsigned int ia_valid)
 {
 	unsigned long dn_mask = 0;
@@ -122,7 +127,7 @@
 	return dn_mask;
 }
 
-int notify_change(struct dentry * dentry, struct iattr * attr)
+int notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
 	mode_t mode = inode->i_mode;
@@ -184,3 +189,5 @@
 	}
 	return error;
 }
+
+EXPORT_SYMBOL(notify_change);
diff -Nru a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c	Thu Oct  2 02:44:46 2003
+++ b/fs/fcntl.c	Thu Oct  2 02:44:46 2003
@@ -77,9 +77,8 @@
  * expanding the fd arrays if necessary.  Must be called with the
  * file_lock held for write.
  */
-
 static int locate_fd(struct files_struct *files, 
-			    struct file *file, unsigned int orig_start)
+		     struct file *file, unsigned int orig_start)
 {
 	unsigned int newfd;
 	unsigned int start;
@@ -130,7 +129,7 @@
 
 static int dupfd(struct file *file, unsigned int start)
 {
-	struct files_struct * files = current->files;
+	struct files_struct *files = current->files;
 	int fd;
 
 	spin_lock(&files->file_lock);
@@ -151,7 +150,7 @@
 asmlinkage long sys_dup2(unsigned int oldfd, unsigned int newfd)
 {
 	int err = -EBADF;
-	struct file * file, *tofree;
+	struct file *file, *tofree;
 	struct files_struct * files = current->files;
 
 	spin_lock(&files->file_lock);
@@ -214,7 +213,7 @@
 
 #define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | FASYNC | O_DIRECT)
 
-static int setfl(int fd, struct file * filp, unsigned long arg)
+static int setfl(int fd, struct file *filp, unsigned long arg)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
 	int error = 0;
@@ -263,9 +262,8 @@
 
 int f_setown(struct file *filp, unsigned long arg, int force)
 {
-	int err;
-	
-	err = security_file_set_fowner(filp);
+	int err = security_file_set_fowner(filp);
+
 	if (err)
 		return err;
 
@@ -273,13 +271,17 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(f_setown);
+
 void f_delown(struct file *filp)
 {
 	f_modown(filp, 0, 0, 0, 1);
 }
 
+EXPORT_SYMBOL(f_delown);
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
-		     unsigned long arg, struct file * filp)
+		     unsigned long arg, struct file *filp)
 {
 	long err = -EINVAL;
 
@@ -349,7 +351,8 @@
 	return err;
 }
 
-asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
+asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd,
+			  unsigned long arg)
 {	
 	struct file * filp;
 	long err = -EBADF;
@@ -372,7 +375,8 @@
 }
 
 #if BITS_PER_LONG == 32
-asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
+asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd,
+			    unsigned long arg)
 {	
 	struct file * filp;
 	long err;
@@ -541,7 +545,8 @@
  * to set up the fasync queue. It returns negative on error, 0 if it did
  * no changes and positive if it added/deleted the entry.
  */
-int fasync_helper(int fd, struct file * filp, int on, struct fasync_struct **fapp)
+int fasync_helper(int fd, struct file *filp, int on,
+		  struct fasync_struct **fapp)
 {
 	struct fasync_struct *fa, **fp;
 	struct fasync_struct *new = NULL;
@@ -580,6 +585,8 @@
 	return result;
 }
 
+EXPORT_SYMBOL(fasync_helper);
+
 void __kill_fasync(struct fasync_struct *fa, int sig, int band)
 {
 	while (fa) {
@@ -599,6 +606,8 @@
 	}
 }
 
+EXPORT_SYMBOL(__kill_fasync);
+
 void kill_fasync(struct fasync_struct **fp, int sig, int band)
 {
 	read_lock(&fasync_lock);
@@ -606,6 +615,8 @@
 	read_unlock(&fasync_lock);
 }
 
+EXPORT_SYMBOL(kill_fasync);
+
 static int __init fasync_init(void)
 {
 	fasync_cache = kmem_cache_create("fasync_cache",
@@ -616,9 +627,3 @@
 }
 
 module_init(fasync_init)
-
-EXPORT_SYMBOL(f_setown);
-EXPORT_SYMBOL(f_delown);
-#ifdef CONFIG_NET
-EXPORT_SYMBOL(__kill_fasync);
-#endif
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	Thu Oct  2 02:44:46 2003
+++ b/fs/file_table.c	Thu Oct  2 02:44:46 2003
@@ -22,16 +22,20 @@
 	.max_files = NR_FILE
 };
 
+EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
+
 /* public *and* exported. Not pretty! */
 spinlock_t __cacheline_aligned_in_smp files_lock = SPIN_LOCK_UNLOCKED;
 
+EXPORT_SYMBOL(files_lock);
+
 static spinlock_t filp_count_lock = SPIN_LOCK_UNLOCKED;
 
 /* slab constructors and destructors are called from arbitrary
  * context and must be fully threaded - use a local spinlock
  * to protect files_stat.nr_files
  */
-void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
+void filp_ctor(void *objp, struct kmem_cache_s *cachep, unsigned long cflags)
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
@@ -42,7 +46,7 @@
 	}
 }
 
-void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+void filp_dtor(void *objp, struct kmem_cache_s *cachep, unsigned long dflags)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&filp_count_lock, flags);
@@ -61,8 +65,8 @@
  */
 struct file *get_empty_filp(void)
 {
-static int old_max;
-	struct file * f;
+	static int old_max;
+	struct file *f;
 
 	/*
 	 * Privileged users can go above max_files
@@ -100,6 +104,8 @@
 	return NULL;
 }
 
+EXPORT_SYMBOL(get_empty_filp);
+
 /*
  * Clear and initialize a (private) struct file for the given dentry,
  * allocate the security structure, and call the open function (if any).  
@@ -128,25 +134,31 @@
 	return error;
 }
 
+EXPORT_SYMBOL(open_private_file);
+
 /*
  * Release a private file by calling the release function (if any) and
  * freeing the security structure.
  */
 void close_private_file(struct file *file)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_dentry->d_inode;
 
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
 	security_file_free(file);
 }
 
+EXPORT_SYMBOL(close_private_file);
+
 void fput(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count))
 		__fput(file);
 }
 
+EXPORT_SYMBOL(fput);
+
 /* __fput is called from task context when aio completion releases the last
  * last use of a struct file *.  Do not use otherwise.
  */
@@ -192,6 +204,8 @@
 	return file;
 }
 
+EXPORT_SYMBOL(fget);
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared. 
  * You can use this only if it is guranteed that the current task already 
@@ -229,6 +243,8 @@
 	}
 }
 
+EXPORT_SYMBOL(put_filp);
+
 void file_move(struct file *file, struct list_head *list)
 {
 	if (!list)
@@ -284,6 +300,3 @@
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
 } 
-
-/* Needed by unix.o */
-EXPORT_SYMBOL(files_stat);
diff -Nru a/fs/filesystems.c b/fs/filesystems.c
--- a/fs/filesystems.c	Thu Oct  2 02:44:46 2003
+++ b/fs/filesystems.c	Thu Oct  2 02:44:46 2003
@@ -61,8 +61,7 @@
  *	structures and must not be freed until the file system has been
  *	unregistered.
  */
- 
-int register_filesystem(struct file_system_type * fs)
+int register_filesystem(struct file_system_type *fs)
 {
 	int res = 0;
 	struct file_system_type ** p;
@@ -82,6 +81,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(register_filesystem);
+
 /**
  *	unregister_filesystem - unregister a file system
  *	@fs: filesystem to unregister
@@ -93,10 +94,9 @@
  *	Once this function has returned the &struct file_system_type structure
  *	may be freed or reused.
  */
- 
-int unregister_filesystem(struct file_system_type * fs)
+int unregister_filesystem(struct file_system_type *fs)
 {
-	struct file_system_type ** tmp;
+	struct file_system_type **tmp;
 
 	write_lock(&file_systems_lock);
 	tmp = &file_systems;
@@ -113,10 +113,12 @@
 	return -EINVAL;
 }
 
-static int fs_index(const char __user * __name)
+EXPORT_SYMBOL(unregister_filesystem);
+
+static int fs_index(const char __user *__name)
 {
-	struct file_system_type * tmp;
-	char * name;
+	struct file_system_type *tmp;
+	char *name;
 	int err, index;
 
 	name = getname(__name);
@@ -137,9 +139,9 @@
 	return err;
 }
 
-static int fs_name(unsigned int index, char __user * buf)
+static int fs_name(unsigned int index, char __user *buf)
 {
-	struct file_system_type * tmp;
+	struct file_system_type *tmp;
 	int len, res;
 
 	read_lock(&file_systems_lock);
@@ -159,7 +161,7 @@
 
 static int fs_maxindex(void)
 {
-	struct file_system_type * tmp;
+	struct file_system_type *tmp;
 	int index;
 
 	read_lock(&file_systems_lock);
@@ -192,7 +194,7 @@
 	return retval;
 }
 
-int get_filesystem_list(char * buf)
+int get_filesystem_list(char *buf)
 {
 	int len = 0;
 	struct file_system_type * tmp;
@@ -227,3 +229,5 @@
 	}
 	return fs;
 }
+
+EXPORT_SYMBOL(get_fs_type);
diff -Nru a/fs/fs-writeback.c b/fs/fs-writeback.c
--- a/fs/fs-writeback.c	Thu Oct  2 02:44:46 2003
+++ b/fs/fs-writeback.c	Thu Oct  2 02:44:46 2003
@@ -107,6 +107,8 @@
 	spin_unlock(&inode_lock);
 }
 
+EXPORT_SYMBOL(__mark_inode_dirty);
+
 static void write_inode(struct inode *inode, int sync)
 {
 	if (inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
@@ -129,8 +131,8 @@
  *
  * Called under inode_lock.
  */
-static void
-__sync_single_inode(struct inode *inode, struct writeback_control *wbc)
+static void __sync_single_inode(struct inode *inode,
+				struct writeback_control *wbc)
 {
 	unsigned dirty;
 	struct address_space *mapping = inode->i_mapping;
@@ -194,9 +196,8 @@
 /*
  * Write out an inode's dirty pages.  Called under inode_lock.
  */
-static void
-__writeback_single_inode(struct inode *inode,
-			struct writeback_control *wbc)
+static void __writeback_single_inode(struct inode *inode,
+				     struct writeback_control *wbc)
 {
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
@@ -246,8 +247,8 @@
  * on the writer throttling path, and we get decent balancing between many
  * throttled threads: we don't want them all piling up on __wait_on_inode.
  */
-static void
-sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
+static void sync_sb_inodes(struct super_block *sb,
+			   struct writeback_control *wbc)
 {
 	const unsigned long start = jiffies;	/* livelock avoidance */
 
@@ -341,8 +342,7 @@
  * sync_sb_inodes will seekout the blockdev which matches `bdi'.  Maybe not
  * super-efficient but we're about to do a ton of I/O...
  */
-void
-writeback_inodes(struct writeback_control *wbc)
+void writeback_inodes(struct writeback_control *wbc)
 {
 	struct super_block *sb;
 
@@ -479,7 +479,6 @@
  *	This function commits an inode to disk immediately if it is
  *	dirty. This is primarily needed by knfsd.
  */
- 
 void write_inode_now(struct inode *inode, int sync)
 {
 	struct writeback_control wbc = {
@@ -494,6 +493,8 @@
 		wait_on_inode(inode);
 }
 
+EXPORT_SYMBOL(write_inode_now);
+
 /**
  * generic_osync_inode - flush all dirty data for a given inode to disk
  * @inode: inode to write
@@ -509,7 +510,6 @@
  *    OSYNC_METADATA: the buffers at i_mapping->private_list
  *    OSYNC_INODE:    the inode itself
  */
-
 int generic_osync_inode(struct inode *inode, int what)
 {
 	int err = 0;
@@ -544,6 +544,8 @@
 
 	return err;
 }
+
+EXPORT_SYMBOL(generic_osync_inode);
 
 /**
  * writeback_acquire: attempt to get exclusive writeback access to a device
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Thu Oct  2 02:44:46 2003
+++ b/fs/locks.c	Thu Oct  2 02:44:46 2003
@@ -138,6 +138,9 @@
 	for (lockp = &inode->i_flock; *lockp != NULL; lockp = &(*lockp)->fl_next)
 
 LIST_HEAD(file_lock_list);
+
+EXPORT_SYMBOL(file_lock_list);
+
 static LIST_HEAD(blocked_list);
 
 static kmem_cache_t *filelock_cache;
@@ -185,6 +188,8 @@
 	fl->fl_remove = NULL;
 }
 
+EXPORT_SYMBOL(locks_init_lock);
+
 /*
  * Initialises the fields of the file lock which are invariant for
  * free file_locks.
@@ -218,7 +223,10 @@
 	new->fl_u = fl->fl_u;
 }
 
-static inline int flock_translate_cmd(int cmd) {
+EXPORT_SYMBOL(locks_copy_lock);
+
+static inline int flock_translate_cmd(int cmd)
+{
 	if (cmd & LOCK_MAND)
 		return cmd & (LOCK_MAND | LOCK_RW);
 	switch (cmd) {
@@ -234,7 +242,7 @@
 
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
 static int flock_make_lock(struct file *filp, struct file_lock **lock,
-		unsigned int cmd)
+			   unsigned int cmd)
 {
 	struct file_lock *fl;
 	int type = flock_translate_cmd(cmd);
@@ -410,8 +418,8 @@
  * Check whether two locks have the same owner.  The apparently superfluous
  * check for fl_pid enables us to distinguish between locks set by lockd.
  */
-static inline int
-posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+static inline int posix_same_owner(struct file_lock *fl1,
+				   struct file_lock *fl2)
 {
 	return (fl1->fl_owner == fl2->fl_owner) &&
 		(fl1->fl_pid == fl2->fl_pid);
@@ -427,8 +435,6 @@
 	waiter->fl_next = NULL;
 }
 
-/*
- */
 static void locks_delete_block(struct file_lock *waiter)
 {
 	lock_kernel();
@@ -503,7 +509,8 @@
 
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL) {
-		printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
+		printk(KERN_ERR "locks_delete_lock: fasync == %p\n",
+		       fl->fl_fasync);
 		fl->fl_fasync = NULL;
 	}
 
@@ -517,7 +524,8 @@
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int locks_conflict(struct file_lock *caller_fl,
+			  struct file_lock *sys_fl)
 {
 	if (sys_fl->fl_type == F_WRLCK)
 		return 1;
@@ -529,7 +537,8 @@
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
  * checking before calling the locks_conflict().
  */
-static int posix_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int posix_locks_conflict(struct file_lock *caller_fl,
+				struct file_lock *sys_fl)
 {
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
@@ -547,7 +556,8 @@
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
  * checking before calling the locks_conflict().
  */
-static int flock_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int flock_locks_conflict(struct file_lock *caller_fl,
+				struct file_lock *sys_fl)
 {
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
@@ -560,7 +570,8 @@
 	return (locks_conflict(caller_fl, sys_fl));
 }
 
-static int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, int timeout)
+static int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait,
+					 int timeout)
 {
 	int result = 0;
 	DECLARE_WAITQUEUE(wait, current);
@@ -578,7 +589,8 @@
 	return result;
 }
 
-static int locks_block_on_timeout(struct file_lock *blocker, struct file_lock *waiter, int time)
+static int locks_block_on_timeout(struct file_lock *blocker,
+				  struct file_lock *waiter, int time)
 {
 	int result;
 	locks_insert_block(blocker, waiter);
@@ -587,8 +599,7 @@
 	return result;
 }
 
-struct file_lock *
-posix_test_lock(struct file *filp, struct file_lock *fl)
+struct file_lock *posix_test_lock(struct file *filp, struct file_lock *fl)
 {
 	struct file_lock *cfl;
 
@@ -604,6 +615,8 @@
 	return (cfl);
 }
 
+EXPORT_SYMBOL(posix_test_lock);
+
 /* This function tests for deadlock condition before putting a process to
  * sleep. The detection scheme is no longer recursive. Recursive was neat,
  * but dangerous - we risked stack corruption if the lock data was bad, or
@@ -619,7 +632,7 @@
  * worry about than proper deadlock detection anyway... --okir
  */
 int posix_locks_deadlock(struct file_lock *caller_fl,
-				struct file_lock *block_fl)
+			 struct file_lock *block_fl)
 {
 	struct list_head *tmp;
 	fl_owner_t caller_owner, blocked_owner;
@@ -646,6 +659,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(posix_locks_deadlock);
+
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
@@ -707,6 +722,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(posix_lock_file);
+
 static int __posix_lock_file(struct inode *inode, struct file_lock *request)
 {
 	struct file_lock *fl;
@@ -978,6 +995,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(locks_mandatory_area);
+
 /* We already had a lease on this file; just change its type */
 static int lease_modify(struct file_lock **before, int arg)
 {
@@ -1116,6 +1135,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(__break_lease);
+
 /**
  *	lease_get_mtime
  *	@inode: the inode
@@ -1133,6 +1154,8 @@
 		*time = inode->i_mtime;
 }
 
+EXPORT_SYMBOL(lease_get_mtime);
+
 /**
  *	fcntl_getlease - Enquire what lease is currently active
  *	@filp: the file
@@ -1548,7 +1571,8 @@
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk64(struct file *filp, unsigned int cmd, struct flock64 __user *l)
+int fcntl_setlk64(struct file *filp, unsigned int cmd,
+		  struct flock64 __user *l)
 {
 	struct file_lock *file_lock = locks_alloc_lock();
 	struct flock64 flock;
@@ -1718,20 +1742,20 @@
  *
  * lockd needs to block waiting for locks.
  */
-void
-posix_block_lock(struct file_lock *blocker, struct file_lock *waiter)
+void posix_block_lock(struct file_lock *blocker, struct file_lock *waiter)
 {
 	locks_insert_block(blocker, waiter);
 }
 
+EXPORT_SYMBOL(posix_block_lock);
+
 /**
  *	posix_unblock_lock - stop waiting for a file lock
  *	@waiter: the lock which was waiting
  *
  *	lockd needs to block waiting for locks.
  */
-void
-posix_unblock_lock(struct file *filp, struct file_lock *waiter)
+void posix_unblock_lock(struct file *filp, struct file_lock *waiter)
 {
 	/* 
 	 * A remote machine may cancel the lock request after it's been
@@ -1748,7 +1772,10 @@
 	}
 }
 
-static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
+EXPORT_SYMBOL(posix_unblock_lock);
+
+static void lock_get_status(char* out, struct file_lock *fl,
+			    int id, char *pfx)
 {
 	struct inode *inode = NULL;
 
@@ -1844,7 +1871,6 @@
  *	@offset: how far we are through the buffer
  *	@length: how much to read
  */
-
 int get_locks_status(char *buffer, char **start, off_t offset, int length)
 {
 	struct list_head *tmp;
@@ -1902,7 +1928,8 @@
 		if (IS_POSIX(fl)) {
 			if (fl->fl_type == F_RDLCK)
 				continue;
-			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
+			if ((fl->fl_end < start) ||
+			    (fl->fl_start > (start + len)))
 				continue;
 		} else if (IS_FLOCK(fl)) {
 			if (!(fl->fl_type & LOCK_MAND))
@@ -1918,6 +1945,8 @@
 	return result;
 }
 
+EXPORT_SYMBOL(lock_may_read);
+
 /**
  *	lock_may_write - checks that the region is free of locks
  *	@inode: the inode that is being written
@@ -1938,7 +1967,8 @@
 	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (IS_POSIX(fl)) {
-			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
+			if ((fl->fl_end < start) ||
+			    (fl->fl_start > (start + len)))
 				continue;
 		} else if (IS_FLOCK(fl)) {
 			if (!(fl->fl_type & LOCK_MAND))
@@ -1954,6 +1984,8 @@
 	return result;
 }
 
+EXPORT_SYMBOL(lock_may_write);
+
 static int __init filelock_init(void)
 {
 	filelock_cache = kmem_cache_create("file_lock_cache",
@@ -1964,13 +1996,3 @@
 }
 
 module_init(filelock_init)
-
-EXPORT_SYMBOL(file_lock_list);
-EXPORT_SYMBOL(locks_init_lock);
-EXPORT_SYMBOL(locks_copy_lock);
-EXPORT_SYMBOL(posix_lock_file);
-EXPORT_SYMBOL(posix_test_lock);
-EXPORT_SYMBOL(posix_block_lock);
-EXPORT_SYMBOL(posix_unblock_lock);
-EXPORT_SYMBOL(posix_locks_deadlock);
-EXPORT_SYMBOL(locks_mandatory_area);
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Thu Oct  2 02:44:46 2003
+++ b/fs/namespace.c	Thu Oct  2 02:44:46 2003
@@ -94,6 +94,8 @@
 	return found;
 }
 
+EXPORT_SYMBOL(lookup_mnt);
+
 static int check_mnt(struct vfsmount *mnt)
 {
 	spin_lock(&vfsmount_lock);
@@ -139,8 +141,7 @@
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
@@ -164,6 +165,8 @@
 	deactivate_super(sb);
 }
 
+EXPORT_SYMBOL(__mntput);
+
 /* iterator */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
@@ -259,6 +262,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(may_umount);
+
 void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
@@ -366,8 +371,7 @@
  * We now support a flag for forced unmount like the other 'big iron'
  * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
  */
-
-asmlinkage long sys_umount(char __user * name, int flags)
+asmlinkage long sys_umount(char __user *name, int flags)
 {
 	struct nameidata nd;
 	int retval;
@@ -395,10 +399,9 @@
 /*
  *	The 2.0 compatible umount. No flags. 
  */
- 
-asmlinkage long sys_oldumount(char __user * name)
+asmlinkage long sys_oldumount(char __user *name)
 {
-	return sys_umount(name,0);
+	return sys_umount(name, 0);
 }
 
 static int mount_is_safe(struct nameidata *nd)
@@ -419,8 +422,7 @@
 #endif
 }
 
-static int
-lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
+static int lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
 {
 	while (1) {
 		if (d == dentry)
@@ -559,11 +561,11 @@
  * If you've mounted a non-root directory somewhere and want to do remount
  * on it - tough luck.
  */
-
-static int do_remount(struct nameidata *nd,int flags,int mnt_flags,void *data)
+static int do_remount(struct nameidata *nd, int flags,
+		      int mnt_flags, void *data)
 {
 	int err;
-	struct super_block * sb = nd->mnt->mnt_sb;
+	struct super_block *sb = nd->mnt->mnt_sb;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -684,7 +686,7 @@
 	return err;
 }
 
-static int copy_mount_options (const void __user *data, unsigned long *where)
+static int copy_mount_options(const void __user *data, unsigned long *where)
 {
 	int i;
 	unsigned long page;
@@ -731,8 +733,8 @@
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-long do_mount(char * dev_name, char * dir_name, char *type_page,
-		  unsigned long flags, void *data_page)
+long do_mount(char *dev_name, char *dir_name, char *type_page,
+	      unsigned long flags, void *data_page)
 {
 	struct nameidata nd;
 	int retval = 0;
@@ -862,9 +864,9 @@
 	return -ENOMEM;
 }
 
-asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
-			  char __user * type, unsigned long flags,
-			  void __user * data)
+asmlinkage long sys_mount(char __user *dev_name, char __user *dir_name,
+			  char __user *type, unsigned long flags,
+			  void __user *data)
 {
 	int retval;
 	unsigned long data_page;
@@ -925,6 +927,8 @@
 	}
 }
 
+EXPORT_SYMBOL(set_fs_root);
+
 /*
  * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
@@ -948,6 +952,8 @@
 	}
 }
 
+EXPORT_SYMBOL(set_fs_pwd);
+
 static void chroot_fs_refs(struct nameidata *old_nd, struct nameidata *new_nd)
 {
 	struct task_struct *g, *p;
@@ -983,8 +989,8 @@
  *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
  *    first.
  */
-
-asmlinkage long sys_pivot_root(const char __user *new_root, const char __user *put_old)
+asmlinkage long sys_pivot_root(const char __user *new_root,
+			       const char __user *put_old)
 {
 	struct vfsmount *tmp;
 	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Thu Oct  2 02:44:46 2003
+++ b/fs/open.c	Thu Oct  2 02:44:46 2003
@@ -42,6 +42,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(vfs_statfs);
+
 static int vfs_statfs_native(struct super_block *sb, struct statfs *buf)
 {
 	struct kstatfs st;
@@ -103,7 +105,8 @@
 	return 0;
 }
 
-asmlinkage long sys_statfs(const char __user * path, struct statfs __user * buf)
+asmlinkage long sys_statfs(const char __user *path,
+			   struct statfs __user *buf)
 {
 	struct nameidata nd;
 	int error;
@@ -120,7 +123,8 @@
 }
 
 
-asmlinkage long sys_statfs64(const char __user *path, size_t sz, struct statfs64 __user *buf)
+asmlinkage long sys_statfs64(const char __user *path, size_t sz,
+			     struct statfs64 __user *buf)
 {
 	struct nameidata nd;
 	long error;
@@ -139,7 +143,7 @@
 }
 
 
-asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user * buf)
+asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf)
 {
 	struct file * file;
 	struct statfs tmp;
@@ -157,7 +161,8 @@
 	return error;
 }
 
-asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz, struct statfs64 __user *buf)
+asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
+			      struct statfs64 __user *buf)
 {
 	struct file * file;
 	struct statfs64 tmp;
@@ -195,7 +200,7 @@
 	return err;
 }
 
-static inline long do_sys_truncate(const char __user * path, loff_t length)
+static inline long do_sys_truncate(const char __user *path, loff_t length)
 {
 	struct nameidata nd;
 	struct inode * inode;
@@ -255,7 +260,7 @@
 	return error;
 }
 
-asmlinkage long sys_truncate(const char __user * path, unsigned long length)
+asmlinkage long sys_truncate(const char __user *path, unsigned long length)
 {
 	/* on 32-bit boxen it will cut the range 2^31--2^32-1 off */
 	return do_sys_truncate(path, (long)length);
@@ -311,7 +316,7 @@
 
 /* LFS versions of truncate are only needed on 32 bit machines */
 #if BITS_PER_LONG == 32
-asmlinkage long sys_truncate64(const char __user * path, loff_t length)
+asmlinkage long sys_truncate64(const char __user *path, loff_t length)
 {
 	return do_sys_truncate(path, length);
 }
@@ -335,7 +340,7 @@
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-asmlinkage long sys_utime(char __user * filename, struct utimbuf __user * times)
+asmlinkage long sys_utime(char __user *filename, struct utimbuf __user *times)
 {
 	int error;
 	struct nameidata nd;
@@ -361,7 +366,8 @@
 		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
 		newattrs.ia_atime.tv_nsec = 0;
 		if (!error) 
-			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
+			error = get_user(newattrs.ia_mtime.tv_sec,
+					 &times->modtime);
 		newattrs.ia_mtime.tv_nsec = 0;
 		if (error)
 			goto dput_and_out;
@@ -391,7 +397,7 @@
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-long do_utimes(char __user * filename, struct timeval * times)
+long do_utimes(char __user *filename, struct timeval *times)
 {
 	int error;
 	struct nameidata nd;
@@ -438,7 +444,8 @@
 	return error;
 }
 
-asmlinkage long sys_utimes(char __user * filename, struct timeval __user * utimes)
+asmlinkage long sys_utimes(char __user *filename,
+			   struct timeval __user *utimes)
 {
 	struct timeval times[2];
 
@@ -453,7 +460,7 @@
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-asmlinkage long sys_access(const char __user * filename, int mode)
+asmlinkage long sys_access(const char __user *filename, int mode)
 {
 	struct nameidata nd;
 	int old_fsuid, old_fsgid;
@@ -500,7 +507,7 @@
 	return res;
 }
 
-asmlinkage long sys_chdir(const char __user * filename)
+asmlinkage long sys_chdir(const char __user *filename)
 {
 	struct nameidata nd;
 	int error;
@@ -551,12 +558,12 @@
 	return error;
 }
 
-asmlinkage long sys_chroot(const char __user * filename)
+asmlinkage long sys_chroot(const char __user *filename)
 {
 	struct nameidata nd;
-	int error;
-
-	error = __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
+	int error = __user_walk(filename,
+				LOOKUP_FOLLOW | LOOKUP_DIRECTORY |
+					LOOKUP_NOALT, &nd);
 	if (error)
 		goto out;
 
@@ -612,7 +619,7 @@
 	return err;
 }
 
-asmlinkage long sys_chmod(const char __user * filename, mode_t mode)
+asmlinkage long sys_chmod(const char __user *filename, mode_t mode)
 {
 	struct nameidata nd;
 	struct inode * inode;
@@ -646,7 +653,7 @@
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct dentry *dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -681,7 +688,7 @@
 	return error;
 }
 
-asmlinkage long sys_chown(const char __user * filename, uid_t user, gid_t group)
+asmlinkage long sys_chown(const char __user *filename, uid_t user, gid_t group)
 {
 	struct nameidata nd;
 	int error;
@@ -694,7 +701,7 @@
 	return error;
 }
 
-asmlinkage long sys_lchown(const char __user * filename, uid_t user, gid_t group)
+asmlinkage long sys_lchown(const char __user *filename, uid_t user, gid_t group)
 {
 	struct nameidata nd;
 	int error;
@@ -735,7 +742,7 @@
  * for the internal routines (ie open_namei()/follow_link() etc). 00 is
  * used by symlinks.
  */
-struct file *filp_open(const char * filename, int flags, int mode)
+struct file *filp_open(const char *filename, int flags, int mode)
 {
 	int namei_flags, error;
 	struct nameidata nd;
@@ -753,6 +760,8 @@
 	return ERR_PTR(error);
 }
 
+EXPORT_SYMBOL(filp_open);
+
 struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
 {
 	struct file * f;
@@ -812,6 +821,8 @@
 	return ERR_PTR(error);
 }
 
+EXPORT_SYMBOL(dentry_open);
+
 /*
  * Find an empty file descriptor entry, and mark it busy.
  */
@@ -874,6 +885,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(get_unused_fd);
+
 static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
 	__FD_CLR(fd, files->open_fds);
@@ -889,6 +902,8 @@
 	spin_unlock(&files->file_lock);
 }
 
+EXPORT_SYMBOL(put_unused_fd);
+
 /*
  * Install a file pointer in the fd array.  
  *
@@ -901,8 +916,7 @@
  * It should never happen - if we allow dup2() do it, _really_ bad things
  * will follow.
  */
-
-void fd_install(unsigned int fd, struct file * file)
+void fd_install(unsigned int fd, struct file *file)
 {
 	struct files_struct *files = current->files;
 	spin_lock(&files->file_lock);
@@ -912,7 +926,9 @@
 	spin_unlock(&files->file_lock);
 }
 
-asmlinkage long sys_open(const char __user * filename, int flags, int mode)
+EXPORT_SYMBOL(fd_install);
+
+asmlinkage long sys_open(const char __user *filename, int flags, int mode)
 {
 	char * tmp;
 	int fd, error;
@@ -948,7 +964,7 @@
  * For backward compatibility?  Maybe this should be moved
  * into arch/i386 instead?
  */
-asmlinkage long sys_creat(const char __user * pathname, int mode)
+asmlinkage long sys_creat(const char __user *pathname, int mode)
 {
 	return sys_open(pathname, O_CREAT | O_WRONLY | O_TRUNC, mode);
 }
@@ -985,6 +1001,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(filp_close);
+
 /*
  * Careful here! We test whether the file pointer is NULL before
  * releasing the fd. This ensures that one clone task can't release
@@ -1012,6 +1030,8 @@
 	return -EBADF;
 }
 
+EXPORT_SYMBOL(sys_close);
+
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
@@ -1031,7 +1051,7 @@
  * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
  * on this flag in sys_open.
  */
-int generic_file_open(struct inode * inode, struct file * filp)
+int generic_file_open(struct inode *inode, struct file *filp)
 {
 	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Thu Oct  2 02:44:46 2003
+++ b/fs/partitions/check.c	Thu Oct  2 02:44:46 2003
@@ -135,6 +135,8 @@
 	return disk_name(bdev->bd_disk, part, buf);
 }
 
+EXPORT_SYMBOL(bdevname);
+
 /*
  * NOTE: this cannot be called from interrupt context.
  *
@@ -158,8 +160,10 @@
 	return buffer;
 }
 
-static struct parsed_partitions *
-check_partition(struct gendisk *hd, struct block_device *bdev)
+EXPORT_SYMBOL(__bdevname);
+
+static struct parsed_partitions *check_partition(struct gendisk *hd,
+						 struct block_device *bdev)
 {
 	struct parsed_partitions *state;
 	int i, res;
@@ -205,14 +209,16 @@
 	ssize_t (*show)(struct hd_struct *,char *);
 };
 
-static ssize_t 
-part_attr_show(struct kobject * kobj, struct attribute * attr, char * page)
+static ssize_t part_attr_show(struct kobject *kobj,
+			      struct attribute *attr, char *page)
 {
-	struct hd_struct * p = container_of(kobj,struct hd_struct,kobj);
-	struct part_attribute * part_attr = container_of(attr,struct part_attribute,attr);
+	struct hd_struct *p = container_of(kobj,struct hd_struct,kobj);
+	struct part_attribute *part_attr = container_of(attr,
+							struct part_attribute,
+							attr);
 	ssize_t ret = 0;
 	if (part_attr->show)
-		ret = part_attr->show(p,page);
+		ret = part_attr->show(p, page);
 	return ret;
 }
 
@@ -220,44 +226,51 @@
 	.show	=	part_attr_show,
 };
 
-static ssize_t part_dev_read(struct hd_struct * p, char *page)
+static ssize_t part_dev_read(struct hd_struct *p, char *page)
 {
 	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
 	dev_t dev = MKDEV(disk->major, disk->first_minor + p->partno); 
 	return print_dev_t(page, dev);
 }
-static ssize_t part_start_read(struct hd_struct * p, char *page)
+
+static ssize_t part_start_read(struct hd_struct *p, char *page)
 {
 	return sprintf(page, "%llu\n",(unsigned long long)p->start_sect);
 }
-static ssize_t part_size_read(struct hd_struct * p, char *page)
+
+static ssize_t part_size_read(struct hd_struct *p, char *page)
 {
 	return sprintf(page, "%llu\n",(unsigned long long)p->nr_sects);
 }
-static ssize_t part_stat_read(struct hd_struct * p, char *page)
+
+static ssize_t part_stat_read(struct hd_struct *p, char *page)
 {
 	return sprintf(page, "%8u %8llu %8u %8llu\n",
 		       p->reads, (unsigned long long)p->read_sectors,
 		       p->writes, (unsigned long long)p->write_sectors);
 }
+
 static struct part_attribute part_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= part_dev_read
 };
+
 static struct part_attribute part_attr_start = {
 	.attr = {.name = "start", .mode = S_IRUGO },
 	.show	= part_start_read
 };
+
 static struct part_attribute part_attr_size = {
 	.attr = {.name = "size", .mode = S_IRUGO },
 	.show	= part_size_read
 };
+
 static struct part_attribute part_attr_stat = {
 	.attr = {.name = "stat", .mode = S_IRUGO },
 	.show	= part_stat_read
 };
 
-static struct attribute * default_attrs[] = {
+static struct attribute *default_attrs[] = {
 	&part_attr_dev.attr,
 	&part_attr_start.attr,
 	&part_attr_size.attr,
@@ -269,7 +282,7 @@
 
 static void part_release(struct kobject *kobj)
 {
-	struct hd_struct * p = container_of(kobj,struct hd_struct,kobj);
+	struct hd_struct *p = container_of(kobj, struct hd_struct, kobj);
 	kfree(p);
 }
 
@@ -294,7 +307,8 @@
 	kobject_unregister(&p->kobj);
 }
 
-void add_partition(struct gendisk *disk, int part, sector_t start, sector_t len)
+void add_partition(struct gendisk *disk, int part,
+		   sector_t start, sector_t len)
 {
 	struct hd_struct *p;
 
@@ -413,13 +427,14 @@
 	return res;
 }
 
-unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
+unsigned char *read_dev_sector(struct block_device *bdev,
+			       sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 	struct page *page;
 
 	page = read_cache_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
-			(filler_t *)mapping->a_ops->readpage, NULL);
+			       (filler_t *)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
@@ -427,13 +442,16 @@
 		if (PageError(page))
 			goto fail;
 		p->v = page;
-		return (unsigned char *)page_address(page) +  ((n & ((1 << (PAGE_CACHE_SHIFT - 9)) - 1)) << 9);
+		return (unsigned char *)page_address(page) +
+		       ((n & ((1 << (PAGE_CACHE_SHIFT - 9)) - 1)) << 9);
 fail:
 		page_cache_release(page);
 	}
 	p->v = NULL;
 	return NULL;
 }
+
+EXPORT_SYMBOL(read_dev_sector);
 
 void del_gendisk(struct gendisk *disk)
 {
diff -Nru a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	Thu Oct  2 02:44:46 2003
+++ b/fs/read_write.c	Thu Oct  2 02:44:46 2003
@@ -23,6 +23,8 @@
 	.sendfile	= generic_file_sendfile,
 };
 
+EXPORT_SYMBOL(generic_ro_fops);
+
 loff_t generic_file_llseek(struct file *file, loff_t offset, int origin)
 {
 	long long retval;
@@ -48,6 +50,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(generic_file_llseek);
+
 loff_t remote_llseek(struct file *file, loff_t offset, int origin)
 {
 	long long retval;
@@ -72,11 +76,15 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(remote_llseek);
+
 loff_t no_llseek(struct file *file, loff_t offset, int origin)
 {
 	return -ESPIPE;
 }
 
+EXPORT_SYMBOL(no_llseek);
+
 loff_t default_llseek(struct file *file, loff_t offset, int origin)
 {
 	long long retval;
@@ -101,6 +109,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(default_llseek);
+
 static inline loff_t llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t (*fn)(struct file *, loff_t, int);
@@ -169,7 +179,8 @@
 }
 #endif
 
-ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
+ssize_t do_sync_read(struct file *filp, char __user *buf,
+		     size_t len, loff_t *ppos)
 {
 	struct kiocb kiocb;
 	ssize_t ret;
@@ -183,7 +194,10 @@
 	return ret;
 }
 
-ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+EXPORT_SYMBOL(do_sync_read);
+
+ssize_t vfs_read(struct file *file, char __user *buf,
+		 size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
@@ -209,7 +223,10 @@
 	return ret;
 }
 
-ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
+EXPORT_SYMBOL(vfs_read);
+
+ssize_t do_sync_write(struct file *filp, const char __user *buf,
+		      size_t len, loff_t *ppos)
 {
 	struct kiocb kiocb;
 	ssize_t ret;
@@ -223,7 +240,10 @@
 	return ret;
 }
 
-ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
+EXPORT_SYMBOL(do_sync_write);
+
+ssize_t vfs_write(struct file *file, const char __user *buf,
+		  size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
@@ -249,6 +269,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(vfs_write);
+
 asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
 {
 	struct file *file;
@@ -264,7 +286,8 @@
 	return ret;
 }
 
-asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, size_t count)
+asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf,
+			     size_t count)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -280,7 +303,7 @@
 }
 
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
-			     size_t count, loff_t pos)
+			       size_t count, loff_t pos)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -337,12 +360,16 @@
 	return seg;
 }
 
+EXPORT_SYMBOL(iov_shorten);
+
 static ssize_t do_readv_writev(int type, struct file *file,
 			       const struct iovec __user * uvector,
 			       unsigned long nr_segs, loff_t *pos)
 {
-	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
-	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
+	typedef ssize_t (*io_fn_t)(struct file *, char __user *,
+				   size_t, loff_t *);
+	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *,
+				    unsigned long, loff_t *);
 
 	size_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -468,6 +495,8 @@
 	return do_readv_writev(READ, file, vec, vlen, pos);
 }
 
+EXPORT_SYMBOL(vfs_readv);
+
 ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 		   unsigned long vlen, loff_t *pos)
 {
@@ -479,9 +508,11 @@
 	return do_readv_writev(WRITE, file, vec, vlen, pos);
 }
 
+EXPORT_SYMBOL(vfs_writev);
 
-asmlinkage ssize_t
-sys_readv(unsigned long fd, const struct iovec __user *vec, unsigned long vlen)
+asmlinkage ssize_t sys_readv(unsigned long fd,
+			     const struct iovec __user *vec,
+			     unsigned long vlen)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -496,8 +527,9 @@
 	return ret;
 }
 
-asmlinkage ssize_t
-sys_writev(unsigned long fd, const struct iovec __user *vec, unsigned long vlen)
+asmlinkage ssize_t sys_writev(unsigned long fd,
+			      const struct iovec __user *vec,
+			      unsigned long vlen)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -595,7 +627,8 @@
 	return retval;
 }
 
-asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t __user *offset, size_t count)
+asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd,
+				off_t __user *offset, size_t count)
 {
 	loff_t pos;
 	off_t off;
@@ -614,7 +647,8 @@
 	return do_sendfile(out_fd, in_fd, NULL, count, MAX_NON_LFS);
 }
 
-asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t __user *offset, size_t count)
+asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd,
+				  loff_t __user *offset, size_t count)
 {
 	loff_t pos;
 	ssize_t ret;
@@ -630,6 +664,3 @@
 
 	return do_sendfile(out_fd, in_fd, NULL, count, 0);
 }
-
-EXPORT_SYMBOL(do_sync_read);
-EXPORT_SYMBOL(do_sync_write);
diff -Nru a/fs/select.c b/fs/select.c
--- a/fs/select.c	Thu Oct  2 02:44:46 2003
+++ b/fs/select.c	Thu Oct  2 02:44:46 2003
@@ -14,6 +14,7 @@
  *     of fds to overcome nfds < 16390 descriptors limit (Tigran Aivazian).
  */
 
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/poll.h>
@@ -53,7 +54,8 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p);
+void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
+		poll_table *p);
 
 void poll_initwait(struct poll_wqueues *pwq)
 {
@@ -62,6 +64,8 @@
 	pwq->table = NULL;
 }
 
+EXPORT_SYMBOL(poll_initwait);
+
 void poll_freewait(struct poll_wqueues *pwq)
 {
 	struct poll_table_page * p = pwq->table;
@@ -81,7 +85,10 @@
 	}
 }
 
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *_p)
+EXPORT_SYMBOL(poll_freewait);
+
+void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
+		poll_table *_p)
 {
 	struct poll_wqueues *p = container_of(_p, struct poll_wqueues, pt);
 	struct poll_table_page *table = p->table;
@@ -89,7 +96,7 @@
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;
 
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
+		new_table = (struct poll_table_page *)__get_free_page(GFP_KERNEL);
 		if (!new_table) {
 			p->error = -ENOMEM;
 			__set_current_state(TASK_RUNNING);
@@ -266,6 +273,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(do_select);
+
 static void *select_bits_alloc(int size)
 {
 	return kmalloc(6 * size, GFP_KERNEL);
@@ -287,8 +296,8 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage long
-sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
+asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
+			   fd_set __user *exp, struct timeval __user *tvp)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -388,8 +397,8 @@
 
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
 
-static void do_pollfd(unsigned int num, struct pollfd * fdpage,
-	poll_table ** pwait, int *count)
+static void do_pollfd(unsigned int num, struct pollfd *fdpage,
+		      poll_table **pwait, int *count)
 {
 	int i;
 
@@ -421,7 +430,7 @@
 }
 
 static int do_poll(unsigned int nfds,  struct poll_list *list,
-			struct poll_wqueues *wait, long timeout)
+		   struct poll_wqueues *wait, long timeout)
 {
 	int count = 0;
 	poll_table* pt = &wait->pt;
@@ -449,7 +458,8 @@
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
+			 long timeout)
 {
 	struct poll_wqueues table;
  	int fdcount, err;
diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Thu Oct  2 02:44:46 2003
+++ b/fs/stat.c	Thu Oct  2 02:44:46 2003
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -33,6 +34,8 @@
 	stat->blksize = inode->i_blksize;
 }
 
+EXPORT_SYMBOL(generic_fillattr);
+
 int vfs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 {
 	struct inode *inode = dentry->d_inode;
@@ -56,6 +59,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(vfs_getattr);
+
 int vfs_stat(char __user *name, struct kstat *stat)
 {
 	struct nameidata nd;
@@ -69,6 +74,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(vfs_stat);
+
 int vfs_lstat(char __user *name, struct kstat *stat)
 {
 	struct nameidata nd;
@@ -82,6 +89,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(vfs_lstat);
+
 int vfs_fstat(unsigned int fd, struct kstat *stat)
 {
 	struct file *f = fget(fd);
@@ -94,6 +103,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(vfs_fstat);
+
 #if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
   && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) && !defined(__x86_64__) \
   && !defined(__arm__) && !defined(CONFIG_V850) && !defined(__powerpc64__)
@@ -102,14 +113,16 @@
  * For backward compatibility?  Maybe this should be moved
  * into arch/i386 instead?
  */
-static int cp_old_stat(struct kstat *stat, struct __old_kernel_stat __user * statbuf)
+static int cp_old_stat(struct kstat *stat,
+		       struct __old_kernel_stat __user *statbuf)
 {
 	static int warncount = 5;
 	struct __old_kernel_stat tmp;
 	
 	if (warncount > 0) {
 		warncount--;
-		printk(KERN_WARNING "VFS: Warning: %s using old stat() call. Recompile your binary.\n",
+		printk(KERN_WARNING "VFS: Warning: %s using old stat() "
+				    "call. Recompile your binary.\n",
 			current->comm);
 	} else if (warncount < 0) {
 		/* it's laughable, but... */
@@ -135,7 +148,8 @@
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
-asmlinkage long sys_stat(char __user * filename, struct __old_kernel_stat __user * statbuf)
+asmlinkage long sys_stat(char __user *filename,
+			 struct __old_kernel_stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
@@ -145,7 +159,8 @@
 
 	return error;
 }
-asmlinkage long sys_lstat(char __user * filename, struct __old_kernel_stat __user * statbuf)
+asmlinkage long sys_lstat(char __user *filename,
+			  struct __old_kernel_stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
@@ -155,7 +170,9 @@
 
 	return error;
 }
-asmlinkage long sys_fstat(unsigned int fd, struct __old_kernel_stat __user * statbuf)
+
+asmlinkage long sys_fstat(unsigned int fd,
+			  struct __old_kernel_stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
@@ -214,7 +231,8 @@
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
-asmlinkage long sys_newstat(char __user * filename, struct stat __user * statbuf)
+asmlinkage long sys_newstat(char __user *filename,
+			    struct stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
@@ -224,7 +242,8 @@
 
 	return error;
 }
-asmlinkage long sys_newlstat(char __user * filename, struct stat __user * statbuf)
+asmlinkage long sys_newlstat(char __user *filename,
+			     struct stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
@@ -234,7 +253,7 @@
 
 	return error;
 }
-asmlinkage long sys_newfstat(unsigned int fd, struct stat __user * statbuf)
+asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
@@ -245,7 +264,8 @@
 	return error;
 }
 
-asmlinkage long sys_readlink(const char __user * path, char __user * buf, int bufsiz)
+asmlinkage long sys_readlink(const char __user *path,
+			     char __user *buf, int bufsiz)
 {
 	struct nameidata nd;
 	int error;
@@ -309,7 +329,8 @@
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
-asmlinkage long sys_stat64(char __user * filename, struct stat64 __user * statbuf, long flags)
+asmlinkage long sys_stat64(char __user *filename,
+			   struct stat64 __user *statbuf, long flags)
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
@@ -319,7 +340,9 @@
 
 	return error;
 }
-asmlinkage long sys_lstat64(char __user * filename, struct stat64 __user * statbuf, long flags)
+
+asmlinkage long sys_lstat64(char __user *filename,
+			    struct stat64 __user *statbuf, long flags)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
@@ -329,7 +352,9 @@
 
 	return error;
 }
-asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user * statbuf, long flags)
+
+asmlinkage long sys_fstat64(unsigned long fd,
+			    struct stat64 __user *statbuf, long flags)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
@@ -355,6 +380,8 @@
 	spin_unlock(&inode->i_lock);
 }
 
+EXPORT_SYMBOL(inode_add_bytes);
+
 void inode_sub_bytes(struct inode *inode, loff_t bytes)
 {
 	spin_lock(&inode->i_lock);
@@ -368,6 +395,8 @@
 	spin_unlock(&inode->i_lock);
 }
 
+EXPORT_SYMBOL(inode_sub_bytes);
+
 loff_t inode_get_bytes(struct inode *inode)
 {
 	loff_t ret;
@@ -378,8 +407,12 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(inode_get_bytes);
+
 void inode_set_bytes(struct inode *inode, loff_t bytes)
 {
 	inode->i_blocks = bytes >> 9;
 	inode->i_bytes = bytes & 511;
 }
+
+EXPORT_SYMBOL(inode_set_bytes);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Oct  2 02:44:46 2003
+++ b/kernel/ksyms.c	Thu Oct  2 02:44:46 2003
@@ -137,65 +137,18 @@
 EXPORT_SYMBOL(get_user_pages);
 
 /* filesystem internal functions */
-EXPORT_SYMBOL(get_fs_type);
-EXPORT_SYMBOL(fput);
-EXPORT_SYMBOL(fget);
-EXPORT_SYMBOL(lookup_mnt);
-EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
-EXPORT_SYMBOL(__mark_inode_dirty);
-EXPORT_SYMBOL(get_empty_filp);
-EXPORT_SYMBOL(open_private_file);
-EXPORT_SYMBOL(close_private_file);
-EXPORT_SYMBOL(filp_open);
-EXPORT_SYMBOL(filp_close);
-EXPORT_SYMBOL(put_filp);
-EXPORT_SYMBOL(files_lock);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
-EXPORT_SYMBOL(inode_setattr);
-EXPORT_SYMBOL(inode_change_ok);
-EXPORT_SYMBOL(write_inode_now);
-EXPORT_SYMBOL(notify_change);
 EXPORT_SYMBOL(blockdev_direct_IO);
 EXPORT_SYMBOL(file_ra_state_init);
-EXPORT_SYMBOL(generic_ro_fops);
-EXPORT_SYMBOL(get_unused_fd);
-EXPORT_SYMBOL(vfs_read);
-EXPORT_SYMBOL(vfs_readv);
-EXPORT_SYMBOL(vfs_write);
-EXPORT_SYMBOL(vfs_writev);
-EXPORT_SYMBOL(vfs_statfs);
-EXPORT_SYMBOL(vfs_fstat);
-EXPORT_SYMBOL(vfs_stat);
-EXPORT_SYMBOL(vfs_lstat);
-EXPORT_SYMBOL(vfs_getattr);
-EXPORT_SYMBOL(inode_add_bytes);
-EXPORT_SYMBOL(inode_sub_bytes);
-EXPORT_SYMBOL(inode_get_bytes);
-EXPORT_SYMBOL(inode_set_bytes);
-EXPORT_SYMBOL(generic_fillattr);
-EXPORT_SYMBOL(generic_file_llseek);
-EXPORT_SYMBOL(remote_llseek);
-EXPORT_SYMBOL(no_llseek);
-EXPORT_SYMBOL(poll_initwait);
-EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(read_cache_pages);
 EXPORT_SYMBOL(mark_page_accessed);
 EXPORT_SYMBOL(vfs_readdir);
-EXPORT_SYMBOL(__break_lease);
-EXPORT_SYMBOL(lease_get_mtime);
-EXPORT_SYMBOL(lock_may_read);
-EXPORT_SYMBOL(lock_may_write);
-EXPORT_SYMBOL(fd_install);
-EXPORT_SYMBOL(put_unused_fd);
-EXPORT_SYMBOL(do_select);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
-EXPORT_SYMBOL(default_llseek);
-EXPORT_SYMBOL(dentry_open);
 EXPORT_SYMBOL(lock_page);
 
 /* device registration */
@@ -206,20 +159,12 @@
 EXPORT_SYMBOL(tty_std_termios);
 
 /* block device driver support */
-EXPORT_SYMBOL(read_dev_sector);
-EXPORT_SYMBOL(iov_shorten);
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_wait_until_sent);
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
-/* filesystem registration */
-EXPORT_SYMBOL(register_filesystem);
-EXPORT_SYMBOL(unregister_filesystem);
-EXPORT_SYMBOL(__mntput);
-EXPORT_SYMBOL(may_umount);
-
 /* interrupt handling */
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
@@ -295,8 +240,6 @@
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(vsscanf);
-EXPORT_SYMBOL(__bdevname);
-EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(simple_strtoull);
 EXPORT_SYMBOL(simple_strtoul);
 EXPORT_SYMBOL(simple_strtol);
@@ -321,7 +264,6 @@
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(__inode_dir_notify);
-EXPORT_SYMBOL(generic_osync_inode);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
@@ -330,10 +272,6 @@
 EXPORT_SYMBOL(fs_overflowuid);
 EXPORT_SYMBOL(fs_overflowgid);
 
-/* all busmice */
-EXPORT_SYMBOL(fasync_helper);
-EXPORT_SYMBOL(kill_fasync);
-
 /* library functions */
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
@@ -350,7 +288,6 @@
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
 /* init task, for moving kthread roots - ought to export a function ?? */
-
 EXPORT_SYMBOL(init_task);
 
 EXPORT_SYMBOL(tasklist_lock);
@@ -359,9 +296,6 @@
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
-
-EXPORT_SYMBOL(set_fs_pwd);
-EXPORT_SYMBOL(set_fs_root);
 
 /* debug */
 EXPORT_SYMBOL(dump_stack);

===================================================================
