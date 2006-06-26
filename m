Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWFZBJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWFZBJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFZBIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:08:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19855 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964990AbWFZA6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:49 -0400
Date: Sun, 25 Jun 2006 17:58:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 21/43] alpha support for klibc
Message-Id: <klibc.200606251757.21@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the alpha architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 5e5ce29210ac33a0b3704eb9ab5e5d5b55375575
tree 2ec24df596e13c21b68da4d905f546770d36fdad
parent 8529b52550ba78984998d3a9cc9deb467217fa3e
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:14 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:14 -0700

 usr/include/arch/alpha/klibc/archconfig.h |   15 ++++++
 usr/include/arch/alpha/klibc/archsetjmp.h |   33 +++++++++++++
 usr/include/arch/alpha/klibc/archsignal.h |   14 +++++
 usr/include/arch/alpha/klibc/archstat.h   |   28 +++++++++++
 usr/include/arch/alpha/klibc/archsys.h    |   53 ++++++++++++++++++++
 usr/include/arch/alpha/machine/asm.h      |   44 +++++++++++++++++
 usr/klibc/arch/alpha/MCONFIG              |   16 ++++++
 usr/klibc/arch/alpha/Makefile.inc         |   60 +++++++++++++++++++++++
 usr/klibc/arch/alpha/README-gcc           |   22 +++++++++
 usr/klibc/arch/alpha/crt0.S               |   22 +++++++++
 usr/klibc/arch/alpha/divide.c             |   59 +++++++++++++++++++++++
 usr/klibc/arch/alpha/pipe.S               |   38 +++++++++++++++
 usr/klibc/arch/alpha/setjmp.S             |   75 +++++++++++++++++++++++++++++
 usr/klibc/arch/alpha/syscall.S            |   26 ++++++++++
 usr/klibc/arch/alpha/sysdual.S            |   33 +++++++++++++
 usr/klibc/arch/alpha/sysstub.ph           |   37 ++++++++++++++
 16 files changed, 575 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/alpha/klibc/archconfig.h b/usr/include/arch/alpha/klibc/archconfig.h
