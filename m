Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSIPGpQ>; Mon, 16 Sep 2002 02:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSIPGpQ>; Mon, 16 Sep 2002 02:45:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:64952 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313070AbSIPGpE>;
	Mon, 16 Sep 2002 02:45:04 -0400
Date: Mon, 16 Sep 2002 16:45:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
       rmk@arm.linux.org.uk, bjornw@axis.com, davidm@hpl.hp.com,
       paulus@samba.org, anton@samba.org, engebret@us.ibm.com,
       jes@trained-monkey.org, ralf@gnu.org, schwidefsky@de.ibm.com,
       davem@redhat.com, gniibe@m17n.org, ak@suse.de
Subject: [PATCH] fcntl.h consolidation 1/18
Message-Id: <20020916164516.196cc21c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

At Christoph Hellwig's suggestion, I have redone the fcntl.h
consolidation by creating an asm-generic/fcntl.h.

This is asm-generic/fcntl.h.  I will follow this with one patch
for each architecture.

The diffstat for the finished patch (after applying all 18 bits)
looks like this:

 asm-alpha/fcntl.h   |   41 ++------------
 asm-arm/fcntl.h     |   77 ----------------------------
 asm-cris/fcntl.h    |   85 ------------------------------
 asm-generic/fcntl.h |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-i386/fcntl.h    |   83 ------------------------------
 asm-ia64/fcntl.h    |   79 +---------------------------
 asm-m68k/fcntl.h    |   77 ----------------------------
 asm-mips/fcntl.h    |   51 +-----------------
 asm-mips64/fcntl.h  |   52 +-----------------
 asm-parisc/fcntl.h  |   58 ---------------------
 asm-ppc/fcntl.h     |   83 ------------------------------
 asm-ppc64/fcntl.h   |   83 ------------------------------
 asm-s390/fcntl.h    |   85 ------------------------------
 asm-s390x/fcntl.h   |   70 +------------------------
 asm-sh/fcntl.h      |   83 ------------------------------
 asm-sparc/fcntl.h   |   46 +---------------
 asm-sparc64/fcntl.h |   44 +---------------
 asm-x86_64/fcntl.h  |   74 +-------------------------
 18 files changed, 189 insertions(+), 1125 deletions(-)

This first patch, on its own, is completely safe (as nothing includes
asm-generic/fcntl.h yet :-)), so Linus pleas apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-generic/fcntl.h 2.5.35-fcntl.1/include/asm-generic/fcntl.h
--- 2.5.35/include/asm-generic/fcntl.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.35-fcntl.1/include/asm-generic/fcntl.h	2002-09-16 16:04:22.000000000 +1000
@@ -0,0 +1,143 @@
+#ifndef _ASM_GENERIC_FCNTL_H
+#define _ASM_GENERIC_FCNTL_H
+
+/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
+   located on an ext2 file system */
+#define O_ACCMODE	   0003
+#define O_RDONLY	     00
+#define O_WRONLY	     01
+#define O_RDWR		     02
+#ifndef O_CREAT
+#define O_CREAT		   0100	/* not fcntl */
+#endif
+#ifndef O_EXCL
+#define O_EXCL		   0200	/* not fcntl */
+#endif
+#ifndef O_NOCTTY
+#define O_NOCTTY	   0400	/* not fcntl */
+#endif
+#ifndef O_TRUNC
+#define O_TRUNC		  01000	/* not fcntl */
+#endif
+#ifndef O_APPEND
+#define O_APPEND	  02000
+#endif
+#ifndef O_NONBLOCK
+#define O_NONBLOCK	  04000
+#endif
+#ifndef O_NDELAY
+#define O_NDELAY	O_NONBLOCK
+#endif
+#ifndef O_SYNC
+#define O_SYNC		 010000
+#endif
+#ifndef FASYNC
+#define FASYNC		 020000	/* fcntl, for BSD compatibility */
+#endif
+#ifndef O_DIRECT
+#define O_DIRECT	 040000	/* direct disk access hint */
+#endif
+#ifndef O_LARGEFILE
+#define O_LARGEFILE	0100000
+#endif
+#ifndef O_DIRECTORY
+#define O_DIRECTORY	0200000	/* must be a directory */
+#endif
+#ifndef O_NOFOLLOW
+#define O_NOFOLLOW	0400000 /* don't follow links */
+#endif
+
+#define F_DUPFD		0	/* dup */
+#define F_GETFD		1	/* get close_on_exec */
+#define F_SETFD		2	/* set/clear close_on_exec */
+#define F_GETFL		3	/* get file->f_flags */
+#define F_SETFL		4	/* set file->f_flags */
+#ifndef F_GETLK
+#define F_GETLK		5
+#endif
+#ifndef F_SETLK
+#define F_SETLK		6
+#endif
+#ifndef F_SETLKW
+#define F_SETLKW	7
+#endif
+
+#ifndef F_SETOWN
+#define F_SETOWN	8	/*  for sockets. */
+#endif
+#ifndef F_GETOWN
+#define F_GETOWN	9	/*  for sockets. */
+#endif
+#ifndef F_SETSIG
+#define F_SETSIG	10	/*  for sockets. */
+#endif
+#ifndef F_GETSIG
+#define F_GETSIG	11	/*  for sockets. */
+#endif
+
+#ifndef __NO_FCNTL_LK64
+#ifndef F_GETLK64
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#endif
+#ifndef F_SETLK64
+#define F_SETLK64	13
+#endif
+#ifndef F_SETLKW64
+#define F_SETLKW64	14
+#endif
+#endif /* __NO_FCNTL_LK64 */
+
+/* for F_[GET|SET]FL */
+#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+
+/* for posix fcntl() and lockf() */
+#ifndef F_RDLCK
+#define F_RDLCK		0
+#endif
+#ifndef F_WRLCK
+#define F_WRLCK		1
+#endif
+#ifndef F_UNLCK
+#define F_UNLCK		2
+#endif
+
+/* for leases */
+#ifndef F_INPROGRESS
+#define F_INPROGRESS	16
+#endif
+
+/* operations for bsd flock(), also used by the kernel implementation */
+#define LOCK_SH		1	/* shared lock */
+#define LOCK_EX		2	/* exclusive lock */
+#define LOCK_NB		4	/* or'd with one of the above to prevent
+				   blocking */
+#define LOCK_UN		8	/* remove lock */
+
+#define LOCK_MAND	32	/* This is a mandatory flock */
+#define LOCK_READ	64	/* ... Which allows concurrent read operations */
+#define LOCK_WRITE	128	/* ... Which allows concurrent write operations */
+#define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK
+struct flock {
+	short l_type;
+	short l_whence;
+	off_t l_start;
+	off_t l_len;
+	pid_t l_pid;
+};
+#endif
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK64
+struct flock64 {
+	short  l_type;
+	short  l_whence;
+	loff_t l_start;
+	loff_t l_len;
+	pid_t  l_pid;
+};
+#endif
+
+#define F_LINUX_SPECIFIC_BASE	1024
+
+#endif /* _ASM_GENERIC_FCNTL_H */
