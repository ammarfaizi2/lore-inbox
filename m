Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUEKI6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUEKI6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEKI6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:58:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:46216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUEKI5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:57:14 -0400
Date: Tue, 11 May 2004 01:56:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 7/11] add rlimit entry for POSIX mqueue allocation
Message-ID: <20040511015658.F21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net> <20040511015357.E21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511015357.E21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:53:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an rlimit entry to control the maximum number of bytes a user can
allocate to a POSIX mqueue.

--- 2.6-rlimit/arch/alpha/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:44.734764544 -0700
+++ 2.6-rlimit/arch/alpha/kernel/init_task.c	2004-05-10 23:16:44.736764240 -0700
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 #include <asm/uaccess.h>
 
 
--- 2.6-rlimit/arch/arm/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:44.856746000 -0700
+++ 2.6-rlimit/arch/arm/kernel/init_task.c	2004-05-10 23:16:44.859745544 -0700
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/include/asm-arm26/resource.h~mqueue_rlimit	2004-05-10 23:01:16.256914632 -0700
+++ 2.6-rlimit/include/asm-arm26/resource.h	2004-05-10 23:16:46.769455224 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/arch/h8300/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:44.994725024 -0700
+++ 2.6-rlimit/arch/h8300/kernel/init_task.c	2004-05-10 23:16:44.996724720 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/i386/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:44.199845864 -0700
+++ 2.6-rlimit/arch/i386/kernel/init_task.c	2004-05-10 23:16:44.201845560 -0700
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/ia64/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.128704656 -0700
+++ 2.6-rlimit/arch/ia64/kernel/init_task.c	2004-05-10 23:16:45.130704352 -0700
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/m68knommu/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.265683832 -0700
+++ 2.6-rlimit/arch/m68knommu/kernel/init_task.c	2004-05-10 23:16:45.268683376 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/mips/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.404662704 -0700
+++ 2.6-rlimit/arch/mips/kernel/init_task.c	2004-05-10 23:16:45.406662400 -0700
@@ -3,6 +3,7 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/thread_info.h>
 #include <asm/uaccess.h>
--- 2.6-rlimit/arch/parisc/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.535642792 -0700
+++ 2.6-rlimit/arch/parisc/kernel/init_task.c	2004-05-10 23:16:45.538642336 -0700
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/ppc64/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.681620600 -0700
+++ 2.6-rlimit/arch/ppc64/kernel/init_task.c	2004-05-10 23:16:45.683620296 -0700
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 #include <asm/uaccess.h>
 
 static struct fs_struct init_fs = INIT_FS;
--- 2.6-rlimit/arch/s390/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.793603576 -0700
+++ 2.6-rlimit/arch/s390/kernel/init_task.c	2004-05-10 23:16:45.795603272 -0700
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/sh/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:45.935581992 -0700
+++ 2.6-rlimit/arch/sh/kernel/init_task.c	2004-05-10 23:16:45.937581688 -0700
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/sparc/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.075560712 -0700
+++ 2.6-rlimit/arch/sparc/kernel/init_task.c	2004-05-10 23:16:46.078560256 -0700
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- 2.6-rlimit/arch/sparc64/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.204541104 -0700
+++ 2.6-rlimit/arch/sparc64/kernel/init_task.c	2004-05-10 23:16:46.206540800 -0700
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- 2.6-rlimit/arch/um/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.339520584 -0700
+++ 2.6-rlimit/arch/um/kernel/init_task.c	2004-05-10 23:16:46.341520280 -0700
@@ -9,6 +9,7 @@
 #include "linux/sched.h"
 #include "linux/init_task.h"
 #include "linux/version.h"
+#include "linux/mqueue.h"
 #include "asm/uaccess.h"
 #include "asm/pgtable.h"
 #include "user_util.h"
