Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSLDIHW>; Wed, 4 Dec 2002 03:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSLDIHW>; Wed, 4 Dec 2002 03:07:22 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:22522 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S266943AbSLDIHK>; Wed, 4 Dec 2002 03:07:10 -0500
Date: Wed, 4 Dec 2002 00:14:38 -0800
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions - take 2
Message-ID: <20021204001438.B25613@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <20021201083056.GJ679@kroah.com> <20021204001322.GA23464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021204001322.GA23464@kroah.com>; from greg@kroah.com on Tue, Dec 03, 2002 at 04:13:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> 
> If there aren't any objections, I'll be sending this out to Linus soon.

Why did you uninline verify()?  It actually increases the size of
security.o:

w/ inline
$ size security/security.o
   text    data     bss     dec     hex filename
   1925       0       4    1929     789 security/security.o

w/out inline
$ size security/security.o
   text    data     bss     dec     hex filename
   1957       0       4    1961     7a9 security/security.o

Also, I think the fixup should go directly in verify, since they are
always called together.  Otherwise, this looks good.  Thanks, it's been
sorely needed.

thanks,
-chris

--- linux-2.5/security/capability.c.lsm	Tue Dec  3 23:25:46 2002
+++ linux-2.5/security/capability.c	Tue Dec  3 23:25:46 2002
@@ -279,550 +279,20 @@
 
 #ifdef CONFIG_SECURITY
 
