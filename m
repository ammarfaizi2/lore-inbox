Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSJIHS3>; Wed, 9 Oct 2002 03:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJIHS3>; Wed, 9 Oct 2002 03:18:29 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:47526 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261218AbSJIHS0>;
	Wed, 9 Oct 2002 03:18:26 -0400
Date: Wed, 9 Oct 2002 17:23:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.41-BK] Consolidate asm/ucontext.h
Message-Id: <20021009172348.7eca8e0b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

9 of our architectures use the same struct ucontext.  This patch
creates asm-generic/ucontext.h and changes the 8 architectures to use it.
When the sigcontext_struct -> sigcontext patch goes in PPC64
will also be able to use asm-generic/ucontext.h.

diffstat looks like this:
 asm-arm/ucontext.h     |   13 +------------
 asm-cris/ucontext.h    |   13 +------------
 asm-generic/ucontext.h |   12 ++++++++++++
 asm-i386/ucontext.h    |   13 +------------
 asm-mips/ucontext.h    |   23 +----------------------
 asm-mips64/ucontext.h  |   22 +---------------------
 asm-parisc/ucontext.h  |   13 +------------
 asm-ppc/ucontext.h     |   15 +--------------
 asm-sh/ucontext.h      |   13 +------------
 asm-x86_64/ucontext.h  |   13 +------------
 10 files changed, 21 insertions(+), 129 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.41-1.715/include/asm-arm/ucontext.h 2.5.41-1.715-ucontext/include/asm-arm/ucontext.h
--- 2.5.41-1.715/include/asm-arm/ucontext.h	1998-01-21 11:39:43.000000000 +1100
+++ 2.5.41-1.715-ucontext/include/asm-arm/ucontext.h	2002-10-09 16:59:50.000000000 +1000
@@ -1,12 +1 @@
-#ifndef _ASMARM_UCONTEXT_H
-#define _ASMARM_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* !_ASMARM_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-cris/ucontext.h 2.5.41-1.715-ucontext/include/asm-cris/ucontext.h
--- 2.5.41-1.715/include/asm-cris/ucontext.h	2001-02-09 11:32:44.000000000 +1100
+++ 2.5.41-1.715-ucontext/include/asm-cris/ucontext.h	2002-10-09 16:59:56.000000000 +1000
@@ -1,12 +1 @@
-#ifndef _ASM_CRIS_UCONTEXT_H
-#define _ASM_CRIS_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* !_ASM_CRIS_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-generic/ucontext.h 2.5.41-1.715-ucontext/include/asm-generic/ucontext.h
--- 2.5.41-1.715/include/asm-generic/ucontext.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.41-1.715-ucontext/include/asm-generic/ucontext.h	2002-10-09 16:54:25.000000000 +1000
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_UCONTEXT_H
+#define _ASM_GENERIC_UCONTEXT_H
+
+struct ucontext {
+	unsigned long	  uc_flags;
+	struct ucontext  *uc_link;
+	stack_t		  uc_stack;
+	struct sigcontext uc_mcontext;
+	sigset_t	  uc_sigmask;	/* mask last for extensibility */
+};
+
+#endif /* !_ASM_GENERIC_UCONTEXT_H */
diff -ruN 2.5.41-1.715/include/asm-i386/ucontext.h 2.5.41-1.715-ucontext/include/asm-i386/ucontext.h
--- 2.5.41-1.715/include/asm-i386/ucontext.h	1997-12-02 05:45:24.000000000 +1100
+++ 2.5.41-1.715-ucontext/include/asm-i386/ucontext.h	2002-10-09 17:00:06.000000000 +1000
@@ -1,12 +1 @@
-#ifndef _ASMi386_UCONTEXT_H
-#define _ASMi386_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* !_ASMi386_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-mips/ucontext.h 2.5.41-1.715-ucontext/include/asm-mips/ucontext.h
--- 2.5.41-1.715/include/asm-mips/ucontext.h	2000-05-14 01:31:25.000000000 +1000
+++ 2.5.41-1.715-ucontext/include/asm-mips/ucontext.h	2002-10-09 17:00:21.000000000 +1000
@@ -1,22 +1 @@
-/* $Id: ucontext.h,v 1.2 1999/09/27 16:01:40 ralf Exp $
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Low level exception handling
- *
- * Copyright (C) 1998, 1999 by Ralf Baechle
- */
-#ifndef _ASM_UCONTEXT_H
-#define _ASM_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* _ASM_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-mips64/ucontext.h 2.5.41-1.715-ucontext/include/asm-mips64/ucontext.h
--- 2.5.41-1.715/include/asm-mips64/ucontext.h	2001-09-10 03:43:02.000000000 +1000
+++ 2.5.41-1.715-ucontext/include/asm-mips64/ucontext.h	2002-10-09 17:00:30.000000000 +1000
@@ -1,21 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Low level exception handling
- *
- * Copyright (C) 1998, 1999 by Ralf Baechle
- */
-#ifndef _ASM_UCONTEXT_H
-#define _ASM_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* _ASM_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-parisc/ucontext.h 2.5.41-1.715-ucontext/include/asm-parisc/ucontext.h
--- 2.5.41-1.715/include/asm-parisc/ucontext.h	2000-12-06 07:29:39.000000000 +1100
+++ 2.5.41-1.715-ucontext/include/asm-parisc/ucontext.h	2002-10-09 17:00:36.000000000 +1000
@@ -1,12 +1 @@
-#ifndef _ASMPARISC_UCONTEXT_H
-#define _ASMPARISC_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* !_ASMPARISC_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-ppc/ucontext.h 2.5.41-1.715-ucontext/include/asm-ppc/ucontext.h
--- 2.5.41-1.715/include/asm-ppc/ucontext.h	2002-10-09 15:47:25.000000000 +1000
+++ 2.5.41-1.715-ucontext/include/asm-ppc/ucontext.h	2002-10-09 17:00:41.000000000 +1000
@@ -1,14 +1 @@
-#ifndef _ASMPPC_UCONTEXT_H
-#define _ASMPPC_UCONTEXT_H
-
-/* Copied from i386. */
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* !_ASMPPC_UCONTEXT_H */
+#include <asm-generic/uconext.h>
diff -ruN 2.5.41-1.715/include/asm-sh/ucontext.h 2.5.41-1.715-ucontext/include/asm-sh/ucontext.h
--- 2.5.41-1.715/include/asm-sh/ucontext.h	1999-08-31 11:12:59.000000000 +1000
+++ 2.5.41-1.715-ucontext/include/asm-sh/ucontext.h	2002-10-09 17:00:57.000000000 +1000
@@ -1,12 +1 @@
-#ifndef __ASM_SH_UCONTEXT_H
-#define __ASM_SH_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* __ASM_SH_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
diff -ruN 2.5.41-1.715/include/asm-x86_64/ucontext.h 2.5.41-1.715-ucontext/include/asm-x86_64/ucontext.h
--- 2.5.41-1.715/include/asm-x86_64/ucontext.h	2002-02-20 14:13:21.000000000 +1100
+++ 2.5.41-1.715-ucontext/include/asm-x86_64/ucontext.h	2002-10-09 17:01:04.000000000 +1000
@@ -1,12 +1 @@
-#ifndef _ASMX8664_UCONTEXT_H
-#define _ASMX8664_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif
+#include <asm-generic/ucontext.h>
