Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSIPGr2>; Mon, 16 Sep 2002 02:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSIPGr2>; Mon, 16 Sep 2002 02:47:28 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:14777 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313190AbSIPGr0>;
	Mon, 16 Sep 2002 02:47:26 -0400
Date: Mon, 16 Sep 2002 16:52:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fcntl.h consolidation 2/18
Message-Id: <20020916165216.2a39be6c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Alpha part of the patch.

[Does anyone want to put their hands up to be Alpha maintainer?]
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-alpha/fcntl.h 2.5.35-fcntl.1/include/asm-alpha/fcntl.h
--- 2.5.35/include/asm-alpha/fcntl.h	2001-09-18 06:16:30.000000000 +1000
+++ 2.5.35-fcntl.1/include/asm-alpha/fcntl.h	2002-09-16 16:04:22.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ALPHA_FCNTL_H
 #define _ALPHA_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
 #define O_CREAT		 01000	/* not fcntl */
 #define O_TRUNC		 02000	/* not fcntl */
 #define O_EXCL		 04000	/* not fcntl */
@@ -14,53 +8,27 @@
 
 #define O_NONBLOCK	 00004
 #define O_APPEND	 00010
-#define O_NDELAY	O_NONBLOCK
 #define O_SYNC		040000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
 #define O_DIRECTORY	0100000	/* must be a directory */
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4       /* set file->f_flags */
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
 
 #define F_SETOWN	5	/*  for sockets. */
 #define F_GETOWN	6	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
 #define F_UNLCK		8
 
-/* for old implementation of bsd flock () */
-#define F_EXLCK		16	/* or 3 */
-#define F_SHLCK		32	/* or 4 */
-
+/* for leases */
 #define F_INPROGRESS	64
 
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-#define LOCK_MAND      32      /* This is a mandatory flock */
-#define LOCK_READ      64      /* ... Which allows concurrent read operations */
-#define LOCK_WRITE     128     /* ... Which allows concurrent write operations */
-#define LOCK_RW        192     /* ... Which allows concurrent read & write ops */
- 
 struct flock {
 	short l_type;
 	short l_whence;
@@ -68,10 +36,15 @@
 	__kernel_off_t l_len;
 	__kernel_pid_t l_pid;
 };
+#define HAVE_ARCH_STRUCT_FLOCK
 
 #ifdef __KERNEL__
 #define flock64	flock
 #endif
-#define F_LINUX_SPECIFIC_BASE  1024
+#define HAVE_ARCH_STRUCT_FLOCK64
+
+#define __NO_FCNTL_LK64
+
+#include <asm-generic/fcntl.h>
 
 #endif
