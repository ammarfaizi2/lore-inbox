Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVDAMiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVDAMiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDAMiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:38:11 -0500
Received: from mail.aknet.ru ([217.67.122.194]:4619 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262729AbVDAMf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:35:56 -0500
Message-ID: <424D402E.7040705@aknet.ru>
Date: Fri, 01 Apr 2005 16:35:58 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] move SA_xxx defines to linux/signal.h
Content-Type: multipart/mixed;
 boundary="------------050506090102020804060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050506090102020804060402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

The attached patch moves the
IRQ-related SA_xxx flags (namely,
SA_PROBE, SA_SAMPLE_RANDOM and
SA_SHIRQ) from all the arch-specific
headers to linux/signal.h.
This looks like a left-over after
the irq-handling code was consolidated.
The code was moved to kernel/irq/*, but
the flags are still left per-arch.

Right now, adding a new IRQ flag to the
arch-specific header, like this patch
does:
http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-driver/utils/patches/pcsp-kernel-2.6.10-03.diff?rev=1.1
no longer works, it breaks the compilation
for all other arches, unless you add that
flag to all the other arch-specific headers
too. So I think such a clean-up makes sense.

Can this please be applied?
Unfortunately I have tested it on x86 only.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------050506090102020804060402
Content-Type: text/x-patch;
 name="linux-2.6.12-rc1-hdr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-rc1-hdr.diff"

diff -ur linux-2.6.11/include/asm-alpha/signal.h linux-2.6.11-hdr/include/asm-alpha/signal.h
--- linux-2.6.11/include/asm-alpha/signal.h	2005-01-17 09:36:46.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-alpha/signal.h	2005-03-09 11:17:45.000000000 +0300
@@ -109,20 +109,6 @@
 #define MINSIGSTKSZ	4096
 #define SIGSTKSZ	16384
 
-
-#ifdef __KERNEL__
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x40000000
-#endif
-
 #define SIG_BLOCK          1	/* for blocking signals */
 #define SIG_UNBLOCK        2	/* for unblocking signals */
 #define SIG_SETMASK        3	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-arm/signal.h linux-2.6.11-hdr/include/asm-arm/signal.h
--- linux-2.6.11/include/asm-arm/signal.h	2005-01-17 09:36:41.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-arm/signal.h	2005-03-09 11:33:19.000000000 +0300
@@ -114,18 +114,7 @@
 #define SIGSTKSZ	8192
 
 #ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		0x80000000
-#define SA_SAMPLE_RANDOM	0x10000000
 #define SA_IRQNOMASK		0x08000000
-#define SA_SHIRQ		0x04000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -ur linux-2.6.11/include/asm-arm26/signal.h linux-2.6.11-hdr/include/asm-arm26/signal.h
--- linux-2.6.11/include/asm-arm26/signal.h	2005-01-17 09:36:47.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-arm26/signal.h	2005-03-09 11:39:28.000000000 +0300
@@ -114,18 +114,7 @@
 #define SIGSTKSZ	8192
 
 #ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		0x80000000
-#define SA_SAMPLE_RANDOM	0x10000000
 #define SA_IRQNOMASK		0x08000000
-#define SA_SHIRQ		0x04000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -ur linux-2.6.11/include/asm-cris/signal.h linux-2.6.11-hdr/include/asm-cris/signal.h
--- linux-2.6.11/include/asm-cris/signal.h	2005-01-17 09:36:38.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-cris/signal.h	2005-03-09 11:34:52.000000000 +0300
@@ -108,20 +108,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-frv/signal.h linux-2.6.11-hdr/include/asm-frv/signal.h
--- linux-2.6.11/include/asm-frv/signal.h	2005-01-17 09:42:36.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-frv/signal.h	2005-03-09 11:16:45.000000000 +0300
@@ -107,20 +107,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-h8300/signal.h linux-2.6.11-hdr/include/asm-h8300/signal.h
--- linux-2.6.11/include/asm-h8300/signal.h	2005-01-17 09:36:46.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-h8300/signal.h	2005-03-09 11:17:59.000000000 +0300
@@ -107,19 +107,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-i386/signal.h linux-2.6.11-hdr/include/asm-i386/signal.h
--- linux-2.6.11/include/asm-i386/signal.h	2005-01-17 09:36:45.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-i386/signal.h	2005-03-09 11:14:42.000000000 +0300
@@ -110,20 +110,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-ia64/signal.h linux-2.6.11-hdr/include/asm-ia64/signal.h
--- linux-2.6.11/include/asm-ia64/signal.h	2005-02-21 11:02:00.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-ia64/signal.h	2005-03-09 11:20:29.000000000 +0300
@@ -114,16 +114,6 @@
 #define _NSIG_BPW	64
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
 #define SA_PERCPU_IRQ		0x02000000
 
 #endif /* __KERNEL__ */
