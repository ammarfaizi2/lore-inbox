Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSFNP34>; Fri, 14 Jun 2002 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317936AbSFNP3z>; Fri, 14 Jun 2002 11:29:55 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:58777 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317935AbSFNP3h>;
	Fri, 14 Jun 2002 11:29:37 -0400
Date: Sat, 15 Jun 2002 01:28:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org, engebret@us.ibm.com, schwidefsky@de.ibm.com,
        linux390@de.ibm.com, davem@redhat.com, ak@suse.de, davidm@hpl.hp.com
Cc: anton@samba.org, paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] continue creation of include/asm/compat32.h
Message-Id: <20020615012825.3a788a5c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Dave Miller's prompting I have continued the populating of
include/asm/compat32.h

There is more to do, but this is a start.

This patch is relative to my previous patch (see mail with subject
"[PATCH] Take 2: Consolidate sys32_utime").

Comments?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

P.S. Any one know the PARISC maintainer?

diff -ruN 2.5.21-sfr.3/arch/mips64/kernel/ioctl32.c 2.5.21-sfr.4/arch/mips64/kernel/ioctl32.c
--- 2.5.21-sfr.3/arch/mips64/kernel/ioctl32.c	Mon Apr 29 14:57:05 2002
+++ 2.5.21-sfr.4/arch/mips64/kernel/ioctl32.c	Sat Jun 15 00:23:29 2002
@@ -29,6 +29,7 @@
 #include <linux/raid/md_u.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
+#include <asm/compat32.h>
 
 long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
diff -ruN 2.5.21-sfr.3/arch/mips64/kernel/signal32.c 2.5.21-sfr.4/arch/mips64/kernel/signal32.c
--- 2.5.21-sfr.3/arch/mips64/kernel/signal32.c	Thu May 30 09:44:28 2002
+++ 2.5.21-sfr.4/arch/mips64/kernel/signal32.c	Sat Jun 15 00:24:53 2002
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/compat32.h>
 
 #define DEBUG_SIG 0
 
diff -ruN 2.5.21-sfr.3/arch/ppc64/kernel/signal32.c 2.5.21-sfr.4/arch/ppc64/kernel/signal32.c
--- 2.5.21-sfr.3/arch/ppc64/kernel/signal32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.21-sfr.4/arch/ppc64/kernel/signal32.c	Sat Jun 15 00:33:33 2002
@@ -51,6 +51,7 @@
 #include <asm/ppc32.h>
 #include <asm/ppcdebug.h>
 #include <asm/unistd.h>
+#include <asm/compat32.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 /* 
diff -ruN 2.5.21-sfr.3/arch/s390x/kernel/ioctl32.c 2.5.21-sfr.4/arch/s390x/kernel/ioctl32.c
--- 2.5.21-sfr.3/arch/s390x/kernel/ioctl32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.4/arch/s390x/kernel/ioctl32.c	Sat Jun 15 00:25:34 2002
@@ -35,6 +35,7 @@
 #include <asm/tape390.h>
 #include <asm/sockios.h>
 #include <asm/ioctls.h>
+#include <asm/compat32.h>
 
 #include "linux32.h"
 
diff -ruN 2.5.21-sfr.3/arch/s390x/kernel/linux32.h 2.5.21-sfr.4/arch/s390x/kernel/linux32.h
--- 2.5.21-sfr.3/arch/s390x/kernel/linux32.h	Fri Jun 14 16:58:22 2002
+++ 2.5.21-sfr.4/arch/s390x/kernel/linux32.h	Fri Jun 14 23:11:58 2002
@@ -8,6 +8,8 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/export.h>
 
+#include <asm/compat32.h>
+
 #ifdef CONFIG_S390_SUPPORT
 
 /* Macro that masks the high order bit of an 32 bit pointer and converts it*/
