Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSLMEf4>; Thu, 12 Dec 2002 23:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSLMEf4>; Thu, 12 Dec 2002 23:35:56 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:28831 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261330AbSLMEfu>;
	Thu, 12 Dec 2002 23:35:50 -0500
Date: Fri, 13 Dec 2002 15:43:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - x86_64
Message-Id: <20021213154332.049bd6b5.sfr@canb.auug.org.au>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here is the x86_64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/arch/x86_64/ia32/ia32_ioctl.c 2.5.51-32bit.2/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.51-32bit.1/arch/x86_64/ia32/ia32_ioctl.c	2002-12-10 15:26:49.000000000 +1100
+++ 2.5.51-32bit.2/arch/x86_64/ia32/ia32_ioctl.c	2002-12-13 14:44:57.000000000 +1100
@@ -1909,9 +1909,9 @@
 
 struct loop_info32 {
 	int			lo_number;      /* ioctl r/o */
-	__kernel_dev_t32	lo_device;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
 	unsigned int		lo_inode;       /* ioctl r/o */
-	__kernel_dev_t32	lo_rdevice;     /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	int			lo_offset;
 	int			lo_encrypt_type;
 	int			lo_encrypt_key_size;    /* ioctl w/o */
@@ -2116,7 +2116,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (__kernel_uid_t32 *)arg);
+		err = put_user(kuid, (compat_pid_t *)arg);
 
 	return err;
 }
@@ -3487,7 +3487,7 @@
 
 struct dirent32 {
 	unsigned int		d_ino;
-	__kernel_off_t32	d_off;
+	compat_off_t	d_off;
 	unsigned short	d_reclen;
 	char		d_name[256]; /* We must not include limits.h! */
 };
@@ -4937,7 +4937,7 @@
 HANDLE_IOCTL(VIDIOCGFREQ32, do_video_ioctl)
 HANDLE_IOCTL(VIDIOCSFREQ32, do_video_ioctl)
 /* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_pid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
 HANDLE_IOCTL(ATM_GETNAMES32, do_atm_ioctl)
diff -ruN 2.5.51-32bit.1/arch/x86_64/ia32/ia32entry.S 2.5.51-32bit.2/arch/x86_64/ia32/ia32entry.S
--- 2.5.51-32bit.1/arch/x86_64/ia32/ia32entry.S	2002-12-10 17:07:24.000000000 +1100
+++ 2.5.51-32bit.2/arch/x86_64/ia32/ia32entry.S	2002-12-13 14:57:15.000000000 +1100
@@ -227,9 +227,9 @@
 	.quad sys_syslog
 	.quad compat_sys_setitimer
 	.quad compat_sys_getitimer	/* 105 */
-	.quad sys32_newstat
-	.quad sys32_newlstat
-	.quad sys32_newfstat
+	.quad compat_sys_newstat
+	.quad compat_sys_newlstat
+	.quad compat_sys_newfstat
 	.quad sys32_uname
 	.quad stub32_iopl		/* 110 */
 	.quad sys_vhangup
diff -ruN 2.5.51-32bit.1/arch/x86_64/ia32/ipc32.c 2.5.51-32bit.2/arch/x86_64/ia32/ipc32.c
--- 2.5.51-32bit.1/arch/x86_64/ia32/ipc32.c	2002-12-10 15:26:49.000000000 +1100
+++ 2.5.51-32bit.2/arch/x86_64/ia32/ipc32.c	2002-12-12 13:43:57.000000000 +1100
@@ -30,10 +30,10 @@
 
 struct ipc_perm32 {
 	int key;
-	__kernel_uid_t32 uid;
-	__kernel_gid_t32 gid;
-	__kernel_uid_t32 cuid;
-	__kernel_gid_t32 cgid;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_uid_t cuid;
+	compat_gid_t cgid;
 	unsigned short mode;
 	unsigned short seq;
 };
@@ -101,8 +101,8 @@
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
 	unsigned int msg_qbytes;
-	__kernel_pid_t32 msg_lspid;
-	__kernel_pid_t32 msg_lrpid;
+	compat_pid_t msg_lspid;
+	compat_pid_t msg_lrpid;
 	unsigned int __unused4;
 	unsigned int __unused5;
 };
@@ -127,8 +127,8 @@
 	unsigned int __unused2;
 	compat_time_t shm_ctime;
 	unsigned int __unused3;
