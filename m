Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVG1RM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVG1RM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVG1Q1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:27:15 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58328 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261625AbVG1QZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:44 -0400
Date: Fri, 29 Jul 2005 02:19:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] Clean up the fcntl operations
Message-Id: <20050729021909.1911fd04.sfr@canb.auug.org.au>
In-Reply-To: <20050729020802.22b7656c.sfr@canb.auug.org.au>
References: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the most popular of each fcntl operation/flag into
asm-generic/fcntl.h and cleans up the arch files.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-fcntl.3/include/asm-arm/fcntl.h linus-fcntl.4/include/asm-arm/fcntl.h
--- linus-fcntl.3/include/asm-arm/fcntl.h	2005-07-26 16:06:12.000000000 +1000
+++ linus-fcntl.4/include/asm-arm/fcntl.h	2005-07-26 16:47:14.000000000 +1000
@@ -6,31 +6,10 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-arm26/fcntl.h linus-fcntl.4/include/asm-arm26/fcntl.h
--- linus-fcntl.3/include/asm-arm26/fcntl.h	2005-07-26 16:07:11.000000000 +1000
+++ linus-fcntl.4/include/asm-arm26/fcntl.h	2005-07-26 16:47:44.000000000 +1000
@@ -8,31 +8,10 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-cris/fcntl.h linus-fcntl.4/include/asm-cris/fcntl.h
--- linus-fcntl.3/include/asm-cris/fcntl.h	2005-07-26 16:08:24.000000000 +1000
+++ linus-fcntl.4/include/asm-cris/fcntl.h	2005-07-26 16:48:19.000000000 +1000
@@ -1,31 +1,10 @@
 #ifndef _CRIS_FCNTL_H
 #define _CRIS_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64      12      /*  using 'struct flock64' */
 #define F_SETLK64      13
 #define F_SETLKW64     14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS   16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-frv/fcntl.h linus-fcntl.4/include/asm-frv/fcntl.h
--- linus-fcntl.3/include/asm-frv/fcntl.h	2005-07-26 16:09:12.000000000 +1000
+++ linus-fcntl.4/include/asm-frv/fcntl.h	2005-07-26 16:48:50.000000000 +1000
@@ -1,31 +1,10 @@
 #ifndef _ASM_FCNTL_H
 #define _ASM_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-generic/fcntl.h linus-fcntl.4/include/asm-generic/fcntl.h
--- linus-fcntl.3/include/asm-generic/fcntl.h	2005-07-26 16:29:43.000000000 +1000
+++ linus-fcntl.4/include/asm-generic/fcntl.h	2005-07-26 17:02:11.000000000 +1000
@@ -55,10 +55,41 @@
 #define F_SETFD		2	/* set/clear close_on_exec */
 #define F_GETFL		3	/* get file->f_flags */
 #define F_SETFL		4	/* set file->f_flags */
+#ifndef F_GETLK
+#define F_GETLK		5
+#define F_SETLK		6
+#define F_SETLKW	7
+#endif
+#ifndef F_SETOWN
+#define F_SETOWN	8	/* for sockets. */
+#define F_GETOWN	9	/* for sockets. */
+#endif
+#ifndef F_SETSIG
+#define F_SETSIG	10	/* for sockets. */
+#define F_GETSIG	11	/* for sockets. */
+#endif
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
+/* for posix fcntl() and lockf() */
+#ifndef F_RDLCK
+#define F_RDLCK		0
+#define F_WRLCK		1
+#define F_UNLCK		2
+#endif
+
+/* for old implementation of bsd flock () */
+#ifndef F_EXLCK
+#define F_EXLCK		4	/* or 3 */
+#define F_SHLCK		8	/* or 4 */
+#endif
+
+/* for leases */
+#ifndef F_INPROGRESS
+#define F_INPROGRESS	16
+#endif
+
 /* operations for bsd flock(), also used by the kernel implementation */
 #define LOCK_SH		1	/* shared lock */
 #define LOCK_EX		2	/* exclusive lock */
diff -ruNp linus-fcntl.3/include/asm-h8300/fcntl.h linus-fcntl.4/include/asm-h8300/fcntl.h
--- linus-fcntl.3/include/asm-h8300/fcntl.h	2005-07-26 16:10:15.000000000 +1000
+++ linus-fcntl.4/include/asm-h8300/fcntl.h	2005-07-26 16:49:30.000000000 +1000
@@ -6,31 +6,10 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-i386/fcntl.h linus-fcntl.4/include/asm-i386/fcntl.h
--- linus-fcntl.3/include/asm-i386/fcntl.h	2005-07-26 16:11:05.000000000 +1000
+++ linus-fcntl.4/include/asm-i386/fcntl.h	2005-07-26 16:50:00.000000000 +1000
@@ -1,31 +1,10 @@
 #ifndef _I386_FCNTL_H
 #define _I386_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-ia64/fcntl.h linus-fcntl.4/include/asm-ia64/fcntl.h
