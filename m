Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWBVUWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWBVUWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWBVUWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422663AbWBVUWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:12 -0500
Date: Wed, 22 Feb 2006 20:21:45 GMT
Message-Id: <200602222021.k1MKLjU5028345@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-fsdevel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 2/5] NFS: Apply mount root dentry override to filesystems
In-Reply-To: <dhowells1140639702@warthog.cambridge.redhat.com>
References: <dhowells1140639702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch changes all the filesystems in the kernel to deal with the
extra argument to get_sb(). In every case the extra argument is simply ignored,
thus causing the dentry returned in sb->s_root to be used as the root of the
mountpoint.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 getsb-change-fses-2616rc4.diff
 arch/ia64/kernel/perfmon.c                |    3 ++-
 arch/powerpc/platforms/cell/spufs/inode.c |    2 +-
 drivers/infiniband/core/uverbs_main.c     |    3 ++-
 drivers/isdn/capi/capifs.c                |    2 +-
 drivers/misc/ibmasm/ibmasmfs.c            |    3 ++-
 drivers/oprofile/oprofilefs.c             |    2 +-
 drivers/usb/core/inode.c                  |    2 +-
 drivers/usb/gadget/inode.c                |    2 +-
 fs/9p/vfs_super.c                         |    3 ++-
 fs/adfs/super.c                           |    2 +-
 fs/affs/super.c                           |    2 +-
 fs/afs/super.c                            |    5 +++--
 fs/autofs/init.c                          |    2 +-
 fs/autofs4/init.c                         |    2 +-
 fs/befs/linuxvfs.c                        |    2 +-
 fs/bfs/inode.c                            |    2 +-
 fs/binfmt_misc.c                          |    2 +-
 fs/block_dev.c                            |    2 +-
 fs/cifs/cifsfs.c                          |    2 +-
 fs/coda/inode.c                           |    2 +-
 fs/configfs/mount.c                       |    2 +-
 fs/cramfs/inode.c                         |    2 +-
 fs/debugfs/inode.c                        |    2 +-
 fs/devfs/base.c                           |    2 +-
 fs/devpts/inode.c                         |    2 +-
 fs/efs/super.c                            |    2 +-
 fs/eventpoll.c                            |    4 ++--
 fs/ext2/super.c                           |    2 +-
 fs/ext3/super.c                           |    2 +-
 fs/freevxfs/vxfs_super.c                  |    2 +-
 fs/fuse/inode.c                           |    2 +-
 fs/hfs/super.c                            |    3 ++-
 fs/hfsplus/super.c                        |    3 ++-
 fs/hpfs/super.c                           |    2 +-
 fs/hugetlbfs/inode.c                      |    2 +-
 fs/inotify.c                              |    2 +-
 fs/isofs/inode.c                          |    2 +-
 fs/jffs/inode-v23.c                       |    2 +-
 fs/jffs2/super.c                          |    2 +-
 fs/jfs/super.c                            |    2 +-
 fs/minix/inode.c                          |    2 +-
 fs/msdos/namei.c                          |    2 +-
 fs/ncpfs/inode.c                          |    2 +-
 fs/nfs/inode.c                            |    4 ++--
 fs/nfsd/nfsctl.c                          |    2 +-
 fs/ntfs/super.c                           |    2 +-
 fs/ocfs2/dlm/dlmfs.c                      |    2 +-
 fs/ocfs2/super.c                          |    3 ++-
 fs/openpromfs/inode.c                     |    2 +-
 fs/pipe.c                                 |    2 +-
 fs/proc/root.c                            |    2 +-
 fs/qnx4/inode.c                           |    2 +-
 fs/ramfs/inode.c                          |    4 ++--
 fs/relayfs/inode.c                        |    2 +-
 fs/romfs/inode.c                          |    2 +-
 fs/smbfs/inode.c                          |    2 +-
 fs/sysfs/mount.c                          |    2 +-
 fs/sysv/super.c                           |    4 ++--
 fs/udf/super.c                            |    2 +-
 fs/ufs/super.c                            |    2 +-
 fs/vfat/namei.c                           |    2 +-
 fs/xfs/linux-2.6/xfs_super.c              |    3 ++-
 include/linux/ramfs.h                     |    2 +-
 ipc/mqueue.c                              |    2 +-
 kernel/cpuset.c                           |    2 +-
 kernel/futex.c                            |    2 +-
 mm/shmem.c                                |    2 +-
 net/socket.c                              |    2 +-
 net/sunrpc/rpc_pipe.c                     |    2 +-
 security/selinux/selinuxfs.c              |    3 ++-
 70 files changed, 85 insertions(+), 75 deletions(-)