-static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on (struct file *f)
-{
-	return 0;
-}
-
-static int cap_acct (struct file *file)
-{
-	return 0;
-}
-
-static int cap_bprm_alloc_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int cap_bprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_free_security (struct linux_binprm *bprm)
-{
-	return;
-}
-
-static int cap_sb_alloc_security (struct super_block *sb)
-{
-	return 0;
-}
-
-static void cap_sb_free_security (struct super_block *sb)
-{
-	return;
-}
-
-static int cap_sb_statfs (struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_mount (char *dev_name, struct nameidata *nd, char *type,
-		      unsigned long flags, void *data)
-{
-	return 0;
-}
-
-static int cap_check_sb (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return 0;
-}
-
-static int cap_umount (struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static void cap_umount_close (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void cap_umount_busy (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void cap_post_remount (struct vfsmount *mnt, unsigned long flags,
-			      void *data)
-{
-	return;
-}
-
-static void cap_post_mountroot (void)
-{
-	return;
-}
-
-static void cap_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return;
-}
-
-static int cap_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return 0;
-}
-
-static void cap_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return;
-}
-
-static int cap_inode_alloc_security (struct inode *inode)
-{
-	return 0;
-}
-
-static void cap_inode_free_security (struct inode *inode)
-{
-	return;
-}
-
-static int cap_inode_create (struct inode *inode, struct dentry *dentry,
-			     int mask)
-{
-	return 0;
-}
-
-static void cap_inode_post_create (struct inode *inode, struct dentry *dentry,
-				   int mask)
-{
-	return;
-}
-
-static int cap_inode_link (struct dentry *old_dentry, struct inode *inode,
-			   struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_link (struct dentry *old_dentry, struct inode *inode,
-				 struct dentry *new_dentry)
-{
-	return;
-}
-
-static int cap_inode_unlink (struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_symlink (struct inode *inode, struct dentry *dentry,
-			      const char *name)
-{
-	return 0;
-}
-
-static void cap_inode_post_symlink (struct inode *inode, struct dentry *dentry,
-				    const char *name)
-{
-	return;
-}
-
-static int cap_inode_mkdir (struct inode *inode, struct dentry *dentry,
-			    int mask)
-{
-	return 0;
-}
-
-static void cap_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
-				  int mask)
-{
-	return;
-}
-
-static int cap_inode_rmdir (struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_mknod (struct inode *inode, struct dentry *dentry,
-			    int mode, dev_t dev)
-{
-	return 0;
-}
-
-static void cap_inode_post_mknod (struct inode *inode, struct dentry *dentry,
-				  int mode, dev_t dev)
-{
-	return;
-}
-
-static int cap_inode_rename (struct inode *old_inode, struct dentry *old_dentry,
-			     struct inode *new_inode, struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_rename (struct inode *old_inode,
-				   struct dentry *old_dentry,
-				   struct inode *new_inode,
-				   struct dentry *new_dentry)
-{
-	return;
-}
-
-static int cap_inode_readlink (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_follow_link (struct dentry *dentry,
-				  struct nameidata *nameidata)
-{
-	return 0;
-}
-
-static int cap_inode_permission (struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int cap_inode_permission_lite (struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int cap_inode_setattr (struct dentry *dentry, struct iattr *iattr)
-{
-	return 0;
-}
-
-static int cap_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
-{
-	return 0;
-}
-
-static void cap_post_lookup (struct inode *ino, struct dentry *d)
-{
-	return;
-}
-
-static void cap_delete (struct inode *ino)
-{
-	return;
-}
-
-static int cap_inode_setxattr (struct dentry *dentry, char *name, void *value,
-				size_t size, int flags)
-{
-	return 0;
-}
-
-static int cap_inode_getxattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static int cap_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_removexattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static int cap_file_permission (struct file *file, int mask)
-{
-	return 0;
-}
-
-static int cap_file_alloc_security (struct file *file)
-{
-	return 0;
-}
-
-static void cap_file_free_security (struct file *file)
-{
-	return;
-}
-
-static int cap_file_ioctl (struct file *file, unsigned int command,
-			   unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_mmap (struct file *file, unsigned long prot,
-			  unsigned long flags)
-{
-	return 0;
-}
-
-static int cap_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
-{
-	return 0;
-}
-
-static int cap_file_lock (struct file *file, unsigned int cmd)
-{
-	return 0;
-}
-
-static int cap_file_fcntl (struct file *file, unsigned int cmd,
-			   unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_set_fowner (struct file *file)
-{
-	return 0;
-}
-
-static int cap_file_send_sigiotask (struct task_struct *tsk,
-				    struct fown_struct *fown, int fd,
-				    int reason)
-{
-	return 0;
-}
-
-static int cap_file_receive (struct file *file)
-{
-	return 0;
-}
-
-static int cap_task_create (unsigned long clone_flags)
-{
-	return 0;
-}
-
-static int cap_task_alloc_security (struct task_struct *p)
-{
-	return 0;
-}
-
-static void cap_task_free_security (struct task_struct *p)
-{
-	return;
-}
-
-static int cap_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
-{
-	return 0;
-}
-
-static int cap_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
-{
-	return 0;
-}
-
-static int cap_task_setpgid (struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
-
-static int cap_task_getpgid (struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_getsid (struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_setgroups (int gidsetsize, gid_t * grouplist)
-{
-	return 0;
-}
-
-static int cap_task_setnice (struct task_struct *p, int nice)
-{
-	return 0;
-}
-
-static int cap_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static int cap_task_setscheduler (struct task_struct *p, int policy,
-				  struct sched_param *lp)
-{
-	return 0;
-}
-
-static int cap_task_getscheduler (struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_wait (struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_kill (struct task_struct *p, struct siginfo *info, int sig)
-{
-	return 0;
-}
-
-static int cap_task_prctl (int option, unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, unsigned long arg5)
-{
-	return 0;
-}
-
-static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
-{
-	return 0;
-}
-
-static int cap_msg_queue_alloc_security (struct msg_queue *msq)
-{
-	return 0;
-}
-
-static void cap_msg_queue_free_security (struct msg_queue *msq)
-{
-	return;
-}
-
-static int cap_shm_alloc_security (struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static void cap_shm_free_security (struct shmid_kernel *shp)
-{
-	return;
-}
-
-static int cap_sem_alloc_security (struct sem_array *sma)
-{
-	return 0;
-}
-
-static void cap_sem_free_security (struct sem_array *sma)
-{
-	return;
-}
-
-static int cap_register (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static int cap_unregister (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
 
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
 	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
-	.acct =				cap_acct,
 	.capable =			cap_capable,
-	.quotactl =			cap_quotactl,
-	.quota_on =			cap_quota_on,
 
-	.bprm_alloc_security =		cap_bprm_alloc_security,
-	.bprm_free_security =		cap_bprm_free_security,
 	.bprm_compute_creds =		cap_bprm_compute_creds,
 	.bprm_set_security =		cap_bprm_set_security,
-	.bprm_check_security =		cap_bprm_check_security,
-
-	.sb_alloc_security =		cap_sb_alloc_security,
-	.sb_free_security =		cap_sb_free_security,
-	.sb_statfs =			cap_sb_statfs,
-	.sb_mount =			cap_mount,
-	.sb_check_sb =			cap_check_sb,
-	.sb_umount =			cap_umount,
-	.sb_umount_close =		cap_umount_close,
-	.sb_umount_busy =		cap_umount_busy,
-	.sb_post_remount =		cap_post_remount,
-	.sb_post_mountroot =		cap_post_mountroot,
-	.sb_post_addmount =		cap_post_addmount,
-	.sb_pivotroot =			cap_pivotroot,
-	.sb_post_pivotroot =		cap_post_pivotroot,
-	
-	.inode_alloc_security =		cap_inode_alloc_security,
-	.inode_free_security =		cap_inode_free_security,
-	.inode_create =			cap_inode_create,
-	.inode_post_create =		cap_inode_post_create,
-	.inode_link =			cap_inode_link,
-	.inode_post_link =		cap_inode_post_link,
-	.inode_unlink =			cap_inode_unlink,
-	.inode_symlink =		cap_inode_symlink,
-	.inode_post_symlink =		cap_inode_post_symlink,
-	.inode_mkdir =			cap_inode_mkdir,
-	.inode_post_mkdir =		cap_inode_post_mkdir,
-	.inode_rmdir =			cap_inode_rmdir,
-	.inode_mknod =			cap_inode_mknod,
-	.inode_post_mknod =		cap_inode_post_mknod,
-	.inode_rename =			cap_inode_rename,
-	.inode_post_rename =		cap_inode_post_rename,
-	.inode_readlink =		cap_inode_readlink,
-	.inode_follow_link =		cap_inode_follow_link,
-	.inode_permission =		cap_inode_permission,
-	.inode_permission_lite =	cap_inode_permission_lite,
-	.inode_setattr =		cap_inode_setattr,
-	.inode_getattr =		cap_inode_getattr,
-	.inode_post_lookup =		cap_post_lookup,
-	.inode_delete =			cap_delete,
-	.inode_setxattr =		cap_inode_setxattr,
-	.inode_getxattr =		cap_inode_getxattr,
-	.inode_listxattr =		cap_inode_listxattr,
-	.inode_removexattr =		cap_inode_removexattr,
-	
-	.file_permission =		cap_file_permission,
-	.file_alloc_security =		cap_file_alloc_security,
-	.file_free_security =		cap_file_free_security,
-	.file_ioctl =			cap_file_ioctl,
-	.file_mmap =			cap_file_mmap,
-	.file_mprotect =		cap_file_mprotect,
-	.file_lock =			cap_file_lock,
-	.file_fcntl =			cap_file_fcntl,
-	.file_set_fowner =		cap_file_set_fowner,
-	.file_send_sigiotask =		cap_file_send_sigiotask,
-	.file_receive =			cap_file_receive,
 
-	.task_create =			cap_task_create,
-	.task_alloc_security =		cap_task_alloc_security,
-	.task_free_security =		cap_task_free_security,
-	.task_setuid =			cap_task_setuid,
 	.task_post_setuid =		cap_task_post_setuid,
-	.task_setgid =			cap_task_setgid,
-	.task_setpgid =			cap_task_setpgid,
-	.task_getpgid =			cap_task_getpgid,
-	.task_getsid =			cap_task_getsid,
-	.task_setgroups =		cap_task_setgroups,
-	.task_setnice =			cap_task_setnice,
-	.task_setrlimit =		cap_task_setrlimit,
-	.task_setscheduler =		cap_task_setscheduler,
-	.task_getscheduler =		cap_task_getscheduler,
-	.task_wait =			cap_task_wait,
-	.task_kill =			cap_task_kill,
-	.task_prctl =			cap_task_prctl,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
-
-	.ipc_permission =		cap_ipc_permission,
-
-	.msg_queue_alloc_security =	cap_msg_queue_alloc_security,
-	.msg_queue_free_security =	cap_msg_queue_free_security,
-	
-	.shm_alloc_security =		cap_shm_alloc_security,
-	.shm_free_security =		cap_shm_free_security,
-	
-	.sem_alloc_security =		cap_sem_alloc_security,
-	.sem_free_security =		cap_sem_free_security,
-
-	.register_security =		cap_register,
-	.unregister_security =		cap_unregister,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
--- linux-2.5/security/dummy.c.lsm	Tue Dec  3 23:25:46 2002
+++ linux-2.5/security/dummy.c	Tue Dec  3 23:25:46 2002
@@ -12,6 +12,8 @@
  *	(at your option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -19,6 +21,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 
+
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	return 0;
@@ -122,55 +125,55 @@
 	return 0;
 }
 
-static int dummy_mount (char *dev_name, struct nameidata *nd, char *type,
-			unsigned long flags, void *data)
+static int dummy_sb_mount (char *dev_name, struct nameidata *nd, char *type,
+			   unsigned long flags, void *data)
 {
 	return 0;
 }
 
-static int dummy_check_sb (struct vfsmount *mnt, struct nameidata *nd)
+static int dummy_sb_check_sb (struct vfsmount *mnt, struct nameidata *nd)
 {
 	return 0;
 }
 
-static int dummy_umount (struct vfsmount *mnt, int flags)
+static int dummy_sb_umount (struct vfsmount *mnt, int flags)
 {
 	return 0;
 }
 
-static void dummy_umount_close (struct vfsmount *mnt)
+static void dummy_sb_umount_close (struct vfsmount *mnt)
 {
 	return;
 }
 
-static void dummy_umount_busy (struct vfsmount *mnt)
+static void dummy_sb_umount_busy (struct vfsmount *mnt)
 {
 	return;
 }
 
-static void dummy_post_remount (struct vfsmount *mnt, unsigned long flags,
-				void *data)
+static void dummy_sb_post_remount (struct vfsmount *mnt, unsigned long flags,
+				   void *data)
 {
 	return;
 }
 
 
-static void dummy_post_mountroot (void)
+static void dummy_sb_post_mountroot (void)
 {
 	return;
 }
 
-static void dummy_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
+static void dummy_sb_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
 {
 	return;
 }
 
-static int dummy_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+static int dummy_sb_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
 {
 	return 0;
 }
 
-static void dummy_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+static void dummy_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
 {
 	return;
 }
@@ -303,12 +306,12 @@
 	return 0;
 }
 
-static void dummy_post_lookup (struct inode *ino, struct dentry *d)
+static void dummy_inode_post_lookup (struct inode *ino, struct dentry *d)
 {
 	return;
 }
 
-static void dummy_delete (struct inode *ino)
+static void dummy_inode_delete (struct inode *ino)
 {
 	return;
 }
@@ -529,12 +532,12 @@
 	return;
 }
 
-static int dummy_register (const char *name, struct security_operations *ops)
+static int dummy_register_security (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
 }
 
-static int dummy_unregister (const char *name, struct security_operations *ops)
+static int dummy_unregister_security (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
 }
@@ -558,16 +561,16 @@
 	.sb_alloc_security =		dummy_sb_alloc_security,
 	.sb_free_security =		dummy_sb_free_security,
 	.sb_statfs =			dummy_sb_statfs,
-	.sb_mount =			dummy_mount,
-	.sb_check_sb =			dummy_check_sb,
-	.sb_umount =			dummy_umount,
-	.sb_umount_close =		dummy_umount_close,
-	.sb_umount_busy =		dummy_umount_busy,
-	.sb_post_remount =		dummy_post_remount,
-	.sb_post_mountroot =		dummy_post_mountroot,
-	.sb_post_addmount =		dummy_post_addmount,
-	.sb_pivotroot =			dummy_pivotroot,
-	.sb_post_pivotroot =		dummy_post_pivotroot,
+	.sb_mount =			dummy_sb_mount,
+	.sb_check_sb =			dummy_sb_check_sb,
+	.sb_umount =			dummy_sb_umount,
+	.sb_umount_close =		dummy_sb_umount_close,
+	.sb_umount_busy =		dummy_sb_umount_busy,
+	.sb_post_remount =		dummy_sb_post_remount,
+	.sb_post_mountroot =		dummy_sb_post_mountroot,
+	.sb_post_addmount =		dummy_sb_post_addmount,
+	.sb_pivotroot =			dummy_sb_pivotroot,
+	.sb_post_pivotroot =		dummy_sb_post_pivotroot,
 	
 	.inode_alloc_security =		dummy_inode_alloc_security,
 	.inode_free_security =		dummy_inode_free_security,
@@ -591,8 +594,8 @@
 	.inode_permission_lite =	dummy_inode_permission_lite,
 	.inode_setattr =		dummy_inode_setattr,
 	.inode_getattr =		dummy_inode_getattr,
-	.inode_post_lookup =		dummy_post_lookup,
-	.inode_delete =			dummy_delete,
+	.inode_post_lookup =		dummy_inode_post_lookup,
+	.inode_delete =			dummy_inode_delete,
 	.inode_setxattr =		dummy_inode_setxattr,
 	.inode_getxattr =		dummy_inode_getxattr,
 	.inode_listxattr =		dummy_inode_listxattr,
@@ -641,7 +644,113 @@
 	.sem_alloc_security =		dummy_sem_alloc_security,
 	.sem_free_security =		dummy_sem_free_security,
 
-	.register_security =		dummy_register,
-	.unregister_security =		dummy_unregister,
+	.register_security =		dummy_register_security,
+	.unregister_security =		dummy_unregister_security,
 };
+
+#define set_to_dummy_if_null(ops, function)				\
+	do {								\
+		if (!ops->function) {					\
+			ops->function = dummy_##function;		\
+			pr_debug("Had to override the " #function	\
+				 " security operation with the dummy one.\n");\
+			}						\
+	} while (0)
+
+void security_fixup_ops (struct security_operations *ops)
+{
+	set_to_dummy_if_null(ops, ptrace);
+	set_to_dummy_if_null(ops, capget);
+	set_to_dummy_if_null(ops, capset_check);
+	set_to_dummy_if_null(ops, capset_set);
+	set_to_dummy_if_null(ops, acct);
+	set_to_dummy_if_null(ops, capable);
+	set_to_dummy_if_null(ops, quotactl);
+	set_to_dummy_if_null(ops, quota_on);
+	set_to_dummy_if_null(ops, bprm_alloc_security);
+	set_to_dummy_if_null(ops, bprm_free_security);
+	set_to_dummy_if_null(ops, bprm_compute_creds);
+	set_to_dummy_if_null(ops, bprm_set_security);
+	set_to_dummy_if_null(ops, bprm_check_security);
+	set_to_dummy_if_null(ops, sb_alloc_security);
+	set_to_dummy_if_null(ops, sb_free_security);
+	set_to_dummy_if_null(ops, sb_statfs);
+	set_to_dummy_if_null(ops, sb_mount);
+	set_to_dummy_if_null(ops, sb_check_sb);
+	set_to_dummy_if_null(ops, sb_umount);
+	set_to_dummy_if_null(ops, sb_umount_close);
+	set_to_dummy_if_null(ops, sb_umount_busy);
+	set_to_dummy_if_null(ops, sb_post_remount);
+	set_to_dummy_if_null(ops, sb_post_mountroot);
+	set_to_dummy_if_null(ops, sb_post_addmount);
+	set_to_dummy_if_null(ops, sb_pivotroot);
+	set_to_dummy_if_null(ops, sb_post_pivotroot);
+	set_to_dummy_if_null(ops, inode_alloc_security);
+	set_to_dummy_if_null(ops, inode_free_security);
+	set_to_dummy_if_null(ops, inode_create);
+	set_to_dummy_if_null(ops, inode_post_create);
+	set_to_dummy_if_null(ops, inode_link);
+	set_to_dummy_if_null(ops, inode_post_link);
+	set_to_dummy_if_null(ops, inode_unlink);
+	set_to_dummy_if_null(ops, inode_symlink);
+	set_to_dummy_if_null(ops, inode_post_symlink);
+	set_to_dummy_if_null(ops, inode_mkdir);
+	set_to_dummy_if_null(ops, inode_post_mkdir);
+	set_to_dummy_if_null(ops, inode_rmdir);
+	set_to_dummy_if_null(ops, inode_mknod);
+	set_to_dummy_if_null(ops, inode_post_mknod);
+	set_to_dummy_if_null(ops, inode_rename);
+	set_to_dummy_if_null(ops, inode_post_rename);
+	set_to_dummy_if_null(ops, inode_readlink);
+	set_to_dummy_if_null(ops, inode_follow_link);
+	set_to_dummy_if_null(ops, inode_permission);
+	set_to_dummy_if_null(ops, inode_permission_lite);
+	set_to_dummy_if_null(ops, inode_setattr);
+	set_to_dummy_if_null(ops, inode_getattr);
+	set_to_dummy_if_null(ops, inode_post_lookup);
+	set_to_dummy_if_null(ops, inode_delete);
+	set_to_dummy_if_null(ops, inode_setxattr);
+	set_to_dummy_if_null(ops, inode_getxattr);
+	set_to_dummy_if_null(ops, inode_listxattr);
+	set_to_dummy_if_null(ops, inode_removexattr);
+	set_to_dummy_if_null(ops, file_permission);
+	set_to_dummy_if_null(ops, file_alloc_security);
+	set_to_dummy_if_null(ops, file_free_security);
+	set_to_dummy_if_null(ops, file_ioctl);
+	set_to_dummy_if_null(ops, file_mmap);
+	set_to_dummy_if_null(ops, file_mprotect);
+	set_to_dummy_if_null(ops, file_lock);
+	set_to_dummy_if_null(ops, file_fcntl);
+	set_to_dummy_if_null(ops, file_set_fowner);
+	set_to_dummy_if_null(ops, file_send_sigiotask);
+	set_to_dummy_if_null(ops, file_receive);
+	set_to_dummy_if_null(ops, task_create);
+	set_to_dummy_if_null(ops, task_alloc_security);
+	set_to_dummy_if_null(ops, task_free_security);
+	set_to_dummy_if_null(ops, task_setuid);
+	set_to_dummy_if_null(ops, task_post_setuid);
+	set_to_dummy_if_null(ops, task_setgid);
+	set_to_dummy_if_null(ops, task_setpgid);
+	set_to_dummy_if_null(ops, task_getpgid);
+	set_to_dummy_if_null(ops, task_getsid);
+	set_to_dummy_if_null(ops, task_setgroups);
+	set_to_dummy_if_null(ops, task_setnice);
+	set_to_dummy_if_null(ops, task_setrlimit);
+	set_to_dummy_if_null(ops, task_setscheduler);
+	set_to_dummy_if_null(ops, task_getscheduler);
+	set_to_dummy_if_null(ops, task_wait);
+	set_to_dummy_if_null(ops, task_kill);
+	set_to_dummy_if_null(ops, task_prctl);
+	set_to_dummy_if_null(ops, task_kmod_set_label);
+	set_to_dummy_if_null(ops, task_reparent_to_init);
+	set_to_dummy_if_null(ops, ipc_permission);
+	set_to_dummy_if_null(ops, msg_queue_alloc_security);
+	set_to_dummy_if_null(ops, msg_queue_free_security);
+	set_to_dummy_if_null(ops, shm_alloc_security);
+	set_to_dummy_if_null(ops, shm_free_security);
+	set_to_dummy_if_null(ops, sem_alloc_security);
+	set_to_dummy_if_null(ops, sem_free_security);
+	set_to_dummy_if_null(ops, register_security);
+	set_to_dummy_if_null(ops, unregister_security);
+}
 
--- linux-2.5/security/security.c.lsm	Tue Dec  3 23:25:46 2002
+++ linux-2.5/security/security.c	Tue Dec  3 23:45:51 2002
@@ -20,59 +20,21 @@
 
 #define SECURITY_SCAFFOLD_VERSION	"1.0.0"
 
-extern struct security_operations dummy_security_ops;	/* lives in dummy.c */
+/* things that live in dummy.c */
+extern struct security_operations dummy_security_ops;
+extern void security_fixup_ops (struct security_operations *ops);
 
 struct security_operations *security_ops;	/* Initialized to NULL */
 
-/* This macro checks that all pointers in a struct are non-NULL.  It 
- * can be fooled by struct padding for object tile alignment and when
- * pointers to data and pointers to functions aren't the same size.
- * Yes it's ugly, we'll replace it if it becomes a problem.
- */
-#define VERIFY_STRUCT(struct_type, s, e) \
-	do { \
-		unsigned long * __start = (unsigned long *)(s); \
-		unsigned long * __end = __start + \
-				sizeof(struct_type)/sizeof(unsigned long *); \
-		while (__start != __end) { \
-			if (!*__start) { \
-				printk(KERN_INFO "%s is missing something\n",\
-					#struct_type); \
-				e++; \
-				break; \
-			} \
-			__start++; \
-		} \
-	} while (0)
-
-static int inline verify (struct security_operations *ops)
+static inline int verify (struct security_operations *ops)
 {
-	int err;
-
 	/* verify the security_operations structure exists */
 	if (!ops) {
 		printk (KERN_INFO "Passed a NULL security_operations "
 			"pointer, %s failed.\n", __FUNCTION__);
 		return -EINVAL;
 	}
-
-	/* Perform a little sanity checking on our inputs */
-	err = 0;
-
-	/* This first check scans the whole security_ops struct for
-	 * missing structs or functions.
-	 *
-	 * (There is no further check now, but will leave as is until
-	 *  the lazy registration stuff is done -- JM).
-	 */
-	VERIFY_STRUCT(struct security_operations, ops, err);
-
-	if (err) {
-		printk (KERN_INFO "Not enough functions specified in the "
-			"security_operation structure, %s failed.\n",
-			__FUNCTION__);
-		return -EINVAL;
-	}
+	security_fixup_ops (ops);
 	return 0;
 }
 
@@ -106,12 +68,12 @@
  */
 int register_security (struct security_operations *ops)
 {
-
 	if (verify (ops)) {
 		printk (KERN_INFO "%s could not verify "
 			"security_operations structure.\n", __FUNCTION__);
 		return -EINVAL;
 	}
+
 	if (security_ops != &dummy_security_ops) {
 		printk (KERN_INFO "There is already a security "
 			"framework initialized, %s failed.\n", __FUNCTION__);
