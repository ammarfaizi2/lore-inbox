Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUKMRkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUKMRkI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUKMRjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 12:39:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31129 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261853AbUKMRgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 12:36:55 -0500
Date: Sat, 13 Nov 2004 18:36:50 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411131736.iADHaoB20668@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] __init for inflate.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In do_mounts_rd.c and initramfs.c there are many references
from .text to .text.init because of the inclusion of lib/inflate.c.
The below adds INIT markup in lib/inflate.c.

diff -uprN -X /linux/dontdiff a/init/do_mounts_rd.c b/init/do_mounts_rd.c
--- a/init/do_mounts_rd.c	2004-10-30 21:44:07.000000000 +0200
+++ b/init/do_mounts_rd.c	2004-11-13 18:08:10.000000000 +0100
@@ -309,14 +309,15 @@ static int crd_infd, crd_outfd;
 #define Tracecv(c,x)
 
 #define STATIC static
+#define INIT __init
 
-static int  fill_inbuf(void);
-static void flush_window(void);
-static void *malloc(size_t size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
+static int  __init fill_inbuf(void);
+static void __init flush_window(void);
+static void __init *malloc(size_t size);
+static void __init free(void *where);
+static void __init error(char *m);
+static void __init gzip_mark(void **);
+static void __init gzip_release(void **);
 
 #include "../lib/inflate.c"
 
diff -uprN -X /linux/dontdiff a/init/initramfs.c b/init/initramfs.c
--- a/init/initramfs.c	2004-08-26 22:05:44.000000000 +0200
+++ b/init/initramfs.c	2004-11-13 18:40:56.000000000 +0100
@@ -372,11 +372,12 @@ static long bytes_out;
 #define Tracecv(c,x)
 
 #define STATIC static
+#define INIT __init
 
-static void flush_window(void);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
+static void __init flush_window(void);
+static void __init error(char *m);
+static void __init gzip_mark(void **);
+static void __init gzip_release(void **);
 
 #include "../lib/inflate.c"
 
diff -uprN -X /linux/dontdiff a/lib/inflate.c b/lib/inflate.c
--- a/lib/inflate.c	2004-04-08 13:18:03.000000000 +0200
+++ b/lib/inflate.c	2004-11-13 18:17:14.000000000 +0100
@@ -118,6 +118,10 @@ static char rcsid[] = "#Id: inflate.c,v 
 #include "gzip.h"
 #define STATIC
 #endif /* !STATIC */
+
+#ifndef INIT
+#define INIT
+#endif
 	
 #define slide window
 
@@ -139,15 +143,15 @@ struct huft {
 
 
 /* Function prototypes */
-STATIC int huft_build OF((unsigned *, unsigned, unsigned, 
+STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned, 
 		const ush *, const ush *, struct huft **, int *));
-STATIC int huft_free OF((struct huft *));
-STATIC int inflate_codes OF((struct huft *, struct huft *, int, int));
-STATIC int inflate_stored OF((void));
-STATIC int inflate_fixed OF((void));
-STATIC int inflate_dynamic OF((void));
-STATIC int inflate_block OF((int *));
-STATIC int inflate OF((void));
+STATIC int INIT huft_free OF((struct huft *));
+STATIC int INIT inflate_codes OF((struct huft *, struct huft *, int, int));
+STATIC int INIT inflate_stored OF((void));
+STATIC int INIT inflate_fixed OF((void));
+STATIC int INIT inflate_dynamic OF((void));
+STATIC int INIT inflate_block OF((int *));
+STATIC int INIT inflate OF((void));
 
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
@@ -272,7 +276,7 @@ STATIC const int dbits = 6;          /* 
 STATIC unsigned hufts;         /* track memory usage */
 
 
-STATIC int huft_build(
+STATIC int INIT huft_build(
 	unsigned *b,            /* code lengths in bits (all assumed <= BMAX) */
 	unsigned n,             /* number of codes (assumed <= N_MAX) */
 	unsigned s,             /* number of simple-valued codes (0..s-1) */
@@ -491,7 +495,7 @@ DEBG("huft7 ");
 
 
 
-STATIC int huft_free(
+STATIC int INIT huft_free(
 	struct huft *t         /* table to free */
 	)
 /* Free the malloc'ed tables built by huft_build(), which makes a linked
@@ -513,7 +517,7 @@ STATIC int huft_free(
 }
 
 
-STATIC int inflate_codes(
+STATIC int INIT inflate_codes(
 	struct huft *tl,    /* literal/length decoder tables */
 	struct huft *td,    /* distance decoder tables */
 	int bl,             /* number of bits decoded by tl[] */
@@ -628,7 +632,7 @@ STATIC int inflate_codes(
 
 
 
-STATIC int inflate_stored(void)
+STATIC int INIT inflate_stored(void)
 /* "decompress" an inflated type 0 (stored) block. */
 {
   unsigned n;           /* number of bytes in block */
@@ -689,7 +693,7 @@ DEBG("<stor");
 /*
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-STATIC int noinline inflate_fixed(void)
+STATIC int noinline INIT inflate_fixed(void)
 /* decompress an inflated type 1 (fixed Huffman codes) block.  We should
    either replace this with a custom decoder, or at least precompute the
    Huffman tables. */
@@ -745,7 +749,7 @@ DEBG("<fix");
 /*
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
-STATIC int noinline inflate_dynamic(void)
+STATIC int noinline INIT inflate_dynamic(void)
 /* decompress an inflated type 2 (dynamic Huffman codes) block. */
 {
   int i;                /* temporary variables */
@@ -926,7 +930,7 @@ DEBG("dyn7 ");
 
 
 
-STATIC int inflate_block(
+STATIC int INIT inflate_block(
 	int *e                  /* last block flag */
 	)
 /* decompress an inflated block */
@@ -977,7 +981,7 @@ STATIC int inflate_block(
 
 
 
-STATIC int inflate(void)
+STATIC int INIT inflate(void)
 /* decompress an inflated entry */
 {
   int e;                /* last block flag */
@@ -1039,7 +1043,7 @@ static ulg crc;		/* initialized in makec
  * gzip-1.0.3/makecrc.c.
  */
 
-static void
+static void INIT
 makecrc(void)
 {
 /* Not copyrighted 1990 Mark Adler	*/
@@ -1087,7 +1091,7 @@ makecrc(void)
 /*
  * Do the uncompression!
  */
-static int gunzip(void)
+static int INIT gunzip(void)
 {
     uch flags;
     unsigned char magic[2]; /* magic header */