diff -uNrp linux-2.6.16-rc4/arch/ia64/kernel/perfmon.c linux-2.6.16-rc4-getsb/arch/ia64/kernel/perfmon.c
--- linux-2.6.16-rc4/arch/ia64/kernel/perfmon.c	2006-02-22 17:00:19.000000000 +0000
+++ linux-2.6.16-rc4-getsb/arch/ia64/kernel/perfmon.c	2006-02-22 17:08:45.000000000 +0000
@@ -596,7 +596,8 @@ pfm_get_unmapped_area(struct file *file,
 
 
 static struct super_block *
-pfmfs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name, void *data)
+pfmfs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name, void *data,
+	     struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "pfm:", NULL, PFMFS_MAGIC);
 }
diff -uNrp linux-2.6.16-rc4/arch/powerpc/platforms/cell/spufs/inode.c linux-2.6.16-rc4-getsb/arch/powerpc/platforms/cell/spufs/inode.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/cell/spufs/inode.c	2006-02-22 17:00:22.000000000 +0000
+++ linux-2.6.16-rc4-getsb/arch/powerpc/platforms/cell/spufs/inode.c	2006-02-22 17:10:18.000000000 +0000
@@ -430,7 +430,7 @@ spufs_fill_super(struct super_block *sb,
 
 static struct super_block *
 spufs_get_sb(struct file_system_type *fstype, int flags,
-		const char *name, void *data)
+		const char *name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fstype, flags, data, spufs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/drivers/infiniband/core/uverbs_main.c linux-2.6.16-rc4-getsb/drivers/infiniband/core/uverbs_main.c
--- linux-2.6.16-rc4/drivers/infiniband/core/uverbs_main.c	2006-02-22 17:00:27.000000000 +0000
+++ linux-2.6.16-rc4-getsb/drivers/infiniband/core/uverbs_main.c	2006-02-22 17:16:59.000000000 +0000
@@ -819,7 +819,8 @@ static void ib_uverbs_remove_one(struct 
 }
 
 static struct super_block *uverbs_event_get_sb(struct file_system_type *fs_type, int flags,
-					       const char *dev_name, void *data)
+					       const char *dev_name, void *data,
+					       struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "infinibandevent:", NULL,
 			     INFINIBANDEVENTFS_MAGIC);
diff -uNrp linux-2.6.16-rc4/drivers/isdn/capi/capifs.c linux-2.6.16-rc4-getsb/drivers/isdn/capi/capifs.c
--- linux-2.6.16-rc4/drivers/isdn/capi/capifs.c	2006-02-22 17:00:28.000000000 +0000
+++ linux-2.6.16-rc4-getsb/drivers/isdn/capi/capifs.c	2006-02-22 17:08:47.000000000 +0000
@@ -122,7 +122,7 @@ fail:
 }
 
 static struct super_block *capifs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, capifs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/drivers/misc/ibmasm/ibmasmfs.c linux-2.6.16-rc4-getsb/drivers/misc/ibmasm/ibmasmfs.c
