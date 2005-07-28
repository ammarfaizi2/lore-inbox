Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVG1RM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVG1RM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVG1Q12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:27:28 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58072 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261639AbVG1QZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:43 -0400
Date: Fri, 29 Jul 2005 02:16:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] Clean up the open flags
Message-Id: <20050729021640.1666b73a.sfr@canb.auug.org.au>
In-Reply-To: <20050729020802.22b7656c.sfr@canb.auug.org.au>
References: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the most popular of each open flag into asm-generic/fcntl.h and cleans
up the arch files.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-fcntl.2/include/asm-alpha/fcntl.h linus-fcntl.3/include/asm-alpha/fcntl.h
--- linus-fcntl.2/include/asm-alpha/fcntl.h	2005-07-26 15:06:41.000000000 +1000
+++ linus-fcntl.3/include/asm-alpha/fcntl.h	2005-07-26 16:04:48.000000000 +1000
@@ -10,9 +10,7 @@
 
 #define O_NONBLOCK	 00004
 #define O_APPEND	 00010
-#define O_NDELAY	O_NONBLOCK
 #define O_SYNC		040000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	0100000	/* must be a directory */
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
diff -ruNp linus-fcntl.2/include/asm-arm/fcntl.h linus-fcntl.3/include/asm-arm/fcntl.h
--- linus-fcntl.2/include/asm-arm/fcntl.h	2005-07-26 15:07:42.000000000 +1000
+++ linus-fcntl.3/include/asm-arm/fcntl.h	2005-07-26 16:06:12.000000000 +1000
@@ -1,22 +1,10 @@
 #ifndef _ARM_FCNTL_H
 #define _ARM_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	 040000	/* must be a directory */
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-arm26/fcntl.h linus-fcntl.3/include/asm-arm26/fcntl.h
--- linus-fcntl.2/include/asm-arm26/fcntl.h	2005-07-26 15:08:25.000000000 +1000
+++ linus-fcntl.3/include/asm-arm26/fcntl.h	2005-07-26 16:07:11.000000000 +1000
@@ -3,20 +3,10 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	 040000	/* must be a directory */
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-cris/fcntl.h linus-fcntl.3/include/asm-cris/fcntl.h
--- linus-fcntl.2/include/asm-cris/fcntl.h	2005-07-26 15:09:10.000000000 +1000
+++ linus-fcntl.3/include/asm-cris/fcntl.h	2005-07-26 16:08:24.000000000 +1000
@@ -1,25 +1,6 @@
 #ifndef _CRIS_FCNTL_H
 #define _CRIS_FCNTL_H
 
-/* verbatim copy of i386 version */
-
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-frv/fcntl.h linus-fcntl.3/include/asm-frv/fcntl.h
--- linus-fcntl.2/include/asm-frv/fcntl.h	2005-07-26 15:10:01.000000000 +1000
+++ linus-fcntl.3/include/asm-frv/fcntl.h	2005-07-26 16:09:12.000000000 +1000
@@ -1,23 +1,6 @@
 #ifndef _ASM_FCNTL_H
 #define _ASM_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-generic/fcntl.h linus-fcntl.3/include/asm-generic/fcntl.h
