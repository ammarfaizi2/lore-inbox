Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSLMEcL>; Thu, 12 Dec 2002 23:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSLMEcL>; Thu, 12 Dec 2002 23:32:11 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8607 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261321AbSLMEcB>;
	Thu, 12 Dec 2002 23:32:01 -0500
Date: Fri, 13 Dec 2002 15:39:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - sparc64
Message-Id: <20021213153946.108a904f.sfr@canb.auug.org.au>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This is the sparc64 part if the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/arch/sparc64/kernel/ioctl32.c 2.5.51-32bit.2/arch/sparc64/kernel/ioctl32.c
--- 2.5.51-32bit.1/arch/sparc64/kernel/ioctl32.c	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.51-32bit.2/arch/sparc64/kernel/ioctl32.c	2002-12-13 14:44:35.000000000 +1100
@@ -2041,9 +2041,9 @@
 
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
@@ -2248,7 +2248,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (__kernel_uid_t32 *)arg);
+		err = put_user(kuid, (compat_uid_t *)arg);
 
 	return err;
 }
@@ -2835,7 +2835,7 @@
 } lv_status_byindex_req32_t;
 
 typedef struct {
-	__kernel_dev_t32 dev;
+	compat_dev_t dev;
 	u32   lv;
 } lv_status_bydev_req32_t;
 
@@ -5133,7 +5133,7 @@
 HANDLE_IOCTL(VIDIOCGFREQ32, do_video_ioctl)
 HANDLE_IOCTL(VIDIOCSFREQ32, do_video_ioctl)
 /* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 /* NCPFS */
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
diff -ruN 2.5.51-32bit.1/arch/sparc64/kernel/sys_sparc32.c 2.5.51-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.51-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2002-12-10 17:06:24.000000000 +1100
+++ 2.5.51-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2002-12-13 14:44:40.000000000 +1100
@@ -289,11 +289,11 @@
 struct ipc_perm32
 {
 	key_t    	  key;
-        __kernel_uid_t32  uid;
-        __kernel_gid_t32  gid;
-        __kernel_uid_t32  cuid;
-        __kernel_gid_t32  cgid;
-        __kernel_mode_t32 mode;
+        compat_uid_t  uid;
+        compat_gid_t  gid;
+        compat_uid_t  cuid;
+        compat_gid_t  cgid;
+        compat_mode_t mode;
         unsigned short  seq;
 };
 
@@ -347,8 +347,8 @@
 	unsigned int  msg_cbytes;
 	unsigned int  msg_qnum;
 	unsigned int  msg_qbytes;
-	__kernel_pid_t32 msg_lspid;
-	__kernel_pid_t32 msg_lrpid;
+	compat_pid_t msg_lspid;
+	compat_pid_t msg_lrpid;
 	unsigned int  __unused1;
 	unsigned int  __unused2;
 };
@@ -374,8 +374,8 @@
 	unsigned int		__pad3;
 	compat_time_t  	shm_ctime;
 	compat_size_t	shm_segsz;
-	__kernel_pid_t32	shm_cpid;
-	__kernel_pid_t32	shm_lpid;
+	compat_pid_t	shm_cpid;
+	compat_pid_t	shm_lpid;
 	unsigned int		shm_nattch;
 	unsigned int		__unused1;
 	unsigned int		__unused2;
@@ -1397,10 +1397,13 @@
 	return ret;
 }
 
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
 
+	if (stat->size > MAX_NON_LFS)
+		return -EOVERFLOW;
+
 	err  = put_user(stat->dev, &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
@@ -1408,8 +1411,6 @@
 	err |= put_user(high2lowuid(stat->uid), &statbuf->st_uid);
 	err |= put_user(high2lowgid(stat->gid), &statbuf->st_gid);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
-	if (stat->size > MAX_NON_LFS)
-		return -EOVERFLOW;
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
 	err |= put_user(0, &statbuf->__unused1);
@@ -1425,39 +1426,6 @@
 	return err;
 }
 