--- linux-2.6.16-rc4/drivers/misc/ibmasm/ibmasmfs.c	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.16-rc4-getsb/drivers/misc/ibmasm/ibmasmfs.c	2006-02-22 17:08:47.000000000 +0000
@@ -91,7 +91,8 @@ static int ibmasmfs_fill_super (struct s
 
 
 static struct super_block *ibmasmfs_get_super(struct file_system_type *fst,
-			int flags, const char *name, void *data)
+			int flags, const char *name, void *data,
+			struct dentry **_root)
 {
 	return get_sb_single(fst, flags, data, ibmasmfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/drivers/oprofile/oprofilefs.c linux-2.6.16-rc4-getsb/drivers/oprofile/oprofilefs.c
--- linux-2.6.16-rc4/drivers/oprofile/oprofilefs.c	2005-03-02 12:08:20.000000000 +0000
+++ linux-2.6.16-rc4-getsb/drivers/oprofile/oprofilefs.c	2006-02-22 17:08:47.000000000 +0000
@@ -273,7 +273,7 @@ static int oprofilefs_fill_super(struct 
 
 
 static struct super_block *oprofilefs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, oprofilefs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/drivers/usb/core/inode.c linux-2.6.16-rc4-getsb/drivers/usb/core/inode.c
--- linux-2.6.16-rc4/drivers/usb/core/inode.c	2006-02-22 17:00:34.000000000 +0000
+++ linux-2.6.16-rc4-getsb/drivers/usb/core/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -544,7 +544,7 @@ static void fs_remove_file (struct dentr
 /* --------------------------------------------------------------------- */
 
 static struct super_block *usb_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, usbfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/drivers/usb/gadget/inode.c linux-2.6.16-rc4-getsb/drivers/usb/gadget/inode.c
--- linux-2.6.16-rc4/drivers/usb/gadget/inode.c	2006-02-22 17:00:34.000000000 +0000
+++ linux-2.6.16-rc4-getsb/drivers/usb/gadget/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -2067,7 +2067,7 @@ gadgetfs_fill_super (struct super_block 
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
 static struct super_block *
 gadgetfs_get_sb (struct file_system_type *t, int flags,
-		const char *path, void *opts)
+		const char *path, void *opts, struct dentry **_root)
 {
 	return get_sb_single (t, flags, opts, gadgetfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/9p/vfs_super.c linux-2.6.16-rc4-getsb/fs/9p/vfs_super.c
--- linux-2.6.16-rc4/fs/9p/vfs_super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/9p/vfs_super.c	2006-02-22 17:15:20.000000000 +0000
@@ -105,7 +105,8 @@ v9fs_fill_super(struct super_block *sb, 
 
 static struct super_block *v9fs_get_sb(struct file_system_type
 				       *fs_type, int flags,
-				       const char *dev_name, void *data)
+				       const char *dev_name, void *data,
+				       struct dentry **_root)
 {
 	struct super_block *sb = NULL;
 	struct v9fs_fcall *fcall = NULL;
diff -uNrp linux-2.6.16-rc4/fs/adfs/super.c linux-2.6.16-rc4-getsb/fs/adfs/super.c
--- linux-2.6.16-rc4/fs/adfs/super.c	2005-01-04 11:13:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/adfs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -470,7 +470,7 @@ error:
 }
 
 static struct super_block *adfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/affs/super.c linux-2.6.16-rc4-getsb/fs/affs/super.c
--- linux-2.6.16-rc4/fs/affs/super.c	2006-01-04 12:39:35.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/affs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -524,7 +524,7 @@ affs_statfs(struct super_block *sb, stru
 }
 
 static struct super_block *affs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, affs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/afs/super.c linux-2.6.16-rc4-getsb/fs/afs/super.c
--- linux-2.6.16-rc4/fs/afs/super.c	2004-09-16 12:06:12.000000000 +0100
+++ linux-2.6.16-rc4-getsb/fs/afs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -40,7 +40,7 @@ static void afs_i_init_once(void *foo, k
 
 static struct super_block *afs_get_sb(struct file_system_type *fs_type,
 				      int flags, const char *dev_name,
-				      void *data);
+				      void *data, struct dentry **_root);
 
 static struct inode *afs_alloc_inode(struct super_block *sb);
 
@@ -297,7 +297,8 @@ static int afs_fill_super(struct super_b
 static struct super_block *afs_get_sb(struct file_system_type *fs_type,
 				      int flags,
 				      const char *dev_name,
-				      void *options)
+				      void *options,
+				      struct dentry **_root)
 {
 	struct afs_mount_params params;
 	struct super_block *sb;
diff -uNrp linux-2.6.16-rc4/fs/autofs/init.c linux-2.6.16-rc4-getsb/fs/autofs/init.c
--- linux-2.6.16-rc4/fs/autofs/init.c	2004-06-18 13:41:28.000000000 +0100
+++ linux-2.6.16-rc4-getsb/fs/autofs/init.c	2006-02-22 17:08:47.000000000 +0000
@@ -15,7 +15,7 @@
 #include "autofs_i.h"
 
 static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, autofs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/autofs4/init.c linux-2.6.16-rc4-getsb/fs/autofs4/init.c
--- linux-2.6.16-rc4/fs/autofs4/init.c	2004-06-18 13:41:20.000000000 +0100
+++ linux-2.6.16-rc4-getsb/fs/autofs4/init.c	2006-02-22 17:08:47.000000000 +0000
@@ -15,7 +15,7 @@
 #include "autofs_i.h"
 
 static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, autofs4_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/befs/linuxvfs.c linux-2.6.16-rc4-getsb/fs/befs/linuxvfs.c
--- linux-2.6.16-rc4/fs/befs/linuxvfs.c	2006-01-04 12:39:35.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/befs/linuxvfs.c	2006-02-22 17:08:47.000000000 +0000
@@ -900,7 +900,7 @@ befs_statfs(struct super_block *sb, stru
 
 static struct super_block *
 befs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name,
-	    void *data)
+	    void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, befs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/bfs/inode.c linux-2.6.16-rc4-getsb/fs/bfs/inode.c
--- linux-2.6.16-rc4/fs/bfs/inode.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/bfs/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -410,7 +410,7 @@ out:
 }
 
 static struct super_block *bfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/binfmt_misc.c linux-2.6.16-rc4-getsb/fs/binfmt_misc.c
--- linux-2.6.16-rc4/fs/binfmt_misc.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/binfmt_misc.c	2006-02-22 17:08:47.000000000 +0000
@@ -741,7 +741,7 @@ static int bm_fill_super(struct super_bl
 }
 
 static struct super_block *bm_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, bm_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/block_dev.c linux-2.6.16-rc4-getsb/fs/block_dev.c
--- linux-2.6.16-rc4/fs/block_dev.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/block_dev.c	2006-02-22 17:08:47.000000000 +0000
@@ -301,7 +301,7 @@ static struct super_operations bdev_sops
 };
 
 static struct super_block *bd_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "bdev:", &bdev_sops, 0x62646576);
 }
diff -uNrp linux-2.6.16-rc4/fs/cifs/cifsfs.c linux-2.6.16-rc4-getsb/fs/cifs/cifsfs.c
--- linux-2.6.16-rc4/fs/cifs/cifsfs.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/cifs/cifsfs.c	2006-02-22 17:13:10.000000000 +0000
@@ -467,7 +467,7 @@ struct super_operations cifs_super_ops =
 
 static struct super_block *
 cifs_get_sb(struct file_system_type *fs_type,
-	    int flags, const char *dev_name, void *data)
+	    int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	int rc;
 	struct super_block *sb = sget(fs_type, NULL, set_anon_super, NULL);
diff -uNrp linux-2.6.16-rc4/fs/coda/inode.c linux-2.6.16-rc4-getsb/fs/coda/inode.c
--- linux-2.6.16-rc4/fs/coda/inode.c	2005-03-02 12:08:35.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/coda/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -306,7 +306,7 @@ static int coda_statfs(struct super_bloc
 /* init_coda: used by filesystems.c to register coda */
 
 static struct super_block *coda_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, coda_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/configfs/mount.c linux-2.6.16-rc4-getsb/fs/configfs/mount.c
--- linux-2.6.16-rc4/fs/configfs/mount.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/configfs/mount.c	2006-02-22 17:15:50.000000000 +0000
@@ -104,7 +104,7 @@ static int configfs_fill_super(struct su
 }
 
 static struct super_block *configfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, configfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/cramfs/inode.c linux-2.6.16-rc4-getsb/fs/cramfs/inode.c
--- linux-2.6.16-rc4/fs/cramfs/inode.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/cramfs/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -530,7 +530,7 @@ static struct super_operations cramfs_op
 };
 
 static struct super_block *cramfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, cramfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/debugfs/inode.c linux-2.6.16-rc4-getsb/fs/debugfs/inode.c
--- linux-2.6.16-rc4/fs/debugfs/inode.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/debugfs/inode.c	2006-02-22 17:14:48.000000000 +0000
@@ -112,7 +112,7 @@ static int debug_fill_super(struct super
 
 static struct super_block *debug_get_sb(struct file_system_type *fs_type,
 				        int flags, const char *dev_name,
-					void *data)
+					void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, debug_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/devfs/base.c linux-2.6.16-rc4-getsb/fs/devfs/base.c
--- linux-2.6.16-rc4/fs/devfs/base.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/devfs/base.c	2006-02-22 17:08:47.000000000 +0000
@@ -2551,7 +2551,7 @@ static int devfs_fill_super(struct super
 
 static struct super_block *devfs_get_sb(struct file_system_type *fs_type,
 					int flags, const char *dev_name,
-					void *data)
+					void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, devfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/devpts/inode.c linux-2.6.16-rc4-getsb/fs/devpts/inode.c
--- linux-2.6.16-rc4/fs/devpts/inode.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/devpts/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -109,7 +109,7 @@ fail:
 }
 
 static struct super_block *devpts_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, devpts_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/efs/super.c linux-2.6.16-rc4-getsb/fs/efs/super.c
--- linux-2.6.16-rc4/fs/efs/super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/efs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -19,7 +19,7 @@ static int efs_statfs(struct super_block
 static int efs_fill_super(struct super_block *s, void *d, int silent);
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, efs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/eventpoll.c linux-2.6.16-rc4-getsb/fs/eventpoll.c
--- linux-2.6.16-rc4/fs/eventpoll.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/eventpoll.c	2006-02-22 17:08:47.000000000 +0000
@@ -269,7 +269,7 @@ static int eventpollfs_delete_dentry(str
 static struct inode *ep_eventpoll_inode(void);
 static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
 					      int flags, const char *dev_name,
-					      void *data);
+					      void *data, struct dentry **_root);
 
 /*
  * This semaphore is used to serialize ep_free() and eventpoll_release_file().
@@ -1605,7 +1605,7 @@ eexit_1:
 
 static struct super_block *
 eventpollfs_get_sb(struct file_system_type *fs_type, int flags,
-		   const char *dev_name, void *data)
+		   const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC);
 }
diff -uNrp linux-2.6.16-rc4/fs/ext2/super.c linux-2.6.16-rc4-getsb/fs/ext2/super.c
--- linux-2.6.16-rc4/fs/ext2/super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ext2/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -1090,7 +1090,7 @@ static int ext2_statfs (struct super_blo
 }
 
 static struct super_block *ext2_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ext3/super.c linux-2.6.16-rc4-getsb/fs/ext3/super.c
--- linux-2.6.16-rc4/fs/ext3/super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ext3/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -2651,7 +2651,7 @@ out:
 #endif
 
 static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext3_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/freevxfs/vxfs_super.c linux-2.6.16-rc4-getsb/fs/freevxfs/vxfs_super.c
--- linux-2.6.16-rc4/fs/freevxfs/vxfs_super.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/freevxfs/vxfs_super.c	2006-02-22 17:08:47.000000000 +0000
@@ -242,7 +242,7 @@ out:
  * The usual module blurb.
  */
 static struct super_block *vxfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/fuse/inode.c linux-2.6.16-rc4-getsb/fs/fuse/inode.c
--- linux-2.6.16-rc4/fs/fuse/inode.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/fuse/inode.c	2006-02-22 17:13:29.000000000 +0000
@@ -606,7 +606,7 @@ static int fuse_fill_super(struct super_
 
 static struct super_block *fuse_get_sb(struct file_system_type *fs_type,
 				       int flags, const char *dev_name,
-				       void *raw_data)
+				       void *raw_data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/hfs/super.c linux-2.6.16-rc4-getsb/fs/hfs/super.c
--- linux-2.6.16-rc4/fs/hfs/super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/hfs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -414,7 +414,8 @@ bail:
 }
 
 static struct super_block *hfs_get_sb(struct file_system_type *fs_type,
-				      int flags, const char *dev_name, void *data)
+				      int flags, const char *dev_name, void *data,
+				      struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/hfsplus/super.c linux-2.6.16-rc4-getsb/fs/hfsplus/super.c
--- linux-2.6.16-rc4/fs/hfsplus/super.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/hfsplus/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -451,7 +451,8 @@ static void hfsplus_destroy_inode(struct
 #define HFSPLUS_INODE_SIZE	sizeof(struct hfsplus_inode_info)
 
 static struct super_block *hfsplus_get_sb(struct file_system_type *fs_type,
-					  int flags, const char *dev_name, void *data)
+					  int flags, const char *dev_name, void *data,
+					  struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/hpfs/super.c linux-2.6.16-rc4-getsb/fs/hpfs/super.c
--- linux-2.6.16-rc4/fs/hpfs/super.c	2006-01-04 12:39:35.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/hpfs/super.c	2006-02-22 17:08:47.000000000 +0000
@@ -662,7 +662,7 @@ bail0:
 }
 
 static struct super_block *hpfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/hugetlbfs/inode.c linux-2.6.16-rc4-getsb/fs/hugetlbfs/inode.c
--- linux-2.6.16-rc4/fs/hugetlbfs/inode.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/hugetlbfs/inode.c	2006-02-22 17:08:47.000000000 +0000
@@ -758,7 +758,7 @@ void hugetlb_put_quota(struct address_sp
 }
 
 static struct super_block *hugetlbfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, hugetlbfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/inotify.c linux-2.6.16-rc4-getsb/fs/inotify.c
--- linux-2.6.16-rc4/fs/inotify.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/inotify.c	2006-02-22 17:14:52.000000000 +0000
@@ -1032,7 +1032,7 @@ out:
 
 static struct super_block *
 inotify_get_sb(struct file_system_type *fs_type, int flags,
-	       const char *dev_name, void *data)
+	       const char *dev_name, void *data, struct dentry **_root)
 {
     return get_sb_pseudo(fs_type, "inotify", NULL, 0xBAD1DEA);
 }
diff -uNrp linux-2.6.16-rc4/fs/isofs/inode.c linux-2.6.16-rc4-getsb/fs/isofs/inode.c
--- linux-2.6.16-rc4/fs/isofs/inode.c	2006-01-04 12:39:35.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/isofs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -1399,7 +1399,7 @@ struct inode *isofs_iget(struct super_bl
 }
 
 static struct super_block *isofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/jffs/inode-v23.c linux-2.6.16-rc4-getsb/fs/jffs/inode-v23.c
--- linux-2.6.16-rc4/fs/jffs/inode-v23.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/jffs/inode-v23.c	2006-02-22 17:08:48.000000000 +0000
@@ -1786,7 +1786,7 @@ static struct super_operations jffs_ops 
 };
 
 static struct super_block *jffs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, jffs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/jffs2/super.c linux-2.6.16-rc4-getsb/fs/jffs2/super.c
--- linux-2.6.16-rc4/fs/jffs2/super.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/jffs2/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -188,7 +188,7 @@ static struct super_block *jffs2_get_sb_
 
 static struct super_block *jffs2_get_sb(struct file_system_type *fs_type,
 					int flags, const char *dev_name,
-					void *data)
+					void *data, struct dentry **_root)
 {
 	int err;
 	struct nameidata nd;
diff -uNrp linux-2.6.16-rc4/fs/jfs/super.c linux-2.6.16-rc4-getsb/fs/jfs/super.c
--- linux-2.6.16-rc4/fs/jfs/super.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/jfs/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -542,7 +542,7 @@ static void jfs_unlockfs(struct super_bl
 }
 
 static struct super_block *jfs_get_sb(struct file_system_type *fs_type, 
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/minix/inode.c linux-2.6.16-rc4-getsb/fs/minix/inode.c
--- linux-2.6.16-rc4/fs/minix/inode.c	2005-11-01 13:19:15.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/minix/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -559,7 +559,7 @@ void minix_truncate(struct inode * inode
 }
 
 static struct super_block *minix_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, minix_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/msdos/namei.c linux-2.6.16-rc4-getsb/fs/msdos/namei.c
--- linux-2.6.16-rc4/fs/msdos/namei.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/msdos/namei.c	2006-02-22 17:14:34.000000000 +0000
@@ -676,7 +676,7 @@ static int msdos_fill_super(struct super
 
 static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
 					int flags, const char *dev_name,
-					void *data)
+					void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ncpfs/inode.c linux-2.6.16-rc4-getsb/fs/ncpfs/inode.c
--- linux-2.6.16-rc4/fs/ncpfs/inode.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ncpfs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -957,7 +957,7 @@ out:
 }
 
 static struct super_block *ncp_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, ncp_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/nfs/inode.c linux-2.6.16-rc4-getsb/fs/nfs/inode.c
--- linux-2.6.16-rc4/fs/nfs/inode.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/nfs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -1586,7 +1586,7 @@ static int nfs_compare_super(struct supe
 }
 
 static struct super_block *nfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
+	int flags, const char *dev_name, void *raw_data, struct dentry **_root)
 {
 	int error;
 	struct nfs_server *server = NULL;
@@ -1924,7 +1924,7 @@ nfs_copy_user_string(char *dst, struct n
 }
 
 static struct super_block *nfs4_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
+	int flags, const char *dev_name, void *raw_data, struct dentry **_root)
 {
 	int error;
 	struct nfs_server *server;
diff -uNrp linux-2.6.16-rc4/fs/nfsd/nfsctl.c linux-2.6.16-rc4-getsb/fs/nfsd/nfsctl.c
--- linux-2.6.16-rc4/fs/nfsd/nfsctl.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/nfsd/nfsctl.c	2006-02-22 17:08:48.000000000 +0000
@@ -495,7 +495,7 @@ static int nfsd_fill_super(struct super_
 }
 
 static struct super_block *nfsd_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, nfsd_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ntfs/super.c linux-2.6.16-rc4-getsb/fs/ntfs/super.c
--- linux-2.6.16-rc4/fs/ntfs/super.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ntfs/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -3015,7 +3015,7 @@ kmem_cache_t *ntfs_index_ctx_cache;
 DECLARE_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ocfs2/dlm/dlmfs.c linux-2.6.16-rc4-getsb/fs/ocfs2/dlm/dlmfs.c
--- linux-2.6.16-rc4/fs/ocfs2/dlm/dlmfs.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ocfs2/dlm/dlmfs.c	2006-02-22 17:16:16.000000000 +0000
@@ -575,7 +575,7 @@ static struct inode_operations dlmfs_fil
 };
 
 static struct super_block *dlmfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, dlmfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ocfs2/super.c linux-2.6.16-rc4-getsb/fs/ocfs2/super.c
--- linux-2.6.16-rc4/fs/ocfs2/super.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ocfs2/super.c	2006-02-22 17:16:22.000000000 +0000
@@ -675,7 +675,8 @@ read_super_error:
 static struct super_block *ocfs2_get_sb(struct file_system_type *fs_type,
 					int flags,
 					const char *dev_name,
-					void *data)
+					void *data,
+					struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ocfs2_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/openpromfs/inode.c linux-2.6.16-rc4-getsb/fs/openpromfs/inode.c
--- linux-2.6.16-rc4/fs/openpromfs/inode.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/openpromfs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -1055,7 +1055,7 @@ out_no_root:
 }
 
 static struct super_block *openprom_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, openprom_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/pipe.c linux-2.6.16-rc4-getsb/fs/pipe.c
