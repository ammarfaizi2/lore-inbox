Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbTADGKa>; Sat, 4 Jan 2003 01:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTADGKa>; Sat, 4 Jan 2003 01:10:30 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:51336 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265236AbTADGKU>;
	Sat, 4 Jan 2003 01:10:20 -0500
Date: Sat, 4 Jan 2003 17:18:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] move struct flock32 3/8 sparc64
Message-Id: <20030104171837.3c58af4b.sfr@canb.auug.org.au>
In-Reply-To: <20030103.185628.46335143.davem@redhat.com>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
	<20030103172118.59b24934.sfr@canb.auug.org.au>
	<20030103.185628.46335143.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Fri, 03 Jan 2003 18:56:28 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
> Stephen, where are compat_off_t and compat_pid_t defined
> on sparc64?  I think your patch depends upon some other set
> of changes you've done which haven't been applied yet.

I guessed as much.  Below is my outstanding patch against Linus' recent BK
tree for sparc64.  I sent a previous one with subject "[PATCH][COMPAT]
Eliminate the rest of the __kernel_..._t32 typedefs 2/7 SPARC64" last
Monday, but I guess it got lost in your inbox somewhere (it happens ...).
At the time I also said:

I am not sure if I should be changing the sunos compatibility code
as will as the sparc32 code.  You may want another separate set of
types there.

> Therefore I've just changes your patch to get the build to pass
> properly on sparc64.

Thanks.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301041605/arch/sparc64/kernel/ioctl32.c 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/ioctl32.c
--- 2.5.54-200301041605/arch/sparc64/kernel/ioctl32.c	2002-12-27 15:15:40.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/ioctl32.c	2003-01-03 16:24:15.000000000 +1100
@@ -450,13 +450,13 @@
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
@@ -1009,7 +1009,7 @@
 
 struct fb_fix_screeninfo32 {
 	char			id[16];
-        __kernel_caddr_t32	smem_start;
+        compat_caddr_t	smem_start;
 	__u32			smem_len;
 	__u32			type;
 	__u32			type_aux;
@@ -1018,7 +1018,7 @@
 	__u16			ypanstep;
 	__u16			ywrapstep;
 	__u32			line_length;
-        __kernel_caddr_t32	mmio_start;
+        compat_caddr_t	mmio_start;
 	__u32			mmio_len;
 	__u32			accel;
 	__u16			reserved[3];
@@ -1027,10 +1027,10 @@
 struct fb_cmap32 {
 	__u32			start;
 	__u32			len;
-	__kernel_caddr_t32	red;
-	__kernel_caddr_t32	green;
-	__kernel_caddr_t32	blue;
-	__kernel_caddr_t32	transp;
+	compat_caddr_t	red;
+	compat_caddr_t	green;
+	compat_caddr_t	blue;
+	compat_caddr_t	transp;
 };
 
 static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -1169,7 +1169,7 @@
 	unsigned char	rate;
 	unsigned char	spec1;
 	unsigned char	fmt_gap;
-	const __kernel_caddr_t32 name;
+	const compat_caddr_t name;
 };
 
 struct floppy_drive_params32 {
@@ -1208,7 +1208,7 @@
 	int		fd_ref;
 	int		fd_device;
 	int		last_checked;
-	__kernel_caddr_t32 dmabuf;
+	compat_caddr_t dmabuf;
 	int		bufblocks;
 };
 
@@ -1732,7 +1732,7 @@
 }
 
 struct ppp_option_data32 {
-	__kernel_caddr_t32	ptr;
+	compat_caddr_t	ptr;
 	__u32			length;
 	int			transmit;
 };
@@ -1813,8 +1813,8 @@
 	__u32	mt_dsreg;
 	__u32	mt_gstat;
 	__u32	mt_erreg;
-	__kernel_daddr_t32	mt_fileno;
-	__kernel_daddr_t32	mt_blkno;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
 };
 #define MTIOCGET32	_IOR('m', 2, struct mtget32)
 
@@ -1932,7 +1932,7 @@
 
 struct cdrom_read32 {
 	int			cdread_lba;
-	__kernel_caddr_t32	cdread_bufaddr;
+	compat_caddr_t	cdread_bufaddr;
 	int			cdread_buflen;
 };
 
@@ -1940,16 +1940,16 @@
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
@@ -1958,7 +1958,7 @@
 	struct cdrom_read cdread;
 	struct cdrom_read_audio cdreadaudio;
 	struct cdrom_generic_command cgc;