-	__kernel_pid_t32 shm_cpid;
-	__kernel_pid_t32 shm_lpid;
+	compat_pid_t shm_cpid;
+	compat_pid_t shm_lpid;
 	unsigned int shm_nattch;
 	unsigned int __unused4;
 	unsigned int __unused5;
diff -ruN 2.5.51-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.51-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.51-32bit.1/arch/x86_64/ia32/sys_ia32.c	2002-12-10 17:07:52.000000000 +1100
+++ 2.5.51-32bit.2/arch/x86_64/ia32/sys_ia32.c	2002-12-13 14:45:03.000000000 +1100
@@ -86,10 +86,9 @@
 extern int overflowuid,overflowgid; 
 
 
-static int
-putstat(struct stat32 *ubuf, struct stat *kbuf)
+int cp_compat_stat(struct kstat *kbuf, struct compat_stat *ubuf)
 {
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(struct stat32)) ||
+	if (verify_area(VERIFY_WRITE, ubuf, sizeof(struct compat_stat)) ||
 	    __put_user (kbuf->st_dev, &ubuf->st_dev) ||
 	    __put_user (kbuf->st_ino, &ubuf->st_ino) ||
 	    __put_user (kbuf->st_mode, &ubuf->st_mode) ||
@@ -107,57 +106,6 @@
 	return 0;
 }
 
-extern asmlinkage long sys_newstat(char * filename, struct stat * statbuf);
-
-asmlinkage long
-sys32_newstat(char * filename, struct stat32 *statbuf)
-{
-	int ret;
-	struct stat s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_newstat(filename, &s);
-	set_fs (old_fs);
-	if (putstat (statbuf, &s))
-		return -EFAULT;
-	return ret;
-}
-
-extern asmlinkage long sys_newlstat(char * filename, struct stat * statbuf);
-
-asmlinkage long
-sys32_newlstat(char * filename, struct stat32 *statbuf)
-{
-	int ret;
-	struct stat s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_newlstat(filename, &s);
-	set_fs (old_fs);
-	if (putstat (statbuf, &s))
-		return -EFAULT;
-	return ret;
-}
-
-extern asmlinkage long sys_newfstat(unsigned int fd, struct stat * statbuf);
-
-asmlinkage long
-sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
-{
-	int ret;
-	struct stat s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_newfstat(fd, &s);
-	set_fs (old_fs);
-	if (putstat (statbuf, &s))
-		return -EFAULT;
-	return ret;
-}
-
 /* Another set for IA32/LFS -- x86_64 struct stat is different due to 
    support for 64bit inode numbers. */
 
@@ -1062,7 +1010,7 @@
 				int options, struct rusage * ru);
 
 asmlinkage long
-sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options,
+sys32_wait4(compat_pid_t pid, unsigned int *stat_addr, int options,
 	    struct rusage32 *ru)
 {
 	if (!ru)
@@ -1084,7 +1032,7 @@
 }
 
 asmlinkage long
-sys32_waitpid(__kernel_pid_t32 pid, unsigned int *stat_addr, int options)
+sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
 {
 	return sys32_wait4(pid, stat_addr, options, NULL);
 }
@@ -1326,7 +1274,7 @@
 						struct timespec *interval);
 
 asmlinkage long
-sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
+sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1686,7 +1634,7 @@
 				       size_t count); 
 
 asmlinkage long
-sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -2030,27 +1978,27 @@
 struct nfsctl_export32 {
 	s8			ex32_client[NFSCLNT_IDMAX+1];
 	s8			ex32_path[NFS_MAXPATHLEN+1];
-	__kernel_dev_t32	ex32_dev;
-	__kernel_ino_t32	ex32_ino;
+	compat_dev_t	ex32_dev;
+	compat_ino_t	ex32_ino;
 	s32			ex32_flags;
-	__kernel_uid_t32	ex32_anon_uid;
-	__kernel_gid_t32	ex32_anon_gid;
+	compat_pid_t	ex32_anon_uid;
+	compat_gid_t	ex32_anon_gid;
 };
 
 struct nfsctl_uidmap32 {
 	u32			ug32_ident;   /* char * */
-	__kernel_uid_t32	ug32_uidbase;
+	compat_pid_t	ug32_uidbase;
 	s32			ug32_uidlen;
 	u32			ug32_udimap;  /* uid_t * */
-	__kernel_uid_t32	ug32_gidbase;
+	compat_pid_t	ug32_gidbase;
 	s32			ug32_gidlen;
 	u32			ug32_gdimap;  /* gid_t * */
 };
 
 struct nfsctl_fhparm32 {
 	struct sockaddr		gf32_addr;
-	__kernel_dev_t32	gf32_dev;
-	__kernel_ino_t32	gf32_ino;
+	compat_dev_t	gf32_dev;
+	compat_ino_t	gf32_ino;
 	s32			gf32_version;
 };
 