--- linux-2.6.16-rc4/fs/pipe.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/pipe.c	2006-02-22 17:08:48.000000000 +0000
@@ -806,7 +806,7 @@ no_files:
  */
 
 static struct super_block *pipefs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC);
 }
diff -uNrp linux-2.6.16-rc4/fs/proc/root.c linux-2.6.16-rc4-getsb/fs/proc/root.c
--- linux-2.6.16-rc4/fs/proc/root.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/proc/root.c	2006-02-22 17:08:48.000000000 +0000
@@ -27,7 +27,7 @@ struct proc_dir_entry *proc_sys_root;
 #endif
 
 static struct super_block *proc_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, proc_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/qnx4/inode.c linux-2.6.16-rc4-getsb/fs/qnx4/inode.c
--- linux-2.6.16-rc4/fs/qnx4/inode.c	2005-11-01 13:19:15.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/qnx4/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -561,7 +561,7 @@ static void destroy_inodecache(void)
 }
 
 static struct super_block *qnx4_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ramfs/inode.c linux-2.6.16-rc4-getsb/fs/ramfs/inode.c
--- linux-2.6.16-rc4/fs/ramfs/inode.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ramfs/inode.c	2006-02-22 17:14:16.000000000 +0000
@@ -183,13 +183,13 @@ static int ramfs_fill_super(struct super
 }
 
 struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
 }
 
 static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/relayfs/inode.c linux-2.6.16-rc4-getsb/fs/relayfs/inode.c
