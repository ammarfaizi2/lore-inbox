Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSHSBZg>; Sun, 18 Aug 2002 21:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHSBZf>; Sun, 18 Aug 2002 21:25:35 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:34832 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316609AbSHSBZd>;
	Sun, 18 Aug 2002 21:25:33 -0400
Date: Sun, 18 Aug 2002 21:20:52 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : include/asm-generic/a.out.h 
Message-ID: <Pine.LNX.4.44.0208182101270.861-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch creates a new file, include/asm-generic/a.out.h , 
that attempts to consolidate 'struct exec' within the individual 
include/asm/a.out.h files without creating a #ifdef mess. Arch diffs for cris, i386, mips, and 
ppc are included. Please review. 

Regards,
Frank

--- dev/null	Wed Dec 31 19:00:00 1969
+++ include/asm-generic/a.out.h	Thu Aug  8 21:45:20 2002
@@ -0,0 +1,30 @@
+#ifndef __ASMGEN_A_OUT_H__
+#define __ASMGEN_A_OUT_H__
+
+/* This defines the generic a.out exec struct used by all archs
+ *
+ **/
+
+struct exec
+{
+#ifdef (__SPARC_A_OUT_H__ || __SPARC64_A_OUT_H__ )
+  unsigned char a_dynamic:1;
+  unsigned char a_toolversion:7;
+  unsigned a_machtype;
+#endif
+  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
+  unsigned long a_text;		/* length of text, in bytes */
+  unsigned long a_data;		/* length of data, in bytes */
+  unsigned long a_bss;		/* length of uninitialized data area for file, in bytes */
+  unsigned long a_syms;		/* length of symbol table data in file, in bytes */
+  unsigned long a_entry;		/* start address */
+  unsigned long a_trsize;		/* length of relocation info for text, in bytes */
+  unsigned long a_drsize;		/* length of relocation info for data, in bytes */
+};
+
+
+#define N_TRSIZE(a)	((a).a_trsize)
+#define N_DRSIZE(a)	((a).a_drsize)
+#define N_SYMSIZE(a)	((a).a_syms)
+
+#endif


--- asm-cris/a.out.h.old	Thu Feb  8 19:32:44 2001
+++ asm-cris/a.out.h	Thu Aug  8 21:48:27 2002
@@ -9,23 +9,6 @@
 /* grabbed from the intel stuff  */   
 #define STACK_TOP TASK_SIZE
 
-
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
+#include <asm-generic/a.out.h>
 
 #endif

--- asm-i386/a.out.h.old	Fri Jun 16 14:33:06 1995
+++ asm-i386/a.out.h	Thu Aug  8 21:50:56 2002
@@ -1,21 +1,7 @@
 #ifndef __I386_A_OUT_H__
 #define __I386_A_OUT_H__
 
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
+#include <asm-generic/a.out.h>
 
 #ifdef __KERNEL__
 
--- asm-mips/a.out.h.old	Wed Dec 13 05:39:45 1995
+++ asm-mips/a.out.h	Thu Aug  8 22:04:18 2002
@@ -1,21 +1,7 @@
 #ifndef __ASM_MIPS_A_OUT_H
 #define __ASM_MIPS_A_OUT_H
 
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
+#include <asm-generic/a.out.h>
 
 #ifdef __KERNEL__
 
--- asm-ppc/a.out.h.old	Mon May 21 18:02:06 2001
+++ asm-ppc/a.out.h	Thu Aug  8 23:01:38 2002
@@ -7,23 +7,6 @@
 /* grabbed from the intel stuff  */   
 #define STACK_TOP TASK_SIZE
 
-
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
+#include <asm-generic/a.out.h>
 
 #endif

