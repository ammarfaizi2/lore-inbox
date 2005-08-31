Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVHaHEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHaHEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVHaHDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:54 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:63894 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932401AbVHaHD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:26 -0400
Date: Wed, 31 Aug 2005 16:57:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] Clean up the fcntl operations
Message-Id: <20050831165724.114c4600.sfr@canb.auug.org.au>
In-Reply-To: <20050831165550.7a477884.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
	<20050831165039.3740c832.sfr@canb.auug.org.au>
	<20050831165358.63910cfb.sfr@canb.auug.org.au>
	<20050831165550.7a477884.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the most popular of each fcntl operation/flag into
asm-generic/fcntl.h and cleans up the arch files.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-arm/fcntl.h     |   21 ---------------------
 include/asm-arm26/fcntl.h   |   21 ---------------------
 include/asm-cris/fcntl.h    |   21 ---------------------
 include/asm-frv/fcntl.h     |   21 ---------------------
 include/asm-generic/fcntl.h |   31 +++++++++++++++++++++++++++++++
 include/asm-h8300/fcntl.h   |   21 ---------------------
 include/asm-i386/fcntl.h    |   21 ---------------------
 include/asm-ia64/fcntl.h    |   21 ---------------------
 include/asm-m32r/fcntl.h    |   21 ---------------------
 include/asm-m68k/fcntl.h    |   21 ---------------------
 include/asm-mips/fcntl.h    |   12 ------------
 include/asm-parisc/fcntl.h  |   10 ----------
 include/asm-ppc/fcntl.h     |   21 ---------------------
 include/asm-s390/fcntl.h    |   21 ---------------------
 include/asm-sh/fcntl.h      |   21 ---------------------
 include/asm-sparc/fcntl.h   |    9 ---------
 include/asm-sparc64/fcntl.h |    9 ---------
 include/asm-v850/fcntl.h    |   21 ---------------------
 include/asm-x86_64/fcntl.h  |   21 ---------------------
 include/asm-xtensa/fcntl.h  |   14 --------------
 20 files changed, 31 insertions(+), 348 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-arm/fcntl.h b/include/asm-arm/fcntl.h
--- a/include/asm-arm/fcntl.h
+++ b/include/asm-arm/fcntl.h
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
diff --git a/include/asm-arm26/fcntl.h b/include/asm-arm26/fcntl.h
--- a/include/asm-arm26/fcntl.h
+++ b/include/asm-arm26/fcntl.h
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
diff --git a/include/asm-cris/fcntl.h b/include/asm-cris/fcntl.h
--- a/include/asm-cris/fcntl.h
+++ b/include/asm-cris/fcntl.h
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
diff --git a/include/asm-frv/fcntl.h b/include/asm-frv/fcntl.h
--- a/include/asm-frv/fcntl.h
+++ b/include/asm-frv/fcntl.h
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
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
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
diff --git a/include/asm-h8300/fcntl.h b/include/asm-h8300/fcntl.h
--- a/include/asm-h8300/fcntl.h
+++ b/include/asm-h8300/fcntl.h
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
diff --git a/include/asm-i386/fcntl.h b/include/asm-i386/fcntl.h
--- a/include/asm-i386/fcntl.h
+++ b/include/asm-i386/fcntl.h
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
diff --git a/include/asm-ia64/fcntl.h b/include/asm-ia64/fcntl.h
--- a/include/asm-ia64/fcntl.h
+++ b/include/asm-ia64/fcntl.h
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
diff --git a/include/asm-m32r/fcntl.h b/include/asm-m32r/fcntl.h
--- a/include/asm-m32r/fcntl.h
+++ b/include/asm-m32r/fcntl.h
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
diff --git a/include/asm-m68k/fcntl.h b/include/asm-m68k/fcntl.h
--- a/include/asm-m68k/fcntl.h
+++ b/include/asm-m68k/fcntl.h
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
diff --git a/include/asm-mips/fcntl.h b/include/asm-mips/fcntl.h
--- a/include/asm-mips/fcntl.h
+++ b/include/asm-mips/fcntl.h
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
diff --git a/include/asm-parisc/fcntl.h b/include/asm-parisc/fcntl.h
--- a/include/asm-parisc/fcntl.h
+++ b/include/asm-parisc/fcntl.h
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
diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
--- a/include/asm-ppc/fcntl.h
+++ b/include/asm-ppc/fcntl.h
@@ -6,33 +6,12 @@
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
 #ifndef __powerpc64__
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
diff --git a/include/asm-s390/fcntl.h b/include/asm-s390/fcntl.h
--- a/include/asm-s390/fcntl.h
+++ b/include/asm-s390/fcntl.h
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
diff --git a/include/asm-sh/fcntl.h b/include/asm-sh/fcntl.h
--- a/include/asm-sh/fcntl.h
+++ b/include/asm-sh/fcntl.h
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
diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
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
diff --git a/include/asm-sparc64/fcntl.h b/include/asm-sparc64/fcntl.h
--- a/include/asm-sparc64/fcntl.h
+++ b/include/asm-sparc64/fcntl.h
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
diff --git a/include/asm-v850/fcntl.h b/include/asm-v850/fcntl.h
--- a/include/asm-v850/fcntl.h
+++ b/include/asm-v850/fcntl.h
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
diff --git a/include/asm-x86_64/fcntl.h b/include/asm-x86_64/fcntl.h
--- a/include/asm-x86_64/fcntl.h
+++ b/include/asm-x86_64/fcntl.h
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
diff --git a/include/asm-xtensa/fcntl.h b/include/asm-xtensa/fcntl.h
--- a/include/asm-xtensa/fcntl.h
+++ b/include/asm-xtensa/fcntl.h
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
