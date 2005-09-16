Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbVIPS00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbVIPS00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbVIPS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:26:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47805 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161227AbVIPS0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:23 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 1/10] vfs: Lindentified namespace.c 
Message-ID: <20050916182619.GA28428@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lindentified fs/namespace.c

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c |  180 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 91 insertions(+), 89 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -35,37 +35,37 @@ static inline int sysfs_init(void)
 	return 0;
 }
 #endif
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
-static kmem_cache_t *mnt_cache; 
+static kmem_cache_t *mnt_cache;
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
-	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
-	tmp += ((unsigned long) dentry / L1_CACHE_BYTES);
+	unsigned long tmp = ((unsigned long)mnt / L1_CACHE_BYTES);
+	tmp += ((unsigned long)dentry / L1_CACHE_BYTES);
 	tmp = tmp + (tmp >> hash_bits);
 	return tmp & hash_mask;
 }
 
 struct vfsmount *alloc_vfsmnt(const char *name)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
+	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
-		atomic_set(&mnt->mnt_count,1);
+		atomic_set(&mnt->mnt_count, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
 		if (name) {
-			int size = strlen(name)+1;
+			int size = strlen(name) + 1;
 			char *newname = kmalloc(size, GFP_KERNEL);
 			if (newname) {
 				memcpy(newname, name, size);
 				mnt->mnt_devname = newname;
 			}
@@ -84,12 +84,12 @@ void free_vfsmnt(struct vfsmount *mnt)
  * Now, lookup_mnt increments the ref count before returning
  * the vfsmount struct.
  */
 struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
-	struct list_head * head = mount_hashtable + hash(mnt, dentry);
-	struct list_head * tmp = head;
+	struct list_head *head = mount_hashtable + hash(mnt, dentry);
+	struct list_head *tmp = head;
 	struct vfsmount *p, *found = NULL;
 
 	spin_lock(&vfsmount_lock);
 	for (;;) {
 		tmp = tmp->next;
@@ -124,11 +124,11 @@ static void detach_mnt(struct vfsmount *
 
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
+	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
 }
 
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
@@ -145,12 +145,11 @@ static struct vfsmount *next_mnt(struct 
 		}
 	}
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
 
 	if (mnt) {
@@ -181,29 +180,29 @@ void __mntput(struct vfsmount *mnt)
 }
 
 EXPORT_SYMBOL(__mntput);
 
 /* iterator */
-static void *m_start(struct seq_file *m, loff_t *pos)
+static void *m_start(struct seq_file *m, loff_t * pos)
 {
 	struct namespace *n = m->private;
 	struct list_head *p;
 	loff_t l = *pos;
 
 	down_read(&n->sem);
 	list_for_each(p, &n->list)
-		if (!l--)
-			return list_entry(p, struct vfsmount, mnt_list);
+	    if (!l--)
+		return list_entry(p, struct vfsmount, mnt_list);
 	return NULL;
 }
 
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+static void *m_next(struct seq_file *m, void *v, loff_t * pos)
 {
 	struct namespace *n = m->private;
 	struct list_head *p = ((struct vfsmount *)v)->mnt_list.next;
 	(*pos)++;
-	return p==&n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
+	return p == &n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct namespace *n = m->private;
@@ -221,11 +220,11 @@ static int show_vfsmnt(struct seq_file *
 	int err = 0;
 	static struct proc_fs_info {
 		int flag;
 		char *str;
 	} fs_info[] = {
-		{ MS_SYNCHRONOUS, ",sync" },
+		{ MS_SYNCHRONOUS, ",sync" },
 		{ MS_DIRSYNC, ",dirsync" },
 		{ MS_MANDLOCK, ",mand" },
 		{ MS_NOATIME, ",noatime" },
 		{ MS_NODIRATIME, ",nodiratime" },
 		{ 0, NULL }
@@ -257,14 +256,14 @@ static int show_vfsmnt(struct seq_file *
 	seq_puts(m, " 0 0\n");
 	return err;
 }
 
 struct seq_operations mounts_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_vfsmnt
+	.start = m_start,
+	.next = m_next,
+	.stop = m_stop,
+	.show = show_vfsmnt
 };
 
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
@@ -281,15 +280,16 @@ int may_umount_tree(struct vfsmount *mnt
 	int minimum_refs;
 
 	spin_lock(&vfsmount_lock);
 	actual_refs = atomic_read(&mnt->mnt_count);
 	minimum_refs = 2;
-repeat:
+      repeat:
 	next = this_parent->mnt_mounts.next;
-resume:
+      resume:
 	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+		struct vfsmount *p =
+		    list_entry(next, struct vfsmount, mnt_child);
 
 		next = next->next;
 
 		actual_refs += atomic_read(&p->mnt_count);
 		minimum_refs += 2;
@@ -365,11 +365,11 @@ static void umount_tree(struct vfsmount 
 	}
 }
 
 static int do_umount(struct vfsmount *mnt, int flags)
 {
-	struct super_block * sb = mnt->mnt_sb;
+	struct super_block *sb = mnt->mnt_sb;
 	int retval;
 
 	retval = security_sb_umount(mnt, flags);
 	if (retval)
 		return retval;
@@ -401,11 +401,11 @@ static int do_umount(struct vfsmount *mn
 	 * must return, and the like. Thats for the mount program to worry
 	 * about for the moment.
 	 */
 
 	lock_kernel();
-	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
+	if ((flags & MNT_FORCE) && sb->s_op->umount_begin)
 		sb->s_op->umount_begin(sb);
 	unlock_kernel();
 
 	/*
 	 * No sense to grab the lock for this test, but test itself looks
@@ -483,25 +483,25 @@ asmlinkage long sys_umount(char __user *
 	retval = -EPERM;
 	if (!capable(CAP_SYS_ADMIN))
 		goto dput_and_out;
 
 	retval = do_umount(nd.mnt, flags);
-dput_and_out:
+      dput_and_out:
 	path_release_on_umount(&nd);
-out:
+      out:
 	return retval;
 }
 
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
- *	The 2.0 compatible umount. No flags. 
+ *	The 2.0 compatible umount. No flags.
  */
- 
+
 asmlinkage long sys_oldumount(char __user * name)
 {
-	return sys_umount(name,0);
+	return sys_umount(name, 0);
 }
 
 #endif
 
 static int mount_is_safe(struct nameidata *nd)
@@ -520,12 +520,11 @@ static int mount_is_safe(struct nameidat
 		return -EPERM;
 	return 0;
 #endif
 }
 
-static int
-lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
+static int lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
 {
 	while (1) {
 		if (d == dentry)
 			return 1;
 		if (d == NULL || d == d->d_parent)
@@ -567,11 +566,11 @@ static struct vfsmount *copy_tree(struct
 			attach_mnt(q, &nd);
 			spin_unlock(&vfsmount_lock);
 		}
 	}
 	return res;
- Enomem:
+      Enomem:
 	if (res) {
 		spin_lock(&vfsmount_lock);
 		umount_tree(res);
 		spin_unlock(&vfsmount_lock);
 	}
@@ -583,11 +582,11 @@ static int graft_tree(struct vfsmount *m
 	int err;
 	if (mnt->mnt_sb->s_flags & MS_NOUSER)
 		return -EINVAL;
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-	      S_ISDIR(mnt->mnt_root->d_inode->i_mode))
+	    S_ISDIR(mnt->mnt_root->d_inode->i_mode))
 		return -ENOTDIR;
 
 	err = -ENOENT;
 	down(&nd->dentry->d_inode->i_sem);
 	if (IS_DEADDIR(nd->dentry->d_inode))
@@ -607,11 +606,11 @@ static int graft_tree(struct vfsmount *m
 		list_splice(&head, current->namespace->list.prev);
 		mntget(mnt);
 		err = 0;
 	}
 	spin_unlock(&vfsmount_lock);
-out_unlock:
+      out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
 		security_sb_post_addmount(mnt, nd);
 	return err;
 }
@@ -665,16 +664,15 @@ static int do_loopback(struct nameidata 
 /*
  * change filesystem flags. dir should be a physical root of filesystem.
  * If you've mounted a non-root directory somewhere and want to do remount
  * on it - tough luck.
  */
-
 static int do_remount(struct nameidata *nd, int flags, int mnt_flags,
 		      void *data)
 {
 	int err;
-	struct super_block * sb = nd->mnt->mnt_sb;
+	struct super_block *sb = nd->mnt->mnt_sb;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (!check_mnt(nd->mnt))
@@ -684,11 +682,11 @@ static int do_remount(struct nameidata *
 		return -EINVAL;
 
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
-		nd->mnt->mnt_flags=mnt_flags;
+		nd->mnt->mnt_flags = mnt_flags;
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
@@ -705,12 +703,11 @@ static int do_move_mount(struct nameidat
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
 	down_write(&current->namespace->sem);
-	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
-		;
+	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
 		goto out;
 
 	err = -ENOENT;
@@ -728,30 +725,30 @@ static int do_move_mount(struct nameidat
 
 	if (old_nd.mnt == old_nd.mnt->mnt_parent)
 		goto out2;
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
+	    S_ISDIR(old_nd.dentry->d_inode->i_mode))
 		goto out2;
 
 	err = -ELOOP;
-	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
+	for (p = nd->mnt; p->mnt_parent != p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
 			goto out2;
 	err = 0;
 
 	detach_mnt(old_nd.mnt, &parent_nd);
 	attach_mnt(old_nd.mnt, nd);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old_nd.mnt->mnt_expire);
-out2:
+      out2:
 	spin_unlock(&vfsmount_lock);
-out1:
+      out1:
 	up(&nd->dentry->d_inode->i_sem);
-out:
+      out:
 	up_write(&current->namespace->sem);
 	if (!err)
 		path_release(&parent_nd);
 	path_release(&old_nd);
 	return err;
@@ -789,12 +786,11 @@ int do_add_mount(struct vfsmount *newmnt
 {
 	int err;
 
 	down_write(&current->namespace->sem);
 	/* Something was mounted here while we slept */
-	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
-		;
+	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt))
 		goto unlock;
 
 	/* Refuse the same filesystem on the same mount point */
@@ -816,11 +812,11 @@ int do_add_mount(struct vfsmount *newmnt
 		spin_lock(&vfsmount_lock);
 		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
 
-unlock:
+      unlock:
 	up_write(&current->namespace->sem);
 	mntput(newmnt);
 	return err;
 }
 
@@ -943,11 +939,11 @@ EXPORT_SYMBOL_GPL(mark_mounts_for_expiry
  * bytes remaining to copy on a fault.  But copy_mount_options() requires that.
  * Note that this function differs from copy_from_user() in that it will oops
  * on bad values of `to', rather than returning a short copy.
  */
 static long
-exact_copy_from_user(void *to, const void __user *from, unsigned long n)
+exact_copy_from_user(void *to, const void __user * from, unsigned long n)
 {
 	char *t = to;
 	const char __user *f = from;
 	char c;
 
@@ -964,16 +960,16 @@ exact_copy_from_user(void *to, const voi
 		n--;
 	}
 	return n;
 }
 
-int copy_mount_options(const void __user *data, unsigned long *where)
+int copy_mount_options(const void __user * data, unsigned long *where)
 {
 	int i;
 	unsigned long page;
 	unsigned long size;
-	
+
 	*where = 0;
 	if (!data)
 		return 0;
 
 	if (!(page = __get_free_page(GFP_KERNEL)))
@@ -988,11 +984,11 @@ int copy_mount_options(const void __user
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
 	i = size - exact_copy_from_user((void *)page, data, size);
 	if (!i) {
-		free_page(page); 
+		free_page(page);
 		return -EFAULT;
 	}
 	if (i != PAGE_SIZE)
 		memset((char *)page + i, 0, PAGE_SIZE - i);
 	*where = page;
@@ -1011,12 +1007,12 @@ int copy_mount_options(const void __user
  * When the flags word was introduced its top half was required
  * to have the magic value 0xC0ED, and this remained so until 2.4.0-test9.
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
 	int mnt_flags = 0;
 
@@ -1039,11 +1035,11 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
+	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
 	if (retval)
 		return retval;
@@ -1060,11 +1056,11 @@ long do_mount(char * dev_name, char * di
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
 		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
-dput_out:
+      dput_out:
 	path_release(&nd);
 	return retval;
 }
 
 int copy_namespace(int flags, struct task_struct *tsk)
@@ -1146,11 +1142,11 @@ int copy_namespace(int flags, struct tas
 		mntput(altrootmnt);
 
 	put_namespace(namespace);
 	return 0;
 
-out:
+      out:
 	put_namespace(namespace);
 	return -ENOMEM;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
@@ -1161,38 +1157,38 @@ asmlinkage long sys_mount(char __user * 
 	unsigned long data_page;
 	unsigned long type_page;
 	unsigned long dev_page;
 	char *dir_page;
 
-	retval = copy_mount_options (type, &type_page);
+	retval = copy_mount_options(type, &type_page);
 	if (retval < 0)
 		return retval;
 
 	dir_page = getname(dir_name);
 	retval = PTR_ERR(dir_page);
 	if (IS_ERR(dir_page))
 		goto out1;
 
-	retval = copy_mount_options (dev_name, &dev_page);
+	retval = copy_mount_options(dev_name, &dev_page);
 	if (retval < 0)
 		goto out2;
 
-	retval = copy_mount_options (data, &data_page);
+	retval = copy_mount_options(data, &data_page);
 	if (retval < 0)
 		goto out3;
 
 	lock_kernel();
-	retval = do_mount((char*)dev_page, dir_page, (char*)type_page,
-			  flags, (void*)data_page);
+	retval = do_mount((char *)dev_page, dir_page, (char *)type_page,
+			  flags, (void *)data_page);
 	unlock_kernel();
 	free_page(data_page);
 
-out3:
+      out3:
 	free_page(dev_page);
-out2:
+      out2:
 	putname(dir_page);
-out1:
+      out1:
 	free_page(type_page);
 	return retval;
 }
 
 /*
@@ -1249,18 +1245,21 @@ static void chroot_fs_refs(struct nameid
 		task_lock(p);
 		fs = p->fs;
 		if (fs) {
 			atomic_inc(&fs->count);
 			task_unlock(p);
-			if (fs->root==old_nd->dentry&&fs->rootmnt==old_nd->mnt)
+			if (fs->root == old_nd->dentry
+			    && fs->rootmnt == old_nd->mnt)
 				set_fs_root(fs, new_nd->mnt, new_nd->dentry);
-			if (fs->pwd==old_nd->dentry&&fs->pwdmnt==old_nd->mnt)
+			if (fs->pwd == old_nd->dentry
+			    && fs->pwdmnt == old_nd->mnt)
 				set_fs_pwd(fs, new_nd->mnt, new_nd->dentry);
 			put_fs_struct(fs);
 		} else
 			task_unlock(p);
-	} while_each_thread(g, p);
+	}
+	while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 }
 
 /*
  * pivot_root Semantics:
@@ -1281,30 +1280,31 @@ static void chroot_fs_refs(struct nameid
  *  - it's okay to pick a root that isn't the root of a file system, e.g.
  *    /nfs/my_root where /nfs is the mount point. It must be a mountpoint,
  *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
  *    first.
  */
-
-asmlinkage long sys_pivot_root(const char __user *new_root, const char __user *put_old)
+asmlinkage long sys_pivot_root(const char __user * new_root,
+			       const char __user * put_old)
 {
 	struct vfsmount *tmp;
 	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
 	int error;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	lock_kernel();
 
-	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
+	error =
+	    __user_walk(new_root, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new_nd);
 	if (error)
 		goto out0;
 	error = -EINVAL;
 	if (!check_mnt(new_nd.mnt))
 		goto out1;
 
-	error = __user_walk(put_old, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
+	error = __user_walk(put_old, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old_nd);
 	if (error)
 		goto out1;
 
 	error = security_sb_pivotroot(&old_nd, &new_nd);
 	if (error) {
@@ -1328,51 +1328,51 @@ asmlinkage long sys_pivot_root(const cha
 		goto out2;
 	if (d_unhashed(old_nd.dentry) && !IS_ROOT(old_nd.dentry))
 		goto out2;
 	error = -EBUSY;
 	if (new_nd.mnt == user_nd.mnt || old_nd.mnt == user_nd.mnt)
-		goto out2; /* loop, on the same file system  */
+		goto out2;	/* loop, on the same file system  */
 	error = -EINVAL;
 	if (user_nd.mnt->mnt_root != user_nd.dentry)
-		goto out2; /* not a mountpoint */
+		goto out2;	/* not a mountpoint */
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
-		goto out2; /* not a mountpoint */
-	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
+		goto out2;	/* not a mountpoint */
+	tmp = old_nd.mnt;	/* make sure we can reach put_old from new_root */
 	spin_lock(&vfsmount_lock);
 	if (tmp != new_nd.mnt) {
 		for (;;) {
 			if (tmp->mnt_parent == tmp)
-				goto out3; /* already mounted on put_old */
+				goto out3;	/* already mounted on put_old */
 			if (tmp->mnt_parent == new_nd.mnt)
 				break;
 			tmp = tmp->mnt_parent;
 		}
 		if (!is_subdir(tmp->mnt_mountpoint, new_nd.dentry))
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
 	detach_mnt(new_nd.mnt, &parent_nd);
 	detach_mnt(user_nd.mnt, &root_parent);
-	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
-	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
+	attach_mnt(user_nd.mnt, &old_nd);	/* mount old root on put_old */
+	attach_mnt(new_nd.mnt, &root_parent);	/* mount new_root on / */
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
-out2:
+      out2:
 	up(&old_nd.dentry->d_inode->i_sem);
 	up_write(&current->namespace->sem);
 	path_release(&user_nd);
 	path_release(&old_nd);
-out1:
+      out1:
 	path_release(&new_nd);
-out0:
+      out0:
 	unlock_kernel();
 	return error;
-out3:
+      out3:
 	spin_unlock(&vfsmount_lock);
 	goto out2;
 }
 
 static void __init init_mount_tree(void)
@@ -1397,11 +1397,12 @@ static void __init init_mount_tree(void)
 	init_task.namespace = namespace;
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		get_namespace(namespace);
 		p->namespace = namespace;
-	} while_each_thread(g, p);
+	}
+	while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 
 	set_fs_pwd(current->fs, namespace->root, namespace->root->mnt_root);
 	set_fs_root(current->fs, namespace->root, namespace->root->mnt_root);
 }
@@ -1411,14 +1412,15 @@ void __init mnt_init(unsigned long mempa
 	struct list_head *d;
 	unsigned int nr_hash;
 	int i;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+				      0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL,
+				      NULL);
 
 	mount_hashtable = (struct list_head *)
-		__get_free_page(GFP_ATOMIC);
+	    __get_free_page(GFP_ATOMIC);
 
 	if (!mount_hashtable)
 		panic("Failed to allocate mount hash table\n");
 
 	/*
@@ -1436,11 +1438,11 @@ void __init mnt_init(unsigned long mempa
 	/*
 	 * Re-calculate the actual number of entries and the mask
 	 * from the number of bits we can fit.
 	 */
 	nr_hash = 1UL << hash_bits;
-	hash_mask = nr_hash-1;
+	hash_mask = nr_hash - 1;
 
 	printk("Mount-cache hash table entries: %d\n", nr_hash);
 
 	/* And initialize the newly allocated array */
 	d = mount_hashtable;
