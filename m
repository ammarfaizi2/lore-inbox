Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbSJWWkP>; Wed, 23 Oct 2002 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265265AbSJWWkP>; Wed, 23 Oct 2002 18:40:15 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:52614 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265264AbSJWWkB>; Wed, 23 Oct 2002 18:40:01 -0400
Date: Wed, 23 Oct 2002 18:38:33 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : lib/inflate.c remove STATIC
Message-ID: <Pine.LNX.4.44.0210231834580.923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch is the last of the 
#define STATIC static 

macro removals.  There still exists /fs/xfs STATIC references, however, 
due to a code co-existance with libxfs (that uses STATIC), we're unable to 
remove those at this point.

Regards,
Frank

--- linux/lib/inflate.c.old	Wed Oct 23 18:33:33 2002
+++ linux/lib/inflate.c	Tue Oct 22 19:43:03 2002
@@ -107,16 +107,12 @@
 static char rcsid[] = "#Id: inflate.c,v 0.14 1993/06/10 13:27:04 jloup Exp #";
 #endif
 
-#ifndef STATIC
-
 #if defined(STDC_HEADERS) || defined(HAVE_STDLIB_H)
 #  include <sys/types.h>
 #  include <stdlib.h>
 #endif
 
 #include "gzip.h"
-#define STATIC
-#endif /* !STATIC */
 	
 #define slide window
 
@@ -138,15 +134,15 @@
 
 
 /* Function prototypes */
-STATIC int huft_build OF((unsigned *, unsigned, unsigned, 
+ int huft_build OF((unsigned *, unsigned, unsigned, 
 		const ush *, const ush *, struct huft **, int *));
-STATIC int huft_free OF((struct huft *));
-STATIC int inflate_codes OF((struct huft *, struct huft *, int, int));
-STATIC int inflate_stored OF((void));
-STATIC int inflate_fixed OF((void));
-STATIC int inflate_dynamic OF((void));
-STATIC int inflate_block OF((int *));
-STATIC int inflate OF((void));
+ int huft_free OF((struct huft *));
+ int inflate_codes OF((struct huft *, struct huft *, int, int));
+ int inflate_stored OF((void));
+ int inflate_fixed OF((void));
+ int inflate_dynamic OF((void));
+ int inflate_block OF((int *));
+ int inflate OF((void));
 
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
@@ -212,10 +208,10 @@
    the stream.
  */
 
-STATIC ulg bb;                         /* bit buffer */
-STATIC unsigned bk;                    /* bits in bit buffer */
+ ulg bb;                         /* bit buffer */
+ unsigned bk;                    /* bits in bit buffer */
 
-STATIC const ush mask_bits[] = {
+ const ush mask_bits[] = {
     0x0000,
     0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
     0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
@@ -259,8 +255,8 @@
  */
 
 
-STATIC const int lbits = 9;          /* bits in base literal/length lookup table */
-STATIC const int dbits = 6;          /* bits in base distance lookup table */
+ const int lbits = 9;          /* bits in base literal/length lookup table */
+ const int dbits = 6;          /* bits in base distance lookup table */
 
 
 /* If BMAX needs to be larger than 16, then h and x[] should be ulg. */
@@ -268,10 +264,10 @@
 #define N_MAX 288       /* maximum number of codes in any set */
 
 
-STATIC unsigned hufts;         /* track memory usage */
+ unsigned hufts;         /* track memory usage */
 
 
-STATIC int huft_build(b, n, s, d, e, t, m)
+ int huft_build(b, n, s, d, e, t, m)
 unsigned *b;            /* code lengths in bits (all assumed <= BMAX) */
 unsigned n;             /* number of codes (assumed <= N_MAX) */
 unsigned s;             /* number of simple-valued codes (0..s-1) */
@@ -489,7 +485,7 @@
 
 
 
-STATIC int huft_free(t)
+ int huft_free(t)
 struct huft *t;         /* table to free */
 /* Free the malloc'ed tables built by huft_build(), which makes a linked
    list of the tables it made, with the links in a dummy first entry of
@@ -510,7 +506,7 @@
 }
 
 
-STATIC int inflate_codes(tl, td, bl, bd)
+ int inflate_codes(tl, td, bl, bd)
 struct huft *tl, *td;   /* literal/length and distance decoder tables */
 int bl, bd;             /* number of bits decoded by tl[] and td[] */
 /* inflate (decompress) the codes in a deflated (compressed) block.
@@ -619,7 +615,7 @@
 
 
 
-STATIC int inflate_stored()
+ int inflate_stored()
 /* "decompress" an inflated type 0 (stored) block. */
 {
   unsigned n;           /* number of bytes in block */
@@ -675,7 +671,7 @@
 
 
 
-STATIC int inflate_fixed()
+ int inflate_fixed()
 /* decompress an inflated type 1 (fixed Huffman codes) block.  We should
    either replace this with a custom decoder, or at least precompute the
    Huffman tables. */
@@ -729,7 +725,7 @@
 
 
 
-STATIC int inflate_dynamic()
+ int inflate_dynamic()
 /* decompress an inflated type 2 (dynamic Huffman codes) block. */
 {
   int i;                /* temporary variables */
@@ -907,7 +903,7 @@
 
 
 
-STATIC int inflate_block(e)
+ int inflate_block(e)
 int *e;                 /* last block flag */
 /* decompress an inflated block */
 {
@@ -954,7 +950,7 @@
 
 
 
-STATIC int inflate()
+ int inflate()
 /* decompress an inflated entry */
 {
   int e;                /* last block flag */

