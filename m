Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWFZBGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWFZBGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWFZBGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:06:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22671 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965009AbWFZA7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:18 -0400
Date: Sun, 25 Jun 2006 17:58:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 32/43] ppc64 support for klibc
Message-Id: <klibc.200606251757.32@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the ppc64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 6db62c809bf46ac8a9f743513384d29fd339f877
tree e4850136d00d6b9fc1d5fb7eae9a329ac79947e1
parent a82c9b6e9b3428bae592241d1ac276054bc46fc5
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:40 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:40 -0700

 usr/include/arch/ppc64/klibc/archconfig.h |   12 ++++
 usr/include/arch/ppc64/klibc/archsetjmp.h |   36 ++++++++++++
 usr/include/arch/ppc64/klibc/archsignal.h |   14 +++++
 usr/include/arch/ppc64/klibc/archstat.h   |   27 +++++++++
 usr/include/arch/ppc64/klibc/archsys.h    |   52 ++++++++++++++++++
 usr/klibc/arch/ppc64/MCONFIG              |   26 +++++++++
 usr/klibc/arch/ppc64/Makefile.inc         |   25 +++++++++
 usr/klibc/arch/ppc64/crt0.S               |   32 +++++++++++
 usr/klibc/arch/ppc64/setjmp.S             |   85 +++++++++++++++++++++++++++++
 usr/klibc/arch/ppc64/syscall.c            |   14 +++++
 usr/klibc/arch/ppc64/sysstub.ph           |   31 +++++++++++
 11 files changed, 354 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/ppc64/klibc/archconfig.h b/usr/include/arch/ppc64/klibc/archconfig.h
