Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVJaVFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVJaVFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVJaVEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:04:31 -0500
Received: from waste.org ([216.27.176.166]:10648 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932537AbVJaVAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:38 -0500
Date: Mon, 31 Oct 2005 14:54:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <15.196662837@selenic.com>
Message-Id: <16.196662837@selenic.com>
Subject: [PATCH 15/20] inflate: (arch) tidy user declarations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: tidy user declarations

Regroup the few remaining gzip-related declarations in users. As the
bulk of the users are now _not_ a collection of routines copied from
gzip, that comment is removed.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * Modified for ARM Linux by Russell King
  *
@@ -17,28 +14,23 @@
  */
 
 #include <linux/kernel.h>
-
 #include <asm/uaccess.h>
 
 #define puts		srm_printk
 extern long srm_printk(const char *, ...)
      __attribute__ ((format (printf, 1, 2)));
 
-/*
- * gzip delarations
- */
-
+extern int end;
 static char *input_data;
 static int  input_data_size;
-
 static u8 *output_data;
 
-extern int end;
+#define HEAP_SIZE 0x2000
+
+/* gzip delarations */
 static u32 free_mem_ptr;
 static u32 free_mem_ptr_end;
 
-#define HEAP_SIZE 0x2000
-
 #include "../../../lib/inflate.c"
 
 /* flush gunzip output window */
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * Modified for ARM Linux by Russell King
  *
@@ -17,7 +14,6 @@
 unsigned int __machine_arch_type;
 
 #include <linux/string.h>
-
 #include <asm/arch/uncompress.h>
 
 #ifdef STANDALONE_DEBUG
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * Modified for ARM Linux by Russell King
  *
@@ -17,7 +14,6 @@
 unsigned int __machine_arch_type;
 
 #include <linux/kernel.h>
-
 #include <asm/uaccess.h>
 #include "uncompress.h"
 
@@ -25,24 +21,19 @@ unsigned int __machine_arch_type;
 #define puts printf
 #endif
 
-#define __ptr_t void *
-
-/*
- * gzip delarations
- */
-
+extern int end;
 extern char input_data[];
 extern char input_data_end[];
 static u8 *output_data;
 
 static void puts(const char *);
 
-extern int end;
+#define HEAP_SIZE 0x2000
+
+/* gzip delarations */
 static u32 free_mem_ptr;
 static u32 free_mem_ptr_end;
 
-#define HEAP_SIZE 0x2000
-
 #include "../../../../lib/inflate.c"
 
 #ifdef STANDALONE_DEBUG
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,14 +1,9 @@
 /*
  * misc.c
  *
- * $Id: misc.c,v 1.6 2003/10/27 08:04:31 starvik Exp $
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
- *
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * adoptation for Linux/CRIS Axis Communications AB, 1999
- * 
+ *
  */
 
 /* where the piggybacked kernel image expects itself to live.
@@ -20,24 +15,17 @@
 #define KERNEL_LOAD_ADR 0x40004000
 
 #include <linux/config.h>
-
 #include <linux/types.h>
 #include <asm/arch/svinto.h>
 
-/*
- * gzip declarations
- */
-
-unsigned compsize; /* compressed size, used by head.S */
-
+extern int end; /* the "heap" is put directly after the BSS ends, at end */
+extern unsigned compsize; /* compressed size, used by head.S */
 extern char *input_data;  /* lives in head.S */
 static u8 *output_data;
 
 static void puts(const char *);
 
-/* the "heap" is put directly after the BSS ends, at end */
-  
-extern int end;
+/* gzip declarations */
 static long free_mem_ptr = (long)&end;
 static long free_mem_end_ptr = 0xffffffff;
 
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,11 +1,6 @@
 /*
  * misc.c
  *
- * $Id: misc.c,v 1.8 2005/04/24 18:34:29 starvik Exp $
- *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * adoptation for Linux/CRIS Axis Communications AB, 1999
  *
@@ -20,24 +15,18 @@
 #define KERNEL_LOAD_ADR 0x40004000
 
 #include <linux/config.h>
-
 #include <linux/types.h>
 #include <asm/arch/hwregs/reg_rdwr.h>
 #include <asm/arch/hwregs/reg_map.h>
 #include <asm/arch/hwregs/ser_defs.h>
 
-/*
- * gzip declarations
- */
-
+extern int _end; /* the "heap" is put directly after the BSS ends, at end */
 extern char *input_data;  /* lives in head.S */
 static u8 *output_data;
 
 static void puts(const char *);
 
-/* the "heap" is put directly after the BSS ends, at end */
-
-extern int _end;
+/* gzip declarations */
 static long free_mem_ptr = (long)&_end;
 static long free_mem_end_ptr = 0xffffffff;
 
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
@@ -15,16 +12,6 @@
 #include <asm/page.h>
 
 /*
- * gzip declarations
- */
-
-/*
- * Why do we do this? Don't ask me..
- *
- * Incomprehensible are the ways of bootloaders.
- */
-
-/*
  * This is set up by the setup-routine at boot-time
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
@@ -35,6 +22,7 @@ static unsigned char *real_mode; /* Poin
 #endif
 #define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
 
+extern int end;
 extern char input_data[];
 extern int input_len;
 static long bytes_out;
@@ -42,10 +30,6 @@ static u8 *output_data;
 
 static void putstr(const char *);
 
-extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
@@ -62,6 +46,10 @@ static int lines, cols;
 static void * xquad_portio = NULL;
 #endif
 
+/* gzip declarations */
+static long free_mem_ptr = (long)&end;
+static long free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 static void scroll(void)
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,9 +1,6 @@
 /*
  * arch/m32r/boot/compressed/misc.c
  *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
  * Adapted for SH by Stuart Menefy, Aug 1999
  *
  * 2003-02-12:	Support M32R by Takeo Takahashi
@@ -13,21 +10,18 @@
 #include <linux/config.h>
 #include <linux/string.h>
 
-/*
- * gzip declarations
- */
-
 static unsigned char *input_data;
 static int input_len;
 static u8 *output_data;
 
 #include "m32r_sio.c"
 
+#define HEAP_SIZE             0x10000
+
+/* gzip declarations */
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
-#define HEAP_SIZE             0x10000
-
 #include "../../../../lib/inflate.c"
 
 /* flush the gunzip output buffer */
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,9 +1,6 @@
 /*
  * arch/sh/boot/compressed/misc.c
  *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
  * Adapted for SH by Stuart Menefy, Aug 1999
  *
  * Modified to use standard LinuxSH BIOS by Greg Banks 7Jul2000
@@ -15,23 +12,20 @@
 #include <asm/sh_bios.h>
 #endif
 
-/*
- * gzip declarations
- */
-
+extern int _text;		/* Defined in vmlinux.lds.S */
+extern int _end;
 extern char input_data[];
 extern int input_len;
 static u8 *output_data;
 
 int puts(const char *);
 
-extern int _text;		/* Defined in vmlinux.lds.S */
-extern int _end;
+#define HEAP_SIZE             0x10000
+
+/* gzip declarations */
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
-#define HEAP_SIZE             0x10000
-
 #include "../../../../lib/inflate.c"
 
 #ifdef CONFIG_SH_STANDARD_BIOS
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,9 +1,6 @@
 /*
  * arch/shmedia/boot/compressed/misc.c
  *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
  * Adapted for SHmedia from sh by Stuart Menefy, May 2002
  */
 
@@ -15,23 +12,20 @@
 #define CACHE_DISABLE     1
 int cache_control(unsigned int command);
 
-/*
- * gzip declarations
- */
-
+extern int _text;		/* Defined in vmlinux.lds.S */
+extern int _end;
 extern char input_data[];
 extern int input_len;
 static u8 *output_data;
 
 static void puts(const char *);
 
-extern int _text;		/* Defined in vmlinux.lds.S */
-extern int _end;
+#define HEAP_SIZE             0x10000
+
+/* gzip declarations */
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
-#define HEAP_SIZE             0x10000
-
 #include "../../../../lib/inflate.c"
 
 void puts(const char *s)
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:25.000000000 -0700
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
@@ -13,10 +10,6 @@
 #include <asm/page.h>
 
 /*
- * gzip declarations
- */
-
-/*
  * This is set up by the setup-routine at boot-time
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
@@ -29,16 +22,11 @@ static unsigned char *real_mode; /* Poin
 
 extern unsigned char input_data[];
 extern int input_len;
-
+extern int end;
 static long bytes_out;
 static u8 *output_data;
-
 static void putstr(const char *);
 
-extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
@@ -51,6 +39,10 @@ static char *vidmem = (char *)0xb8000;
 static int vidport;
 static int lines, cols;
 
+/* gzip declarations */
+static long free_mem_ptr = (long)&end;
+static long free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 static void scroll(void)
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/init/do_mounts_rd.c	2005-10-28 22:04:25.000000000 -0700
@@ -269,9 +269,11 @@ int __init rd_load_disk(int n)
 
 #ifdef BUILD_CRAMDISK
 
-/*
- * gzip declarations
- */
+/* gzip declarations */
+#define INIT __init
+#define NO_INFLATE_MALLOC
+
+#include "../lib/inflate.c"
 
 #define INBUFSIZ 4096
 static u8 *inbuf;
@@ -279,12 +281,6 @@ static int exit_code;
 static int unzip_error;
 static int crd_infd, crd_outfd;
 
-#define INIT __init
-
-#define NO_INFLATE_MALLOC
-
-#include "../lib/inflate.c"
-
 static void __init error(const char *x)
 {
 	printk(KERN_ERR "%s\n", x);
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/init/initramfs.c	2005-10-28 22:04:25.000000000 -0700
@@ -329,12 +329,9 @@ static void __init flush_buffer(const u8
 	}
 }
 
-/*
- * gzip declarations
- */
+/* gzip declarations */
 
 #define INIT __init
-
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