new file mode 100644
index 0000000..272fee0
--- /dev/null
+++ b/usr/include/arch/alpha/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/alpha/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+#define _KLIBC_USE_RT_SIG 1
+#define _KLIBC_STATFS_F_TYPE_64 0
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/alpha/klibc/archsetjmp.h b/usr/include/arch/alpha/klibc/archsetjmp.h
new file mode 100644
index 0000000..47638b3
--- /dev/null
+++ b/usr/include/arch/alpha/klibc/archsetjmp.h
@@ -0,0 +1,33 @@
+/*
+ * arch/alpha/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __s0;
+	unsigned long __s1;
+	unsigned long __s2;
+	unsigned long __s3;
+	unsigned long __s4;
+	unsigned long __s5;
+	unsigned long __fp;
+	unsigned long __ra;
+	unsigned long __gp;
+	unsigned long __sp;
+
+	unsigned long __f2;
+	unsigned long __f3;
+	unsigned long __f4;
+	unsigned long __f5;
+	unsigned long __f6;
+	unsigned long __f7;
+	unsigned long __f8;
+	unsigned long __f9;
+};
+
+/* Must be an array so it will decay to a pointer when a function is called */
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLIBC_ARCHSETJMP_H */
diff --git a/usr/include/arch/alpha/klibc/archsignal.h b/usr/include/arch/alpha/klibc/archsignal.h
new file mode 100644
index 0000000..2193a35
--- /dev/null
+++ b/usr/include/arch/alpha/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/alpha/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/alpha/klibc/archstat.h b/usr/include/arch/alpha/klibc/archstat.h
new file mode 100644
index 0000000..66e29be
--- /dev/null
+++ b/usr/include/arch/alpha/klibc/archstat.h
@@ -0,0 +1,28 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	__stdev64	(st_dev);
+	unsigned long	st_ino;
+	__stdev64	(st_rdev);
+	long		st_size;
+	unsigned long	st_blocks;
+
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	st_blksize;
+	unsigned int	st_nlink;
+	unsigned int	__pad0;
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+  	long		__unused[3];
+};
+
+#endif
diff --git a/usr/include/arch/alpha/klibc/archsys.h b/usr/include/arch/alpha/klibc/archsys.h
new file mode 100644
index 0000000..a60a0f2
--- /dev/null
+++ b/usr/include/arch/alpha/klibc/archsys.h
@@ -0,0 +1,53 @@
+/*
+ * arch/alpha/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+/* Alpha has some bizarre Tru64-derived system calls which return two
+   different values in $0 and $20(!), respectively.  The standard
+   macros can't deal with these; even the ones that give the right
+   return value have the wrong clobbers. */
+
+#define _syscall0_dual0(type, name)                                     \
+type name(void)                                                         \
+{                                                                       \
+        long _sc_ret, _sc_err;                                          \
+        {                                                               \
+                register long _sc_0 __asm__("$0");                      \
+                register long _sc_19 __asm__("$19");                    \
+                register long _sc_20 __asm__("$20");                    \
+                                                                        \
+                _sc_0 = __NR_##name;                                    \
+                __asm__("callsys"                                       \
+                        : "=r"(_sc_0), "=r"(_sc_19), "=r" (_sc_20)      \
+                        : "0"(_sc_0)                                    \
+                        : _syscall_clobbers);                           \
+                _sc_ret = _sc_0, _sc_err = _sc_19; (void)(_sc_20);      \
+        }                                                               \
+        _syscall_return(type);                                          \
+}
+
+#define _syscall0_dual1(type, name)                                     \
+type name(void)                                                         \
+{                                                                       \
+        long _sc_ret, _sc_err;                                          \
+        {                                                               \
+                register long _sc_0 __asm__("$0");                      \
+                register long _sc_19 __asm__("$19");                    \
+                register long _sc_20 __asm__("$20");                    \
+                                                                        \
+                _sc_0 = __NR_##name;                                    \
+                __asm__("callsys"                                       \
+                        : "=r"(_sc_0), "=r"(_sc_19), "=r" (_sc_20)      \
+                        : "0"(_sc_0)                                    \
+                        : _syscall_clobbers);                           \
+                _sc_ret = _sc_20, _sc_err = _sc_19; (void)(_sc_0);      \
+        }                                                               \
+        _syscall_return(type);                                          \
+}
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/include/arch/alpha/machine/asm.h b/usr/include/arch/alpha/machine/asm.h
new file mode 100644
index 0000000..c2ae4ed
--- /dev/null
+++ b/usr/include/arch/alpha/machine/asm.h
@@ -0,0 +1,44 @@
+/*
+ * machine/asm.h
+ */
+
+#ifndef _MACHINE_ASM_H
+#define _MACHINE_ASM_H
+
+/* Standard aliases for Alpha register names */
+
+#define v0	$0
+#define t0	$1
+#define t1	$2
+#define t2	$3
+#define t3	$4
+#define t4	$5
+#define t5	$6
+#define t6	$7
+#define t7	$8
+#define s0	$9
+#define s1	$10
+#define s2	$11
+#define s3	$12
+#define s4	$13
+#define s5	$14
+#define fp	$15
+#define a0	$16
+#define a1	$17
+#define a2	$18
+#define a3	$19
+#define a4	$20
+#define a5	$21
+#define t8	$22
+#define t9	$23
+#define t10	$24
+#define t11	$25
+#define ra	$26
+#define t12	$27		/* t12 and pv are both used for $27 */
+#define pv	$27		/* t12 and pv are both used for $27 */
+#define at	$28
+#define gp	$29
+#define sp	$30
+#define zero	$31
+
+#endif				/* _MACHINE_ASM_H */
diff --git a/usr/klibc/arch/alpha/MCONFIG b/usr/klibc/arch/alpha/MCONFIG
new file mode 100644
index 0000000..4420cdb
--- /dev/null
+++ b/usr/klibc/arch/alpha/MCONFIG
@@ -0,0 +1,16 @@
+# -*- makefile -*-
+#
+# arch/alpha/MCONFIG
+#
+# Build configuration for this architecture
+#
+
+KLIBCOPTFLAGS = -Os
+KLIBCBITSIZE  = 64
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 7 GB - normal binaries start at 4.5 GB, and the stack is below
+# the binary.
+KLIBCSHAREDFLAGS	= -Ttext 0x1c0000200
diff --git a/usr/klibc/arch/alpha/Makefile.inc b/usr/klibc/arch/alpha/Makefile.inc
new file mode 100644
index 0000000..9f51b7f
--- /dev/null
+++ b/usr/klibc/arch/alpha/Makefile.inc
@@ -0,0 +1,60 @@
+# -*- makefile -*-
+#
+# arch/alpha/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+# Special CFLAGS for the divide code
+DIVCFLAGS = $(KLIBCREQFLAGS) $(KLIBCARCHREQFLAGS) \
+	-O3 -fomit-frame-pointer -fcall-saved-1 -fcall-saved-2 \
+	-fcall-saved-3 -fcall-saved-4 -fcall-saved-5 -fcall-saved-6 \
+	-fcall-saved-7 -fcall-saved-8 -ffixed-15 -fcall-saved-16 \
+	-fcall-saved-17 -fcall-saved-18 -fcall-saved-19 -fcall-saved-20 \
+	-fcall-saved-21 -fcall-saved-22 -ffixed-23 -fcall-saved-24 \
+	-ffixed-25 -ffixed-27
+
+KLIBCARCHOBJS := arch/$(KLIBCARCH)/pipe.o     arch/$(KLIBCARCH)/setjmp.o
+KLIBCARCHOBJS += arch/$(KLIBCARCH)/syscall.o  arch/$(KLIBCARCH)/sysdual.o
+
+DIVOBJS += arch/$(KLIBCARCH)/__divqu.o \
+           arch/$(KLIBCARCH)/__remqu.o \
+           arch/$(KLIBCARCH)/__divq.o \
+           arch/$(KLIBCARCH)/__remq.o \
+           arch/$(KLIBCARCH)/__divlu.o \
+           arch/$(KLIBCARCH)/__remlu.o \
+           arch/$(KLIBCARCH)/__divl.o \
+           arch/$(KLIBCARCH)/__reml.o
+
+KLIBCARCHOBJS += $(DIVOBJS)
+
+quiet_cmd_regswap = REGSWAP $@
+      cmd_regswap = sed -e 's/\$$0\b/$$27/g'  -e 's/\$$24\b/$$99/g' \
+                        -e 's/\$$16\b/$$24/g' -e 's/\$$17\b/$$25/g' \
+                        -e 's/\$$26\b/$$23/g' -e 's/\$$99\b/$$16/g' < $< > $@
+
+# Use static pattern rule to avoid using a temporary file
+$(addprefix $(obj)/,$(DIVOBJS:.o=.S)): $(obj)/arch/$(KLIBCARCH)/%.S: \
+                                       $(obj)/arch/$(KLIBCARCH)/%.ss
+	$(call if_changed,regswap)
+
+quiet_cmd_genss = DIV-CC  $@
+      cmd_genss = $(CC) $(DIVCFLAGS) $(FILE_CFLAGS) \
+                        -DNAME=$(basename $(notdir $@)) -S -o $@ $<
+
+$(obj)/arch/$(KLIBCARCH)/%.ss: $(obj)/arch/$(KLIBCARCH)/divide.c
+	$(call if_changed,genss)
+
+$(obj)/arch/$(KLIBCARCH)/__divqu.ss: FILE_CFLAGS := -DSIGNED=0 -DREM=0 -DBITS=64
+$(obj)/arch/$(KLIBCARCH)/__remqu.ss: FILE_CFLAGS := -DSIGNED=0 -DREM=1 -DBITS=64
+$(obj)/arch/$(KLIBCARCH)/__divq.ss:  FILE_CFLAGS := -DSIGNED=1 -DREM=0 -DBITS=64
+$(obj)/arch/$(KLIBCARCH)/__remq.ss:  FILE_CFLAGS := -DSIGNED=1 -DREM=1 -DBITS=64
+$(obj)/arch/$(KLIBCARCH)/__divlu.ss: FILE_CFLAGS := -DSIGNED=0 -DREM=0 -DBITS=32
+$(obj)/arch/$(KLIBCARCH)/__remlu.ss: FILE_CFLAGS := -DSIGNED=0 -DREM=1 -DBITS=32
+$(obj)/arch/$(KLIBCARCH)/__divl.ss:  FILE_CFLAGS := -DSIGNED=1 -DREM=0 -DBITS=32
+$(obj)/arch/$(KLIBCARCH)/__reml.ss:  FILE_CFLAGS := -DSIGNED=1 -DREM=1 -DBITS=32
+
+targets     += $(DIVOBJS:.o=.S) $(DIVOBJS:.o=.ss)
+clean-files += $(DIVOBJS:.o=.S) $(DIVOBJS:.o=.ss)
diff --git a/usr/klibc/arch/alpha/README-gcc b/usr/klibc/arch/alpha/README-gcc
new file mode 100644
index 0000000..1d0052f
--- /dev/null
+++ b/usr/klibc/arch/alpha/README-gcc
@@ -0,0 +1,22 @@
+   The current Alpha chips don't provide hardware for integer
+   division.  The C compiler expects the functions
+
+        __divqu: 64-bit unsigned long divide
+        __remqu: 64-bit unsigned long remainder
+        __divq/__remq:   signed 64-bit
+        __divlu/__remlu: unsigned 32-bit
+        __divl/__reml:   signed 32-bit
+
+   These are not normal C functions: instead of the normal calling
+   sequence, these expect their arguments in registers t10 and t11, and
+   return the result in t12 (aka pv).  Register AT may be clobbered
+   (assembly temporary), anything else must be saved.
+
+   Furthermore, the return address is in t9 instead of ra.
+
+   Normal function	Divide functions
+   ---------------	----------------
+   v0 ($0)		t12/pv ($27)
+   a0 ($16)		t10 ($24)
+   a1 ($17)		t11 ($25)
+   ra ($26)		t9 ($23)
diff --git a/usr/klibc/arch/alpha/crt0.S b/usr/klibc/arch/alpha/crt0.S
new file mode 100644
index 0000000..5e2babb
--- /dev/null
+++ b/usr/klibc/arch/alpha/crt0.S
@@ -0,0 +1,22 @@
+#
+# arch/alpha/crt0.S
+#
+
+	.text
+	.type	_start,@function
+	.ent	_start, 0
+	.globl	_start
+_start:
+	.frame  $30, 0, $26, 0
+	mov	$31, $15
+	br	$29, 1f
+1:	ldgp	$29, 0($29)
+	.prologue 0
+
+	lda	$16, 0($30)		# ELF data structure
+	lda	$17, 0($0)		# atexit pointer
+
+	jsr	$26, __libc_init
+
+	.size	_start,.-_start
+	.end	_start
diff --git a/usr/klibc/arch/alpha/divide.c b/usr/klibc/arch/alpha/divide.c
new file mode 100644
index 0000000..c44254f
--- /dev/null
+++ b/usr/klibc/arch/alpha/divide.c
@@ -0,0 +1,59 @@
+#include <stdint.h>
+#include <asm/gentrap.h>
+#include <asm/pal.h>
+
+#if BITS == 64
+typedef uint64_t uint;
+typedef int64_t sint;
+#else
+typedef uint32_t uint;
+typedef int32_t sint;
+#endif
+
+#ifdef SIGNED
+typedef sint xint;
+#else
+typedef uint xint;
+#endif
+
+xint NAME(uint num, uint den)
+{
+	uint quot = 0, qbit = 1;
+	int minus = 0;
+	xint v;
+
+	if (den == 0) {
+		/* This is really $16, but $16 and $24 are exchanged by a script */
+		register unsigned long cause asm("$24") = GEN_INTDIV;
+		asm volatile ("call_pal %0"::"i" (PAL_gentrap), "r"(cause));
+		return 0;	/* If trap returns... */
+	}
+#if SIGNED
+	if ((sint) (num ^ den) < 0)
+		minus = 1;
+	if ((sint) num < 0)
+		num = -num;
+	if ((sint) den < 0)
+		den = -den;
+#endif
+
+	/* Left-justify denominator and count shift */
+	while ((sint) den >= 0) {
+		den <<= 1;
+		qbit <<= 1;
+	}
+
+	while (qbit) {
+		if (den <= num) {
+			num -= den;
+			quot += qbit;
+		}
+		den >>= 1;
+		qbit >>= 1;
+	}
+
+	v = (xint) (REM ? num : quot);
+	if (minus)
+		v = -v;
+	return v;
+}
diff --git a/usr/klibc/arch/alpha/pipe.S b/usr/klibc/arch/alpha/pipe.S
new file mode 100644
index 0000000..ee72413
--- /dev/null
+++ b/usr/klibc/arch/alpha/pipe.S
@@ -0,0 +1,38 @@
+#
+# arch/alpha/pipe.S
+#
+
+#
+# pipe() on alpha returns both file descriptors in registers --
+# $0 (v0) and $20 (a4) respectively.  This is unlike any other system call,
+# as far as I can tell.
+#
+
+#include <asm/unistd.h>
+#include <machine/asm.h>
+
+	.text
+	.align	3
+	.type	pipe, @function
+	.ent	pipe, 0
+	.globl	pipe
+pipe:
+	.frame	sp,0,ra,0
+	lda	v0, __NR_pipe
+	callsys
+	beq	a3, 1f
+	br	pv, 2f			# pv <- pc
+2:
+	ldgp	gp, 0(pv)
+	lda	a1, errno
+	lda	v0, -1(zero)
+	stl	a3, 0(a1)
+	ret	zero,(ra),1
+1:
+	stl	v0, 0(a0)
+	lda	v0, 0
+	stl	a4, 4(a0)
+	ret	zero,(ra),1
+
+	.size	pipe,.-pipe
+	.end	pipe
diff --git a/usr/klibc/arch/alpha/setjmp.S b/usr/klibc/arch/alpha/setjmp.S
new file mode 100644
index 0000000..ed604bd
--- /dev/null
+++ b/usr/klibc/arch/alpha/setjmp.S
@@ -0,0 +1,75 @@
+#
+# setjmp.S
+#
+
+#
+# The jmp_buf looks like:
+#
+#	s0..5
+#	fp
+#	ra
+#	gp
+#	sp
+#
+
+#include <machine/asm.h>
+
+	.text
+	.align	3
+	.type	setjmp,@function
+	.ent	setjmp, 0
+	.globl	setjmp
+setjmp:
+	lda	v0,   0(zero)
+	stq	s0,   0(a0)
+	stq	s1,   8(a0)
+	stq	s2,  16(a0)
+	stq	s3,  24(a0)
+	stq	s4,  32(a0)
+	stq	s5,  40(a0)
+	stq	fp,  48(a0)
+	stq	ra,  56(a0)
+	stq	gp,  64(a0)
+	stq	sp,  72(a0)
+	stt	$f2,  80(a0)
+	stt	$f3,  88(a0)
+	stt	$f4,  96(a0)
+	stt	$f5, 104(a0)
+	stt	$f6, 112(a0)
+	stt	$f7, 120(a0)
+	stt	$f8, 128(a0)
+	stt	$f9, 136(a0)
+	ret	zero,(ra),1
+
+	.size setjmp,.-setjmp
+	.end setjmp
+
+	.type	longjmp,@function
+	.ent	longjmp, 0
+	.globl	longjmp
+longjmp:
+	mov	a1, v0
+	ldq	s0,   0(a0)
+	ldq	s1,   8(a0)
+	ldq	s2,  16(a0)
+	ldq	s3,  24(a0)
+	ldq	s4,  32(a0)
+	ldq	s5,  40(a0)
+	ldq	fp,  48(a0)
+	ldq	ra,  56(a0)
+	ldq	gp,  64(a0)
+	ldq	sp,  72(a0)
+	ldt	$f2,  80(a0)
+	ldt	$f3,  88(a0)
+	ldt	$f4,  96(a0)
+	ldt	$f5, 104(a0)
+	ldt	$f6, 112(a0)
+	ldt	$f7, 120(a0)
+	ldt	$f8, 128(a0)
+	ldt	$f9, 136(a0)
+	/* We're bound to get a mispredict here, but at least give us
+	   a chance to get the return stack back in sync... */
+	ret	zero,(ra),1
+
+	.size longjmp,.-longjmp
+	.end longjmp
diff --git a/usr/klibc/arch/alpha/syscall.S b/usr/klibc/arch/alpha/syscall.S
new file mode 100644
index 0000000..ae69ef2
--- /dev/null
+++ b/usr/klibc/arch/alpha/syscall.S
@@ -0,0 +1,26 @@
+#
+# arch/alpha/syscall.S
+#
+
+#include <machine/asm.h>
+
+	.text
+	.align	3
+	.type	__syscall_common,@function
+	.ent	__syscall_common, 0
+	.globl	__syscall_common
+__syscall_common:
+	.frame	sp,0,ra,0
+	callsys
+	beq	a3, 1f
+	br	pv, 2f			# pv <- pc
+2:
+	ldgp	gp, 0(pv)
+	lda	a1, errno
+	stl	v0, 0(a1)
+	lda	v0, -1(zero)
+1:
+	ret	zero,(ra),1
+
+	.size	__syscall_common,.-__syscall_common
+	.end	__syscall_common
diff --git a/usr/klibc/arch/alpha/sysdual.S b/usr/klibc/arch/alpha/sysdual.S
new file mode 100644
index 0000000..1719e37
--- /dev/null
+++ b/usr/klibc/arch/alpha/sysdual.S
@@ -0,0 +1,33 @@
+#
+# arch/alpha/sysdual.S
+#
+
+#
+# Some system calls have an alternate return value in r20 (a4).
+# This system call stub is for system calls where that is
+# the "real" return value.
+#
+
+#include <machine/asm.h>
+
+	.text
+	.align	3
+	.type	__syscall_dual1,@function
+	.ent	__syscall_dual1, 0
+	.globl	__syscall_dual1
+__syscall_dual1:
+	.frame	sp,0,ra,0
+	callsys
+	mov	v0, a4
+	beq	a3, 1f
+	br	pv, 2f			# pv <- pc
+2:
+	ldgp	gp, 0(pv)
+	lda	a1, errno
+	lda	v0, -1(zero)
+	stl	a3, 0(a1)
+1:
+	ret	zero,(ra),1
+
+	.size	__syscall_dual1,.-__syscall_dual1
+	.end	__syscall_dual1
diff --git a/usr/klibc/arch/alpha/sysstub.ph b/usr/klibc/arch/alpha/sysstub.ph
new file mode 100644
index 0000000..08b97e8
--- /dev/null
+++ b/usr/klibc/arch/alpha/sysstub.ph
@@ -0,0 +1,37 @@
+# -*- perl -*-
+#
+# arch/alpha/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+# On Alpha, most system calls follow the standard convention, with the
+# system call number in r0 (v0), return an error value in r19 (a3) as
+# well as the return value in r0 (v0).
+#
+# A few system calls are dual-return with the second return value in
+# r20 (a4).
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    $stype = $stype || 'common';
+    $stype = 'common' if ( $stype eq 'dual0' );
+
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print OUT "#include <asm/unistd.h>\n";
+    print OUT "#include <machine/asm.h>\n";
+    print OUT "\n";
+    print OUT "\t.text\n";
+    print OUT "\t.type ${fname},\@function\n";
+    print OUT "\t.ent\t${fname}, 0\n"; # What is this?
+    print OUT "\t.globl ${fname}\n";
+    print OUT "${fname}:\n";
+    print OUT "\tlda\tv0, __NR_${sname}(zero)\n";
+    print OUT "\tbr __syscall_${stype}\n";
+    print OUT "\t.size\t${fname},.-${fname}\n";
+    print OUT "\t.end\t${fname}\n";
+    close(OUT);
+}
+
+1;
