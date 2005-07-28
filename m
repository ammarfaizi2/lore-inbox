Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVG1QeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVG1QeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVG1Q1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:27:32 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:57816 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261594AbVG1QZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:40 -0400
Date: Fri, 29 Jul 2005 02:14:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] consildate asm-ppc*/fcntl.h
Message-Id: <20050729021406.5086837e.sfr@canb.auug.org.au>
In-Reply-To: <20050729020802.22b7656c.sfr@canb.auug.org.au>
References: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two files are basically identical, so make one just include the
other (protecting the 32-bit-only parts with CONFIG_64BIT).  Also remove
some completely unused defines.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-fcntl.1/include/asm-ppc/fcntl.h linus-fcntl.2/include/asm-ppc/fcntl.h
--- linus-fcntl.1/include/asm-ppc/fcntl.h	2005-07-26 15:17:24.000000000 +1000
+++ linus-fcntl.2/include/asm-ppc/fcntl.h	2005-07-26 15:29:57.000000000 +1000
@@ -1,6 +1,8 @@
 #ifndef _PPC_FCNTL_H
 #define _PPC_FCNTL_H
 
+#include <linux/config.h>
+
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
 #define O_CREAT		   0100	/* not fcntl */
@@ -27,9 +29,11 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
+#ifndef CONFIG_64BIT
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
+#endif
 
 /* for posix fcntl() and lockf() */
 #define F_RDLCK		0
@@ -43,12 +47,6 @@
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
@@ -57,6 +55,7 @@ struct flock {
 	pid_t l_pid;
 };
 
+#ifndef CONFIG_64BIT
 struct flock64 {
 	short  l_type;
 	short  l_whence;
@@ -64,7 +63,8 @@ struct flock64 {
 	loff_t l_len;
 	pid_t  l_pid;
 };
+#endif
 
 #include <asm-generic/fcntl.h>
 
-#endif
+#endif /* _PPC_FCNTL_H */
diff -ruNp linus-fcntl.1/include/asm-ppc64/fcntl.h linus-fcntl.2/include/asm-ppc64/fcntl.h
--- linus-fcntl.1/include/asm-ppc64/fcntl.h	2005-07-26 15:18:09.000000000 +1000
+++ linus-fcntl.2/include/asm-ppc64/fcntl.h	2005-07-26 15:30:23.000000000 +1000
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
