Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVHaHD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVHaHD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVHaHDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:60822 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932401AbVHaHDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:23 -0400
Date: Wed, 31 Aug 2005 16:50:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] Create asm-generic/fcntl.h
Message-Id: <20050831165039.3740c832.sfr@canb.auug.org.au>
In-Reply-To: <20050831164738.6cee5830.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just gathers all the identical bits of the asm-*/fcntl.h
files into asm-generic/fcntl.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-alpha/fcntl.h   |   25 +------------------------
 include/asm-arm/fcntl.h     |   27 ++-------------------------
 include/asm-arm26/fcntl.h   |   27 ++-------------------------
 include/asm-cris/fcntl.h    |   26 +-------------------------
 include/asm-frv/fcntl.h     |   27 ++-------------------------
 include/asm-generic/fcntl.h |   32 ++++++++++++++++++++++++++++++++
 include/asm-h8300/fcntl.h   |   27 ++-------------------------
 include/asm-i386/fcntl.h    |   26 +-------------------------
 include/asm-ia64/fcntl.h    |   28 ++--------------------------
 include/asm-m32r/fcntl.h    |   26 +-------------------------
 include/asm-m68k/fcntl.h    |   27 ++-------------------------
 include/asm-mips/fcntl.h    |   26 +-------------------------
 include/asm-parisc/fcntl.h  |   26 +-------------------------
 include/asm-ppc/fcntl.h     |   27 ++-------------------------
 include/asm-ppc64/fcntl.h   |   26 +-------------------------
 include/asm-s390/fcntl.h    |   28 +++-------------------------
 include/asm-sh/fcntl.h      |   27 ++-------------------------
 include/asm-sparc/fcntl.h   |   27 ++-------------------------
 include/asm-sparc64/fcntl.h |   26 +-------------------------
 include/asm-v850/fcntl.h    |   27 ++-------------------------
 include/asm-x86_64/fcntl.h  |   26 +-------------------------
 include/asm-xtensa/fcntl.h  |   26 +-------------------------
 22 files changed, 65 insertions(+), 525 deletions(-)
 create mode 100644 include/asm-generic/fcntl.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-alpha/fcntl.h b/include/asm-alpha/fcntl.h
--- a/include/asm-alpha/fcntl.h
+++ b/include/asm-alpha/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
 #define O_CREAT		 01000	/* not fcntl */
 #define O_TRUNC		 02000	/* not fcntl */
 #define O_EXCL		 04000	/* not fcntl */
