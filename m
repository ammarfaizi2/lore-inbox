Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSL3G1W>; Mon, 30 Dec 2002 01:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSL3G1W>; Mon, 30 Dec 2002 01:27:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:22442 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266749AbSL3G1L>;
	Mon, 30 Dec 2002 01:27:11 -0500
Date: Mon, 30 Dec 2002 17:35:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 4/7 IA64
Message-Id: <20021230173527.673d547d.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

IA64 specific stuff ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/ia64/ia32/sys_ia32.c 2.5.53-32bit.1/arch/ia64/ia32/sys_ia32.c
--- 2.5.53/arch/ia64/ia32/sys_ia32.c	2002-12-27 15:15:38.000000000 +1100
+++ 2.5.53-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-12-30 16:33:33.000000000 +1100
@@ -1848,10 +1848,10 @@
 
 struct ipc64_perm32 {
 	key_t key;
-	__kernel_uid32_t32 uid;
-	__kernel_gid32_t32 gid;
-	__kernel_uid32_t32 cuid;
-	__kernel_gid32_t32 cgid;
+	compat_uid32_t uid;
+	compat_gid32_t gid;
+	compat_uid32_t cuid;
+	compat_gid32_t cgid;
 	compat_mode_t mode;
 	unsigned short __pad1;
 	unsigned short seq;
@@ -1894,8 +1894,8 @@
 	unsigned short msg_cbytes;
 	unsigned short msg_qnum;
 	unsigned short msg_qbytes;
-	__kernel_ipc_pid_t32 msg_lspid;
-	__kernel_ipc_pid_t32 msg_lrpid;
+	compat_ipc_pid_t msg_lspid;
+	compat_ipc_pid_t msg_lrpid;
 };
 
 struct msqid64_ds32 {
@@ -1921,8 +1921,8 @@
 	compat_time_t   shm_atime;
 	compat_time_t   shm_dtime;
 	compat_time_t   shm_ctime;
-	__kernel_ipc_pid_t32 shm_cpid;
-	__kernel_ipc_pid_t32 shm_lpid;
+	compat_ipc_pid_t shm_cpid;
+	compat_ipc_pid_t shm_lpid;
 	unsigned short shm_nattch;
 };
 
diff -ruN 2.5.53/include/asm-ia64/compat.h 2.5.53-32bit.1/include/asm-ia64/compat.h
--- 2.5.53/include/asm-ia64/compat.h	2002-12-27 15:15:58.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-ia64/compat.h	2002-12-30 16:31:12.000000000 +1100
@@ -14,11 +14,18 @@
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
diff -ruN 2.5.53/include/asm-ia64/ia32.h 2.5.53-32bit.1/include/asm-ia64/ia32.h
--- 2.5.53/include/asm-ia64/ia32.h	2002-12-27 15:15:58.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-ia64/ia32.h	2002-12-30 16:31:36.000000000 +1100
@@ -12,17 +12,6 @@
  * 32 bit structures for IA32 support.
  */
 
-/* 32bit compatibility types */
-typedef unsigned short	__kernel_ipc_pid_t32;
-typedef unsigned int	__kernel_uid32_t32;
-typedef unsigned int	__kernel_gid32_t32;
-typedef unsigned short	__kernel_umode_t32;
-typedef short		__kernel_nlink_t32;
-typedef int		__kernel_daddr_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef long		__kernel_loff_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
-
 #define IA32_PAGE_SHIFT		12	/* 4KB pages */
 #define IA32_PAGE_SIZE		(1UL << IA32_PAGE_SHIFT)
 #define IA32_PAGE_MASK		(~(IA32_PAGE_SIZE - 1))
@@ -231,7 +220,7 @@
        int f_bavail;
        int f_files;
        int f_ffree;
-       __kernel_fsid_t32 f_fsid;
+       compat_fsid_t f_fsid;
        int f_namelen;  /* SunOS ignores this field. */
        int f_spare[6];
 };
