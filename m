Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUEKIqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUEKIqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEKIqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:46:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:65153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261668AbUEKIpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:45:33 -0400
Date: Tue, 11 May 2004 01:45:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 1/11] add rlimit entry for controlling queued signals
Message-ID: <20040511014524.Z21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511014232.Y21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:42:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an rlimit entry to control the maximum number of pending signals a user
may have.  This is essentially just the resource.h changes.

===== include/asm-alpha/resource.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/resource.h	Tue Feb  5 09:39:46 2002
+++ edited/include/asm-alpha/resource.h	Mon May 10 18:24:25 2004
@@ -15,9 +15,10 @@
 #define RLIMIT_AS	7		/* address space limit(?) */
 #define RLIMIT_NPROC	8		/* max number of processes */
 #define RLIMIT_MEMLOCK	9		/* max locked-in-memory address space */
-#define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
@@ -40,7 +41,8 @@
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
-    {LONG_MAX, LONG_MAX},                       /* RLIMIT_LOCKS */      \
+    {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
+    {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
 }
 
 #endif /* __KERNEL__ */
===== include/asm-arm/resource.h 1.1 vs edited =====
--- 1.1/include/asm-arm/resource.h	Tue Feb  5 09:39:52 2002
+++ edited/include/asm-arm/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
@@ -40,6 +41,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-arm26/resource.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/resource.h	Wed Jun  4 04:14:10 2003
+++ edited/include/asm-arm26/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
@@ -40,6 +41,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-cris/resource.h 1.1 vs edited =====
--- 1.1/include/asm-cris/resource.h	Tue Feb  5 09:56:43 2002
+++ edited/include/asm-cris/resource.h	Mon May 10 18:25:50 2004
@@ -15,9 +15,10 @@
 #define RLIMIT_NOFILE	7		/* max number of open files */
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -38,8 +39,9 @@
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },               \
-        { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-h8300/resource.h 1.1 vs edited =====
--- 1.1/include/asm-h8300/resource.h	Sun Feb 16 16:01:58 2003
+++ edited/include/asm-h8300/resource.h	Mon May 10 18:26:57 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -39,7 +40,8 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-i386/resource.h 1.1 vs edited =====
--- 1.1/include/asm-i386/resource.h	Tue Feb  5 09:39:44 2002
+++ edited/include/asm-i386/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+
+#define RLIM_NLIMITS	12
 
-#define RLIM_NLIMITS	11
 
 /*
  * SuS says limits have to be unsigned.
@@ -39,7 +41,8 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ia64/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ia64/resource.h	Fri Jan 23 10:52:25 2004
+++ edited/include/asm-ia64/resource.h	Mon May 10 18:22:10 2004
@@ -23,8 +23,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -47,6 +48,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 # endif /* __KERNEL__ */
===== include/asm-m68k/resource.h 1.2 vs edited =====
--- 1.2/include/asm-m68k/resource.h	Fri Nov  9 05:47:28 2001
+++ edited/include/asm-m68k/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -39,7 +40,8 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-mips/resource.h 1.3 vs edited =====
--- 1.3/include/asm-mips/resource.h	Mon Jul 28 04:57:50 2003
+++ edited/include/asm-mips/resource.h	Mon May 10 18:22:10 2004
@@ -23,8 +23,9 @@
 #define RLIMIT_NPROC 8			/* max number of processes */
 #define RLIMIT_MEMLOCK 9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS 11			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 12			/* Number of limit flavors.  */
 
 #ifdef __KERNEL__
 
@@ -54,6 +55,7 @@
 	{ 0,             0             },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-parisc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/resource.h	Tue Feb  5 09:39:57 2002
+++ edited/include/asm-parisc/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +41,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ppc/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/resource.h	Sun Sep 15 21:52:06 2002
+++ edited/include/asm-ppc/resource.h	Mon May 10 18:22:10 2004
@@ -12,8 +12,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
@@ -37,6 +38,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ppc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/resource.h	Thu Feb 14 04:14:36 2002
+++ edited/include/asm-ppc64/resource.h	Mon May 10 18:22:10 2004
@@ -21,8 +21,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
@@ -46,6 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-s390/resource.h 1.2 vs edited =====
--- 1.2/include/asm-s390/resource.h	Mon Feb  4 23:37:28 2002
+++ edited/include/asm-s390/resource.h	Mon May 10 18:22:10 2004
@@ -24,8 +24,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
-  
-#define RLIM_NLIMITS	11
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -48,6 +49,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sh/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sh/resource.h	Tue Feb  5 09:39:53 2002
+++ edited/include/asm-sh/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
@@ -40,6 +41,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sparc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/resource.h	Tue Feb  5 09:39:47 2002
+++ edited/include/asm-sparc/resource.h	Mon May 10 18:32:32 2004
@@ -19,11 +19,12 @@
 #define RLIMIT_RSS	5		/* max resident set size */
 #define RLIMIT_NOFILE	6		/* max number of open files */
 #define RLIMIT_NPROC	7		/* max number of processes */
-#define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
-#define RLIMIT_AS       9               /* address space limit */
+#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
+#define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,7 +45,8 @@
     {INR_OPEN, INR_OPEN}, {0, 0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY}	\
+    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {MAX_SIGPENDING, MAX_SIGPENDING},	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sparc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc64/resource.h	Tue Feb  5 09:39:50 2002
+++ edited/include/asm-sparc64/resource.h	Mon May 10 18:33:39 2004
@@ -19,11 +19,12 @@
 #define RLIMIT_RSS	5		/* max resident set size */
 #define RLIMIT_NOFILE	6		/* max number of open files */
 #define RLIMIT_NPROC	7		/* max number of processes */
-#define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
-#define RLIMIT_AS       9               /* address space limit */
+#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
+#define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -43,7 +44,8 @@
     {INR_OPEN, INR_OPEN}, {0, 0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY}	\
+    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {MAX_SIGPENDING, MAX_SIGPENDING},	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-v850/resource.h 1.1 vs edited =====
--- 1.1/include/asm-v850/resource.h	Fri Nov  1 08:38:12 2002
+++ edited/include/asm-v850/resource.h	Mon May 10 18:34:44 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -39,7 +40,8 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-x86_64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-x86_64/resource.h	Thu Feb  7 02:55:27 2002
+++ edited/include/asm-x86_64/resource.h	Mon May 10 18:22:10 2004
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
@@ -39,7 +40,8 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 }
 
 #endif /* __KERNEL__ */
===== include/linux/signal.h 1.15 vs edited =====
--- 1.15/include/linux/signal.h	Thu Jan 15 12:40:33 2004
+++ edited/include/linux/signal.h	Mon May 10 18:22:10 2004
@@ -7,6 +7,9 @@
 #include <asm/siginfo.h>
 
 #ifdef __KERNEL__
+
+#define MAX_SIGPENDING	1024
+
 /*
  * Real Time signals may be queued.
  */

