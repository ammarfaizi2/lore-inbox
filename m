Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbSL3GR0>; Mon, 30 Dec 2002 01:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbSL3GR0>; Mon, 30 Dec 2002 01:17:26 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:44457 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266730AbSL3GRQ>;
	Mon, 30 Dec 2002 01:17:16 -0500
Date: Mon, 30 Dec 2002 17:25:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 1/7 PPC64
Message-Id: <20021230172529.3acc863f.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

PPC64 specific stuff ...

This includes that compat_..stat and compat_times calls and fixes a
(pseudo) bug where the compatibility loff_t was defined as int (instead
of signed 64 bit).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/ppc64/kernel/ioctl32.c 2.5.53-32bit.1/arch/ppc64/kernel/ioctl32.c
--- 2.5.53/arch/ppc64/kernel/ioctl32.c	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.53-32bit.1/arch/ppc64/kernel/ioctl32.c	2002-12-30 15:42:02.000000000 +1100
@@ -442,13 +442,13 @@
                 struct  ifmap32 ifru_map;
                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
-                __kernel_caddr_t32 ifru_data;
+                compat_caddr_t ifru_data;
         } ifr_ifru;
 };
 
 struct ifconf32 {
         int     ifc_len;                        /* size of buffer       */
-        __kernel_caddr_t32  ifcbuf;
+        compat_caddr_t  ifcbuf;
 };
 
 #ifdef CONFIG_NET
@@ -884,7 +884,7 @@
 	unsigned char	rate;
 	unsigned char	spec1;
 	unsigned char	fmt_gap;
-	const __kernel_caddr_t32 name;
+	const compat_caddr_t name;
 };
 
 struct floppy_drive_params32 {
@@ -923,7 +923,7 @@
 	int		fd_ref;
 	int		fd_device;
 	int		last_checked;
-	__kernel_caddr_t32 dmabuf;
+	compat_caddr_t dmabuf;
 	int		bufblocks;
 };
 
@@ -1413,7 +1413,7 @@
 }
 
 struct ppp_option_data32 {
-	__kernel_caddr_t32	ptr;
+	compat_caddr_t	ptr;
 	__u32			length;
 	int			transmit;
 };
@@ -1494,8 +1494,8 @@
 	__u32	mt_dsreg;
 	__u32	mt_gstat;
 	__u32	mt_erreg;
-	__kernel_daddr_t32	mt_fileno;
-	__kernel_daddr_t32	mt_blkno;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
 };
 #define MTIOCGET32	_IOR('m', 2, struct mtget32)
 
@@ -1613,7 +1613,7 @@
 
 struct cdrom_read32 {
 	int			cdread_lba;
-	__kernel_caddr_t32	cdread_bufaddr;
+	compat_caddr_t	cdread_bufaddr;
 	int			cdread_buflen;
 };
 
@@ -1621,16 +1621,16 @@
 	union cdrom_addr	addr;
 	u_char			addr_format;
 	int			nframes;
-	__kernel_caddr_t32	buf;
+	compat_caddr_t	buf;
 };
 
 struct cdrom_generic_command32 {
 	unsigned char		cmd[CDROM_PACKET_SIZE];
-	__kernel_caddr_t32	buffer;
+	compat_caddr_t	buffer;
 	unsigned int		buflen;
 	int			stat;
-	__kernel_caddr_t32	sense;
-	__kernel_caddr_t32	reserved[3];
+	compat_caddr_t	sense;
+	compat_caddr_t	reserved[3];
 };
 
 static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -1639,7 +1639,7 @@
 	struct cdrom_read cdread;
 	struct cdrom_read_audio cdreadaudio;
 	struct cdrom_generic_command cgc;
-	__kernel_caddr_t32 addr;
+	compat_caddr_t addr;
 	char *data = 0;
 	void *karg;
 	int err = 0;
@@ -1722,9 +1722,9 @@
 
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
@@ -2054,7 +2054,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (__kernel_uid_t32 *)arg);
+		err = put_user(kuid, (compat_uid_t *)arg);
 
 	return err;
 }
