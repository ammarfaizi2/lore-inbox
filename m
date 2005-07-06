Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVGFCl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVGFCl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVGFChD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:37:03 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61592 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262054AbVGFCTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:20 -0400
Subject: [PATCH] [13/48] Suspend2 2.1.9.8 for 2.6.12: 403-debug-pagealloc-support.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <1120616440281@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 404-check-mounts-support.patch-old/drivers/usb/core/inode.c 404-check-mounts-support.patch-new/drivers/usb/core/inode.c
--- 404-check-mounts-support.patch-old/drivers/usb/core/inode.c	2005-06-20 11:47:07.000000000 +1000
+++ 404-check-mounts-support.patch-new/drivers/usb/core/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -569,6 +569,7 @@ static struct file_system_type usb_fs_ty
 	.name =		"usbfs",
 	.get_sb =	usb_get_sb,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_RW_S4_RESUME_SAFE,
 };
 
 /* --------------------------------------------------------------------- */
diff -ruNp 404-check-mounts-support.patch-old/fs/block_dev.c 404-check-mounts-support.patch-new/fs/block_dev.c
--- 404-check-mounts-support.patch-old/fs/block_dev.c	2005-06-20 11:47:11.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/block_dev.c	2005-07-04 23:14:19.000000000 +1000
@@ -310,6 +310,7 @@ static struct file_system_type bd_type =
 	.name		= "bdev",
 	.get_sb		= bd_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static struct vfsmount *bd_mnt;
diff -ruNp 404-check-mounts-support.patch-old/fs/debugfs/inode.c 404-check-mounts-support.patch-new/fs/debugfs/inode.c
--- 404-check-mounts-support.patch-old/fs/debugfs/inode.c	2005-02-03 22:33:40.000000000 +1100
+++ 404-check-mounts-support.patch-new/fs/debugfs/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -132,6 +132,7 @@ static struct file_system_type debug_fs_
 	.name =		"debugfs",
 	.get_sb =	debug_get_sb,
 	.kill_sb =	kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static int debugfs_create_by_name(const char *name, mode_t mode,
diff -ruNp 404-check-mounts-support.patch-old/fs/devfs/base.c 404-check-mounts-support.patch-new/fs/devfs/base.c
--- 404-check-mounts-support.patch-old/fs/devfs/base.c	2005-02-03 22:33:40.000000000 +1100
+++ 404-check-mounts-support.patch-new/fs/devfs/base.c	2005-07-04 23:14:19.000000000 +1000
@@ -2560,6 +2560,7 @@ static struct file_system_type devfs_fs_
 	.name = DEVFS_NAME,
 	.get_sb = devfs_get_sb,
 	.kill_sb = kill_anon_super,
+	.fs_flags = FS_RW_S4_RESUME_SAFE,
 };
 
 /*  File operations for devfsd follow  */
diff -ruNp 404-check-mounts-support.patch-old/fs/devpts/inode.c 404-check-mounts-support.patch-new/fs/devpts/inode.c
--- 404-check-mounts-support.patch-old/fs/devpts/inode.c	2005-02-03 22:33:40.000000000 +1100
+++ 404-check-mounts-support.patch-new/fs/devpts/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -139,6 +139,7 @@ static struct file_system_type devpts_fs
 	.name		= "devpts",
 	.get_sb		= devpts_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 /*
diff -ruNp 404-check-mounts-support.patch-old/fs/eventpoll.c 404-check-mounts-support.patch-new/fs/eventpoll.c
--- 404-check-mounts-support.patch-old/fs/eventpoll.c	2005-06-20 11:47:12.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/eventpoll.c	2005-07-04 23:14:19.000000000 +1000
@@ -348,6 +348,7 @@ static struct file_system_type eventpoll
 	.name		= "eventpollfs",
 	.get_sb		= eventpollfs_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 /* Very basic directory entry operations for the eventpoll virtual file system */
diff -ruNp 404-check-mounts-support.patch-old/fs/hugetlbfs/inode.c 404-check-mounts-support.patch-new/fs/hugetlbfs/inode.c
--- 404-check-mounts-support.patch-old/fs/hugetlbfs/inode.c	2005-06-20 11:47:12.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/hugetlbfs/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -728,6 +728,7 @@ static struct file_system_type hugetlbfs
 	.name		= "hugetlbfs",
 	.get_sb		= hugetlbfs_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static struct vfsmount *hugetlbfs_vfsmount;
diff -ruNp 404-check-mounts-support.patch-old/fs/nfs/inode.c 404-check-mounts-support.patch-new/fs/nfs/inode.c
--- 404-check-mounts-support.patch-old/fs/nfs/inode.c	2005-06-20 11:47:13.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/nfs/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -1490,7 +1490,7 @@ static struct file_system_type nfs_fs_ty
 	.name		= "nfs",
 	.get_sb		= nfs_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA|FS_RW_S4_RESUME_SAFE,
 };
 
 #ifdef CONFIG_NFS_V4