diff -ur linux-2.6.11/include/asm-m32r/signal.h linux-2.6.11-hdr/include/asm-m32r/signal.h
--- linux-2.6.11/include/asm-m32r/signal.h	2005-01-17 09:36:40.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-m32r/signal.h	2005-03-09 11:33:35.000000000 +0300
@@ -114,20 +114,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-m68k/signal.h linux-2.6.11-hdr/include/asm-m68k/signal.h
--- linux-2.6.11/include/asm-m68k/signal.h	2005-01-17 09:36:46.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-m68k/signal.h	2005-03-09 11:18:16.000000000 +0300
@@ -105,19 +105,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-m68knommu/signal.h linux-2.6.11-hdr/include/asm-m68knommu/signal.h
--- linux-2.6.11/include/asm-m68knommu/signal.h	2005-01-17 09:36:44.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-m68knommu/signal.h	2005-03-09 11:32:07.000000000 +0300
@@ -105,19 +105,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-mips/signal.h linux-2.6.11-hdr/include/asm-mips/signal.h
--- linux-2.6.11/include/asm-mips/signal.h	2005-01-17 09:36:39.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-mips/signal.h	2005-03-09 11:34:41.000000000 +0300
@@ -98,21 +98,6 @@
 #define MINSIGSTKSZ    2048
 #define SIGSTKSZ       8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ flag is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x02000000
-
-#endif /* __KERNEL__ */
-
 #define SIG_BLOCK	1	/* for blocking signals */
 #define SIG_UNBLOCK	2	/* for unblocking signals */
 #define SIG_SETMASK	3	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-parisc/signal.h linux-2.6.11-hdr/include/asm-parisc/signal.h
--- linux-2.6.11/include/asm-parisc/signal.h	2005-01-17 09:36:40.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-parisc/signal.h	2005-03-09 11:34:00.000000000 +0300
@@ -89,17 +89,6 @@
 #define _NSIG_BPW	BITS_PER_LONG
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -ur linux-2.6.11/include/asm-ppc/signal.h linux-2.6.11-hdr/include/asm-ppc/signal.h
--- linux-2.6.11/include/asm-ppc/signal.h	2005-01-17 09:42:36.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-ppc/signal.h	2005-03-09 11:34:13.000000000 +0300
@@ -99,19 +99,6 @@
 
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
diff -ur linux-2.6.11/include/asm-ppc64/signal.h linux-2.6.11-hdr/include/asm-ppc64/signal.h
--- linux-2.6.11/include/asm-ppc64/signal.h	2005-01-17 09:36:45.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-ppc64/signal.h	2005-03-09 11:21:53.000000000 +0300
@@ -96,19 +96,6 @@
 
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
diff -ur linux-2.6.11/include/asm-s390/signal.h linux-2.6.11-hdr/include/asm-s390/signal.h
--- linux-2.6.11/include/asm-s390/signal.h	2005-01-17 09:36:46.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-s390/signal.h	2005-03-09 11:17:16.000000000 +0300
@@ -117,20 +117,6 @@
 #define MINSIGSTKSZ     2048
 #define SIGSTKSZ        8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE                SA_ONESHOT
-#define SA_SAMPLE_RANDOM        SA_RESTART
-#define SA_SHIRQ                0x04000000
-#endif
-
 #define SIG_BLOCK          0    /* for blocking signals */
 #define SIG_UNBLOCK        1    /* for unblocking signals */
 #define SIG_SETMASK        2    /* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-sh/signal.h linux-2.6.11-hdr/include/asm-sh/signal.h