-	__kernel_caddr_t32 addr;
+	compat_caddr_t addr;
 	char *data = 0;
 	void *karg;
 	int err = 0;
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
@@ -2256,7 +2256,7 @@
 struct ncp_ioctl_request_32 {
 	unsigned int function;
 	unsigned int size;
-	__kernel_caddr_t32 data;
+	compat_caddr_t data;
 };
 
 struct ncp_fs_info_v2_32 {
@@ -2277,13 +2277,13 @@
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
@@ -2557,12 +2557,12 @@
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
@@ -2623,7 +2623,7 @@
 
 	iobuf.length = iobuf32.length;
 
-	if (iobuf32.buffer == (__kernel_caddr_t32) NULL || iobuf32.length == 0) {
+	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
 		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
 	} else {
 		iobuf.buffer = kmalloc(iobuf.length, GFP_KERNEL);
@@ -2677,7 +2677,7 @@
         sioc.number = sioc32.number;
         sioc.length = sioc32.length;
         
-	if (sioc32.arg == (__kernel_caddr_t32) NULL || sioc32.length == 0) {
+	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
 		sioc.arg = (void*)(unsigned long)sioc32.arg;
         } else {
                 sioc.arg = kmalloc(sioc.length, GFP_KERNEL);
@@ -2835,7 +2835,7 @@
 } lv_status_byindex_req32_t;
 
 typedef struct {
-	__kernel_dev_t32 dev;
+	compat_dev_t dev;
 	u32   lv;
 } lv_status_bydev_req32_t;
 
@@ -5128,7 +5128,7 @@
 HANDLE_IOCTL(VIDIOCGFREQ32, do_video_ioctl)
 HANDLE_IOCTL(VIDIOCSFREQ32, do_video_ioctl)
 /* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 /* NCPFS */
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
diff -ruN 2.5.54-200301041605/arch/sparc64/kernel/sunos_ioctl32.c 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sunos_ioctl32.c
--- 2.5.54-200301041605/arch/sparc64/kernel/sunos_ioctl32.c	2000-08-05 11:16:11.000000000 +1000
+++ 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sunos_ioctl32.c	2003-01-03 16:24:15.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/compat.h>
 #include <asm/kbio.h>
 
 /* Use this to get at 32-bit user passed pointers. */
@@ -80,13 +81,13 @@
                 int     ifru_mtu;
                 struct  ifmap32 ifru_map;
                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
-                __kernel_caddr_t32 ifru_data;
+                compat_caddr_t ifru_data;
         } ifr_ifru;
 };
 
 struct ifconf32 {
         int     ifc_len;                        /* size of buffer       */
-        __kernel_caddr_t32  ifcbuf;
+        compat_caddr_t  ifcbuf;
 };
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
diff -ruN 2.5.54-200301041605/arch/sparc64/kernel/sys_sparc32.c 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.54-200301041605/arch/sparc64/kernel/sys_sparc32.c	2003-01-04 16:33:08.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2003-01-04 16:39:48.000000000 +1100
@@ -290,11 +290,11 @@
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
 
@@ -333,8 +333,8 @@
         unsigned short msg_cbytes;
         unsigned short msg_qnum;  
         unsigned short msg_qbytes;
-        __kernel_ipc_pid_t32 msg_lspid;
-        __kernel_ipc_pid_t32 msg_lrpid;
+        compat_ipc_pid_t msg_lspid;
+        compat_ipc_pid_t msg_lrpid;
 };
 
 struct msqid64_ds32 {
@@ -348,8 +348,8 @@
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
@@ -361,8 +361,8 @@
 	compat_time_t         shm_atime;
 	compat_time_t         shm_dtime;
 	compat_time_t         shm_ctime;
-	__kernel_ipc_pid_t32    shm_cpid; 
-	__kernel_ipc_pid_t32    shm_lpid; 
+	compat_ipc_pid_t    shm_cpid; 
+	compat_ipc_pid_t    shm_lpid; 
 	unsigned short          shm_nattch;
 };
 
