Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262521AbSJAVuX>; Tue, 1 Oct 2002 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262522AbSJAVuX>; Tue, 1 Oct 2002 17:50:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:62026 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262521AbSJAVt2>; Tue, 1 Oct 2002 17:49:28 -0400
Date: Tue, 1 Oct 2002 22:55:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 9/9 whitespace only
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012254440.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regularize the erratic whitespace conventions in mm/shmem.c.  Removal
of blank line changes BUG_ON line numbers, otherwise builds the same.

--- tmpfs8/mm/shmem.c	Tue Oct  1 19:49:29 2002
+++ tmpfs9/mm/shmem.c	Tue Oct  1 19:49:34 2002
@@ -140,7 +140,7 @@
  *
  * It has to be called with the spinlock held.
  */
-static void shmem_recalc_inode(struct inode * inode)
+static void shmem_recalc_inode(struct inode *inode)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	long freed;
@@ -511,8 +511,7 @@
 	return error;
 }
 
-
-static void shmem_delete_inode(struct inode * inode)
+static void shmem_delete_inode(struct inode *inode)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -524,12 +523,12 @@
 		if (info->flags & VM_ACCOUNT)
 			vm_unacct_memory(VM_ACCT(inode->i_size));
 		inode->i_size = 0;
-		shmem_truncate (inode);
+		shmem_truncate(inode);
 	}
 	BUG_ON(inode->i_blocks);
-	spin_lock (&sbinfo->stat_lock);
+	spin_lock(&sbinfo->stat_lock);
 	sbinfo->free_inodes++;
-	spin_unlock (&sbinfo->stat_lock);
+	spin_unlock(&sbinfo->stat_lock);
 	clear_inode(inode);
 }
 
@@ -629,10 +628,10 @@
 int shmem_unuse(swp_entry_t entry, struct page *page)
 {
 	struct list_head *p;
-	struct shmem_inode_info * info;
+	struct shmem_inode_info *info;
 	int found = 0;
 
-	spin_lock (&shmem_ilock);
+	spin_lock(&shmem_ilock);
 	list_for_each(p, &shmem_inodes) {
 		info = list_entry(p, struct shmem_inode_info, list);
 
@@ -643,14 +642,14 @@
 			break;
 		}
 	}
-	spin_unlock (&shmem_ilock);
+	spin_unlock(&shmem_ilock);
 	return found;
 }
 
 /*
  * Move the page from the page cache to the swap cache.
  */
-static int shmem_writepage(struct page * page)
+static int shmem_writepage(struct page *page)
 {
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
@@ -909,10 +908,10 @@
 	return page;
 }
 
-void shmem_lock(struct file * file, int lock)
+void shmem_lock(struct file *file, int lock)
 {
-	struct inode * inode = file->f_dentry->d_inode;
-	struct shmem_inode_info * info = SHMEM_I(inode);
+	struct inode *inode = file->f_dentry->d_inode;
+	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	spin_lock(&info->lock);
 	if (lock)
@@ -922,9 +921,9 @@
 	spin_unlock(&info->lock);
 }
 
-static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
+static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct vm_operations_struct * ops;
+	struct vm_operations_struct *ops;
 	struct inode *inode = file->f_dentry->d_inode;
 
 	ops = &shmem_vm_ops;
@@ -937,17 +936,17 @@
 
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
 {
-	struct inode * inode;
+	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
-	spin_lock (&sbinfo->stat_lock);
+	spin_lock(&sbinfo->stat_lock);
 	if (!sbinfo->free_inodes) {
-		spin_unlock (&sbinfo->stat_lock);
+		spin_unlock(&sbinfo->stat_lock);
 		return NULL;
 	}
 	sbinfo->free_inodes--;
-	spin_unlock (&sbinfo->stat_lock);
+	spin_unlock(&sbinfo->stat_lock);
 
 	inode = new_inode(sb);
 	if (inode) {
@@ -971,9 +970,9 @@
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
-			spin_lock (&shmem_ilock);
+			spin_lock(&shmem_ilock);
 			list_add_tail(&info->list, &shmem_inodes);
-			spin_unlock (&shmem_ilock);
+			spin_unlock(&shmem_ilock);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1019,9 +1018,9 @@
 static struct inode_operations shmem_symlink_inline_operations;
 
 static ssize_t
-shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
+shmem_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	struct inode	*inode = file->f_dentry->d_inode; 
+	struct inode	*inode = file->f_dentry->d_inode;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	struct page	*page;
@@ -1129,7 +1128,7 @@
 			count -= bytes;
 			pos += bytes;
 			buf += bytes;
-			if (pos > inode->i_size) 
+			if (pos > inode->i_size)
 				inode->i_size = pos;
 		}
 unlock:
@@ -1156,7 +1155,7 @@
 	goto unlock;
 }
 