@@ -2062,7 +2062,7 @@
 struct ncp_ioctl_request_32 {
 	unsigned int function;
 	unsigned int size;
-	__kernel_caddr_t32 data;
+	compat_caddr_t data;
 };
 
 struct ncp_fs_info_v2_32 {
@@ -2083,13 +2083,13 @@
 {
 	int		auth_type;
 	unsigned int	object_name_len;
-	__kernel_caddr_t32	object_name;	/* an userspace data, in most cases user name */
+	compat_caddr_t	object_name;	/* an userspace data, in most cases user name */
 };
 
 struct ncp_privatedata_ioctl_32
 {
 	unsigned int	len;
-	__kernel_caddr_t32	data;		/* ~1000 for NDS */
+	compat_caddr_t	data;		/* ~1000 for NDS */
 };
 
 #define	NCP_IOC_NCPREQUEST_32		_IOR('n', 1, struct ncp_ioctl_request_32)
@@ -2362,12 +2362,12 @@
 struct atmif_sioc32 {
         int                number;
         int                length;
-        __kernel_caddr_t32 arg;
+        compat_caddr_t arg;
 };
 
 struct atm_iobuf32 {
 	int                length;
-	__kernel_caddr_t32 buffer;
+	compat_caddr_t buffer;
 };
 
 #define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
@@ -2428,7 +2428,7 @@
 
 	iobuf.length = iobuf32.length;
 
-	if (iobuf32.buffer == (__kernel_caddr_t32) NULL || iobuf32.length == 0) {
+	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
 		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
 	} else {
 		iobuf.buffer = kmalloc(iobuf.length, GFP_KERNEL);
@@ -2482,7 +2482,7 @@
         sioc.number = sioc32.number;
         sioc.length = sioc32.length;
         
-	if (sioc32.arg == (__kernel_caddr_t32) NULL || sioc32.length == 0) {
+	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
 		sioc.arg = (void*)(unsigned long)sioc32.arg;
         } else {
                 sioc.arg = kmalloc(sioc.length, GFP_KERNEL);
@@ -3656,7 +3656,7 @@
 #define HANDLE_IOCTL(cmd,handler) { cmd, (unsigned long)handler, 0 }
 
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 
 static struct ioctl_trans ioctl_translations[] = {
     /* List here explicitly which ioctl's need translation,
diff -ruN 2.5.53/arch/ppc64/kernel/misc.S 2.5.53-32bit.1/arch/ppc64/kernel/misc.S
--- 2.5.53/arch/ppc64/kernel/misc.S	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.53-32bit.1/arch/ppc64/kernel/misc.S	2002-12-16 14:51:53.000000000 +1100
@@ -551,7 +551,7 @@
 	.llong .sys_rmdir		/* 40 */
 	.llong .sys_dup
 	.llong .sys_pipe
-	.llong .sys32_times
+	.llong .compat_sys_times
 	.llong .sys_ni_syscall		/* old prof syscall */
 	.llong .sys_brk			/* 45 */
 	.llong .sys_setgid
@@ -614,9 +614,9 @@
 	.llong .sys32_syslog
 	.llong .compat_sys_setitimer
 	.llong .compat_sys_getitimer		/* 105 */
-	.llong .sys32_newstat
-	.llong .sys32_newlstat
-	.llong .sys32_newfstat
+	.llong .compat_sys_newstat
+	.llong .compat_sys_newlstat
+	.llong .compat_sys_newfstat
 	.llong .sys_uname
 	.llong .sys_ni_syscall		/* 110 old iopl syscall */
 	.llong .sys_vhangup
diff -ruN 2.5.53/arch/ppc64/kernel/sys_ppc32.c 2.5.53-32bit.1/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.53/arch/ppc64/kernel/sys_ppc32.c	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.53-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2002-12-30 16:10:12.000000000 +1100
@@ -300,16 +300,16 @@
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
@@ -380,11 +380,11 @@
 
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
@@ -802,10 +802,13 @@
 	return sys32_select((int)n, inp, outp, exp, tvp_x);
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
@@ -813,8 +816,6 @@
 	err |= put_user(stat->uid, &statbuf->st_uid);
 	err |= put_user(stat->gid, &statbuf->st_gid);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
-	if (stat->size > MAX_NON_LFS)
-		return -EOVERFLOW;
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
 	err |= put_user(0, &statbuf->__unused1);
@@ -830,39 +831,6 @@
 	return err;
 }
 
-asmlinkage long sys32_newstat(char* filename, struct stat32* statbuf)
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
-asmlinkage long sys32_newlstat(char * filename, struct stat32 *statbuf)
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
-asmlinkage long sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
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
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
 {
 	int err;
@@ -1492,27 +1460,27 @@
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
 
@@ -1645,7 +1613,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -1659,7 +1627,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return err;
 }
@@ -2076,37 +2044,6 @@
 }
 
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-extern asmlinkage long sys_times(struct tms * tbuf);
-
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	mm_segment_t old_fs = get_fs ();
-	int err;
-	
-	set_fs (KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs (old_fs);
-	if (tbuf) {
-		err = put_user (t.tms_utime, &tbuf->tms_utime);
-		err |= __put_user (t.tms_stime, &tbuf->tms_stime);
-		err |= __put_user (t.tms_cutime, &tbuf->tms_cutime);
-		err |= __put_user (t.tms_cstime, &tbuf->tms_cstime);
-		if (err)
-			ret = -EFAULT;
-	}
-	
-	return ret;
-}
-
 struct msgbuf32 { s32 mtype; char mtext[1]; };
 
 struct semid_ds32 {
@@ -2144,8 +2081,8 @@
 	unsigned short msg_cbytes;
 	unsigned short msg_qnum;
 	unsigned short msg_qbytes;
-	__kernel_ipc_pid_t32 msg_lspid;
-	__kernel_ipc_pid_t32 msg_lrpid;
+	compat_ipc_pid_t msg_lspid;
+	compat_ipc_pid_t msg_lrpid;
 };
 
 struct msqid64_ds32 {
@@ -2159,8 +2096,8 @@
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
@@ -2171,8 +2108,8 @@
 	compat_time_t shm_atime;
 	compat_time_t shm_dtime;
 	compat_time_t shm_ctime;
-	__kernel_ipc_pid_t32 shm_cpid;
-	__kernel_ipc_pid_t32 shm_lpid;
+	compat_ipc_pid_t shm_cpid;
+	compat_ipc_pid_t shm_lpid;
 	unsigned short shm_nattch;
 	unsigned short __unused;
 	unsigned int __unused2;
@@ -2189,8 +2126,8 @@
 	compat_time_t shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
-	__kernel_pid_t32 shm_cpid;
-	__kernel_pid_t32 shm_lpid;
+	compat_pid_t shm_cpid;
+	compat_pid_t shm_lpid;
 	unsigned int shm_nattch;
 	unsigned int __unused5;
 	unsigned int __unused6;
@@ -2712,7 +2649,7 @@
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
  * and the register representation of a signed int (msr in 64-bit mode) is performed.
  */
-asmlinkage long sys32_sendfile(u32 out_fd, u32 in_fd, __kernel_off_t32* offset, u32 count)
+asmlinkage long sys32_sendfile(u32 out_fd, u32 in_fd, compat_off_t* offset, u32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -2733,7 +2670,7 @@
 
 extern asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile64(int out_fd, int in_fd, __kernel_loff_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile64(int out_fd, int in_fd, compat_loff_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -4296,7 +4233,7 @@
 extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -4320,7 +4257,7 @@
 extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
diff -ruN 2.5.53/include/asm-ppc64/compat.h 2.5.53-32bit.1/include/asm-ppc64/compat.h
--- 2.5.53/include/asm-ppc64/compat.h	2002-12-10 15:10:39.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-ppc64/compat.h	2002-12-30 16:27:03.000000000 +1100
@@ -5,9 +5,25 @@
  */
 #include <linux/types.h>
 
+#define COMPAT_USER_HZ	100
+
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u32		compat_uid_t;
+typedef u32		compat_gid_t;
+typedef u32		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u32		compat_dev_t;
+typedef s32		compat_off_t;
+typedef s64		compat_loff_t;
+typedef s16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -19,4 +35,24 @@
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
+	compat_off_t	st_blksize;
+	compat_off_t	st_blocks;
+	compat_time_t	st_atime;
+	u32		__unused1;
+	compat_time_t	st_mtime;
+	u32		__unused2;
+	compat_time_t	st_ctime;
+	u32		__unused3;
+	u32		__unused4[2];
+};
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.53/include/asm-ppc64/ppc32.h 2.5.53-32bit.1/include/asm-ppc64/ppc32.h
--- 2.5.53/include/asm-ppc64/ppc32.h	2002-12-10 15:10:39.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-ppc64/ppc32.h	2002-12-30 16:27:32.000000000 +1100
@@ -14,11 +14,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef __KERNEL_STRICT_NAMES
-#include <linux/types.h>
-typedef __kernel_fsid_t __kernel_fsid_t32;
-#endif
-
 /* Use this to get at 32-bit user passed pointers. */
 /* Things to consider: the low-level assembly stub does
    srl x, 0, x for first four arguments, so if you have
@@ -44,21 +39,6 @@
 })
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_pid_t32;
-typedef unsigned short	__kernel_ipc_pid_t32;
-typedef unsigned int	__kernel_uid_t32;
-typedef unsigned int	__kernel_gid_t32;
-typedef unsigned int	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned int	__kernel_mode_t32;
-typedef unsigned int	__kernel_umode_t32;
-typedef short		__kernel_nlink_t32;
-typedef int		__kernel_daddr_t32;
-typedef int		__kernel_off_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef int		__kernel_loff_t32;
 
 struct statfs32 {
 	int f_type;
@@ -68,7 +48,7 @@
 	int f_bavail;
 	int f_files;
 	int f_ffree;
-	__kernel_fsid_t32 f_fsid;
+	compat_fsid_t f_fsid;
 	int f_namelen;  /* SunOS ignores this field. */
 	int f_spare[6];
 };
@@ -88,8 +68,8 @@
 
 		/* kill() */
 		struct {
-			__kernel_pid_t32 _pid;		/* sender's pid */
-			__kernel_uid_t32 _uid;		/* sender's uid */
+			compat_pid_t _pid;		/* sender's pid */
+			compat_uid_t _uid;		/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
@@ -100,18 +80,18 @@
 
 		/* POSIX.1b signals */
 		struct {
-			__kernel_pid_t32 _pid;		/* sender's pid */
-			__kernel_uid_t32 _uid;		/* sender's uid */
+			compat_pid_t _pid;		/* sender's pid */
+			compat_uid_t _uid;		/* sender's uid */
 			sigval_t32 _sigval;
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
-			__kernel_pid_t32 _pid;		/* which child */
-			__kernel_uid_t32 _uid;		/* sender's uid */
+			compat_pid_t _pid;		/* which child */
+			compat_uid_t _uid;		/* sender's uid */
 			int _status;			/* exit code */
-			__kernel_clock_t32 _utime;
-			__kernel_clock_t32 _stime;
+			compat_clock_t _utime;
+			compat_clock_t _stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
@@ -164,32 +144,12 @@
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
 
-struct stat32 {
-	__kernel_dev_t32   st_dev; /* 2 */
-	__kernel_ino_t32   st_ino; /* 4  */
-	__kernel_mode_t32  st_mode; /* 2  */
-	short   	   st_nlink; /* 2 */
-	__kernel_uid_t32   st_uid; /* 2 */
-	__kernel_gid_t32   st_gid; /* 2 */
-	__kernel_dev_t32   st_rdev; /* 2 */
-	__kernel_off_t32   st_size; /* 4 */
-	__kernel_off_t32   st_blksize; /* 4 */
-	__kernel_off_t32   st_blocks; /* 4 */
-	compat_time_t    st_atime; /* 4 */
-	unsigned int       __unused1; /* 4 */
-	compat_time_t    st_mtime; /* 4 */
-	unsigned int       __unused2; /* 4 */
-	compat_time_t    st_ctime; /* 4 */
-	unsigned int       __unused3; /* 4 */
-	unsigned int  __unused4[2]; /* 2*4 */
-};
-
 struct sigcontext32 {
 	unsigned int	_unused[4];
 	int		signal;