diff -ruNp 404-check-mounts-support.patch-old/fs/pipe.c 404-check-mounts-support.patch-new/fs/pipe.c
--- 404-check-mounts-support.patch-old/fs/pipe.c	2005-06-20 11:47:13.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/pipe.c	2005-07-04 23:14:19.000000000 +1000
@@ -810,6 +810,7 @@ static struct file_system_type pipe_fs_t
 	.name		= "pipefs",
 	.get_sb		= pipefs_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static int __init init_pipe_fs(void)
diff -ruNp 404-check-mounts-support.patch-old/fs/proc/root.c 404-check-mounts-support.patch-new/fs/proc/root.c
--- 404-check-mounts-support.patch-old/fs/proc/root.c	2004-12-10 14:26:29.000000000 +1100
+++ 404-check-mounts-support.patch-new/fs/proc/root.c	2005-07-04 23:14:19.000000000 +1000
@@ -34,6 +34,7 @@ static struct file_system_type proc_fs_t
 	.name		= "proc",
 	.get_sb		= proc_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 extern int __init proc_init_inodecache(void);
diff -ruNp 404-check-mounts-support.patch-old/fs/ramfs/inode.c 404-check-mounts-support.patch-new/fs/ramfs/inode.c
--- 404-check-mounts-support.patch-old/fs/ramfs/inode.c	2005-06-20 11:47:13.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/ramfs/inode.c	2005-07-04 23:14:19.000000000 +1000
@@ -218,11 +218,13 @@ static struct file_system_type ramfs_fs_
 	.name		= "ramfs",
 	.get_sb		= ramfs_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 static struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.get_sb		= rootfs_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static int __init init_ramfs_fs(void)
diff -ruNp 404-check-mounts-support.patch-old/fs/super.c 404-check-mounts-support.patch-new/fs/super.c
--- 404-check-mounts-support.patch-old/fs/super.c	2005-06-20 11:47:13.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/super.c	2005-07-04 23:14:19.000000000 +1000
@@ -584,6 +584,68 @@ void emergency_remount(void)
 	pdflush_operation(do_emergency_remount, 0);
 }
 
+static inline int mount_s4_resume_safe(struct super_block *sb)
+{
+	return ((sb->s_flags & MS_RDONLY) ||
+		(sb->s_type->fs_flags & FS_RW_S4_RESUME_SAFE));
+}
+
+/* mounts_are_s4_resume_safe
+ *
+ * This routine is used by software suspend to check that
+ * the user doesn't have any mounts that we might corrupt
+ * by resuming. This is a possibility where initrds/initramfs
+ * are used and the user hasn't properly configured their
+ * system to check for resuming _before_ mounting filesystems
+ */
+
+int mounts_are_S4_resume_safe(void)
+{
+	struct super_block *sb;
+	int result = 1;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!mount_s4_resume_safe(sb)) {
+			result = 0;
+			break;
+		}
+	}
+
+	spin_unlock(&sb_lock);
+	return result;
+}
+
+/* printk_S4_resume_unsafe_mounts
+ *
+ * Display which mounts we consider unsafe. It's all very
+ * well to tell the user some are, but it's more helpful
+ * to tell them which ones. It might simply be that the
+ * FS is safe but hasn't been marked as such yet.
+ */
+
+void get_S4_resume_unsafe_mounts(char * buffer, int buffer_size)
+{
+	struct super_block *sb;
+	int printed_len = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!mount_s4_resume_safe(sb)) {
+			printed_len += snprintf(
+				buffer + printed_len,
+				buffer_size - printed_len,
+				" - %s fs mounted %s.\n",
+				sb->s_type->name,
+				sb->s_flags & MS_RDONLY ? " ro" : " rw");
+			if (printed_len > buffer_size)
+				break;
+		}
+	}
+
+	spin_unlock(&sb_lock);
+}
+
 /*
  * Unnamed block devices are dummy devices used by virtual
  * filesystems which don't use real block-devices.  -- jrs
diff -ruNp 404-check-mounts-support.patch-old/fs/sysfs/mount.c 404-check-mounts-support.patch-new/fs/sysfs/mount.c
--- 404-check-mounts-support.patch-old/fs/sysfs/mount.c	2005-06-20 11:47:13.000000000 +1000
+++ 404-check-mounts-support.patch-new/fs/sysfs/mount.c	2005-07-04 23:14:19.000000000 +1000
@@ -74,6 +74,7 @@ static struct file_system_type sysfs_fs_
 	.name		= "sysfs",
 	.get_sb		= sysfs_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 int __init sysfs_init(void)
diff -ruNp 404-check-mounts-support.patch-old/include/linux/fs.h 404-check-mounts-support.patch-new/include/linux/fs.h
--- 404-check-mounts-support.patch-old/include/linux/fs.h	2005-06-20 11:47:29.000000000 +1000
+++ 404-check-mounts-support.patch-new/include/linux/fs.h	2005-07-04 23:14:19.000000000 +1000
@@ -81,6 +81,7 @@ extern int dir_notify_enable;
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_RW_S4_RESUME_SAFE 4 /* Can this FS be safely mounted RW when we're doing S4 resume? */
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
@@ -1199,6 +1200,9 @@ int __put_super(struct super_block *sb);
 int __put_super_and_need_restart(struct super_block *sb);
 void unnamed_dev_init(void);
 
