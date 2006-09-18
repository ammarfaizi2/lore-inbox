Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWIRBku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWIRBku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWIRBip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:48347 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965213AbWIRBiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:25 -0400
Message-Id: <20060918013217.154667000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:44 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 4/8] fix exported flock64 constants
Content-Disposition: inline; filename=headercheck-fcntl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic/fcntl.h header relied on CONFIG_64BIT
to determine if it should define some of its contents.

This does not work in user space where no CONFIG_ symbols
are available, so introduce a new __ARCH_FLOCK64 symbol
that is set by asm/fcntl.h before including asm-generic/fcntl.h
when an architecture wants these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--- a/include/asm-arm/fcntl.h
+++ b/include/asm-arm/fcntl.h
@@ -6,6 +6,8 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-arm26/fcntl.h b/include/asm-arm26/fcntl.h
index d85995e..23c5875 100644
--- a/include/asm-arm26/fcntl.h
+++ b/include/asm-arm26/fcntl.h
@@ -8,6 +8,8 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-cris/fcntl.h b/include/asm-cris/fcntl.h
index 46ab12d..a025b36 100644
--- a/include/asm-cris/fcntl.h
+++ b/include/asm-cris/fcntl.h
@@ -1 +1,3 @@
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-frv/fcntl.h b/include/asm-frv/fcntl.h
index 46ab12d..a025b36 100644
--- a/include/asm-frv/fcntl.h
+++ b/include/asm-frv/fcntl.h
@@ -1 +1,3 @@
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
index c154b9d..55e8eff 100644
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
@@ -121,7 +121,7 @@ struct flock {
 };
 #endif
 
-#ifndef CONFIG_64BIT
+#ifdef __ARCH_FLOCK64
 
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
diff --git a/include/asm-h8300/fcntl.h b/include/asm-h8300/fcntl.h
index 1952cb2..e0001cd 100644
--- a/include/asm-h8300/fcntl.h
+++ b/include/asm-h8300/fcntl.h
@@ -6,6 +6,8 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _H8300_FCNTL_H */
diff --git a/include/asm-i386/fcntl.h b/include/asm-i386/fcntl.h
index 46ab12d..a025b36 100644
--- a/include/asm-i386/fcntl.h
+++ b/include/asm-i386/fcntl.h
@@ -1 +1,3 @@
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-ia64/fcntl.h b/include/asm-ia64/fcntl.h
index 1dd275d..622d230 100644
--- a/include/asm-ia64/fcntl.h
+++ b/include/asm-ia64/fcntl.h
@@ -8,6 +8,8 @@
 #define force_o_largefile()	\
 		(personality(current->personality) != PER_LINUX32)
 
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _ASM_IA64_FCNTL_H */
diff --git a/include/asm-m32r/fcntl.h b/include/asm-m32r/fcntl.h
index 46ab12d..a025b36 100644
--- a/include/asm-m32r/fcntl.h
+++ b/include/asm-m32r/fcntl.h
@@ -1 +1,3 @@
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-m68k/fcntl.h b/include/asm-m68k/fcntl.h
index 1c369b2..d9070e4 100644
--- a/include/asm-m68k/fcntl.h
+++ b/include/asm-m68k/fcntl.h
@@ -6,6 +6,8 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
+#define __ARCH_FLOCK64
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _M68K_FCNTL_H */
diff --git a/include/asm-m68knommu/fcntl.h b/include/asm-m68knommu/fcntl.h
index f6a552c..237f6b8 100644
--- a/include/asm-m68knommu/fcntl.h
+++ b/include/asm-m68knommu/fcntl.h
@@ -1 +1,3 @@
+#define __ARCH_FLOCK64
+
 #include <asm-m68k/fcntl.h>
diff --git a/include/asm-mips/fcntl.h b/include/asm-mips/fcntl.h
index 787220e..bab60a4 100644
--- a/include/asm-mips/fcntl.h
+++ b/include/asm-mips/fcntl.h
@@ -55,6 +55,8 @@ struct flock {
 
 #define HAVE_ARCH_STRUCT_FLOCK
 
+#define __ARCH_FLOCK64
+
 #endif /* CONFIG_32BIT */
 
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-parisc/fcntl.h b/include/asm-parisc/fcntl.h
index 317851f..df97fd4 100644
--- a/include/asm-parisc/fcntl.h
+++ b/include/asm-parisc/fcntl.h
@@ -33,6 +33,10 @@
 #define F_WRLCK		02
 #define F_UNLCK		03
 
+#ifndef __LP64__
+#define __ARCH_FLOCK64
+#endif
+
 #include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-powerpc/fcntl.h b/include/asm-powerpc/fcntl.h
index ce5c451..a399283 100644
--- a/include/asm-powerpc/fcntl.h
+++ b/include/asm-powerpc/fcntl.h
@@ -6,6 +6,10 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 
+#ifndef __powerpc64__
+#define __ARCH_FLOCK64
+#endif
+
 #include <asm-generic/fcntl.h>
 
 #endif /* _ASM_FCNTL_H */
diff --git a/include/asm-s390/fcntl.h b/include/asm-s390/fcntl.h
index 46ab12d..1495a78 100644
--- a/include/asm-s390/fcntl.h
+++ b/include/asm-s390/fcntl.h
@@ -1 +1,4 @@
+#ifndef __s390x__
+#define __ARCH_FLOCK64
+#endif
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-sh/fcntl.h b/include/asm-sh/fcntl.h
index 46ab12d..0128121 100644
--- a/include/asm-sh/fcntl.h
+++ b/include/asm-sh/fcntl.h
@@ -1 +1,2 @@
+#define __ARCH_FLOCK64
 #include <asm-generic/fcntl.h>
diff --git a/include/asm-sh64/fcntl.h b/include/asm-sh64/fcntl.h
index 744dd79..f887490 100644
--- a/include/asm-sh64/fcntl.h
+++ b/include/asm-sh64/fcntl.h
@@ -1 +1,2 @@
+#define __ARCH_FLOCK64
 #include <asm-sh/fcntl.h>
diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
index 5db60b5..ce3e074 100644
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
@@ -30,6 +30,7 @@
 
 #define __ARCH_FLOCK_PAD	short __unused;
 #define __ARCH_FLOCK64_PAD	short __unused;
+#define __ARCH_FLOCK64
 
 #include <asm-generic/fcntl.h>
 
diff --git a/include/asm-v850/fcntl.h b/include/asm-v850/fcntl.h
index 3af4d56..ef49898 100644
--- a/include/asm-v850/fcntl.h
+++ b/include/asm-v850/fcntl.h
@@ -6,6 +6,7 @@
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
 
+#define __ARCH_FLOCK64
 #include <asm-generic/fcntl.h>
 
 #endif /* __V850_FCNTL_H__ */
diff --git a/include/asm-xtensa/fcntl.h b/include/asm-xtensa/fcntl.h
index ec066ae..b1f33a9 100644
--- a/include/asm-xtensa/fcntl.h
+++ b/include/asm-xtensa/fcntl.h
@@ -55,6 +55,7 @@ struct flock64 {
 
 #define HAVE_ARCH_STRUCT_FLOCK
 #define HAVE_ARCH_STRUCT_FLOCK64
+#define __ARCH_FLOCK64
 
 #include <asm-generic/fcntl.h>
 

--

