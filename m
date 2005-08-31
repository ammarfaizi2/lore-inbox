Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVHaHDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVHaHDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVHaHD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:26 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:61590 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932402AbVHaHDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:24 -0400
Date: Wed, 31 Aug 2005 16:53:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] Consildate asm-ppc*/fcntl.h
Message-Id: <20050831165358.63910cfb.sfr@canb.auug.org.au>
In-Reply-To: <20050831165039.3740c832.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
	<20050831165039.3740c832.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two files are basically identical, so make one just include the
other (protecting the 32-bit-only parts with __powerpc64__).  Also remove
some completely unused defines.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-ppc/fcntl.h   |   12 +++-----
 include/asm-ppc64/fcntl.h |   66 +--------------------------------------------
 2 files changed, 6 insertions(+), 72 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
--- a/include/asm-ppc/fcntl.h
+++ b/include/asm-ppc/fcntl.h
@@ -27,9 +27,11 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
+#ifndef __powerpc64__
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
+#endif
 
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
@@ -43,12 +45,6 @@
 /* for leases */
 #define F_INPROGRESS	16
 
-#ifdef __KERNEL__
-#define F_POSIX		1
-#define F_FLOCK		2
-#define F_BROKEN	4	/* broken flock() emulation */
-#endif /* __KERNEL__ */
-
 struct flock {
 	short l_type;
 	short l_whence;
@@ -57,6 +53,7 @@ struct flock {
 	pid_t l_pid;
 };
 
+#ifndef __powerpc64__
 struct flock64 {
 	short  l_type;
 	short  l_whence;
@@ -64,7 +61,8 @@ struct flock64 {
 	loff_t l_len;
 	pid_t  l_pid;
 };
+#endif
 
 #include <asm-generic/fcntl.h>
 
-#endif
+#endif /* _PPC_FCNTL_H */
diff --git a/include/asm-ppc64/fcntl.h b/include/asm-ppc64/fcntl.h
--- a/include/asm-ppc64/fcntl.h
+++ b/include/asm-ppc64/fcntl.h
@@ -1,65 +1 @@
-#ifndef _PPC64_FCNTL_H
-#define _PPC64_FCNTL_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
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
-#define O_DIRECTORY      040000	/* must be a directory */
-#define O_NOFOLLOW      0100000	/* don't follow links */
-#define O_LARGEFILE     0200000
-#define O_DIRECT	0400000	/* direct disk access hint */
-#define O_NOATIME	01000000
-
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
-#ifdef __KERNEL__
-#define F_POSIX		1
-#define F_FLOCK		2
-#define F_BROKEN	4	/* broken flock() emulation */
-#endif /* __KERNEL__ */
-
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
-#include <asm-generic/fcntl.h>
-
-#endif /* _PPC64_FCNTL_H */
+#include <asm-ppc/fcntl.h>