new file mode 100644
index 0000000..27c5630
--- /dev/null
+++ b/usr/include/arch/ppc64/klibc/archconfig.h
@@ -0,0 +1,12 @@
+/*
+ * include/arch/ppc64/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in this file.
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+#define _KLIBC_USE_RT_SIG 1
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/ppc64/klibc/archsetjmp.h b/usr/include/arch/ppc64/klibc/archsetjmp.h
new file mode 100644
index 0000000..d227728
--- /dev/null
+++ b/usr/include/arch/ppc64/klibc/archsetjmp.h
@@ -0,0 +1,36 @@
+/*
+ * arch/ppc64/include/klibc/archsetjmp.h
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
diff --git a/usr/include/arch/ppc64/klibc/archsignal.h b/usr/include/arch/ppc64/klibc/archsignal.h
new file mode 100644
index 0000000..2c4cef0
--- /dev/null
+++ b/usr/include/arch/ppc64/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/ppc64/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/ppc64/klibc/archstat.h b/usr/include/arch/ppc64/klibc/archstat.h
new file mode 100644
index 0000000..491316c
--- /dev/null
+++ b/usr/include/arch/ppc64/klibc/archstat.h
@@ -0,0 +1,27 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	__stdev64	(st_dev);
+	ino_t		st_ino;
+	nlink_t		st_nlink;
+	mode_t		st_mode;
+	uid_t 		st_uid;
+	gid_t 		st_gid;
+	__stdev64	(st_rdev);
+	off_t		st_size;
+	unsigned long  	st_blksize;
+	unsigned long  	st_blocks;
+	struct timespec st_atim;	/* Time of last access.  */
+	struct timespec st_mtim;	/* Time of last modification.  */
+	struct timespec st_ctim;	/* Time of last status change.  */
+	unsigned long  	__unused4;
+	unsigned long  	__unused5;
+	unsigned long  	__unused6;
+};
+
+#endif
diff --git a/usr/include/arch/ppc64/klibc/archsys.h b/usr/include/arch/ppc64/klibc/archsys.h
new file mode 100644
index 0000000..e65d188
--- /dev/null
+++ b/usr/include/arch/ppc64/klibc/archsys.h
@@ -0,0 +1,52 @@
+/*
+ * arch/ppc64/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
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
+                        : "=&r" (__sc_3), "=&r" (__sc_0)                \
+                        : "0"   (__sc_3), "1"   (__sc_0),               \
+                          "r"   (__sc_4),                               \
+                          "r"   (__sc_5),                               \
+                          "r"   (__sc_6),                               \
+                          "r"   (__sc_7),                               \
+                          "r"   (__sc_8)                                \
+                        : __syscall_clobbers);                          \
+                __sc_ret = __sc_3;                                      \
+                __sc_err = __sc_0;                                      \
+        }                                                               \
+        __syscall_return (type);                                        \
+}
+
+#endif				/* _syscall6() missing */
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/klibc/arch/ppc64/MCONFIG b/usr/klibc/arch/ppc64/MCONFIG
new file mode 100644
index 0000000..6d8e136
--- /dev/null
+++ b/usr/klibc/arch/ppc64/MCONFIG
@@ -0,0 +1,26 @@
+# -*- makefile -*-
+#
+# arch/ppc64/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHREQFLAGS = -m64 -mcall-aixdesc
+KLIBCOPTFLAGS     = -Os
+KLIBCBITSIZE      = 64
+KLIBCLDFLAGS      = -m elf64ppc
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 256-16 MB - normal binaries start at 256 MB, and jumps are limited
+# to +/- 16 MB
+KLIBCSHAREDFLAGS     = -Ttext 0x0f000200
+
+# The kernel so far has both asm-ppc* and asm-powerpc.
+KLIBCARCHINCFLAGS = -I$(KLIBCKERNELOBJ)arch/$(KLIBCARCH)/include
+
+# The asm include files live in asm-powerpc
+KLIBCASMARCH	= powerpc
diff --git a/usr/klibc/arch/ppc64/Makefile.inc b/usr/klibc/arch/ppc64/Makefile.inc
new file mode 100644
index 0000000..80f6be5
--- /dev/null
+++ b/usr/klibc/arch/ppc64/Makefile.inc
@@ -0,0 +1,25 @@
+# -*- makefile -*-
+#
+# arch/ppc64/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o
+
+KLIBCARCHSOOBJS = $(patsubst %.o,%.lo,$(KLIBCARCHOBJS))
+
+INTERP_O = interp1.o
+
+interp.o: interp1.o klibc.got
+	$(LD) $(KLIBCLDFLAGS) -r -o $@ interp1.o klibc.got
+
+klibc.got: $(SOHASH)
+	$(OBJCOPY) -j .got $< $@
+
+archclean:
+	rm -f klibc.got
diff --git a/usr/klibc/arch/ppc64/crt0.S b/usr/klibc/arch/ppc64/crt0.S
new file mode 100644
index 0000000..a7776a1
--- /dev/null
+++ b/usr/klibc/arch/ppc64/crt0.S
@@ -0,0 +1,32 @@
+#
+# arch/ppc64/crt0.S
+#
+# void _start(void)
+# {
+#    /* Divine up argc, argv, and envp */
+#    environ = envp;
+#    exit(main(argc, argv, envp));
+# }
+#
+
+	.section ".toc","aw"
+.LC0:	.tc	environ[TC],environ
+
+	.section ".opd","aw"
+	.align 3
+	.globl _start
+_start:
+	.quad	._start
+	.quad	.TOC.@tocbase, 0
+
+	.text
+	.globl	._start
+	.type	._start,@function
+._start:
+	stdu    %r1,-32(%r1)
+	addi    %r3,%r1,32
+	li	%r4,0		/* fini (unused) */
+	b 	.__libc_init
+	nop
+
+	.size _start,.-_start
diff --git a/usr/klibc/arch/ppc64/setjmp.S b/usr/klibc/arch/ppc64/setjmp.S
new file mode 100644
index 0000000..30db419
--- /dev/null
+++ b/usr/klibc/arch/ppc64/setjmp.S
@@ -0,0 +1,85 @@
+#
+# arch/ppc64/setjmp.S
+#
+# Basic setjmp/longjmp implementation
+#
+
+	.text
+	.align 4
+
+	.section ".opd","aw"
+setjmp:
+	.quad	.setjmp,.TOC.@tocbase,0
+	.previous
+	.size	setjmp,24
+	.type	.setjmp,@function
+	.globl	setjmp
+	.globl	.setjmp
+.setjmp:
+	mflr	%r11			/* save return address */
+	mfcr	%r12			/* save condition register */
+	std	%r2,0(%r3)		/* save TOC pointer (not needed) */
+	stdu	%r1,8(%r3)		/* save stack pointer */
+	stdu	%r11,8(%r3)
+	stdu	%r12,8(%r3)
+	stdu	%r13,8(%r3)		/* save caller saved regs */
+	stdu	%r14,8(%r3)
+	stdu	%r15,8(%r3)
+	stdu	%r16,8(%r3)
+	stdu	%r17,8(%r3)
+	stdu	%r18,8(%r3)
+	stdu	%r19,8(%r3)
+	stdu	%r20,8(%r3)
+	stdu	%r21,8(%r3)
+	stdu	%r22,8(%r3)
+	stdu	%r23,8(%r3)
+	stdu	%r24,8(%r3)
+	stdu	%r25,8(%r3)
+	stdu	%r26,8(%r3)
+	stdu	%r27,8(%r3)
+	stdu	%r28,8(%r3)
+	stdu	%r29,8(%r3)
+	stdu	%r30,8(%r3)
+	std	%r31,8(%r3)
+	li	%r3,0			/* indicate success */
+	blr				/* return */
+
+	.size .setjmp,.-.setjmp
+	.section ".opd","aw"
+longjmp:
+	.quad	.longjmp,.TOC.@tocbase,0
+	.previous
+	.size	longjmp,24
+	.type	.longjmp,@function
+	.globl	longjmp
+	.globl	.longjmp
+.longjmp:
+	ld	%r2,0(%r3)		/* restore TOC pointer (not needed) */
+	ldu	%r1,8(%r3)		/* restore stack */
+	ldu	%r11,8(%r3)
+	ldu	%r12,8(%r3)
+	ldu	%r13,8(%r3)		/* restore caller saved regs */
+	ldu	%r14,8(%r3)
+	ldu	%r15,8(%r3)
+	ldu	%r16,8(%r3)
+	ldu	%r17,8(%r3)
+	ldu	%r18,8(%r3)
+	ldu	%r19,8(%r3)
+	ldu	%r20,8(%r3)
+	ldu	%r21,8(%r3)
+	ldu	%r22,8(%r3)
+	ldu	%r23,8(%r3)
+	ldu	%r24,8(%r3)
+	ldu	%r25,8(%r3)
+	ldu	%r26,8(%r3)
+	ldu	%r27,8(%r3)
+	ldu	%r28,8(%r3)
+	ldu	%r29,8(%r3)
+	ldu	%r30,8(%r3)
+	ld	%r31,8(%r3)
+	mtlr	%r11			/* restore LR */
+	mtcr	%r12			/* restore CR */
+	mr	%r3,%r4			/* get return value */
+	blr				/* return */
+
+	.size .longjmp,.-.longjmp
diff --git a/usr/klibc/arch/ppc64/syscall.c b/usr/klibc/arch/ppc64/syscall.c
new file mode 100644
index 0000000..a5895fe
--- /dev/null
+++ b/usr/klibc/arch/ppc64/syscall.c
@@ -0,0 +1,14 @@
+/*
+ * arch/ppc64/syscall.c
+ *
+ * Common error-handling path for system calls.
+ * The return value from __syscall_error becomes the
+ * return value from the system call.
+ */
+#include <errno.h>
+
+long int __syscall_error(long int err)
+{
+	errno = err;
+	return -1;
+}
diff --git a/usr/klibc/arch/ppc64/sysstub.ph b/usr/klibc/arch/ppc64/sysstub.ph
new file mode 100644
index 0000000..9ee9370
--- /dev/null
+++ b/usr/klibc/arch/ppc64/sysstub.ph
@@ -0,0 +1,31 @@
+# -*- perl -*-
+#
+# arch/ppc64/sysstub.ph
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
+    print OUT "\t.globl ${fname}\n";
+    print OUT "\t.section \".opd\",\"aw\"\n";
+    print OUT "\t.align 3\n";
+    print OUT "${fname}:\n";
+    print OUT "\t.quad .${fname},.TOC.\@tocbase,0\n";
+    print OUT "\t.text\n";
+    print OUT "\t.type .${fname},\@function\n";
+    print OUT "\t.globl .${fname}\n";
+    print OUT ".${fname}:\n";
+    print OUT "\tli 0,__NR_${sname}\n";
+    print OUT "\tsc\n";
+    print OUT "\tbnslr\n";
+    print OUT "\tb .__syscall_error\n";
+    print OUT "\t.size .${fname},.-.${fname}\n";
+    close(OUT);
+}
+
+1;
