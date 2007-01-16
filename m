Return-Path: <linux-kernel-owner+w=401wt.eu-S1751459AbXAPJlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAPJlL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAPJlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:41:11 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44229 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXAPJlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:41:08 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Subject: [PATCH] Mark struct super_operations const
Date: Tue, 16 Jan 2007 04:40:54 -0500
Message-Id: <11689404544064-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.5.0.rc1.g696b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is inspired by Arjan's "Patch series to mark struct
file_operations and struct inode_operations const".

Compile tested with gcc & sparse.

Signed-off-by: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
---
 fs/9p/vfs_super.c             |    4 ++--
 fs/adfs/super.c               |    2 +-
 fs/affs/super.c               |    2 +-
 fs/afs/super.c                |    2 +-
 fs/autofs/inode.c             |    2 +-
 fs/autofs4/inode.c            |    2 +-
 fs/bfs/inode.c                |    2 +-
 fs/binfmt_misc.c              |    2 +-
 fs/block_dev.c                |    2 +-
 fs/cifs/cifsfs.c              |    4 ++--
 fs/cifs/cifsfs.h              |    2 +-
 fs/coda/inode.c               |    2 +-
 fs/configfs/mount.c           |    2 +-
 fs/cramfs/inode.c             |    4 ++--
 fs/devpts/inode.c             |    2 +-
 fs/ecryptfs/ecryptfs_kernel.h |    2 +-
 fs/ecryptfs/super.c           |    2 +-
 fs/efs/super.c                |    2 +-
 fs/ext2/super.c               |    2 +-
 fs/ext3/super.c               |    2 +-
 fs/ext4/super.c               |    2 +-
 fs/fat/inode.c                |    2 +-
 fs/freevxfs/vxfs_super.c      |    2 +-
 fs/fuse/inode.c               |    2 +-
 fs/gfs2/ops_super.c           |    2 +-
 fs/gfs2/ops_super.h           |    2 +-
 fs/hfs/super.c                |    2 +-
 fs/hfsplus/super.c            |    2 +-
 fs/hostfs/hostfs_kern.c       |    2 +-
 fs/hpfs/super.c               |    2 +-
 fs/hppfs/hppfs_kern.c         |    4 ++--
 fs/hugetlbfs/inode.c          |    4 ++--
 fs/inode.c                    |    6 +++---
 fs/isofs/inode.c              |    2 +-
 fs/jffs/inode-v23.c           |    4 ++--
 fs/jffs2/super.c              |    2 +-
 fs/jfs/super.c                |    4 ++--
 fs/libfs.c                    |    4 ++--
 fs/minix/inode.c              |    2 +-
 fs/ncpfs/inode.c              |    2 +-
 fs/nfs/super.c                |    4 ++--
 fs/ntfs/super.c               |    2 +-
 fs/ocfs2/dlm/dlmfs.c          |    4 ++--
 fs/ocfs2/super.c              |    2 +-
 fs/openpromfs/inode.c         |    2 +-
 fs/proc/inode.c               |    2 +-
 fs/qnx4/inode.c               |    4 ++--
 fs/ramfs/inode.c              |    4 ++--
 fs/reiserfs/super.c           |    2 +-
 fs/romfs/inode.c              |    4 ++--
 fs/smbfs/inode.c              |    2 +-
 fs/super.c                    |    2 +-
 fs/sysfs/mount.c              |    2 +-
 fs/sysv/inode.c               |    2 +-
 fs/sysv/sysv.h                |    2 +-
 fs/udf/super.c                |    2 +-
 fs/ufs/super.c                |    4 ++--
 include/linux/fs.h            |    4 ++--
 58 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 63320d4..4bafd76 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -45,7 +45,7 @@
 #include "fid.h"
 
 static void v9fs_clear_inode(struct inode *);
