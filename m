Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVDZVex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDZVex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVDZVew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:34:52 -0400
Received: from mail.dif.dk ([193.138.115.101]:43728 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261799AbVDZVe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:34:29 -0400
Date: Tue, 26 Apr 2005 23:37:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Love <rml@novell.com>, kpreempt-tech@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] streamline preempt_count type across archs
Message-ID: <Pine.LNX.4.62.0504262328190.2071@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The preempt_count member of struct thread_info is currently either defined 
as int, unsigned int or __s32 depending on arch. This patch makes the type 
of preempt_count an int on all archs.
Having preempt_count be an unsigned type prevents the catching of 
preempt_count < 0 bugs, and using int on some archs and __s32 on others is 
not exactely "neat" - much nicer when it's just int all over.

A previous version of this patch was already ACK'ed by Robert Love, and 
the only change in this version of the patch compared to the one he ACK'ed 
is that this one also makes sure the preempt_count member is consistently 
commented.

Please consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 include/asm-arm/thread_info.h       |    2 +-
 include/asm-arm26/thread_info.h     |    2 +-
 include/asm-cris/thread_info.h      |    2 +-
 include/asm-frv/thread_info.h       |    2 +-
 include/asm-h8300/thread_info.h     |    2 +-
 include/asm-i386/thread_info.h      |    2 +-
 include/asm-ia64/thread_info.h      |    2 +-
 include/asm-m32r/thread_info.h      |    2 +-
 include/asm-m68k/thread_info.h      |    2 +-
 include/asm-m68knommu/thread_info.h |    2 +-
 include/asm-mips/thread_info.h      |    2 +-
 include/asm-parisc/thread_info.h    |    2 +-
 include/asm-ppc/thread_info.h       |    3 ++-
 include/asm-ppc64/thread_info.h     |    2 +-
 include/asm-s390/thread_info.h      |    2 +-
 include/asm-sh/thread_info.h        |    2 +-
 include/asm-sh64/thread_info.h      |    2 +-
 include/asm-sparc/thread_info.h     |    4 ++--
 include/asm-sparc64/thread_info.h   |    2 +-
 include/asm-um/thread_info.h        |    2 +-
 include/asm-v850/thread_info.h      |    3 ++-
 include/asm-x86_64/thread_info.h    |    2 +-
 22 files changed, 25 insertions(+), 23 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/include/asm-m68knommu/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-m68knommu/thread_info.h	2005-04-26 22:57:21.000000000 +0200
@@ -36,7 +36,7 @@
 	struct exec_domain *exec_domain;	/* execution domain */
 	unsigned long	   flags;		/* low level flags */
 	int		   cpu;			/* cpu we're on */
-	int		   preempt_count;	/* 0 => preemptable, <0 => BUG*/
+	int		   preempt_count;	/* 0 => preemptable, <0 => BUG */
 	struct restart_block restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-sh/thread_info.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-sh/thread_info.h	2005-04-23 23:18:20.000000000 +0200
@@ -20,7 +20,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	__u32			flags;		/* low level flags */
 	__u32			cpu;
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	struct restart_block	restart_block;
 	__u8			supervisor_stack[0];
 };
--- linux-2.6.12-rc2-mm3-orig/include/asm-um/thread_info.h	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-um/thread_info.h	2005-04-26 22:58:07.000000000 +0200
@@ -17,7 +17,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count;  /* 0 => preemptable, 
+	int			preempt_count;  /* 0 => preemptable, 
 						   <0 => BUG */
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user
--- linux-2.6.12-rc2-mm3-orig/include/asm-parisc/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-parisc/thread_info.h	2005-04-23 23:17:55.000000000 +0200
@@ -12,7 +12,7 @@
 	unsigned long flags;		/* thread_info flags (see TIF_*) */
 	mm_segment_t addr_limit;	/* user-level address space limit */
 	__u32 cpu;			/* current CPU */
-	__s32 preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
+	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 	struct restart_block restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-x86_64/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-x86_64/thread_info.h	2005-04-26 22:59:15.000000000 +0200
@@ -29,7 +29,7 @@
 	__u32			flags;		/* low level flags */
 	__u32			status;		/* thread synchronous flags */
 	__u32			cpu;		/* current CPU */
-	int 			preempt_count;
+	int 			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	
 	struct restart_block    restart_block;
--- linux-2.6.12-rc2-mm3-orig/include/asm-arm26/thread_info.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-arm26/thread_info.h	2005-04-23 23:16:22.000000000 +0200
@@ -44,7 +44,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => bug */
+	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain      *exec_domain;   /* execution domain */
--- linux-2.6.12-rc2-mm3-orig/include/asm-h8300/thread_info.h	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-h8300/thread_info.h	2005-04-26 22:59:41.000000000 +0200
@@ -23,7 +23,7 @@
 	struct exec_domain *exec_domain;	/* execution domain */
 	unsigned long	   flags;		/* low level flags */
 	int		   cpu;			/* cpu we're on */