@@ -2179,7 +2127,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_pid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -2193,7 +2141,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return err;
 }
diff -ruN 2.5.51-32bit.1/include/asm-x86_64/compat.h 2.5.51-32bit.2/include/asm-x86_64/compat.h
--- 2.5.51-32bit.1/include/asm-x86_64/compat.h	2002-12-10 16:38:26.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-x86_64/compat.h	2002-12-12 16:52:38.000000000 +1100
@@ -11,6 +11,14 @@
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u16		compat_uid_t;
+typedef u16		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u16		compat_dev_t;
+typedef s32		compat_off_t;
+typedef u16		compat_nlink_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -22,4 +30,27 @@
 	s32		tv_usec;
 };
 
+struct compat_stat {
+	compat_dev_t	st_dev;
+	u16		__pad1;
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	compat_dev_t	st_rdev;
+	u16		__pad2;
+	u32		st_size;
+	u32		st_blksize;
+	u32		st_blocks;
+	u32		st_atime;
+	u32		__unused1;
+	u32		st_mtime;
+	u32		__unused2;
+	u32		st_ctime;
+	u32		__unused3;
+	u32		__unused4;
+	u32		__unused5;
+};
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.51-32bit.1/include/asm-x86_64/ia32.h 2.5.51-32bit.2/include/asm-x86_64/ia32.h
--- 2.5.51-32bit.1/include/asm-x86_64/ia32.h	2002-12-10 15:44:49.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-x86_64/ia32.h	2002-12-12 16:51:29.000000000 +1100
@@ -5,26 +5,18 @@
 
 #ifdef CONFIG_IA32_EMULATION
 
-#include <compat.h>
+#include <linux/compat.h>
 
 /*
  * 32 bit structures for IA32 support.
  */
 
 /* 32bit compatibility types */
-typedef int		       __kernel_pid_t32;
 typedef unsigned short	       __kernel_ipc_pid_t32;
-typedef unsigned short	       __kernel_uid_t32;
 typedef unsigned 				__kernel_uid32_t32;
-typedef unsigned short	       __kernel_gid_t32;
 typedef unsigned 				__kernel_gid32_t32;
-typedef unsigned short	       __kernel_dev_t32;
-typedef unsigned int	       __kernel_ino_t32;
-typedef unsigned short	       __kernel_mode_t32;
 typedef unsigned short	       __kernel_umode_t32;
-typedef short		       __kernel_nlink_t32;
 typedef int		       __kernel_daddr_t32;
-typedef int		       __kernel_off_t32;
 typedef unsigned int	       __kernel_caddr_t32;
 typedef long		       __kernel_loff_t32;
 typedef __kernel_fsid_t	       __kernel_fsid_t32;
@@ -34,9 +26,9 @@
 struct flock32 {
        short l_type;
        short l_whence;
-       __kernel_off_t32 l_start;
-       __kernel_off_t32 l_len;
-       __kernel_pid_t32 l_pid;
+       compat_off_t l_start;
+       compat_off_t l_len;
+       compat_pid_t l_pid;
 };
 
 
@@ -95,30 +87,6 @@
 	sigset32_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
-struct stat32 {
-       unsigned short st_dev;
-       unsigned short __pad1;
-       unsigned int st_ino;
-       unsigned short st_mode;
-       unsigned short st_nlink;
-       unsigned short st_uid;
-       unsigned short st_gid;
-       unsigned short st_rdev;
-       unsigned short __pad2;
-       unsigned int  st_size;
-       unsigned int  st_blksize;
-       unsigned int  st_blocks;
-       unsigned int  st_atime;
-       unsigned int  __unused1;
-       unsigned int  st_mtime;
-       unsigned int  __unused2;
-       unsigned int  st_ctime;
-       unsigned int  __unused3;
-       unsigned int  __unused4;
-       unsigned int  __unused5;
-};
-
-
 /* This matches struct stat64 in glibc2.2, hence the absolutely
  * insane amounts of padding around dev_t's.
  */
@@ -221,7 +189,7 @@
 
 struct ustat32 {
 	__u32	f_tfree;
-	__kernel_ino_t32		f_tinode;
+	compat_ino_t		f_tinode;
 	char			f_fname[6];
 	char			f_fpack[6];
 };
