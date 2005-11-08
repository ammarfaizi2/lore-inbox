Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVKHCHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVKHCHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKHCBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29645 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965256AbVKHCBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:37 -0500
To: torvalds@osdl.org
Subject: [PATCH 5/18] lindent fs/namespace.c
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001El-A3@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401769 -0500

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   97 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 48 insertions(+), 49 deletions(-)

38500791664754db810ce1bc0e6a2cb9622700ac
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -43,29 +43,29 @@ static int event;
 
 static struct list_head *mount_hashtable;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
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
@@ -88,8 +88,8 @@ void free_vfsmnt(struct vfsmount *mnt)
  */
 struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
-	struct list_head * head = mount_hashtable + hash(mnt, dentry);
-	struct list_head * tmp = head;
+	struct list_head *head = mount_hashtable + hash(mnt, dentry);
+	struct list_head *tmp = head;
 	struct vfsmount *p, *found = NULL;
 
 	spin_lock(&vfsmount_lock);
@@ -144,7 +144,7 @@ static void attach_mnt(struct vfsmount *
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
+	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
 }
@@ -165,8 +165,7 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
@@ -258,7 +257,7 @@ static void *m_next(struct seq_file *m, 
 	struct namespace *n = m->private;
 	struct list_head *p = ((struct vfsmount *)v)->mnt_list.next;
 	(*pos)++;
-	return p==&n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
+	return p == &n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -344,7 +343,8 @@ repeat:
 	next = this_parent->mnt_mounts.next;
 resume:
 	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+		struct vfsmount *p =
+		    list_entry(next, struct vfsmount, mnt_child);
 
 		next = next->next;
 
@@ -425,7 +425,7 @@ static void umount_tree(struct vfsmount 
 
 static int do_umount(struct vfsmount *mnt, int flags)
 {
-	struct super_block * sb = mnt->mnt_sb;
+	struct super_block *sb = mnt->mnt_sb;
 	int retval;
 
 	retval = security_sb_umount(mnt, flags);
@@ -461,7 +461,7 @@ static int do_umount(struct vfsmount *mn
 	 */
 
 	lock_kernel();
-	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
+	if ((flags & MNT_FORCE) && sb->s_op->umount_begin)
 		sb->s_op->umount_begin(sb);
 	unlock_kernel();
 
@@ -543,12 +543,11 @@ out:
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
- *	The 2.0 compatible umount. No flags. 
+ *	The 2.0 compatible umount. No flags.
  */
- 
 asmlinkage long sys_oldumount(char __user * name)
 {
-	return sys_umount(name,0);
+	return sys_umount(name, 0);
 }
 
 #endif
@@ -571,8 +570,7 @@ static int mount_is_safe(struct nameidat
 #endif
 }
 
-static int
-lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
+static int lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
 {
 	while (1) {
 		if (d == dentry)
@@ -616,7 +614,7 @@ static struct vfsmount *copy_tree(struct
 		}
 	}
 	return res;
- Enomem:
+Enomem:
 	if (res) {
 		spin_lock(&vfsmount_lock);
 		umount_tree(res);
@@ -718,12 +716,11 @@ out:
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
@@ -737,7 +734,7 @@ static int do_remount(struct nameidata *
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
-		nd->mnt->mnt_flags=mnt_flags;
+		nd->mnt->mnt_flags = mnt_flags;
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
@@ -758,7 +755,7 @@ static int do_move_mount(struct nameidat
 		return err;
 
 	down_write(&current->namespace->sem);
-	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
+	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
@@ -785,7 +782,7 @@ static int do_move_mount(struct nameidat
 		goto out2;
 
 	err = -ELOOP;
-	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
+	for (p = nd->mnt; p->mnt_parent != p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
 			goto out2;
 	err = 0;
@@ -843,7 +840,7 @@ int do_add_mount(struct vfsmount *newmnt
 
 	down_write(&current->namespace->sem);
 	/* Something was mounted here while we slept */
-	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
+	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt))
@@ -986,8 +983,8 @@ EXPORT_SYMBOL_GPL(mark_mounts_for_expiry
  * Note that this function differs from copy_from_user() in that it will oops
  * on bad values of `to', rather than returning a short copy.
  */
-static long
-exact_copy_from_user(void *to, const void __user *from, unsigned long n)
+static long exact_copy_from_user(void *to, const void __user * from,
+				 unsigned long n)
 {
 	char *t = to;
 	const char __user *f = from;
@@ -1008,12 +1005,12 @@ exact_copy_from_user(void *to, const voi
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
@@ -1032,7 +1029,7 @@ int copy_mount_options(const void __user
 
 	i = size - exact_copy_from_user((void *)page, data, size);
 	if (!i) {
-		free_page(page); 
+		free_page(page);
 		return -EFAULT;
 	}
 	if (i != PAGE_SIZE)
@@ -1055,7 +1052,7 @@ int copy_mount_options(const void __user
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-long do_mount(char * dev_name, char * dir_name, char *type_page,
+long do_mount(char *dev_name, char *dir_name, char *type_page,
 		  unsigned long flags, void *data_page)
 {
 	struct nameidata nd;
@@ -1083,7 +1080,7 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
+	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
@@ -1207,7 +1204,7 @@ asmlinkage long sys_mount(char __user * 
 	unsigned long dev_page;
 	char *dir_page;
 
-	retval = copy_mount_options (type, &type_page);
+	retval = copy_mount_options(type, &type_page);
 	if (retval < 0)
 		return retval;
 
@@ -1216,17 +1213,17 @@ asmlinkage long sys_mount(char __user * 
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
 
@@ -1295,9 +1292,11 @@ static void chroot_fs_refs(struct nameid
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
@@ -1327,8 +1326,8 @@ static void chroot_fs_refs(struct nameid
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
@@ -1339,14 +1338,15 @@ asmlinkage long sys_pivot_root(const cha
 
 	lock_kernel();
 
-	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
+	error = __user_walk(new_root, LOOKUP_FOLLOW | LOOKUP_DIRECTORY,
+			    &new_nd);
 	if (error)
 		goto out0;
 	error = -EINVAL;
 	if (!check_mnt(new_nd.mnt))
 		goto out1;
 
-	error = __user_walk(put_old, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
+	error = __user_walk(put_old, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old_nd);
 	if (error)
 		goto out1;
 
@@ -1464,10 +1464,9 @@ void __init mnt_init(unsigned long mempa
 	int i;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
 
-	mount_hashtable = (struct list_head *)
-		__get_free_page(GFP_ATOMIC);
+	mount_hashtable = (struct list_head *)__get_free_page(GFP_ATOMIC);
 
 	if (!mount_hashtable)
 		panic("Failed to allocate mount hash table\n");
@@ -1489,7 +1488,7 @@ void __init mnt_init(unsigned long mempa
 	 * from the number of bits we can fit.
 	 */
 	nr_hash = 1UL << hash_bits;
-	hash_mask = nr_hash-1;
+	hash_mask = nr_hash - 1;
 
 	printk("Mount-cache hash table entries: %d\n", nr_hash);
 
