Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWF1F26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWF1F26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423153AbWF1FSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:65485 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161056AbWF1FSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:36 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 10/31] m68k support for klibc
Date: Tue, 27 Jun 2006 22:17:10 -0700
Message-Id: <klibc.200606272217.10@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the m68k architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 5d5bb97039eb8b54f57108cdcde55e4cb4bd5227
tree 23750d414b01bbf986e327313fb7c19f7da54a6e
parent b8481500fe4d3475857c7f8da022d6ac640b9420
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:42 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:42 -0700

 usr/include/arch/m68k/klibc/archconfig.h |   15 ++++++++++
 usr/include/arch/m68k/klibc/archsetjmp.h |   26 ++++++++++++++++++
 usr/include/arch/m68k/klibc/archsignal.h |   14 ++++++++++
 usr/include/arch/m68k/klibc/archstat.h   |   38 +++++++++++++++++++++++++++
 usr/klibc/arch/m68k/MCONFIG              |   11 ++++++++
 usr/klibc/arch/m68k/Makefile.inc         |   25 +++++++++++++++++
 usr/klibc/arch/m68k/crt0.S               |   27 +++++++++++++++++++
 usr/klibc/arch/m68k/setjmp.S             |   43 ++++++++++++++++++++++++++++++
 usr/klibc/arch/m68k/syscall.S            |   27 +++++++++++++++++++
 usr/klibc/arch/m68k/sysstub.ph           |   26 ++++++++++++++++++
 usr/klibc/arch/m68k/vfork.S              |   28 ++++++++++++++++++++
 11 files changed, 280 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/m68k/klibc/archconfig.h b/usr/include/arch/m68k/klibc/archconfig.h
