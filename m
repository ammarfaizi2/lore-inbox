Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSHSBha>; Sun, 18 Aug 2002 21:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSHSBha>; Sun, 18 Aug 2002 21:37:30 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:9991 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316951AbSHSBh1>;
	Sun, 18 Aug 2002 21:37:27 -0400
Date: Sun, 18 Aug 2002 21:33:23 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : include/asm/a.out.h (last archs)
Message-ID: <Pine.LNX.4.44.0208182128060.861-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  These patches against archs s390, s390x, sh, sparc, sparc64, x86_64 
reflect the proposed additionm of creating an include/asm-generic/a.out.h 
. Please review.

Regards,
Frank

--- include/asm-s390/a.out.h.old	Fri May 12 14:41:44 2000
+++ include/asm-s390/a.out.h	Thu Aug  8 23:04:05 2002
@@ -13,21 +13,7 @@
 #ifndef __S390_A_OUT_H__
 #define __S390_A_OUT_H__
 
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
 
 
--- include/asm-s390x/a.out.h.old	Tue Feb 13 17:13:44 2001
+++ include/asm-s390x/a.out.h	Thu Aug  8 23:09:27 2002
@@ -13,21 +13,7 @@
 #ifndef __S390_A_OUT_H__
 #define __S390_A_OUT_H__
 
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
 

--- include/asm-sh/a.out.h.old	Mon Aug 30 21:12:59 1999
+++ include/asm-sh/a.out.h	Thu Aug  8 23:11:00 2002
@@ -1,21 +1,7 @@
 #ifndef __ASM_SH_A_OUT_H
 #define __ASM_SH_A_OUT_H
 
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
 

--- include/asm-sparc/a.out.h.old	Thu Jan 13 15:03:00 2000
+++ include/asm-sparc/a.out.h	Thu Aug  8 23:13:21 2002
@@ -5,19 +5,7 @@
 #define SPARC_PGSIZE    0x2000        /* Thanks to the sun4 architecture... */
 #define SEGMENT_SIZE    SPARC_PGSIZE  /* whee... */
 
-struct exec {
-	unsigned char a_dynamic:1;      /* A __DYNAMIC is in this image */
-	unsigned char a_toolversion:7;
-	unsigned char a_machtype;
-	unsigned short a_info;
-	unsigned long a_text;		/* length of text, in bytes */
-	unsigned long a_data;		/* length of data, in bytes */
-	unsigned long a_bss;		/* length of bss, in bytes */
-	unsigned long a_syms;		/* length of symbol table, in bytes */
-	unsigned long a_entry;		/* where program begins */
-	unsigned long a_trsize;
-	unsigned long a_drsize;
-};
+#include <asm-generic/a.out.h>
 
 /* Where in the file does the text information begin? */
 #define N_TXTOFF(x)     (N_MAGIC(x) == ZMAGIC ? 0 : sizeof (struct exec))
@@ -37,10 +25,6 @@
                       (N_TXTADDR(x) + (x).a_text)  \
                        : (_N_SEGMENT_ROUND (_N_TXTENDADDR(x))))
 
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
 /*
  * Sparc relocation types
  */

--- include/asm-sparc64/a.out.h.old	Wed Feb 13 21:27:46 2002
+++ include/asm-sparc64/a.out.h	Thu Aug  8 23:14:39 2002
@@ -7,19 +7,7 @@
 
 #ifndef __ASSEMBLY__
 
-struct exec {
-	unsigned char a_dynamic:1;      /* A __DYNAMIC is in this image */
-	unsigned char a_toolversion:7;
-	unsigned char a_machtype;
-	unsigned short a_info;
-	unsigned int a_text;		/* length of text, in bytes */
-	unsigned int a_data;		/* length of data, in bytes */
-	unsigned int a_bss;		/* length of bss, in bytes */
-	unsigned int a_syms;		/* length of symbol table, in bytes */
-	unsigned int a_entry;		/* where program begins */
-	unsigned int a_trsize;
-	unsigned int a_drsize;
-};
+#include <asm-generic/a.out.h>
 
 #endif /* !__ASSEMBLY__ */
 
@@ -41,10 +29,6 @@
                       (N_TXTADDR(x) + (x).a_text)  \
                        : (unsigned long)(_N_SEGMENT_ROUND (_N_TXTENDADDR(x))))
 
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
 #ifndef __ASSEMBLY__
 
 /*

--- include/asm-x86_64/a.out.h.old	Wed Feb 20 19:46:23 2002
+++ include/asm-x86_64/a.out.h	Thu Aug  8 23:15:53 2002
@@ -5,21 +5,7 @@
 /* Note: a.out is not supported in 64bit mode. This is just here to 
    still let some old things compile. */ 
 
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
 