-static void do_shmem_file_read(struct file * filp, loff_t *ppos, read_descriptor_t * desc)
+static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
@@ -1220,7 +1219,7 @@
 		offset += nr;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
-	
+
 		page_cache_release(page);
 	}
 
@@ -1228,7 +1227,7 @@
 	UPDATE_ATIME(inode);
 }
 
-static ssize_t shmem_file_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
+static ssize_t shmem_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	ssize_t retval;
 
@@ -1259,12 +1258,12 @@
 
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
-	spin_lock (&sbinfo->stat_lock);
+	spin_lock(&sbinfo->stat_lock);
 	buf->f_blocks = sbinfo->max_blocks;
 	buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
 	buf->f_files = sbinfo->max_inodes;
 	buf->f_ffree = sbinfo->free_inodes;
-	spin_unlock (&sbinfo->stat_lock);
+	spin_unlock(&sbinfo->stat_lock);
 	buf->f_namelen = NAME_MAX;
 	return 0;
 }
@@ -1274,7 +1273,7 @@
  */
 static int shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
 {
-	struct inode * inode = shmem_get_inode(dir->i_sb, mode, dev);
+	struct inode *inode = shmem_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
 
 	if (inode) {
@@ -1287,7 +1286,7 @@
 	return error;
 }
 
-static int shmem_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+static int shmem_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int error;
 
@@ -1305,7 +1304,7 @@
 /*
  * Link a file..
  */
-static int shmem_link(struct dentry *old_dentry, struct inode * dir, struct dentry * dentry)
+static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
 
@@ -1351,7 +1350,7 @@
 	return 1;
 }
 
-static int shmem_unlink(struct inode * dir, struct dentry *dentry)
+static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 
@@ -1362,7 +1361,7 @@
 	return 0;
 }
 
-static int shmem_rmdir(struct inode * dir, struct dentry *dentry)
+static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (!shmem_empty(dentry))
 		return -ENOTEMPTY;
@@ -1377,12 +1376,12 @@
  * it exists so that the VFS layer correctly free's it when it
  * gets overwritten.
  */
-static int shmem_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
+static int shmem_rename(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 
-	if (!shmem_empty(new_dentry)) 
+	if (!shmem_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (new_dentry->d_inode) {
@@ -1402,14 +1401,14 @@
 	return 0;
 }
 
-static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 {
 	int error;
 	int len;
 	struct inode *inode;
 	struct page *page;
 	char *kaddr;
-	struct shmem_inode_info * info;
+	struct shmem_inode_info *info;
 
 	len = strlen(symname) + 1;
 	if (len > PAGE_CACHE_SIZE)
@@ -1437,9 +1436,9 @@
 			return error;
 		}
 		inode->i_op = &shmem_symlink_inode_operations;
-		spin_lock (&shmem_ilock);
+		spin_lock(&shmem_ilock);
 		list_add_tail(&info->list, &shmem_inodes);
-		spin_unlock (&shmem_ilock);
+		spin_unlock(&shmem_ilock);
 		kaddr = kmap(page);
 		memcpy(kaddr, symname, len);
 		kunmap(page);
@@ -1456,7 +1455,7 @@
 
 static int shmem_readlink_inline(struct dentry *dentry, char *buffer, int buflen)
 {
-	return vfs_readlink(dentry,buffer,buflen, (const char *)SHMEM_I(dentry->d_inode));
+	return vfs_readlink(dentry, buffer, buflen, (const char *)SHMEM_I(dentry->d_inode));
 }
 
 static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
@@ -1501,7 +1500,7 @@
 	.follow_link	= shmem_follow_link,
 };
 
-static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
 {
 	char *this_char, *value, *rest;
 
@@ -1511,8 +1510,8 @@
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		} else {
-			printk(KERN_ERR 
-			    "tmpfs: No value for mount option '%s'\n", 
+			printk(KERN_ERR
+			    "tmpfs: No value for mount option '%s'\n",
 			    this_char);
 			return 1;
 		}
@@ -1558,13 +1557,13 @@
 	return 0;
 
 bad_val:
-	printk(KERN_ERR "tmpfs: Bad value '%s' for mount option '%s'\n", 
+	printk(KERN_ERR "tmpfs: Bad value '%s' for mount option '%s'\n",
 	       value, this_char);
 	return 1;
 
 }
 
-static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+static int shmem_remount_fs(struct super_block *sb, int *flags, char *data)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	unsigned long max_blocks = sbinfo->max_blocks;
@@ -1575,16 +1574,16 @@
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
 
-int shmem_sync_file(struct file * file, struct dentry *dentry, int datasync)
+int shmem_sync_file(struct file *file, struct dentry *dentry, int datasync)
 {
 	return 0;
 }
 #endif
 
-static int shmem_fill_super(struct super_block * sb, void * data, int silent)
+static int shmem_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct inode * inode;
-	struct dentry * root;
+	struct inode *inode;
+	struct dentry *root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
 	uid_t uid = current->fsuid;
@@ -1615,7 +1614,7 @@
 	sb->s_flags |= MS_NOUSER;
 #endif
 
-	spin_lock_init (&sbinfo->stat_lock);
+	spin_lock_init(&sbinfo->stat_lock);
 	sbinfo->max_blocks = blocks;
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
@@ -1655,7 +1654,7 @@
 	sb->u.generic_sbp = NULL;
 }
 
-static kmem_cache_t * shmem_inode_cachep;
+static kmem_cache_t *shmem_inode_cachep;
 
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
@@ -1671,7 +1670,7 @@
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
 {
 	struct shmem_inode_info *p = (struct shmem_inode_info *) foo;
 
@@ -1680,7 +1679,7 @@
 		inode_init_once(&p->vfs_inode);
 	}
 }
