Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWFZBAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWFZBAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWFZA76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:58 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25743 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965104AbWFZA7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:31 -0400
Date: Sun, 25 Jun 2006 17:58:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 31/43] ppc support for klibc
Message-Id: <klibc.200606251757.31@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the ppc architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit a82c9b6e9b3428bae592241d1ac276054bc46fc5
tree 70852f39dd495c9bffc307d38f6da673d91ab08a
parent 078d6614054391efe17093f8d70340e2c0644ffb
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:37 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:37 -0700

 usr/include/arch/ppc/klibc/archconfig.h |   14 +++++++
 usr/include/arch/ppc/klibc/archsetjmp.h |   36 ++++++++++++++++++
 usr/include/arch/ppc/klibc/archsignal.h |   14 +++++++
 usr/include/arch/ppc/klibc/archstat.h   |   30 +++++++++++++++
 usr/include/arch/ppc/klibc/archsys.h    |   61 +++++++++++++++++++++++++++++++
 usr/klibc/arch/ppc/MCONFIG              |   29 +++++++++++++++
 usr/klibc/arch/ppc/Makefile.inc         |   22 +++++++++++
 usr/klibc/arch/ppc/crt0.S               |   23 ++++++++++++
 usr/klibc/arch/ppc/setjmp.S             |   34 +++++++++++++++++
 usr/klibc/arch/ppc/syscall.S            |   16 ++++++++
 usr/klibc/arch/ppc/sysstub.ph           |   25 +++++++++++++
 11 files changed, 304 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/ppc/klibc/archconfig.h b/usr/include/arch/ppc/klibc/archconfig.h