--- linux-2.6.11/include/asm-sh/signal.h	2005-01-17 09:36:40.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-sh/signal.h	2005-03-09 11:34:26.000000000 +0300
@@ -108,20 +108,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-sh64/signal.h linux-2.6.11-hdr/include/asm-sh64/signal.h
--- linux-2.6.11/include/asm-sh64/signal.h	2005-01-17 09:36:44.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-sh64/signal.h	2005-03-09 11:32:19.000000000 +0300
@@ -107,20 +107,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	THREAD_SIZE
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-sparc/signal.h linux-2.6.11-hdr/include/asm-sparc/signal.h
--- linux-2.6.11/include/asm-sparc/signal.h	2005-01-17 09:36:44.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-sparc/signal.h	2005-03-09 11:31:12.000000000 +0300
@@ -143,7 +143,6 @@
 #define SA_ONESHOT	_SV_RESET
 #define SA_INTERRUPT	0x10u
 #define SA_NOMASK	0x20u
-#define SA_SHIRQ	0x40u
 #define SA_NOCLDWAIT	0x100u
 #define SA_SIGINFO	0x200u
 
@@ -162,11 +161,6 @@
 
 #ifdef __KERNEL__
 /*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- *
  * DJHR
  * SA_STATIC_ALLOC is used for the SPARC system to indicate that this
  * interrupt handler's irq structure should be statically allocated
@@ -177,8 +171,6 @@
  * statically allocated data.. which is NOT GOOD.
  *
  */
-#define SA_PROBE SA_ONESHOT
-#define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
 #endif
 
diff -ur linux-2.6.11/include/asm-sparc64/signal.h linux-2.6.11-hdr/include/asm-sparc64/signal.h
--- linux-2.6.11/include/asm-sparc64/signal.h	2005-01-17 09:36:44.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-sparc64/signal.h	2005-03-09 11:31:49.000000000 +0300
@@ -145,7 +145,6 @@
 #define SA_ONESHOT	_SV_RESET
 #define SA_INTERRUPT	0x10u
 #define SA_NOMASK	0x20u
-#define SA_SHIRQ	0x40u
 #define SA_NOCLDWAIT    0x100u
 #define SA_SIGINFO      0x200u
 
@@ -165,11 +164,6 @@
 
 #ifdef __KERNEL__
 /*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- *
  * DJHR
  * SA_STATIC_ALLOC is used for the SPARC system to indicate that this
  * interrupt handler's irq structure should be statically allocated
@@ -180,8 +174,6 @@
  * statically allocated data.. which is NOT GOOD.
  *
  */
-#define SA_PROBE SA_ONESHOT
-#define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
 #endif
 
diff -ur linux-2.6.11/include/asm-v850/signal.h linux-2.6.11-hdr/include/asm-v850/signal.h
--- linux-2.6.11/include/asm-v850/signal.h	2005-01-17 09:36:45.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-v850/signal.h	2005-03-09 11:21:02.000000000 +0300
@@ -110,21 +110,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-
-#ifdef __KERNEL__
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif /* __KERNEL__ */
-
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/asm-x86_64/signal.h linux-2.6.11-hdr/include/asm-x86_64/signal.h
--- linux-2.6.11/include/asm-x86_64/signal.h	2005-01-17 09:36:44.000000000 +0300
+++ linux-2.6.11-hdr/include/asm-x86_64/signal.h	2005-03-09 11:32:36.000000000 +0300
@@ -116,20 +116,6 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-#ifdef __KERNEL__
-
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- */
-#define SA_PROBE		SA_ONESHOT
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#endif
-
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -ur linux-2.6.11/include/linux/signal.h linux-2.6.11-hdr/include/linux/signal.h
--- linux-2.6.11/include/linux/signal.h	2005-01-17 09:36:43.000000000 +0300
+++ linux-2.6.11-hdr/include/linux/signal.h	2005-03-09 11:15:32.000000000 +0300
@@ -9,6 +9,17 @@
 #ifdef __KERNEL__
 
 /*
+ * These values of sa_flags are used only by the kernel as part of the
+ * irq handling routines.
+ *
+ * SA_INTERRUPT is also used by the irq handling routines.
+ * SA_SHIRQ is for shared interrupt support on PCI and EISA.
+ */
+#define SA_PROBE		SA_ONESHOT
+#define SA_SAMPLE_RANDOM	SA_RESTART
+#define SA_SHIRQ		0x04000000
+
+/*
  * Real Time signals may be queued.
  */
 

--------------050506090102020804060402--