--- 2.6-rlimit/arch/v850/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.477499608 -0700
+++ 2.6-rlimit/arch/v850/kernel/init_task.c	2004-05-10 23:16:46.479499304 -0700
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/x86_64/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.613478936 -0700
+++ 2.6-rlimit/arch/x86_64/kernel/init_task.c	2004-05-10 23:16:46.615478632 -0700
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/arch/arm26/kernel/init_task.c~mqueue_rlimit	2004-05-10 23:16:46.742459328 -0700
+++ 2.6-rlimit/arch/arm26/kernel/init_task.c	2004-05-10 23:16:46.746458720 -0700
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
--- 2.6-rlimit/include/asm-alpha/resource.h~mqueue_rlimit	2004-05-10 23:01:16.253915088 -0700
+++ 2.6-rlimit/include/asm-alpha/resource.h	2004-05-10 23:16:46.747458568 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_MEMLOCK	9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
@@ -43,6 +44,7 @@
     {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
+    {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-arm/resource.h~mqueue_rlimit	2004-05-10 23:01:16.255914784 -0700
+++ 2.6-rlimit/include/asm-arm/resource.h	2004-05-10 23:16:46.749458264 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-cris/resource.h~mqueue_rlimit	2004-05-10 23:01:16.258914328 -0700
+++ 2.6-rlimit/include/asm-cris/resource.h	2004-05-10 23:16:46.750458112 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-h8300/resource.h~mqueue_rlimit	2004-05-10 23:01:16.259914176 -0700
+++ 2.6-rlimit/include/asm-h8300/resource.h	2004-05-10 23:16:46.751457960 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-i386/resource.h~mqueue_rlimit	2004-05-10 23:01:39.674354640 -0700
+++ 2.6-rlimit/include/asm-i386/resource.h	2004-05-10 23:16:46.752457808 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 
 /*
@@ -43,6 +44,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-ia64/resource.h~mqueue_rlimit	2004-05-10 23:01:16.262913720 -0700
+++ 2.6-rlimit/include/asm-ia64/resource.h	2004-05-10 23:16:46.754457504 -0700
@@ -24,8 +24,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -49,6 +50,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 # endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-m68k/resource.h~mqueue_rlimit	2004-05-10 23:01:16.263913568 -0700
+++ 2.6-rlimit/include/asm-m68k/resource.h	2004-05-10 23:16:46.755457352 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-mips/resource.h~mqueue_rlimit	2004-05-10 23:01:16.265913264 -0700
+++ 2.6-rlimit/include/asm-mips/resource.h	2004-05-10 23:16:46.756457200 -0700
@@ -24,8 +24,9 @@
 #define RLIMIT_MEMLOCK 9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS 12			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 13			/* Number of limit flavors.  */
 
 #ifdef __KERNEL__
 
@@ -56,6 +57,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-parisc/resource.h~mqueue_rlimit	2004-05-10 23:01:16.266913112 -0700
+++ 2.6-rlimit/include/asm-parisc/resource.h	2004-05-10 23:16:46.758456896 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-ppc/resource.h~mqueue_rlimit	2004-05-10 23:01:16.267912960 -0700
+++ 2.6-rlimit/include/asm-ppc/resource.h	2004-05-10 23:16:46.759456744 -0700
@@ -13,8 +13,9 @@
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -39,6 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-ppc64/resource.h~mqueue_rlimit	2004-05-10 23:01:16.269912656 -0700
+++ 2.6-rlimit/include/asm-ppc64/resource.h	2004-05-10 23:16:46.760456592 -0700
@@ -22,8 +22,9 @@
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -48,6 +49,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-s390/resource.h~mqueue_rlimit	2004-05-10 23:01:16.270912504 -0700
+++ 2.6-rlimit/include/asm-s390/resource.h	2004-05-10 23:16:46.761456440 -0700
@@ -25,8 +25,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -50,6 +51,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-sh/resource.h~mqueue_rlimit	2004-05-10 23:01:16.271912352 -0700
+++ 2.6-rlimit/include/asm-sh/resource.h	2004-05-10 23:16:46.763456136 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-sparc/resource.h~mqueue_rlimit	2004-05-10 23:01:16.273912048 -0700
+++ 2.6-rlimit/include/asm-sparc/resource.h	2004-05-10 23:16:46.764455984 -0700
@@ -23,8 +23,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -47,6 +48,7 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
+    {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-sparc64/resource.h~mqueue_rlimit	2004-05-10 23:01:16.274911896 -0700
+++ 2.6-rlimit/include/asm-sparc64/resource.h	2004-05-10 23:16:46.765455832 -0700
@@ -23,8 +23,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -46,6 +47,7 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
+    {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-v850/resource.h~mqueue_rlimit	2004-05-10 23:01:16.276911592 -0700
+++ 2.6-rlimit/include/asm-v850/resource.h	2004-05-10 23:16:46.767455528 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/asm-x86_64/resource.h~mqueue_rlimit	2004-05-10 23:01:16.277911440 -0700
+++ 2.6-rlimit/include/asm-x86_64/resource.h	2004-05-10 23:16:46.768455376 -0700
@@ -17,8 +17,9 @@
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
-#define RLIM_NLIMITS	12
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -42,6 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
 }
 
 #endif /* __KERNEL__ */
--- 2.6-rlimit/include/linux/mqueue.h~mqueue_rlimit	2004-05-10 23:01:16.278911288 -0700
+++ 2.6-rlimit/include/linux/mqueue.h	2004-05-10 23:16:46.771454920 -0700
@@ -21,6 +21,8 @@
 #include <linux/types.h>
 
 #define MQ_PRIO_MAX 	32768
+/* per-uid limit of kernel memory used by mqueue, in bytes */
+#define MQ_BYTES_MAX	819200
 
 struct mq_attr {
 	long	mq_flags;	/* message queue flags			*/

