Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVEAQCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEAQCG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEAPsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:48:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48904 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261675AbVEAPmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:42:35 -0400
Date: Sun, 1 May 2005 17:42:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/: make some code static
Message-ID: <20050501154231.GP3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2005

 fs/bad_inode.c          |    2 +-
 fs/buffer.c             |    2 +-
 fs/char_dev.c           |    2 +-
 fs/dcache.c             |    2 +-
 fs/eventpoll.c          |    2 +-
 fs/exec.c               |    3 ++-
 fs/locks.c              |    6 +++---
 fs/mbcache.c            |    2 +-
 fs/mpage.c              |    2 +-
 fs/namei.c              |    8 ++++----
 fs/select.c             |    6 ++++--
 include/linux/binfmts.h |    1 -
 12 files changed, 20 insertions(+), 18 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/bad_inode.c.old	2005-04-23 02:27:20.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/bad_inode.c	2005-04-23 02:27:30.000000000 +0200
@@ -47,7 +47,7 @@
 	.get_unmapped_area = EIO_ERROR,
 };
 
-struct inode_operations bad_inode_ops =
+static struct inode_operations bad_inode_ops =
 {
 	.create		= EIO_ERROR,
 	.lookup		= EIO_ERROR,
--- linux-2.6.12-rc2-mm3-full/fs/buffer.c.old	2005-04-23 02:29:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/buffer.c	2005-04-23 02:29:15.000000000 +0200
@@ -1215,7 +1215,7 @@
 	return 1;
 }
 
-struct buffer_head *
+static struct buffer_head *
 __getblk_slow(struct block_device *bdev, sector_t block, int size)
 {
 	/* Size must be multiple of hard sectorsize */
--- linux-2.6.12-rc2-mm3-full/fs/char_dev.c.old	2005-04-23 02:29:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/char_dev.c	2005-04-23 02:30:02.000000000 +0200
@@ -329,7 +329,7 @@
 	spin_unlock(&cdev_lock);
 }
 
