Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVG1Q1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVG1Q1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVG1Q0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:26:53 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58840 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261640AbVG1QZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:47 -0400
Date: Fri, 29 Jul 2005 02:25:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] Clean up struct flock64 definitions
Message-Id: <20050729022520.67cfe160.sfr@canb.auug.org.au>
In-Reply-To: <20050729020802.22b7656c.sfr@canb.auug.org.au>
References: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gathers all the struct flock64 definitions (and the operations) and
puts them under !CONFIG_64BIT and cleans up the arch files.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-fcntl.5/include/asm-arm/fcntl.h linus-fcntl.6/include/asm-arm/fcntl.h
--- linus-fcntl.5/include/asm-arm/fcntl.h	2005-07-26 17:50:55.000000000 +1000
+++ linus-fcntl.6/include/asm-arm/fcntl.h	2005-07-26 18:13:16.000000000 +1000
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff -ruNp linus-fcntl.5/include/asm-arm26/fcntl.h linus-fcntl.6/include/asm-arm26/fcntl.h
--- linus-fcntl.5/include/asm-arm26/fcntl.h	2005-07-26 17:51:05.000000000 +1000
+++ linus-fcntl.6/include/asm-arm26/fcntl.h	2005-07-26 18:13:30.000000000 +1000
@@ -8,18 +8,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff -ruNp linus-fcntl.5/include/asm-cris/fcntl.h linus-fcntl.6/include/asm-cris/fcntl.h
--- linus-fcntl.5/include/asm-cris/fcntl.h	2005-07-26 17:51:14.000000000 +1000
+++ linus-fcntl.6/include/asm-cris/fcntl.h	2005-07-26 18:13:45.000000000 +1000
@@ -1,18 +1 @@
-#ifndef _CRIS_FCNTL_H
-#define _CRIS_FCNTL_H
-
-#define F_GETLK64      12      /*  using 'struct flock64' */
-#define F_SETLK64      13
-#define F_SETLKW64     14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff -ruNp linus-fcntl.5/include/asm-frv/fcntl.h linus-fcntl.6/include/asm-frv/fcntl.h
--- linus-fcntl.5/include/asm-frv/fcntl.h	2005-07-26 17:51:25.000000000 +1000
+++ linus-fcntl.6/include/asm-frv/fcntl.h	2005-07-26 18:14:00.000000000 +1000
@@ -1,19 +1 @@
-#ifndef _ASM_FCNTL_H
-#define _ASM_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif /* _ASM_FCNTL_H */
-
diff -ruNp linus-fcntl.5/include/asm-generic/fcntl.h linus-fcntl.6/include/asm-generic/fcntl.h
--- linus-fcntl.5/include/asm-generic/fcntl.h	2005-07-26 18:33:48.000000000 +1000
+++ linus-fcntl.6/include/asm-generic/fcntl.h	2005-07-26 18:33:56.000000000 +1000
@@ -1,6 +1,7 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
+#include <linux/config.h>
 #include <linux/types.h>
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
@@ -121,4 +122,28 @@ struct flock {
 };
 #endif
 
+#ifndef CONFIG_64BIT
+
+#ifndef F_GETLK64
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#define F_SETLK64	13
+#define F_SETLKW64	14
+#endif
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK64
+#ifndef __ARCH_FLOCK64_PAD
+#define __ARCH_FLOCK64_PAD
+#endif
+
+struct flock64 {
+	short  l_type;
+	short  l_whence;
+	loff_t l_start;
+	loff_t l_len;
+	pid_t  l_pid;
+	__ARCH_FLOCK64_PAD
+};
+#endif
+#endif /* !CONFIG_64BIT */
+
 #endif /* _ASM_GENERIC_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-h8300/fcntl.h linus-fcntl.6/include/asm-h8300/fcntl.h
--- linus-fcntl.5/include/asm-h8300/fcntl.h	2005-07-26 17:51:38.000000000 +1000
+++ linus-fcntl.6/include/asm-h8300/fcntl.h	2005-07-26 18:14:15.000000000 +1000
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _H8300_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-i386/fcntl.h linus-fcntl.6/include/asm-i386/fcntl.h
--- linus-fcntl.5/include/asm-i386/fcntl.h	2005-07-26 17:48:37.000000000 +1000
+++ linus-fcntl.6/include/asm-i386/fcntl.h	2005-07-26 18:14:26.000000000 +1000
@@ -1,18 +1 @@
-#ifndef _I386_FCNTL_H
-#define _I386_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff -ruNp linus-fcntl.5/include/asm-m32r/fcntl.h linus-fcntl.6/include/asm-m32r/fcntl.h
--- linus-fcntl.5/include/asm-m32r/fcntl.h	2005-07-26 17:52:22.000000000 +1000
+++ linus-fcntl.6/include/asm-m32r/fcntl.h	2005-07-26 18:14:45.000000000 +1000
@@ -1,18 +1 @@
-#ifndef _ASM_M32R_FCNTL_H
-#define _ASM_M32R_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif  /* _ASM_M32R_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-m68k/fcntl.h linus-fcntl.6/include/asm-m68k/fcntl.h
--- linus-fcntl.5/include/asm-m68k/fcntl.h	2005-07-26 17:52:32.000000000 +1000
+++ linus-fcntl.6/include/asm-m68k/fcntl.h	2005-07-26 18:14:56.000000000 +1000
@@ -6,18 +6,6 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _M68K_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-mips/fcntl.h linus-fcntl.6/include/asm-mips/fcntl.h
--- linus-fcntl.5/include/asm-mips/fcntl.h	2005-07-29 01:05:09.000000000 +1000
+++ linus-fcntl.6/include/asm-mips/fcntl.h	2005-07-29 01:05:20.000000000 +1000
@@ -52,15 +52,6 @@ typedef struct flock {
 	long	pad[4];
 };
 
