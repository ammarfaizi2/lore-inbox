Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316625AbSEVSC2>; Wed, 22 May 2002 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316627AbSEVSC1>; Wed, 22 May 2002 14:02:27 -0400
Received: from imladris.infradead.org ([194.205.184.45]:64529 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316625AbSEVSCS>; Wed, 22 May 2002 14:02:18 -0400
Date: Wed, 22 May 2002 19:02:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] split namei.h out of fs.h
Message-ID: <20020522190213.A17774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently fs.h is full of unrelated declarations and included in almost
any source file. Thus it makes sense to spilt certain aspects out that are
only used by few users.

This patch starts with the namei/path lookup interface and splits it into
<linux/namei.h> which is now directly included by the 24 files that actually
need it.


--- 1.30/drivers/usb/core/inode.c	Fri Apr  5 01:59:36 2002
+++ edited/drivers/usb/core/inode.c	Wed May 22 16:25:48 2002
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/usb.h>
+#include <linux/namei.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/smp_lock.h>
 #include <asm/byteorder.h>
--- 1.11/fs/binfmt_misc.c	Tue Apr 16 23:23:07 2002
+++ edited/fs/binfmt_misc.c	Wed May 22 15:48:10 2002
@@ -24,6 +24,7 @@
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 
--- 1.27/fs/exec.c	Mon Apr 22 15:42:32 2002
+++ edited/fs/exec.c	Wed May 22 15:48:11 2002
@@ -38,6 +38,7 @@
 #include <linux/binfmts.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- 1.45/fs/namei.c	Wed May  1 01:37:15 2002
+++ edited/fs/namei.c	Wed May 22 15:48:12 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
 #include <linux/dnotify.h>
--- 1.20/fs/namespace.c	Tue Mar 12 02:30:15 2002
+++ edited/fs/namespace.c	Wed May 22 15:48:12 2002
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 
--- 1.2/fs/nfsctl.c	Tue Apr  9 05:24:00 2002
+++ edited/fs/nfsctl.c	Wed May 22 15:48:12 2002
@@ -11,6 +11,7 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/syscall.h>
 #include <linux/linkage.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 
 /*
--- 1.19/fs/open.c	Sun May 19 13:49:48 2002
+++ edited/fs/open.c	Wed May 22 15:50:04 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/iobuf.h>
+#include <linux/namei.h>
 #include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
--- 1.2/fs/quota.c	Sat May 18 19:48:47 2002
+++ edited/fs/quota.c	Wed May 22 16:07:40 2002
@@ -11,6 +11,7 @@
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/namei.h>
 #ifdef CONFIG_QIFACE_COMPAT
 #include <linux/quotacompat.h>
 #endif
--- 1.7/fs/stat.c	Mon Mar 11 18:34:09 2002
+++ edited/fs/stat.c	Wed May 22 15:48:12 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 
--- 1.72/fs/super.c	Mon May 20 15:40:13 2002
+++ edited/fs/super.c	Wed May 22 15:50:25 2002
@@ -27,6 +27,7 @@
 #include <linux/acct.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 
 void get_filesystem(struct file_system_type *fs);
--- 1.5/fs/xattr.c	Sun Apr 28 16:33:07 2002
+++ edited/fs/xattr.c	Wed May 22 15:48:13 2002
@@ -12,6 +12,7 @@
 #include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/xattr.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 
 /*
--- 1.1/fs/autofs/dirhash.c	Tue Feb  5 18:39:38 2002
+++ edited/fs/autofs/dirhash.c	Wed May 22 19:18:48 2002
@@ -10,6 +10,8 @@
  *
  * ------------------------------------------------------------------------- */
 
+#include <linux/dcache.h>
+#include <linux/namei.h>
 #include "autofs_i.h"
 
 /* Functions for maintenance of expiry queue */
