Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSLEQ15>; Thu, 5 Dec 2002 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSLEQ15>; Thu, 5 Dec 2002 11:27:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13072 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262380AbSLEQ0R>;
	Thu, 5 Dec 2002 11:26:17 -0500
Date: Thu, 5 Dec 2002 08:33:39 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205163339.GD2865@kroah.com>
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com> <20021205163300.GC2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205163300.GC2865@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.797.142.2, 2002/12/04 16:01:47-06:00, greg@kroah.com

LSM: Added security_fixup_ops()

This allows LSM code to only define the functions that they want to,
and not be forced to provide "dummy" functions for everything else.


diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Thu Dec  5 01:19:17 2002
+++ b/security/dummy.c	Thu Dec  5 01:19:17 2002
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
 
diff -Nru a/security/security.c b/security/security.c
--- a/security/security.c	Thu Dec  5 01:19:17 2002
+++ b/security/security.c	Thu Dec  5 01:19:17 2002
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