-typedef struct flock64 {
-	short	l_type;
-	short	l_whence;
-	loff_t	l_start;
-	loff_t	l_len;
-	pid_t	l_pid;
-} flock64_t;
-
-
 #define HAVE_ARCH_STRUCT_FLOCK
 
 #endif
@@ -68,5 +59,8 @@ typedef struct flock64 {
 #include <asm-generic/fcntl.h>
 
 typedef struct flock flock_t;
+#ifndef __mips64
+typedef struct flock64 flock64_t;
+#endif
 
 #endif /* _ASM_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-parisc/fcntl.h linus-fcntl.6/include/asm-parisc/fcntl.h
--- linus-fcntl.5/include/asm-parisc/fcntl.h	2005-07-26 17:53:10.000000000 +1000
+++ linus-fcntl.6/include/asm-parisc/fcntl.h	2005-07-26 18:25:24.000000000 +1000
@@ -33,14 +33,6 @@
 #define F_WRLCK		02
 #define F_UNLCK		03
 
-struct flock64 {
-	short l_type;
-	short l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif
diff -ruNp linus-fcntl.5/include/asm-ppc/fcntl.h linus-fcntl.6/include/asm-ppc/fcntl.h
--- linus-fcntl.5/include/asm-ppc/fcntl.h	2005-07-26 17:53:25.000000000 +1000
+++ linus-fcntl.6/include/asm-ppc/fcntl.h	2005-07-26 18:11:15.000000000 +1000
@@ -8,20 +8,6 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 
-#ifndef CONFIG_64BIT
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-#endif
-
 #include <asm-generic/fcntl.h>
 
 #endif /* _PPC_FCNTL_H */
diff -ruNp linus-fcntl.5/include/asm-s390/fcntl.h linus-fcntl.6/include/asm-s390/fcntl.h
--- linus-fcntl.5/include/asm-s390/fcntl.h	2005-07-26 17:53:43.000000000 +1000
+++ linus-fcntl.6/include/asm-s390/fcntl.h	2005-07-26 18:25:56.000000000 +1000
@@ -1,27 +1 @@
-/*
- *  include/asm-s390/fcntl.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/fcntl.h"
- */
-#ifndef _S390_FCNTL_H
-#define _S390_FCNTL_H
-
-#ifndef __s390x__
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-#endif
-
 #include <asm-generic/fcntl.h>
-
-#endif
diff -ruNp linus-fcntl.5/include/asm-sh/fcntl.h linus-fcntl.6/include/asm-sh/fcntl.h
--- linus-fcntl.5/include/asm-sh/fcntl.h	2005-07-26 17:53:51.000000000 +1000
+++ linus-fcntl.6/include/asm-sh/fcntl.h	2005-07-26 18:21:27.000000000 +1000
@@ -1,19 +1 @@
-#ifndef __ASM_SH_FCNTL_H
-#define __ASM_SH_FCNTL_H
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
-
-#endif /* __ASM_SH_FCNTL_H */
-
diff -ruNp linus-fcntl.5/include/asm-sh64/fcntl.h linus-fcntl.6/include/asm-sh64/fcntl.h
--- linus-fcntl.5/include/asm-sh64/fcntl.h	2005-06-27 16:08:09.000000000 +1000
+++ linus-fcntl.6/include/asm-sh64/fcntl.h	2005-07-26 18:21:40.000000000 +1000
@@ -1,7 +1 @@
-#ifndef __ASM_SH64_FCNTL_H
-#define __ASM_SH64_FCNTL_H
-
 #include <asm-sh/fcntl.h>
-
-#endif /* __ASM_SH64_FCNTL_H */
-
diff -ruNp linus-fcntl.5/include/asm-sparc/fcntl.h linus-fcntl.6/include/asm-sparc/fcntl.h
--- linus-fcntl.5/include/asm-sparc/fcntl.h	2005-07-26 18:31:34.000000000 +1000
+++ linus-fcntl.6/include/asm-sparc/fcntl.h	2005-07-26 18:31:45.000000000 +1000
@@ -23,25 +23,13 @@
 #define F_SETLK		8
 #define F_SETLKW	9
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-struct flock64 {
-	short l_type;
-	short l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t l_pid;
-	short __unused;
-};
-
 #define __ARCH_FLOCK_PAD	short __unused;
+#define __ARCH_FLOCK64_PAD	short __unused;
 
 #include <asm-generic/fcntl.h>
 
diff -ruNp linus-fcntl.5/include/asm-v850/fcntl.h linus-fcntl.6/include/asm-v850/fcntl.h
--- linus-fcntl.5/include/asm-v850/fcntl.h	2005-07-26 17:54:51.000000000 +1000
+++ linus-fcntl.6/include/asm-v850/fcntl.h	2005-07-26 18:22:47.000000000 +1000
@@ -6,18 +6,6 @@
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #include <asm-generic/fcntl.h>
 
 #endif /* __V850_FCNTL_H__ */
diff -ruNp linus-fcntl.5/include/asm-xtensa/fcntl.h linus-fcntl.6/include/asm-xtensa/fcntl.h
--- linus-fcntl.5/include/asm-xtensa/fcntl.h	2005-07-26 17:56:18.000000000 +1000
+++ linus-fcntl.6/include/asm-xtensa/fcntl.h	2005-07-26 18:23:23.000000000 +1000
@@ -54,6 +54,7 @@ struct flock64 {
 };
 
 #define HAVE_ARCH_STRUCT_FLOCK
+#define HAVE_ARCH_STRUCT_FLOCK64
 
 #include <asm-generic/fcntl.h>
 
