Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbSLRXQN>; Wed, 18 Dec 2002 18:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbSLRXQN>; Wed, 18 Dec 2002 18:16:13 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45073 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267376AbSLRXQH>;
	Wed, 18 Dec 2002 18:16:07 -0500
Date: Wed, 18 Dec 2002 15:21:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.52
Message-ID: <20021218232125.GB1782@kroah.com>
References: <20021218231917.GA1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218231917.GA1782@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.898, 2002/12/18 14:57:38-08:00, greg@kroah.com

LSM: changed the dummy code to use the default operations logic.


diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Dec 18 15:13:41 2002
+++ b/security/dummy.c	Wed Dec 18 15:13:41 2002
@@ -542,111 +542,7 @@
 	return -EINVAL;
 }
 
-struct security_operations dummy_security_ops = {
-	.ptrace =			dummy_ptrace,
-	.capget =			dummy_capget,
-	.capset_check =			dummy_capset_check,
-	.capset_set =			dummy_capset_set,
-	.acct =				dummy_acct,
-	.capable =			dummy_capable,
-	.quotactl =			dummy_quotactl,
-	.quota_on =			dummy_quota_on,
-
-	.bprm_alloc_security =		dummy_bprm_alloc_security,
-	.bprm_free_security =		dummy_bprm_free_security,
-	.bprm_compute_creds =		dummy_bprm_compute_creds,
-	.bprm_set_security =		dummy_bprm_set_security,
-	.bprm_check_security =		dummy_bprm_check_security,
-
-	.sb_alloc_security =		dummy_sb_alloc_security,
-	.sb_free_security =		dummy_sb_free_security,
-	.sb_statfs =			dummy_sb_statfs,
-	.sb_mount =			dummy_sb_mount,
-	.sb_check_sb =			dummy_sb_check_sb,
-	.sb_umount =			dummy_sb_umount,
-	.sb_umount_close =		dummy_sb_umount_close,
-	.sb_umount_busy =		dummy_sb_umount_busy,
-	.sb_post_remount =		dummy_sb_post_remount,
-	.sb_post_mountroot =		dummy_sb_post_mountroot,
-	.sb_post_addmount =		dummy_sb_post_addmount,
-	.sb_pivotroot =			dummy_sb_pivotroot,
-	.sb_post_pivotroot =		dummy_sb_post_pivotroot,
-	
-	.inode_alloc_security =		dummy_inode_alloc_security,
-	.inode_free_security =		dummy_inode_free_security,
-	.inode_create =			dummy_inode_create,
-	.inode_post_create =		dummy_inode_post_create,
-	.inode_link =			dummy_inode_link,
-	.inode_post_link =		dummy_inode_post_link,
-	.inode_unlink =			dummy_inode_unlink,
-	.inode_symlink =		dummy_inode_symlink,
-	.inode_post_symlink =		dummy_inode_post_symlink,
-	.inode_mkdir =			dummy_inode_mkdir,
-	.inode_post_mkdir =		dummy_inode_post_mkdir,
-	.inode_rmdir =			dummy_inode_rmdir,
-	.inode_mknod =			dummy_inode_mknod,
-	.inode_post_mknod =		dummy_inode_post_mknod,
-	.inode_rename =			dummy_inode_rename,
-	.inode_post_rename =		dummy_inode_post_rename,
-	.inode_readlink =		dummy_inode_readlink,
-	.inode_follow_link =		dummy_inode_follow_link,
-	.inode_permission =		dummy_inode_permission,
-	.inode_permission_lite =	dummy_inode_permission_lite,
-	.inode_setattr =		dummy_inode_setattr,
-	.inode_getattr =		dummy_inode_getattr,
-	.inode_post_lookup =		dummy_inode_post_lookup,
-	.inode_delete =			dummy_inode_delete,
-	.inode_setxattr =		dummy_inode_setxattr,
-	.inode_getxattr =		dummy_inode_getxattr,
-	.inode_listxattr =		dummy_inode_listxattr,
-	.inode_removexattr =		dummy_inode_removexattr,
-
-	.file_permission =		dummy_file_permission,
-	.file_alloc_security =		dummy_file_alloc_security,
-	.file_free_security =		dummy_file_free_security,
-	.file_ioctl =			dummy_file_ioctl,
-	.file_mmap =			dummy_file_mmap,
-	.file_mprotect =		dummy_file_mprotect,
-	.file_lock =			dummy_file_lock,
-	.file_fcntl =			dummy_file_fcntl,
-	.file_set_fowner =		dummy_file_set_fowner,
-	.file_send_sigiotask =		dummy_file_send_sigiotask,
-	.file_receive =			dummy_file_receive,
-
-	.task_create =			dummy_task_create,
-	.task_alloc_security =		dummy_task_alloc_security,
-	.task_free_security =		dummy_task_free_security,
-	.task_setuid =			dummy_task_setuid,
-	.task_post_setuid =		dummy_task_post_setuid,
-	.task_setgid =			dummy_task_setgid,
-	.task_setpgid =			dummy_task_setpgid,
-	.task_getpgid =			dummy_task_getpgid,
-	.task_getsid =			dummy_task_getsid,
-	.task_setgroups =		dummy_task_setgroups,
-	.task_setnice =			dummy_task_setnice,
-	.task_setrlimit =		dummy_task_setrlimit,
-	.task_setscheduler =		dummy_task_setscheduler,
-	.task_getscheduler =		dummy_task_getscheduler,
-	.task_wait =			dummy_task_wait,
-	.task_kill =			dummy_task_kill,
-	.task_prctl =			dummy_task_prctl,
-	.task_kmod_set_label =		dummy_task_kmod_set_label,
-	.task_reparent_to_init =	dummy_task_reparent_to_init,
-
-	.ipc_permission =		dummy_ipc_permission,
-	
-	.msg_queue_alloc_security =	dummy_msg_queue_alloc_security,
-	.msg_queue_free_security =	dummy_msg_queue_free_security,
-	
-	.shm_alloc_security =		dummy_shm_alloc_security,
-	.shm_free_security =		dummy_shm_free_security,
-	
-	.sem_alloc_security =		dummy_sem_alloc_security,
-	.sem_free_security =		dummy_sem_free_security,
-
-	.register_security =		dummy_register_security,
-	.unregister_security =		dummy_unregister_security,
-};
+struct security_operations dummy_security_ops;
 
 #define set_to_dummy_if_null(ops, function)				\
 	do {								\
diff -Nru a/security/security.c b/security/security.c
--- a/security/security.c	Wed Dec 18 15:13:41 2002
+++ b/security/security.c	Wed Dec 18 15:13:41 2002
@@ -48,6 +48,12 @@
 	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
 		" initialized\n");
 
+	if (verify (&dummy_security_ops)) {
+		printk (KERN_ERR "%s could not verify "
+			"dummy_security_ops structure.\n", __FUNCTION__);
+		return -EIO;
+	}
+
 	security_ops = &dummy_security_ops;
 
 	return 0;
