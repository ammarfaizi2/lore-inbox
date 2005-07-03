Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVGCPwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVGCPwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVGCPwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:52:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:28818 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261458AbVGCPnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:43:52 -0400
Date: Sun, 3 Jul 2005 17:43:47 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: [PATCH 2a/3] Reorder the security stubs
Message-ID: <20050703154347.GC11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch has been generated automatically, so the rediffing pain
is reduced.
It reorders the implementations of the security stubs to have=20
CONFIG_SECURITY and else stuff next to each other.
Makes the cleanup patch (2b) much more easy and safer to create.

If anyone is interested in the python script, let me know ...

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-reorder-stubs
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Reorder stubs in security.h

This reordering is done automatically by a little python script of mine,
in order to minimize the chances of screwing up in the next step.

This is patch 2a/5 of the LSM overhaul.

 security.h | 1163 +++++++++++++++++++++++++++++---------------------------=
-----
 1 files changed, 559 insertions(+), 604 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.12/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/include/linux/security.h
+++ linux-2.6.12/include/linux/security.h
@@ -86,10 +86,10 @@ struct swap_info_struct;
 #define LSM_UNSAFE_SHARE	1
 #define LSM_UNSAFE_PTRACE	2
 #define LSM_UNSAFE_PTRACE_CAP	4
=20
-#ifdef CONFIG_SECURITY
=20
+# ifdef CONFIG_SECURITY
 /**
  * struct security_operations - main security structure
  *
  * Security hooks for program execution operations.
@@ -1212,9 +1212,9 @@ struct security_operations {
=20
  	int (*getprocattr)(struct task_struct *p, char *name, void *value, size_=
t size);
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_=
t size);
=20
-#ifdef CONFIG_SECURITY_NETWORK
+#  ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
 				    struct socket * other, struct sock * newsk);
 	int (*unix_may_send) (struct socket * sock, struct socket * other);
=20
@@ -1241,9 +1241,9 @@ struct security_operations {
 	int (*socket_sock_rcv_skb) (struct sock * sk, struct sk_buff * skb);
 	int (*socket_getpeersec) (struct socket *sock, char __user *optval, int _=
_user *optlen, unsigned len);
 	int (*sk_alloc_security) (struct sock *sk, int family, int priority);
 	void (*sk_free_security) (struct sock *sk);
-#endif	/* CONFIG_SECURITY_NETWORK */
+#  endif /* CONFIG_SECURITY_NETWORK */
 };
=20
 /* global variables */
 extern struct security_operations *security_ops;
@@ -1252,731 +1252,1210 @@ extern struct security_operations *secur
 static inline int security_ptrace (struct task_struct * parent, struct tas=
k_struct * child)
 {
 	return security_ops->ptrace (parent, child);
 }
