Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVKJA3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKJA3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKJA3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:29:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28077 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751127AbVKJA3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:29:03 -0500
Date: Thu, 10 Nov 2005 00:29:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] 64bit values for d_ino
Message-ID: <20051110002902.GC7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The rest - filldir_t update

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

 arch/alpha/kernel/osf_sys.c       |    2 +-
 arch/ia64/ia32/sys_ia32.c         |    4 ++--
 arch/mips/kernel/sysirix.c        |    4 ++--
 arch/parisc/hpux/fs.c             |    2 +-
 arch/parisc/kernel/sys_parisc32.c |    4 ++--
 arch/powerpc/kernel/sys_ppc32.c   |    2 +-
 arch/sparc/kernel/sys_sunos.c     |    4 ++--
 arch/sparc64/kernel/sys_sunos32.c |    4 ++--
 fs/afs/dir.c                      |    4 ++--
 fs/compat.c                       |    6 +++---
 fs/exportfs/expfs.c               |    2 +-
 fs/fat/dir.c                      |    2 +-
 fs/hppfs/hppfs_kern.c             |    2 +-
 fs/nfsd/nfs3xdr.c                 |    8 ++++----
 fs/nfsd/nfs4recover.c             |    2 +-
 fs/nfsd/nfs4xdr.c                 |    2 +-
 fs/nfsd/nfsxdr.c                  |    2 +-
 fs/readdir.c                      |    6 +++---
 fs/reiserfs/xattr.c               |    6 +++---
 include/linux/fs.h                |    2 +-
 include/linux/nfsd/nfsd.h         |    2 +-
 include/linux/nfsd/xdr.h          |    2 +-
 include/linux/nfsd/xdr3.h         |    4 ++--
 23 files changed, 39 insertions(+), 39 deletions(-)

