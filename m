Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVJaVAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVJaVAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVJaVAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:00:34 -0500
Received: from waste.org ([216.27.176.166]:6296 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932521AbVJaVAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:21 -0500
Date: Mon, 31 Oct 2005 14:54:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <17.196662837@selenic.com>
Message-Id: <18.196662837@selenic.com>
Subject: [PATCH 17/20] inflate: mark some arrays as initdata
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: mark some arrays as INITDATA and define it in in-core callers

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/init/do_mounts_rd.c
===================================================================
--- tiny.orig/init/do_mounts_rd.c	2005-09-30 23:45:21.000000000 -0700
+++ tiny/init/do_mounts_rd.c	2005-09-30 23:45:37.000000000 -0700
@@ -271,6 +271,7 @@ int __init rd_load_disk(int n)
 
 /* gzip declarations */
 #define INIT __init
+#define INITDATA __initdata
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
Index: tiny/lib/inflate.c
===================================================================
--- tiny.orig/lib/inflate.c	2005-09-30 23:45:33.000000000 -0700
+++ tiny/lib/inflate.c	2005-09-30 23:48:16.000000000 -0700
@@ -104,6 +104,9 @@
 #ifndef INIT
 #define INIT
 #endif
+#ifndef INITDATA
+#define INITDATA
+#endif
 
 #include <asm/types.h>
 
@@ -144,7 +147,7 @@ static void free(void *where)
 		malloc_ptr = free_mem_ptr;
 }
 
-static u8 window[0x8000]; /* use a statically allocated window */
+static u8 INITDATA window[0x8000]; /* use a statically allocated window */
 #else
 static u8 *window; /* dynamically allocate */
 #define malloc(a) kmalloc(a, GFP_KERNEL)
@@ -236,12 +239,12 @@ static void copy_bytes(struct iostate *i
 /* Tables for deflate from PKZIP's appnote.txt. */
 
 /* Order of the bit length code lengths */
-static const unsigned border[] = {
+static INITDATA unsigned border[] = {
 	16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15
 };
 
 /* Copy lengths for literal codes 257..285 */
-static const u16 cplens[] = {
+static INITDATA u16 cplens[] = {
 	3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
 	35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
 };
@@ -250,20 +253,20 @@ static const u16 cplens[] = {
  * note: see note #13 above about the 258 in this list.
  * 99==invalid
  */
-static const u16 cplext[] = {
+static INITDATA u16 cplext[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
 	3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99
 };
 
 /* Copy offsets for distance codes 0..29 */
-static const u16 cpdist[] = {
+static INITDATA u16 cpdist[] = {
 	1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
 	257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
 	8193, 12289, 16385, 24577
 };
 
 /* Extra bits for distance codes */
-static const u16 cpdext[] = {
+static INITDATA u16 cpdext[] = {
 	0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
 	7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
 	12, 12, 13, 13
Index: tiny/init/initramfs.c
===================================================================
--- tiny.orig/init/initramfs.c	2005-09-30 23:44:47.000000000 -0700
+++ tiny/init/initramfs.c	2005-09-30 23:46:20.000000000 -0700
@@ -332,6 +332,7 @@ static void __init flush_buffer(u8 *buf,
 /* gzip declarations */
 
 #define INIT __init
+#define INITDATA __initdata
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