-void cdev_purge(struct cdev *cdev)
+static void cdev_purge(struct cdev *cdev)
 {
 	spin_lock(&cdev_lock);
 	while (!list_empty(&cdev->list)) {
--- linux-2.6.12-rc2-mm3-full/fs/dcache.c.old	2005-04-23 02:30:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/dcache.c	2005-04-23 02:30:46.000000000 +0200
@@ -39,7 +39,7 @@
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(dcache_lock);
-seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
+static seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 
 EXPORT_SYMBOL(dcache_lock);
 
--- linux-2.6.12-rc2-mm3-full/fs/eventpoll.c.old	2005-04-23 02:31:07.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/eventpoll.c	2005-04-23 02:31:17.000000000 +0200
@@ -320,7 +320,7 @@
 /*
  * This semaphore is used to serialize ep_free() and eventpoll_release_file().
  */
-struct semaphore epsem;
+static struct semaphore epsem;
 
 /* Safe wake up implementation */
 static struct poll_safewake psw;
--- linux-2.6.12-rc2-mm3-full/include/linux/binfmts.h.old	2005-04-23 02:32:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/binfmts.h	2005-04-23 02:32:16.000000000 +0200
@@ -77,7 +77,6 @@
 extern int setup_arg_pages(struct linux_binprm * bprm,
 			   unsigned long stack_top,
 			   int executable_stack);
-extern int copy_strings(int argc,char __user * __user * argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
 extern int do_coredump(long signr, int exit_code, struct pt_regs * regs);
--- linux-2.6.12-rc2-mm3-full/fs/exec.c.old	2005-04-23 02:32:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/exec.c	2005-04-23 02:32:47.000000000 +0200
@@ -197,7 +197,8 @@
  * memory to free pages in kernel mem. These are in a format ready
  * to be put directly into the top of new user memory.
  */
-int copy_strings(int argc,char __user * __user * argv, struct linux_binprm *bprm)
+static int copy_strings(int argc, char __user * __user * argv,
+			struct linux_binprm *bprm)
 {
 	struct page *kmapped_page = NULL;
 	char *kaddr = NULL;
--- linux-2.6.12-rc2-mm3-full/fs/locks.c.old	2005-04-23 02:36:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/locks.c	2005-04-23 02:37:12.000000000 +0200
@@ -406,12 +406,12 @@
 	fl->fl_file->f_owner.signum = 0;
 }
 
-int lease_mylease_callback(struct file_lock *fl, struct file_lock *try)
+static int lease_mylease_callback(struct file_lock *fl, struct file_lock *try)
 {
 	return fl->fl_file == try->fl_file;
 }
 
-struct lock_manager_operations lease_manager_ops = {
+static struct lock_manager_operations lease_manager_ops = {
 	.fl_break = lease_break_callback,
 	.fl_release_private = lease_release_private_callback,
 	.fl_mylease = lease_mylease_callback,
@@ -1274,7 +1274,7 @@
  *
  *	Called with kernel lock held.
  */
-int __setlease(struct file *filp, long arg, struct file_lock **flp)
+static int __setlease(struct file *filp, long arg, struct file_lock **flp)
 {
 	struct file_lock *fl, **before, **my_before = NULL, *lease = *flp;
 	struct dentry *dentry = filp->f_dentry;
--- linux-2.6.12-rc2-mm3-full/fs/mbcache.c.old	2005-04-23 02:37:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/mbcache.c	2005-04-23 02:37:35.000000000 +0200
@@ -57,7 +57,7 @@
 
 #define MB_CACHE_WRITER ((unsigned short)~0U >> 1)
 
-DECLARE_WAIT_QUEUE_HEAD(mb_cache_queue);
+static DECLARE_WAIT_QUEUE_HEAD(mb_cache_queue);
 		
 MODULE_AUTHOR("Andreas Gruenbacher <a.gruenbacher@computer.org>");
 MODULE_DESCRIPTION("Meta block cache (for extended attributes)");
--- linux-2.6.12-rc2-mm3-full/fs/mpage.c.old	2005-04-23 02:37:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/mpage.c	2005-04-23 02:37:56.000000000 +0200
@@ -87,7 +87,7 @@
 	return 0;
 }
 
-struct bio *mpage_bio_submit(int rw, struct bio *bio)
+static struct bio *mpage_bio_submit(int rw, struct bio *bio)
 {
 	bio->bi_end_io = mpage_end_io_read;
 	if (rw == WRITE)
--- linux-2.6.12-rc2-mm3-full/fs/namei.c.old	2005-04-23 02:38:33.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/namei.c	2005-04-23 02:39:02.000000000 +0200
@@ -2068,8 +2068,8 @@
  *	   ->i_sem on parents, which works but leads to some truely excessive
  *	   locking].
  */
-int vfs_rename_dir(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+static int vfs_rename_dir(struct inode *old_dir, struct dentry *old_dentry,
+			  struct inode *new_dir, struct dentry *new_dentry)
 {
 	int error = 0;
 	struct inode *target;
@@ -2113,8 +2113,8 @@
 	return error;
 }
 
-int vfs_rename_other(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+static int vfs_rename_other(struct inode *old_dir, struct dentry *old_dentry,
+			    struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct inode *target;
 	int error;
--- linux-2.6.12-rc2-mm3-full/fs/select.c.old	2005-04-23 02:41:02.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/select.c	2005-04-23 02:41:22.000000000 +0200
@@ -55,7 +55,8 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p);
+static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
+		       poll_table *p);
 
 void poll_initwait(struct poll_wqueues *pwq)
 {
@@ -87,7 +88,8 @@
 
 EXPORT_SYMBOL(poll_freewait);
 
-void __pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *_p)
+static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
+		       poll_table *_p)
 {
 	struct poll_wqueues *p = container_of(_p, struct poll_wqueues, pt);
 	struct poll_table_page *table = p->table;

