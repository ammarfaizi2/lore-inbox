Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVJaVEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVJaVEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVJaVEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:04:36 -0500
Received: from waste.org ([216.27.176.166]:10136 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932536AbVJaVAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:37 -0500
Date: Mon, 31 Oct 2005 14:54:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <16.196662837@selenic.com>
Message-Id: <17.196662837@selenic.com>
Subject: [PATCH 16/20] inflate: remove legacy DEBG macros
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove legacy DEBG macros

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 22:04:23.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 22:04:27.000000000 -0700
@@ -1,5 +1,3 @@
-#define DEBG(x)
-#define DEBG1(x)
 /* inflate.c -- Not copyrighted 1992 by Mark Adler
  * version c10p1, 10 January 1993
  *
@@ -416,8 +414,6 @@ static int INIT huft_build(unsigned *b, 
 	int y;			/* number of dummy codes added */
 	unsigned z;		/* number of entries in current table */
 
-	DEBG("huft1 ");
-
 	for (i = 0; i < BMAX + 1; i++)
 		c[i] = 0;
 
@@ -435,8 +431,6 @@ static int INIT huft_build(unsigned *b, 
 		return 2;
 	}
 
-	DEBG("huft2 ");
-
 	/* Find minimum and maximum length, bound *m by those */
 	l = *m;
 	for (j = 1; j <= BMAX; j++)
@@ -455,8 +449,6 @@ static int INIT huft_build(unsigned *b, 
 		l = i;
 	*m = l;
 
-	DEBG("huft3 ");
-
 	/* Adjust last length count to fill out codes, if needed */
 	for (y = 1 << j; j < i; j++, y <<= 1) {
 		y -= c[j];
@@ -469,8 +461,6 @@ static int INIT huft_build(unsigned *b, 
 		return 2;
 	c[i] += y;
 
-	DEBG("huft4 ");
-
 	/* Generate starting offsets into the value table for each length */
 	x[1] = j = 0;
 	p = c + 1;
@@ -483,8 +473,6 @@ static int INIT huft_build(unsigned *b, 
 		xp++;
 	}
 
-	DEBG("huft5 ");
-
 	/* Make a table of values in order of bit lengths */
 	p = b;
 	i = 0;
@@ -496,8 +484,6 @@ static int INIT huft_build(unsigned *b, 
 
 	n = x[g];                   /* set n to length of v */
 
-	DEBG("h6 ");
-
 	/* Generate the Huffman codes and for each, make the table entries */
 	x[0] = i = 0; /* first Huffman code is zero */
 	p = v; /* grab values in bit order */
@@ -506,18 +492,14 @@ static int INIT huft_build(unsigned *b, 
 	u[0] = NULL; /* just to keep compilers happy */
 	q = NULL; /* ditto */
 	z = 0; /* ditto */
-	DEBG("h6a ");
 
 	/* go through the bit lengths (k already is bits in shortest code) */
 	for (; k <= g; k++) {
-		DEBG("h6b ");
 		a = c[k];
 		while (a--) {
-			DEBG("h6b1 ");
 			/* i is the Huffman code of length k for value *p */
 			/* make tables up to required level */
 			while (k > w + l) {
-				DEBG1("1 ");
 				h++;
 				w += l;	/* previous table always l bits */
 
@@ -530,7 +512,6 @@ static int INIT huft_build(unsigned *b, 
 				f = 1 << j;
 				if (f > a + 1) {
 					/* too few codes for k-w bit table */
-					DEBG1("2 ");
 					/* deduct codes from patterns left */
 					f -= a + 1;
 					xp = c + k;
@@ -547,7 +528,6 @@ static int INIT huft_build(unsigned *b, 
 					}
     				}
 
-				DEBG1("3 ");
 				/* table entries for j-bit table */
 				z = 1 << j;
 
@@ -559,13 +539,11 @@ static int INIT huft_build(unsigned *b, 
 					return 3;	/* not enough memory */
 				}
 
-				DEBG1("4 ");
 				*t = q + 1; /* link to list for huft_free */
 				t = &q->next;
 				*t = NULL;
 				u[h] = ++q;	/* table starts after link */
 
-				DEBG1("5 ");
 				/* connect to last table, if there is one */
 				if (h) {
 					/* save pattern for backing up */
@@ -581,9 +559,7 @@ static int INIT huft_build(unsigned *b, 
 					/* connect to last table */
 					u[h - 1][j] = r;
 				}
-				DEBG1("6 ");
 			}
-			DEBG("h6c ");
 
 			/* set up table entry in r */
 			r.bits = (u8)(k - w);
@@ -601,7 +577,6 @@ static int INIT huft_build(unsigned *b, 
 				r.extra = (u8)e[*p - s];
 				r.val = d[*p++ - s];
 			}
-			DEBG("h6d ");
 
 			/* fill code-like entries with r */
 			f = 1 << (k - w);
@@ -618,13 +593,9 @@ static int INIT huft_build(unsigned *b, 
 				h--;	/* don't need to update q */
 				w -= l;
 			}
-			DEBG("h6e ");
 		}
-		DEBG("h6f ");
 	}
 
-	DEBG("huft7 ");
-
 	/* Return true (1) if we were given an incomplete table */
 	return y && g != 1;
 }
@@ -713,8 +684,6 @@ static int INIT inflate_stored(struct io
 {
 	unsigned n;		/* number of bytes in block */
 
-	DEBG("<stor");
-
 	/* go to byte boundary */
 	dumpbits(io, io->bits & 7);
 
@@ -727,7 +696,6 @@ static int INIT inflate_stored(struct io
 	while (n--)
 		put_byte(io, readbyte(io));
 
-	DEBG(">");
 	return 0;
 }
 
@@ -750,8 +718,6 @@ static int noinline INIT inflate_fixed(s
 	int bd;			/* lookup bits for td */
 	unsigned l[N_MAX];	/* length list for huft_build */
 
-	DEBG("<fix");
-
 	/* set up literal table */
 	for (i = 0; i < 144; i++)
 		l[i] = 8;
@@ -772,7 +738,6 @@ static int noinline INIT inflate_fixed(s
 	if ((i = huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1) {
 		huft_free(tl);
 
-		DEBG(">");
 		return i;
 	}
 
@@ -806,8 +771,6 @@ static int noinline INIT inflate_dynamic
 	unsigned nd;		/* number of distance codes */
 	unsigned ll[286 + 30];	/* literal/length and distance code lengths */
 
-	DEBG("<dyn");
-
 	/* read in table lengths */
 	nl = 257 + pullbits(io, 5); /* number of literal/length codes */
 	nd = 1 + pullbits(io, 5); /* number of distance codes */
@@ -815,16 +778,12 @@ static int noinline INIT inflate_dynamic
 	if (nl > 286 || nd > 30)
 		return 1;	/* bad lengths */
 
-	DEBG("dyn1 ");
-
 	/* read in bit-length-code lengths */
 	for (j = 0; j < nb; j++)
 		ll[border[j]] = pullbits(io, 3);
 	for (; j < 19; j++)
 		ll[border[j]] = 0;
 
-	DEBG("dyn2 ");
-
 	/* build decoding table for trees--single level, 7 bit lookup */
 	bl = 7;
 	if ((i = huft_build(ll, 19, 19, 0, 0, &tl, &bl))) {
@@ -833,8 +792,6 @@ static int noinline INIT inflate_dynamic
 		return i;	/* incomplete code set */
 	}
 
-	DEBG("dyn3 ");
-
 	/* read in literal and distance code lengths */
 	n = nl + nd;
 	i = l = 0;
@@ -867,29 +824,21 @@ static int noinline INIT inflate_dynamic
 		}
 	}
 
-	DEBG("dyn4 ");
-
 	/* free decoding table for trees */
 	huft_free(tl);
 
-	DEBG("dyn5 ");
-
-	DEBG("dyn5a ");
-
 	/* build the decoding tables for literal/length and distance codes */
 	bl = lbits;
 	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl))) {
-		DEBG("dyn5b ");
 		if (i == 1) {
 			io->error("incomplete literal tree");
 			huft_free(tl);
 		}
 		return i;	/* incomplete code set */
 	}
-	DEBG("dyn5c ");
+
 	bd = dbits;
 	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd))) {
-		DEBG("dyn5d ");
 		if (i == 1) {
 			io->error("incomplete distance tree");
 			huft_free(td);
@@ -898,19 +847,14 @@ static int noinline INIT inflate_dynamic
 		return i;	/* incomplete code set */
 	}
 
-	DEBG("dyn6 ");
-
 	/* decompress until an end-of-block code */
 	if (inflate_codes(io, tl, td, bl, bd))
 		return 1;
 
-	DEBG("dyn7 ");
-
 	/* free the decoding tables, return */
 	huft_free(tl);
 	huft_free(td);
 
-	DEBG(">");
 	return 0;
 }
 
@@ -922,8 +866,6 @@ static int INIT inflate_block(struct ios
 {
 	unsigned t;		/* block type */
 
-	DEBG("<blk");
-
 	*e = pullbits(io, 1); /* read in last block bit */
 	t = pullbits(io, 2); /* read in block type */
 
@@ -935,8 +877,6 @@ static int INIT inflate_block(struct ios
 	if (t == 1)
 		return inflate_fixed(io);
 
-	DEBG(">");
-
 	/* bad block type */
 	return 2;
 }