@@ -17,24 +19,6 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_clock_t32;
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
-typedef long                   __kernel_loff_t32;
-typedef __kernel_fsid_t        __kernel_fsid_t32;  
 
 struct ipc_kludge_32 {
         __u32   msgp;                           /* pointer              */
diff -ruN 2.5.21-sfr.3/arch/sparc64/kernel/signal32.c 2.5.21-sfr.4/arch/sparc64/kernel/signal32.c
--- 2.5.21-sfr.3/arch/sparc64/kernel/signal32.c	Fri May 10 09:35:09 2002
+++ 2.5.21-sfr.4/arch/sparc64/kernel/signal32.c	Sat Jun 15 00:32:00 2002
@@ -28,6 +28,7 @@
 #include <asm/psrcompat.h>
 #include <asm/fpumacro.h>
 #include <asm/visasm.h>
+#include <asm/compat32.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff -ruN 2.5.21-sfr.3/arch/sparc64/kernel/sunos_ioctl32.c 2.5.21-sfr.4/arch/sparc64/kernel/sunos_ioctl32.c
--- 2.5.21-sfr.3/arch/sparc64/kernel/sunos_ioctl32.c	Sat Aug  5 11:16:11 2000
+++ 2.5.21-sfr.4/arch/sparc64/kernel/sunos_ioctl32.c	Sat Jun 15 00:30:13 2002
@@ -23,6 +23,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <asm/kbio.h>
+#include <asm/compat32.h>
 
 /* Use this to get at 32-bit user passed pointers. */
 #define A(__x)				\
diff -ruN 2.5.21-sfr.3/arch/sparc64/solaris/socket.c 2.5.21-sfr.4/arch/sparc64/solaris/socket.c
--- 2.5.21-sfr.3/arch/sparc64/solaris/socket.c	Mon Feb 11 17:37:20 2002
+++ 2.5.21-sfr.4/arch/sparc64/solaris/socket.c	Sat Jun 15 00:32:41 2002
@@ -18,6 +18,7 @@
 #include <asm/string.h>
 #include <asm/oplib.h>
 #include <asm/idprom.h>
+#include <asm/compat32.h>
 
 #include "conv.h"
 
diff -ruN 2.5.21-sfr.3/arch/x86_64/ia32/socket32.c 2.5.21-sfr.4/arch/x86_64/ia32/socket32.c
--- 2.5.21-sfr.3/arch/x86_64/ia32/socket32.c	Wed Feb 20 16:36:40 2002
+++ 2.5.21-sfr.4/arch/x86_64/ia32/socket32.c	Sat Jun 15 00:36:48 2002
@@ -25,6 +25,7 @@
 #include <asm/ia32.h>
 #include <asm/uaccess.h>
 #include <asm/socket32.h>
+#include <asm/compat32.h>
 
 #define A(__x)		((unsigned long)(__x))
 #define AA(__x)		((unsigned long)(__x))
diff -ruN 2.5.21-sfr.3/include/asm-generic/compat32.h 2.5.21-sfr.4/include/asm-generic/compat32.h
--- 2.5.21-sfr.3/include/asm-generic/compat32.h	Fri Jun 14 16:42:45 2002
+++ 2.5.21-sfr.4/include/asm-generic/compat32.h	Sat Jun 15 01:08:07 2002
@@ -8,5 +8,33 @@
 #define ASM_GENERIC_COMPAT32_H
 
 typedef int		__kernel_time_t32;
+typedef int		__kernel_clock_t32;
+typedef int		__kernel_daddr_t32;
+typedef int		__kernel_off_t32;
+typedef int		__kernel_pid_t32;
+typedef int		__kernel_ssize_t32;
+typedef unsigned int	__kernel_caddr_t32;
+typedef unsigned int	__kernel_ino_t32;
+typedef unsigned int	__kernel_size_t32;
+
+#ifndef HAVE_ARCH___KERNEL_DEV_T32
+typedef unsigned short	__kernel_dev_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_GID_T32
+typedef unsigned short	__kernel_gid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_UID_T32
+typedef unsigned short	__kernel_uid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_IPC_PID_T32
+typedef unsigned short	__kernel_ipc_pid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_MODE_T32
+typedef unsigned short	__kernel_mode_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_FSID_T32
+#include <linux/types.h>
+typedef __kernel_fsid_t	__kernel_fsid_t32;
+#endif
 
 #endif /* ASM_GENERIC_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-ia64/compat32.h 2.5.21-sfr.4/include/asm-ia64/compat32.h
--- 2.5.21-sfr.3/include/asm-ia64/compat32.h	Fri Jun 14 16:46:23 2002
+++ 2.5.21-sfr.4/include/asm-ia64/compat32.h	Sat Jun 15 00:19:04 2002
@@ -6,4 +6,7 @@
 
 #include <asm-generic/compat32.h>
 
+typedef unsigned int	__kernel_gid32_t32;
+typedef unsigned int	__kernel_uid32_t32;
+
 #endif /* ASM_IA64_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-ia64/ia32.h 2.5.21-sfr.4/include/asm-ia64/ia32.h
--- 2.5.21-sfr.3/include/asm-ia64/ia32.h	Fri Jun 14 16:18:17 2002
+++ 2.5.21-sfr.4/include/asm-ia64/ia32.h	Fri Jun 14 22:55:54 2002
@@ -6,32 +6,13 @@
 #ifdef CONFIG_IA32_SUPPORT
 
 #include <linux/binfmts.h>
+#include <asm/compat32.h>
 
 /*
  * 32 bit structures for IA32 support.
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_pid_t32;
-typedef unsigned short	__kernel_ipc_pid_t32;
-typedef unsigned short	__kernel_uid_t32;
-typedef unsigned int	__kernel_uid32_t32;
-typedef unsigned short	__kernel_gid_t32;
-typedef unsigned int	__kernel_gid32_t32;
-typedef unsigned short	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned short	__kernel_mode_t32;
-typedef unsigned short	__kernel_umode_t32;
-typedef short		__kernel_nlink_t32;
-typedef int		__kernel_daddr_t32;
-typedef int		__kernel_off_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef long		__kernel_loff_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
 
 #define IA32_PAGE_SHIFT		12	/* 4KB pages */
 #define IA32_PAGE_SIZE		(1UL << IA32_PAGE_SHIFT)
diff -ruN 2.5.21-sfr.3/include/asm-mips64/compat32.h 2.5.21-sfr.4/include/asm-mips64/compat32.h
--- 2.5.21-sfr.3/include/asm-mips64/compat32.h	Fri Jun 14 16:47:38 2002
+++ 2.5.21-sfr.4/include/asm-mips64/compat32.h	Sat Jun 15 01:08:19 2002
@@ -4,6 +4,19 @@
 #ifndef ASM_MIPS64_COMPAT32_H
 #define ASM_MIPS64_COMPAT32_H
 
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_IPC_PID_T32
+#define HAVE_ARCH___KERNEL_MODE_T32
+
 #include <asm-generic/compat32.h>
+
+typedef int		__kernel_gid_t32;
+typedef int		__kernel_ipc_pid_t32;
+typedef int		__kernel_uid_t32;
+typedef unsigned int	__kernel_dev_t32;
+typedef unsigned int	__kernel_mode_t32;
+typedef unsigned int	__kernel_nlink_t32;
 
 #endif /* ASM_MIPS64_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-mips64/posix_types.h 2.5.21-sfr.4/include/asm-mips64/posix_types.h
--- 2.5.21-sfr.3/include/asm-mips64/posix_types.h	Fri Jun 14 16:48:14 2002
+++ 2.5.21-sfr.4/include/asm-mips64/posix_types.h	Fri Jun 14 22:58:23 2002
@@ -48,25 +48,6 @@
         int    val[2];
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef unsigned int	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned int	__kernel_mode_t32;
-typedef unsigned int	__kernel_nlink_t32;
-typedef int		__kernel_off_t32;
-typedef int		__kernel_pid_t32;
-typedef int		__kernel_ipc_pid_t32;
-typedef int		__kernel_uid_t32;
-typedef int		__kernel_gid_t32;
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_suseconds_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_daddr_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.21-sfr.3/include/asm-parisc/compat32.h 2.5.21-sfr.4/include/asm-parisc/compat32.h
--- 2.5.21-sfr.3/include/asm-parisc/compat32.h	Fri Jun 14 17:18:02 2002
+++ 2.5.21-sfr.4/include/asm-parisc/compat32.h	Sat Jun 15 01:08:26 2002
@@ -4,6 +4,15 @@
 #ifndef ASM_PARISC_COMPAT32_H
 #define ASM_PARISC_COMPAT32_H
 
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_FSID_T32
+
 #include <asm-generic/compat32.h>
+
+typedef unsigned int		__kernel_dev_t32;
+typedef unsigned int		__kernel_gid_t32;
+typedef unsigned int		__kernel_uid_t32;
 
 #endif /* ASM_PARISC_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-parisc/posix_types.h 2.5.21-sfr.4/include/asm-parisc/posix_types.h
--- 2.5.21-sfr.3/include/asm-parisc/posix_types.h	Fri Jun 14 17:18:49 2002
+++ 2.5.21-sfr.4/include/asm-parisc/posix_types.h	Sat Jun 15 01:17:19 2002
@@ -44,26 +44,6 @@
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) && defined(__LP64__)
-/* Now 32bit compatibility types */
-typedef unsigned int		__kernel_dev_t32;
-typedef unsigned int		__kernel_ino_t32;
-typedef unsigned short		__kernel_mode_t32;
-typedef unsigned short		__kernel_nlink_t32;
-typedef int			__kernel_off_t32;
-typedef int			__kernel_pid_t32;
-typedef unsigned short		__kernel_ipc_pid_t32;
-typedef unsigned int		__kernel_uid_t32;
-typedef unsigned int		__kernel_gid_t32;
-typedef unsigned int		__kernel_size_t32;
-typedef int			__kernel_ssize_t32;
-typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_suseconds_t32;
-typedef int			__kernel_clock_t32;
-typedef int			__kernel_daddr_t32;
-typedef unsigned int		__kernel_caddr_t32;
-#endif
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.21-sfr.3/include/asm-ppc64/compat32.h 2.5.21-sfr.4/include/asm-ppc64/compat32.h
--- 2.5.21-sfr.3/include/asm-ppc64/compat32.h	Fri Jun 14 16:48:50 2002
+++ 2.5.21-sfr.4/include/asm-ppc64/compat32.h	Sat Jun 15 01:08:36 2002
@@ -4,6 +4,22 @@
 #ifndef ASM_PPC64_COMPAT32_H
 #define ASM_PPC64_COMPAT32_H
 
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_MODE_T32
+#define HAVE_ARCH___KERNEL_FSID_T32
+
 #include <asm-generic/compat32.h>
