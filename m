Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSIPHH0>; Mon, 16 Sep 2002 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSIPHH0>; Mon, 16 Sep 2002 03:07:26 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:27579 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315440AbSIPHHU>;
	Mon, 16 Sep 2002 03:07:20 -0400
Date: Mon, 16 Sep 2002 17:12:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: [PATCH] fcntl.h consolidation 17/18
Message-Id: <20020916171205.4dde0744.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sparc64 bit.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-sparc64/fcntl.h 2.5.35-fcntl.1/include/asm-sparc64/fcntl.h
--- 2.5.35/include/asm-sparc64/fcntl.h	2001-09-21 07:11:58.000000000 +1000
+++ 2.5.35-fcntl.1/include/asm-sparc64/fcntl.h	2002-09-16 16:04:22.000000000 +1000
@@ -2,12 +2,6 @@
 #ifndef _SPARC64_FCNTL_H
 #define _SPARC64_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_ACCMODE	0x0003
 #define O_NDELAY	0x0004
 #define O_APPEND	0x0008
 #define FASYNC		0x0040	/* fcntl, for BSD compatibility */
@@ -17,58 +11,27 @@
 #define O_SYNC		0x2000
 #define O_NONBLOCK	0x4000
 #define O_NOCTTY	0x8000	/* not fcntl */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
 
-
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
 
+#define __NO_FCNTL_LK64
 #ifdef __KERNEL__
 #define F_GETLK64	12
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
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
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND	32	/* This is a mandatory flock */
-#define LOCK_READ	64	/* ... Which allows concurrent read operations */
-#define LOCK_WRITE	128	/* ... Which allows concurrent write operations */
-#define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
-
 struct flock {
 	short l_type;
 	short l_whence;
@@ -77,6 +40,7 @@
 	pid_t l_pid;
 	short __unused;
 };
+#define HAVE_ARCH_STRUCT_FLOCK
 
 #ifdef __KERNEL__
 struct flock32 {
@@ -92,6 +56,8 @@
 #ifdef __KERNEL__
 #define flock64	flock
 #endif
+#define HAVE_ARCH_STRUCT_FLOCK64
+
+#include <asm-generic/fcntl.h>
 
-#define F_LINUX_SPECIFIC_BASE	1024
 #endif /* !(_SPARC64_FCNTL_H) */
