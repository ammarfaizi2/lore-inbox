Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbSJACpJ>; Mon, 30 Sep 2002 22:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJACpJ>; Mon, 30 Sep 2002 22:45:09 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:1271 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261455AbSJACpF>;
	Mon, 30 Sep 2002 22:45:05 -0400
Date: Tue, 1 Oct 2002 12:50:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate asm/ucontext.h for 2.5.39
Message-Id: <20021001125017.5da31db8.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

8 of our architectures use the same struct ucontext.  This patch
creates asm-generic/ucontext.h and changes the 8 architectures to use it.
When the sigcontext_struct -> sigcontext patch goes in, PPC and PPC64
will also be able to use asm-generic/ucontext.h.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.39/include/asm-arm/ucontext.h 2.5.39-ucontext/include/asm-arm/ucontext.h
--- 2.5.39/include/asm-arm/ucontext.h	1998-01-21 11:39:43.000000000 +1100
+++ 2.5.39-ucontext/include/asm-arm/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ASMARM_UCONTEXT_H
 #define _ASMARM_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* !_ASMARM_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-cris/ucontext.h 2.5.39-ucontext/include/asm-cris/ucontext.h
--- 2.5.39/include/asm-cris/ucontext.h	2001-02-09 11:32:44.000000000 +1100
+++ 2.5.39-ucontext/include/asm-cris/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ASM_CRIS_UCONTEXT_H
 #define _ASM_CRIS_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* !_ASM_CRIS_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-generic/ucontext.h 2.5.39-ucontext/include/asm-generic/ucontext.h
--- 2.5.39/include/asm-generic/ucontext.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.39-ucontext/include/asm-generic/ucontext.h	2002-10-01 12:40:07.000000000 +1000
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
diff -ruN 2.5.39/include/asm-i386/ucontext.h 2.5.39-ucontext/include/asm-i386/ucontext.h
--- 2.5.39/include/asm-i386/ucontext.h	1997-12-02 05:45:24.000000000 +1100
+++ 2.5.39-ucontext/include/asm-i386/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ASMi386_UCONTEXT_H
 #define _ASMi386_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* !_ASMi386_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-mips/ucontext.h 2.5.39-ucontext/include/asm-mips/ucontext.h
--- 2.5.39/include/asm-mips/ucontext.h	2000-05-14 01:31:25.000000000 +1000
+++ 2.5.39-ucontext/include/asm-mips/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -11,12 +11,6 @@
 #ifndef _ASM_UCONTEXT_H
 #define _ASM_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* _ASM_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-mips64/ucontext.h 2.5.39-ucontext/include/asm-mips64/ucontext.h
--- 2.5.39/include/asm-mips64/ucontext.h	2001-09-10 03:43:02.000000000 +1000
+++ 2.5.39-ucontext/include/asm-mips64/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -10,12 +10,6 @@
 #ifndef _ASM_UCONTEXT_H
 #define _ASM_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* _ASM_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-parisc/ucontext.h 2.5.39-ucontext/include/asm-parisc/ucontext.h
--- 2.5.39/include/asm-parisc/ucontext.h	2000-12-06 07:29:39.000000000 +1100
+++ 2.5.39-ucontext/include/asm-parisc/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ASMPARISC_UCONTEXT_H
 #define _ASMPARISC_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* !_ASMPARISC_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-sh/ucontext.h 2.5.39-ucontext/include/asm-sh/ucontext.h
--- 2.5.39/include/asm-sh/ucontext.h	1999-08-31 11:12:59.000000000 +1000
+++ 2.5.39-ucontext/include/asm-sh/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef __ASM_SH_UCONTEXT_H
 #define __ASM_SH_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif /* __ASM_SH_UCONTEXT_H */
diff -ruN 2.5.39/include/asm-x86_64/ucontext.h 2.5.39-ucontext/include/asm-x86_64/ucontext.h
--- 2.5.39/include/asm-x86_64/ucontext.h	2002-02-20 14:13:21.000000000 +1100
+++ 2.5.39-ucontext/include/asm-x86_64/ucontext.h	2002-10-01 12:40:07.000000000 +1000
@@ -1,12 +1,6 @@
 #ifndef _ASMX8664_UCONTEXT_H
 #define _ASMX8664_UCONTEXT_H
 
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
+#include <asm-generic/ucontext.h>
 
 #endif