+
+#ifndef __KERNEL_STRICT_NAMES
+#include <linux/types.h>
+typedef __kernel_fsid_t __kernel_fsid_t32;
+#endif
+
+typedef unsigned int           __kernel_dev_t32;
+typedef unsigned int           __kernel_gid_t32;
+typedef unsigned int           __kernel_mode_t32;
+typedef unsigned int           __kernel_uid_t32;
 
 #endif /* ASM_PPC64_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-ppc64/ppc32.h 2.5.21-sfr.4/include/asm-ppc64/ppc32.h
--- 2.5.21-sfr.3/include/asm-ppc64/ppc32.h	Fri Jun 14 17:20:31 2002
+++ 2.5.21-sfr.4/include/asm-ppc64/ppc32.h	Fri Jun 14 23:09:01 2002
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
@@ -44,24 +39,6 @@
 })
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_clock_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned int           __kernel_uid_t32;
-typedef unsigned int           __kernel_gid_t32;
-typedef unsigned int           __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned int           __kernel_mode_t32;
-typedef unsigned int           __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef int 		       __kernel_loff_t32;
-/* typedef __kernel_fsid_t        __kernel_fsid_t32; */
 
 struct statfs32 {
 	int f_type;
diff -ruN 2.5.21-sfr.3/include/asm-s390x/compat32.h 2.5.21-sfr.4/include/asm-s390x/compat32.h
--- 2.5.21-sfr.3/include/asm-s390x/compat32.h	Fri Jun 14 16:49:42 2002
+++ 2.5.21-sfr.4/include/asm-s390x/compat32.h	Sat Jun 15 00:58:48 2002
@@ -6,4 +6,6 @@
 
 #include <asm-generic/compat32.h>
 
+typedef long		__kernel_loff_t32;
+
 #endif /* ASM_S390X_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/compat32.h 2.5.21-sfr.4/include/asm-sparc64/compat32.h
--- 2.5.21-sfr.3/include/asm-sparc64/compat32.h	Fri Jun 14 16:50:55 2002
+++ 2.5.21-sfr.4/include/asm-sparc64/compat32.h	Sat Jun 15 00:58:43 2002
@@ -6,4 +6,6 @@
 
 #include <asm-generic/compat32.h>
 
+typedef long		__kernel_loff_t32;
+
 #endif /* ASM_SPARC64_COMPAT32_H */
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/fcntl.h 2.5.21-sfr.4/include/asm-sparc64/fcntl.h
--- 2.5.21-sfr.3/include/asm-sparc64/fcntl.h	Mon Sep 24 05:13:18 2001
+++ 2.5.21-sfr.4/include/asm-sparc64/fcntl.h	Sat Jun 15 00:41:11 2002
@@ -79,6 +79,8 @@
 };
 
 #ifdef __KERNEL__
