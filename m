Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVLVSeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVLVSeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVLVSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:34:24 -0500
Received: from waste.org ([64.81.244.121]:15056 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030275AbVLVS2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:14 -0500
Date: Thu, 22 Dec 2005 12:26:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <15.150843412@selenic.com>
Message-Id: <16.150843412@selenic.com>
Subject: [PATCH 15/20] inflate: (arch) tidy user declarations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: tidy user declarations

Regroup the few remaining gzip-related declarations in users. As the
bulk of the users are now _not_ a collection of routines copied from
gzip, that comment is removed.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-11-29 18:36:44.000000000 -0600
@@ -1,8 +1,5 @@
 /*
  * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
  *
  * Modified for ARM Linux by Russell King
  *
@@ -17,27 +14,22 @@
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
-static char *free_mem_ptr, *free_mem_ptr_end;
-
 #define HEAP_SIZE 0x2000
 
+/* gzip delarations */
+static char *free_mem_ptr, *free_mem_ptr_end;
+
 #include "../../../lib/inflate.c"
 
 /* flush gunzip output window */
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-11-29 18:36:24.000000000 -0600
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
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-11-29 18:36:58.000000000 -0600
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
 
@@ -25,23 +21,18 @@ unsigned int __machine_arch_type;
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
-static char *free_mem_ptr, *free_mem_ptr_end;
-
 #define HEAP_SIZE 0x2000
 
+/* gzip delarations */
+static char *free_mem_ptr, *free_mem_ptr_end;
+
 #include "../../../../lib/inflate.c"
 
 #ifdef STANDALONE_DEBUG
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:37:12.000000000 -0600
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
 static char *free_mem_ptr = (char *)&end;
 static char *free_mem_end_ptr = (char *)0xffffffff;
 
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:37:26.000000000 -0600
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
 static char *free_mem_ptr = (char *)&_end;
 static char *free_mem_end_ptr = (char *)0xffffffff;
 
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-11-29 18:38:49.000000000 -0600
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
@@ -42,9 +30,6 @@ static u8 *output_data;
 
 static void putstr(const char *);
 
-extern int end;
-static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
-
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
@@ -61,6 +46,9 @@ static int lines, cols;
 static void * xquad_portio = NULL;
 #endif
 
+/* gzip declarations */
+static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 static void scroll(void)
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-11-29 18:39:21.000000000 -0600
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
 static char *free_mem_ptr;
 static char *free_mem_end_ptr;
 
-#define HEAP_SIZE             0x10000
-
 #include "../../../../lib/inflate.c"
 
 /* flush the gunzip output buffer */
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-11-29 18:39:36.000000000 -0600
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
@@ -15,22 +12,19 @@
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
-static char *free_mem_ptr, *free_mem_end_ptr;
-
 #define HEAP_SIZE             0x10000
 
+/* gzip declarations */
+static char *free_mem_ptr, *free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 #ifdef CONFIG_SH_STANDARD_BIOS
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-11-29 18:39:49.000000000 -0600
@@ -1,9 +1,6 @@
 /*
  * arch/shmedia/boot/compressed/misc.c
  *
- * This is a collection of several routines from gzip-1.0.3
- * adapted for Linux.
- *
  * Adapted for SHmedia from sh by Stuart Menefy, May 2002
  */
 
@@ -15,22 +12,19 @@
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
-static char *free_mem_ptr, *free_mem_end_ptr;
-
 #define HEAP_SIZE             0x10000
 
+/* gzip declarations */
+static char *free_mem_ptr, *free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 void puts(const char *s)
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:41:41.000000000 -0600
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
@@ -29,15 +22,11 @@ static unsigned char *real_mode; /* Poin
 
 extern unsigned char input_data[];
 extern int input_len;
-
+extern int end;
 static long bytes_out;
 static u8 *output_data;
-
 static void putstr(const char *);
 
-extern int end;
-static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
-
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
 #define LOW_BUFFER_MAX       0x90000
@@ -50,6 +39,9 @@ static char *vidmem = (char *)0xb8000;
 static int vidport;
 static int lines, cols;
 
+/* gzip declarations */
+static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
+
 #include "../../../../lib/inflate.c"
 
 static void scroll(void)
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-11-29 18:36:24.000000000 -0600
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
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 18:36:19.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-11-29 18:36:24.000000000 -0600
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
