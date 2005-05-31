Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVEaBF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVEaBF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEaBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:05:26 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:26511 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261852AbVEaBBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:01:23 -0400
Date: Tue, 31 May 2005 11:01:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>,
       "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: [PATCH] compat: introduce compat_time_t
Message-Id: <20050531110114.78df2857.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch is based on work by Carlos O'Donell and Matthew Wilcox.  It
introduces/updates the compat_time_t type and uses it for compat siginfo
structures.  I have built this on ppc64 and x86_64.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ia64/ia32/ia32priv.h       |    2 +-
 arch/s390/kernel/compat_linux.h |    2 +-
 arch/sparc64/kernel/signal32.c  |    2 +-
 include/asm-ia64/compat.h       |    1 +
 include/asm-mips/compat.h       |    1 +
 include/asm-parisc/compat.h     |    2 +-
 include/asm-ppc64/compat.h      |    1 +
 include/asm-ppc64/ppc32.h       |    2 +-
 include/asm-sparc64/compat.h    |    1 +
 include/asm-x86_64/ia32.h       |    2 +-
 10 files changed, 10 insertions(+), 6 deletions(-)

diff -ruNp linus/arch/ia64/ia32/ia32priv.h linus-willy.2/arch/ia64/ia32/ia32priv.h
--- linus/arch/ia64/ia32/ia32priv.h	2005-05-20 09:02:39.000000000 +1000
+++ linus-willy.2/arch/ia64/ia32/ia32priv.h	2005-04-18 18:03:46.000000000 +1000
@@ -241,7 +241,7 @@ typedef struct compat_siginfo {
 
 		/* POSIX.1b timers */
 		struct {
-			timer_t _tid;		/* timer id */
+			compat_timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
 			char _pad[sizeof(unsigned int) - sizeof(int)];
 			compat_sigval_t _sigval;	/* same as below */
diff -ruNp linus/arch/s390/kernel/compat_linux.h linus-willy.2/arch/s390/kernel/compat_linux.h
--- linus/arch/s390/kernel/compat_linux.h	2005-05-20 09:03:16.000000000 +1000
+++ linus-willy.2/arch/s390/kernel/compat_linux.h	2005-04-18 18:11:49.000000000 +1000
@@ -45,7 +45,7 @@ typedef struct compat_siginfo {
 
 		/* POSIX.1b timers */
 		struct {
-			timer_t _tid;		/* timer id */
+			compat_timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
 			int _sys_private;       /* not to be passed to user */
diff -ruNp linus/arch/sparc64/kernel/signal32.c linus-willy.2/arch/sparc64/kernel/signal32.c
--- linus/arch/sparc64/kernel/signal32.c	2005-05-20 09:03:27.000000000 +1000
+++ linus-willy.2/arch/sparc64/kernel/signal32.c	2005-04-27 02:33:26.000000000 +1000
@@ -102,7 +102,7 @@ typedef struct compat_siginfo{
 
 		/* POSIX.1b timers */
 		struct {
-			timer_t _tid;			/* timer id */
+			compat_timer_t _tid;			/* timer id */
 			int _overrun;			/* overrun count */
 			compat_sigval_t _sigval;		/* same as below */
 			int _sys_private;		/* not to be passed to user */
diff -ruNp linus/include/asm-ia64/compat.h linus-willy.2/include/asm-ia64/compat.h
--- linus/include/asm-ia64/compat.h	2005-05-20 09:05:37.000000000 +1000
+++ linus-willy.2/include/asm-ia64/compat.h	2005-03-15 23:57:33.000000000 +1100
@@ -27,6 +27,7 @@ typedef u16		compat_ipc_pid_t;
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -ruNp linus/include/asm-mips/compat.h linus-willy.2/include/asm-mips/compat.h
--- linus/include/asm-mips/compat.h	2005-05-20 09:05:46.000000000 +1000
+++ linus-willy.2/include/asm-mips/compat.h	2005-03-15 23:58:59.000000000 +1100
@@ -29,6 +29,7 @@ typedef s32		compat_caddr_t;
 typedef struct {
 	s32	val[2];
 } compat_fsid_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -ruNp linus/include/asm-parisc/compat.h linus-willy.2/include/asm-parisc/compat.h
--- linus/include/asm-parisc/compat.h	2005-05-20 09:05:51.000000000 +1000
+++ linus-willy.2/include/asm-parisc/compat.h	2005-03-16 00:01:32.000000000 +1100
@@ -24,7 +24,7 @@ typedef u16	compat_nlink_t;
 typedef u16	compat_ipc_pid_t;
 typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
-typedef u32	compat_timer_t;
+typedef s32	compat_timer_t;
 
 typedef s32	compat_int_t;
 typedef s32	compat_long_t;
diff -ruNp linus/include/asm-ppc64/compat.h linus-willy.2/include/asm-ppc64/compat.h
--- linus/include/asm-ppc64/compat.h	2005-05-20 09:05:54.000000000 +1000
+++ linus-willy.2/include/asm-ppc64/compat.h	2005-03-16 00:02:28.000000000 +1100
@@ -26,6 +26,7 @@ typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 typedef s32		compat_key_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -ruNp linus/include/asm-ppc64/ppc32.h linus-willy.2/include/asm-ppc64/ppc32.h
--- linus/include/asm-ppc64/ppc32.h	2005-05-20 09:05:56.000000000 +1000
+++ linus-willy.2/include/asm-ppc64/ppc32.h	2005-04-18 18:15:06.000000000 +1000
@@ -32,7 +32,7 @@ typedef struct compat_siginfo {
 
 		/* POSIX.1b timers */
 		struct {
-			timer_t _tid;			/* timer id */
+			compat_timer_t _tid;			/* timer id */
 			int _overrun;			/* overrun count */
 			compat_sigval_t _sigval;		/* same as below */
 			int _sys_private;		/* not to be passed to user */
diff -ruNp linus/include/asm-sparc64/compat.h linus-willy.2/include/asm-sparc64/compat.h
--- linus/include/asm-sparc64/compat.h	2005-05-20 09:06:04.000000000 +1000
+++ linus-willy.2/include/asm-sparc64/compat.h	2005-04-27 02:33:58.000000000 +1000
@@ -25,6 +25,7 @@ typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 typedef s32		compat_key_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -ruNp linus/include/asm-x86_64/ia32.h linus-willy.2/include/asm-x86_64/ia32.h
--- linus/include/asm-x86_64/ia32.h	2005-05-20 09:06:10.000000000 +1000
+++ linus-willy.2/include/asm-x86_64/ia32.h	2005-04-18 18:17:50.000000000 +1000
@@ -94,7 +94,7 @@ typedef struct compat_siginfo{
 
 		/* POSIX.1b timers */
 		struct {
-			int _tid;		/* timer id */
+			compat_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
 			int _sys_private;	/* not to be passed to user */


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
