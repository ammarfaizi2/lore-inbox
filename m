Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUHEEIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUHEEIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUHEEIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:08:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267344AbUHEEIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:08:40 -0400
Date: Thu, 5 Aug 2004 00:08:33 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] increase mlock limit to 32k
Message-ID: <Pine.LNX.4.44.0408050005380.25023-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since various gnupg users have indicated that gpg wants to mlock
32kB of memory, I created the patch below that increases the
default mlock ulimit to 32kB.

This is no security problem because it's trivial for processes
to lock way more memory than this in page tables, network buffers,
etc.   In fact, since this patch allows gnupg to mlock to prevent
passphrase data from being swapped out, the security people will
probably like it ;)

Signed-off-by: Rik van Riel <riel@redhat.com>


--- linux-2.6.7/include/asm-ppc64/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ppc64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 32768,	     32768     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-m68k/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-m68k/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,		32768  },			\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-parisc/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-parisc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,		32768  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ppc/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ppc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{	 32768,		32768  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-x86_64/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-x86_64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE , PAGE_SIZE  },		\
+	{ 	32768 ,		32768  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ia64/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ia64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,		 32768 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-arm/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-arm/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ PAGE_SIZE,      PAGE_SIZE    },	\
+	{ 	32768,      	32768  },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-sparc/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sparc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {PAGE_SIZE, PAGE_SIZE},	\
+    {		32768,	 32768},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-alpha/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-alpha/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {PAGE_SIZE, PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
+    {	32768, 32768},				/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
--- linux-2.6.7/include/asm-h8300/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-h8300/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,     32768     },			\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-i386/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-i386/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,		32768  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-s390/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-s390/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,		32768  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-cris/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-cris/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{     PAGE_SIZE,    PAGE_SIZE  },               \
+	{	32768,		32768  },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sparc64/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sparc64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {PAGE_SIZE,     PAGE_SIZE    },	\
+    {	32768,     32768    },		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-arm26/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-arm26/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ PAGE_SIZE,     PAGE_SIZE     },	\
+	{ 32768,         32768         },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-v850/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-v850/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE, PAGE_SIZE  },		\
+	{ 	32768,		 32768 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sh/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sh/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{ 	32768,     32768     },			\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\