ee4212af2dc6b2ebd05e113339fbe1d9fcd11a76
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -111,7 +111,7 @@ struct osf_dirent_callback {
 
 static int
 osf_filldir(void *__buf, const char *name, int namlen, loff_t offset,
-	    ino_t ino, unsigned int d_type)
+	    u64 ino, unsigned int d_type)
 {
 	struct osf_dirent __user *dirent;
 	struct osf_dirent_callback *buf = (struct osf_dirent_callback *) __buf;
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -1240,7 +1240,7 @@ struct readdir32_callback {
 };
 
 static int
-filldir32 (void *__buf, const char *name, int namlen, loff_t offset, ino_t ino,
+filldir32 (void *__buf, const char *name, int namlen, loff_t offset, u64 ino,
 	   unsigned int d_type)
 {
 	struct compat_dirent __user * dirent;
@@ -1305,7 +1305,7 @@ out:
 }
 
 static int
-fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, ino_t ino,
+fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, u64 ino,
 	      unsigned int d_type)
 {
 	struct readdir32_callback * buf = (struct readdir32_callback *) __buf;
diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -1760,7 +1760,7 @@ struct irix_dirent32_callback {
 #define ROUND_UP32(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
 
 static int irix_filldir32(void *__buf, const char *name,
-	int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent32 __user *dirent;
 	struct irix_dirent32_callback *buf = __buf;
@@ -1858,7 +1858,7 @@ struct irix_dirent64_callback {
 #define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
 static int irix_filldir64(void *__buf, const char *name,
-	int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent64 __user *dirent;
 	struct irix_dirent64_callback * buf = __buf;
diff --git a/arch/parisc/hpux/fs.c b/arch/parisc/hpux/fs.c
--- a/arch/parisc/hpux/fs.c
+++ b/arch/parisc/hpux/fs.c
@@ -73,7 +73,7 @@ struct getdents_callback {
 #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
 static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
-		ino_t ino, unsigned d_type)
+		u64 ino, unsigned d_type)
 {
 	struct hpux_dirent * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -309,7 +309,7 @@ struct readdir32_callback {
 #define ROUND_UP(x,a)	((__typeof__(x))(((unsigned long)(x) + ((a) - 1)) & ~((a) - 1)))
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
 static int
-filldir32 (void *__buf, const char *name, int namlen, loff_t offset, ino_t ino,
+filldir32 (void *__buf, const char *name, int namlen, loff_t offset, u64 ino,
 	   unsigned int d_type)
 {
 	struct linux32_dirent __user * dirent;
@@ -369,7 +369,7 @@ out:
 }
 
 static int
-fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, ino_t ino,
+fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, u64 ino,
 	      unsigned int d_type)
 {
 	struct readdir32_callback * buf = (struct readdir32_callback *) __buf;
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -72,7 +72,7 @@ struct readdir_callback32 {
 };
 
 static int fillonedir(void * __buf, const char * name, int namlen,
-		                  off_t offset, ino_t ino, unsigned int d_type)
+		                  off_t offset, u64 ino, unsigned int d_type)
 {
 	struct readdir_callback32 * buf = (struct readdir_callback32 *) __buf;
 	struct old_linux_dirent32 __user * dirent;
diff --git a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
--- a/arch/sparc/kernel/sys_sunos.c
+++ b/arch/sparc/kernel/sys_sunos.c
@@ -324,7 +324,7 @@ struct sunos_dirent_callback {
 #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
 static int sunos_filldir(void * __buf, const char * name, int namlen,
-			 loff_t offset, ino_t ino, unsigned int d_type)
+			 loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = __buf;
@@ -405,7 +405,7 @@ struct sunos_direntry_callback {
 };
 
 static int sunos_filldirentry(void * __buf, const char * name, int namlen,
-			      loff_t offset, ino_t ino, unsigned int d_type)
+			      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_direntry __user *dirent;
 	struct sunos_direntry_callback *buf = __buf;
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -274,7 +274,7 @@ struct sunos_dirent_callback {
 #define ROUND_UP(x) (((x)+sizeof(s32)-1) & ~(sizeof(s32)-1))
 
 static int sunos_filldir(void * __buf, const char * name, int namlen,
-			 loff_t offset, ino_t ino, unsigned int d_type)
+			 loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = (struct sunos_dirent_callback *) __buf;
@@ -356,7 +356,7 @@ struct sunos_direntry_callback {
 };
 
 static int sunos_filldirentry(void * __buf, const char * name, int namlen,
-			      loff_t offset, ino_t ino, unsigned int d_type)
+			      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_direntry __user *dirent;
 	struct sunos_direntry_callback * buf =
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -30,7 +30,7 @@ static int afs_dir_readdir(struct file *
 static int afs_d_revalidate(struct dentry *dentry, struct nameidata *nd);
 static int afs_d_delete(struct dentry *dentry);
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen,
-				  loff_t fpos, ino_t ino, unsigned dtype);
+				  loff_t fpos, u64 ino, unsigned dtype);
 
 struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
@@ -411,7 +411,7 @@ static int afs_dir_readdir(struct file *
  *   uniquifier through dtype
  */
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen,
-				  loff_t fpos, ino_t ino, unsigned dtype)
+				  loff_t fpos, u64 ino, unsigned dtype)
 {
 	struct afs_dir_lookup_cookie *cookie = _cookie;
 
diff --git a/fs/compat.c b/fs/compat.c
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -867,7 +867,7 @@ struct compat_readdir_callback {
 };
 
 static int compat_fillonedir(void *__buf, const char *name, int namlen,
-			loff_t offset, ino_t ino, unsigned int d_type)
+			loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct compat_readdir_callback *buf = __buf;
 	struct compat_old_linux_dirent __user *dirent;
@@ -931,7 +931,7 @@ struct compat_getdents_callback {
 };
 
 static int compat_filldir(void *__buf, const char *name, int namlen,
-		loff_t offset, ino_t ino, unsigned int d_type)
+		loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct compat_linux_dirent __user * dirent;
 	struct compat_getdents_callback *buf = __buf;
@@ -1017,7 +1017,7 @@ struct compat_getdents_callback64 {
 };
 
 static int compat_filldir64(void * __buf, const char * name, int namlen, loff_t offset,
-		     ino_t ino, unsigned int d_type)
+		     u64 ino, unsigned int d_type)
 {
 	struct linux_dirent64 __user *dirent;
 	struct compat_getdents_callback64 *buf = __buf;
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -322,7 +322,7 @@ struct getdents_callback {
  * the name matching the specified inode number.
  */
 static int filldir_one(void * __buf, const char * name, int len,
-			loff_t pos, ino_t ino, unsigned int d_type)
+			loff_t pos, u64 ino, unsigned int d_type)
 {
 	struct getdents_callback *buf = __buf;
 	int result = 0;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -647,7 +647,7 @@ static int fat_readdir(struct file *filp
 }
 
 static int fat_ioctl_filldir(void *__buf, const char *name, int name_len,
-			     loff_t offset, ino_t ino, unsigned int d_type)
+			     loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct fat_ioctl_filldir_callback *buf = __buf;
 	struct dirent __user *d1 = buf->dirent;
diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -573,7 +573,7 @@ struct hppfs_dirent {
 };
 
 static int hppfs_filldir(void *d, const char *name, int size,
-			 loff_t offset, ino_t inode, unsigned int type)
+			 loff_t offset, u64 inode, unsigned int type)
 {
 	struct hppfs_dirent *dirent = d;
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -777,7 +777,7 @@ nfs3svc_encode_readdirres(struct svc_rqs
 
 static inline u32 *
 encode_entry_baggage(struct nfsd3_readdirres *cd, u32 *p, const char *name,
-	     int namlen, ino_t ino)
+	     int namlen, u64 ino)
 {
 	*p++ = xdr_one;				 /* mark entry present */
 	p    = xdr_encode_hyper(p, ino);	 /* file id */
@@ -848,7 +848,7 @@ compose_entry_fh(struct nfsd3_readdirres
 #define NFS3_ENTRYPLUS_BAGGAGE	(1 + 21 + 1 + (NFS3_FHSIZE >> 2))
 static int
 encode_entry(struct readdir_cd *ccd, const char *name,
-	     int namlen, off_t offset, ino_t ino, unsigned int d_type, int plus)
+	     int namlen, off_t offset, u64 ino, unsigned int d_type, int plus)
 {
 	struct nfsd3_readdirres *cd = container_of(ccd, struct nfsd3_readdirres,
 		       					common);
@@ -994,14 +994,14 @@ encode_entry(struct readdir_cd *ccd, con
 
 int
 nfs3svc_encode_entry(struct readdir_cd *cd, const char *name,
-		     int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+		     int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 0);
 }
 
 int
 nfs3svc_encode_entry_plus(struct readdir_cd *cd, const char *name,
-			  int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+			  int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
 }
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -183,7 +183,7 @@ struct dentry_list_arg {
 
 static int
 nfsd4_build_dentrylist(void *arg, const char *name, int namlen,
-		loff_t offset, ino_t ino, unsigned int d_type)
+		loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct dentry_list_arg *dla = arg;
 	struct list_head *dentries = &dla->dentries;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1719,7 +1719,7 @@ nfsd4_encode_rdattr_error(u32 *p, int bu
 
 static int
 nfsd4_encode_dirent(struct readdir_cd *ccd, const char *name, int namlen,
-		    loff_t offset, ino_t ino, unsigned int d_type)
+		    loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct nfsd4_readdir *cd = container_of(ccd, struct nfsd4_readdir, common);
 	int buflen;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -473,7 +473,7 @@ nfssvc_encode_statfsres(struct svc_rqst 
 
 int
 nfssvc_encode_entry(struct readdir_cd *ccd, const char *name,
-		    int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+		    int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct nfsd_readdirres *cd = container_of(ccd, struct nfsd_readdirres, common);
 	u32	*p = cd->buffer;
diff --git a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -69,7 +69,7 @@ struct readdir_callback {
 };
 
 static int fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
-		      ino_t ino, unsigned int d_type)
+		      u64 ino, unsigned int d_type)
 {
 	struct readdir_callback * buf = (struct readdir_callback *) __buf;
 	struct old_linux_dirent __user * dirent;
@@ -138,7 +138,7 @@ struct getdents_callback {
 };
 
 static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
-		   ino_t ino, unsigned int d_type)
+		   u64 ino, unsigned int d_type)
 {
 	struct linux_dirent __user * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
@@ -222,7 +222,7 @@ struct getdents_callback64 {
 };
 
 static int filldir64(void * __buf, const char * name, int namlen, loff_t offset,
-		     ino_t ino, unsigned int d_type)
+		     u64 ino, unsigned int d_type)
 {
 	struct linux_dirent64 __user *dirent;
 	struct getdents_callback64 * buf = (struct getdents_callback64 *) __buf;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -785,7 +785,7 @@ int reiserfs_xattr_del(struct inode *ino
 
 static int
 reiserfs_delete_xattrs_filler(void *buf, const char *name, int namelen,
-			      loff_t offset, ino_t ino, unsigned int d_type)
+			      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct dentry *xadir = (struct dentry *)buf;
 
@@ -863,7 +863,7 @@ struct reiserfs_chown_buf {
 /* XXX: If there is a better way to do this, I'd love to hear about it */
 static int
 reiserfs_chown_xattrs_filler(void *buf, const char *name, int namelen,
-			     loff_t offset, ino_t ino, unsigned int d_type)
+			     loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct reiserfs_chown_buf *chown_buf = (struct reiserfs_chown_buf *)buf;
 	struct dentry *xafile, *xadir = chown_buf->xadir;
@@ -1060,7 +1060,7 @@ struct reiserfs_listxattr_buf {
 
 static int
 reiserfs_listxattr_filler(void *buf, const char *name, int namelen,
-			  loff_t offset, ino_t ino, unsigned int d_type)
+			  loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct reiserfs_listxattr_buf *b = (struct reiserfs_listxattr_buf *)buf;
 	int len = 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -915,7 +915,7 @@ int generic_osync_inode(struct inode *, 
  * This allows the kernel to read directories into kernel space or
  * to have different dirent layouts depending on the binary type.
  */
-typedef int (*filldir_t)(void *, const char *, int, loff_t, ino_t, unsigned);
+typedef int (*filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 struct block_device_operations {
 	int (*open) (struct inode *, struct file *);
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -54,7 +54,7 @@ struct readdir_cd {
 	int			err;	/* 0, nfserr, or nfserr_eof */
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
-						int, loff_t, ino_t, unsigned int);
+						int, loff_t, u64, unsigned int);
 typedef int (*nfsd_dirop_t)(struct inode *, struct dentry *, int, int);
 
 extern struct svc_program	nfsd_program;
diff --git a/include/linux/nfsd/xdr.h b/include/linux/nfsd/xdr.h
--- a/include/linux/nfsd/xdr.h
+++ b/include/linux/nfsd/xdr.h
@@ -165,7 +165,7 @@ int nfssvc_encode_statfsres(struct svc_r
 int nfssvc_encode_readdirres(struct svc_rqst *, u32 *, struct nfsd_readdirres *);
 
 int nfssvc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino, unsigned int);
+				int namlen, loff_t offset, u64 ino, unsigned int);
 
 int nfssvc_release_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
 
diff --git a/include/linux/nfsd/xdr3.h b/include/linux/nfsd/xdr3.h
--- a/include/linux/nfsd/xdr3.h
+++ b/include/linux/nfsd/xdr3.h
@@ -333,10 +333,10 @@ int nfs3svc_release_fhandle(struct svc_r
 int nfs3svc_release_fhandle2(struct svc_rqst *, u32 *,
 				struct nfsd3_fhandle_pair *);
 int nfs3svc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino,
+				int namlen, loff_t offset, u64 ino,
 				unsigned int);
 int nfs3svc_encode_entry_plus(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino,
+				int namlen, loff_t offset, u64 ino,
 				unsigned int);
 /* Helper functions for NFSv3 ACL code */
 u32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, u32 *p,
