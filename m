Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293594AbSBZUtz>; Tue, 26 Feb 2002 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293542AbSBZUth>; Tue, 26 Feb 2002 15:49:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:5883 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S293580AbSBZUtV>; Tue, 26 Feb 2002 15:49:21 -0500
Date: Tue, 26 Feb 2002 21:44:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] Drop support for egcs from 2.5
Message-ID: <Pine.NEB.4.44.0202262131000.9458-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the patch below drops support for egcs from 2.5. This patch doesn't remove
egcs workarounds, it only causes the kernel to refuse to build with egcs
and to document this. The affected files are:

init/main.c:
refuse to build with egcs

README and Documentation/Changes:
document that egcs is no longer supported

arch/arm/tools/getconstants.c:
now that the check for gcc >= 2.95 is in init/main.c the same check is no
longer needed in this file

cu
Adrian


--- init/main.c.old	Tue Feb 26 21:25:30 2002
+++ init/main.c	Tue Feb 26 21:25:55 2002
@@ -50,7 +50,7 @@
  * To avoid associated bogus bug reports, we flatly refuse to compile
  * with a gcc that is known to be too old from the very beginning.
  */
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91)
+#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif

--- README.old	Wed Jan 23 22:46:19 2002
+++ README	Wed Jan 23 22:47:01 2002
@@ -153,8 +153,8 @@

 COMPILING the kernel:

- - Make sure you have gcc 2.95.3 available.  gcc 2.91.66 (egcs-1.1.2) may
-   also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
+ - Make sure you have gcc 2.95.3 available. *gcc 2.7.2.3 and gcc 2.91.66
+   (egcs-1.1.2) are no longer supported*.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
    if necessary. For more information, refer to ./Documentation/Changes.

--- Documentation/Changes.old	Tue Feb 26 21:25:19 2002
+++ Documentation/Changes	Tue Feb 26 21:26:36 2002
@@ -76,13 +76,11 @@
 have not received much testing for Linux kernel compilation, and there are
 almost certainly bugs (mainly, but not exclusively, in the kernel) that
 will need to be fixed in order to use these compilers. In any case, using
-pgcc instead of egcs or plain gcc is just asking for trouble.
+pgcc instead of plain gcc is just asking for trouble.

-Note that gcc 2.7.2.3 is no longer a supported kernel compiler. The kernel
-no longer works around bugs in gcc 2.7.2.3 and, in fact, will refuse to
-be compiled with it. egcs-1.1.2 has register allocation problems in very
-obscure cases. We have ensured the kernel does not trip these in any known
-situation. The 2.5 tree is likely to drop egcs-1.1.2 workarounds.
+Note that gcc 2.7.2.3 and egcs are no longer supported kernel compilers.
+The kernel no longer works around bugs these compilers and, in fact, will
+refuse to be compiled with them.

 The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
 You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
@@ -263,10 +261,6 @@

 Kernel compilation
 ******************
-
-egcs 1.1.2 (gcc 2.91.66)
-------------------------
-o  <ftp://sourceware.cygnus.com/pub/gcc/releases/egcs-1.1.2/egcs-1.1.2.tar.bz2>

 gcc 2.95.3
 ----------
--- arch/arm/tools/getconstants.c.old	Wed Jan 23 22:49:39 2002
+++ arch/arm/tools/getconstants.c	Wed Jan 23 22:57:35 2002
@@ -23,9 +23,6 @@
 #if defined(__APCS_26__) && defined(CONFIG_CPU_32)
 #error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
 #endif
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
-#error Sorry, your compiler is known to miscompile kernels.  Only use gcc 2.95.3 and later.
-#endif
 #if __GNUC__ == 2 && __GNUC_MINOR__ == 95
 /* shame we can't detect the .1 or .2 releases */
 #warning GCC 2.95.2 and earlier miscompiles kernels.


