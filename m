Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVHYBW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVHYBW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVHYBWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:22:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbVHYBWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:22:37 -0400
Message-Id: <20050825012149.898157000@localhost.localdomain>
References: <20050825012028.720597000@localhost.localdomain>
Date: Wed, 24 Aug 2005 18:20:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 4/5] Remove unnecessary default capability callbacks.
Content-Disposition: inline; filename=cap-empty-default.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all security hook inline stubs conditionally call to module and
do proper default action as fallback, all the old no-op default hooks can
be removed.  Similarly, the verify() bits which populated empty slots with
default hooks is no longer needed.  A few hooks are called from security
core directly rather than from inline stubs, so fix those up as well.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 security/commoncap.c |  825 ---------------------------------------------------
 security/security.c  |   50 +--
 2 files changed, 17 insertions(+), 858 deletions(-)

Index: lsm-hooks-2.6/security/commoncap.c
===================================================================
--- lsm-hooks-2.6.orig/security/commoncap.c
+++ lsm-hooks-2.6/security/commoncap.c
@@ -337,828 +337,3 @@ int cap_netlink_recv(struct sk_buff *skb
 	return 0;
 }
 EXPORT_SYMBOL(cap_netlink_recv);
-
-#ifdef CONFIG_SECURITY
-
-static int cap_acct (struct file *file)
-{
-	return 0;
-}
-
-static int cap_sysctl (ctl_table * table, int op)
-{
-	return 0;
-}
-
-static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_bprm_alloc_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_free_security (struct linux_binprm *bprm)
-{
-	return;
-}
-
-static void cap_bprm_post_apply_creds (struct linux_binprm *bprm)
-{
-	return;
-}
-
-static int cap_bprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
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
-static int cap_sb_copy_data (struct file_system_type *type,
-			       void *orig, void *copy)
-{
-	return 0;
-}
-
-static int cap_sb_kern_mount (struct super_block *sb, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_statfs (struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_sb_mount (char *dev_name, struct nameidata *nd, char *type,
-			   unsigned long flags, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_check_sb (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return 0;
-}
-
-static int cap_sb_umount (struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static void cap_sb_umount_close (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void cap_sb_umount_busy (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void cap_sb_post_remount (struct vfsmount *mnt, unsigned long flags,
-				   void *data)
-{
-	return;
-}
-
-
-static void cap_sb_post_mountroot (void)
-{
-	return;
-}
-
-static void cap_sb_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return;
-}
-
-static int cap_sb_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return 0;
-}
-
-static void cap_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
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
-			       int mask)
-{
-	return 0;
-}
-
-static void cap_inode_post_create (struct inode *inode, struct dentry *dentry,
-				     int mask)
-{
-	return;
-}
-
-static int cap_inode_link (struct dentry *old_dentry, struct inode *inode,
-			     struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_link (struct dentry *old_dentry,
-				   struct inode *inode,
-				   struct dentry *new_dentry)
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
-				const char *name)
-{
-	return 0;
-}
-
-static void cap_inode_post_symlink (struct inode *inode,
-				      struct dentry *dentry, const char *name)
-{
-	return;
-}
-
-static int cap_inode_mkdir (struct inode *inode, struct dentry *dentry,
-			      int mask)
-{
-	return 0;
-}
-
-static void cap_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
-				    int mask)
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
-			      int mode, dev_t dev)
-{
-	return 0;
-}
-
-static void cap_inode_post_mknod (struct inode *inode, struct dentry *dentry,
-				    int mode, dev_t dev)
-{
-	return;
-}
-
-static int cap_inode_rename (struct inode *old_inode,
-			       struct dentry *old_dentry,
-			       struct inode *new_inode,
-			       struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_rename (struct inode *old_inode,
-				     struct dentry *old_dentry,
-				     struct inode *new_inode,
-				     struct dentry *new_dentry)
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
-				    struct nameidata *nameidata)
-{
-	return 0;
-}
-
-static int cap_inode_permission (struct inode *inode, int mask, struct nameidata *nd)
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
-static void cap_inode_delete (struct inode *ino)
-{
-	return;
-}
-
-static void cap_inode_post_setxattr (struct dentry *dentry, char *name, void *value,
-				       size_t size, int flags)
-{
-	return;
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
-static int cap_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
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
-			     unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_mmap (struct file *file, unsigned long reqprot,
-			    unsigned long prot,
-			    unsigned long flags)
-{
-	return 0;
-}
-
-static int cap_file_mprotect (struct vm_area_struct *vma,
-				unsigned long reqprot,
-				unsigned long prot)
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
-			     unsigned long arg)
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
-				      struct fown_struct *fown, int sig)
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
-static int cap_task_setgroups (struct group_info *group_info)
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
-				    struct sched_param *lp)
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
-static int cap_task_kill (struct task_struct *p, struct siginfo *info,
-			    int sig)
-{
-	return 0;
-}
-
-static int cap_task_prctl (int option, unsigned long arg2, unsigned long arg3,
-			     unsigned long arg4, unsigned long arg5)
-{
-	return 0;
-}
-
-static void cap_task_to_inode(struct task_struct *p, struct inode *inode)
-{
-	return;
-}
-
-static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
-{
-	return 0;
-}
-
-static int cap_msg_msg_alloc_security (struct msg_msg *msg)
-{
-	return 0;
-}
-
-static void cap_msg_msg_free_security (struct msg_msg *msg)
-{
-	return;
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
-static int cap_msg_queue_associate (struct msg_queue *msq, 
-				      int msqflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgctl (struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
-				   int msgflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
-				   struct task_struct *target, long type,
-				   int mode)
-{
-	return 0;
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
-static int cap_shm_associate (struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int cap_shm_shmctl (struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int cap_shm_shmat (struct shmid_kernel *shp, char __user *shmaddr,
-			    int shmflg)
-{
-	return 0;
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
-static int cap_sem_associate (struct sem_array *sma, int semflg)
-{
-	return 0;
-}
-
-static int cap_sem_semctl (struct sem_array *sma, int cmd)
-{
-	return 0;
-}
-
-static int cap_sem_semop (struct sem_array *sma, 
-			    struct sembuf *sops, unsigned nsops, int alter)
-{
-	return 0;
-}
-
-#ifdef CONFIG_SECURITY_NETWORK
-static int cap_unix_stream_connect (struct socket *sock,
-				      struct socket *other,
-				      struct sock *newsk)
-{
-	return 0;
-}
-
-static int cap_unix_may_send (struct socket *sock,
-				struct socket *other)
-{
-	return 0;
-}
-
-static int cap_socket_create (int family, int type,
-				int protocol, int kern)
-{
-	return 0;
-}
-
-static void cap_socket_post_create (struct socket *sock, int family, int type,
-				      int protocol, int kern)
-{
-	return;
-}
-
-static int cap_socket_bind (struct socket *sock, struct sockaddr *address,
-			      int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_connect (struct socket *sock, struct sockaddr *address,
-				 int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_listen (struct socket *sock, int backlog)
-{
-	return 0;
-}
-
-static int cap_socket_accept (struct socket *sock, struct socket *newsock)
-{
-	return 0;
-}
-
-static void cap_socket_post_accept (struct socket *sock, 
-				      struct socket *newsock)
-{
-	return;
-}
-
-static int cap_socket_sendmsg (struct socket *sock, struct msghdr *msg,
-				 int size)
-{
-	return 0;
-}
-
-static int cap_socket_recvmsg (struct socket *sock, struct msghdr *msg,
-				 int size, int flags)
-{
-	return 0;
-}
-
-static int cap_socket_getsockname (struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_getpeername (struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_setsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_getsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_shutdown (struct socket *sock, int how)
-{
-	return 0;
-}
-
-static int cap_socket_sock_rcv_skb (struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int cap_socket_getpeersec(struct socket *sock, char __user *optval,
-				   int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
-
-static inline int cap_sk_alloc_security (struct sock *sk, int family, int priority)
-{
-	return 0;
-}
-
-static inline void cap_sk_free_security (struct sock *sk)
-{
-}
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-static int cap_register_security (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static int cap_unregister_security (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static void cap_d_instantiate (struct dentry *dentry, struct inode *inode)
-{
-	return;
-}
-
-static int cap_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static int cap_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-#define set_to_default_if_null(ops, function)				\
-	do {								\
-		if (!ops->function) {					\
-			ops->function = cap_##function;		\
-			pr_debug("Had to override with " #function	\
-				 " security op with the default one.\n");\
-			}						\
-	} while (0)
-
-void security_fixup_ops (struct security_operations *ops)
-{
-	set_to_default_if_null(ops, ptrace);
-	set_to_default_if_null(ops, capget);
-	set_to_default_if_null(ops, capset_check);
-	set_to_default_if_null(ops, capset_set);
-	set_to_default_if_null(ops, acct);
-	set_to_default_if_null(ops, capable);
-	set_to_default_if_null(ops, quotactl);
-	set_to_default_if_null(ops, quota_on);
-	set_to_default_if_null(ops, sysctl);
-	set_to_default_if_null(ops, syslog);
-	set_to_default_if_null(ops, settime);
-	set_to_default_if_null(ops, vm_enough_memory);
-	set_to_default_if_null(ops, bprm_alloc_security);
-	set_to_default_if_null(ops, bprm_free_security);
-	set_to_default_if_null(ops, bprm_apply_creds);
-	set_to_default_if_null(ops, bprm_post_apply_creds);
-	set_to_default_if_null(ops, bprm_set_security);
-	set_to_default_if_null(ops, bprm_check_security);
-	set_to_default_if_null(ops, bprm_secureexec);
-	set_to_default_if_null(ops, sb_alloc_security);
-	set_to_default_if_null(ops, sb_free_security);
-	set_to_default_if_null(ops, sb_copy_data);
-	set_to_default_if_null(ops, sb_kern_mount);
-	set_to_default_if_null(ops, sb_statfs);
-	set_to_default_if_null(ops, sb_mount);
-	set_to_default_if_null(ops, sb_check_sb);
-	set_to_default_if_null(ops, sb_umount);
-	set_to_default_if_null(ops, sb_umount_close);
-	set_to_default_if_null(ops, sb_umount_busy);
-	set_to_default_if_null(ops, sb_post_remount);
-	set_to_default_if_null(ops, sb_post_mountroot);
-	set_to_default_if_null(ops, sb_post_addmount);
-	set_to_default_if_null(ops, sb_pivotroot);
-	set_to_default_if_null(ops, sb_post_pivotroot);
-	set_to_default_if_null(ops, inode_alloc_security);
-	set_to_default_if_null(ops, inode_free_security);
-	set_to_default_if_null(ops, inode_create);
-	set_to_default_if_null(ops, inode_post_create);
-	set_to_default_if_null(ops, inode_link);
-	set_to_default_if_null(ops, inode_post_link);
-	set_to_default_if_null(ops, inode_unlink);
-	set_to_default_if_null(ops, inode_symlink);
-	set_to_default_if_null(ops, inode_post_symlink);
-	set_to_default_if_null(ops, inode_mkdir);
-	set_to_default_if_null(ops, inode_post_mkdir);
-	set_to_default_if_null(ops, inode_rmdir);
-	set_to_default_if_null(ops, inode_mknod);
-	set_to_default_if_null(ops, inode_post_mknod);
-	set_to_default_if_null(ops, inode_rename);
-	set_to_default_if_null(ops, inode_post_rename);
-	set_to_default_if_null(ops, inode_readlink);
-	set_to_default_if_null(ops, inode_follow_link);
-	set_to_default_if_null(ops, inode_permission);
-	set_to_default_if_null(ops, inode_setattr);
-	set_to_default_if_null(ops, inode_getattr);
-	set_to_default_if_null(ops, inode_delete);
-	set_to_default_if_null(ops, inode_setxattr);
-	set_to_default_if_null(ops, inode_post_setxattr);
-	set_to_default_if_null(ops, inode_getxattr);
-	set_to_default_if_null(ops, inode_listxattr);
-	set_to_default_if_null(ops, inode_removexattr);
-	set_to_default_if_null(ops, inode_getsecurity);
-	set_to_default_if_null(ops, inode_setsecurity);
-	set_to_default_if_null(ops, inode_listsecurity);
-	set_to_default_if_null(ops, file_permission);
-	set_to_default_if_null(ops, file_alloc_security);
-	set_to_default_if_null(ops, file_free_security);
-	set_to_default_if_null(ops, file_ioctl);
-	set_to_default_if_null(ops, file_mmap);
-	set_to_default_if_null(ops, file_mprotect);
-	set_to_default_if_null(ops, file_lock);
-	set_to_default_if_null(ops, file_fcntl);
-	set_to_default_if_null(ops, file_set_fowner);
-	set_to_default_if_null(ops, file_send_sigiotask);
-	set_to_default_if_null(ops, file_receive);
-	set_to_default_if_null(ops, task_create);
-	set_to_default_if_null(ops, task_alloc_security);
-	set_to_default_if_null(ops, task_free_security);
-	set_to_default_if_null(ops, task_setuid);
-	set_to_default_if_null(ops, task_post_setuid);
-	set_to_default_if_null(ops, task_setgid);
-	set_to_default_if_null(ops, task_setpgid);
-	set_to_default_if_null(ops, task_getpgid);
-	set_to_default_if_null(ops, task_getsid);
-	set_to_default_if_null(ops, task_setgroups);
-	set_to_default_if_null(ops, task_setnice);
-	set_to_default_if_null(ops, task_setrlimit);
-	set_to_default_if_null(ops, task_setscheduler);
-	set_to_default_if_null(ops, task_getscheduler);
-	set_to_default_if_null(ops, task_wait);
-	set_to_default_if_null(ops, task_kill);
-	set_to_default_if_null(ops, task_prctl);
-	set_to_default_if_null(ops, task_reparent_to_init);
- 	set_to_default_if_null(ops, task_to_inode);
-	set_to_default_if_null(ops, ipc_permission);
-	set_to_default_if_null(ops, msg_msg_alloc_security);
-	set_to_default_if_null(ops, msg_msg_free_security);
-	set_to_default_if_null(ops, msg_queue_alloc_security);
-	set_to_default_if_null(ops, msg_queue_free_security);
-	set_to_default_if_null(ops, msg_queue_associate);
-	set_to_default_if_null(ops, msg_queue_msgctl);
-	set_to_default_if_null(ops, msg_queue_msgsnd);
-	set_to_default_if_null(ops, msg_queue_msgrcv);
-	set_to_default_if_null(ops, shm_alloc_security);
-	set_to_default_if_null(ops, shm_free_security);
-	set_to_default_if_null(ops, shm_associate);
-	set_to_default_if_null(ops, shm_shmctl);
-	set_to_default_if_null(ops, shm_shmat);
-	set_to_default_if_null(ops, sem_alloc_security);
-	set_to_default_if_null(ops, sem_free_security);
-	set_to_default_if_null(ops, sem_associate);
-	set_to_default_if_null(ops, sem_semctl);
-	set_to_default_if_null(ops, sem_semop);
-	set_to_default_if_null(ops, netlink_send);
-	set_to_default_if_null(ops, netlink_recv);
-	set_to_default_if_null(ops, register_security);
-	set_to_default_if_null(ops, unregister_security);
-	set_to_default_if_null(ops, d_instantiate);
- 	set_to_default_if_null(ops, getprocattr);
- 	set_to_default_if_null(ops, setprocattr);
-#ifdef CONFIG_SECURITY_NETWORK
-	set_to_default_if_null(ops, unix_stream_connect);
-	set_to_default_if_null(ops, unix_may_send);
-	set_to_default_if_null(ops, socket_create);
-	set_to_default_if_null(ops, socket_post_create);
-	set_to_default_if_null(ops, socket_bind);
-	set_to_default_if_null(ops, socket_connect);
-	set_to_default_if_null(ops, socket_listen);
-	set_to_default_if_null(ops, socket_accept);
-	set_to_default_if_null(ops, socket_post_accept);
-	set_to_default_if_null(ops, socket_sendmsg);
-	set_to_default_if_null(ops, socket_recvmsg);
-	set_to_default_if_null(ops, socket_getsockname);
-	set_to_default_if_null(ops, socket_getpeername);
-	set_to_default_if_null(ops, socket_setsockopt);
-	set_to_default_if_null(ops, socket_getsockopt);
-	set_to_default_if_null(ops, socket_shutdown);
-	set_to_default_if_null(ops, socket_sock_rcv_skb);
-	set_to_default_if_null(ops, socket_getpeersec);
-	set_to_default_if_null(ops, sk_alloc_security);
-	set_to_default_if_null(ops, sk_free_security);
-#endif	/* CONFIG_SECURITY_NETWORK */
-}
-
-#endif	/* CONFIG_SECURITY */
Index: lsm-hooks-2.6/security/security.c
===================================================================
--- lsm-hooks-2.6.orig/security/security.c
+++ lsm-hooks-2.6/security/security.c
@@ -22,19 +22,9 @@
 
 struct security_operations *security_ops;	/* Initialized to NULL */
 
+/* NULL ops are default */
 static struct security_operations default_security_ops;
 
-extern void security_fixup_ops (struct security_operations *ops);
-
-static inline int verify(struct security_operations *ops)
-{
-	/* verify the security_operations structure exists */
-	if (!ops)
-		return -EINVAL;
-	security_fixup_ops(ops);
-	return 0;
-}
-
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
@@ -55,12 +45,6 @@ int __init security_init(void)
 	printk(KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
 	       " initialized\n");
 
-	if (verify(&default_security_ops)) {
-		printk(KERN_ERR "%s could not verify "
-		       "default_security_ops structure.\n", __FUNCTION__);
-		return -EIO;
-	}
-
 	security_ops = &default_security_ops;
 	do_security_initcalls();
 
@@ -81,12 +65,6 @@ int __init security_init(void)
  */
 int register_security(struct security_operations *ops)
 {
-	if (verify(ops)) {
-		printk(KERN_DEBUG "%s could not verify "
-		       "security_operations structure.\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
 	if (security_ops != &default_security_ops)
 		return -EAGAIN;
 
@@ -134,19 +112,16 @@ int unregister_security(struct security_
  */
 int mod_reg_security(const char *name, struct security_operations *ops)
 {
-	if (verify(ops)) {
-		printk(KERN_INFO "%s could not verify "
-		       "security operations.\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
 	if (ops == security_ops) {
 		printk(KERN_INFO "%s security operations "
 		       "already registered.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	return security_ops->register_security(name, ops);
+	if (security_ops->register_security)
+		return security_ops->register_security(name, ops);
+
+	return -EINVAL;
 }
 
 /**
@@ -170,7 +145,10 @@ int mod_unreg_security(const char *name,
 		return -EINVAL;
 	}
 
-	return security_ops->unregister_security(name, ops);
+	if (security_ops->unregister_security)
+		return security_ops->unregister_security(name, ops);
+	
+	return -EINVAL;
 }
 
 /**
@@ -185,10 +163,16 @@ int mod_unreg_security(const char *name,
  */
 int capable(int cap)
 {
-	if (security_ops->capable(current, cap)) {
+	int err;
+
+	if (security_ops->capable)
+		err = security_ops->capable(current, cap);
+	else
+		err = cap_capable(current, cap);
+
+	if (err)
 		/* capability denied */
 		return 0;
-	}
 
 	/* capability granted */
 	current->flags |= PF_SUPERPRIV;

--