+extern int mounts_are_S4_resume_safe(void);
+extern void get_S4_resume_unsafe_mounts(char * buffer, int buffer_size);
+
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
 	(((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
diff -ruNp 404-check-mounts-support.patch-old/ipc/mqueue.c 404-check-mounts-support.patch-new/ipc/mqueue.c
--- 404-check-mounts-support.patch-old/ipc/mqueue.c	2005-06-20 11:47:31.000000000 +1000
+++ 404-check-mounts-support.patch-new/ipc/mqueue.c	2005-07-04 23:14:19.000000000 +1000
@@ -1149,6 +1149,7 @@ static struct file_system_type mqueue_fs
 	.name = "mqueue",
 	.get_sb = mqueue_get_sb,
 	.kill_sb = kill_litter_super,
+	.fs_flags = FS_RW_S4_RESUME_SAFE,
 };
 
 static int msg_max_limit_min = DFLT_MSGMAX;
diff -ruNp 404-check-mounts-support.patch-old/kernel/futex.c 404-check-mounts-support.patch-new/kernel/futex.c
--- 404-check-mounts-support.patch-old/kernel/futex.c	2005-06-20 11:47:31.000000000 +1000
+++ 404-check-mounts-support.patch-new/kernel/futex.c	2005-07-04 23:14:19.000000000 +1000
@@ -781,6 +781,7 @@ static struct file_system_type futex_fs_
 	.name		= "futexfs",
 	.get_sb		= futexfs_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static int __init init(void)
diff -ruNp 404-check-mounts-support.patch-old/mm/shmem.c 404-check-mounts-support.patch-new/mm/shmem.c
--- 404-check-mounts-support.patch-old/mm/shmem.c	2005-06-20 11:47:32.000000000 +1000
+++ 404-check-mounts-support.patch-new/mm/shmem.c	2005-07-04 23:14:19.000000000 +1000
@@ -2203,6 +2203,7 @@ static struct file_system_type tmpfs_fs_
 	.name		= "tmpfs",
 	.get_sb		= shmem_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 static struct vfsmount *shm_mnt;
 
diff -ruNp 404-check-mounts-support.patch-old/mm/tiny-shmem.c 404-check-mounts-support.patch-new/mm/tiny-shmem.c
--- 404-check-mounts-support.patch-old/mm/tiny-shmem.c	2004-12-10 14:26:31.000000000 +1100
+++ 404-check-mounts-support.patch-new/mm/tiny-shmem.c	2005-07-04 23:14:19.000000000 +1000
@@ -25,6 +25,7 @@ static struct file_system_type tmpfs_fs_
 	.name		= "tmpfs",
 	.get_sb		= ramfs_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static struct vfsmount *shm_mnt;
diff -ruNp 404-check-mounts-support.patch-old/net/socket.c 404-check-mounts-support.patch-new/net/socket.c
--- 404-check-mounts-support.patch-old/net/socket.c	2005-06-20 11:47:34.000000000 +1000
+++ 404-check-mounts-support.patch-new/net/socket.c	2005-07-04 23:14:19.000000000 +1000
@@ -336,6 +336,7 @@ static struct file_system_type sock_fs_t
 	.name =		"sockfs",
 	.get_sb =	sockfs_get_sb,
 	.kill_sb =	kill_anon_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 static int sockfs_delete_dentry(struct dentry *dentry)
 {
diff -ruNp 404-check-mounts-support.patch-old/net/sunrpc/rpc_pipe.c 404-check-mounts-support.patch-new/net/sunrpc/rpc_pipe.c
--- 404-check-mounts-support.patch-old/net/sunrpc/rpc_pipe.c	2005-02-03 22:33:53.000000000 +1100
+++ 404-check-mounts-support.patch-new/net/sunrpc/rpc_pipe.c	2005-07-04 23:14:19.000000000 +1000
@@ -796,6 +796,7 @@ static struct file_system_type rpc_pipe_
 	.name		= "rpc_pipefs",
 	.get_sb		= rpc_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags 	= FS_RW_S4_RESUME_SAFE,
 };
 
 static void
diff -ruNp 404-check-mounts-support.patch-old/security/selinux/selinuxfs.c 404-check-mounts-support.patch-new/security/selinux/selinuxfs.c
--- 404-check-mounts-support.patch-old/security/selinux/selinuxfs.c	2005-06-20 11:47:35.000000000 +1000
+++ 404-check-mounts-support.patch-new/security/selinux/selinuxfs.c	2005-07-04 23:14:19.000000000 +1000
@@ -1308,6 +1308,7 @@ static struct file_system_type sel_fs_ty
 	.name		= "selinuxfs",
 	.get_sb		= sel_get_sb,
 	.kill_sb	= kill_litter_super,
+	.fs_flags	= FS_RW_S4_RESUME_SAFE,
 };
 
 struct vfsmount *selinuxfs_mount;