@@ -375,8 +375,8 @@
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
@@ -1378,6 +1378,9 @@
 {
 	int err;
 
+	if (stat->size > MAX_NON_LFS)
+		return -EOVERFLOW;
+
 	err  = put_user(stat->dev, &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
@@ -1385,8 +1388,6 @@
 	err |= put_user(high2lowuid(stat->uid), &statbuf->st_uid);
 	err |= put_user(high2lowgid(stat->gid), &statbuf->st_gid);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
-	if (stat->size > MAX_NON_LFS)
-		return -EOVERFLOW;
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
 	err |= put_user(0, &statbuf->__unused1);
@@ -1412,16 +1413,16 @@
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
@@ -1492,11 +1493,11 @@
 
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
@@ -1656,7 +1657,7 @@
 	return err;
 }
 
-asmlinkage int sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
+asmlinkage int sys32_wait4(compat_pid_t pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
 {
 	if (!ru)
 		return sys_wait4(pid, stat_addr, options, NULL);
@@ -1718,7 +1719,7 @@
 
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
+asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -3027,27 +3028,27 @@
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
 
@@ -3176,7 +3177,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -3190,7 +3191,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return (err ? -EFAULT : 0);
 }
@@ -3482,7 +3483,7 @@
 
 extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -3503,7 +3504,7 @@
 
 extern asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile64(int out_fd, int in_fd, __kernel_loff_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile64(int out_fd, int in_fd, compat_loff_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -3737,7 +3738,7 @@
 extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -3761,7 +3762,7 @@
 extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
diff -ruN 2.5.54-200301041605/arch/sparc64/kernel/sys_sunos32.c 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.54-200301041605/arch/sparc64/kernel/sys_sunos32.c	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/arch/sparc64/kernel/sys_sunos32.c	2003-01-03 16:24:15.000000000 +1100
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
 
@@ -952,8 +952,8 @@
         unsigned short msg_cbytes;
         unsigned short msg_qnum;  
         unsigned short msg_qbytes;
-        __kernel_ipc_pid_t32 msg_lspid;
-        __kernel_ipc_pid_t32 msg_lrpid;
+        compat_ipc_pid_t msg_lspid;
+        compat_ipc_pid_t msg_lrpid;
 };
 
 static inline int sunos_msqid_get(struct msqid_ds32 *user,
@@ -1084,8 +1084,8 @@
         compat_time_t         shm_atime;
         compat_time_t         shm_dtime;
         compat_time_t         shm_ctime;
-        __kernel_ipc_pid_t32    shm_cpid; 
-        __kernel_ipc_pid_t32    shm_lpid; 
+        compat_ipc_pid_t    shm_cpid; 
+        compat_ipc_pid_t    shm_lpid; 
         unsigned short          shm_nattch;
 };
                                                         
diff -ruN 2.5.54-200301041605/include/asm-sparc64/compat.h 2.5.54-200301041605-32bit.2/include/asm-sparc64/compat.h
--- 2.5.54-200301041605/include/asm-sparc64/compat.h	2003-01-04 16:33:10.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/include/asm-sparc64/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -5,32 +5,25 @@
  */
 #include <linux/types.h>
 
-#define COMPAT_USER_HZ 100
+#define COMPAT_USER_HZ	100
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
-
-struct compat_stat {
-	__kernel_dev_t32	st_dev;
-	__kernel_ino_t32	st_ino;
-	__kernel_mode_t32	st_mode;
-	s16			st_nlink;
-	__kernel_uid_t32	st_uid;
-	__kernel_gid_t32	st_gid;
-	__kernel_dev_t32	st_rdev;
-	__kernel_off_t32	st_size;
-	compat_time_t		st_atime;
-	u32			__unused1;
-	compat_time_t		st_mtime;
-	u32			__unused2;
-	compat_time_t		st_ctime;
-	u32			__unused3;
-	__kernel_off_t32	st_blksize;
-	__kernel_off_t32	st_blocks;
-	u32			__unused4[2];
-};
+typedef s32		compat_pid_t;
+typedef u16		compat_uid_t;
+typedef u16		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u16		compat_dev_t;
+typedef s32		compat_off_t;
+typedef s64		compat_loff_t;
+typedef s16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -42,13 +35,33 @@
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
 struct compat_flock {
-	short			l_type;
-	short			l_whence;
-	__kernel_off_t32	l_start;
-	__kernel_off_t32	l_len;
-	__kernel_pid_t32	l_pid;
-	short			__unused;
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+	short		__unused;
 };
 
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.54-200301041605/include/asm-sparc64/posix_types.h 2.5.54-200301041605-32bit.2/include/asm-sparc64/posix_types.h
--- 2.5.54-200301041605/include/asm-sparc64/posix_types.h	2002-12-27 15:16:02.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/include/asm-sparc64/posix_types.h	2003-01-03 16:24:15.000000000 +1100
@@ -47,23 +47,6 @@
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
-typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef long		       __kernel_loff_t32;
-typedef __kernel_fsid_t        __kernel_fsid_t32;
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.54-200301041605/include/asm-sparc64/siginfo.h 2.5.54-200301041605-32bit.2/include/asm-sparc64/siginfo.h
--- 2.5.54-200301041605/include/asm-sparc64/siginfo.h	2002-12-27 15:16:02.000000000 +1100
+++ 2.5.54-200301041605-32bit.2/include/asm-sparc64/siginfo.h	2003-01-03 16:24:15.000000000 +1100
@@ -13,7 +13,7 @@
 
 #ifdef __KERNEL__
 
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 typedef union sigval32 {
 	int sival_int;
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
diff -ruN 2.5.54-200301041605/include/asm-sparc64/statfs.h 2.5.54-200301041605-32bit.2/include/asm-sparc64/statfs.h
--- 2.5.54-200301041605/include/asm-sparc64/statfs.h	1997-04-24 12:01:28.000000000 +1000
+++ 2.5.54-200301041605-32bit.2/include/asm-sparc64/statfs.h	2003-01-03 16:24:15.000000000 +1100
@@ -5,6 +5,7 @@
 #ifndef __KERNEL_STRICT_NAMES
 
 #include <linux/types.h>
+#include <linux/compat.h>	/* for compat_fsid_t */
 
 typedef __kernel_fsid_t	fsid_t;
 
@@ -18,7 +19,7 @@
 	int f_bavail;
 	int f_files;
 	int f_ffree;
-	__kernel_fsid_t32 f_fsid;
+	compat_fsid_t f_fsid;
 	int f_namelen;  /* SunOS ignores this field. */
 	int f_spare[6];
 };
