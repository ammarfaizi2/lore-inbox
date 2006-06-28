Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423159AbWF1FUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423159AbWF1FUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423161AbWF1FTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2254 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423159AbWF1FSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:50 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 09/31] m32r support for klibc
Date: Tue, 27 Jun 2006 22:17:09 -0700
Message-Id: <klibc.200606272217.09@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the m32r architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit b8481500fe4d3475857c7f8da022d6ac640b9420
tree a66da10e8168b9c82b0306657ecffd03154f14c5
parent 2ddc0b5cb0056f213e6e279030e50c1bd223cef6
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:39 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:39 -0700

 usr/include/arch/m32r/klibc/archconfig.h |   14 +++++++++
 usr/include/arch/m32r/klibc/archsetjmp.h |   21 +++++++++++++
 usr/include/arch/m32r/klibc/archsignal.h |   14 +++++++++
 usr/include/arch/m32r/klibc/archstat.h   |   39 +++++++++++++++++++++++++
 usr/klibc/arch/m32r/MCONFIG              |   18 +++++++++++
 usr/klibc/arch/m32r/Makefile.inc         |   19 ++++++++++++
 usr/klibc/arch/m32r/crt0.S               |   24 +++++++++++++++
 usr/klibc/arch/m32r/setjmp.S             |   47 ++++++++++++++++++++++++++++++
 usr/klibc/arch/m32r/syscall.S            |   29 +++++++++++++++++++
 usr/klibc/arch/m32r/sysstub.ph           |   25 ++++++++++++++++
 10 files changed, 250 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/m32r/klibc/archconfig.h b/usr/include/arch/m32r/klibc/archconfig.h
