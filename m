Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268213AbTBNGKY>; Fri, 14 Feb 2003 01:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTBNGKY>; Fri, 14 Feb 2003 01:10:24 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:44458 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S268213AbTBNGKV>;
	Fri, 14 Feb 2003 01:10:21 -0500
Date: Fri, 14 Feb 2003 17:19:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate signal numbers
Message-Id: <20030214171953.10a7d71e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I noticed that 13 of our architectures share the same set of signal
numbers (and um doesn't really count) so this patch creates
asm-generic/signum.h containing that set (it happens to be the set used by
i386).  I also created asm-*/signum.h so that it is clearer (I think) what
the idea is for future architectures.

Here is the generic and i386 parts of the patch.   Does this look worth
while doing, and do you want the rest of the patch?  The diffstat for the
whole thing looks like this:

 asm-alpha/signal.h     |   46 ------------------------------
 asm-alpha/signum.h     |   48 +++++++++++++++++++++++++++++++
 asm-arm/signal.h       |   45 -----------------------------
 asm-arm/signum.h       |    8 +++++
 asm-cris/signal.h      |   43 ----------------------------
 asm-cris/signum.h      |    6 +++
 asm-generic/signum.h   |   44 ++++++++++++++++++++++++++++
 asm-i386/signal.h      |   43 ----------------------------
 asm-i386/signum.h      |    6 +++
 asm-ia64/signal.h      |   44 ----------------------------
 asm-ia64/signum.h      |    6 +++
 asm-m68k/signal.h      |   43 ----------------------------
 asm-m68k/signum.h      |    6 +++
 asm-m68knommu/signal.h |   43 ----------------------------
 asm-m68knommu/signum.h |    6 +++
 asm-mips/signal.h      |   40 --------------------------
 asm-mips/signum.h      |   43 ++++++++++++++++++++++++++++
 asm-mips64/signal.h    |   40 --------------------------
 asm-mips64/signum.h    |   43 ++++++++++++++++++++++++++++
 asm-parisc/signal.h    |   43 ----------------------------
 asm-parisc/signum.h    |   47 ++++++++++++++++++++++++++++++
 asm-ppc/signal.h       |   43 ----------------------------
 asm-ppc/signum.h       |    6 +++
 asm-ppc64/signal.h     |   43 ----------------------------
 asm-ppc64/signum.h     |    6 +++
 asm-s390/signal.h      |   43 ----------------------------
 asm-s390/signum.h      |    6 +++
 asm-s390x/signal.h     |   43 ----------------------------
 asm-s390x/signum.h     |    6 +++
 asm-sh/signal.h        |   43 ----------------------------
 asm-sh/signum.h        |    6 +++
 asm-sparc/signal.h     |   72 -----------------------------------------------
 asm-sparc/signum.h     |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
 asm-sparc64/signal.h   |   72 -----------------------------------------------
 asm-sparc64/signum.h   |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
 asm-um/signum.h        |    6 +++
 asm-v850/signal.h      |   44 ----------------------------
 asm-v850/signum.h      |    6 +++
 asm-x86_64/signal.h    |   43 ----------------------------
 asm-x86_64/signum.h    |    6 +++
 40 files changed, 480 insertions(+), 857 deletions(-)

I intend to try to consolidate some more of the signal code over time,
this is just a small beginning.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-2003021309/include/asm-generic/signum.h 2.5.60-2003021309-signal.1/include/asm-generic/signum.h
--- 2.5.60-2003021309/include/asm-generic/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.60-2003021309-signal.1/include/asm-generic/signum.h	2003-02-14 11:38:42.000000000 +1100
@@ -0,0 +1,44 @@
+#ifndef _ASM_GENERIC_SIGNUM_H
+#define _ASM_GENERIC_SIGNUM_H
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGBUS		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGUSR1		10
+#define SIGSEGV		11
+#define SIGUSR2		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGSTKFLT	16
+#define SIGCHLD		17
+#define SIGCONT		18
+#define SIGSTOP		19
+#define SIGTSTP		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGURG		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGIO		29
+#define SIGPWR		30
+#define SIGSYS		31
+#define	SIGUNUSED	31
+
+#define SIGPOLL		SIGIO
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+#endif /* _ASM_GENERIC_SIGNUM_H */
diff -ruN 2.5.60-2003021309/include/asm-i386/signal.h 2.5.60-2003021309-signal.1/include/asm-i386/signal.h
--- 2.5.60-2003021309/include/asm-i386/signal.h	2003-02-13 09:55:25.000000000 +1100
+++ 2.5.60-2003021309-signal.1/include/asm-i386/signal.h	2003-02-13 17:40:27.000000000 +1100
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/linkage.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -29,48 +30,6 @@
 
 #endif /* __KERNEL__ */
 
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.60-2003021309/include/asm-i386/signum.h 2.5.60-2003021309-signal.1/include/asm-i386/signum.h
--- 2.5.60-2003021309/include/asm-i386/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.60-2003021309-signal.1/include/asm-i386/signum.h	2003-02-14 11:51:17.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_SIGNUM_H
+#define _ASM_I386_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_I386_SIGNUM_H */