-asmlinkage int sys32_newstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
-asmlinkage int sys32_newlstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
-asmlinkage int sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_fstat(fd, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
 extern asmlinkage int sys_sysfs(int option, unsigned long arg1, unsigned long arg2);
 
 asmlinkage int sys32_sysfs(int option, u32 arg1, u32 arg2)
@@ -1468,16 +1436,16 @@
 struct ncp_mount_data32_v3 {
         int version;
         unsigned int ncp_fd;
-        __kernel_uid_t32 mounted_uid;
-        __kernel_pid_t32 wdog_pid;
+        compat_uid_t mounted_uid;
+        compat_pid_t wdog_pid;
         unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
         unsigned int time_out;
         unsigned int retry_count;
         unsigned int flags;
-        __kernel_uid_t32 uid;
-        __kernel_gid_t32 gid;
-        __kernel_mode_t32 file_mode;
-        __kernel_mode_t32 dir_mode;
+        compat_uid_t uid;
+        compat_gid_t gid;
+        compat_mode_t file_mode;
+        compat_mode_t dir_mode;
 };
 
 struct ncp_mount_data32_v4 {
@@ -1548,11 +1516,11 @@
 
 struct smb_mount_data32 {
         int version;
-        __kernel_uid_t32 mounted_uid;
-        __kernel_uid_t32 uid;
-        __kernel_gid_t32 gid;
-        __kernel_mode_t32 file_mode;
-        __kernel_mode_t32 dir_mode;
+        compat_uid_t mounted_uid;
+        compat_uid_t uid;
+        compat_gid_t gid;
+        compat_mode_t file_mode;
+        compat_mode_t dir_mode;
 };
 
 static void *do_smb_super_data_conv(void *raw_data)
@@ -1712,7 +1680,7 @@
 	return err;
 }
 
-asmlinkage int sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
+asmlinkage int sys32_wait4(compat_pid_t pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
 {
 	if (!ru)
 		return sys_wait4(pid, stat_addr, options, NULL);
@@ -1774,7 +1742,7 @@
 
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
+asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -3083,27 +3051,27 @@
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
+	compat_uid_t	ex32_anon_uid;
+	compat_gid_t	ex32_anon_gid;
 };
 
 struct nfsctl_uidmap32 {
 	u32			ug32_ident;   /* char * */
-	__kernel_uid_t32	ug32_uidbase;
+	compat_uid_t	ug32_uidbase;
 	s32			ug32_uidlen;
 	u32			ug32_udimap;  /* uid_t * */
-	__kernel_uid_t32	ug32_gidbase;
+	compat_uid_t	ug32_gidbase;
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
 
@@ -3232,7 +3200,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -3246,7 +3214,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return (err ? -EFAULT : 0);
 }
@@ -3540,7 +3508,7 @@
 
 extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -3795,7 +3763,7 @@
 extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -3819,7 +3787,7 @@
 extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
diff -ruN 2.5.51-32bit.1/arch/sparc64/kernel/sys_sunos32.c 2.5.51-32bit.2/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.51-32bit.1/arch/sparc64/kernel/sys_sunos32.c	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.51-32bit.2/arch/sparc64/kernel/sys_sunos32.c	2002-12-12 13:53:26.000000000 +1100
@@ -798,14 +798,14 @@
 }
 
 /* So stupid... */
-extern asmlinkage int sys32_wait4(__kernel_pid_t32 pid,
+extern asmlinkage int sys32_wait4(compat_pid_t pid,
 				  u32 stat_addr, int options, u32 ru);
 
-asmlinkage int sunos_wait4(__kernel_pid_t32 pid, u32 stat_addr, int options, u32 ru)
+asmlinkage int sunos_wait4(compat_pid_t pid, u32 stat_addr, int options, u32 ru)
 {
 	int ret;
 
-	ret = sys32_wait4((pid ? pid : ((__kernel_pid_t32)-1)),
+	ret = sys32_wait4((pid ? pid : ((compat_pid_t)-1)),
 			  stat_addr, options, ru);
 	return ret;
 }
@@ -931,11 +931,11 @@
 struct ipc_perm32
 {
 	key_t    	  key;
-        __kernel_uid_t32  uid;
-        __kernel_gid_t32  gid;
-        __kernel_uid_t32  cuid;
-        __kernel_gid_t32  cgid;
-        __kernel_mode_t32 mode;
+        compat_uid_t  uid;
+        compat_gid_t  gid;
+        compat_uid_t  cuid;
+        compat_gid_t  cgid;
+        compat_mode_t mode;
         unsigned short  seq;
 };
 
diff -ruN 2.5.51-32bit.1/arch/sparc64/kernel/systbls.S 2.5.51-32bit.2/arch/sparc64/kernel/systbls.S
--- 2.5.51-32bit.1/arch/sparc64/kernel/systbls.S	2002-12-10 17:06:07.000000000 +1100
+++ 2.5.51-32bit.2/arch/sparc64/kernel/systbls.S	2002-12-13 14:56:51.000000000 +1100
@@ -26,12 +26,12 @@
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys32_setuid16, sys32_getuid16
 /*25*/	.word sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
 /*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys_access, sys_nice
-	.word sys_chown, sys_sync, sys_kill, sys32_newstat, sys32_sendfile
-/*40*/	.word sys32_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
+	.word sys_chown, sys_sync, sys_kill, compat_sys_newstat, sys32_sendfile
+/*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
 /*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, sys32_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
-/*60*/	.word sys_umask, sys_chroot, sys32_newfstat, sys_fstat64, sys_getpagesize
+/*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys32_mmap, sys_setreuid, sys_munmap, sys_mprotect
 	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
@@ -150,8 +150,8 @@
 	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sys_access, sunos_nosys, sunos_nosys
-	.word sys_sync, sys_kill, sys32_newstat
-	.word sunos_nosys, sys32_newlstat, sys_dup
+	.word sys_sync, sys_kill, compat_sys_newstat
+	.word sunos_nosys, compat_sys_newlstat, sys_dup
 	.word sys_pipe, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_getgid
 	.word sunos_nosys, sunos_nosys
@@ -159,7 +159,7 @@
 	.word sunos_mctl, sunos_ioctl, sys_reboot
 	.word sunos_nosys, sys_symlink, sys_readlink
 	.word sys32_execve, sys_umask, sys_chroot
-	.word sys32_newfstat, sunos_nosys, sys_getpagesize
+	.word compat_sys_newfstat, sunos_nosys, sys_getpagesize
 	.word sys_msync, sys_vfork, sunos_nosys
 	.word sunos_nosys, sunos_sbrk, sunos_sstk
 	.word sunos_mmap, sunos_vadvise, sys_munmap
diff -ruN 2.5.51-32bit.1/include/asm-sparc64/compat.h 2.5.51-32bit.2/include/asm-sparc64/compat.h
--- 2.5.51-32bit.1/include/asm-sparc64/compat.h	2002-12-10 16:38:22.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-sparc64/compat.h	2002-12-12 16:17:41.000000000 +1100
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
+typedef s16		compat_nlink_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -22,4 +30,24 @@
 	s32		tv_usec;
 };
 
+struct compat_stat {
+	compat_dev_t	st_dev;
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	compat_dev_t	st_rdev;
+	compat_off_t	st_size;
+	compat_time_t	st_atime;
+	u32		__unused1;
+	compat_time_t	st_mtime;
+	u32		__unused2;
+	compat_time_t	st_ctime;
+	u32		__unused3;
+	compat_off_t	st_blksize;
+	compat_off_t	st_blocks;
+	u32		__unused4[2];
+};
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.51-32bit.1/include/asm-sparc64/fcntl.h 2.5.51-32bit.2/include/asm-sparc64/fcntl.h
--- 2.5.51-32bit.1/include/asm-sparc64/fcntl.h	2001-09-21 07:11:58.000000000 +1000
+++ 2.5.51-32bit.2/include/asm-sparc64/fcntl.h	2002-12-12 14:48:45.000000000 +1100
@@ -79,12 +79,14 @@
 };
 
 #ifdef __KERNEL__
+#include <linux/compat.h>
+
 struct flock32 {
 	short l_type;
 	short l_whence;
-	__kernel_off_t32 l_start;
-	__kernel_off_t32 l_len;
-	__kernel_pid_t32 l_pid;
+	compat_off_t l_start;
+	compat_off_t l_len;
+	compat_pid_t l_pid;
 	short __unused;
 };
 #endif
diff -ruN 2.5.51-32bit.1/include/asm-sparc64/posix_types.h 2.5.51-32bit.2/include/asm-sparc64/posix_types.h
--- 2.5.51-32bit.1/include/asm-sparc64/posix_types.h	2002-12-10 15:42:57.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-sparc64/posix_types.h	2002-12-12 16:15:40.000000000 +1100
@@ -48,17 +48,9 @@
 } __kernel_fsid_t;
 
 /* Now 32bit compatibility types */
-typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
 typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
 typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
 typedef unsigned int           __kernel_caddr_t32;
 typedef long		       __kernel_loff_t32;
 typedef __kernel_fsid_t        __kernel_fsid_t32;
diff -ruN 2.5.51-32bit.1/include/asm-sparc64/siginfo.h 2.5.51-32bit.2/include/asm-sparc64/siginfo.h
--- 2.5.51-32bit.1/include/asm-sparc64/siginfo.h	2002-12-10 15:43:53.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-sparc64/siginfo.h	2002-12-12 11:28:48.000000000 +1100
@@ -30,7 +30,7 @@
 
 		/* kill() */
 		struct {
-			__kernel_pid_t32 _pid;		/* sender's pid */
+			compat_pid_t _pid;		/* sender's pid */
 			unsigned int _uid;		/* sender's uid */
 		} _kill;
 
@@ -42,14 +42,14 @@
 
 		/* POSIX.1b signals */
 		struct {
-			__kernel_pid_t32 _pid;		/* sender's pid */
+			compat_pid_t _pid;		/* sender's pid */
 			unsigned int _uid;		/* sender's uid */
 			sigval_t32 _sigval;
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
-			__kernel_pid_t32 _pid;		/* which child */
+			compat_pid_t _pid;		/* which child */
 			unsigned int _uid;		/* sender's uid */
 			int _status;			/* exit code */
 			compat_clock_t _utime;
diff -ruN 2.5.51-32bit.1/include/asm-sparc64/stat.h 2.5.51-32bit.2/include/asm-sparc64/stat.h
--- 2.5.51-32bit.1/include/asm-sparc64/stat.h	2002-12-10 15:10:40.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-sparc64/stat.h	2002-12-12 15:22:10.000000000 +1100
@@ -3,29 +3,8 @@
 #define _SPARC64_STAT_H
 
 #include <linux/types.h>
-#include <linux/compat.h>
 #include <linux/time.h>
 
-struct stat32 {
-	__kernel_dev_t32   st_dev;
-	__kernel_ino_t32   st_ino;
-	__kernel_mode_t32  st_mode;
-	short   	   st_nlink;
-	__kernel_uid_t32   st_uid;
-	__kernel_gid_t32   st_gid;
-	__kernel_dev_t32   st_rdev;
-	__kernel_off_t32   st_size;
-	compat_time_t    st_atime;
-	unsigned int       __unused1;
-	compat_time_t    st_mtime;
-	unsigned int       __unused2;
-	compat_time_t    st_ctime;
-	unsigned int       __unused3;
-	__kernel_off_t32   st_blksize;
-	__kernel_off_t32   st_blocks;
-	unsigned int  __unused4[2];
-};
-
 struct stat {
 	dev_t   st_dev;
 	ino_t   st_ino;