new file mode 100644
index 0000000..10ef62e
--- /dev/null
+++ b/usr/include/arch/m68k/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/m68k/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* On m68k, sys_mmap2 uses the current page size as the shift factor */
+#define _KLIBC_MMAP2_SHIFT	__getpageshift()
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/m68k/klibc/archsetjmp.h b/usr/include/arch/m68k/klibc/archsetjmp.h
new file mode 100644
index 0000000..e85c810
--- /dev/null
+++ b/usr/include/arch/m68k/klibc/archsetjmp.h
@@ -0,0 +1,26 @@
+/*
+ * usr/include/arch/m68k/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned int __d2;
+	unsigned int __d3;
+	unsigned int __d4;
+	unsigned int __d5;
+	unsigned int __d6;
+	unsigned int __d7;
+	unsigned int __a2;
+	unsigned int __a3;
+	unsigned int __a4;
+	unsigned int __a5;
+	unsigned int __fp;	/* a6 */
+	unsigned int __sp;	/* a7 */
+	unsigned int __retaddr;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLBIC_ARCHSETJMP_H */
diff --git a/usr/include/arch/m68k/klibc/archsignal.h b/usr/include/arch/m68k/klibc/archsignal.h
new file mode 100644
index 0000000..bf7912a
--- /dev/null
+++ b/usr/include/arch/m68k/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/m68k/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+/* No special stuff for this architecture */
+
+#endif
diff --git a/usr/include/arch/m68k/klibc/archstat.h b/usr/include/arch/m68k/klibc/archstat.h
new file mode 100644
index 0000000..dce25f9
--- /dev/null
+++ b/usr/include/arch/m68k/klibc/archstat.h
@@ -0,0 +1,38 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane padding around dev_t's.
+ */
+struct stat {
+	__stdev64	(st_dev);
+	unsigned char	__pad1[2];
+
+	unsigned long	__st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned long	st_uid;
+	unsigned long	st_gid;
+
+	__stdev64	(st_rdev);
+	unsigned char	__pad3[2];
+
+	long long	st_size;
+	unsigned long	st_blksize;
+
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/klibc/arch/m68k/MCONFIG b/usr/klibc/arch/m68k/MCONFIG
new file mode 100644
index 0000000..4360408
--- /dev/null
+++ b/usr/klibc/arch/m68k/MCONFIG
@@ -0,0 +1,11 @@
+# -*- makefile -*-
+#
+# arch/m68k/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os -fomit-frame-pointer
+KLIBCBITSIZE  = 32
diff --git a/usr/klibc/arch/m68k/Makefile.inc b/usr/klibc/arch/m68k/Makefile.inc
new file mode 100644
index 0000000..a6f9827
--- /dev/null
+++ b/usr/klibc/arch/m68k/Makefile.inc
@@ -0,0 +1,25 @@
+# -*- makefile -*-
+#
+# arch/m68k/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/vfork.o
+
+KLIBCBITSIZE  = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 2816 MB - normal binaries start at 2048 MB if I read the link
+# script right.  Not sure if there is a fundamental reason
+# to not duck below the halfway point...
+KLIBCSHAREDFLAGS        = -Ttext 0xb0000000
+
+archclean:
diff --git a/usr/klibc/arch/m68k/crt0.S b/usr/klibc/arch/m68k/crt0.S
new file mode 100644
index 0000000..fbf6f13
--- /dev/null
+++ b/usr/klibc/arch/m68k/crt0.S
@@ -0,0 +1,27 @@
+#
+# arch/m68k/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+	.text
+	.align 4
+	.type _start,@function
+	.globl _start
+_start:
+	# Zero out the frame pointer to be nice to the debugger
+	movea.l	#0,%a6
+	# Save the address of the ELF argument array
+	move.l	%a7, %d0
+	# Push a zero on the stack in lieu of atexit pointer
+	clr.l	-(%sp)
+	# Push ELF argument pointer on the stack
+	move.l	%d0, -(%a7)
+
+	jbsr	__libc_init
+
+	.size _start, .-_start
diff --git a/usr/klibc/arch/m68k/setjmp.S b/usr/klibc/arch/m68k/setjmp.S
new file mode 100644
index 0000000..1b3591e
--- /dev/null
+++ b/usr/klibc/arch/m68k/setjmp.S
@@ -0,0 +1,43 @@
+#
+# arch/m68k/setjmp.S
+#
+# setjmp/longjmp for the m68k architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	%d2..%d7
+#	%a2..%a7
+#	return address
+#
+
+	.text
+	.align 2
+	.globl setjmp
+	.type setjmp, @function
+setjmp:
+	move.l	(%sp)+, %d0		| Return address
+	movea.l	(%sp), %a0		| Buffer address
+	| Postincrement mode is not permitted here...
+	movem.l	%d2-%d7/%a2-%a7, (%a0)
+	move.l	%d0, 48(%a0)		| Return address
+	move.l	%d0, -(%sp)		| Restore return address
+	clr.l	%d0			| Return value
+	movea.l	%d0, %a0		| Redundant return...
+	rts
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 2
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+	move.l	4(%sp), %a0		| Buffer address
+	move.l	8(%sp), %d0		| Return value
+	movem.l	(%a0)+, %d2-%d7/%a2-%a7
+	movea.l	(%a0), %a1
+	movea.l	%d0, %a0		| Redundant return...
+	jmp.l	(%a1)
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/m68k/syscall.S b/usr/klibc/arch/m68k/syscall.S
new file mode 100644
index 0000000..966c92d
--- /dev/null
+++ b/usr/klibc/arch/m68k/syscall.S
@@ -0,0 +1,27 @@
+/*
+ * arch/m68k/syscall.S
+ *
+ * Common tail-handling code for system calls.
+ *
+ * The arguments are on the stack; the system call number in %d0.
+ */
+
+	.text
+	.align	2
+	.globl	__syscall_common
+	.type	__syscall_common, @function
+__syscall_common:
+	movem.l %d2-%d6, -(%sp)	/* 5 registers saved */
+	movem.l	24(%sp), %d1-%d6
+	trap	#0
+	cmpi.l	#-4095, %d0
+	blt.l	1f
+	neg.l	%d0
+	move.l	%d0, (errno)
+	moveq	#-1, %d0
+1:
+	movea.l	%d0, %a0	/* Redundant return */
+	movem.l (%sp)+, %d2-%d6 /* Restore registers */
+	rts
+
+	.size	__syscall_common,.-__syscall_common
diff --git a/usr/klibc/arch/m68k/sysstub.ph b/usr/klibc/arch/m68k/sysstub.ph
new file mode 100644
index 0000000..78c239d
--- /dev/null
+++ b/usr/klibc/arch/m68k/sysstub.ph
@@ -0,0 +1,26 @@
+# -*- perl -*-
+#
+# arch/m68k/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print OUT "#include <asm/unistd.h>\n";
+    print OUT "\n";
+    print OUT "\t.type ${fname},\@function\n";
+    print OUT "\t.globl ${fname}\n";
+    print OUT "${fname}:\n";
+
+    $stype = 'common' if ( $stype eq '' );
+
+    print OUT "\tmove.l\t# __NR_${sname}, %d0\n";
+    print OUT "\tbr\t__syscall_$stype\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/m68k/vfork.S b/usr/klibc/arch/m68k/vfork.S
new file mode 100644
index 0000000..a3a7e44
--- /dev/null
+++ b/usr/klibc/arch/m68k/vfork.S
@@ -0,0 +1,28 @@
+#
+# usr/klibc/arch/m68k/vfork.S
+#
+# vfork is nasty - there must be nothing at all on the stack above
+# the stack frame of the enclosing function.
+#
+
+#include <asm/unistd.h>
+
+	.text
+	.align	2
+	.globl	vfork
+	.type	vfork, @function
+vfork:
+	move.l	(%sp)+, %d1		/* Return address */
+	move.l	# __NR_vfork, %d0
+	trap	#0
+	move.l	%d1, -(%sp)
+	cmpi.l	#-4095, %d0
+	blt.l	1f
+	neg.l	%d0
+	move.l	%d0, (errno)
+	moveq	#-1, %d0
+1:
+	movea.l	%d0, %a0
+	rts
+
+	.size	vfork, .-vfork