--- linus-fcntl.2/include/asm-generic/fcntl.h	2005-07-26 15:04:28.000000000 +1000
+++ linus-fcntl.3/include/asm-generic/fcntl.h	2005-07-26 16:29:43.000000000 +1000
@@ -1,10 +1,54 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
-#define O_ACCMODE	0003
-#define O_RDONLY	0000
-#define O_WRONLY	0001
-#define O_RDWR		0002
+/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
+   located on an ext2 file system */
+#define O_ACCMODE	00000003
+#define O_RDONLY	00000000
+#define O_WRONLY	00000001
+#define O_RDWR		00000002
+#ifndef O_CREAT
+#define O_CREAT		00000100	/* not fcntl */
+#endif
+#ifndef O_EXCL
+#define O_EXCL		00000200	/* not fcntl */
+#endif
+#ifndef O_NOCTTY
+#define O_NOCTTY	00000400	/* not fcntl */
+#endif
+#ifndef O_TRUNC
+#define O_TRUNC		00001000	/* not fcntl */
+#endif
+#ifndef O_APPEND
+#define O_APPEND	00002000
+#endif
+#ifndef O_NONBLOCK
+#define O_NONBLOCK	00004000
+#endif
+#ifndef O_SYNC
+#define O_SYNC		00010000
+#endif
+#ifndef FASYNC
+#define FASYNC		00020000	/* fcntl, for BSD compatibility */
+#endif
+#ifndef O_DIRECT
+#define O_DIRECT	00040000	/* direct disk access hint */
+#endif
+#ifndef O_LARGEFILE
+#define O_LARGEFILE	00100000
+#endif
+#ifndef O_DIRECTORY
+#define O_DIRECTORY	00200000	/* must be a directory */
+#endif
+#ifndef O_NOFOLLOW
+#define O_NOFOLLOW	00400000	/* don't follow links */
+#endif
+#ifndef O_NOATIME
+#define O_NOATIME	01000000
+#endif
+#ifndef O_NDELAY
+#define O_NDELAY	O_NONBLOCK
+#endif
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -ruNp linus-fcntl.2/include/asm-h8300/fcntl.h linus-fcntl.3/include/asm-h8300/fcntl.h
--- linus-fcntl.2/include/asm-h8300/fcntl.h	2005-07-26 15:10:44.000000000 +1000
+++ linus-fcntl.3/include/asm-h8300/fcntl.h	2005-07-26 16:10:15.000000000 +1000
@@ -1,22 +1,10 @@
 #ifndef _H8300_FCNTL_H
 #define _H8300_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	040000	/* must be a directory */
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-i386/fcntl.h linus-fcntl.3/include/asm-i386/fcntl.h
--- linus-fcntl.2/include/asm-i386/fcntl.h	2005-07-26 15:11:37.000000000 +1000
+++ linus-fcntl.3/include/asm-i386/fcntl.h	2005-07-26 16:11:05.000000000 +1000
@@ -1,23 +1,6 @@
 #ifndef _I386_FCNTL_H
 #define _I386_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-ia64/fcntl.h linus-fcntl.3/include/asm-ia64/fcntl.h
--- linus-fcntl.2/include/asm-ia64/fcntl.h	2005-07-26 15:12:33.000000000 +1000
+++ linus-fcntl.3/include/asm-ia64/fcntl.h	2005-07-26 16:12:06.000000000 +1000
@@ -1,31 +1,10 @@
 #ifndef _ASM_IA64_FCNTL_H
 #define _ASM_IA64_FCNTL_H
 /*
- * Based on <asm-i386/fcntl.h>.
- *
  * Modified 1998-2000
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co.
  */
 
