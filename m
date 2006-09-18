Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWIRBkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWIRBkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbWIRBiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63213 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965221AbWIRBi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:28 -0400
Message-Id: <20060918013217.690500000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:46 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 6/8] annotate header files for make headers_check
Content-Disposition: inline; filename=headercheck-annotate.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These files can only be included from user space if some
other header has been included first, and they don't look
like they should include that header themselves.

This uses a special '@headercheck: ... @' tag in a comment,
which is then turned into a gcc command line option that
will include the dependencies first.

All netfilter headers need something like this as well,
but I decided to make them a separate patch, because there
are so many of them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/include/asm-generic/siginfo.h
===================================================================
--- linux-cg.orig/include/asm-generic/siginfo.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-generic/siginfo.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_SIGINFO_H
 #define _ASM_GENERIC_SIGINFO_H
 
+/* @headercheck: -include linux/signal.h @ */
+
 #include <linux/compiler.h>
 #include <linux/types.h>
 
Index: linux-cg/include/asm-i386/ipcbuf.h
===================================================================
--- linux-cg.orig/include/asm-i386/ipcbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-i386/ipcbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -10,6 +10,7 @@
  * - 32-bit mode_t and seq
  * - 2 miscellaneous 32-bit values
  */
+/* @headercheck: -include linux/posix_types.h @ */
 
 struct ipc64_perm
 {
Index: linux-cg/include/asm-i386/msgbuf.h
===================================================================
--- linux-cg.orig/include/asm-i386/msgbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-i386/msgbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -10,6 +10,8 @@
  * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
+/* @headercheck: -include linux/posix_types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
Index: linux-cg/include/asm-i386/sembuf.h
===================================================================
--- linux-cg.orig/include/asm-i386/sembuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-i386/sembuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -10,6 +10,8 @@
  * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
+/* @headercheck: -include linux/posix_types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
Index: linux-cg/include/asm-i386/shmbuf.h
===================================================================
--- linux-cg.orig/include/asm-i386/shmbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-i386/shmbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -10,6 +10,9 @@
  * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
+/* @headercheck: -include linux/posix_types.h @ */
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
Index: linux-cg/include/asm-i386/ucontext.h
===================================================================
--- linux-cg.orig/include/asm-i386/ucontext.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-i386/ucontext.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _ASMi386_UCONTEXT_H
 #define _ASMi386_UCONTEXT_H
 
+/* @headercheck: -include asm/signal.h @ */
+/* @headercheck: -include asm/sigcontext.h @ */
+
 struct ucontext {
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
Index: linux-cg/include/asm-powerpc/msgbuf.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/msgbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-powerpc/msgbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_MSGBUF_H
 #define _ASM_POWERPC_MSGBUF_H
 
+/* @headercheck:-include asm/ipcbuf.h@ */
 /*
  * The msqid64_ds structure for the PowerPC architecture.
  * Note extra padding because this structure is passed back and forth
Index: linux-cg/include/asm-powerpc/posix_types.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/posix_types.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-powerpc/posix_types.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_POSIX_TYPES_H
 #define _ASM_POWERPC_POSIX_TYPES_H
 
+/* @headercheck:-include linux/posix_types.h@ */
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
Index: linux-cg/include/asm-powerpc/sembuf.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/sembuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-powerpc/sembuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_SEMBUF_H
 #define _ASM_POWERPC_SEMBUF_H
 
+/* @headercheck:-include asm/ipcbuf.h@ */
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
Index: linux-cg/include/asm-powerpc/shmbuf.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/shmbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-powerpc/shmbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_SHMBUF_H
 #define _ASM_POWERPC_SHMBUF_H
 
+/* @headercheck:-include asm/ipcbuf.h@ */
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
Index: linux-cg/include/asm-s390/ipcbuf.h
===================================================================
--- linux-cg.orig/include/asm-s390/ipcbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-s390/ipcbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __S390_IPCBUF_H__
 #define __S390_IPCBUF_H__
 
+/* @headercheck: -include linux/types.h @ */
+
 /*
  * The user_ipc_perm structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
Index: linux-cg/include/asm-s390/msgbuf.h
===================================================================
--- linux-cg.orig/include/asm-s390/msgbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-s390/msgbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _S390_MSGBUF_H
 #define _S390_MSGBUF_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
+
 /* 
  * The msqid64_ds structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
Index: linux-cg/include/asm-s390/sembuf.h
===================================================================
--- linux-cg.orig/include/asm-s390/sembuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-s390/sembuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _S390_SEMBUF_H
 #define _S390_SEMBUF_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
+
 /* 
  * The semid64_ds structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
Index: linux-cg/include/asm-s390/shmbuf.h
===================================================================
--- linux-cg.orig/include/asm-s390/shmbuf.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-s390/shmbuf.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _S390_SHMBUF_H
 #define _S390_SHMBUF_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include asm/ipcbuf.h @ */
+
 /* 
  * The shmid64_ds structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
Index: linux-cg/include/asm-s390/ucontext.h
===================================================================
--- linux-cg.orig/include/asm-s390/ucontext.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-s390/ucontext.h	2006-09-18 02:54:10.000000000 +0200
@@ -9,6 +9,9 @@
 #ifndef _ASM_S390_UCONTEXT_H
 #define _ASM_S390_UCONTEXT_H
 
+/* @headercheck: -include asm/signal.h @ */
+/* @headercheck: -include asm/sigcontext.h @ */
+
 struct ucontext {
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
Index: linux-cg/include/linux/atalk.h
===================================================================
--- linux-cg.orig/include/linux/atalk.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/atalk.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef __LINUX_ATALK_H__
 #define __LINUX_ATALK_H__
 
+/* @headercheck: -include linux/socket.h @ */
 #include <asm/byteorder.h>
 
 /*
Index: linux-cg/include/linux/atm_tcp.h
===================================================================
--- linux-cg.orig/include/linux/atm_tcp.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/atm_tcp.h	2006-09-18 02:54:10.000000000 +0200
@@ -12,6 +12,8 @@
 #ifdef __KERNEL__
 #include <linux/types.h>
 #endif
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/atm.h @ */
 #include <linux/atmioc.h>
 
 
Index: linux-cg/include/linux/atm_zatm.h
===================================================================
--- linux-cg.orig/include/linux/atm_zatm.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/atm_zatm.h	2006-09-18 02:54:10.000000000 +0200
@@ -11,6 +11,7 @@
  * Note: non-kernel programs including this file must also include
  * sys/types.h for struct timeval
  */
+/* @headercheck: -include sys/types.h@ */
 
 #include <linux/atmapi.h>
 #include <linux/atmioc.h>
Index: linux-cg/include/linux/atmarp.h
===================================================================
--- linux-cg.orig/include/linux/atmarp.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/atmarp.h	2006-09-18 02:54:10.000000000 +0200
@@ -9,6 +9,8 @@
 #ifdef __KERNEL__
 #include <linux/types.h>
 #endif
+/* @headercheck: -include linux/types.h @ */
+
 #include <linux/atmapi.h>
 #include <linux/atmioc.h>
 
Index: linux-cg/include/linux/dirent.h
===================================================================
--- linux-cg.orig/include/linux/dirent.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/dirent.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_DIRENT_H
 #define _LINUX_DIRENT_H
 
+/* @headercheck: -include linux/types.h @ */
+
 struct dirent {
 	long		d_ino;
 	__kernel_off_t	d_off;
Index: linux-cg/include/linux/errqueue.h
===================================================================
--- linux-cg.orig/include/linux/errqueue.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/errqueue.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_ERRQUEUE_H
 #define _LINUX_ERRQUEUE_H 1
 
+/* @headercheck: -include linux/types.h @ */
+
 struct sock_extended_err
 {
 	__u32	ee_errno;	
Index: linux-cg/include/linux/hdlc/ioctl.h
===================================================================
--- linux-cg.orig/include/linux/hdlc/ioctl.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/hdlc/ioctl.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __HDLC_IOCTL_H__
 #define __HDLC_IOCTL_H__
 
+/* @headercheck:-include linux/if.h@ */
+
 typedef struct { 
 	unsigned int clock_rate; /* bits per second */
 	unsigned int clock_type; /* internal, external, TX-internal etc. */
Index: linux-cg/include/linux/inet_diag.h
===================================================================
--- linux-cg.orig/include/linux/inet_diag.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/inet_diag.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _INET_DIAG_H_
 #define _INET_DIAG_H_ 1
 
+/* @headercheck: -include linux/types.h @ */
+
 /* Just some random number */
 #define TCPDIAG_GETSOCK 18
 #define DCCPDIAG_GETSOCK 19
Index: linux-cg/include/linux/ipv6_route.h
===================================================================
--- linux-cg.orig/include/linux/ipv6_route.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/ipv6_route.h	2006-09-18 02:54:10.000000000 +0200
@@ -13,6 +13,9 @@
 #ifndef _LINUX_IPV6_ROUTE_H
 #define _LINUX_IPV6_ROUTE_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/in6.h @ */
+
 #define RTF_DEFAULT	0x00010000	/* default - learned via ND	*/
 #define RTF_ALLONLINK	0x00020000	/* (deprecated and will be removed)
 					   fallback, no routers on link */
Index: linux-cg/include/linux/irda.h
===================================================================
--- linux-cg.orig/include/linux/irda.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/irda.h	2006-09-18 02:54:10.000000000 +0200
@@ -30,6 +30,7 @@
  * Please fix the calling file to properly included needed files before
  * this one, or preferably to include <net/irda/irda.h> instead.
  * Jean II */
+/* @headercheck: -include linux/socket.h@ */
 
 /* Hint bit positions for first hint byte */
 #define HINT_PNP         0x01
Index: linux-cg/include/linux/llc.h
===================================================================
--- linux-cg.orig/include/linux/llc.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/llc.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,5 +1,9 @@
 #ifndef __LINUX_LLC_H
 #define __LINUX_LLC_H
+
+/* @headercheck: -include linux/socket.h @ */
+/* @headercheck: -include linux/if.h @ */
+
 /*
  * IEEE 802.2 User Interface SAPs for Linux, data structures and indicators.
  *
Index: linux-cg/include/linux/netfilter_ipv4/ipt_physdev.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_physdev.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_physdev.h	2006-09-18 02:54:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _IPT_PHYSDEV_H
 
 /* Backwards compatibility for old userspace */
+/* @headercheck:-include linux/if.h@ */
 
 #include <linux/netfilter/xt_physdev.h>
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_physdev.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_physdev.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_physdev.h	2006-09-18 02:54:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _IP6T_PHYSDEV_H
 
 /* Backwards compatibility for old userspace */
+/* @headercheck:-include linux/if.h@ */
 
 #include <linux/netfilter/xt_physdev.h>
 
Index: linux-cg/include/linux/netrom.h
===================================================================
--- linux-cg.orig/include/linux/netrom.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/netrom.h	2006-09-18 02:54:10.000000000 +0200
@@ -3,6 +3,7 @@
  * For kernel AX.25 see the file ax25.h. This file requires ax25.h for the
  * definition of the ax25_address structure.
  */
+/* @headercheck: -include linux/ax25.h@ */
 
 #ifndef	NETROM_KERNEL_H
 #define	NETROM_KERNEL_H
Index: linux-cg/include/linux/nfs_idmap.h
===================================================================
--- linux-cg.orig/include/linux/nfs_idmap.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/nfs_idmap.h	2006-09-18 02:54:10.000000000 +0200
@@ -37,6 +37,8 @@
 #ifndef NFS_IDMAP_H
 #define NFS_IDMAP_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /* XXX from bits/utmp.h  */
 #define IDMAP_NAMESZ  128
 
Index: linux-cg/include/linux/nubus.h
===================================================================
--- linux-cg.orig/include/linux/nubus.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/nubus.h	2006-09-18 02:54:10.000000000 +0200
@@ -12,6 +12,8 @@
 #ifndef LINUX_NUBUS_H
 #define LINUX_NUBUS_H
 
+/* @headercheck: -include linux/types.h @ */
+
 #ifdef __KERNEL__
 #include <asm/nubus.h>
 #endif
Index: linux-cg/include/linux/patchkey.h
===================================================================
--- linux-cg.orig/include/linux/patchkey.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/patchkey.h	2006-09-18 02:54:10.000000000 +0200
@@ -9,14 +9,15 @@
  * Do not include this file directly.  Please use <sys/soundcard.h> instead.
  * For kernel code, use <linux/soundcard.h>
  */
+#ifndef _LINUX_PATCHKEY_H
+#define _LINUX_PATCHKEY_H
+
+/* @headercheck: -include linux/soundcard.h @ */
 
 #ifndef _LINUX_PATCHKEY_H_INDIRECT
 #error "patchkey.h included directly"
 #endif
 
-#ifndef _LINUX_PATCHKEY_H
-#define _LINUX_PATCHKEY_H
-
 /* Endian macros. */
 #ifdef __KERNEL__
 #  include <asm/byteorder.h>
Index: linux-cg/include/linux/romfs_fs.h
===================================================================
--- linux-cg.orig/include/linux/romfs_fs.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/romfs_fs.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_ROMFS_FS_H
 #define __LINUX_ROMFS_FS_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /* The basic structures of the romfs filesystem */
 
 #define ROMBSIZE BLOCK_SIZE
Index: linux-cg/include/linux/rose.h
===================================================================
--- linux-cg.orig/include/linux/rose.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/rose.h	2006-09-18 02:54:10.000000000 +0200
@@ -7,6 +7,9 @@
 #ifndef	ROSE_KERNEL_H
 #define	ROSE_KERNEL_H
 
+/* @headercheck: -include linux/socket.h @ */
+/* @headercheck: -include linux/ax25.h @ */
+
 #define ROSE_MTU	251
 
 #define ROSE_MAX_DIGIS 6
Index: linux-cg/include/linux/scc.h
===================================================================
--- linux-cg.orig/include/linux/scc.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/scc.h	2006-09-18 02:54:10.000000000 +0200
@@ -3,6 +3,7 @@
 #ifndef	_SCC_H
 #define	_SCC_H
 
+/* @headercheck: -include linux/sockios.h @ */
 
 /* selection of hardware types */
 
Index: linux-cg/include/linux/sdla.h
===================================================================
--- linux-cg.orig/include/linux/sdla.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/sdla.h	2006-09-18 02:54:10.000000000 +0200
@@ -23,6 +23,8 @@
 #ifndef SDLA_H
 #define SDLA_H
 
+/* @headercheck: -include linux/if_frad.h @ */
+
 /* adapter type */
 #define SDLA_TYPES
 #define SDLA_S502A			5020
Index: linux-cg/include/linux/selinux_netlink.h
===================================================================
--- linux-cg.orig/include/linux/selinux_netlink.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/selinux_netlink.h	2006-09-18 02:54:10.000000000 +0200
@@ -12,6 +12,8 @@
 #ifndef _LINUX_SELINUX_NETLINK_H
 #define _LINUX_SELINUX_NETLINK_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /* Message types. */
 #define SELNL_MSG_BASE 0x10
 enum {
Index: linux-cg/include/linux/uinput.h
===================================================================
--- linux-cg.orig/include/linux/uinput.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/uinput.h	2006-09-18 02:54:10.000000000 +0200
@@ -28,6 +28,8 @@
  *	0.1	20/06/2002
  *		- first public version
  */
+/* @headercheck: -include linux/input.h @ */
+
 #ifdef __KERNEL__
 #define UINPUT_MINOR		223
 #define UINPUT_NAME		"uinput"
Index: linux-cg/include/linux/un.h
===================================================================
--- linux-cg.orig/include/linux/un.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/un.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_UN_H
 #define _LINUX_UN_H
 
+/* @headercheck: -include linux/socket.h @ */
 #define UNIX_PATH_MAX	108
 
 struct sockaddr_un {
Index: linux-cg/include/linux/utime.h
===================================================================
--- linux-cg.orig/include/linux/utime.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/utime.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_UTIME_H
 #define _LINUX_UTIME_H
 
+/* @headercheck: -include linux/types.h @ */
 struct utimbuf {
 	time_t actime;
 	time_t modtime;
Index: linux-cg/include/linux/x25.h
===================================================================
--- linux-cg.orig/include/linux/x25.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/x25.h	2006-09-18 02:54:10.000000000 +0200
@@ -12,6 +12,7 @@
 #define	X25_KERNEL_H
 
 #include <linux/types.h>
+/* @headercheck: -include linux/socket.h @ */
 
 #define	SIOCX25GSUBSCRIP	(SIOCPROTOPRIVATE + 0)
 #define	SIOCX25SSUBSCRIP	(SIOCPROTOPRIVATE + 1)
Index: linux-cg/include/mtd/inftl-user.h
===================================================================
--- linux-cg.orig/include/mtd/inftl-user.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/mtd/inftl-user.h	2006-09-18 02:54:10.000000000 +0200
@@ -8,6 +8,8 @@
 #ifndef __MTD_INFTL_USER_H__
 #define __MTD_INFTL_USER_H__
 
+/* @headercheck: -include linux/types.h @ */
+
 #define	OSAK_VERSION	0x5120
 #define	PERCENTUSED	98
 
Index: linux-cg/include/mtd/mtd-abi.h
===================================================================
--- linux-cg.orig/include/mtd/mtd-abi.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/mtd/mtd-abi.h	2006-09-18 02:54:10.000000000 +0200
@@ -7,11 +7,7 @@
 #ifndef __MTD_ABI_H__
 #define __MTD_ABI_H__
 
-#ifndef __KERNEL__ 
-/* Urgh. The whole point of splitting this out into
-   separate files was to avoid #ifdef __KERNEL__ */
-#define __user
-#endif
+/* @headercheck: -include linux/types.h @ */
 
 struct erase_info_user {
 	uint32_t start;
Index: linux-cg/include/mtd/nftl-user.h
===================================================================
--- linux-cg.orig/include/mtd/nftl-user.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/mtd/nftl-user.h	2006-09-18 02:54:10.000000000 +0200
@@ -8,6 +8,8 @@
 #ifndef __MTD_NFTL_USER_H__
 #define __MTD_NFTL_USER_H__
 
+/* @headercheck: -include linux/types.h @ */
+
 /* Block Control Information */
 
 struct nftl_bci {
Index: linux-cg/include/scsi/sg.h
===================================================================
--- linux-cg.orig/include/scsi/sg.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/scsi/sg.h	2006-09-18 02:54:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _SCSI_GENERIC_H
 
 #include <linux/compiler.h>
+/* @headercheck: -include linux/types.h @ */
 
 /*
    History:
Index: linux-cg/include/sound/asequencer.h
===================================================================
--- linux-cg.orig/include/sound/asequencer.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/sound/asequencer.h	2006-09-18 02:54:10.000000000 +0200
@@ -22,9 +22,11 @@
 #ifndef __SOUND_ASEQUENCER_H
 #define __SOUND_ASEQUENCER_H
 
-#ifdef __KERNEL__
-#include <linux/ioctl.h>
 #include <sound/asound.h>
+/* @headercheck: -include linux/time.h @ */
+
+#ifndef __KERNEL__
+#define __bitwise
 #endif
 
 /** version of the sequencer */
Index: linux-cg/include/sound/asound.h
===================================================================
--- linux-cg.orig/include/sound/asound.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/sound/asound.h	2006-09-18 02:54:10.000000000 +0200
@@ -23,9 +23,12 @@
 #ifndef __SOUND_ASOUND_H
 #define __SOUND_ASOUND_H
 
-#ifdef __KERNEL__
-#include <linux/ioctl.h>
 #include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* @headercheck: -include linux/time.h @ */
+
+#ifdef __KERNEL__
 #include <linux/time.h>
 #include <asm/byteorder.h>
 
Index: linux-cg/include/sound/emu10k1.h
===================================================================
--- linux-cg.orig/include/sound/emu10k1.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/sound/emu10k1.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,10 @@
 #ifndef __SOUND_EMU10K1_H
 #define __SOUND_EMU10K1_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/time.h @ */
+/* @headercheck: -include sound/asound.h @ */
+
 /*
  *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>,
  *		     Creative Labs, Inc.
@@ -1527,6 +1531,11 @@
 	unsigned int translation;	/* translation type (EMU10K1_GPR_TRANSLATION*) */
 };
 
+#ifndef DECLARE_BITMAP
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[(bits) / (8*sizeof(long))]
+#endif
+
 struct snd_emu10k1_fx8010_code {
 	char name[128];
 
Index: linux-cg/include/sound/sfnt_info.h
===================================================================
--- linux-cg.orig/include/sound/sfnt_info.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/sound/sfnt_info.h	2006-09-18 02:54:10.000000000 +0200
@@ -22,6 +22,8 @@
  *
  */
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include time.h @ */
 #include <sound/asound.h>
 
 /*
Index: linux-cg/include/asm-generic/atomic.h
===================================================================
--- linux-cg.orig/include/asm-generic/atomic.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/asm-generic/atomic.h	2006-09-18 02:54:10.000000000 +0200
@@ -8,6 +8,8 @@
  * edit all arch specific atomic.h files.
  */
 
+/* @headercheck:-include asm/atomic.h@ */
+
 #include <asm/types.h>
 
 /*
Index: linux-cg/include/linux/nfsd/syscall.h
===================================================================
--- linux-cg.orig/include/linux/nfsd/syscall.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/nfsd/syscall.h	2006-09-18 02:54:10.000000000 +0200
@@ -9,6 +9,9 @@
 #ifndef NFSD_SYSCALL_H
 #define NFSD_SYSCALL_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/in.h@ */
+
 #include <asm/types.h>
 #ifdef __KERNEL__
 # include <linux/types.h>
Index: linux-cg/include/linux/auto_fs4.h
===================================================================
--- linux-cg.orig/include/linux/auto_fs4.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/auto_fs4.h	2006-09-18 02:54:10.000000000 +0200
@@ -11,6 +11,9 @@
 #ifndef _LINUX_AUTO_FS4_H
 #define _LINUX_AUTO_FS4_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/limits.h @ */
+
 /* Include common v3 definitions */
 #include <linux/auto_fs.h>
 
Index: linux-cg/include/linux/bfs_fs.h
===================================================================
--- linux-cg.orig/include/linux/bfs_fs.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/bfs_fs.h	2006-09-18 02:54:10.000000000 +0200
@@ -6,6 +6,8 @@
 #ifndef _LINUX_BFS_FS_H
 #define _LINUX_BFS_FS_H
 
+/* @headercheck: -include linux/types.h @ */
+
 #define BFS_BSIZE_BITS		9
 #define BFS_BSIZE		(1<<BFS_BSIZE_BITS)
 
Index: linux-cg/include/linux/efs_fs_sb.h
===================================================================
--- linux-cg.orig/include/linux/efs_fs_sb.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/efs_fs_sb.h	2006-09-18 02:54:10.000000000 +0200
@@ -9,6 +9,8 @@
 #ifndef __EFS_FS_SB_H__
 #define __EFS_FS_SB_H__
 
+/* @headercheck: -include linux/types.h @ */
+
 /* statfs() magic number for EFS */
 #define EFS_SUPER_MAGIC	0x414A53
 
Index: linux-cg/include/linux/jffs2.h
===================================================================
--- linux-cg.orig/include/linux/jffs2.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/jffs2.h	2006-09-18 02:54:10.000000000 +0200
@@ -15,6 +15,8 @@
 #ifndef __LINUX_JFFS2_H__
 #define __LINUX_JFFS2_H__
 
+/* @headercheck: -include linux/types.h @ */
+
 /* You must include something which defines the C99 uintXX_t types. 
    We don't do it from here because this file is used in too many
    different environments. */
Index: linux-cg/include/linux/minix_fs.h
===================================================================
--- linux-cg.orig/include/linux/minix_fs.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/minix_fs.h	2006-09-18 02:54:10.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MINIX_FS_H
 #define _LINUX_MINIX_FS_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /*
  * The minix filesystem constants/structures
  */
Index: linux-cg/include/linux/auto_fs.h
===================================================================
--- linux-cg.orig/include/linux/auto_fs.h	2006-09-18 02:52:30.000000000 +0200
+++ linux-cg/include/linux/auto_fs.h	2006-09-18 02:54:10.000000000 +0200
@@ -14,6 +14,9 @@
 #ifndef _LINUX_AUTO_FS_H
 #define _LINUX_AUTO_FS_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/limits.h @ */
+
 #ifdef __KERNEL__
 #include <linux/fs.h>
 #include <linux/limits.h>
Index: linux-cg/include/linux/dn.h
===================================================================
--- linux-cg.orig/include/linux/dn.h	2006-09-18 02:54:17.000000000 +0200
+++ linux-cg/include/linux/dn.h	2006-09-18 02:54:20.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_DN_H
 #define _LINUX_DN_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /*
 
 	DECnet Data Structures and Constants
Index: linux-cg/include/linux/ethtool.h
===================================================================
--- linux-cg.orig/include/linux/ethtool.h	2006-09-18 02:54:17.000000000 +0200
+++ linux-cg/include/linux/ethtool.h	2006-09-18 02:54:20.000000000 +0200
@@ -12,6 +12,7 @@
 #ifndef _LINUX_ETHTOOL_H
 #define _LINUX_ETHTOOL_H
 
+/* @headercheck: -include linux/types.h @ */
 
 /* This should work for both 32 and 64 bit userland. */
 struct ethtool_cmd {
Index: linux-cg/include/linux/synclink.h
===================================================================
--- linux-cg.orig/include/linux/synclink.h	2006-09-18 02:54:17.000000000 +0200
+++ linux-cg/include/linux/synclink.h	2006-09-18 02:54:20.000000000 +0200
@@ -13,6 +13,8 @@
 #define _SYNCLINK_H_
 #define SYNCLINK_H_VERSION 3.6
 
+/* @headercheck: -include linux/types.h @ */
+
 #define BOOLEAN int
 #define TRUE 1
 #define FALSE 0

--