--- 1.7/fs/coda/pioctl.c	Mon May 20 15:35:03 2002
+++ edited/fs/coda/pioctl.c	Wed May 22 16:24:07 2002
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #define __NO_VERSION__
+#include <linux/namei.h>
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
--- 1.18/fs/driverfs/inode.c	Tue Mar 12 23:22:16 2002
+++ edited/fs/driverfs/inode.c	Wed May 22 15:48:13 2002
@@ -29,6 +29,7 @@
 #include <linux/stat.h>
 #include <linux/fs.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
--- 1.3/fs/exportfs/expfs.c	Tue May  7 06:28:38 2002
+++ edited/fs/exportfs/expfs.c	Wed May 22 15:48:13 2002
@@ -2,6 +2,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/namei.h>
 
 struct export_operations export_op_default;
 
--- 1.24/fs/nfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/nfs/dir.c	Wed May 22 15:48:13 2002
@@ -30,6 +30,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/namei.h>
 
 #define NFS_PARANOIA 1
 /* #define NFS_DEBUG_VERBOSE 1 */
--- 1.33/fs/nfsd/export.c	Wed May 15 07:08:19 2002
+++ edited/fs/nfsd/export.c	Wed May 22 15:48:13 2002
@@ -21,6 +21,7 @@
 #include <linux/in.h>
 #include <linux/seq_file.h>
 #include <linux/rwsem.h>
+#include <linux/namei.h>
 
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
--- 1.11/fs/nfsd/nfs3xdr.c	Fri Apr  5 06:00:18 2002
+++ edited/fs/nfsd/nfs3xdr.c	Wed May 22 19:19:24 2002
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs3.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
 
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
--- 1.13/fs/nfsd/nfsproc.c	Mon May 20 15:38:13 2002
+++ edited/fs/nfsd/nfsproc.c	Wed May 22 16:23:24 2002
@@ -15,6 +15,7 @@
 #include <linux/fcntl.h>
 #include <linux/net.h>
 #include <linux/in.h>
+#include <linux/namei.h>
 #include <linux/version.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
--- 1.28/fs/nfsd/vfs.c	Mon May 20 15:38:16 2002
+++ edited/fs/nfsd/vfs.c	Wed May 22 15:48:13 2002
@@ -32,6 +32,7 @@
 #include <linux/in.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/namei.h>
 
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
--- 1.25/fs/proc/base.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/proc/base.c	Wed May 22 15:48:14 2002
@@ -24,6 +24,7 @@
 #include <linux/file.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
+#include <linux/namei.h>
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
--- 1.117/include/linux/fs.h	Mon May 20 15:43:51 2002
+++ edited/include/linux/fs.h	Wed May 22 18:57:10 2002
@@ -27,6 +27,7 @@
 #include <asm/atomic.h>
 
 struct poll_table_struct;
+struct nameidata;
 
 
 /*
@@ -605,16 +606,6 @@
 /* only for net: no internal synchronization */
 extern void __kill_fasync(struct fasync_struct *, int, int);
 
-struct nameidata {
-	struct dentry *dentry;
-	struct vfsmount *mnt;
-	struct qstr last;
-	unsigned int flags;
-	int last_type;
-	struct dentry *old_dentry;
-	struct vfsmount *old_mnt;
-};
-
 /*
  *	Umount options
  */
@@ -707,9 +698,6 @@
 extern int vfs_unlink(struct inode *, struct dentry *);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 
-extern struct dentry *lock_rename(struct dentry *, struct dentry *);
-extern void unlock_rename(struct dentry *, struct dentry *);
-
 /*
  * File types
  */
