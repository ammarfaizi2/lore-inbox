Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263549AbTCUHQ7>; Fri, 21 Mar 2003 02:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbTCUHQ7>; Fri, 21 Mar 2003 02:16:59 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:23992 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S263549AbTCUHOr>;
	Fri, 21 Mar 2003 02:14:47 -0500
Date: Fri, 21 Mar 2003 18:25:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Consolidate signal numbers
Message-Id: <20030321182532.3aa15292.sfr@canb.auug.org.au>
In-Reply-To: <20030214171953.10a7d71e.sfr@canb.auug.org.au>
References: <20030214171953.10a7d71e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, 14 Feb 2003 17:19:53 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I noticed that 13 of our architectures share the same set of signal
> numbers (and um doesn't really count) so this patch creates
> asm-generic/signum.h containing that set (it happens to be the set used by
> i386).  I also created asm-*/signum.h so that it is clearer (I think) what
> the idea is for future architectures.
> 
> Here is the generic and i386 parts of the patch.   Does this look worth
> while doing, and do you want the rest of the patch?  The diffstat for the
> whole thing looks like this:
> 
>  asm-alpha/signal.h     |   46 ------------------------------
>  asm-alpha/signum.h     |   48 +++++++++++++++++++++++++++++++
>  asm-arm/signal.h       |   45 -----------------------------
>  asm-arm/signum.h       |    8 +++++
>  asm-cris/signal.h      |   43 ----------------------------
>  asm-cris/signum.h      |    6 +++
>  asm-generic/signum.h   |   44 ++++++++++++++++++++++++++++
>  asm-i386/signal.h      |   43 ----------------------------
>  asm-i386/signum.h      |    6 +++
>  asm-ia64/signal.h      |   44 ----------------------------
>  asm-ia64/signum.h      |    6 +++
>  asm-m68k/signal.h      |   43 ----------------------------
>  asm-m68k/signum.h      |    6 +++
>  asm-m68knommu/signal.h |   43 ----------------------------
>  asm-m68knommu/signum.h |    6 +++
>  asm-mips/signal.h      |   40 --------------------------
>  asm-mips/signum.h      |   43 ++++++++++++++++++++++++++++
>  asm-mips64/signal.h    |   40 --------------------------
>  asm-mips64/signum.h    |   43 ++++++++++++++++++++++++++++
>  asm-parisc/signal.h    |   43 ----------------------------
>  asm-parisc/signum.h    |   47 ++++++++++++++++++++++++++++++
>  asm-ppc/signal.h       |   43 ----------------------------
>  asm-ppc/signum.h       |    6 +++
>  asm-ppc64/signal.h     |   43 ----------------------------
>  asm-ppc64/signum.h     |    6 +++
>  asm-s390/signal.h      |   43 ----------------------------
>  asm-s390/signum.h      |    6 +++
>  asm-s390x/signal.h     |   43 ----------------------------
>  asm-s390x/signum.h     |    6 +++
>  asm-sh/signal.h        |   43 ----------------------------
>  asm-sh/signum.h        |    6 +++
>  asm-sparc/signal.h     |   72 -----------------------------------------------
>  asm-sparc/signum.h     |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  asm-sparc64/signal.h   |   72 -----------------------------------------------
>  asm-sparc64/signum.h   |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  asm-um/signum.h        |    6 +++
>  asm-v850/signal.h      |   44 ----------------------------
>  asm-v850/signum.h      |    6 +++
>  asm-x86_64/signal.h    |   43 ----------------------------
>  asm-x86_64/signum.h    |    6 +++
>  40 files changed, 480 insertions(+), 857 deletions(-)
> 
> I intend to try to consolidate some more of the signal code over time,
> this is just a small beginning.

This time here is the whole patch.  I hope you can see its usefulness.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65/include/asm-alpha/signal.h 2.5.65-signal.1/include/asm-alpha/signal.h
--- 2.5.65/include/asm-alpha/signal.h	2003-02-15 23:19:59.000000000 +1100
+++ 2.5.65-signal.1/include/asm-alpha/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASMAXP_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -28,51 +29,6 @@
 
 #endif /* __KERNEL__ */
 
-
-/*
- * Linux/AXP has different signal numbers that Linux/i386: I'm trying
- * to make it OSF/1 binary compatible, at least for normal binaries.
- */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGEMT		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGBUS		10
-#define SIGSEGV		11
-#define SIGSYS		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGURG		16
-#define SIGSTOP		17
-#define SIGTSTP		18
-#define SIGCONT		19
-#define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGIO		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGINFO		29
-#define SIGUSR1		30
-#define SIGUSR2		31
-
-#define SIGPOLL	SIGIO
-#define SIGPWR	SIGINFO
-#define SIGIOT	SIGABRT
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-alpha/signum.h 2.5.65-signal.1/include/asm-alpha/signum.h
--- 2.5.65/include/asm-alpha/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-alpha/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,48 @@
+#ifndef _ASM_ALPHA_SIGNUM_H
+#define _ASM_ALPHA_SIGNUM_H
+
+/*
+ * Linux/AXP has different signal numbers that Linux/i386: I'm trying
+ * to make it OSF/1 binary compatible, at least for normal binaries.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGEMT		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGBUS		10
+#define SIGSEGV		11
+#define SIGSYS		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG		16
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGINFO		29
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+#define SIGPOLL	SIGIO
+#define SIGPWR	SIGINFO
+#define SIGIOT	SIGABRT
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+#endif /* _ASM_ALPHA_SIGNUM_H */
diff -ruN 2.5.65/include/asm-arm/signal.h 2.5.65-signal.1/include/asm-arm/signal.h
--- 2.5.65/include/asm-arm/signal.h	2003-02-18 11:46:42.000000000 +1100
+++ 2.5.65-signal.1/include/asm-arm/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASMARM_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -28,50 +29,6 @@
 
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
-#define SIGSWI		32
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-arm/signum.h 2.5.65-signal.1/include/asm-arm/signum.h
--- 2.5.65/include/asm-arm/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-arm/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,8 @@
+#ifndef _ASM_ARM_SIGNUM_H
+#define _ASM_ARM_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#define SIGSWI		32
+
+#endif /* _ASM_ARM_SIGNUM_H */
diff -ruN 2.5.65/include/asm-cris/signal.h 2.5.65-signal.1/include/asm-cris/signal.h
--- 2.5.65/include/asm-cris/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-cris/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASM_CRIS_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -28,48 +29,6 @@
 
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
-#define SIGSYS          31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-cris/signum.h 2.5.65-signal.1/include/asm-cris/signum.h
--- 2.5.65/include/asm-cris/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-cris/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_CRIS_SIGNUM_H
+#define _ASM_CRIS_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_CRIS_SIGNUM_H */
diff -ruN 2.5.65/include/asm-generic/signum.h 2.5.65-signal.1/include/asm-generic/signum.h
--- 2.5.65/include/asm-generic/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-generic/signum.h	2003-03-21 18:15:36.000000000 +1100
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
diff -ruN 2.5.65/include/asm-i386/signal.h 2.5.65-signal.1/include/asm-i386/signal.h
--- 2.5.65/include/asm-i386/signal.h	2003-02-25 12:59:55.000000000 +1100
+++ 2.5.65-signal.1/include/asm-i386/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/linkage.h>
 #include <linux/time.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -30,48 +31,6 @@
 
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
diff -ruN 2.5.65/include/asm-i386/signum.h 2.5.65-signal.1/include/asm-i386/signum.h
--- 2.5.65/include/asm-i386/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-i386/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_SIGNUM_H
+#define _ASM_I386_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_I386_SIGNUM_H */
diff -ruN 2.5.65/include/asm-ia64/signal.h 2.5.65-signal.1/include/asm-ia64/signal.h
--- 2.5.65/include/asm-ia64/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-ia64/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -8,49 +8,7 @@
  * Unfortunately, this file is being included by bits/signal.h in
  * glibc-2.x.  Hence the #ifdef __KERNEL__ ugliness.
  */
-
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
-/* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#include <asm/signum.h>
 
 /*
  * SA_FLAGS values:
diff -ruN 2.5.65/include/asm-ia64/signum.h 2.5.65-signal.1/include/asm-ia64/signum.h
--- 2.5.65/include/asm-ia64/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-ia64/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_IA64_SIGNUM_H
+#define _ASM_IA64_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_IA64_SIGNUM_H */
diff -ruN 2.5.65/include/asm-m68k/signal.h 2.5.65-signal.1/include/asm-m68k/signal.h
--- 2.5.65/include/asm-m68k/signal.h	2003-02-11 09:39:57.000000000 +1100
+++ 2.5.65-signal.1/include/asm-m68k/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _M68K_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -28,48 +29,6 @@
 
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
diff -ruN 2.5.65/include/asm-m68k/signum.h 2.5.65-signal.1/include/asm-m68k/signum.h
--- 2.5.65/include/asm-m68k/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-m68k/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_SIGNUM_H
+#define _ASM_M68K_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_M68K_SIGNUM_H */
diff -ruN 2.5.65/include/asm-m68knommu/signal.h 2.5.65-signal.1/include/asm-m68knommu/signal.h
--- 2.5.65/include/asm-m68knommu/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-m68knommu/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _M68KNOMMU_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -28,48 +29,6 @@
 
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
diff -ruN 2.5.65/include/asm-m68knommu/signum.h 2.5.65-signal.1/include/asm-m68knommu/signum.h
--- 2.5.65/include/asm-m68knommu/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-m68knommu/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68KNOMMU_SIGNUM_H
+#define _ASM_M68KNOMMU_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_M68KNOMMU_SIGNUM_H */
diff -ruN 2.5.65/include/asm-mips/signal.h 2.5.65-signal.1/include/asm-mips/signal.h
--- 2.5.65/include/asm-mips/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-mips/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -11,6 +11,7 @@
 #define _ASM_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 #define _NSIG		128
 #define _NSIG_BPW	32
@@ -22,45 +23,6 @@
 
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
 
-#define SIGHUP		 1	/* Hangup (POSIX).  */
-#define SIGINT		 2	/* Interrupt (ANSI).  */
-#define SIGQUIT		 3	/* Quit (POSIX).  */
-#define SIGILL		 4	/* Illegal instruction (ANSI).  */
-#define SIGTRAP		 5	/* Trace trap (POSIX).  */
-#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
-#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
-#define SIGEMT		 7
-#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
-#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
-#define SIGBUS		10	/* BUS error (4.2 BSD).  */
-#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
-#define SIGSYS		12
-#define SIGPIPE		13	/* Broken pipe (POSIX).  */
-#define SIGALRM		14	/* Alarm clock (POSIX).  */
-#define SIGTERM		15	/* Termination (ANSI).  */
-#define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
-#define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
-#define SIGCHLD		18	/* Child status has changed (POSIX).  */
-#define SIGCLD		SIGCHLD	/* Same as SIGCHLD (System V).  */
-#define SIGPWR		19	/* Power failure restart (System V).  */
-#define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
-#define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
-#define SIGIO		22	/* I/O now possible (4.2 BSD).  */
-#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
-#define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
-#define SIGTSTP		24	/* Keyboard stop (POSIX).  */
-#define SIGCONT		25	/* Continue (POSIX).  */
-#define SIGTTIN		26	/* Background read from tty (POSIX).  */
-#define SIGTTOU		27	/* Background write to tty (POSIX).  */
-#define SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
-#define SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
-#define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
-#define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-mips/signum.h 2.5.65-signal.1/include/asm-mips/signum.h
--- 2.5.65/include/asm-mips/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-mips/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,43 @@
+#ifndef _ASM_MIPS_SIGNUM_H
+#define _ASM_MIPS_SIGNUM_H
+
+#define SIGHUP		 1	/* Hangup (POSIX).  */
+#define SIGINT		 2	/* Interrupt (ANSI).  */
+#define SIGQUIT		 3	/* Quit (POSIX).  */
+#define SIGILL		 4	/* Illegal instruction (ANSI).  */
+#define SIGTRAP		 5	/* Trace trap (POSIX).  */
+#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
+#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
+#define SIGEMT		 7
+#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
+#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
+#define SIGBUS		10	/* BUS error (4.2 BSD).  */
+#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
+#define SIGSYS		12
+#define SIGPIPE		13	/* Broken pipe (POSIX).  */
+#define SIGALRM		14	/* Alarm clock (POSIX).  */
+#define SIGTERM		15	/* Termination (ANSI).  */
+#define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
+#define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
+#define SIGCHLD		18	/* Child status has changed (POSIX).  */
+#define SIGCLD		SIGCHLD	/* Same as SIGCHLD (System V).  */
+#define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
+#define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
+#define SIGIO		22	/* I/O now possible (4.2 BSD).  */
+#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
+#define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
+#define SIGTSTP		24	/* Keyboard stop (POSIX).  */
+#define SIGCONT		25	/* Continue (POSIX).  */
+#define SIGTTIN		26	/* Background read from tty (POSIX).  */
+#define SIGTTOU		27	/* Background write to tty (POSIX).  */
+#define SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
+#define SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
+#define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
+#define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+#endif /* _ASM_MIPS_SIGNUM_H */
diff -ruN 2.5.65/include/asm-mips64/signal.h 2.5.65-signal.1/include/asm-mips64/signal.h
--- 2.5.65/include/asm-mips64/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-mips64/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASM_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm-signum.h>
 
 #define _NSIG		128
 #define _NSIG_BPW	64
@@ -22,45 +23,6 @@
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
 typedef unsigned int old_sigset_t32;
 
-#define SIGHUP		 1	/* Hangup (POSIX).  */
-#define SIGINT		 2	/* Interrupt (ANSI).  */
-#define SIGQUIT		 3	/* Quit (POSIX).  */
-#define SIGILL		 4	/* Illegal instruction (ANSI).  */
-#define SIGTRAP		 5	/* Trace trap (POSIX).  */
-#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
-#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
-#define SIGEMT		 7
-#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
-#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
-#define SIGBUS		10	/* BUS error (4.2 BSD).  */
-#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
-#define SIGSYS		12
-#define SIGPIPE		13	/* Broken pipe (POSIX).  */
-#define SIGALRM		14	/* Alarm clock (POSIX).  */
-#define SIGTERM		15	/* Termination (ANSI).  */
-#define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
-#define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
-#define SIGCHLD		18	/* Child status has changed (POSIX).  */
-#define SIGCLD		SIGCHLD	/* Same as SIGCHLD (System V).  */
-#define SIGPWR		19	/* Power failure restart (System V).  */
-#define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
-#define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
-#define SIGIO		22	/* I/O now possible (4.2 BSD).  */
-#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
-#define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
-#define SIGTSTP		24	/* Keyboard stop (POSIX).  */
-#define SIGCONT		25	/* Continue (POSIX).  */
-#define SIGTTIN		26	/* Background read from tty (POSIX).  */
-#define SIGTTOU		27	/* Background write to tty (POSIX).  */
-#define SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
-#define SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
-#define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
-#define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-mips64/signum.h 2.5.65-signal.1/include/asm-mips64/signum.h
--- 2.5.65/include/asm-mips64/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-mips64/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,43 @@
+#ifndef _ASM_MIPS64_SIGNUM_H
+#define _ASM_MIPS64_SIGNUM_H
+
+#define SIGHUP		 1	/* Hangup (POSIX).  */
+#define SIGINT		 2	/* Interrupt (ANSI).  */
+#define SIGQUIT		 3	/* Quit (POSIX).  */
+#define SIGILL		 4	/* Illegal instruction (ANSI).  */
+#define SIGTRAP		 5	/* Trace trap (POSIX).  */
+#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
+#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
+#define SIGEMT		 7
+#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
+#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
+#define SIGBUS		10	/* BUS error (4.2 BSD).  */
+#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
+#define SIGSYS		12
+#define SIGPIPE		13	/* Broken pipe (POSIX).  */
+#define SIGALRM		14	/* Alarm clock (POSIX).  */
+#define SIGTERM		15	/* Termination (ANSI).  */
+#define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
+#define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
+#define SIGCHLD		18	/* Child status has changed (POSIX).  */
+#define SIGCLD		SIGCHLD	/* Same as SIGCHLD (System V).  */
+#define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
+#define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
+#define SIGIO		22	/* I/O now possible (4.2 BSD).  */
+#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
+#define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
+#define SIGTSTP		24	/* Keyboard stop (POSIX).  */
+#define SIGCONT		25	/* Continue (POSIX).  */
+#define SIGTTIN		26	/* Background read from tty (POSIX).  */
+#define SIGTTOU		27	/* Background write to tty (POSIX).  */
+#define SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
+#define SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
+#define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
+#define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+#endif /* _ASM_MIPS64_SIGNUM_H */
diff -ruN 2.5.65/include/asm-parisc/signal.h 2.5.65-signal.1/include/asm-parisc/signal.h
--- 2.5.65/include/asm-parisc/signal.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.65-signal.1/include/asm-parisc/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -1,48 +1,7 @@
 #ifndef _ASM_PARISC_SIGNAL_H
 #define _ASM_PARISC_SIGNAL_H
 
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGEMT		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGBUS		10
-#define SIGSEGV		11
-#define SIGSYS		12 /* Linux doesn't use this */
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGUSR1		16
-#define SIGUSR2		17
-#define SIGCHLD		18
-#define SIGPWR		19
-#define SIGVTALRM	20
-#define SIGPROF		21
-#define SIGIO		22
-#define SIGPOLL		SIGIO
-#define SIGWINCH	23
-#define SIGSTOP		24
-#define SIGTSTP		25
-#define SIGCONT		26
-#define SIGTTIN		27
-#define SIGTTOU		28
-#define SIGURG		29
-#define SIGLOST		30 /* Linux doesn't use this either */
-#define	SIGUNUSED	31
-#define SIGRESERVE	SIGUNUSED
-
-#define SIGXCPU		33
-#define SIGXFSZ		34
-#define SIGSTKFLT	36
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	37
-#define SIGRTMAX	(_NSIG-1) /* it's 44 under HP/UX */
+#include <asm/signum.h>
 
 /*
  * SA_FLAGS values:
diff -ruN 2.5.65/include/asm-parisc/signum.h 2.5.65-signal.1/include/asm-parisc/signum.h
--- 2.5.65/include/asm-parisc/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-parisc/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,47 @@
+#ifndef _ASM_PARISC_SIGNUM_H
+#define _ASM_PARISC_SIGNUM_H
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGEMT		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGBUS		10
+#define SIGSEGV		11
+#define SIGSYS		12 /* Linux doesn't use this */
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGUSR1		16
+#define SIGUSR2		17
+#define SIGCHLD		18
+#define SIGPWR		19
+#define SIGVTALRM	20
+#define SIGPROF		21
+#define SIGIO		22
+#define SIGPOLL		SIGIO
+#define SIGWINCH	23
+#define SIGSTOP		24
+#define SIGTSTP		25
+#define SIGCONT		26
+#define SIGTTIN		27
+#define SIGTTOU		28
+#define SIGURG		29
+#define SIGLOST		30 /* Linux doesn't use this either */
+#define	SIGUNUSED	31
+#define SIGRESERVE	SIGUNUSED
+
+#define SIGXCPU		33
+#define SIGXFSZ		34
+#define SIGSTKFLT	36
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	37
+#define SIGRTMAX	(_NSIG-1) /* it's 44 under HP/UX */
+
+#endif /* _ASM_PARISC_SIGNUM_H */
diff -ruN 2.5.65/include/asm-ppc/signal.h 2.5.65-signal.1/include/asm-ppc/signal.h
--- 2.5.65/include/asm-ppc/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-ppc/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -4,6 +4,7 @@
 #ifdef __KERNEL__
 #include <linux/types.h>
 #endif /* __KERNEL__ */
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -21,48 +22,6 @@
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
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
diff -ruN 2.5.65/include/asm-ppc/signum.h 2.5.65-signal.1/include/asm-ppc/signum.h
--- 2.5.65/include/asm-ppc/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-ppc/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC_SIGNUM_H
+#define _ASM_PPC_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_PPC_SIGNUM_H */
diff -ruN 2.5.65/include/asm-ppc64/signal.h 2.5.65-signal.1/include/asm-ppc64/signal.h
--- 2.5.65/include/asm-ppc64/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-ppc64/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASMPPC64_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -16,48 +17,6 @@
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
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
diff -ruN 2.5.65/include/asm-ppc64/signum.h 2.5.65-signal.1/include/asm-ppc64/signum.h
--- 2.5.65/include/asm-ppc64/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-ppc64/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC64_SIGNUM_H
+#define _ASM_PPC64_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_PPC64_SIGNUM_H */
diff -ruN 2.5.65/include/asm-s390/signal.h 2.5.65-signal.1/include/asm-s390/signal.h
--- 2.5.65/include/asm-s390/signal.h	2003-02-25 12:59:57.000000000 +1100
+++ 2.5.65-signal.1/include/asm-s390/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -37,48 +38,6 @@
 
 #endif /* __KERNEL__ */
 
-#define SIGHUP           1
-#define SIGINT           2
-#define SIGQUIT          3
-#define SIGILL           4
-#define SIGTRAP          5
-#define SIGABRT          6
-#define SIGIOT           6
-#define SIGBUS           7
-#define SIGFPE           8
-#define SIGKILL          9
-#define SIGUSR1         10
-#define SIGSEGV         11
-#define SIGUSR2         12
-#define SIGPIPE         13
-#define SIGALRM         14
-#define SIGTERM         15
-#define SIGSTKFLT       16
-#define SIGCHLD         17
-#define SIGCONT         18
-#define SIGSTOP         19
-#define SIGTSTP         20
-#define SIGTTIN         21
-#define SIGTTOU         22
-#define SIGURG          23
-#define SIGXCPU         24
-#define SIGXFSZ         25
-#define SIGVTALRM       26
-#define SIGPROF         27
-#define SIGWINCH        28
-#define SIGIO           29
-#define SIGPOLL         SIGIO
-/*
-#define SIGLOST         29
-*/
-#define SIGPWR          30
-#define SIGSYS		31
-#define SIGUNUSED       31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-s390/signum.h 2.5.65-signal.1/include/asm-s390/signum.h
--- 2.5.65/include/asm-s390/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-s390/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390_SIGNUM_H
+#define _ASM_S390_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_S390_SIGNUM_H */
diff -ruN 2.5.65/include/asm-s390x/signal.h 2.5.65-signal.1/include/asm-s390x/signal.h
--- 2.5.65/include/asm-s390x/signal.h	2003-02-25 12:59:58.000000000 +1100
+++ 2.5.65-signal.1/include/asm-s390x/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -37,48 +38,6 @@
 
 #endif /* __KERNEL__ */
 
-#define SIGHUP           1
-#define SIGINT           2
-#define SIGQUIT          3
-#define SIGILL           4
-#define SIGTRAP          5
-#define SIGABRT          6
-#define SIGIOT           6
-#define SIGBUS           7
-#define SIGFPE           8
-#define SIGKILL          9
-#define SIGUSR1         10
-#define SIGSEGV         11
-#define SIGUSR2         12
-#define SIGPIPE         13
-#define SIGALRM         14
-#define SIGTERM         15
-#define SIGSTKFLT       16
-#define SIGCHLD         17
-#define SIGCONT         18
-#define SIGSTOP         19
-#define SIGTSTP         20
-#define SIGTTIN         21
-#define SIGTTOU         22
-#define SIGURG          23
-#define SIGXCPU         24
-#define SIGXFSZ         25
-#define SIGVTALRM       26
-#define SIGPROF         27
-#define SIGWINCH        28
-#define SIGIO           29
-#define SIGPOLL         SIGIO
-/*
-#define SIGLOST         29
-*/
-#define SIGPWR          30
-#define SIGSYS		31
-#define SIGUNUSED       31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
diff -ruN 2.5.65/include/asm-s390x/signum.h 2.5.65-signal.1/include/asm-s390x/signum.h
--- 2.5.65/include/asm-s390x/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-s390x/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390X_SIGNUM_H
+#define _ASM_S390X_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_S390X_SIGNUM_H */
diff -ruN 2.5.65/include/asm-sh/signal.h 2.5.65-signal.1/include/asm-sh/signal.h
--- 2.5.65/include/asm-sh/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-sh/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -2,6 +2,7 @@
 #define __ASM_SH_SIGNAL_H
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -16,48 +17,6 @@
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
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
diff -ruN 2.5.65/include/asm-sh/signum.h 2.5.65-signal.1/include/asm-sh/signum.h
--- 2.5.65/include/asm-sh/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-sh/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_SH_SIGNUM_H
+#define _ASM_SH_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_SH_SIGNUM_H */
diff -ruN 2.5.65/include/asm-sparc/signal.h 2.5.65-signal.1/include/asm-sparc/signal.h
--- 2.5.65/include/asm-sparc/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-sparc/signal.h	2003-03-21 18:15:36.000000000 +1100
@@ -3,6 +3,7 @@
 #define _ASMSPARC_SIGNAL_H
 
 #include <asm/sigcontext.h>
+#include <asm/signum.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -11,74 +12,6 @@
 #endif
 #endif
 
-/* On the Sparc the signal handlers get passed a 'sub-signal' code
- * for certain signal types, which we document here.
- */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define    SUBSIG_STACK       0
-#define    SUBSIG_ILLINST     2
-#define    SUBSIG_PRIVINST    3
-#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
-#define SIGEMT           7
-#define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
-#define    SUBSIG_FPDISABLED     0x400
-#define    SUBSIG_FPERROR        0x404
-#define    SUBSIG_FPINTOVFL      0x001
-#define    SUBSIG_FPSTSIG        0x002
-#define    SUBSIG_IDIVZERO       0x014
-#define    SUBSIG_FPINEXACT      0x0c4
-#define    SUBSIG_FPDIVZERO      0x0c8
-#define    SUBSIG_FPUNFLOW       0x0cc
-#define    SUBSIG_FPOPERROR      0x0d0
-#define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
-#define SIGBUS          10
-#define    SUBSIG_BUSTIMEOUT    1
-#define    SUBSIG_ALIGNMENT     2
-#define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
-#define    SUBSIG_NOMAPPING     3
-#define    SUBSIG_PROTECTION    4
-#define    SUBSIG_SEGERROR      5
-
-#define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGURG          16
-
-/* SunOS values which deviate from the Linux/i386 ones */
-#define SIGSTOP		17
-#define SIGTSTP		18
-#define SIGCONT		19
-#define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGLOST		29
-#define SIGPWR		SIGLOST
-#define SIGUSR1		30
-#define SIGUSR2		31
-
 /* Most things should be clean enough to redefine this at will, if care
  * is taken to make libc match.
  */
@@ -88,9 +21,6 @@
 #define _NSIG_BPW	32
 #define _NSIG_WORDS	(__NEW_NSIG / _NSIG_BPW)
 
-#define SIGRTMIN	32
-#define SIGRTMAX	(__NEW_NSIG - 1)
-
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define	_NSIG		__NEW_NSIG
 #define __new_sigset_t	sigset_t
diff -ruN 2.5.65/include/asm-sparc/signum.h 2.5.65-signal.1/include/asm-sparc/signum.h
--- 2.5.65/include/asm-sparc/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-sparc/signum.h	2003-03-21 18:15:36.000000000 +1100
@@ -0,0 +1,75 @@
+#ifndef _ASM_SPARC_SIGNUM_H
+#define _ASM_SPARC_SIGNUM_H
+
+/* On the Sparc the signal handlers get passed a 'sub-signal' code
+ * for certain signal types, which we document here.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define    SUBSIG_STACK       0
+#define    SUBSIG_ILLINST     2
+#define    SUBSIG_PRIVINST    3
+#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
+
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+
+#define SIGEMT           7
+#define    SUBSIG_TAG    10
+
+#define SIGFPE		 8
+#define    SUBSIG_FPDISABLED     0x400
+#define    SUBSIG_FPERROR        0x404
+#define    SUBSIG_FPINTOVFL      0x001
+#define    SUBSIG_FPSTSIG        0x002
+#define    SUBSIG_IDIVZERO       0x014
+#define    SUBSIG_FPINEXACT      0x0c4
+#define    SUBSIG_FPDIVZERO      0x0c8
+#define    SUBSIG_FPUNFLOW       0x0cc
+#define    SUBSIG_FPOPERROR      0x0d0
+#define    SUBSIG_FPOVFLOW       0x0d4
+
+#define SIGKILL		 9
+#define SIGBUS          10
+#define    SUBSIG_BUSTIMEOUT    1
+#define    SUBSIG_ALIGNMENT     2
+#define    SUBSIG_MISCERROR     5
+
+#define SIGSEGV		11
+#define    SUBSIG_NOMAPPING     3
+#define    SUBSIG_PROTECTION    4
+#define    SUBSIG_SEGERROR      5
+
+#define SIGSYS		12
+
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG          16
+
+/* SunOS values which deviate from the Linux/i386 ones */
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGLOST		29
+#define SIGPWR		SIGLOST
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+#define SIGRTMIN	32
+#define SIGRTMAX	(__NEW_NSIG - 1)
+
+#endif /* _ASM_SPARC_SIGNUM_H */
diff -ruN 2.5.65/include/asm-sparc64/signal.h 2.5.65-signal.1/include/asm-sparc64/signal.h
--- 2.5.65/include/asm-sparc64/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-sparc64/signal.h	2003-03-21 18:15:37.000000000 +1100
@@ -3,6 +3,7 @@
 #define _ASMSPARC64_SIGNAL_H
 
 #include <asm/sigcontext.h>
+#include <asm/signum.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -12,74 +13,6 @@
 #endif
 #endif
 
-/* On the Sparc the signal handlers get passed a 'sub-signal' code
- * for certain signal types, which we document here.
- */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define    SUBSIG_STACK       0
-#define    SUBSIG_ILLINST     2
-#define    SUBSIG_PRIVINST    3
-#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
-#define SIGEMT           7
-#define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
-#define    SUBSIG_FPDISABLED     0x400
-#define    SUBSIG_FPERROR        0x404
-#define    SUBSIG_FPINTOVFL      0x001
-#define    SUBSIG_FPSTSIG        0x002
-#define    SUBSIG_IDIVZERO       0x014
-#define    SUBSIG_FPINEXACT      0x0c4
-#define    SUBSIG_FPDIVZERO      0x0c8
-#define    SUBSIG_FPUNFLOW       0x0cc
-#define    SUBSIG_FPOPERROR      0x0d0
-#define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
-#define SIGBUS          10
-#define    SUBSIG_BUSTIMEOUT    1
-#define    SUBSIG_ALIGNMENT     2
-#define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
-#define    SUBSIG_NOMAPPING     3
-#define    SUBSIG_PROTECTION    4
-#define    SUBSIG_SEGERROR      5
-
-#define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGURG          16
-
-/* SunOS values which deviate from the Linux/i386 ones */
-#define SIGSTOP		17
-#define SIGTSTP		18
-#define SIGCONT		19
-#define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGLOST		29
-#define SIGPWR		SIGLOST
-#define SIGUSR1		30
-#define SIGUSR2		31
-
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
 
@@ -88,9 +21,6 @@
 #define _NSIG_BPW     	64
 #define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
 
-#define SIGRTMIN       32
-#define SIGRTMAX       (__NEW_NSIG - 1)
-
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define _NSIG			__NEW_NSIG
 #define __new_sigset_t		sigset_t
diff -ruN 2.5.65/include/asm-sparc64/signum.h 2.5.65-signal.1/include/asm-sparc64/signum.h
--- 2.5.65/include/asm-sparc64/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-sparc64/signum.h	2003-03-21 18:15:37.000000000 +1100
@@ -0,0 +1,75 @@
+#ifndef _ASM_SPARC64_SIGNUM_H
+#define _ASM_SPARC64_SIGNUM_H
+
+/* On the Sparc the signal handlers get passed a 'sub-signal' code
+ * for certain signal types, which we document here.
+ */
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define    SUBSIG_STACK       0
+#define    SUBSIG_ILLINST     2
+#define    SUBSIG_PRIVINST    3
+#define    SUBSIG_BADTRAP(t)  (0x80 + (t))
+
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+
+#define SIGEMT           7
+#define    SUBSIG_TAG    10
+
+#define SIGFPE		 8
+#define    SUBSIG_FPDISABLED     0x400
+#define    SUBSIG_FPERROR        0x404
+#define    SUBSIG_FPINTOVFL      0x001
+#define    SUBSIG_FPSTSIG        0x002
+#define    SUBSIG_IDIVZERO       0x014
+#define    SUBSIG_FPINEXACT      0x0c4
+#define    SUBSIG_FPDIVZERO      0x0c8
+#define    SUBSIG_FPUNFLOW       0x0cc
+#define    SUBSIG_FPOPERROR      0x0d0
+#define    SUBSIG_FPOVFLOW       0x0d4
+
+#define SIGKILL		 9
+#define SIGBUS          10
+#define    SUBSIG_BUSTIMEOUT    1
+#define    SUBSIG_ALIGNMENT     2
+#define    SUBSIG_MISCERROR     5
+
+#define SIGSEGV		11
+#define    SUBSIG_NOMAPPING     3
+#define    SUBSIG_PROTECTION    4
+#define    SUBSIG_SEGERROR      5
+
+#define SIGSYS		12
+
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGURG          16
+
+/* SunOS values which deviate from the Linux/i386 ones */
+#define SIGSTOP		17
+#define SIGTSTP		18
+#define SIGCONT		19
+#define SIGCHLD		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGIO		23
+#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGLOST		29
+#define SIGPWR		SIGLOST
+#define SIGUSR1		30
+#define SIGUSR2		31
+
+#define SIGRTMIN       32
+#define SIGRTMAX       (__NEW_NSIG - 1)
+
+#endif /* _ASM_SPARC64_SIGNUM_H */
diff -ruN 2.5.65/include/asm-um/signum.h 2.5.65-signal.1/include/asm-um/signum.h
--- 2.5.65/include/asm-um/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-um/signum.h	2003-03-21 18:15:37.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_UM_SIGNUM_H
+#define _ASM_UM_SIGNUM_H
+
+#include "asm/arch/signum.h"
+
+#endif /* _ASM_UM_SIGNUM_H */
diff -ruN 2.5.65/include/asm-v850/signal.h 2.5.65-signal.1/include/asm-v850/signal.h
--- 2.5.65/include/asm-v850/signal.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.65-signal.1/include/asm-v850/signal.h	2003-03-21 18:15:37.000000000 +1100
@@ -2,6 +2,7 @@
 #define __V850_SIGNAL_H__
 
 #include <linux/types.h>
+#include <asm/signum.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -30,49 +31,6 @@
 
 #endif /* __KERNEL__ */
 
-
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
diff -ruN 2.5.65/include/asm-v850/signum.h 2.5.65-signal.1/include/asm-v850/signum.h
--- 2.5.65/include/asm-v850/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-v850/signum.h	2003-03-21 18:15:37.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef __ASM_V850_SIGNUM_H
+#define __ASM_V850_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* __ASM_V850_SIGNUM_H */
diff -ruN 2.5.65/include/asm-x86_64/signal.h 2.5.65-signal.1/include/asm-x86_64/signal.h
--- 2.5.65/include/asm-x86_64/signal.h	2003-02-25 12:59:58.000000000 +1100
+++ 2.5.65-signal.1/include/asm-x86_64/signal.h	2003-03-21 18:15:37.000000000 +1100
@@ -1,6 +1,7 @@
 #ifndef _ASMx8664_SIGNAL_H
 #define _ASMx8664_SIGNAL_H
 
+#include <asm/signum.h>
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/linkage.h>
@@ -37,48 +38,6 @@
 #endif /* __KERNEL__ */
 #endif
 
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
diff -ruN 2.5.65/include/asm-x86_64/signum.h 2.5.65-signal.1/include/asm-x86_64/signum.h
--- 2.5.65/include/asm-x86_64/signum.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.65-signal.1/include/asm-x86_64/signum.h	2003-03-21 18:15:37.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_64_SIGNUM_H
+#define _ASM_X86_64_SIGNUM_H
+
+#include <asm-generic/signum.h>
+
+#endif /* _ASM_X86_64_SIGNUM_H */