new file mode 100644
index 0000000..ce04eee
--- /dev/null
+++ b/usr/include/arch/ppc/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/ppc/klibc/archconfig.h
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
diff --git a/usr/include/arch/ppc/klibc/archsetjmp.h b/usr/include/arch/ppc/klibc/archsetjmp.h
new file mode 100644
index 0000000..4be9ed6
--- /dev/null
+++ b/usr/include/arch/ppc/klibc/archsetjmp.h
@@ -0,0 +1,36 @@
+/*
+ * arch/ppc/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __r2;
+	unsigned long __sp;
+	unsigned long __lr;
+	unsigned long __cr;
+	unsigned long __r13;
+	unsigned long __r14;
+	unsigned long __r15;
+	unsigned long __r16;
+	unsigned long __r17;
+	unsigned long __r18;
+	unsigned long __r19;
+	unsigned long __r20;
+	unsigned long __r21;
+	unsigned long __r22;
+	unsigned long __r23;
+	unsigned long __r24;
+	unsigned long __r25;
+	unsigned long __r26;
+	unsigned long __r27;
+	unsigned long __r28;
+	unsigned long __r29;
+	unsigned long __r30;
+	unsigned long __r31;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/ppc/klibc/archsignal.h b/usr/include/arch/ppc/klibc/archsignal.h
new file mode 100644
index 0000000..9c3ac92
--- /dev/null
+++ b/usr/include/arch/ppc/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/ppc/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/ppc/klibc/archstat.h b/usr/include/arch/ppc/klibc/archstat.h
new file mode 100644
index 0000000..9e31f4a
--- /dev/null
+++ b/usr/include/arch/ppc/klibc/archstat.h
@@ -0,0 +1,30 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+/* This matches struct stat64 in glibc2.1.
+ */
+struct stat {
+	__stdev64 (st_dev);		/* Device. */
+	unsigned long long st_ino;	/* File serial number.  */
+	unsigned int st_mode;		/* File mode.  */
+	unsigned int st_nlink;		/* Link count.  */
+	unsigned int st_uid;		/* User ID of the file's owner.  */
+	unsigned int st_gid;		/* Group ID of the file's group. */
+	__stdev64 (st_rdev); 		/* Device number, if device.  */
+	unsigned short int __pad2;
+	long long st_size;		/* Size of file, in bytes.  */
+	long st_blksize;		/* Optimal block size for I/O.  */
+
+	long long st_blocks;		/* Number 512-byte blocks allocated. */
+	struct timespec st_atim;	/* Time of last access.  */
+	struct timespec st_mtim;	/* Time of last modification.  */
+	struct timespec st_ctim;	/* Time of last status change.  */
+	unsigned long int __unused4;
+	unsigned long int __unused5;
+};
+
+#endif
diff --git a/usr/include/arch/ppc/klibc/archsys.h b/usr/include/arch/ppc/klibc/archsys.h
new file mode 100644
index 0000000..24752da
--- /dev/null
+++ b/usr/include/arch/ppc/klibc/archsys.h
@@ -0,0 +1,61 @@
+/*
+ * arch/ppc/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+/* PowerPC seems to lack _syscall6() in its headers */
+/* This seems to work on both 32- and 64-bit ppc */
+
+#ifndef _syscall6
+
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
+          type5,arg5,type6,arg6) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
+{ \
+        unsigned long __sc_ret, __sc_err;                               \
+        {                                                               \
+                register unsigned long __sc_0 __asm__ ("r0");           \
+                register unsigned long __sc_3 __asm__ ("r3");           \
+                register unsigned long __sc_4 __asm__ ("r4");           \
+                register unsigned long __sc_5 __asm__ ("r5");           \
+                register unsigned long __sc_6 __asm__ ("r6");           \
+                register unsigned long __sc_7 __asm__ ("r7");           \
+                register unsigned long __sc_8 __asm__ ("r8");           \
+                                                                        \
+                __sc_3 = (unsigned long) (arg1);                        \
+                __sc_4 = (unsigned long) (arg2);                        \
+                __sc_5 = (unsigned long) (arg3);                        \
+                __sc_6 = (unsigned long) (arg4);                        \
+                __sc_7 = (unsigned long) (arg5);                        \
+                __sc_8 = (unsigned long) (arg6);                        \
+                __sc_0 = __NR_##name;                                   \
+                __asm__ __volatile__                                    \
+                        ("sc           \n\t"                            \
+                         "mfcr %1      "                                \
+                        : "+r"   (__sc_3),				\
+			  "+r"   (__sc_0),             			\
+                          "+r"   (__sc_4),                              \
+                          "+r"   (__sc_5),                              \
+                          "+r"   (__sc_6),                              \
+                          "+r"   (__sc_7),                              \
+                          "+r"   (__sc_8)                               \
+                        : : "cr0", "ctr", "memory",                     \
+                            "r9", "r10", "r11", "r12");		        \
+                __sc_ret = __sc_3;                                      \
+                __sc_err = __sc_0;                                      \
+        }                                                               \
+        if (__sc_err & 0x10000000)                                      \
+        {                                                               \
+                errno = (int)__sc_ret;                                  \
+                __sc_ret = -1;                                          \
+        }                                                               \
+        return (type)__sc_ret;                                          \
+}
+
+#endif				/* _syscall6() missing */
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/klibc/arch/ppc/MCONFIG b/usr/klibc/arch/ppc/MCONFIG
new file mode 100644
index 0000000..5410933
--- /dev/null
+++ b/usr/klibc/arch/ppc/MCONFIG
@@ -0,0 +1,29 @@
+# -*- makefile -*-
+#
+# arch/ppc/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+gcc_m32_option  := $(call cc-option, -m32, )
+
+KLIBCOPTFLAGS	   = -Os
+KLIBCLDFLAGS       = -m elf32ppclinux
+KLIBCARCHREQFLAGS += $(gcc_m32_option)
+
+KLIBCBITSIZE       = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 256-16 MB - normal binaries start at 256 MB, and jumps are limited
+# to +/- 16 MB
+KLIBCSHAREDFLAGS     = -Ttext 0x0f800200
+
+# The kernel so far has both asm-ppc* and asm-powerpc.
+KLIBCARCHINCFLAGS = -I$(KLIBCKERNELOBJ)arch/$(KLIBCARCH)/include
+
+# The asm include files live in asm-powerpc
+KLIBCASMARCH	= powerpc
diff --git a/usr/klibc/arch/ppc/Makefile.inc b/usr/klibc/arch/ppc/Makefile.inc
new file mode 100644
index 0000000..53d99c4
--- /dev/null
+++ b/usr/klibc/arch/ppc/Makefile.inc
@@ -0,0 +1,22 @@
+# -*- makefile -*-
+#
+# arch/ppc/Makefile.inc
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
+
+KLIBCARCHSOOBJS = $(patsubst %.o,%.lo,$(KLIBCARCHOBJS))
+
+archclean:
diff --git a/usr/klibc/arch/ppc/crt0.S b/usr/klibc/arch/ppc/crt0.S
new file mode 100644
index 0000000..85b6dca
--- /dev/null
+++ b/usr/klibc/arch/ppc/crt0.S
@@ -0,0 +1,23 @@
+#
+# arch/ppc/crt0.S
+#
+
+	.text
+	.align 4
+	.type _start,@function
+	.globl _start
+_start:
+	stwu	1,-16(1)
+	addi	3,1,16
+	/*
+	 * the SVR4abippc.pdf specifies r7 as a pointer to
+	 * a termination function point
+	 * However, Section 8.4.1 of the LSB API docs say that
+	 * The value to be placed into register r7, the termination
+	 * function pointer, is not passed to the process.
+	 * So we stub it out, instead.
+	 */
+	li	4,0
+	bl	__libc_init
+
+	.size _start,.-_start
diff --git a/usr/klibc/arch/ppc/setjmp.S b/usr/klibc/arch/ppc/setjmp.S
new file mode 100644
index 0000000..e02b7da
--- /dev/null
+++ b/usr/klibc/arch/ppc/setjmp.S
@@ -0,0 +1,34 @@
+#
+# arch/ppc/setjmp.S
+#
+# Basic setjmp/longjmp implementation
+# This file was derived from the equivalent file in NetBSD
+#
+
+	.text
+	.align 4
+	.type setjmp,@function
+	.globl setjmp
+setjmp:
+        mflr    %r11                    /* save return address */
+        mfcr    %r12                    /* save condition register */
+        mr      %r10,%r1                /* save stack pointer */
+        mr      %r9,%r2                 /* save GPR2 (not needed) */
+        stmw    %r9,0(%r3)              /* save r9..r31 */
+        li      %r3,0                   /* indicate success */
+        blr                             /* return */
+
+	.size setjmp,.-setjmp
+
+	.type longjmp,@function
+	.globl longjmp
+longjmp:
+        lmw     %r9,0(%r3)              /* save r9..r31 */
+        mtlr    %r11                    /* restore LR */
+        mtcr    %r12                    /* restore CR */
+        mr      %r2,%r9                 /* restore GPR2 (not needed) */
+        mr      %r1,%r10                /* restore stack */
+        mr      %r3,%r4                 /* get return value */
+        blr                             /* return */
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/ppc/syscall.S b/usr/klibc/arch/ppc/syscall.S
new file mode 100644
index 0000000..0a7c37c
--- /dev/null
+++ b/usr/klibc/arch/ppc/syscall.S
@@ -0,0 +1,16 @@
+/*
+ * arch/ppc/syscall.S
+ *
+ * Common error-handling path for system calls.
+ */
+
+	.text
+	.align	2
+	.globl	__syscall_error
+	.type	__syscall_error,@function
+__syscall_error:
+	lis	9,errno@ha
+	stw	3,errno@l(9)
+	li	3,-1
+	blr
+	.size	__syscall_error,.-__syscall_error
diff --git a/usr/klibc/arch/ppc/sysstub.ph b/usr/klibc/arch/ppc/sysstub.ph
new file mode 100644
index 0000000..3b3916c
--- /dev/null
+++ b/usr/klibc/arch/ppc/sysstub.ph
@@ -0,0 +1,25 @@
+# -*- perl -*-
+#
+# arch/ppc/sysstub.ph
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
+    print OUT "\tli 0,__NR_${sname}\n";
+    print OUT "\tsc\n";
+    print OUT "\tbnslr\n";
+    print OUT "\tb __syscall_error\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