@@ -23,11 +19,6 @@
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 #define O_NOATIME	04000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4       /* set file->f_flags */
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
@@ -37,9 +28,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
@@ -51,17 +39,6 @@
 
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
@@ -70,6 +47,6 @@ struct flock {
 	__kernel_pid_t l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE  1024
+#include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-arm/fcntl.h b/include/asm-arm/fcntl.h
--- a/include/asm-arm/fcntl.h
+++ b/include/asm-arm/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,5 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif
diff --git a/include/asm-arm26/fcntl.h b/include/asm-arm26/fcntl.h
--- a/include/asm-arm26/fcntl.h
+++ b/include/asm-arm26/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,5 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif
diff --git a/include/asm-cris/fcntl.h b/include/asm-cris/fcntl.h
--- a/include/asm-cris/fcntl.h
+++ b/include/asm-cris/fcntl.h
@@ -5,10 +5,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -24,11 +20,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get f_flags */
-#define F_SETFD		2	/* set f_flags */
-#define F_GETFL		3	/* more flags (cloexec) */
-#define F_SETFL		4
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -42,9 +33,6 @@
 #define F_SETLK64      13
 #define F_SETLKW64     14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -57,18 +45,6 @@
 /* for leases */
 #define F_INPROGRESS   16
 
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND      32      /* This is a mandatory flock */
-#define LOCK_READ      64      /* ... Which allows concurrent read operations */
-#define LOCK_WRITE     128     /* ... Which allows concurrent write operations */
-#define LOCK_RW        192     /* ... Which allows concurrent read & write ops */
-
 struct flock {
 	short l_type;
 	short l_whence;
@@ -85,6 +61,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE  1024
+#include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-frv/fcntl.h b/include/asm-frv/fcntl.h
--- a/include/asm-frv/fcntl.h
+++ b/include/asm-frv/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,6 +59,7 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif /* _ASM_FCNTL_H */
 
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
new file mode 100644
--- /dev/null
+++ b/include/asm-generic/fcntl.h
@@ -0,0 +1,32 @@
+#ifndef _ASM_GENERIC_FCNTL_H
+#define _ASM_GENERIC_FCNTL_H
+
+#define O_ACCMODE	0003
+#define O_RDONLY	0000
+#define O_WRONLY	0001
+#define O_RDWR		0002
+
+#define F_DUPFD		0	/* dup */
+#define F_GETFD		1	/* get close_on_exec */
+#define F_SETFD		2	/* set/clear close_on_exec */
+#define F_GETFL		3	/* get file->f_flags */
+#define F_SETFL		4	/* set file->f_flags */
+
+/* for F_[GET|SET]FL */
+#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+
+/* operations for bsd flock(), also used by the kernel implementation */
+#define LOCK_SH		1	/* shared lock */
+#define LOCK_EX		2	/* exclusive lock */
+#define LOCK_NB		4	/* or'd with one of the above to prevent
+				   blocking */
+#define LOCK_UN		8	/* remove lock */
+
+#define LOCK_MAND	32	/* This is a mandatory flock ... */
+#define LOCK_READ	64	/* which allows concurrent read operations */
+#define LOCK_WRITE	128	/* which allows concurrent write operations */
+#define LOCK_RW		192	/* which allows concurrent read & write ops */
+
+#define F_LINUX_SPECIFIC_BASE	1024
+
+#endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/include/asm-h8300/fcntl.h b/include/asm-h8300/fcntl.h
--- a/include/asm-h8300/fcntl.h
+++ b/include/asm-h8300/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
 #define O_CREAT		  0100	/* not fcntl */
 #define O_EXCL		  0200	/* not fcntl */
 #define O_NOCTTY	  0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,5 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif /* _H8300_FCNTL_H */
diff --git a/include/asm-i386/fcntl.h b/include/asm-i386/fcntl.h
--- a/include/asm-i386/fcntl.h
+++ b/include/asm-i386/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,6 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-ia64/fcntl.h b/include/asm-ia64/fcntl.h
--- a/include/asm-ia64/fcntl.h
+++ b/include/asm-ia64/fcntl.h
@@ -11,10 +11,6 @@
  * open/fcntl - O_SYNC is only implemented on blocks devices and on
  * files located on an ext2 file system
  */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -30,11 +26,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -44,9 +35,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -59,18 +47,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -79,8 +55,8 @@ struct flock {
 	pid_t l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
-
 #define force_o_largefile() ( ! (current->personality & PER_LINUX32) )
 
+#include <asm-generic/fcntl.h>
+
 #endif /* _ASM_IA64_FCNTL_H */
diff --git a/include/asm-m32r/fcntl.h b/include/asm-m32r/fcntl.h
--- a/include/asm-m32r/fcntl.h
+++ b/include/asm-m32r/fcntl.h
@@ -7,10 +7,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -26,11 +22,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -44,9 +35,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -59,18 +47,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -87,6 +63,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif  /* _ASM_M32R_FCNTL_H */
diff --git a/include/asm-m68k/fcntl.h b/include/asm-m68k/fcntl.h
--- a/include/asm-m68k/fcntl.h
+++ b/include/asm-m68k/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
 #define O_CREAT		  0100	/* not fcntl */
 #define O_EXCL		  0200	/* not fcntl */
 #define O_NOCTTY	  0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,5 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif /* _M68K_FCNTL_H */
diff --git a/include/asm-mips/fcntl.h b/include/asm-mips/fcntl.h
--- a/include/asm-mips/fcntl.h
+++ b/include/asm-mips/fcntl.h
@@ -10,10 +10,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	0x0003
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
 #define O_APPEND	0x0008
 #define O_SYNC		0x0010
 #define O_NONBLOCK	0x0080
@@ -30,11 +26,6 @@
 
 #define O_NDELAY	O_NONBLOCK
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		14
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -50,9 +41,6 @@
 #define F_SETLKW64	35
 #endif
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -65,18 +53,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
 /*
  * The flavours of struct flock.  "struct flock" is the ABI compliant
  * variant.  Finally struct flock64 is the LFS variant of struct flock.  As
@@ -120,6 +96,6 @@ typedef struct flock {
 
 #endif
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif /* _ASM_FCNTL_H */
diff --git a/include/asm-parisc/fcntl.h b/include/asm-parisc/fcntl.h
--- a/include/asm-parisc/fcntl.h
+++ b/include/asm-parisc/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	00000003
-#define O_RDONLY	00000000
-#define O_WRONLY	00000001
-#define O_RDWR		00000002
 #define O_APPEND	00000010
 #define O_BLKSEEK	00000100 /* HPUX only */
 #define O_CREAT		00000400 /* not fcntl */
@@ -27,11 +23,6 @@
 #define O_NOFOLLOW	00000200 /* don't follow links */
 #define O_INVISIBLE	04000000 /* invisible I/O, for DMAPI/XDSM */
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get f_flags */
-#define F_SETFD		2	/* set f_flags */
-#define F_GETFL		3	/* more flags (cloexec) */
-#define F_SETFL		4
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -44,9 +35,6 @@
 #define F_SETSIG	13	/*  for sockets. */
 #define F_GETSIG	14	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		01
 #define F_WRLCK		02
@@ -59,18 +47,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -87,6 +63,6 @@ struct flock64 {
 	pid_t l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE  1024
+#include <asm-generic/fcntl.h>
 
 #endif
diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
--- a/include/asm-ppc/fcntl.h
+++ b/include/asm-ppc/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_DIRECT	0400000	/* direct disk access hint */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
 #ifdef __KERNEL__
 #define F_POSIX		1
 #define F_FLOCK		2
@@ -89,5 +65,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif
diff --git a/include/asm-ppc64/fcntl.h b/include/asm-ppc64/fcntl.h
--- a/include/asm-ppc64/fcntl.h
+++ b/include/asm-ppc64/fcntl.h
@@ -10,10 +10,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -29,11 +25,6 @@
 #define O_DIRECT	0400000	/* direct disk access hint */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -43,9 +34,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -58,18 +46,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
 #ifdef __KERNEL__
 #define F_POSIX		1
 #define F_FLOCK		2
@@ -84,6 +60,6 @@ struct flock {
 	pid_t l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif /* _PPC64_FCNTL_H */
diff --git a/include/asm-s390/fcntl.h b/include/asm-s390/fcntl.h
--- a/include/asm-s390/fcntl.h
+++ b/include/asm-s390/fcntl.h
@@ -10,10 +10,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -29,11 +25,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -49,9 +40,6 @@
 #define F_SETLKW64	14
 #endif /* ! __s390x__ */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -64,18 +52,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -93,5 +69,7 @@ struct flock64 {
 	pid_t  l_pid;
 };
 #endif
-#define F_LINUX_SPECIFIC_BASE	1024
+
+#include <asm-generic/fcntl.h>
+
 #endif
diff --git a/include/asm-sh/fcntl.h b/include/asm-sh/fcntl.h
--- a/include/asm-sh/fcntl.h
+++ b/include/asm-sh/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,6 +59,7 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif /* __ASM_SH_FCNTL_H */
 
diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
@@ -4,10 +4,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_ACCMODE	0x0003
 #define O_APPEND	0x0008
 #define FASYNC		0x0040	/* fcntl, for BSD compatibility */
 #define O_CREAT		0x0200	/* not fcntl */
@@ -23,11 +19,6 @@
 #define O_DIRECT        0x100000 /* direct disk access hint */
 #define O_NOATIME	0x200000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
 #define F_GETLK		7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -85,5 +61,6 @@ struct flock64 {
 	short __unused;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif
diff --git a/include/asm-sparc64/fcntl.h b/include/asm-sparc64/fcntl.h
--- a/include/asm-sparc64/fcntl.h
+++ b/include/asm-sparc64/fcntl.h
@@ -4,10 +4,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_ACCMODE	0x0003
 #define O_NDELAY	0x0004
 #define O_APPEND	0x0008
 #define FASYNC		0x0040	/* fcntl, for BSD compatibility */
@@ -24,11 +20,6 @@
 #define O_NOATIME	0x200000
 
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
 #define F_GETLK		7
@@ -37,9 +28,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		1
 #define F_WRLCK		2
@@ -52,18 +40,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -73,6 +49,6 @@ struct flock {
 	short __unused;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif /* !(_SPARC64_FCNTL_H) */
diff --git a/include/asm-v850/fcntl.h b/include/asm-v850/fcntl.h
--- a/include/asm-v850/fcntl.h
+++ b/include/asm-v850/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
 #define O_CREAT		  0100	/* not fcntl */
 #define O_EXCL		  0200	/* not fcntl */
 #define O_NOCTTY	  0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_LARGEFILE    0400000
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -40,9 +31,6 @@
 #define F_SETLK64	13
 #define F_SETLKW64	14
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -55,18 +43,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
@@ -83,5 +59,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
+
 #endif /* __V850_FCNTL_H__ */
diff --git a/include/asm-x86_64/fcntl.h b/include/asm-x86_64/fcntl.h
--- a/include/asm-x86_64/fcntl.h
+++ b/include/asm-x86_64/fcntl.h
@@ -3,10 +3,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
@@ -22,11 +18,6 @@
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		5
 #define F_SETLK		6
 #define F_SETLKW	7
@@ -36,9 +27,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -51,18 +39,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
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
 	short  l_type;
 	short  l_whence;
@@ -71,6 +47,6 @@ struct flock {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif /* !_X86_64_FCNTL_H */
diff --git a/include/asm-xtensa/fcntl.h b/include/asm-xtensa/fcntl.h
--- a/include/asm-xtensa/fcntl.h
+++ b/include/asm-xtensa/fcntl.h
@@ -14,10 +14,6 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	0x0003
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
 #define O_APPEND	0x0008
 #define O_SYNC		0x0010
 #define O_NONBLOCK	0x0080
@@ -34,11 +30,6 @@
 
 #define O_NDELAY	O_NONBLOCK
 
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
 #define F_GETLK		14
 #define F_GETLK64       15
 #define F_SETLK		6
@@ -51,9 +42,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
 #define F_WRLCK		1
@@ -66,18 +54,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND	32	/* This is a mandatory flock ... */
-#define LOCK_READ	64	/*  which allows concurrent read operations */
-#define LOCK_WRITE	128	/*  which allows concurrent write operations */
-#define LOCK_RW		192	/*  which allows concurrent read & write ops */
-
 typedef struct flock {
 	short l_type;
 	short l_whence;
@@ -96,6 +72,6 @@ struct flock64 {
 	pid_t  l_pid;
 };
 
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif /* _XTENSA_FCNTL_H */