-/*
- * open/fcntl - O_SYNC is only implemented on blocks devices and on
- * files located on an ext2 file system
- */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-m32r/fcntl.h linus-fcntl.3/include/asm-m32r/fcntl.h
--- linus-fcntl.2/include/asm-m32r/fcntl.h	2005-07-26 15:13:13.000000000 +1000
+++ linus-fcntl.3/include/asm-m32r/fcntl.h	2005-07-26 16:12:42.000000000 +1000
@@ -5,23 +5,6 @@
 
 /* orig : i386 2.4.18 */
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-m68k/fcntl.h linus-fcntl.3/include/asm-m68k/fcntl.h
--- linus-fcntl.2/include/asm-m68k/fcntl.h	2005-07-26 15:13:50.000000000 +1000
+++ linus-fcntl.3/include/asm-m68k/fcntl.h	2005-07-26 16:13:29.000000000 +1000
@@ -1,22 +1,10 @@
 #ifndef _M68K_FCNTL_H
 #define _M68K_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	040000	/* must be a directory */
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-mips/fcntl.h linus-fcntl.3/include/asm-mips/fcntl.h
--- linus-fcntl.2/include/asm-mips/fcntl.h	2005-07-26 15:14:54.000000000 +1000
+++ linus-fcntl.3/include/asm-mips/fcntl.h	2005-07-26 16:16:50.000000000 +1000
@@ -8,23 +8,15 @@
 #ifndef _ASM_FCNTL_H
 #define _ASM_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
 #define O_APPEND	0x0008
 #define O_SYNC		0x0010
 #define O_NONBLOCK	0x0080
 #define O_CREAT         0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
 #define O_EXCL		0x0400	/* not fcntl */
 #define O_NOCTTY	0x0800	/* not fcntl */
 #define FASYNC		0x1000	/* fcntl, for BSD compatibility */
 #define O_LARGEFILE	0x2000	/* allow large file opens */
 #define O_DIRECT	0x8000	/* direct disk access hint */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
-#define O_NOATIME	0x40000
-
-#define O_NDELAY	O_NONBLOCK
 
 #define F_GETLK		14
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-parisc/fcntl.h linus-fcntl.3/include/asm-parisc/fcntl.h
--- linus-fcntl.2/include/asm-parisc/fcntl.h	2005-07-26 15:15:34.000000000 +1000
+++ linus-fcntl.3/include/asm-parisc/fcntl.h	2005-07-26 16:18:04.000000000 +1000
@@ -6,19 +6,15 @@
 #define O_APPEND	00000010
 #define O_BLKSEEK	00000100 /* HPUX only */
 #define O_CREAT		00000400 /* not fcntl */
-#define O_TRUNC		00001000 /* not fcntl */
 #define O_EXCL		00002000 /* not fcntl */
 #define O_LARGEFILE	00004000
 #define O_SYNC		00100000
 #define O_NONBLOCK	00200004 /* HPUX has separate NDELAY & NONBLOCK */
-#define O_NDELAY	O_NONBLOCK
 #define O_NOCTTY	00400000 /* not fcntl */
 #define O_DSYNC		01000000 /* HPUX only */
 #define O_RSYNC		02000000 /* HPUX only */
 #define O_NOATIME	04000000
 
-#define FASYNC		00020000 /* fcntl, for BSD compatibility */
-#define O_DIRECT	00040000 /* direct disk access hint - currently ignored */
 #define O_DIRECTORY	00010000 /* must be a directory */
 #define O_NOFOLLOW	00000200 /* don't follow links */
 #define O_INVISIBLE	04000000 /* invisible I/O, for DMAPI/XDSM */
diff -ruNp linus-fcntl.2/include/asm-ppc/fcntl.h linus-fcntl.3/include/asm-ppc/fcntl.h
--- linus-fcntl.2/include/asm-ppc/fcntl.h	2005-07-26 15:29:57.000000000 +1000
+++ linus-fcntl.3/include/asm-ppc/fcntl.h	2005-07-26 16:19:00.000000000 +1000
@@ -3,22 +3,10 @@
 
 #include <linux/config.h>
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY      040000	/* must be a directory */
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-s390/fcntl.h linus-fcntl.3/include/asm-s390/fcntl.h
--- linus-fcntl.2/include/asm-s390/fcntl.h	2005-07-26 15:18:50.000000000 +1000
+++ linus-fcntl.3/include/asm-s390/fcntl.h	2005-07-26 16:19:51.000000000 +1000
@@ -8,23 +8,6 @@
 #ifndef _S390_FCNTL_H
 #define _S390_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-sh/fcntl.h linus-fcntl.3/include/asm-sh/fcntl.h
