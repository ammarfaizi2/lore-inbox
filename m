Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271464AbRHPEng>; Thu, 16 Aug 2001 00:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271465AbRHPEn2>; Thu, 16 Aug 2001 00:43:28 -0400
Received: from zero.tech9.net ([209.61.188.187]:5131 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S271464AbRHPEnM>;
	Thu, 16 Aug 2001 00:43:12 -0400
Subject: [PATCH] 2.4.8-ac5: let Net Devices feed Entropy (1/2)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <997936615.921.22.camel@phantasy>
In-Reply-To: <997936615.921.22.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 00:43:44 -0400
Message-Id: <997937035.658.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

against 2.4.8-ac5.  patch #1 of 2 (required: adds the new define
for all architectures, configure support, etc.) see previous email.


diff -urN linux-2.4.8-ac5/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.8-ac5/Documentation/Configure.help	Wed Aug 15 19:05:29 2001
+++ linux/Documentation/Configure.help	Wed Aug 15 19:10:01 2001
@@ -8594,6 +8594,19 @@
 
   If you don't know what to use this for, you don't need it.
 
+Allow Net Devices to contribute to /dev/random
+CONFIG_NET_RANDOM
+  If you say Y here, network device interrupts will contribute to the
+  kernel entropy pool at /dev/random. Normally, block devices and
+  some other devices (keyboard, mouse) add to the pool. Some people,
+  however, feel that network devices should not contribute to /dev/random
+  because an external attacker could manipulate incoming packets in a
+  manner to force the pool into a determinable state. Note this is
+  completely theoretical.
+
+  If you don't mind the risk or are using a headless system and are in
+  need of more entropy, say Y.
+
 Ethertap network tap (OBSOLETE)
 CONFIG_ETHERTAP
   If you say Y here (and have said Y to "Kernel/User network link
diff -urN linux-2.4.8-ac5/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-2.4.8-ac5/drivers/net/Config.in	Wed Aug 15 19:05:34 2001
+++ linux/drivers/net/Config.in	Wed Aug 15 18:49:50 2001
@@ -9,6 +9,7 @@
 tristate 'Bonding driver support' CONFIG_BONDING
 tristate 'EQL (serial line load balancing) support' CONFIG_EQUALIZER
 tristate 'Universal TUN/TAP device driver support' CONFIG_TUN
+bool 'Allow Net Devices to contribute to /dev/random' CONFIG_NET_RANDOM
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    if [ "$CONFIG_NETLINK" = "y" ]; then
       tristate 'Ethertap network tap (OBSOLETE)' CONFIG_ETHERTAP
diff -urN linux-2.4.8-ac5/include/asm-alpha/signal.h linux/include/asm-alpha/signal.h
--- linux-2.4.8-ac5/include/asm-alpha/signal.h	Wed Jun 24 17:30:11 1998
+++ linux/include/asm-alpha/signal.h	Wed Aug 15 18:12:10 2001
@@ -121,8 +121,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x40000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          1	/* for blocking signals */
 #define SIG_UNBLOCK        2	/* for unblocking signals */
 #define SIG_SETMASK        3	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-arm/signal.h linux/include/asm-arm/signal.h
--- linux-2.4.8-ac5/include/asm-arm/signal.h	Thu Nov 18 22:37:03 1999
+++ linux/include/asm-arm/signal.h	Wed Aug 15 18:12:29 2001
@@ -124,8 +124,20 @@
 #define SA_SAMPLE_RANDOM	0x10000000
 #define SA_IRQNOMASK		0x08000000
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-cris/signal.h linux/include/asm-cris/signal.h
--- linux-2.4.8-ac5/include/asm-cris/signal.h	Thu Feb  8 19:32:44 2001
+++ linux/include/asm-cris/signal.h	Wed Aug 15 18:12:40 2001
@@ -120,8 +120,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-i386/signal.h linux/include/asm-i386/signal.h
--- linux-2.4.8-ac5/include/asm-i386/signal.h	Fri Aug 10 21:13:47 2001
+++ linux/include/asm-i386/signal.h	Wed Aug 15 19:02:11 2001
@@ -119,8 +119,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-ia64/signal.h linux/include/asm-ia64/signal.h
--- linux-2.4.8-ac5/include/asm-ia64/signal.h	Tue Jul 31 13:30:09 2001
+++ linux/include/asm-ia64/signal.h	Wed Aug 15 18:13:06 2001
@@ -106,6 +106,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.4.8-ac5/include/asm-m68k/signal.h linux/include/asm-m68k/signal.h
--- linux-2.4.8-ac5/include/asm-m68k/signal.h	Thu Nov 18 22:37:03 1999
+++ linux/include/asm-m68k/signal.h	Wed Aug 15 18:13:16 2001
@@ -116,8 +116,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-mips/signal.h linux/include/asm-mips/signal.h
--- linux-2.4.8-ac5/include/asm-mips/signal.h	Mon Jul 10 01:18:15 2000
+++ linux/include/asm-mips/signal.h	Wed Aug 15 18:13:28 2001
@@ -111,6 +111,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x02000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK	1	/* for blocking signals */
diff -urN linux-2.4.8-ac5/include/asm-mips64/signal.h linux/include/asm-mips64/signal.h
--- linux-2.4.8-ac5/include/asm-mips64/signal.h	Sat May 13 11:31:25 2000
+++ linux/include/asm-mips64/signal.h	Wed Aug 15 18:13:43 2001
@@ -112,6 +112,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x02000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK	1	/* for blocking signals */
diff -urN linux-2.4.8-ac5/include/asm-parisc/signal.h linux/include/asm-parisc/signal.h
--- linux-2.4.8-ac5/include/asm-parisc/signal.h	Tue Dec  5 15:29:39 2000
+++ linux/include/asm-parisc/signal.h	Wed Aug 15 18:13:53 2001
@@ -100,6 +100,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.4.8-ac5/include/asm-ppc/signal.h linux/include/asm-ppc/signal.h
--- linux-2.4.8-ac5/include/asm-ppc/signal.h	Mon May 21 18:02:06 2001
+++ linux/include/asm-ppc/signal.h	Wed Aug 15 18:14:02 2001
@@ -114,8 +114,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-ppc64/signal.h linux/include/asm-ppc64/signal.h
--- linux-2.4.8-ac5/include/asm-ppc64/signal.h	Wed Aug 15 19:05:43 2001
+++ linux/include/asm-ppc64/signal.h	Wed Aug 15 18:14:14 2001
@@ -117,8 +117,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-s390/signal.h linux/include/asm-s390/signal.h
--- linux-2.4.8-ac5/include/asm-s390/signal.h	Wed Apr 11 22:02:28 2001
+++ linux/include/asm-s390/signal.h	Wed Aug 15 18:14:25 2001
@@ -127,8 +127,20 @@
 #define SA_PROBE                SA_ONESHOT
 #define SA_SAMPLE_RANDOM        SA_RESTART
 #define SA_SHIRQ                0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0    /* for blocking signals */
 #define SIG_UNBLOCK        1    /* for unblocking signals */
 #define SIG_SETMASK        2    /* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-s390x/signal.h linux/include/asm-s390x/signal.h
--- linux-2.4.8-ac5/include/asm-s390x/signal.h	Wed Jul 25 17:12:02 2001
+++ linux/include/asm-s390x/signal.h	Wed Aug 15 18:14:32 2001
@@ -127,8 +127,20 @@
 #define SA_PROBE                SA_ONESHOT
 #define SA_SAMPLE_RANDOM        SA_RESTART
 #define SA_SHIRQ                0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0    /* for blocking signals */
 #define SIG_UNBLOCK        1    /* for unblocking signals */
 #define SIG_SETMASK        2    /* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-sh/signal.h linux/include/asm-sh/signal.h
--- linux-2.4.8-ac5/include/asm-sh/signal.h	Thu Nov 18 22:37:03 1999
+++ linux/include/asm-sh/signal.h	Wed Aug 15 18:14:43 2001
@@ -107,8 +107,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.8-ac5/include/asm-sparc/signal.h linux/include/asm-sparc/signal.h
--- linux-2.4.8-ac5/include/asm-sparc/signal.h	Wed Sep  8 14:14:32 1999
+++ linux/include/asm-sparc/signal.h	Wed Aug 15 18:14:52 2001
@@ -176,8 +176,20 @@
 #define SA_PROBE SA_ONESHOT
 #define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, int, struct sigcontext *, char *);
diff -urN linux-2.4.8-ac5/include/asm-sparc64/signal.h linux/include/asm-sparc64/signal.h
--- linux-2.4.8-ac5/include/asm-sparc64/signal.h	Wed Sep  8 14:14:32 1999
+++ linux/include/asm-sparc64/signal.h	Wed Aug 15 18:15:02 2001
@@ -192,8 +192,20 @@
 #define SA_PROBE SA_ONESHOT
 #define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, struct sigcontext *);


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

