Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVLVScd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVLVScd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVLVSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:31:57 -0500
Received: from waste.org ([64.81.244.121]:17104 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030270AbVLVS2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:19 -0500
Date: Thu, 22 Dec 2005 12:26:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <16.150843412@selenic.com>
Message-Id: <17.150843412@selenic.com>
Subject: [PATCH 16/20] inflate: remove legacy DEBG macros
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove legacy DEBG macros

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-12-21 21:46:15.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:46:28.000000000 -0600
@@ -1,5 +1,3 @@
-#define DEBG(x)
-#define DEBG1(x)
 /* inflate.c -- Not copyrighted 1992 by Mark Adler
  * version c10p1, 10 January 1993
  *
@@ -415,8 +413,6 @@ static int INIT huft_build(unsigned *b, 
 	int y;			/* number of dummy codes added */
 	unsigned z;		/* number of entries in current table */
 
-	DEBG("huft1 ");
-
 	for (i = 0; i < BMAX + 1; i++)
 		c[i] = 0;
 
@@ -434,8 +430,6 @@ static int INIT huft_build(unsigned *b, 
 		return 2;
 	}
 
-	DEBG("huft2 ");
-
 	/* Find minimum and maximum length, bound *m by those */
 	l = *m;
 	for (j = 1; j <= BMAX; j++)
@@ -454,8 +448,6 @@ static int INIT huft_build(unsigned *b, 
 		l = i;
 	*m = l;
 
-	DEBG("huft3 ");
-
 	/* Adjust last length count to fill out codes, if needed */
 	for (y = 1 << j; j < i; j++, y <<= 1) {
 		y -= c[j];
@@ -468,8 +460,6 @@ static int INIT huft_build(unsigned *b, 
 		return 2;
 	c[i] += y;
 
-	DEBG("huft4 ");
-
 	/* Generate starting offsets into the value table for each length */
 	x[1] = j = 0;
 	p = c + 1;
@@ -482,8 +472,6 @@ static int INIT huft_build(unsigned *b, 
 		xp++;
 	}
 
-	DEBG("huft5 ");
-
 	/* Make a table of values in order of bit lengths */
 	p = b;
 	i = 0;
@@ -495,8 +483,6 @@ static int INIT huft_build(unsigned *b, 
 
 	n = x[g];                   /* set n to length of v */
 
-	DEBG("h6 ");
-
 	/* Generate the Huffman codes and for each, make the table entries */
 	x[0] = i = 0; /* first Huffman code is zero */
 	p = v; /* grab values in bit order */
@@ -505,18 +491,14 @@ static int INIT huft_build(unsigned *b, 
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
 
@@ -529,7 +511,6 @@ static int INIT huft_build(unsigned *b, 
 				f = 1 << j;
 				if (f > a + 1) {
 					/* too few codes for k-w bit table */
-					DEBG1("2 ");
 					/* deduct codes from patterns left */
 					f -= a + 1;
 					xp = c + k;
@@ -546,7 +527,6 @@ static int INIT huft_build(unsigned *b, 
 					}
     				}
 
-				DEBG1("3 ");
 				/* table entries for j-bit table */
 				z = 1 << j;
 
@@ -558,13 +538,11 @@ static int INIT huft_build(unsigned *b, 
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
@@ -580,9 +558,7 @@ static int INIT huft_build(unsigned *b, 
 					/* connect to last table */
 					u[h - 1][j] = r;
 				}
-				DEBG1("6 ");
 			}
-			DEBG("h6c ");
 
 			/* set up table entry in r */
 			r.bits = (u8)(k - w);
@@ -600,7 +576,6 @@ static int INIT huft_build(unsigned *b, 
 				r.extra = (u8)e[*p - s];
 				r.val = d[*p++ - s];
 			}
-			DEBG("h6d ");
 
 			/* fill code-like entries with r */
 			f = 1 << (k - w);
@@ -617,13 +592,9 @@ static int INIT huft_build(unsigned *b, 
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
@@ -712,8 +683,6 @@ static int INIT inflate_stored(struct io
 {
 	unsigned n;		/* number of bytes in block */
 
-	DEBG("<stor");
-
 	/* go to byte boundary */
 	dumpbits(io, io->bits & 7);
 
@@ -726,7 +695,6 @@ static int INIT inflate_stored(struct io
 	while (n--)
 		put_byte(io, readbyte(io));
 
-	DEBG(">");
 	return 0;
 }
 
@@ -749,8 +717,6 @@ static int noinline INIT inflate_fixed(s
 	int bd;			/* lookup bits for td */
 	unsigned l[N_MAX];	/* length list for huft_build */
 
-	DEBG("<fix");
-
 	/* set up literal table */
 	for (i = 0; i < 144; i++)
 		l[i] = 8;
@@ -771,7 +737,6 @@ static int noinline INIT inflate_fixed(s
 	if ((i = huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1) {
 		huft_free(tl);
 
-		DEBG(">");
 		return i;
 	}
 
@@ -805,8 +770,6 @@ static int noinline INIT inflate_dynamic
 	unsigned nd;		/* number of distance codes */
 	unsigned ll[286 + 30];	/* literal/length and distance code lengths */
 
-	DEBG("<dyn");
-
 	/* read in table lengths */
 	nl = 257 + pullbits(io, 5); /* number of literal/length codes */
 	nd = 1 + pullbits(io, 5); /* number of distance codes */
@@ -814,16 +777,12 @@ static int noinline INIT inflate_dynamic
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
@@ -832,8 +791,6 @@ static int noinline INIT inflate_dynamic
 		return i;	/* incomplete code set */
 	}
 
-	DEBG("dyn3 ");
-
 	/* read in literal and distance code lengths */
 	n = nl + nd;
 	i = l = 0;
@@ -866,29 +823,21 @@ static int noinline INIT inflate_dynamic
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
@@ -897,19 +846,14 @@ static int noinline INIT inflate_dynamic
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
 
@@ -921,8 +865,6 @@ static int INIT inflate_block(struct ios
 {
 	unsigned t;		/* block type */
 
-	DEBG("<blk");
-
 	*e = pullbits(io, 1); /* read in last block bit */
 	t = pullbits(io, 2); /* read in block type */
 
@@ -934,8 +876,6 @@ static int INIT inflate_block(struct ios
 	if (t == 1)
 		return inflate_fixed(io);
 
-	DEBG(">");
-
 	/* bad block type */
 	return 2;
 }