--- linus-fcntl.2/include/asm-sh/fcntl.h	2005-07-26 15:19:19.000000000 +1000
+++ linus-fcntl.3/include/asm-sh/fcntl.h	2005-07-26 16:20:35.000000000 +1000
@@ -1,23 +1,6 @@
 #ifndef __ASM_SH_FCNTL_H
 #define __ASM_SH_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-sparc/fcntl.h linus-fcntl.3/include/asm-sparc/fcntl.h
--- linus-fcntl.2/include/asm-sparc/fcntl.h	2005-07-26 15:20:28.000000000 +1000
+++ linus-fcntl.3/include/asm-sparc/fcntl.h	2005-07-26 16:23:08.000000000 +1000
@@ -13,8 +13,6 @@
 #define O_NONBLOCK	0x4000
 #define O_NDELAY	(0x0004 | O_NONBLOCK)
 #define O_NOCTTY	0x8000	/* not fcntl */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
 #define O_NOATIME	0x200000
diff -ruNp linus-fcntl.2/include/asm-sparc64/fcntl.h linus-fcntl.3/include/asm-sparc64/fcntl.h
--- linus-fcntl.2/include/asm-sparc64/fcntl.h	2005-07-26 15:21:09.000000000 +1000
+++ linus-fcntl.3/include/asm-sparc64/fcntl.h	2005-07-26 16:25:22.000000000 +1000
@@ -13,8 +13,6 @@
 #define O_SYNC		0x2000
 #define O_NONBLOCK	0x4000
 #define O_NOCTTY	0x8000	/* not fcntl */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
 #define O_NOATIME	0x200000
diff -ruNp linus-fcntl.2/include/asm-v850/fcntl.h linus-fcntl.3/include/asm-v850/fcntl.h
--- linus-fcntl.2/include/asm-v850/fcntl.h	2005-07-26 15:21:54.000000000 +1000
+++ linus-fcntl.3/include/asm-v850/fcntl.h	2005-07-26 16:26:06.000000000 +1000
@@ -1,22 +1,10 @@
 #ifndef __V850_FCNTL_H__
 #define __V850_FCNTL_H__
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	040000	/* must be a directory */
 #define O_NOFOLLOW     0100000	/* don't follow links */
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
-#define O_NOATIME	01000000
 
 #define F_GETLK		5
 #define F_SETLK		6
diff -ruNp linus-fcntl.2/include/asm-x86_64/fcntl.h linus-fcntl.3/include/asm-x86_64/fcntl.h
--- linus-fcntl.2/include/asm-x86_64/fcntl.h	2005-07-26 15:22:29.000000000 +1000
+++ linus-fcntl.3/include/asm-x86_64/fcntl.h	2005-07-26 16:26:44.000000000 +1000
@@ -1,23 +1,6 @@
 #ifndef _X86_64_FCNTL_H
 #define _X86_64_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-#define O_NOATIME	01000000
-
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
diff -ruNp linus-fcntl.2/include/asm-xtensa/fcntl.h linus-fcntl.3/include/asm-xtensa/fcntl.h
--- linus-fcntl.2/include/asm-xtensa/fcntl.h	2005-07-26 15:23:10.000000000 +1000
+++ linus-fcntl.3/include/asm-xtensa/fcntl.h	2005-07-26 16:29:34.000000000 +1000
@@ -18,18 +18,13 @@
 #define O_SYNC		0x0010
 #define O_NONBLOCK	0x0080
 #define O_CREAT         0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
 #define O_EXCL		0x0400	/* not fcntl */
 #define O_NOCTTY	0x0800	/* not fcntl */
 #define FASYNC		0x1000	/* fcntl, for BSD compatibility */
 #define O_LARGEFILE	0x2000	/* allow large file opens - currently ignored */
 #define O_DIRECT	0x8000	/* direct disk access hint - currently ignored*/
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_NOATIME	0x100000
 
-#define O_NDELAY	O_NONBLOCK
-
 #define F_GETLK		14
 #define F_GETLK64       15
 #define F_SETLK		6