-static struct super_operations v9fs_super_ops;
+const static struct super_operations v9fs_super_ops;
 
 /**
  * v9fs_clear_inode - release an inode
@@ -263,7 +263,7 @@ v9fs_umount_begin(struct vfsmount *vfsmnt, int flags)
 		v9fs_session_cancel(v9ses);
 }
 
-static struct super_operations v9fs_super_ops = {
+const static struct super_operations v9fs_super_ops = {
 	.statfs = simple_statfs,
 	.clear_inode = v9fs_clear_inode,
 	.show_options = v9fs_show_options,
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 5023351..1b7200f 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -254,7 +254,7 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(adfs_inode_cachep);
 }
 
-static struct super_operations adfs_sops = {
+const static struct super_operations adfs_sops = {
 	.alloc_inode	= adfs_alloc_inode,
 	.destroy_inode	= adfs_destroy_inode,
 	.write_inode	= adfs_write_inode,
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 3de93e7..ab3b912 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -112,7 +112,7 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(affs_inode_cachep);
 }
 
-static struct super_operations affs_sops = {
+const static struct super_operations affs_sops = {
 	.alloc_inode	= affs_alloc_inode,
 	.destroy_inode	= affs_destroy_inode,
 	.read_inode	= affs_read_inode,
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 18d9b77..70f8603 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -56,7 +56,7 @@ struct file_system_type afs_fs_type = {
 	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 
-static struct super_operations afs_super_ops = {
+const static struct super_operations afs_super_ops = {
 	.statfs		= simple_statfs,
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= generic_delete_inode,
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f968d13..475632e 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -52,7 +52,7 @@ out_kill_sb:
 
 static void autofs_read_inode(struct inode *inode);
 
-static struct super_operations autofs_sops = {
+const static struct super_operations autofs_sops = {
 	.read_inode	= autofs_read_inode,
 	.statfs		= simple_statfs,
 };
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index e8f6c5a..98df9a9 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -196,7 +196,7 @@ static int autofs4_show_options(struct seq_file *m, struct vfsmount *mnt)
 	return 0;
 }
 
-static struct super_operations autofs4_sops = {
+const static struct super_operations autofs4_sops = {
 	.statfs		= simple_statfs,
 	.show_options	= autofs4_show_options,
 };
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 134c999..7f6ec89 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -270,7 +270,7 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(bfs_inode_cachep);
 }
 
-static struct super_operations bfs_sops = {
+const static struct super_operations bfs_sops = {
 	.alloc_inode	= bfs_alloc_inode,
 	.destroy_inode	= bfs_destroy_inode,
 	.read_inode	= bfs_read_inode,
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c2e0825..98ffea3 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -719,7 +719,7 @@ static const struct file_operations bm_status_operations = {
 
 /* Superblock handling */
 
-static struct super_operations s_ops = {
+const static struct super_operations s_ops = {
 	.statfs		= simple_statfs,
 	.clear_inode	= bm_clear_inode,
 };
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8b18e43..096dd8e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -440,7 +440,7 @@ static void bdev_clear_inode(struct inode *inode)
 	spin_unlock(&bdev_lock);
 }
 
