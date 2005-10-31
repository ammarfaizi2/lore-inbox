Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVJaVHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVJaVHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVJaVAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:00:17 -0500
Received: from waste.org ([216.27.176.166]:152 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932501AbVJaVAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:14 -0500
Date: Mon, 31 Oct 2005 14:54:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <13.196662837@selenic.com>
Message-Id: <14.196662837@selenic.com>
Subject: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove legacy type definitions from callers

This replaces the legacy zlib typedefs and usage with kernel types in
all the inflate users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -28,20 +28,16 @@ extern long srm_printk(const char *, ...
  * gzip delarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 static char *input_data;
 static int  input_data_size;
 
-static uch *output_data;
+static u8 *output_data;
 
 extern int end;
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static u32 free_mem_ptr;
+static u32 free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
@@ -70,13 +66,13 @@ decompress_kernel(void *output_start,
 		  size_t kzsize)
 {
 	int count;
-	output_data		= (uch *)output_start;
-	input_data		= (uch *)input_start;
+	output_data		= (u8 *)output_start;
+	input_data		= (u8 *)input_start;
 	input_data_size		= kzsize; /* use compressed size */
 
 	/* FIXME FIXME FIXME */
-	free_mem_ptr		= (ulg)output_start + ksize;
-	free_mem_ptr_end	= (ulg)output_start + ksize + 0x200000;
+	free_mem_ptr		= (u32)output_start + ksize;
+	free_mem_ptr_end	= (u32)output_start + ksize + 0x200000;
 	/* FIXME FIXME FIXME */
 
 /*	puts("Uncompressing Linux..."); */
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -46,22 +46,18 @@ icedcc_putstr(const char *ptr)
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 extern char input_data[];
 extern char input_data_end[];
 
-static uch *output_data;
+static u8 *output_data;
 
 static void putstr(const char *);
 
 extern int end;
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static u32 free_mem_ptr;
+static u32 free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
@@ -90,11 +86,11 @@ static void error(char *x)
 
 #ifndef STANDALONE_DEBUG
 
-ulg
-decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
+u32
+decompress_kernel(u32 output_start, u32 free_mem_ptr_p, u32 free_mem_ptr_end_p,
 		  int arch_id)
 {
-	output_data		= (uch *)output_start;	/* Points to kernel start */
+	output_data		= (u8 *)output_start;	/* Points to kernel start */
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_ptr_end	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -31,21 +31,17 @@ unsigned int __machine_arch_type;
  * gzip delarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 extern char input_data[];
 extern char input_data_end[];
-static uch *output_data;
+static u8 *output_data;
 
 static void puts(const char *);
 
 extern int end;
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static u32 free_mem_ptr;
+static u32 free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
@@ -76,11 +72,11 @@ static void error(char *x)
 
 #ifndef STANDALONE_DEBUG
 
-ulg
-decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
+u32
+decompress_kernel(u32 output_start, u32 free_mem_ptr_p, u32 free_mem_ptr_end_p,
 		  int arch_id)
 {
-	output_data		= (uch *)output_start;	/* Points to kernel start */
+	output_data		= (u8 *)output_start;	/* Points to kernel start */
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_ptr_end	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -28,16 +28,12 @@
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 unsigned compsize; /* compressed size, used by head.S */
 
 static void error(char *m);
 
 extern char *input_data;  /* lives in head.S */
-static uch *output_data;
+static u8 *output_data;
 
 static void puts(const char *);
 
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -30,14 +30,10 @@
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 extern char *input_data;  /* lives in head.S */
-static uch *output_data;
+static u8 *output_data;
 
 static void puts(const char *);
 
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -23,9 +23,6 @@
  *
  * Incomprehensible are the ways of bootloaders.
  */
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
 
 static void error(char *m);
 
@@ -43,7 +40,7 @@ static unsigned char *real_mode; /* Poin
 extern char input_data[];
 extern int input_len;
 static long bytes_out;
-static uch *output_data;
+static u8 *output_data;
 
 static void putstr(const char *);
 
@@ -57,7 +54,7 @@ static long free_mem_end_ptr;
 #define HEAP_SIZE             0x3000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+static u8 *high_buffer_start /* = (u8 *)(((u32)&end) + HEAP_SIZE)*/;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -158,13 +155,13 @@ static void setup_normal_output_buffer(v
 }
 
 struct moveparams {
-	uch *low_buffer_start;  int lcount;
-	uch *high_buffer_start; int hcount;
+	u8 *low_buffer_start;  int lcount;
+	u8 *high_buffer_start; int hcount;
 };
 
 static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
-	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
+	high_buffer_start = (u8 *)(((u32)&end) + HEAP_SIZE);
 #ifdef STANDARD_MEMORY_BIOS_CALL
 	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
 #else
@@ -178,8 +175,8 @@ static void setup_output_buffer_if_we_ru
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (__PHYSICAL_START + low_buffer_size) > ((u32)high_buffer_start)) {
+		high_buffer_start = (u8 *)(__PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -17,15 +17,11 @@
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 static unsigned char *input_data;
 static int input_len;
-static uch *output_data;
+static u8 *output_data;
 
 #include "m32r_sio.c"
 
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -19,15 +19,11 @@
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 extern char input_data[];
 extern int input_len;
-static uch *output_data;
+static u8 *output_data;
 
 int puts(const char *);
 
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -19,15 +19,11 @@ int cache_control(unsigned int command);
  * gzip declarations
  */
 
-typedef unsigned char uch;
-typedef unsigned short ush;
-typedef unsigned long ulg;
-
 static void error(char *m);
 
 extern char input_data[];
 extern int input_len;
-static uch *output_data;
+static u8 *output_data;
 
 static void puts(const char *);
 
@@ -68,7 +64,7 @@ long *stack_start = &user_stack[STACK_SI
 
 void decompress_kernel(void)
 {
-	output_data = (uch *) (CONFIG_MEMORY_START + 0x2000);
+	output_data = (u8 *) (CONFIG_MEMORY_START + 0x2000);
 	free_mem_ptr = (unsigned long) &_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:21.000000000 -0700
@@ -16,10 +16,6 @@
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 static void error(char *m);
 
 /*
@@ -37,7 +33,7 @@ extern unsigned char input_data[];
 extern int input_len;
 
 static long bytes_out;
-static uch *output_data;
+static u8 *output_data;
 
 static void putstr(const char *);
 
@@ -51,7 +47,7 @@ static long free_mem_end_ptr;
 #define HEAP_SIZE             0x3000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+static u8 *high_buffer_start /* = (u8 *)(((u32)&end) + HEAP_SIZE)*/;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -139,13 +135,13 @@ void setup_normal_output_buffer(void)
 }
 
 struct moveparams {
-	uch *low_buffer_start;  int lcount;
-	uch *high_buffer_start; int hcount;
+	u8 *low_buffer_start;  int lcount;
+	u8 *high_buffer_start; int hcount;
 };
 
 void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
-	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
+	high_buffer_start = (u8 *)(((u32)&end) + HEAP_SIZE);
 #ifdef STANDARD_MEMORY_BIOS_CALL
 	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
 #else
@@ -157,8 +153,8 @@ void setup_output_buffer_if_we_run_high(
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (__PHYSICAL_START + low_buffer_size) > ((u32)high_buffer_start)) {
+		high_buffer_start = (u8 *)(__PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/init/do_mounts_rd.c	2005-10-28 22:04:21.000000000 -0700
@@ -273,12 +273,8 @@ int __init rd_load_disk(int n)
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 #define INBUFSIZ 4096
-static uch *inbuf;
+static u8 *inbuf;
 static int exit_code;
 static int unzip_error;
 static int crd_infd, crd_outfd;
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-28 22:04:19.000000000 -0700
+++ 2.6.14/init/initramfs.c	2005-10-28 22:04:21.000000000 -0700
@@ -333,10 +333,6 @@ static void __init flush_buffer(const u8
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 #define INIT __init
 
 static void __init error(char *m);
