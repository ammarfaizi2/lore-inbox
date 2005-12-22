Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVLVScm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVLVScm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVLVSby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:31:54 -0500
Received: from waste.org ([64.81.244.121]:22224 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030278AbVLVS2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:25 -0500
Date: Thu, 22 Dec 2005 12:26:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <17.150843412@selenic.com>
Message-Id: <18.150843412@selenic.com>
Subject: [PATCH 17/20] inflate: mark some arrays as initdata
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: mark some arrays as INITDATA and define it in in-core callers

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 18:36:24.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-12-21 21:17:00.000000000 -0600
@@ -271,6 +271,7 @@ int __init rd_load_disk(int n)
 
 /* gzip declarations */
 #define INIT __init
+#define INITDATA __initdata
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-11-29 18:41:59.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:17:00.000000000 -0600
@@ -104,6 +104,9 @@
 #ifndef INIT
 #define INIT
 #endif
+#ifndef INITDATA
+#define INITDATA const
+#endif
 
 #include <asm/types.h>
 
@@ -235,12 +238,12 @@ static void copy_bytes(struct iostate *i
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
@@ -249,20 +252,20 @@ static const u16 cplens[] = {
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
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 18:36:24.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-12-21 21:17:00.000000000 -0600
@@ -332,6 +332,7 @@ static void __init flush_buffer(const u8
 /* gzip declarations */
 
 #define INIT __init
+#define INITDATA __initdata
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