-static struct super_operations bdev_sops = {
+const static struct super_operations bdev_sops = {
 	.statfs = simple_statfs,
 	.alloc_inode = bdev_alloc_inode,
 	.destroy_inode = bdev_destroy_inode,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10c9029..cfffe52 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -64,7 +64,7 @@ extern struct task_struct * oplockThread; /* remove sparse warning */
 struct task_struct * oplockThread = NULL;
 extern struct task_struct * dnotifyThread; /* remove sparse warning */
 struct task_struct * dnotifyThread = NULL;
-static struct super_operations cifs_super_ops; 
+const static struct super_operations cifs_super_ops; 
 unsigned int CIFSMaxBufSize = CIFS_MAX_MSGSIZE;
 module_param(CIFSMaxBufSize, int, 0);
 MODULE_PARM_DESC(CIFSMaxBufSize,"Network buffer size (not including header). Default: 16384 Range: 8192 to 130048");
@@ -453,7 +453,7 @@ static int cifs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations cifs_super_ops = {
+const static struct super_operations cifs_super_ops = {
 	.read_inode = cifs_read_inode,
 	.put_super = cifs_put_super,
 	.statfs = cifs_statfs,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index a243f77..6244f35 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -36,7 +36,7 @@ extern const struct address_space_operations cifs_addr_ops;
 extern const struct address_space_operations cifs_addr_ops_smallbuf;
 
 /* Functions related to super block operations */
-/* extern struct super_operations cifs_super_ops;*/
+/* extern const struct super_operations cifs_super_ops;*/
 extern void cifs_read_inode(struct inode *);
 extern void cifs_delete_inode(struct inode *);
 /* extern void cifs_write_inode(struct inode *); *//* BB not needed yet */
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 01395de..f5a8ec9 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -90,7 +90,7 @@ static int coda_remount(struct super_block *sb, int *flags, char *data)
 }
 
 /* exported operations */
-static struct super_operations coda_super_operations =
+const static struct super_operations coda_super_operations =
 {
 	.alloc_inode	= coda_alloc_inode,
 	.destroy_inode	= coda_destroy_inode,
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index ed67852..f52ef91 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -41,7 +41,7 @@ struct super_block * configfs_sb = NULL;
 struct kmem_cache *configfs_dir_cachep;
 static int configfs_mnt_count = 0;
 
-static struct super_operations configfs_ops = {
+const static struct super_operations configfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 };
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 6db03fb..554d063 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -27,7 +27,7 @@
 
 #include <asm/uaccess.h>
 
-static struct super_operations cramfs_ops;
+const static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
 static const struct file_operations cramfs_directory_operations;
 static const struct address_space_operations cramfs_aops;
@@ -522,7 +522,7 @@ static struct inode_operations cramfs_dir_inode_operations = {
 	.lookup		= cramfs_lookup,
 };
 
-static struct super_operations cramfs_ops = {
+const static struct super_operations cramfs_ops = {
 	.put_super	= cramfs_put_super,
 	.remount_fs	= cramfs_remount,
 	.statfs		= cramfs_statfs,
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 5f7b5a6..907b2b3 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -91,7 +91,7 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations devpts_sops = {
+const static struct super_operations devpts_sops = {
 	.statfs		= simple_statfs,
 	.remount_fs	= devpts_remount,
 };
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index afb64bd..62b5d36 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -388,7 +388,7 @@ extern const struct file_operations ecryptfs_dir_fops;
 extern struct inode_operations ecryptfs_main_iops;
 extern struct inode_operations ecryptfs_dir_iops;
 extern struct inode_operations ecryptfs_symlink_iops;
-extern struct super_operations ecryptfs_sops;
+extern const struct super_operations ecryptfs_sops;
 extern struct dentry_operations ecryptfs_dops;
 extern struct address_space_operations ecryptfs_aops;
 extern int ecryptfs_verbosity;
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index eaa5daa..7b3f0cc 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -168,7 +168,7 @@ out:
 	return rc;
 }
 
-struct super_operations ecryptfs_sops = {
+const struct super_operations ecryptfs_sops = {
 	.alloc_inode = ecryptfs_alloc_inode,
 	.destroy_inode = ecryptfs_destroy_inode,
 	.drop_inode = generic_delete_inode,
diff --git a/fs/efs/super.c b/fs/efs/super.c
index dfebf21..c9d159b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -105,7 +105,7 @@ static int efs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations efs_superblock_operations = {
+const static struct super_operations efs_superblock_operations = {
 	.alloc_inode	= efs_alloc_inode,
 	.destroy_inode	= efs_destroy_inode,
 	.read_inode	= efs_read_inode,
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 6347c2d..234951a 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -231,7 +231,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data, siz
 static ssize_t ext2_quota_write(struct super_block *sb, int type, const char *data, size_t len, loff_t off);
 #endif
 
-static struct super_operations ext2_sops = {
+const static struct super_operations ext2_sops = {
 	.alloc_inode	= ext2_alloc_inode,
 	.destroy_inode	= ext2_destroy_inode,
 	.read_inode	= ext2_read_inode,
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index b348867..c51e1cc 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -639,7 +639,7 @@ static struct quotactl_ops ext3_qctl_operations = {
 };
 #endif
 
-static struct super_operations ext3_sops = {
+const static struct super_operations ext3_sops = {
 	.alloc_inode	= ext3_alloc_inode,
 	.destroy_inode	= ext3_destroy_inode,
 	.read_inode	= ext3_read_inode,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 486a641..d46ad2c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -690,7 +690,7 @@ static struct quotactl_ops ext4_qctl_operations = {
 };
 #endif
 
-static struct super_operations ext4_sops = {
+const static struct super_operations ext4_sops = {
 	.alloc_inode	= ext4_alloc_inode,
 	.destroy_inode	= ext4_destroy_inode,
 	.read_inode	= ext4_read_inode,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a9e4688..ee0c1f3 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -618,7 +618,7 @@ int fat_sync_inode(struct inode *inode)
 EXPORT_SYMBOL_GPL(fat_sync_inode);
 
 static int fat_show_options(struct seq_file *m, struct vfsmount *mnt);
-static struct super_operations fat_sops = {
+const static struct super_operations fat_sops = {
 	.alloc_inode	= fat_alloc_inode,
 	.destroy_inode	= fat_destroy_inode,
 	.write_inode	= fat_write_inode,
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index ac28b08..fb98f01 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -59,7 +59,7 @@ static void		vxfs_put_super(struct super_block *);
 static int		vxfs_statfs(struct dentry *, struct kstatfs *);
 static int		vxfs_remount(struct super_block *, int *, char *);
 
-static struct super_operations vxfs_super_ops = {
+const static struct super_operations vxfs_super_ops = {
 	.read_inode =		vxfs_read_inode,
 	.clear_inode =		vxfs_clear_inode,
 	.put_super =		vxfs_put_super,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 12450d2..fd6ba45 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -446,7 +446,7 @@ static struct inode *get_root_inode(struct super_block *sb, unsigned mode)
 	return fuse_iget(sb, 1, 0, &attr);
 }
 
-static struct super_operations fuse_super_operations = {
+const static struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
 	.destroy_inode  = fuse_destroy_inode,
 	.read_inode	= fuse_read_inode,
diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
index 7685b46..8ebf1c0 100644
--- a/fs/gfs2/ops_super.c
+++ b/fs/gfs2/ops_super.c
@@ -461,7 +461,7 @@ static void gfs2_destroy_inode(struct inode *inode)
 	kmem_cache_free(gfs2_inode_cachep, inode);
 }
 
-struct super_operations gfs2_super_ops = {
+const struct super_operations gfs2_super_ops = {
 	.alloc_inode		= gfs2_alloc_inode,
 	.destroy_inode		= gfs2_destroy_inode,
 	.write_inode		= gfs2_write_inode,
diff --git a/fs/gfs2/ops_super.h b/fs/gfs2/ops_super.h
index 9de73f0..442a274 100644
--- a/fs/gfs2/ops_super.h
+++ b/fs/gfs2/ops_super.h
@@ -12,6 +12,6 @@
 
 #include <linux/fs.h>
 
-extern struct super_operations gfs2_super_ops;
+extern const struct super_operations gfs2_super_ops;
 
 #endif /* __OPS_SUPER_DOT_H__ */
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a369879..669b982 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -154,7 +154,7 @@ static void hfs_destroy_inode(struct inode *inode)
 	kmem_cache_free(hfs_inode_cachep, HFS_I(inode));
 }
 
-static struct super_operations hfs_super_operations = {
+const static struct super_operations hfs_super_operations = {
 	.alloc_inode	= hfs_alloc_inode,
 	.destroy_inode	= hfs_destroy_inode,
 	.write_inode	= hfs_write_inode,
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 0f513c6..dd51a75 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -260,7 +260,7 @@ static int hfsplus_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations hfsplus_sops = {
+const static struct super_operations hfsplus_sops = {
 	.alloc_inode	= hfsplus_alloc_inode,
 	.destroy_inode	= hfsplus_destroy_inode,
 	.read_inode	= hfsplus_read_inode,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1e6fc37..ff4e4f3 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -309,7 +309,7 @@ static void hostfs_read_inode(struct inode *inode)
 	read_inode(inode);
 }
 
-static struct super_operations hostfs_sbops = {
+const static struct super_operations hostfs_sbops = {
 	.alloc_inode	= hostfs_alloc_inode,
 	.drop_inode	= generic_delete_inode,
 	.delete_inode   = hostfs_delete_inode,
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index d4abc1a..ccf85ed 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -426,7 +426,7 @@ static int hpfs_remount_fs(struct super_block *s, int *flags, char *data)
 
 /* Super operations */
 
-static struct super_operations hpfs_sops =
+const static struct super_operations hpfs_sops =
 {
 	.alloc_inode	= hpfs_alloc_inode,
 	.destroy_inode	= hpfs_destroy_inode,
diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index afd340a..b27f0eb 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -43,7 +43,7 @@ static inline struct hppfs_inode_info *HPPFS_I(struct inode *inode)
 
 #define HPPFS_SUPER_MAGIC 0xb00000ee
 
-static struct super_operations hppfs_sbops;
+const static struct super_operations hppfs_sbops;
 
 static int is_pid(struct dentry *dentry)
 {
@@ -649,7 +649,7 @@ static void hppfs_destroy_inode(struct inode *inode)
 	kfree(HPPFS_I(inode));
 }
 
-static struct super_operations hppfs_sbops = {
+const static struct super_operations hppfs_sbops = {
 	.alloc_inode	= hppfs_alloc_inode,
 	.destroy_inode	= hppfs_destroy_inode,
 	.read_inode	= hppfs_read_inode,
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4f4cd13..cfecc53 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -33,7 +33,7 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
 
-static struct super_operations hugetlbfs_ops;
+const static struct super_operations hugetlbfs_ops;
 static const struct address_space_operations hugetlbfs_aops;
 const struct file_operations hugetlbfs_file_operations;
 static struct inode_operations hugetlbfs_dir_inode_operations;
@@ -577,7 +577,7 @@ static struct inode_operations hugetlbfs_inode_operations = {
 	.setattr	= hugetlbfs_setattr,
 };
 
-static struct super_operations hugetlbfs_ops = {
+const static struct super_operations hugetlbfs_ops = {
 	.alloc_inode    = hugetlbfs_alloc_inode,
 	.destroy_inode  = hugetlbfs_destroy_inode,
 	.statfs		= hugetlbfs_statfs,
diff --git a/fs/inode.c b/fs/inode.c
index bf21dc6..7d5f914 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -999,7 +999,7 @@ EXPORT_SYMBOL(remove_inode_hash);
  */
 void generic_delete_inode(struct inode *inode)
 {
-	struct super_operations *op = inode->i_sb->s_op;
+	const struct super_operations *op = inode->i_sb->s_op;
 
 	list_del_init(&inode->i_list);
 	list_del_init(&inode->i_sb_list);
@@ -1092,7 +1092,7 @@ EXPORT_SYMBOL_GPL(generic_drop_inode);
  */
 static inline void iput_final(struct inode *inode)
 {
-	struct super_operations *op = inode->i_sb->s_op;
+	const struct super_operations *op = inode->i_sb->s_op;
 	void (*drop)(struct inode *) = generic_drop_inode;
 
 	if (op && op->drop_inode)
@@ -1112,7 +1112,7 @@ static inline void iput_final(struct inode *inode)
 void iput(struct inode *inode)
 {
 	if (inode) {
-		struct super_operations *op = inode->i_sb->s_op;
+		const struct super_operations *op = inode->i_sb->s_op;
 
 		BUG_ON(inode->i_state == I_CLEAR);
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ea55b6c..36974f9 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -106,7 +106,7 @@ static int isofs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations isofs_sops = {
+const static struct super_operations isofs_sops = {
 	.alloc_inode	= isofs_alloc_inode,
 	.destroy_inode	= isofs_destroy_inode,
 	.read_inode	= isofs_read_inode,
diff --git a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
index 43baa1a..a4d3923 100644
--- a/fs/jffs/inode-v23.c
+++ b/fs/jffs/inode-v23.c
@@ -54,7 +54,7 @@
 
 static int jffs_remove(struct inode *dir, struct dentry *dentry, int type);
 
-static struct super_operations jffs_ops;
+const static struct super_operations jffs_ops;
 static const struct file_operations jffs_file_operations;
 static struct inode_operations jffs_file_inode_operations;
 static const struct file_operations jffs_dir_operations;
@@ -1774,7 +1774,7 @@ static int jffs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations jffs_ops =
+const static struct super_operations jffs_ops =
 {
 	.read_inode	= jffs_read_inode,
 	.delete_inode 	= jffs_delete_inode,
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 7deb782..9a55535 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -65,7 +65,7 @@ static int jffs2_sync_fs(struct super_block *sb, int wait)
 	return 0;
 }
 
-static struct super_operations jffs2_super_operations =
+const static struct super_operations jffs2_super_operations =
 {
 	.alloc_inode =	jffs2_alloc_inode,
 	.destroy_inode =jffs2_destroy_inode,
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 846ac8f..3b6ae50 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -46,7 +46,7 @@ MODULE_LICENSE("GPL");
 
 static struct kmem_cache * jfs_inode_cachep;
 
-static struct super_operations jfs_super_operations;
+const static struct super_operations jfs_super_operations;
 static struct export_operations jfs_export_operations;
 static struct file_system_type jfs_fs_type;
 
@@ -716,7 +716,7 @@ out:
 
 #endif
 
-static struct super_operations jfs_super_operations = {
+const static struct super_operations jfs_super_operations = {
 	.alloc_inode	= jfs_alloc_inode,
 	.destroy_inode	= jfs_destroy_inode,
 	.read_inode	= jfs_read_inode,
diff --git a/fs/libfs.c b/fs/libfs.c
index 503898d..381e047 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -195,11 +195,11 @@ struct inode_operations simple_dir_inode_operations = {
  * will never be mountable)
  */
 int get_sb_pseudo(struct file_system_type *fs_type, char *name,
-	struct super_operations *ops, unsigned long magic,
+	const struct super_operations *ops, unsigned long magic,
 	struct vfsmount *mnt)
 {
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
-	static struct super_operations default_ops = {.statfs = simple_statfs};
+	const static struct super_operations default_ops = {.statfs = simple_statfs};
 	struct dentry *dentry;
 	struct inode *root;
 	struct qstr d_name = {.name = name, .len = strlen(name)};
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 629e09b..6a378bd 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -93,7 +93,7 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(minix_inode_cachep);
 }
 
-static struct super_operations minix_sops = {
+const static struct super_operations minix_sops = {
 	.alloc_inode	= minix_alloc_inode,
 	.destroy_inode	= minix_destroy_inode,
 	.read_inode	= minix_read_inode,
diff --git a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
index 67a90bf..4599de7 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -90,7 +90,7 @@ static int ncp_remount(struct super_block *sb, int *flags, char* data)
 	return 0;
 }
 
-static struct super_operations ncp_sops =
+const static struct super_operations ncp_sops =
 {
 	.alloc_inode	= ncp_alloc_inode,
 	.destroy_inode	= ncp_destroy_inode,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 28108c8..ab36e51 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -81,7 +81,7 @@ struct file_system_type nfs_xdev_fs_type = {
 	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
-static struct super_operations nfs_sops = {
+const static struct super_operations nfs_sops = {
 	.alloc_inode	= nfs_alloc_inode,
 	.destroy_inode	= nfs_destroy_inode,
 	.write_inode	= nfs_write_inode,
@@ -125,7 +125,7 @@ struct file_system_type nfs4_referral_fs_type = {
 	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
-static struct super_operations nfs4_sops = {
+const static struct super_operations nfs4_sops = {
 	.alloc_inode	= nfs_alloc_inode,
 	.destroy_inode	= nfs_destroy_inode,
 	.write_inode	= nfs_write_inode,
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 03a391a..ee8cd77 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2699,7 +2699,7 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
 /**
  * The complete super operations.
  */
-static struct super_operations ntfs_sops = {
+const static struct super_operations ntfs_sops = {
 	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
 	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
 	.put_inode	= ntfs_put_inode,	  /* VFS: Called just before
diff --git a/fs/ocfs2/dlm/dlmfs.c b/fs/ocfs2/dlm/dlmfs.c
index b7f0ba9..5de6c01 100644
--- a/fs/ocfs2/dlm/dlmfs.c
+++ b/fs/ocfs2/dlm/dlmfs.c
@@ -61,7 +61,7 @@
 #define MLOG_MASK_PREFIX ML_DLMFS
 #include "cluster/masklog.h"
 
-static struct super_operations dlmfs_ops;
+const static struct super_operations dlmfs_ops;
 static struct file_operations dlmfs_file_operations;
 static struct inode_operations dlmfs_dir_inode_operations;
 static struct inode_operations dlmfs_root_inode_operations;
@@ -560,7 +560,7 @@ static struct inode_operations dlmfs_root_inode_operations = {
 	.rmdir		= simple_rmdir,
 };
 
-static struct super_operations dlmfs_ops = {
+const static struct super_operations dlmfs_ops = {
 	.statfs		= simple_statfs,
 	.alloc_inode	= dlmfs_alloc_inode,
 	.destroy_inode	= dlmfs_destroy_inode,
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6e300a8..b4bce20 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -116,7 +116,7 @@ static void ocfs2_destroy_inode(struct inode *inode);
 
 static unsigned long long ocfs2_max_file_offset(unsigned int blockshift);
 
-static struct super_operations ocfs2_sops = {
+const static struct super_operations ocfs2_sops = {
 	.statfs		= ocfs2_statfs,
 	.alloc_inode	= ocfs2_alloc_inode,
 	.destroy_inode	= ocfs2_destroy_inode,
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 99c0bc3..e1a9202 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -364,7 +364,7 @@ static int openprom_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations openprom_sops = { 
+const static struct super_operations openprom_sops = { 
 	.alloc_inode	= openprom_alloc_inode,
 	.destroy_inode	= openprom_destroy_inode,
 	.read_inode	= openprom_read_inode,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index e26945b..d6124a7 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -132,7 +132,7 @@ static int proc_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations proc_sops = { 
+const static struct super_operations proc_sops = { 
 	.alloc_inode	= proc_alloc_inode,
 	.destroy_inode	= proc_destroy_inode,
 	.read_inode	= proc_read_inode,
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index c047dc6..9aa3697 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -30,7 +30,7 @@
 #define QNX4_VERSION  4
 #define QNX4_BMNAME   ".bitmap"
 
-static struct super_operations qnx4_sops;
+const static struct super_operations qnx4_sops;
 
 #ifdef CONFIG_QNX4FS_RW
 
@@ -129,7 +129,7 @@ static void qnx4_read_inode(struct inode *);
 static int qnx4_remount(struct super_block *sb, int *flags, char *data);
 static int qnx4_statfs(struct dentry *, struct kstatfs *);
 
-static struct super_operations qnx4_sops =
+const static struct super_operations qnx4_sops =
 {
 	.alloc_inode	= qnx4_alloc_inode,
 	.destroy_inode	= qnx4_destroy_inode,
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 2faf4cd..fb8eda5 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -40,7 +40,7 @@
 /* some random number */
 #define RAMFS_MAGIC	0x858458f6
 
-static struct super_operations ramfs_ops;
+const static struct super_operations ramfs_ops;
 static struct inode_operations ramfs_dir_inode_operations;
 
 static struct backing_dev_info ramfs_backing_dev_info = {
@@ -155,7 +155,7 @@ static struct inode_operations ramfs_dir_inode_operations = {
 	.rename		= simple_rename,
 };
 
-static struct super_operations ramfs_ops = {
+const static struct super_operations ramfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 };
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58ad455..0f18dac 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -593,7 +593,7 @@ static ssize_t reiserfs_quota_read(struct super_block *, int, char *, size_t,
 				   loff_t);
 #endif
 
-static struct super_operations reiserfs_sops = {
+const static struct super_operations reiserfs_sops = {
 	.alloc_inode = reiserfs_alloc_inode,
 	.destroy_inode = reiserfs_destroy_inode,
 	.write_inode = reiserfs_write_inode,
diff --git a/fs/romfs/inode.c b/fs/romfs/inode.c
index d3e243a..cfd981b 100644
--- a/fs/romfs/inode.c
+++ b/fs/romfs/inode.c
@@ -110,7 +110,7 @@ romfs_checksum(void *data, int size)
 	return sum;
 }
 
-static struct super_operations romfs_ops;
+const static struct super_operations romfs_ops;
 
 static int romfs_fill_super(struct super_block *s, void *data, int silent)
 {
@@ -598,7 +598,7 @@ static int romfs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations romfs_ops = {
+const static struct super_operations romfs_ops = {
 	.alloc_inode	= romfs_alloc_inode,
 	.destroy_inode	= romfs_destroy_inode,
 	.read_inode	= romfs_read_inode,
diff --git a/fs/smbfs/inode.c b/fs/smbfs/inode.c
index 84dfe3f..199fdfe 100644
--- a/fs/smbfs/inode.c
+++ b/fs/smbfs/inode.c
@@ -98,7 +98,7 @@ static int smb_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static struct super_operations smb_sops =
+const static struct super_operations smb_sops =
 {
 	.alloc_inode	= smb_alloc_inode,
 	.destroy_inode	= smb_destroy_inode,
diff --git a/fs/super.c b/fs/super.c
index 3e7458c..60b1e50 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -285,7 +285,7 @@ int fsync_super(struct super_block *sb)
  */
 void generic_shutdown_super(struct super_block *sb)
 {
-	struct super_operations *sop = sb->s_op;
+	const struct super_operations *sop = sb->s_op;
 
 	if (sb->s_root) {
 		shrink_dcache_for_umount(sb);
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index e503f85..e015c03 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -18,7 +18,7 @@ struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
 struct kmem_cache *sysfs_dir_cachep;
 
-static struct super_operations sysfs_ops = {
+const static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 };
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index ead9864..14e9f08 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -327,7 +327,7 @@ static void init_once(void *p, struct kmem_cache *cachep, unsigned long flags)
 		inode_init_once(&si->vfs_inode);
 }
 
-struct super_operations sysv_sops = {
+const struct super_operations sysv_sops = {
 	.alloc_inode	= sysv_alloc_inode,
 	.destroy_inode	= sysv_destroy_inode,
 	.read_inode	= sysv_read_inode,
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index dcb18b2..d3e283c 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -165,7 +165,7 @@ extern struct inode_operations sysv_fast_symlink_inode_operations;
 extern const struct file_operations sysv_file_operations;
 extern const struct file_operations sysv_dir_operations;
 extern const struct address_space_operations sysv_aops;
-extern struct super_operations sysv_sops;
+extern const struct super_operations sysv_sops;
 extern struct dentry_operations sysv_dentry_operations;
 
 
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1dbc295..c555a2e 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -160,7 +160,7 @@ static void destroy_inodecache(void)
 }
 
 /* Superblock operations */
-static struct super_operations udf_sb_ops = {
+const static struct super_operations udf_sb_ops = {
 	.alloc_inode		= udf_alloc_inode,
 	.destroy_inode		= udf_destroy_inode,
 	.write_inode		= udf_write_inode,
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 8a8e938..3d021e7 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -203,7 +203,7 @@ static void ufs_print_cylinder_stuff(struct super_block *sb,
 #  define ufs_print_cylinder_stuff(sb, cg) /**/
 #endif /* CONFIG_UFS_DEBUG */
 
-static struct super_operations ufs_super_ops;
+const static struct super_operations ufs_super_ops;
 
 static char error_buf[1024];
 
@@ -1252,7 +1252,7 @@ static ssize_t ufs_quota_read(struct super_block *, int, char *,size_t, loff_t);
 static ssize_t ufs_quota_write(struct super_block *, int, const char *, size_t, loff_t);
 #endif
 
-static struct super_operations ufs_super_ops = {
+const static struct super_operations ufs_super_ops = {
 	.alloc_inode	= ufs_alloc_inode,
 	.destroy_inode	= ufs_destroy_inode,
 	.read_inode	= ufs_read_inode,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1410e53..6294952 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -906,7 +906,7 @@ struct super_block {
 	unsigned char		s_dirt;
 	unsigned long long	s_maxbytes;	/* Max file size */
 	struct file_system_type	*s_type;
-	struct super_operations	*s_op;
+	const struct super_operations	*s_op;
 	struct dquot_operations	*dq_op;
  	struct quotactl_ops	*s_qcop;
 	struct export_operations *s_export_op;
@@ -1382,7 +1382,7 @@ struct super_block *sget(struct file_system_type *type,
 			int (*set)(struct super_block *,void *),
 			void *data);
 extern int get_sb_pseudo(struct file_system_type *, char *,
-	struct super_operations *ops, unsigned long,
+	const struct super_operations *ops, unsigned long,
 	struct vfsmount *mnt);
 extern int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb);
 int __put_super(struct super_block *sb);
-- 
1.5.0.rc1.g696b