+#include <asm/compat32.h>
+
 struct flock32 {
 	short l_type;
 	short l_whence;
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/posix_types.h 2.5.21-sfr.4/include/asm-sparc64/posix_types.h
--- 2.5.21-sfr.3/include/asm-sparc64/posix_types.h	Fri Jun 14 16:51:20 2002
+++ 2.5.21-sfr.4/include/asm-sparc64/posix_types.h	Fri Jun 14 22:49:41 2002
@@ -47,26 +47,6 @@
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_clock_t32;
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
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/siginfo.h 2.5.21-sfr.4/include/asm-sparc64/siginfo.h
--- 2.5.21-sfr.3/include/asm-sparc64/siginfo.h	Mon Jun  3 12:17:08 2002
+++ 2.5.21-sfr.4/include/asm-sparc64/siginfo.h	Sat Jun 15 00:42:31 2002
@@ -74,6 +74,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm-generic/compat32.h>
+
 typedef struct siginfo32 {
 	int si_signo;
 	int si_errno;
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/signal.h 2.5.21-sfr.4/include/asm-sparc64/signal.h
--- 2.5.21-sfr.3/include/asm-sparc64/signal.h	Thu May 30 09:44:39 2002
+++ 2.5.21-sfr.4/include/asm-sparc64/signal.h	Sat Jun 15 00:43:07 2002
@@ -247,6 +247,9 @@
 } stack_t;
 
 #ifdef __KERNEL__
+
+#include <asm/compat32.h>
+
 typedef struct sigaltstack32 {
 	u32			ss_sp;
 	int			ss_flags;
diff -ruN 2.5.21-sfr.3/include/asm-sparc64/statfs.h 2.5.21-sfr.4/include/asm-sparc64/statfs.h
--- 2.5.21-sfr.3/include/asm-sparc64/statfs.h	Thu Apr 24 12:01:28 1997
+++ 2.5.21-sfr.4/include/asm-sparc64/statfs.h	Sat Jun 15 00:43:57 2002
@@ -2,6 +2,8 @@
 #ifndef _SPARC64_STATFS_H
 #define _SPARC64_STATFS_H
 
+#include <asm/compat32.h>
+
 #ifndef __KERNEL_STRICT_NAMES
 
 #include <linux/types.h>
diff -ruN 2.5.21-sfr.3/include/asm-x86_64/ia32.h 2.5.21-sfr.4/include/asm-x86_64/ia32.h
--- 2.5.21-sfr.3/include/asm-x86_64/ia32.h	Thu Jun 13 12:41:02 2002
+++ 2.5.21-sfr.4/include/asm-x86_64/ia32.h	Fri Jun 14 23:14:40 2002
@@ -2,6 +2,7 @@
 #define _ASM_X86_64_IA32_H
 
 #include <linux/config.h>
+#include <asm/compat32.h>
 
 #ifdef CONFIG_IA32_EMULATION
 
@@ -10,25 +11,6 @@
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	       __kernel_size_t32;
-typedef int		       __kernel_ssize_t32;
-typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_clock_t32;
-typedef int		       __kernel_pid_t32;
-typedef unsigned short	       __kernel_ipc_pid_t32;
-typedef unsigned short	       __kernel_uid_t32;
-typedef unsigned short	       __kernel_gid_t32;
-typedef unsigned short	       __kernel_dev_t32;
-typedef unsigned int	       __kernel_ino_t32;
-typedef unsigned short	       __kernel_mode_t32;
-typedef unsigned short	       __kernel_umode_t32;
-typedef short		       __kernel_nlink_t32;
-typedef int		       __kernel_daddr_t32;
-typedef int		       __kernel_off_t32;
-typedef unsigned int	       __kernel_caddr_t32;
-typedef long		       __kernel_loff_t32;
-typedef __kernel_fsid_t	       __kernel_fsid_t32;
-
 
 /* fcntl.h */
 struct flock32 {
diff -ruN 2.5.21-sfr.3/include/asm-x86_64/socket32.h 2.5.21-sfr.4/include/asm-x86_64/socket32.h
--- 2.5.21-sfr.3/include/asm-x86_64/socket32.h	Wed Feb 20 16:36:51 2002
+++ 2.5.21-sfr.4/include/asm-x86_64/socket32.h	Sat Jun 15 00:46:24 2002
@@ -1,6 +1,8 @@
 #ifndef SOCKET32_H
 #define SOCKET32_H 1
 
+#include <asm/compat32.h>
+
 /* XXX This really belongs in some header file... -DaveM */
 #define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
 					   16 for IP, 16 for IPX,