@@ -1168,25 +1156,6 @@
 #include <linux/err.h>
 
 /*
- * The bitmask for a lookup event:
- *  - follow links at the end
- *  - require a directory
- *  - ending slashes ok even for nonexistent files
- *  - internal "there are more path compnents" flag
- *  - locked when lookup done with dcache_lock held
- */
-#define LOOKUP_FOLLOW		(1)
-#define LOOKUP_DIRECTORY	(2)
-#define LOOKUP_CONTINUE		(4)
-#define LOOKUP_PARENT		(16)
-#define LOOKUP_NOALT		(32)
-
-/*
- * Type of the last component on LOOKUP_PARENT
- */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
-
-/*
  * "descriptor" for what we're up to with a read for sendfile().
  * This allows us to use the same read code yet
  * have multiple different users of the data that
@@ -1206,19 +1175,6 @@
 
 /* needed for stackable file system support */
 extern loff_t default_llseek(struct file *file, loff_t offset, int origin);
-
-extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
-extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
-extern int FASTCALL(path_walk(const char *, struct nameidata *));
-extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
-extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
-extern void path_release(struct nameidata *);
-extern int follow_down(struct vfsmount **, struct dentry **);
-extern int follow_up(struct vfsmount **, struct dentry **);
-extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
-#define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW, nd)
-#define user_path_walk_link(name,nd) __user_walk(name, 0, nd)
 
 extern void inode_init_once(struct inode *);
 extern void iput(struct inode *);
--- 1.87/kernel/ksyms.c	Mon May 20 15:40:50 2002
+++ edited/kernel/ksyms.c	Wed May 22 15:48:14 2002
@@ -47,6 +47,7 @@
 #include <linux/completion.h>
 #include <linux/seq_file.h>
 #include <linux/binfmts.h>
+#include <linux/namei.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
--- 1.44/mm/swapfile.c	Sun May 19 13:49:46 2002
+++ edited/mm/swapfile.c	Wed May 22 15:48:14 2002
@@ -13,6 +13,7 @@
 #include <linux/swapctl.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/namei.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
 #include <linux/compiler.h>
--- 1.22/net/unix/af_unix.c	Fri Apr 26 04:51:56 2002
+++ edited/net/unix/af_unix.c	Wed May 22 15:48:14 2002
@@ -88,6 +88,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/stat.h>
+#include <linux/namei.h>
 #include <linux/socket.h>
 #include <linux/un.h>
 #include <linux/fcntl.h>
--- /dev/null	Thu Dec 13 11:34:58 2001
+++ b/include/linux/namei.h	Wed May 22 15:49:42 2002
@@ -0,0 +1,56 @@
+#ifndef _LINUX_NAMEI_H
+#define _LINUX_NAMEI_H
+
+struct vfsmount;
+
+struct nameidata {
+	struct dentry	*dentry;
+	struct vfsmount *mnt;
+	struct qstr	last;
+	unsigned int	flags;
+	int		last_type;
+	struct dentry	*old_dentry;
+	struct vfsmount	*old_mnt;
+};
+
+/*
+ * Type of the last component on LOOKUP_PARENT
+ */
+enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
+
+/*
+ * The bitmask for a lookup event:
+ *  - follow links at the end
+ *  - require a directory
+ *  - ending slashes ok even for nonexistent files
+ *  - internal "there are more path compnents" flag
+ *  - locked when lookup done with dcache_lock held
+ */
+#define LOOKUP_FOLLOW		 1
+#define LOOKUP_DIRECTORY	 2
+#define LOOKUP_CONTINUE		 4
+#define LOOKUP_PARENT		16
+#define LOOKUP_NOALT		32
+
+
+extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
+#define user_path_walk(name,nd) \
+	__user_walk(name, LOOKUP_FOLLOW, nd)
+#define user_path_walk_link(name,nd) \
+	__user_walk(name, 0, nd)
+extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
+extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
+extern void path_release(struct nameidata *);
+
+extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
+
+extern int follow_down(struct vfsmount **, struct dentry **);
+extern int follow_up(struct vfsmount **, struct dentry **);
+
+extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern void unlock_rename(struct dentry *, struct dentry *);
+
+#endif /* _LINUX_NAMEI_H */