--- linux-2.6.16-rc4/fs/relayfs/inode.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/relayfs/inode.c	2006-02-22 17:15:40.000000000 +0000
@@ -539,7 +539,7 @@ static int relayfs_fill_super(struct sup
 
 static struct super_block * relayfs_get_sb(struct file_system_type *fs_type,
 					   int flags, const char *dev_name,
-					   void *data)
+					   void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, relayfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/romfs/inode.c linux-2.6.16-rc4-getsb/fs/romfs/inode.c
--- linux-2.6.16-rc4/fs/romfs/inode.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/romfs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -607,7 +607,7 @@ static struct super_operations romfs_ops
 };
 
 static struct super_block *romfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, romfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/smbfs/inode.c linux-2.6.16-rc4-getsb/fs/smbfs/inode.c
--- linux-2.6.16-rc4/fs/smbfs/inode.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/smbfs/inode.c	2006-02-22 17:08:48.000000000 +0000
@@ -782,7 +782,7 @@ out:
 }
 
 static struct super_block *smb_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, smb_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/sysfs/mount.c linux-2.6.16-rc4-getsb/fs/sysfs/mount.c
--- linux-2.6.16-rc4/fs/sysfs/mount.c	2005-08-30 13:56:29.000000000 +0100
+++ linux-2.6.16-rc4-getsb/fs/sysfs/mount.c	2006-02-22 17:08:48.000000000 +0000
@@ -67,7 +67,7 @@ static int sysfs_fill_super(struct super
 }
 
 static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/sysv/super.c linux-2.6.16-rc4-getsb/fs/sysv/super.c