--- linus-fcntl.3/include/asm-ia64/fcntl.h	2005-07-26 16:12:06.000000000 +1000
+++ linus-fcntl.4/include/asm-ia64/fcntl.h	2005-07-26 16:50:15.000000000 +1000
@@ -5,27 +5,6 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co.
  */
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-m32r/fcntl.h linus-fcntl.4/include/asm-m32r/fcntl.h
--- linus-fcntl.3/include/asm-m32r/fcntl.h	2005-07-26 16:12:42.000000000 +1000
+++ linus-fcntl.4/include/asm-m32r/fcntl.h	2005-07-26 16:50:39.000000000 +1000
@@ -5,31 +5,10 @@
 
 /* orig : i386 2.4.18 */
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-m68k/fcntl.h linus-fcntl.4/include/asm-m68k/fcntl.h
--- linus-fcntl.3/include/asm-m68k/fcntl.h	2005-07-26 16:13:29.000000000 +1000
+++ linus-fcntl.4/include/asm-m68k/fcntl.h	2005-07-26 16:51:08.000000000 +1000
@@ -6,31 +6,10 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-mips/fcntl.h linus-fcntl.4/include/asm-mips/fcntl.h
--- linus-fcntl.3/include/asm-mips/fcntl.h	2005-07-26 16:16:50.000000000 +1000
+++ linus-fcntl.4/include/asm-mips/fcntl.h	2005-07-26 16:52:09.000000000 +1000
@@ -33,18 +33,6 @@
 #define F_SETLKW64	35
 #endif
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 /*
  * The flavours of struct flock.  "struct flock" is the ABI compliant
  * variant.  Finally struct flock64 is the LFS variant of struct flock.  As
diff -ruNp linus-fcntl.3/include/asm-parisc/fcntl.h linus-fcntl.4/include/asm-parisc/fcntl.h
--- linus-fcntl.3/include/asm-parisc/fcntl.h	2005-07-26 16:18:04.000000000 +1000
+++ linus-fcntl.4/include/asm-parisc/fcntl.h	2005-07-26 16:53:18.000000000 +1000
@@ -19,9 +19,6 @@
 #define O_NOFOLLOW	00000200 /* don't follow links */
 #define O_INVISIBLE	04000000 /* invisible I/O, for DMAPI/XDSM */
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
 #define F_GETLK64	8
 #define F_SETLK64	9
 #define F_SETLKW64	10
@@ -36,13 +33,6 @@
 #define F_WRLCK		02
 #define F_UNLCK		03
 
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-ppc/fcntl.h linus-fcntl.4/include/asm-ppc/fcntl.h
--- linus-fcntl.3/include/asm-ppc/fcntl.h	2005-07-26 16:19:00.000000000 +1000
+++ linus-fcntl.4/include/asm-ppc/fcntl.h	2005-07-26 16:53:47.000000000 +1000
@@ -8,33 +8,12 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #ifndef CONFIG_64BIT
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-s390/fcntl.h linus-fcntl.4/include/asm-s390/fcntl.h
--- linus-fcntl.3/include/asm-s390/fcntl.h	2005-07-26 16:19:51.000000000 +1000
+++ linus-fcntl.4/include/asm-s390/fcntl.h	2005-07-26 16:54:10.000000000 +1000
@@ -8,33 +8,12 @@
 #ifndef _S390_FCNTL_H
 #define _S390_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #ifndef __s390x__
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif /* ! __s390x__ */
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-sh/fcntl.h linus-fcntl.4/include/asm-sh/fcntl.h
--- linus-fcntl.3/include/asm-sh/fcntl.h	2005-07-26 16:20:35.000000000 +1000
+++ linus-fcntl.4/include/asm-sh/fcntl.h	2005-07-26 16:54:41.000000000 +1000
@@ -1,31 +1,10 @@
 #ifndef __ASM_SH_FCNTL_H
 #define __ASM_SH_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-sparc/fcntl.h linus-fcntl.4/include/asm-sparc/fcntl.h
--- linus-fcntl.3/include/asm-sparc/fcntl.h	2005-07-26 16:23:08.000000000 +1000
+++ linus-fcntl.4/include/asm-sparc/fcntl.h	2005-07-26 16:55:19.000000000 +1000
@@ -22,8 +22,6 @@
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
 
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
@@ -34,13 +32,6 @@
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-sparc64/fcntl.h linus-fcntl.4/include/asm-sparc64/fcntl.h
--- linus-fcntl.3/include/asm-sparc64/fcntl.h	2005-07-26 16:25:22.000000000 +1000
+++ linus-fcntl.4/include/asm-sparc64/fcntl.h	2005-07-26 16:55:34.000000000 +1000
@@ -23,21 +23,12 @@
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
 
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
 #define F_UNLCK		3
 
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-v850/fcntl.h linus-fcntl.4/include/asm-v850/fcntl.h
--- linus-fcntl.3/include/asm-v850/fcntl.h	2005-07-26 16:26:06.000000000 +1000
+++ linus-fcntl.4/include/asm-v850/fcntl.h	2005-07-26 16:55:58.000000000 +1000
@@ -6,31 +6,10 @@
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short l_type;
 	short l_whence;
diff -ruNp linus-fcntl.3/include/asm-x86_64/fcntl.h linus-fcntl.4/include/asm-x86_64/fcntl.h
--- linus-fcntl.3/include/asm-x86_64/fcntl.h	2005-07-26 16:26:44.000000000 +1000
+++ linus-fcntl.4/include/asm-x86_64/fcntl.h	2005-07-26 16:56:26.000000000 +1000
@@ -1,27 +1,6 @@
 #ifndef _X86_64_FCNTL_H
 #define _X86_64_FCNTL_H
 
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
 struct flock {
 	short  l_type;
 	short  l_whence;
diff -ruNp linus-fcntl.3/include/asm-xtensa/fcntl.h linus-fcntl.4/include/asm-xtensa/fcntl.h
--- linus-fcntl.3/include/asm-xtensa/fcntl.h	2005-07-26 16:29:34.000000000 +1000
+++ linus-fcntl.4/include/asm-xtensa/fcntl.h	2005-07-26 16:57:07.000000000 +1000
@@ -34,20 +34,6 @@
 
 #define F_SETOWN	24	/*  for sockets. */
 #define F_GETOWN	23	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
 
 typedef struct flock {
 	short l_type;
