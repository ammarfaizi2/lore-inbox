Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSIPHCP>; Mon, 16 Sep 2002 03:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSIPHCP>; Mon, 16 Sep 2002 03:02:15 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:62138 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313898AbSIPHCK>;
	Mon, 16 Sep 2002 03:02:10 -0400
Date: Mon, 16 Sep 2002 17:07:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
Subject: [PATCH] fcntl.h consolidation 14/18
Message-Id: <20020916170701.516fb4fb.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The S390x part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-s390x/fcntl.h 2.5.35-fcntl.1/include/asm-s390x/fcntl.h
--- 2.5.35/include/asm-s390x/fcntl.h	2001-11-10 09:11:15.000000000 +1100
+++ 2.5.35-fcntl.1/include/asm-s390x/fcntl.h	2002-09-16 16:04:22.000000000 +1000
@@ -2,73 +2,11 @@
  *  include/asm-s390/fcntl.h
  *
  *  S390 version
- *
- *  Derived from "include/asm-i386/fcntl.h"
  */
 #ifndef _S390_FCNTL_H
 #define _S390_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
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
-
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
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
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND	32	/* This is a mandatory flock */
-#define LOCK_READ	64	/* ... Which allows concurrent read operations */
-#define LOCK_WRITE	128	/* ... Which allows concurrent write operations
-*/
-#define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
+#define __NO_FCNTL_LK64
 
 struct flock {
 	short l_type;
@@ -77,9 +15,11 @@
 	__kernel_off_t l_len;
 	__kernel_pid_t l_pid;
 };
-
-#define F_LINUX_SPECIFIC_BASE  1024
+#define HAVE_ARCH_STRUCT_FLOCK
 
 #define flock64   flock
+#define HAVE_ARCH_STRUCT_FLOCK64
+
+#include <asm-generic/fcntl.h>
 
 #endif
