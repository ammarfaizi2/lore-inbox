Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132036AbQKCVVP>; Fri, 3 Nov 2000 16:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbQKCVVG>; Fri, 3 Nov 2000 16:21:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129559AbQKCVUv>; Fri, 3 Nov 2000 16:20:51 -0500
Message-ID: <3A032C1D.D50C8D46@transmeta.com>
Date: Fri, 03 Nov 2000 13:20:29 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gcc@vger.kernel.org
Subject: asm/resource.h
Content-Type: multipart/mixed;
 boundary="------------3ADAEE5C8404AC7E5B173250"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3ADAEE5C8404AC7E5B173250
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello friends,

Attached is a patch against 2.4.0-test10 that changes asm/resource.h to
define RLIM_INFINITY insite the #ifdef __KERNEL__ on all architectures;
previously, this was inconsistent between architecures.  This breaks
compilation with -Werror at least on i386 since <bits/resource.h>
includes <asm/resource.h>, at least on glibc-2.1.2.

I have only been able to test this on i386 and glibc 2.1.2.  If there are
any places where this change is *not* appropriate, now would be a good
time to holler...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
--------------3ADAEE5C8404AC7E5B173250
Content-Type: text/plain; charset=us-ascii;
 name="resource.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource.diff"

diff -ur linux-2.4.0-test10-orig/include/asm/resource.h linux-2.4.0-test10/include/asm/resource.h
--- linux-2.4.0-test10-orig/include/asm/resource.h	Fri Sep 22 14:21:19 2000
+++ linux-2.4.0-test10/include/asm/resource.h	Fri Nov  3 13:11:12 2000
@@ -19,13 +19,13 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-alpha/resource.h linux-2.4.0-test10/include/asm-alpha/resource.h
--- linux-2.4.0-test10-orig/include/asm-alpha/resource.h	Wed Sep 27 13:39:23 2000
+++ linux-2.4.0-test10/include/asm-alpha/resource.h	Fri Nov  3 13:11:30 2000
@@ -19,14 +19,14 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
  * we retain the old value for compatibility, especially with DU. 
  * When you run into the 2^63 barrier, you call me.
  */
 #define RLIM_INFINITY	0x7ffffffffffffffful
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS							\
 {									\
diff -ur linux-2.4.0-test10-orig/include/asm-i386/resource.h linux-2.4.0-test10/include/asm-i386/resource.h
--- linux-2.4.0-test10-orig/include/asm-i386/resource.h	Fri Sep 22 14:21:19 2000
+++ linux-2.4.0-test10/include/asm-i386/resource.h	Fri Nov  3 13:11:12 2000
@@ -19,13 +19,13 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-ia64/resource.h linux-2.4.0-test10/include/asm-ia64/resource.h
--- linux-2.4.0-test10-orig/include/asm-ia64/resource.h	Fri Sep 22 14:21:19 2000
+++ linux-2.4.0-test10/include/asm-ia64/resource.h	Fri Nov  3 13:11:04 2000
@@ -22,13 +22,13 @@
 
 #define RLIM_NLIMITS	11
 
+# ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY  (~0UL)
-
-# ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-m68k/resource.h linux-2.4.0-test10/include/asm-m68k/resource.h
--- linux-2.4.0-test10-orig/include/asm-m68k/resource.h	Fri Sep 22 14:21:20 2000
+++ linux-2.4.0-test10/include/asm-m68k/resource.h	Fri Nov  3 13:10:54 2000
@@ -19,13 +19,13 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS	\
 {                       \
diff -ur linux-2.4.0-test10-orig/include/asm-mips/resource.h linux-2.4.0-test10/include/asm-mips/resource.h
--- linux-2.4.0-test10-orig/include/asm-mips/resource.h	Fri Sep 22 14:21:20 2000
+++ linux-2.4.0-test10/include/asm-mips/resource.h	Fri Nov  3 13:10:44 2000
@@ -26,13 +26,13 @@
 
 #define RLIM_NLIMITS 11			/* Number of limit flavors.  */
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	0x7fffffffUL
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-mips64/resource.h linux-2.4.0-test10/include/asm-mips64/resource.h
--- linux-2.4.0-test10-orig/include/asm-mips64/resource.h	Fri Sep 22 14:21:20 2000
+++ linux-2.4.0-test10/include/asm-mips64/resource.h	Fri Nov  3 13:10:30 2000
@@ -27,13 +27,13 @@
 
 #define RLIM_NLIMITS 11			/* Number of limit flavors.  */
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY  (~0UL)
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-s390/resource.h linux-2.4.0-test10/include/asm-s390/resource.h
--- linux-2.4.0-test10-orig/include/asm-s390/resource.h	Fri Sep 22 14:21:21 2000
+++ linux-2.4.0-test10/include/asm-s390/resource.h	Fri Nov  3 13:10:13 2000
@@ -27,13 +27,13 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY   (~0UL)
-
-#ifdef __KERNEL__
 
 #define INIT_RLIMITS					\
 {							\
diff -ur linux-2.4.0-test10-orig/include/asm-sparc/resource.h linux-2.4.0-test10/include/asm-sparc/resource.h
--- linux-2.4.0-test10-orig/include/asm-sparc/resource.h	Tue Oct 10 10:33:52 2000
+++ linux-2.4.0-test10/include/asm-sparc/resource.h	Fri Nov  3 13:09:46 2000
@@ -25,6 +25,8 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * We make this unsigned, but keep the
@@ -32,7 +34,6 @@
  */
 #define RLIM_INFINITY	0x7fffffff
 
-#ifdef __KERNEL__
 #define INIT_RLIMITS			\
 {					\
     {RLIM_INFINITY, RLIM_INFINITY},	\
diff -ur linux-2.4.0-test10-orig/include/asm-sparc64/resource.h linux-2.4.0-test10/include/asm-sparc64/resource.h
--- linux-2.4.0-test10-orig/include/asm-sparc64/resource.h	Tue Oct 10 10:33:52 2000
+++ linux-2.4.0-test10/include/asm-sparc64/resource.h	Fri Nov  3 13:09:29 2000
@@ -25,13 +25,14 @@
 
 #define RLIM_NLIMITS	11
 
+#ifdef __KERNEL__
+
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
 #define RLIM_INFINITY	(~0UL)
 
-#ifdef __KERNEL__
 #define INIT_RLIMITS			\
 {					\
     {RLIM_INFINITY, RLIM_INFINITY},	\

--------------3ADAEE5C8404AC7E5B173250--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
