Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbSL3GZu>; Mon, 30 Dec 2002 01:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbSL3GZu>; Mon, 30 Dec 2002 01:25:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:10666 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266733AbSL3GZo>;
	Mon, 30 Dec 2002 01:25:44 -0500
Date: Mon, 30 Dec 2002 17:33:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 3/7 X86_64
Message-Id: <20021230173359.29275b9e.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

X86_64 specific stuff ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/x86_64/ia32/ia32_ioctl.c 2.5.53-32bit.1/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.53/arch/x86_64/ia32/ia32_ioctl.c	2002-12-27 15:15:41.000000000 +1100
+++ 2.5.53-32bit.1/arch/x86_64/ia32/ia32_ioctl.c	2002-12-30 15:42:35.000000000 +1100
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
@@ -876,7 +876,7 @@
 
 struct fb_fix_screeninfo32 {
 	char			id[16];
-        __kernel_caddr_t32	smem_start;
+        compat_caddr_t	smem_start;
 	__u32			smem_len;
 	__u32			type;
 	__u32			type_aux;
@@ -885,7 +885,7 @@
 	__u16			ypanstep;
 	__u16			ywrapstep;
 	__u32			line_length;
-        __kernel_caddr_t32	mmio_start;
+        compat_caddr_t	mmio_start;
 	__u32			mmio_len;
 	__u32			accel;
 	__u16			reserved[3];
@@ -894,10 +894,10 @@
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
@@ -1036,7 +1036,7 @@
 	unsigned char	rate;
 	unsigned char	spec1;
 	unsigned char	fmt_gap;
-	const __kernel_caddr_t32 name;
+	const compat_caddr_t name;
 };
 
 struct floppy_drive_params32 {
@@ -1075,7 +1075,7 @@
 	int		fd_ref;
 	int		fd_device;
 	int		last_checked;
-	__kernel_caddr_t32 dmabuf;
+	compat_caddr_t dmabuf;
 	int		bufblocks;
 };
 
@@ -1600,7 +1600,7 @@
 }
 
 struct ppp_option_data32 {
-	__kernel_caddr_t32	ptr;
+	compat_caddr_t	ptr;
 	__u32			length;
 	int			transmit;
 };
@@ -1681,8 +1681,8 @@
 	__u32	mt_dsreg;
 	__u32	mt_gstat;
 	__u32	mt_erreg;
-	__kernel_daddr_t32	mt_fileno;
-	__kernel_daddr_t32	mt_blkno;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
 };
 #define MTIOCGET32	_IOR('m', 2, struct mtget32)
 
@@ -1800,7 +1800,7 @@
 
 struct cdrom_read32 {
 	int			cdread_lba;
-	__kernel_caddr_t32	cdread_bufaddr;
+	compat_caddr_t	cdread_bufaddr;
 	int			cdread_buflen;
 };
 
@@ -1808,16 +1808,16 @@
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
@@ -1826,7 +1826,7 @@
 	struct cdrom_read cdread;
 	struct cdrom_read_audio cdreadaudio;
 	struct cdrom_generic_command cgc;
-	__kernel_caddr_t32 addr;
+	compat_caddr_t addr;
 	char *data = 0;
 	void *karg;
 	int err = 0;
@@ -2124,12 +2124,12 @@
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
@@ -2190,7 +2190,7 @@
 
 	iobuf.length = iobuf32.length;
 
-	if (iobuf32.buffer == (__kernel_caddr_t32) NULL || iobuf32.length == 0) {
+	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
 		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
 	} else {
 		iobuf.buffer = kmalloc(iobuf.length, GFP_KERNEL);
@@ -2244,7 +2244,7 @@
         sioc.number = sioc32.number;
         sioc.length = sioc32.length;
         
-	if (sioc32.arg == (__kernel_caddr_t32) NULL || sioc32.length == 0) {
+	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
 		sioc.arg = (void*)(unsigned long)sioc32.arg;
         } else {
                 sioc.arg = kmalloc(sioc.length, GFP_KERNEL);
diff -ruN 2.5.53/arch/x86_64/ia32/ipc32.c 2.5.53-32bit.1/arch/x86_64/ia32/ipc32.c
--- 2.5.53/arch/x86_64/ia32/ipc32.c	2002-12-27 15:15:41.000000000 +1100
+++ 2.5.53-32bit.1/arch/x86_64/ia32/ipc32.c	2002-12-30 16:33:41.000000000 +1100
@@ -40,10 +40,10 @@
 
 struct ipc64_perm32 {
         unsigned key;
-	__kernel_uid32_t32 uid;
-	__kernel_gid32_t32 gid;
-	__kernel_uid32_t32 cuid;
-	__kernel_gid32_t32 cgid;
+	compat_uid32_t uid;
+	compat_gid32_t gid;
+	compat_uid32_t cuid;
+	compat_gid32_t cgid;
 	unsigned short mode;
 	unsigned short __pad1;
 	unsigned short seq;
@@ -86,8 +86,8 @@
 	unsigned short msg_cbytes;
 	unsigned short msg_qnum;
 	unsigned short msg_qbytes;
-	__kernel_ipc_pid_t32 msg_lspid;
-	__kernel_ipc_pid_t32 msg_lrpid;
+	compat_ipc_pid_t msg_lspid;
+	compat_ipc_pid_t msg_lrpid;
 };
 
 struct msqid64_ds32 {
@@ -113,8 +113,8 @@
 	compat_time_t shm_atime;
 	compat_time_t shm_dtime;
 	compat_time_t shm_ctime;
-	__kernel_ipc_pid_t32 shm_cpid;
-	__kernel_ipc_pid_t32 shm_lpid;
+	compat_ipc_pid_t shm_cpid;
+	compat_ipc_pid_t shm_lpid;
 	unsigned short shm_nattch;
 };
 
diff -ruN 2.5.53/include/asm-x86_64/compat.h 2.5.53-32bit.1/include/asm-x86_64/compat.h
--- 2.5.53/include/asm-x86_64/compat.h	2002-12-27 15:16:02.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-x86_64/compat.h	2002-12-30 16:32:03.000000000 +1100
@@ -10,16 +10,22 @@
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
-typedef s32		compat_suseconds_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		compat_uid_t;
 typedef u16		compat_gid_t;
+typedef u32		compat_uid32_t;
+typedef u32		compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
 typedef s32		compat_off_t;
+typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.53/include/asm-x86_64/ia32.h 2.5.53-32bit.1/include/asm-x86_64/ia32.h
--- 2.5.53/include/asm-x86_64/ia32.h	2002-12-27 15:16:02.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-x86_64/ia32.h	2002-12-30 16:32:19.000000000 +1100
@@ -11,17 +11,6 @@
  * 32 bit structures for IA32 support.
  */
 
-/* 32bit compatibility types */
-typedef unsigned short	       __kernel_ipc_pid_t32;
-typedef unsigned 				__kernel_uid32_t32;
-typedef unsigned 				__kernel_gid32_t32;
-typedef unsigned short	       __kernel_umode_t32;
-typedef int		       __kernel_daddr_t32;
-typedef unsigned int	       __kernel_caddr_t32;
-typedef long		       __kernel_loff_t32;
-typedef __kernel_fsid_t	       __kernel_fsid_t32;
-
-
 /* fcntl.h */
 struct flock32 {
        short l_type;
@@ -130,7 +119,7 @@
        int f_bavail;
        int f_files;
        int f_ffree;
-       __kernel_fsid_t32 f_fsid;
+       compat_fsid_t f_fsid;
        int f_namelen;  /* SunOS ignores this field. */
        int f_spare[6];
 };