--- linux-2.6.16-rc4/fs/sysv/super.c	2004-10-19 10:42:09.000000000 +0100
+++ linux-2.6.16-rc4-getsb/fs/sysv/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -507,13 +507,13 @@ failed:
 /* Every kernel module contains stuff like this. */
 
 static struct super_block *sysv_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
 }
 
 static struct super_block *v7_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, v7_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/udf/super.c linux-2.6.16-rc4-getsb/fs/udf/super.c
--- linux-2.6.16-rc4/fs/udf/super.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/udf/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -95,7 +95,7 @@ static int udf_statfs(struct super_block
 
 /* UDF filesystem type */
 static struct super_block *udf_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, udf_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/ufs/super.c linux-2.6.16-rc4-getsb/fs/ufs/super.c
--- linux-2.6.16-rc4/fs/ufs/super.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/ufs/super.c	2006-02-22 17:08:48.000000000 +0000
@@ -1311,7 +1311,7 @@ out:
 #endif
 
 static struct super_block *ufs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/vfat/namei.c linux-2.6.16-rc4-getsb/fs/vfat/namei.c
--- linux-2.6.16-rc4/fs/vfat/namei.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/vfat/namei.c	2006-02-22 17:14:44.000000000 +0000
@@ -1043,7 +1043,7 @@ static int vfat_fill_super(struct super_
 
 static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
 				       int flags, const char *dev_name,
-				       void *data)
+				       void *data, struct dentry **_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/fs/xfs/linux-2.6/xfs_super.c linux-2.6.16-rc4-getsb/fs/xfs/linux-2.6/xfs_super.c
--- linux-2.6.16-rc4/fs/xfs/linux-2.6/xfs_super.c	2006-02-22 17:00:38.000000000 +0000
+++ linux-2.6.16-rc4-getsb/fs/xfs/linux-2.6/xfs_super.c	2006-02-22 17:12:42.000000000 +0000
@@ -914,7 +914,8 @@ linvfs_get_sb(
 	struct file_system_type	*fs_type,
 	int			flags,
 	const char		*dev_name,
-	void			*data)
+	void			*data,
+	struct dentry		**_root)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, linvfs_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/include/linux/ramfs.h linux-2.6.16-rc4-getsb/include/linux/ramfs.h
--- linux-2.6.16-rc4/include/linux/ramfs.h	2006-02-22 17:00:42.000000000 +0000
+++ linux-2.6.16-rc4-getsb/include/linux/ramfs.h	2006-02-22 17:10:37.000000000 +0000
@@ -3,7 +3,7 @@
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
 struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
