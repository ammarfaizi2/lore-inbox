Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVLVS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVLVS3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVLVS2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:45 -0500
Received: from waste.org ([64.81.244.121]:25040 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030279AbVLVS22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:28 -0500
Date: Thu, 22 Dec 2005 12:27:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <18.150843412@selenic.com>
Message-Id: <19.150843412@selenic.com>
Subject: [PATCH 18/20] inflate: minor const changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: small constant tidy-up

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-11-29 18:42:29.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-11-29 18:43:25.000000000 -0600
@@ -52,7 +52,7 @@
    The Huffman codes themselves are decoded using a multi-level table
    lookup, in order to maximize the speed of decoding plus the speed of
    building the decoding tables.  See the comments below that precede the
-   lbits and dbits tuning parameters.
+   LBITS and dbits tuning parameters.
  */
 
 /*
@@ -349,9 +349,9 @@ static inline void popbytes(struct iosta
    the longer codes.  The time it costs to decode the longer codes is
    then traded against the time it takes to make longer tables.
 
-   This results of this trade are in the variables lbits and dbits
-   below.  lbits is the number of bits the first level table for literal/
-   length codes can decode in one step, and dbits is the same thing for
+   This results of this trade are in the variables LBITS and DBITS
+   below.  LBITS is the number of bits the first level table for literal/
+   length codes can decode in one step, and DBITS is the same thing for
    the distance codes.  Subsequent tables are also less than or equal to
    those sizes.  These values may be adjusted either when all of the
    codes are shorter than that, in which case the longest code length in
@@ -364,17 +364,15 @@ static inline void popbytes(struct iosta
    codes 286 possible values, or in a flat code, a little over eight
    bits.  The distance table codes 30 possible values, or a little less
    than five bits, flat.  The optimum values for speed end up being
-   about one bit more than those, so lbits is 8+1 and dbits is 5+1.
+   about one bit more than those, so LBITS is 8+1 and DBITS is 5+1.
    The optimum values may differ though from machine to machine, and
    possibly even between compilers.  Your mileage may vary.
  */
 
-static const int lbits = 9;	/* bits in base literal/length lookup table */
-static const int dbits = 6;	/* bits in base distance lookup table */
-
-/* If BMAX needs to be larger than 16, then h and x[] should be u32. */
-#define BMAX 16		/* maximum bit length of any code (16 for explode) */
-#define N_MAX 288	/* maximum number of codes in any set */
+#define LBITS 9 /* bits in base literal/length lookup table */
+#define DBITS 6 /* bits in base distance lookup table */
+#define BMAX 16 /* maximum bit length of any code (16 for explode) */
+#define N_MAX 288 /* maximum number of codes in any set */
 
 /*
  * huft-build - build a huffman decoding table
@@ -830,7 +828,7 @@ static int noinline INIT inflate_dynamic
 	huft_free(tl);
 
 	/* build the decoding tables for literal/length and distance codes */
-	bl = lbits;
+	bl = LBITS;
 	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl))) {
 		if (i == 1) {
 			io->error("incomplete literal tree");
@@ -839,7 +837,7 @@ static int noinline INIT inflate_dynamic
 		return i;	/* incomplete code set */
 	}
 
-	bd = dbits;
+	bd = DBITS;
 	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd))) {
 		if (i == 1) {
 			io->error("incomplete distance tree");
