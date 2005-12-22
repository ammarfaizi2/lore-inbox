Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVLVSby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVLVSby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVLVS2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:20 -0500
Received: from waste.org ([64.81.244.121]:10192 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030269AbVLVS2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:06 -0500
Date: Thu, 22 Dec 2005 12:26:47 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <13.150843412@selenic.com>
Message-Id: <14.150843412@selenic.com>
Subject: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove legacy type definitions from callers

This replaces the legacy zlib typedefs and usage with kernel types in
all the inflate users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-11-29 18:32:24.000000000 -0600
@@ -28,16 +28,12 @@ extern long srm_printk(const char *, ...
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
 static char *free_mem_ptr, *free_mem_ptr_end;
@@ -69,8 +65,8 @@ decompress_kernel(void *output_start,
 		  size_t kzsize)
 {
 	int count;
-	output_data		= (uch *)output_start;
-	input_data		= (uch *)input_start;
+	output_data		= (u8 *)output_start;
+	input_data		= (u8 *)input_start;
 	input_data_size		= kzsize; /* use compressed size */
 
 	/* FIXME FIXME FIXME */
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-11-29 18:33:11.000000000 -0600
@@ -46,16 +46,12 @@ icedcc_putstr(const char *ptr)
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
 
@@ -95,11 +91,11 @@ static void error(char *x)
 
 #ifndef STANDALONE_DEBUG
 
-ulg
-decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
+u32
+decompress_kernel(u32 output_start, u32 free_mem_ptr_p, u32 free_mem_ptr_end_p,
 		  int arch_id)
 {
-	output_data		= (uch *)output_start;	/* Points to kernel start */
+	output_data		= (u8 *)output_start;	/* Points to kernel start */
 	free_mem_ptr		= (char *)free_mem_ptr_p;
 	free_mem_ptr_end	= (char *)free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-11-29 18:33:40.000000000 -0600
@@ -31,15 +31,11 @@ unsigned int __machine_arch_type;
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
 
@@ -75,11 +71,11 @@ static void error(char *x)
 
 #ifndef STANDALONE_DEBUG
 
-ulg
-decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
+u32
+decompress_kernel(u32 output_start, u32 free_mem_ptr_p, u32 free_mem_ptr_end_p,
 		  int arch_id)
 {
-	output_data		= (uch *)output_start;	/* Points to kernel start */
+	output_data		= (u8 *)output_start;	/* Points to kernel start */
 	free_mem_ptr		= (char *)free_mem_ptr_p;
 	free_mem_ptr_end	= (char *)free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:31:42.000000000 -0600
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
 
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:31:42.000000000 -0600
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
 
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-11-29 18:35:01.000000000 -0600
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
 
@@ -56,7 +53,7 @@ static char *free_mem_ptr = (char *)&end
 #define HEAP_SIZE             0x3000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+static u8 *high_buffer_start /* = (u8 *)(((u32)&end) + HEAP_SIZE)*/;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -157,13 +154,13 @@ static void setup_normal_output_buffer(v
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
@@ -177,8 +174,8 @@ static void setup_output_buffer_if_we_ru
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (char *)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (__PHYSICAL_START + low_buffer_size) > ((u32)high_buffer_start)) {
+		high_buffer_start = (u8 *)(__PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-11-29 18:31:42.000000000 -0600
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
 
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-11-29 18:31:42.000000000 -0600
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
 
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-11-29 18:35:12.000000000 -0600
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
 
@@ -67,7 +63,7 @@ long *stack_start = &user_stack[STACK_SI
 
 void decompress_kernel(void)
 {
-	output_data = (uch *) (CONFIG_MEMORY_START + 0x2000);
+	output_data = (u8 *) (CONFIG_MEMORY_START + 0x2000);
 	free_mem_ptr = (char *)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:31:42.000000000 -0600
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
 
@@ -50,7 +46,7 @@ static char *free_mem_ptr = (char *)&end
 #define HEAP_SIZE             0x3000
 static unsigned int low_buffer_end, low_buffer_size;
 static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+static u8 *high_buffer_start /* = (u8 *)(((u32)&end) + HEAP_SIZE)*/;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -138,13 +134,13 @@ void setup_normal_output_buffer(void)
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
@@ -156,8 +152,8 @@ void setup_output_buffer_if_we_run_high(
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
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-11-29 18:31:42.000000000 -0600
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
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 18:31:40.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-11-29 18:31:42.000000000 -0600
@@ -333,10 +333,6 @@ static void __init flush_buffer(const u8
  * gzip declarations
  */
 
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
 #define INIT __init
 
 static void __init error(char *m);
