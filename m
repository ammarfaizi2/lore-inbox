Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275391AbTHITls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275400AbTHITls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:41:48 -0400
Received: from [66.212.224.118] ([66.212.224.118]:43785 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275391AbTHITlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:41:31 -0400
Date: Sat, 9 Aug 2003 15:29:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH][2.6] WARN_ON_STACK_VAR aka fighting variable lifetime bugs
Message-ID: <Pine.LNX.4.53.0308091430410.32166@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This macro allows us to detect whether a variable is on the stack or not. 
Originally devised to help detect some strange IDE/elevator bugs Bill and 
myself came across in the -wli tree. My apologies as it's simply cut and 
paste for the other architectures, hopefully it doesn't break on 
something badly, i don't know them all that well.

 asm-alpha/bug.h     |    4 ++++
 asm-arm/bug.h       |    4 ++++
 asm-arm26/bug.h     |    4 ++++
 asm-cris/bug.h      |    4 ++++
 asm-h8300/bug.h     |    4 ++++
 asm-i386/bug.h      |    4 ++++
 asm-ia64/bug.h      |    4 ++++
 asm-m68k/bug.h      |    4 ++++
 asm-m68knommu/bug.h |    4 ++++
 asm-mips/bug.h      |    4 ++++
 asm-mips64/bug.h    |    4 ++++
 asm-parisc/bug.h    |    4 ++++
 asm-ppc/bug.h       |    4 ++++
 asm-ppc64/bug.h     |    4 ++++
 asm-s390/bug.h      |    4 ++++
 asm-sh/bug.h        |    4 ++++
 asm-sparc/bug.h     |    4 ++++
 asm-sparc64/bug.h   |    4 ++++
 asm-um/bug.h        |    4 ++++
 asm-v850/bug.h      |    4 ++++
 asm-x86_64/bug.h    |    4 ++++
 21 files changed, 84 insertions(+)

Index: linux-2.6.0-test2-irq/include/asm-alpha/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-alpha/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-alpha/bug.h	30 Jul 2003 00:06:37 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-alpha/bug.h	9 Aug 2003 19:14:55 -0000
@@ -20,4 +20,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-arm/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-arm/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-arm/bug.h	30 Jul 2003 00:06:36 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-arm/bug.h	9 Aug 2003 19:14:42 -0000
@@ -27,4 +27,8 @@ extern volatile void __bug(const char *f
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-arm26/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-arm26/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-arm26/bug.h	30 Jul 2003 00:06:39 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-arm26/bug.h	9 Aug 2003 19:14:33 -0000
@@ -27,4 +27,8 @@ extern volatile void __bug(const char *f
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-cris/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-cris/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-cris/bug.h	30 Jul 2003 00:06:39 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-cris/bug.h	9 Aug 2003 19:14:25 -0000
@@ -18,4 +18,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-h8300/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-h8300/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-h8300/bug.h	30 Jul 2003 00:06:37 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-h8300/bug.h	9 Aug 2003 19:14:18 -0000
@@ -18,4 +18,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-i386/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-i386/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-i386/bug.h	30 Jul 2003 00:06:38 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-i386/bug.h	9 Aug 2003 16:28:34 -0000
@@ -32,4 +32,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-ia64/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-ia64/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-ia64/bug.h	30 Jul 2003 00:06:30 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-ia64/bug.h	9 Aug 2003 19:14:09 -0000
@@ -19,4 +19,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-m68k/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-m68k/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-m68k/bug.h	30 Jul 2003 00:06:32 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-m68k/bug.h	9 Aug 2003 19:14:00 -0000
@@ -37,4 +37,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-m68knommu/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-m68knommu/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-m68knommu/bug.h	30 Jul 2003 00:06:32 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-m68knommu/bug.h	9 Aug 2003 19:09:11 -0000
@@ -21,4 +21,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-mips/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-mips/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-mips/bug.h	30 Jul 2003 00:06:29 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-mips/bug.h	9 Aug 2003 19:09:01 -0000
@@ -18,4 +18,8 @@ do {									\
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-mips64/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-mips64/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-mips64/bug.h	30 Jul 2003 00:06:30 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-mips64/bug.h	9 Aug 2003 19:08:53 -0000
@@ -18,4 +18,8 @@ do {									\
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-parisc/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-parisc/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-parisc/bug.h	30 Jul 2003 00:06:32 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-parisc/bug.h	9 Aug 2003 19:08:46 -0000
@@ -26,4 +26,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-ppc/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-ppc/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-ppc/bug.h	30 Jul 2003 00:06:31 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-ppc/bug.h	9 Aug 2003 19:08:38 -0000
@@ -45,4 +45,8 @@ struct bug_entry {
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-ppc64/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-ppc64/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-ppc64/bug.h	30 Jul 2003 00:06:28 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-ppc64/bug.h	9 Aug 2003 19:07:25 -0000
@@ -55,5 +55,9 @@ struct bug_entry {
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
 #endif
Index: linux-2.6.0-test2-irq/include/asm-s390/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-s390/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-s390/bug.h	30 Jul 2003 00:06:38 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-s390/bug.h	9 Aug 2003 19:06:51 -0000
@@ -22,4 +22,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-sh/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-sh/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-sh/bug.h	30 Jul 2003 00:06:39 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-sh/bug.h	9 Aug 2003 19:06:43 -0000
@@ -27,4 +27,8 @@
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-sparc/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-sparc/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-sparc/bug.h	30 Jul 2003 00:06:37 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-sparc/bug.h	9 Aug 2003 19:06:34 -0000
@@ -41,4 +41,8 @@ extern void do_BUG(const char *file, int
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-sparc64/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-sparc64/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-sparc64/bug.h	30 Jul 2003 00:06:38 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-sparc64/bug.h	9 Aug 2003 19:06:22 -0000
@@ -29,4 +29,8 @@ extern void do_BUG(const char *file, int
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-um/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-um/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-um/bug.h	30 Jul 2003 00:06:35 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-um/bug.h	9 Aug 2003 19:05:28 -0000
@@ -27,4 +27,8 @@ extern int foo;
 
 #endif
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
Index: linux-2.6.0-test2-irq/include/asm-v850/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-v850/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-v850/bug.h	30 Jul 2003 00:06:39 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-v850/bug.h	9 Aug 2003 19:05:19 -0000
@@ -27,4 +27,8 @@ extern void __bug (void) __attribute__ (
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif /* __V850_BUG_H__ */
Index: linux-2.6.0-test2-irq/include/asm-x86_64/bug.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/include/asm-x86_64/bug.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bug.h
--- linux-2.6.0-test2-irq/include/asm-x86_64/bug.h	30 Jul 2003 00:06:30 -0000	1.1.1.1
+++ linux-2.6.0-test2-irq/include/asm-x86_64/bug.h	9 Aug 2003 19:05:06 -0000
@@ -29,4 +29,8 @@ void out_of_line_bug(void);
 	} \
 } while (0)
 
+#define WARN_ON_STACK_VAR(ptr) do { \
+	unsigned long __ti = (unsigned long)current_thread_info(); \
+	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
+} while (0)
 #endif