-	 int flags, const char *dev_name, void *data);
+	 int flags, const char *dev_name, void *data, struct dentry **_root);
 
 #ifndef CONFIG_MMU
 extern unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
diff -uNrp linux-2.6.16-rc4/ipc/mqueue.c linux-2.6.16-rc4-getsb/ipc/mqueue.c
--- linux-2.6.16-rc4/ipc/mqueue.c	2006-02-22 17:00:43.000000000 +0000
+++ linux-2.6.16-rc4-getsb/ipc/mqueue.c	2006-02-22 17:08:49.000000000 +0000
@@ -203,7 +203,7 @@ static int mqueue_fill_super(struct supe
 
 static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
 					 int flags, const char *dev_name,
-					 void *data)
+					 void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, mqueue_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/kernel/cpuset.c linux-2.6.16-rc4-getsb/kernel/cpuset.c
--- linux-2.6.16-rc4/kernel/cpuset.c	2006-02-22 17:00:43.000000000 +0000
+++ linux-2.6.16-rc4-getsb/kernel/cpuset.c	2006-02-22 17:16:44.000000000 +0000
@@ -386,7 +386,7 @@ static int cpuset_fill_super(struct supe
 
 static struct super_block *cpuset_get_sb(struct file_system_type *fs_type,
 					int flags, const char *unused_dev_name,
-					void *data)
+					void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, cpuset_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/kernel/futex.c linux-2.6.16-rc4-getsb/kernel/futex.c
--- linux-2.6.16-rc4/kernel/futex.c	2006-02-22 17:00:43.000000000 +0000
+++ linux-2.6.16-rc4-getsb/kernel/futex.c	2006-02-22 17:08:49.000000000 +0000
@@ -886,7 +886,7 @@ asmlinkage long sys_futex(u32 __user *ua
 
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
-	       int flags, const char *dev_name, void *data)
+	       int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA);
 }