+# else /* CONFIG_SECURITY */
+static inline int security_ptrace (struct task_struct *parent, struct task=
_struct * child)
+{
+	return cap_ptrace (parent, child);
+}
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_capget (struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->capget (target, effective, inheritable, permitted);
+# else /* CONFIG_SECURITY */
+	return cap_capget (target, effective, inheritable, permitted);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_capset_check (struct task_struct *target,
 					 kernel_cap_t *effective,
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->capset_check (target, effective, inheritable, permit=
ted);
+# else /* CONFIG_SECURITY */
+	return cap_capset_check (target, effective, inheritable, permitted);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_capset_set (struct task_struct *target,
 					kernel_cap_t *effective,
 					kernel_cap_t *inheritable,
 					kernel_cap_t *permitted)
 {
+# ifdef CONFIG_SECURITY
 	security_ops->capset_set (target, effective, inheritable, permitted);
+# else /* CONFIG_SECURITY */
+	cap_capset_set (target, effective, inheritable, permitted);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_acct (struct file *file)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->acct (file);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sysctl(struct ctl_table *table, int op)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sysctl(table, op);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_quotactl (int cmds, int type, int id,
+# ifdef CONFIG_SECURITY
 				     struct super_block *sb)
 {
 	return security_ops->quotactl (cmds, type, id, sb);
+# else /* CONFIG_SECURITY */
+				     struct super_block * sb)
+{
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_quota_on (struct dentry * dentry)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->quota_on (dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_syslog(int type)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->syslog(type);
+# else /* CONFIG_SECURITY */
+	return cap_syslog(type);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->settime(ts, tz);
+# else /* CONFIG_SECURITY */
+	return cap_settime(ts, tz);
+# endif /* CONFIG_SECURITY */
 }
=20
=20
 static inline int security_vm_enough_memory(long pages)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->vm_enough_memory(pages);
+# else /* CONFIG_SECURITY */
+	return cap_vm_enough_memory(pages);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->bprm_alloc_security (bprm);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
 static inline void security_bprm_free (struct linux_binprm *bprm)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->bprm_free_security (bprm);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
 static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
 {
+# ifdef CONFIG_SECURITY
 	security_ops->bprm_apply_creds (bprm, unsafe);
+# else /* CONFIG_SECURITY */
+	cap_bprm_apply_creds (bprm, unsafe);
+# endif /* CONFIG_SECURITY */
 }
 static inline void security_bprm_post_apply_creds (struct linux_binprm *bp=
rm)
 {
+# ifdef CONFIG_SECURITY
 	security_ops->bprm_post_apply_creds (bprm);
+# else /* CONFIG_SECURITY */
+	return;
+# endif /* CONFIG_SECURITY */
 }
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->bprm_set_security (bprm);
+# else /* CONFIG_SECURITY */
+	return cap_bprm_set_security (bprm);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->bprm_check_security (bprm);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_bprm_secureexec (struct linux_binprm *bprm)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->bprm_secureexec (bprm);
+# else /* CONFIG_SECURITY */
+	return cap_bprm_secureexec(bprm);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_alloc (struct super_block *sb)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_alloc_security (sb);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_sb_free (struct super_block *sb)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_free_security (sb);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_sb_copy_data (struct file_system_type *type,
 					 void *orig, void *copy)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_copy_data (type, orig, copy);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_kern_mount (sb, data);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_statfs (struct super_block *sb)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_statfs (sb);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
 				    char *type, unsigned long flags,
 				    void *data)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_check_sb (struct vfsmount *mnt,
 					struct nameidata *nd)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_check_sb (mnt, nd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sb_umount (struct vfsmount *mnt, int flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_umount (mnt, flags);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_sb_umount_close (struct vfsmount *mnt)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_umount_close (mnt);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_umount_busy (struct vfsmount *mnt)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_umount_busy (mnt);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_remount (struct vfsmount *mnt,
 					     unsigned long flags, void *data)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_post_remount (mnt, flags, data);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_mountroot (void)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_post_mountroot ();
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_addmount (struct vfsmount *mnt,
 					      struct nameidata *mountpoint_nd)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_post_addmount (mnt, mountpoint_nd);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_sb_pivotroot (struct nameidata *old_nd,
 					 struct nameidata *new_nd)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sb_pivotroot (old_nd, new_nd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
 					       struct nameidata *new_nd)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sb_post_pivotroot (old_nd, new_nd);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_alloc (struct inode *inode)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_alloc_security (inode);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_free (struct inode *inode)
+# ifdef CONFIG_SECURITY
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
 	security_ops->inode_free_security (inode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
 =09
 static inline int security_inode_create (struct inode *dir,
 					 struct dentry *dentry,
 					 int mode)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_create (dir, dentry, mode);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_create (struct inode *dir,
 					       struct dentry *dentry,
 					       int mode)
+# ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_create (dir, dentry, mode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_link (struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode)))
 		return 0;
 	return security_ops->inode_link (old_dentry, dir, new_dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_link (struct dentry *old_dentry,
 					     struct inode *dir,
 					     struct dentry *new_dentry)
+# ifdef CONFIG_SECURITY
 {
 	if (new_dentry->d_inode && unlikely (IS_PRIVATE (new_dentry->d_inode)))
 		return;
 	security_ops->inode_post_link (old_dentry, dir, new_dentry);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_unlink (dir, dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_symlink (struct inode *dir,
 					  struct dentry *dentry,
 					  const char *old_name)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_symlink (dir, dentry, old_name);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_symlink (struct inode *dir,
 						struct dentry *dentry,
 						const char *old_name)
+# ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_symlink (dir, dentry, old_name);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_mkdir (struct inode *dir,
 					struct dentry *dentry,
 					int mode)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_mkdir (dir, dentry, mode);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_mkdir (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode)
+# ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_mkdir (dir, dentry, mode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_rmdir (dir, dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_mknod (struct inode *dir,
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_mknod (dir, dentry, mode, dev);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_mknod (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
+# ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_mknod (dir, dentry, mode, dev);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_rename (struct inode *old_dir,
 					 struct dentry *old_dentry,
 					 struct inode *new_dir,
 					 struct dentry *new_dentry)
 {
+# ifdef CONFIG_SECURITY
         if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return 0;
 	return security_ops->inode_rename (old_dir, old_dentry,
 					   new_dir, new_dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_rename (struct inode *old_dir,
 					       struct dentry *old_dentry,
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
+# ifdef CONFIG_SECURITY
 {
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
 	    (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return;
 	security_ops->inode_post_rename (old_dir, old_dentry,
 						new_dir, new_dentry);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_readlink (struct dentry *dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_readlink (dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_follow_link (dentry, nd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_permission (inode, mask, nd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_setattr (dentry, attr);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_getattr (mnt, dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_delete (struct inode *inode)
+# ifdef CONFIG_SECURITY
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
 	security_ops->inode_delete (inode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_setxattr (struct dentry *dentry, char *na=
me,
 					   void *value, size_t size, int flags)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
+# else /* CONFIG_SECURITY */
+	return cap_inode_setxattr(dentry, name, value, size, flags);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_inode_post_setxattr (struct dentry *dentry, ch=
ar *name,
 						void *value, size_t size, int flags)
+# ifdef CONFIG_SECURITY
 {
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_getxattr (struct dentry *dentry, char *na=
me)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_getxattr (dentry, name);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_listxattr (dentry);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_removexattr (struct dentry *dentry, char =
*name)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_removexattr (dentry, name);
+# else /* CONFIG_SECURITY */
+	return cap_inode_removexattr(dentry, name);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_getsecurity(struct inode *inode, const ch=
ar *name, void *buffer, size_t size)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_getsecurity(inode, name, buffer, size);
+# else /* CONFIG_SECURITY */
+	return -EOPNOTSUPP;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name, const void *value, size_t size, int flags)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+# else /* CONFIG_SECURITY */
+	return -EOPNOTSUPP;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_inode_listsecurity(struct inode *inode, char *b=
uffer, size_t buffer_size)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_permission (struct file *file, int mask)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_permission (file, mask);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_alloc (struct file *file)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_alloc_security (file);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_file_free (struct file *file)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->file_free_security (file);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_ioctl (file, cmd, arg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_mmap (struct file *file, unsigned long req=
prot,
 				      unsigned long prot,
 				      unsigned long flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_mmap (file, reqprot, prot, flags);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_mprotect (struct vm_area_struct *vma,
 					  unsigned long reqprot,
 					  unsigned long prot)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_mprotect (vma, reqprot, prot);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_lock (struct file *file, unsigned int cmd)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_lock (file, cmd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_fcntl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_fcntl (file, cmd, arg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_set_fowner (struct file *file)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_set_fowner (file);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
 						int sig)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_send_sigiotask (tsk, fown, sig);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_file_receive (struct file *file)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->file_receive (file);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_create (unsigned long clone_flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_create (clone_flags);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_alloc (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_alloc_security (p);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_task_free (struct task_struct *p)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->task_free_security (p);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setuid (id0, id1, id2, flags);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_eui=
d,
 					     uid_t old_suid, int flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flag=
s);
+# else /* CONFIG_SECURITY */
+	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
 					int flags)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setgid (id0, id1, id2, flags);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setpgid (p, pgid);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_getpgid (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_getpgid (p);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_getsid (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_getsid (p);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setgroups (struct group_info *group_info)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setgroups (group_info);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setnice (p, nice);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setrlimit (resource, new_rlim);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_setscheduler (p, policy, lp);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_getscheduler (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_getscheduler (p);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_kill (p, info, sig);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_wait (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_wait (p);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_task_prctl (int option, unsigned long arg2,
 				       unsigned long arg3,
 				       unsigned long arg4,
 				       unsigned long arg5)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
+# ifdef CONFIG_SECURITY
 	security_ops->task_reparent_to_init (p);
+# else /* CONFIG_SECURITY */
+	cap_task_reparent_to_init (p);
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_task_to_inode(struct task_struct *p, struct in=
ode *inode)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->task_to_inode(p, inode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->ipc_permission (ipcp, flag);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_msg_alloc_security (msg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_msg_msg_free (struct msg_msg * msg)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->msg_msg_free_security(msg);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_alloc_security (msq);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_msg_queue_free (struct msg_queue *msq)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->msg_queue_free_security (msq);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_msg_queue_associate (struct msg_queue * msq,=20
 						int msqflg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_associate (msq, msqflg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgctl (msq, cmd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
 					     struct msg_msg * msg, int msqflg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
 					     struct msg_msg * msg,
 					     struct task_struct * target,
 					     long type, int mode)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->shm_alloc_security (shp);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_shm_free (struct shmid_kernel *shp)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->shm_free_security (shp);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_shm_associate (struct shmid_kernel * shp,=20
 					  int shmflg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->shm_associate(shp, shmflg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->shm_shmctl (shp, cmd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_shm_shmat (struct shmid_kernel * shp,=20
 				      char __user *shmaddr, int shmflg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sem_alloc (struct sem_array *sma)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sem_alloc_security (sma);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_sem_free (struct sem_array *sma)
+# ifdef CONFIG_SECURITY
 {
 	security_ops->sem_free_security (sma);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sem_associate (sma, semflg);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sem_semctl (struct sem_array * sma, int cmd)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sem_semctl(sma, cmd);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_sem_semop (struct sem_array * sma,=20
 				      struct sembuf * sops, unsigned nsops,=20
 				      int alter)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->sem_semop(sma, sops, nsops, alter);
+# else /* CONFIG_SECURITY */
+	return 0;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
+# ifdef CONFIG_SECURITY
 {
 	if (unlikely (inode && IS_PRIVATE (inode)))
 		return;
 	security_ops->d_instantiate (dentry, inode);
 }
+# else /* CONFIG_SECURITY */
+{ }
+# endif /* CONFIG_SECURITY */
=20
 static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->getprocattr(p, name, value, size);
+# else /* CONFIG_SECURITY */
+	return -EINVAL;
+# endif /* CONFIG_SECURITY */
 }
=20
 static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
+# ifdef CONFIG_SECURITY
 	return security_ops->setprocattr(p, name, value, size);
+# else /* CONFIG_SECURITY */
+	return -EINVAL;
+# endif /* CONFIG_SECURITY */
 }
=20
+# ifdef CONFIG_SECURITY
 static inline int security_netlink_send(struct sock *sk, struct sk_buff * =
skb)
 {
 	return security_ops->netlink_send(sk, skb);
 }
+# else /* CONFIG_SECURITY */
+static inline int security_netlink_send (struct sock *sk, struct sk_buff *=
skb)
+{
+	return cap_netlink_send (sk, skb);
+}
+# endif /* CONFIG_SECURITY */
+# ifdef CONFIG_SECURITY
=20
 static inline int security_netlink_recv(struct sk_buff * skb)
 {
 	return security_ops->netlink_recv(skb);
 }
+# else /* CONFIG_SECURITY */
+static inline int security_netlink_recv (struct sk_buff *skb)
+{
+	return cap_netlink_recv (skb);
+}
+# endif /* CONFIG_SECURITY */
+# ifdef CONFIG_SECURITY
=20
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -1984,9 +2463,9 @@ extern int unregister_security	(struct s
 extern int mod_reg_security	(const char *name, struct security_operations =
*ops);
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
=20
-#else /* CONFIG_SECURITY */
+# else /* CONFIG_SECURITY */
=20
 /*
  * This is the default capabilities functionality.  Most of these functions
  * are just stubbed out, but a few must call the proper capable code.
@@ -1996,863 +2475,339 @@ static inline int security_init(void)
 {
 	return 0;
 }
=20
-static inline int security_ptrace (struct task_struct *parent, struct task=
_struct * child)
-{
-	return cap_ptrace (parent, child);
-}
=20
-static inline int security_capget (struct task_struct *target,
-				   kernel_cap_t *effective,
-				   kernel_cap_t *inheritable,
-				   kernel_cap_t *permitted)
-{
-	return cap_capget (target, effective, inheritable, permitted);
-}
=20
-static inline int security_capset_check (struct task_struct *target,
-					 kernel_cap_t *effective,
-					 kernel_cap_t *inheritable,
-					 kernel_cap_t *permitted)
-{
-	return cap_capset_check (target, effective, inheritable, permitted);
-}
=20
-static inline void security_capset_set (struct task_struct *target,
-					kernel_cap_t *effective,
-					kernel_cap_t *inheritable,
-					kernel_cap_t *permitted)
-{
-	cap_capset_set (target, effective, inheritable, permitted);
-}
=20
-static inline int security_acct (struct file *file)
-{
-	return 0;
-}
=20
-static inline int security_sysctl(struct ctl_table *table, int op)
-{
-	return 0;
-}
=20
-static inline int security_quotactl (int cmds, int type, int id,
-				     struct super_block * sb)
-{
-	return 0;
-}
=20
-static inline int security_quota_on (struct dentry * dentry)
-{
-	return 0;
-}
=20
-static inline int security_syslog(int type)
-{
-	return cap_syslog(type);
-}
=20
-static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
-{
-	return cap_settime(ts, tz);
-}
=20
-static inline int security_vm_enough_memory(long pages)
-{
-	return cap_vm_enough_memory(pages);
-}
=20
-static inline int security_bprm_alloc (struct linux_binprm *bprm)
-{
-	return 0;
-}
=20
-static inline void security_bprm_free (struct linux_binprm *bprm)
-{ }
=20
-static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
-{=20
-	cap_bprm_apply_creds (bprm, unsafe);
-}
=20
-static inline void security_bprm_post_apply_creds (struct linux_binprm *bp=
rm)
-{
-	return;
-}
=20
-static inline int security_bprm_set (struct linux_binprm *bprm)
-{
-	return cap_bprm_set_security (bprm);
-}
=20
-static inline int security_bprm_check (struct linux_binprm *bprm)
-{
-	return 0;
-}
=20
-static inline int security_bprm_secureexec (struct linux_binprm *bprm)
-{
-	return cap_bprm_secureexec(bprm);
-}
=20
-static inline int security_sb_alloc (struct super_block *sb)
-{
-	return 0;
-}
=20
-static inline void security_sb_free (struct super_block *sb)
-{ }
=20
-static inline int security_sb_copy_data (struct file_system_type *type,
-					 void *orig, void *copy)
-{
-	return 0;
-}
=20
-static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
-{
-	return 0;
-}
=20
-static inline int security_sb_statfs (struct super_block *sb)
-{
-	return 0;
-}
=20
-static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
-				    char *type, unsigned long flags,
-				    void *data)
-{
-	return 0;
-}
=20
-static inline int security_sb_check_sb (struct vfsmount *mnt,
-					struct nameidata *nd)
-{
-	return 0;
-}
=20
-static inline int security_sb_umount (struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
=20
-static inline void security_sb_umount_close (struct vfsmount *mnt)
-{ }
=20
-static inline void security_sb_umount_busy (struct vfsmount *mnt)
-{ }
=20
-static inline void security_sb_post_remount (struct vfsmount *mnt,
-					     unsigned long flags, void *data)
-{ }
=20
-static inline void security_sb_post_mountroot (void)
-{ }
=20
-static inline void security_sb_post_addmount (struct vfsmount *mnt,
-					      struct nameidata *mountpoint_nd)
-{ }
=20
-static inline int security_sb_pivotroot (struct nameidata *old_nd,
-					 struct nameidata *new_nd)
-{
-	return 0;
-}
=20
-static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
-					       struct nameidata *new_nd)
-{ }
=20
-static inline int security_inode_alloc (struct inode *inode)
-{
-	return 0;
-}
=20
-static inline void security_inode_free (struct inode *inode)
-{ }
 =09
-static inline int security_inode_create (struct inode *dir,
-					 struct dentry *dentry,
-					 int mode)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_create (struct inode *dir,
-					       struct dentry *dentry,
-					       int mode)
-{ }
=20
-static inline int security_inode_link (struct dentry *old_dentry,
-				       struct inode *dir,
-				       struct dentry *new_dentry)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_link (struct dentry *old_dentry,
-					     struct inode *dir,
-					     struct dentry *new_dentry)
-{ }
=20
-static inline int security_inode_unlink (struct inode *dir,
-					 struct dentry *dentry)
-{
-	return 0;
-}
=20
-static inline int security_inode_symlink (struct inode *dir,
-					  struct dentry *dentry,
-					  const char *old_name)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_symlink (struct inode *dir,
-						struct dentry *dentry,
-						const char *old_name)
-{ }
=20
-static inline int security_inode_mkdir (struct inode *dir,
-					struct dentry *dentry,
-					int mode)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_mkdir (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode)
-{ }
=20
-static inline int security_inode_rmdir (struct inode *dir,
-					struct dentry *dentry)
-{
-	return 0;
-}
=20
-static inline int security_inode_mknod (struct inode *dir,
-					struct dentry *dentry,
-					int mode, dev_t dev)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_mknod (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode, dev_t dev)
-{ }
=20
-static inline int security_inode_rename (struct inode *old_dir,
-					 struct dentry *old_dentry,
-					 struct inode *new_dir,
-					 struct dentry *new_dentry)
-{
-	return 0;
-}
=20
-static inline void security_inode_post_rename (struct inode *old_dir,
-					       struct dentry *old_dentry,
-					       struct inode *new_dir,
-					       struct dentry *new_dentry)
-{ }
=20
-static inline int security_inode_readlink (struct dentry *dentry)
-{
-	return 0;
-}
=20
-static inline int security_inode_follow_link (struct dentry *dentry,
-					      struct nameidata *nd)
-{
-	return 0;
-}
=20
-static inline int security_inode_permission (struct inode *inode, int mask,
-					     struct nameidata *nd)
-{
-	return 0;
-}
=20
-static inline int security_inode_setattr (struct dentry *dentry,
-					  struct iattr *attr)
-{
-	return 0;
-}
=20
-static inline int security_inode_getattr (struct vfsmount *mnt,
-					  struct dentry *dentry)
-{
-	return 0;
-}
=20
-static inline void security_inode_delete (struct inode *inode)
-{ }
=20
-static inline int security_inode_setxattr (struct dentry *dentry, char *na=
me,
-					   void *value, size_t size, int flags)
-{
-	return cap_inode_setxattr(dentry, name, value, size, flags);
-}
=20
-static inline void security_inode_post_setxattr (struct dentry *dentry, ch=
ar *name,
-						 void *value, size_t size, int flags)
-{ }
=20
-static inline int security_inode_getxattr (struct dentry *dentry, char *na=
me)
-{
-	return 0;
-}
=20
-static inline int security_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
=20
-static inline int security_inode_removexattr (struct dentry *dentry, char =
*name)
-{
-	return cap_inode_removexattr(dentry, name);
-}
=20
-static inline int security_inode_getsecurity(struct inode *inode, const ch=
ar *name, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
=20
-static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name, const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
=20
-static inline int security_inode_listsecurity(struct inode *inode, char *b=
uffer, size_t buffer_size)
-{
-	return 0;
-}
=20
-static inline int security_file_permission (struct file *file, int mask)
-{
-	return 0;
-}
=20
-static inline int security_file_alloc (struct file *file)
-{
-	return 0;
-}
=20
-static inline void security_file_free (struct file *file)
-{ }
=20
-static inline int security_file_ioctl (struct file *file, unsigned int cmd,
-				       unsigned long arg)
-{
-	return 0;
-}
=20
-static inline int security_file_mmap (struct file *file, unsigned long req=
prot,
-				      unsigned long prot,
-				      unsigned long flags)
-{
-	return 0;
-}
=20
-static inline int security_file_mprotect (struct vm_area_struct *vma,
-					  unsigned long reqprot,
-					  unsigned long prot)
-{
-	return 0;
-}
=20
-static inline int security_file_lock (struct file *file, unsigned int cmd)
-{
-	return 0;
-}
=20
-static inline int security_file_fcntl (struct file *file, unsigned int cmd,
-				       unsigned long arg)
-{
-	return 0;
-}
=20
-static inline int security_file_set_fowner (struct file *file)
-{
-	return 0;
-}
=20
-static inline int security_file_send_sigiotask (struct task_struct *tsk,
-						struct fown_struct *fown,
-						int sig)
-{
-	return 0;
-}
=20
-static inline int security_file_receive (struct file *file)
-{
-	return 0;
-}
=20
-static inline int security_task_create (unsigned long clone_flags)
-{
-	return 0;
-}
=20
-static inline int security_task_alloc (struct task_struct *p)
-{
-	return 0;
-}
=20
-static inline void security_task_free (struct task_struct *p)
-{ }
=20
-static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
-					int flags)
-{
-	return 0;
-}
=20
-static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_eui=
d,
-					     uid_t old_suid, int flags)
-{
-	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
-}
=20
-static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
-					int flags)
-{
-	return 0;
-}
=20
-static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
=20
-static inline int security_task_getpgid (struct task_struct *p)
-{
-	return 0;
-}
=20
-static inline int security_task_getsid (struct task_struct *p)
-{
-	return 0;
-}
=20
-static inline int security_task_setgroups (struct group_info *group_info)
-{
-	return 0;
-}
=20
-static inline int security_task_setnice (struct task_struct *p, int nice)
-{
-	return 0;
-}
=20
-static inline int security_task_setrlimit (unsigned int resource,
-					   struct rlimit *new_rlim)
-{
-	return 0;
-}
=20
-static inline int security_task_setscheduler (struct task_struct *p,
-					      int policy,
-					      struct sched_param *lp)
-{
-	return 0;
-}
=20
-static inline int security_task_getscheduler (struct task_struct *p)
-{
-	return 0;
-}
=20
-static inline int security_task_kill (struct task_struct *p,
-				      struct siginfo *info, int sig)
-{
-	return 0;
-}
=20
-static inline int security_task_wait (struct task_struct *p)
-{
-	return 0;
-}
=20
-static inline int security_task_prctl (int option, unsigned long arg2,
-				       unsigned long arg3,
-				       unsigned long arg4,
-				       unsigned long arg5)
-{
-	return 0;
-}
=20
-static inline void security_task_reparent_to_init (struct task_struct *p)
-{
-	cap_task_reparent_to_init (p);
-}
=20
-static inline void security_task_to_inode(struct task_struct *p, struct in=
ode *inode)
-{ }
=20
-static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
-					   short flag)
-{
-	return 0;
-}
=20
-static inline int security_msg_msg_alloc (struct msg_msg * msg)
-{
-	return 0;
-}
=20
-static inline void security_msg_msg_free (struct msg_msg * msg)
-{ }
=20
-static inline int security_msg_queue_alloc (struct msg_queue *msq)
-{
-	return 0;
-}
=20
-static inline void security_msg_queue_free (struct msg_queue *msq)
-{ }
=20
-static inline int security_msg_queue_associate (struct msg_queue * msq,=20
-						int msqflg)
-{
-	return 0;
-}
=20
-static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
-{
-	return 0;
-}
=20
-static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
-					     struct msg_msg * msg, int msqflg)
-{
-	return 0;
-}
=20
-static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
-					     struct msg_msg * msg,
-					     struct task_struct * target,
-					     long type, int mode)
-{
-	return 0;
-}
=20
-static inline int security_shm_alloc (struct shmid_kernel *shp)
-{
-	return 0;
-}
=20
-static inline void security_shm_free (struct shmid_kernel *shp)
-{ }
=20
-static inline int security_shm_associate (struct shmid_kernel * shp,=20
-					  int shmflg)
-{
-	return 0;
-}
=20
-static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
-{
-	return 0;
-}
=20
-static inline int security_shm_shmat (struct shmid_kernel * shp,=20
-				      char __user *shmaddr, int shmflg)
-{
-	return 0;
-}
=20
-static inline int security_sem_alloc (struct sem_array *sma)
-{
-	return 0;
-}
=20
-static inline void security_sem_free (struct sem_array *sma)
-{ }
=20
-static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
-{
-	return 0;
-}
=20
-static inline int security_sem_semctl (struct sem_array * sma, int cmd)
-{
-	return 0;
-}
=20
-static inline int security_sem_semop (struct sem_array * sma,=20
-				      struct sembuf * sops, unsigned nsops,=20
-				      int alter)
-{
-	return 0;
-}
=20
-static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
-{ }
=20
-static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
-{
-	return -EINVAL;
-}
=20
-static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
-{
-	return -EINVAL;
-}
=20
-static inline int security_netlink_send (struct sock *sk, struct sk_buff *=
skb)
-{
-	return cap_netlink_send (sk, skb);
-}
=20
-static inline int security_netlink_recv (struct sk_buff *skb)
-{
-	return cap_netlink_recv (skb);
-}
=20
-#endif	/* CONFIG_SECURITY */
+# endif /* CONFIG_SECURITY */
=20
-#ifdef CONFIG_SECURITY_NETWORK
 static inline int security_unix_stream_connect(struct socket * sock,
 					       struct socket * other,=20
 					       struct sock * newsk)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->unix_stream_connect(sock, other, newsk);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
=20
 static inline int security_unix_may_send(struct socket * sock,=20
 					 struct socket * other)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->unix_may_send(sock, other);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_create (int family, int type,
 					  int protocol, int kern)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_create(family, type, protocol, kern);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline void security_socket_post_create(struct socket * sock,=20
 					       int family,
 					       int type,=20
 					       int protocol, int kern)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	security_ops->socket_post_create(sock, family, type,
 					 protocol, kern);
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_bind(struct socket * sock,=20
 				       struct sockaddr * address,=20
 				       int addrlen)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_bind(sock, address, addrlen);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_connect(struct socket * sock,=20
 					  struct sockaddr * address,=20
 					  int addrlen)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_connect(sock, address, addrlen);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_listen(struct socket * sock, int backlog)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_listen(sock, backlog);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_accept(struct socket * sock,=20
 					 struct socket * newsock)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_accept(sock, newsock);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline void security_socket_post_accept(struct socket * sock,=20
 					       struct socket * newsock)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	security_ops->socket_post_accept(sock, newsock);
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_sendmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_sendmsg(sock, msg, size);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_recvmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size,=20
 					  int flags)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_recvmsg(sock, msg, size, flags);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_getsockname(struct socket * sock)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_getsockname(sock);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_getpeername(struct socket * sock)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_getpeername(sock);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_getsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_getsockopt(sock, level, optname);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_setsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_setsockopt(sock, level, optname);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_shutdown(struct socket * sock, int how)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_shutdown(sock, how);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_sock_rcv_skb (struct sock * sk,=20
 					 struct sk_buff * skb)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_sock_rcv_skb (sk, skb);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
 					     int __user *optlen, unsigned len)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_getpeersec(sock, optval, optlen, len);
+# else /* CONFIG_SECURITY_NETWORK */
+	return -ENOPROTOOPT;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->sk_alloc_security(sk, family, priority);
+# else /* CONFIG_SECURITY_NETWORK */
+	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
 static inline void security_sk_free(struct sock *sk)
 {
+# ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->sk_free_security(sk);
-}
-#else	/* CONFIG_SECURITY_NETWORK */
-static inline int security_unix_stream_connect(struct socket * sock,
-					       struct socket * other,=20
-					       struct sock * newsk)
-{
-	return 0;
+# endif /* CONFIG_SECURITY_NETWORK */
 }
=20
-static inline int security_unix_may_send(struct socket * sock,=20
-					 struct socket * other)
-{
-	return 0;
-}
=20
-static inline int security_socket_create (int family, int type,
-					  int protocol, int kern)
-{
-	return 0;
-}
=20
-static inline void security_socket_post_create(struct socket * sock,=20
-					       int family,
-					       int type,=20
-					       int protocol, int kern)
-{
-}
=20
-static inline int security_socket_bind(struct socket * sock,=20
-				       struct sockaddr * address,=20
-				       int addrlen)
-{
-	return 0;
-}
=20
-static inline int security_socket_connect(struct socket * sock,=20
-					  struct sockaddr * address,=20
-					  int addrlen)
-{
-	return 0;
-}
=20
-static inline int security_socket_listen(struct socket * sock, int backlog)
-{
-	return 0;
-}
=20
-static inline int security_socket_accept(struct socket * sock,=20
-					 struct socket * newsock)
-{
-	return 0;
-}
=20
-static inline void security_socket_post_accept(struct socket * sock,=20
-					       struct socket * newsock)
-{
-}
=20
-static inline int security_socket_sendmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size)
-{
-	return 0;
-}
=20
-static inline int security_socket_recvmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size,=20
-					  int flags)
-{
-	return 0;
-}
=20
-static inline int security_socket_getsockname(struct socket * sock)
-{
-	return 0;
-}
=20
-static inline int security_socket_getpeername(struct socket * sock)
-{
-	return 0;
-}
=20
-static inline int security_socket_getsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return 0;
-}
=20
-static inline int security_socket_setsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return 0;
-}
=20
-static inline int security_socket_shutdown(struct socket * sock, int how)
-{
-	return 0;
-}
-static inline int security_sock_rcv_skb (struct sock * sk,=20
-					 struct sk_buff * skb)
-{
-	return 0;
-}
=20
-static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
-					     int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
=20
-static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
-{
-	return 0;
-}
=20
-static inline void security_sk_free(struct sock *sk)
-{
-}
-#endif	/* CONFIG_SECURITY_NETWORK */
=20
-#endif /* ! __LINUX_SECURITY_H */
+#endif /* __LINUX_SECURITY_H */
=20

--xB0nW4MQa6jZONgY--

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyAezxmLh6hyYd04RAnz6AJ4yxGaNtRMdh3MGWJi4FwEiFuQAkQCff2RJ
EJuuwH8ZHnRkPMiu+zsOwdU=
=kbyD
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