new file mode 100644
index 0000000..9489877
--- /dev/null
+++ b/usr/include/arch/m32r/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/m32r/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* All defaults */
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/m32r/klibc/archsetjmp.h b/usr/include/arch/m32r/klibc/archsetjmp.h
new file mode 100644
index 0000000..d82df9c
--- /dev/null
+++ b/usr/include/arch/m32r/klibc/archsetjmp.h
@@ -0,0 +1,21 @@
+/*
+ * arch/m32r/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __r8;
+	unsigned long __r9;
+	unsigned long __r10;
+	unsigned long __r11;
+	unsigned long __r12;
+	unsigned long __r13;
+	unsigned long __r14;
+	unsigned long __r15;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLIBC_ARCHSETJMP_H */
diff --git a/usr/include/arch/m32r/klibc/archsignal.h b/usr/include/arch/m32r/klibc/archsignal.h
new file mode 100644
index 0000000..b753026
--- /dev/null
+++ b/usr/include/arch/m32r/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/m32r/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/m32r/klibc/archstat.h b/usr/include/arch/m32r/klibc/archstat.h
new file mode 100644
index 0000000..09d3ade
--- /dev/null
+++ b/usr/include/arch/m32r/klibc/archstat.h
@@ -0,0 +1,39 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane amounts of padding around dev_t's.
+ */
+struct stat {
+	__stdev64	(st_dev);
+	unsigned char	__pad0[4];
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
+	unsigned char	__pad3[4];
+
+	long long	st_size;
+	unsigned long	st_blksize;
+
+	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long	__pad4;		/* future possible st_blocks high bits */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/klibc/arch/m32r/MCONFIG b/usr/klibc/arch/m32r/MCONFIG
new file mode 100644
index 0000000..2f9db0b
--- /dev/null
+++ b/usr/klibc/arch/m32r/MCONFIG
@@ -0,0 +1,18 @@
+# -*- makefile -*-
+#
+# arch/m32r/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os
+KLIBCBITSIZE  = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 224 MB - normal binaries start at 0 (?)
+# (lib?)gcc on cris seems to insist on producing .init and .fini sections
+KLIBCSHAREDFLAGS     = --section-start .init=0x0e000100
diff --git a/usr/klibc/arch/m32r/Makefile.inc b/usr/klibc/arch/m32r/Makefile.inc
new file mode 100644
index 0000000..794aec6
--- /dev/null
+++ b/usr/klibc/arch/m32r/Makefile.inc
@@ -0,0 +1,19 @@
+# -*- makefile -*-
+#
+# arch/m32r/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o
+
+archclean:
diff --git a/usr/klibc/arch/m32r/crt0.S b/usr/klibc/arch/m32r/crt0.S
new file mode 100644
index 0000000..568e5d8
--- /dev/null
+++ b/usr/klibc/arch/m32r/crt0.S
@@ -0,0 +1,24 @@
+#
+# arch/m32r/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+	.text
+	.balign 4
+	.type	_start,@function
+	.globl	_start
+_start:
+	/* Save the address of the ELF argument array */
+	mv	r0, sp
+
+	/* atexit() function (assume null) */
+	xor	r1, r1
+
+	bl	__libc_init
+
+	.size _start, .-_start
diff --git a/usr/klibc/arch/m32r/setjmp.S b/usr/klibc/arch/m32r/setjmp.S
new file mode 100644
index 0000000..02a25e7
--- /dev/null
+++ b/usr/klibc/arch/m32r/setjmp.S
@@ -0,0 +1,47 @@
+#
+# arch/m32r/setjmp.S
+#
+# setjmp/longjmp for the M32R architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	r8-r15
+#
+#	Note that r14 is the return address register and
+#	r15 is the stack pointer.
+#
+
+	.text
+	.balign 4
+	.globl	setjmp
+	.type	setjmp, @function
+setjmp:
+	st	r8, @r0
+	st	r9, @+r0
+	st	r10, @+r0
+	st	r11, @+r0
+	st	r12, @+r0
+	st	r13, @+r0
+	st	r14, @+r0
+	st	r15, @+r0
+	xor	r0, r0
+	jmp	r14
+	.size	setjmp,.-setjmp
+
+	.text
+	.balign 4
+	.globl	longjmp
+	.type	longjmp, @function
+longjmp:
+	ld	r8, @r0+
+	ld	r9, @r0+
+	ld	r10, @r0+
+	ld	r11, @r0+
+	ld	r12, @r0+
+	ld	r13, @r0+
+	ld	r14, @r0+
+	ld	r15, @r0
+	mv	r0, r1
+	jmp	r14
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/m32r/syscall.S b/usr/klibc/arch/m32r/syscall.S
new file mode 100644
index 0000000..a20a336
--- /dev/null
+++ b/usr/klibc/arch/m32r/syscall.S
@@ -0,0 +1,29 @@
+/*
+ * arch/m32r/syscall.S
+ *
+ *     r7 contains the syscall number (set by stub);
+ * r0..r3 contains arguments 0-3 per standard calling convention;
+ * r4..r5 contains arguments 4-5, but we have to get those from
+ *        the stack.
+ */
+
+	.section ".text","ax"
+	.balign	4
+	.globl	__syscall_common
+	.type	__syscall_common,@function
+__syscall_common:
+	ld	r4,@sp
+	ld	r5,@(4,sp)
+	trap	#2
+	cmpi	r0, #-4096
+	bnc	1f
+	jmp	r14
+1:
+	seth	r2,#high(errno)
+	or3	r2,r2,#low(errno)
+	neg	r1,r0
+	st	r1,@r7
+	ldi	r0,#-1
+	jmp	r14
+
+	.size	__syscall_common,.-__syscall_common
diff --git a/usr/klibc/arch/m32r/sysstub.ph b/usr/klibc/arch/m32r/sysstub.ph
new file mode 100644
index 0000000..98dfb9d
--- /dev/null
+++ b/usr/klibc/arch/m32r/sysstub.ph
@@ -0,0 +1,25 @@
+# -*- perl -*-
+#
+# arch/m32r/sysstub.ph
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
+    print OUT "\t.text\n";
+    print OUT "\t.type\t${fname},\@function\n";
+    print OUT "\t.globl\t${fname}\n";
+    print OUT "\t.balign\t4\n";
+    print OUT "${fname}:\n";
+    print OUT "\tldi\tr7,#__NR_${sname}\n";
+    print OUT "\tbra\t__syscall_common\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