diff -uNrp linux-2.6.16-rc4/mm/shmem.c linux-2.6.16-rc4-getsb/mm/shmem.c
--- linux-2.6.16-rc4/mm/shmem.c	2006-02-22 17:00:44.000000000 +0000
+++ linux-2.6.16-rc4-getsb/mm/shmem.c	2006-02-22 17:08:49.000000000 +0000
@@ -2171,7 +2171,7 @@ static struct vm_operations_struct shmem
 
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_nodev(fs_type, flags, data, shmem_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/net/socket.c linux-2.6.16-rc4-getsb/net/socket.c
--- linux-2.6.16-rc4/net/socket.c	2006-02-22 17:00:46.000000000 +0000
+++ linux-2.6.16-rc4-getsb/net/socket.c	2006-02-22 17:08:49.000000000 +0000
@@ -328,7 +328,7 @@ static struct super_operations sockfs_op
 };
 
 static struct super_block *sockfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_pseudo(fs_type, "socket:", &sockfs_ops, SOCKFS_MAGIC);
 }
diff -uNrp linux-2.6.16-rc4/net/sunrpc/rpc_pipe.c linux-2.6.16-rc4-getsb/net/sunrpc/rpc_pipe.c
--- linux-2.6.16-rc4/net/sunrpc/rpc_pipe.c	2006-02-22 17:00:46.000000000 +0000
+++ linux-2.6.16-rc4-getsb/net/sunrpc/rpc_pipe.c	2006-02-22 17:08:49.000000000 +0000
@@ -814,7 +814,7 @@ out:
 
 static struct super_block *
 rpc_get_sb(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+		int flags, const char *dev_name, void *data, struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, rpc_fill_super);
 }
diff -uNrp linux-2.6.16-rc4/security/selinux/selinuxfs.c linux-2.6.16-rc4-getsb/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4/security/selinux/selinuxfs.c	2006-02-22 17:00:46.000000000 +0000
+++ linux-2.6.16-rc4-getsb/security/selinux/selinuxfs.c	2006-02-22 17:08:49.000000000 +0000
@@ -1281,7 +1281,8 @@ out:
 }
 
 static struct super_block *sel_get_sb(struct file_system_type *fs_type,
-				      int flags, const char *dev_name, void *data)
+				      int flags, const char *dev_name, void *data,
+				      struct dentry **_root)
 {
 	return get_sb_single(fs_type, flags, data, sel_fill_super);
 }