- 
+
 static int init_inodecache(void)
 {
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
@@ -1775,7 +1774,7 @@
 static int __init init_shmem_fs(void)
 {
 	int error;
-	struct vfsmount * res;
+	struct vfsmount *res;
 
 	error = init_inodecache();
 	if (error)
@@ -1783,21 +1782,21 @@
 
 	error = register_filesystem(&tmpfs_fs_type);
 	if (error) {
-		printk (KERN_ERR "Could not register tmpfs\n");
+		printk(KERN_ERR "Could not register tmpfs\n");
 		goto out2;
 	}
 #ifdef CONFIG_TMPFS
 	error = register_filesystem(&shmem_fs_type);
 	if (error) {
-		printk (KERN_ERR "Could not register shm fs\n");
+		printk(KERN_ERR "Could not register shm fs\n");
 		goto out1;
 	}
-	devfs_mk_dir (NULL, "shm", NULL);
+	devfs_mk_dir(NULL, "shm", NULL);
 #endif
 	res = kern_mount(&tmpfs_fs_type);
 	if (IS_ERR (res)) {
 		error = PTR_ERR(res);
-		printk (KERN_ERR "could not kern_mount tmpfs\n");
+		printk(KERN_ERR "could not kern_mount tmpfs\n");
 		goto out;
 	}
 	shm_mnt = res;
@@ -1838,11 +1837,11 @@
  * @size: size to be set for the file
  *
  */
-struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags)
+struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags)
 {
 	int error;
 	struct file *file;
-	struct inode * inode;
+	struct inode *inode;
 	struct dentry *dentry, *root;
 	struct qstr this;
 
@@ -1868,7 +1867,7 @@
 
 	error = -ENOSPC;
 	inode = shmem_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
-	if (!inode) 
+	if (!inode)
 		goto close_file;
 
 	SHMEM_I(inode)->flags &= flags;
@@ -1884,11 +1883,11 @@
 close_file:
 	put_filp(file);
 put_dentry:
-	dput (dentry);
+	dput(dentry);
 put_memory:
 	if (flags & VM_ACCOUNT)
 		vm_unacct_memory(VM_ACCT(size));
-	return ERR_PTR(error);	
+	return ERR_PTR(error);
 }
 
 /*
@@ -1900,13 +1899,13 @@
 {
 	struct file *file;
 	loff_t size = vma->vm_end - vma->vm_start;
-	
+
 	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
 	if (vma->vm_file)
-		fput (vma->vm_file);
+		fput(vma->vm_file);
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;