-	int		   preempt_count;	/* 0 => preemptable, <0 => BUG*/
+	int		   preempt_count;	/* 0 => preemptable, <0 => BUG */
 	struct restart_block restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-ppc64/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-ppc64/thread_info.h	2005-04-26 23:00:01.000000000 +0200
@@ -24,7 +24,7 @@
 	struct task_struct *task;		/* main task structure */
 	struct exec_domain *exec_domain;	/* execution domain */
 	int		cpu;			/* cpu we're on */
-	int		preempt_count;
+	int		preempt_count;		/* 0 => preemptable, <0 => BUG */
 	struct restart_block restart_block;
 	/* set by force_successful_syscall_return */
 	unsigned char	syscall_noerror;
--- linux-2.6.12-rc2-mm3-orig/include/asm-sparc/thread_info.h	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-sparc/thread_info.h	2005-04-26 23:00:46.000000000 +0200
@@ -30,9 +30,9 @@
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
-
 	int			cpu;		/* cpu we're on */
-	int			preempt_count;
+	int			preempt_count;	/* 0 => preemptable, 
+						   <0 => BUG */
 	int			softirq_count;
 	int			hardirq_count;
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-i386/thread_info.h	2005-04-05 21:21:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-i386/thread_info.h	2005-04-26 23:01:06.000000000 +0200
@@ -31,7 +31,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 
 	mm_segment_t		addr_limit;	/* thread address space:
--- linux-2.6.12-rc2-mm3-orig/include/asm-cris/thread_info.h	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-cris/thread_info.h	2005-04-26 23:01:17.000000000 +0200
@@ -31,7 +31,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-m32r/thread_info.h	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-m32r/thread_info.h	2005-04-26 23:01:25.000000000 +0200
@@ -28,7 +28,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thread
--- linux-2.6.12-rc2-mm3-orig/include/asm-ia64/thread_info.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-ia64/thread_info.h	2005-04-23 23:17:04.000000000 +0200
@@ -25,7 +25,7 @@
 	__u32 flags;			/* thread_info flags (see TIF_*) */
 	__u32 cpu;			/* current CPU */
 	mm_segment_t addr_limit;	/* user-level address space limit */
-	__s32 preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
+	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 	struct restart_block restart_block;
 	struct {
 		int signo;
--- linux-2.6.12-rc2-mm3-orig/include/asm-m68k/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-m68k/thread_info.h	2005-04-26 23:01:46.000000000 +0200
@@ -8,7 +8,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u32 cpu; /* should always be 0 on m68k */
 	struct restart_block    restart_block;
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-mips/thread_info.h	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-mips/thread_info.h	2005-04-26 23:01:57.000000000 +0200
@@ -27,7 +27,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-s390/thread_info.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-s390/thread_info.h	2005-04-26 23:02:27.000000000 +0200
@@ -50,7 +50,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
-	unsigned int		preempt_count; /* 0 => preemptable */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	struct restart_block	restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-v850/thread_info.h	2005-03-02 08:38:06.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-v850/thread_info.h	2005-04-26 23:03:02.000000000 +0200
@@ -30,7 +30,8 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	int			cpu;		/* cpu we're on */
-	int			preempt_count;
+	int			preempt_count;	/* 0 => preemptable, 
+						   <0 => BUG */
 	struct restart_block	restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-sh64/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-sh64/thread_info.h	2005-04-26 23:03:23.000000000 +0200
@@ -22,7 +22,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	/* Put the 4 32-bit fields together to make asm offsetting easier. */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u16			cpu;
 
 	mm_segment_t		addr_limit;
--- linux-2.6.12-rc2-mm3-orig/include/asm-arm/thread_info.h	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-arm/thread_info.h	2005-04-23 23:16:04.000000000 +0200
@@ -45,7 +45,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => bug */
+	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
--- linux-2.6.12-rc2-mm3-orig/include/asm-frv/thread_info.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-frv/thread_info.h	2005-04-23 23:16:37.000000000 +0200
@@ -33,7 +33,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-ppc/thread_info.h	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-ppc/thread_info.h	2005-04-26 23:04:19.000000000 +0200
@@ -20,7 +20,8 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		local_flags;	/* non-racy flags */
 	int			cpu;		/* cpu we're on */
-	int			preempt_count;
+	int			preempt_count;	/* 0 => preemptable, 
+						   <0 => BUG */
 	struct restart_block	restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-sparc64/thread_info.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-sparc64/thread_info.h	2005-04-26 23:04:57.000000000 +0200
@@ -46,7 +46,7 @@
 	unsigned long		fault_address;
 	struct pt_regs		*kregs;
 	struct exec_domain	*exec_domain;
-	int			preempt_count;
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	int			__pad;
 
 	unsigned long		*utraps;


