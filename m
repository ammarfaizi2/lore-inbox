Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVLVSey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVLVSey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVLVSea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:34:30 -0500
Received: from waste.org ([64.81.244.121]:3280 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030257AbVLVS1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:52 -0500
Date: Thu, 22 Dec 2005 12:26:24 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <1.150843412@selenic.com>
Message-Id: <2.150843412@selenic.com>
Subject: [PATCH 1/20] inflate: lindent and manual formatting changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: lindent and general reformatting

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/lib/inflate.c
===================================================================
--- tiny.orig/lib/inflate.c	2005-09-27 19:31:03.000000000 -0700
+++ tiny/lib/inflate.c	2005-09-27 19:58:58.000000000 -0700
@@ -1,17 +1,17 @@
 #define DEBG(x)
 #define DEBG1(x)
 /* inflate.c -- Not copyrighted 1992 by Mark Adler
-   version c10p1, 10 January 1993 */
-
-/* 
+ * version c10p1, 10 January 1993
+ *
  * Adapted for booting Linux by Hannu Savolainen 1993
- * based on gzip-1.0.3 
+ * based on gzip-1.0.3
  *
  * Nicolas Pitre <nico@cam.org>, 1999/04/14 :
- *   Little mods for all variable to reside either into rodata or bss segments
- *   by marking constant variables with 'const' and initializing all the others
- *   at run-time only.  This allows for the kernel uncompressor to run
- *   directly from Flash or ROM memory on embedded systems.
+ *   Little mods for all variable to reside either into rodata or bss
+ *   segments by marking constant variables with 'const' and
+ *   initializing all the others at run-time only. This allows for the
+ *   kernel uncompressor to run directly from Flash or ROM memory on
+ *   embedded systems.
  */
 
 /*
@@ -50,14 +50,13 @@
    chunks), otherwise the dynamic method is used.  In the latter case, the
    codes are customized to the probabilities in the current block, and so
    can code it much better than the pre-determined fixed codes.
- 
+
    The Huffman codes themselves are decoded using a multi-level table
    lookup, in order to maximize the speed of decoding plus the speed of
    building the decoding tables.  See the comments below that precede the
    lbits and dbits tuning parameters.
  */
 
-
 /*
    Notes beyond the 1.93a appnote.txt:
 
@@ -122,7 +121,7 @@ static char rcsid[] = "#Id: inflate.c,v 
 #ifndef INIT
 #define INIT
 #endif
-	
+
 #define slide window
 
 /* Huffman code lookup table entry--this entry is four bytes for machines
@@ -133,17 +132,16 @@ static char rcsid[] = "#Id: inflate.c,v 
    an unused code.  If a code with e == 99 is looked up, this implies an
    error in the data. */
 struct huft {
-  uch e;                /* number of extra bits or operation */
-  uch b;                /* number of bits in this code or subcode */
-  union {
-    ush n;              /* literal, length base, or distance base */
-    struct huft *t;     /* pointer to next level of table */
-  } v;
+	uch e;			/* number of extra bits or operation */
+	uch b;			/* number of bits in this code or subcode */
+	union {
+		ush n;		/* literal, length base, or distance base */
+		struct huft *t;	/* pointer to next level of table */
+	} v;
 };
 
-
 /* Function prototypes */
-STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned, 
+STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned,
 		const ush *, const ush *, struct huft **, int *));
 STATIC int INIT huft_free OF((struct huft *));
 STATIC int INIT inflate_codes OF((struct huft *, struct huft *, int, int));
@@ -153,7 +151,6 @@ STATIC int INIT inflate_dynamic OF((void
 STATIC int INIT inflate_block OF((int *));
 STATIC int INIT inflate OF((void));
 
-
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
    stream to find repeated byte strings.  This is implemented here as a
    circular buffer.  The index is updated simply by incrementing and then
@@ -167,29 +164,44 @@ STATIC int INIT inflate OF((void));
 #define flush_output(w) (wp=(w),flush_window())
 
 /* Tables for deflate from PKZIP's appnote.txt. */
-static const unsigned border[] = {    /* Order of the bit length code lengths */
-        16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
-static const ush cplens[] = {         /* Copy lengths for literal codes 257..285 */
-        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
-        35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0};
-        /* note: see note #13 above about the 258 in this list. */
-static const ush cplext[] = {         /* Extra bits for literal codes 257..285 */
-        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
-        3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99}; /* 99==invalid */
-static const ush cpdist[] = {         /* Copy offsets for distance codes 0..29 */
-        1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
-        257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
-        8193, 12289, 16385, 24577};
-static const ush cpdext[] = {         /* Extra bits for distance codes */
-        0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
-        7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
-        12, 12, 13, 13};
 
+/* Order of the bit length code lengths */
+static const unsigned border[] = {
+	16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15
+};
+
+/* Copy lengths for literal codes 257..285 */
+static const ush cplens[] = {
+	3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
+	35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
+};
+
+/* Extra bits for literal codes 257..285
+ * note: see note #13 above about the 258 in this list.
+ * 99==invalid
+ */
+static const ush cplext[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
+	3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99
+};
+
+/* Copy offsets for distance codes 0..29 */
+static const ush cpdist[] = {
+	1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
+	257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
+	8193, 12289, 16385, 24577
+};
 
+/* Extra bits for distance codes */
+static const ush cpdext[] = {
+	0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
+	7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
+	12, 12, 13, 13
+};
 
 /* Macros for inflate() bit peeking and grabbing.
    The usage is:
-   
+
         NEEDBITS(j)
         x = b & mask_bits[j];
         DUMPBITS(j)
@@ -217,19 +229,18 @@ static const ush cpdext[] = {         /*
    the stream.
  */
 
-STATIC ulg bb;                         /* bit buffer */
-STATIC unsigned bk;                    /* bits in bit buffer */
+STATIC ulg bb;			/* bit buffer */
+STATIC unsigned bk;		/* bits in bit buffer */
 
 STATIC const ush mask_bits[] = {
-    0x0000,
-    0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
-    0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
+	0x0000,
+	0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
+	0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
 };
 
 #define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (uch)v; })
-#define NEEDBITS(n) {while(k<(n)){b|=((ulg)NEXTBYTE())<<k;k+=8;}}
-#define DUMPBITS(n) {b>>=(n);k-=(n);}
-
+#define NEEDBITS(n) do {while(k<(n)){b|=((ulg)NEXTBYTE())<<k;k+=8;}} while(0)
+#define DUMPBITS(n) do {b>>=(n);k-=(n);} while(0)
 
 /*
    Huffman code decoding is performed using a multi-level table lookup.
@@ -263,771 +274,757 @@ STATIC const ush mask_bits[] = {
    possibly even between compilers.  Your mileage may vary.
  */
 
-
-STATIC const int lbits = 9;          /* bits in base literal/length lookup table */
-STATIC const int dbits = 6;          /* bits in base distance lookup table */
-
+STATIC const int lbits = 9;	/* bits in base literal/length lookup table */
+STATIC const int dbits = 6;	/* bits in base distance lookup table */
 
 /* If BMAX needs to be larger than 16, then h and x[] should be ulg. */
-#define BMAX 16         /* maximum bit length of any code (16 for explode) */
-#define N_MAX 288       /* maximum number of codes in any set */
-
+#define BMAX 16		/* maximum bit length of any code (16 for explode) */
+#define N_MAX 288	/* maximum number of codes in any set */
 
-STATIC unsigned hufts;         /* track memory usage */
+STATIC unsigned hufts;		/* track memory usage */
 
-
-STATIC int INIT huft_build(
-	unsigned *b,            /* code lengths in bits (all assumed <= BMAX) */
-	unsigned n,             /* number of codes (assumed <= N_MAX) */
-	unsigned s,             /* number of simple-valued codes (0..s-1) */
-	const ush *d,           /* list of base values for non-simple codes */
-	const ush *e,           /* list of extra bits for non-simple codes */
-	struct huft **t,        /* result: starting table */
-	int *m                  /* maximum lookup bits, returns actual */
-	)
-/* Given a list of code lengths and a maximum table size, make a set of
-   tables to decode that set of codes.  Return zero on success, one if
-   the given code set is incomplete (the tables are still built in this
-   case), two if the input is invalid (all zero length codes or an
-   oversubscribed set of lengths), and three if not enough memory. */
+/*
+ * huft-build - build a huffman decoding table
+ * @b: code lengths in bits (all assumed <= BMAX)
+ * @n: number of codes (assumed <= N_MAX)
+ * @s: number of simple-valued codes (0..s-1)
+ * @d: list of base values for non-simple codes
+ * @e: list of extra bits for non-simple codes
+ * @t: returns pointer to starting table
+ * @m: maximum lookup bits, returns actual
+ *
+ * Given a list of code lengths and a maximum table size, make a set
+ * of tables to decode that set of codes. Return zero on success, one
+ * if the given code set is incomplete (the tables are still built in
+ * this case), two if the input is invalid (all zero length codes or
+ * an oversubscribed set of lengths), and three if not enough
+ * memory.
+ */
+STATIC int INIT huft_build(unsigned *b, unsigned n, unsigned s, const ush * d,
+		      const ush * e, struct huft **t, int *m)
 {
-  unsigned a;                   /* counter for codes of length k */
-  unsigned c[BMAX+1];           /* bit length count table */
-  unsigned f;                   /* i repeats in table every f entries */
-  int g;                        /* maximum code length */
-  int h;                        /* table level */
-  register unsigned i;          /* counter, current code */
-  register unsigned j;          /* counter */
-  register int k;               /* number of bits in current code */
-  int l;                        /* bits per table (returned in m) */
-  register unsigned *p;         /* pointer into c[], b[], or v[] */
-  register struct huft *q;      /* points to current table */
-  struct huft r;                /* table entry for structure assignment */
-  struct huft *u[BMAX];         /* table stack */
-  unsigned v[N_MAX];            /* values in order of bit length */
-  register int w;               /* bits before this table == (l * h) */
-  unsigned x[BMAX+1];           /* bit offsets, then code stack */
-  unsigned *xp;                 /* pointer into x */
-  int y;                        /* number of dummy codes added */
-  unsigned z;                   /* number of entries in current table */
-
-DEBG("huft1 ");
-
-  /* Generate counts for each bit length */
-  memzero(c, sizeof(c));
-  p = b;  i = n;
-  do {
-    Tracecv(*p, (stderr, (n-i >= ' ' && n-i <= '~' ? "%c %d\n" : "0x%x %d\n"), 
-	    n-i, *p));
-    c[*p]++;                    /* assume all entries <= BMAX */
-    p++;                      /* Can't combine with above line (Solaris bug) */
-  } while (--i);
-  if (c[0] == n)                /* null input--all zero length codes */
-  {
-    *t = (struct huft *)NULL;
-    *m = 0;
-    return 2;
-  }
-
-DEBG("huft2 ");
-
-  /* Find minimum and maximum length, bound *m by those */
-  l = *m;
-  for (j = 1; j <= BMAX; j++)
-    if (c[j])
-      break;
-  k = j;                        /* minimum code length */
-  if ((unsigned)l < j)
-    l = j;
-  for (i = BMAX; i; i--)
-    if (c[i])
-      break;
-  g = i;                        /* maximum code length */
-  if ((unsigned)l > i)
-    l = i;
-  *m = l;
-
-DEBG("huft3 ");
-
-  /* Adjust last length count to fill out codes, if needed */
-  for (y = 1 << j; j < i; j++, y <<= 1)
-    if ((y -= c[j]) < 0)
-      return 2;                 /* bad input: more codes than bits */
-  if ((y -= c[i]) < 0)
-    return 2;
-  c[i] += y;
-
-DEBG("huft4 ");
-
-  /* Generate starting offsets into the value table for each length */
-  x[1] = j = 0;
-  p = c + 1;  xp = x + 2;
-  while (--i) {                 /* note that i == g from above */
-    *xp++ = (j += *p++);
-  }
-
-DEBG("huft5 ");
-
-  /* Make a table of values in order of bit lengths */
-  p = b;  i = 0;
-  do {
-    if ((j = *p++) != 0)
-      v[x[j]++] = i;
-  } while (++i < n);
-  n = x[g];                   /* set n to length of v */
-
-DEBG("h6 ");
-
-  /* Generate the Huffman codes and for each, make the table entries */
-  x[0] = i = 0;                 /* first Huffman code is zero */
-  p = v;                        /* grab values in bit order */
-  h = -1;                       /* no tables yet--level -1 */
-  w = -l;                       /* bits decoded == (l * h) */
-  u[0] = (struct huft *)NULL;   /* just to keep compilers happy */
-  q = (struct huft *)NULL;      /* ditto */
-  z = 0;                        /* ditto */
-DEBG("h6a ");
-
-  /* go through the bit lengths (k already is bits in shortest code) */
-  for (; k <= g; k++)
-  {
-DEBG("h6b ");
-    a = c[k];
-    while (a--)
-    {
-DEBG("h6b1 ");
-      /* here i is the Huffman code of length k bits for value *p */
-      /* make tables up to required level */
-      while (k > w + l)
-      {
-DEBG1("1 ");
-        h++;
-        w += l;                 /* previous table always l bits */
-
-        /* compute minimum size table less than or equal to l bits */
-        z = (z = g - w) > (unsigned)l ? l : z;  /* upper limit on table size */
-        if ((f = 1 << (j = k - w)) > a + 1)     /* try a k-w bit table */
-        {                       /* too few codes for k-w bit table */
-DEBG1("2 ");
-          f -= a + 1;           /* deduct codes from patterns left */
-          xp = c + k;
-          if (j < z)
-            while (++j < z)       /* try smaller tables up to z bits */
-            {
-              if ((f <<= 1) <= *++xp)
-                break;            /* enough codes to use up j bits */
-              f -= *xp;           /* else deduct codes from patterns */
-            }
-        }
-DEBG1("3 ");
-        z = 1 << j;             /* table entries for j-bit table */
-
-        /* allocate and link in new table */
-        if ((q = (struct huft *)malloc((z + 1)*sizeof(struct huft))) ==
-            (struct huft *)NULL)
-        {
-          if (h)
-            huft_free(u[0]);
-          return 3;             /* not enough memory */
-        }
-DEBG1("4 ");
-        hufts += z + 1;         /* track memory usage */
-        *t = q + 1;             /* link to list for huft_free() */
-        *(t = &(q->v.t)) = (struct huft *)NULL;
-        u[h] = ++q;             /* table starts after link */
-
-DEBG1("5 ");
-        /* connect to last table, if there is one */
-        if (h)
-        {
-          x[h] = i;             /* save pattern for backing up */
-          r.b = (uch)l;         /* bits to dump before this table */
-          r.e = (uch)(16 + j);  /* bits in this table */
-          r.v.t = q;            /* pointer to this table */
-          j = i >> (w - l);     /* (get around Turbo C bug) */
-          u[h-1][j] = r;        /* connect to last table */
-        }
-DEBG1("6 ");
-      }
-DEBG("h6c ");
-
-      /* set up table entry in r */
-      r.b = (uch)(k - w);
-      if (p >= v + n)
-        r.e = 99;               /* out of values--invalid code */
-      else if (*p < s)
-      {
-        r.e = (uch)(*p < 256 ? 16 : 15);    /* 256 is end-of-block code */
-        r.v.n = (ush)(*p);             /* simple code is just the value */
-	p++;                           /* one compiler does not like *p++ */
-      }
-      else
-      {
-        r.e = (uch)e[*p - s];   /* non-simple--look up in lists */
-        r.v.n = d[*p++ - s];
-      }
-DEBG("h6d ");
-
-      /* fill code-like entries with r */
-      f = 1 << (k - w);
-      for (j = i >> w; j < z; j += f)
-        q[j] = r;
-
-      /* backwards increment the k-bit code i */
-      for (j = 1 << (k - 1); i & j; j >>= 1)
-        i ^= j;
-      i ^= j;
-
-      /* backup over finished tables */
-      while ((i & ((1 << w) - 1)) != x[h])
-      {
-        h--;                    /* don't need to update q */
-        w -= l;
-      }
-DEBG("h6e ");
-    }
-DEBG("h6f ");
-  }
+	unsigned a;		/* counter for codes of length k */
+	unsigned c[BMAX + 1];	/* bit length count table */
+	unsigned f;		/* i repeats in table every f entries */
+	int g;			/* maximum code length */
+	int h;			/* table level */
+	register unsigned i;	/* counter, current code */
+	register unsigned j;	/* counter */
+	register int k;		/* number of bits in current code */
+	int l;			/* bits per table (returned in m) */
+	register unsigned *p;	/* pointer into c[], b[], or v[] */
+	register struct huft *q;	/* points to current table */
+	struct huft r;		/* table entry for structure assignment */
+	struct huft *u[BMAX];	/* table stack */
+	unsigned v[N_MAX];	/* values in order of bit length */
+	register int w;		/* bits before this table == (l * h) */
+	unsigned x[BMAX + 1];	/* bit offsets, then code stack */
+	unsigned *xp;		/* pointer into x */
+	int y;			/* number of dummy codes added */
+	unsigned z;		/* number of entries in current table */
+
+	DEBG("huft1 ");
+
+	/* Generate counts for each bit length */
+	memzero(c, sizeof(c));
+	p = b;
+	i = n;
+	do {
+		Tracecv(*p, (stderr, (n - i >= ' ' && n - i <= '~' ?
+				      "%c %d\n" : "0x%x %d\n"), n - i, *p));
+		c[*p]++;	/* assume all entries <= BMAX */
+		p++;
+	} while (--i);
+
+	if (c[0] == n) {	/* null input--all zero length codes */
+		*t = (struct huft *)NULL;
+		*m = 0;
+		return 2;
+	}
+
+	DEBG("huft2 ");
+
+	/* Find minimum and maximum length, bound *m by those */
+	l = *m;
+	for (j = 1; j <= BMAX; j++)
+		if (c[j])
+			break;
+	k = j; /* minimum code length */
+
+	if ((unsigned)l < j)
+		l = j;
+	for (i = BMAX; i; i--)
+		if (c[i])
+			break;
+	g = i; /* maximum code length */
+
+	if ((unsigned)l > i)
+		l = i;
+	*m = l;
+
+	DEBG("huft3 ");
+
+	/* Adjust last length count to fill out codes, if needed */
+	for (y = 1 << j; j < i; j++, y <<= 1)
+		if ((y -= c[j]) < 0)
+			return 2; /* bad input: more codes than bits */
+
+	if ((y -= c[i]) < 0)
+		return 2;
+	c[i] += y;
+
+	DEBG("huft4 ");
+
+	/* Generate starting offsets into the value table for each length */
+	x[1] = j = 0;
+	p = c + 1;
+	xp = x + 2;
+	/* note that i == g from above */
+	while (--i)
+		*xp++ = (j += *p++);
+
+	DEBG("huft5 ");
+
+	/* Make a table of values in order of bit lengths */
+	p = b;
+	i = 0;
+	do {
+		if ((j = *p++) != 0)
+			v[x[j]++] = i;
+	} while (++i < n);
+
+	n = x[g];                   /* set n to length of v */
+
+	DEBG("h6 ");
+
+	/* Generate the Huffman codes and for each, make the table entries */
+	x[0] = i = 0; /* first Huffman code is zero */
+	p = v; /* grab values in bit order */
+	h = -1; /* no tables yet--level -1 */
+	w = -l;	/* bits decoded == (l * h) */
+	u[0] = (struct huft *)NULL; /* just to keep compilers happy */
+	q = (struct huft *)NULL; /* ditto */
+	z = 0; /* ditto */
+	DEBG("h6a ");
+
+	/* go through the bit lengths (k already is bits in shortest code) */
+	for (; k <= g; k++) {
+		DEBG("h6b ");
+		a = c[k];
+		while (a--) {
+			DEBG("h6b1 ");
+			/* i is the Huffman code of length k for value *p */
+			/* make tables up to required level */
+			while (k > w + l) {
+				DEBG1("1 ");
+				h++;
+				w += l;	/* previous table always l bits */
+
+				/* compute min size <= l bits */
+				/* upper limit on table size */
+				z = (z = g - w) > (unsigned)l ? l : z;
+
+				/* try a k-w bit table */
+				if ((f = 1 << (j = k - w)) > a + 1) {
+					/* too few codes for k-w bit table */
+					DEBG1("2 ");
+					/* deduct codes from patterns left */
+					f -= a + 1;
+					xp = c + k;
+					/* try smaller tables up to z bits */
+					if (j < z) {
+						/* enough codes for j bits? */
+						while (++j < z) {
+							if ((f <<= 1) <= *++xp)
+								break;
+							/* deduct from pats */
+							f -= *xp;
+						}
+					}
+    				}
+
+				DEBG1("3 ");
+				/* table entries for j-bit table */
+				z = 1 << j;
+
+				/* allocate and link in new table */
+				if ((q = (struct huft *)malloc(
+					     (z + 1) * sizeof(struct huft)))
+				    == (struct huft *)NULL) {
+					if (h)
+						huft_free(u[0]);
+					return 3;	/* not enough memory */
+				}
+				DEBG1("4 ");
+				hufts += z + 1;	/* track memory usage */
+				*t = q + 1; /* link to list for huft_free */
+				*(t = &(q->v.t)) = (struct huft *)NULL;
+				u[h] = ++q;	/* table starts after link */
+
+				DEBG1("5 ");
+				/* connect to last table, if there is one */
+				if (h) {
+					/* save pattern for backing up */
+					x[h] = i;
+					/* bits to dump before this table */
+					r.b = (uch)l;
+					/* bits in this table */
+					r.e = (uch)(16 + j);
+					/* pointer to this table */
+					r.v.t = q;
+					/* (get around Turbo C bug) */
+					j = i >> (w - l);
+					/* connect to last table */
+					u[h - 1][j] = r;
+				}
+				DEBG1("6 ");
+			}
+			DEBG("h6c ");
+
+			/* set up table entry in r */
+			r.b = (uch) (k - w);
+			if (p >= v + n)
+				r.e = 99; /* out of values--invalid code */
+			else if (*p < s) {
+				/* 256 is end-of-block code */
+				r.e = (uch) (*p < 256 ? 16 : 15);
+				/* simple code is just the value */
+				r.v.n = (ush) (*p);
+				/* one compiler does not like *p++ */
+				p++;
+			} else {
+				/* non-simple--look up in lists */
+				r.e = (uch)e[*p - s];
+				r.v.n = d[*p++ - s];
+			}
+			DEBG("h6d ");
+
+			/* fill code-like entries with r */
+			f = 1 << (k - w);
+			for (j = i >> w; j < z; j += f)
+				q[j] = r;
+
+			/* backwards increment the k-bit code i */
+			for (j = 1 << (k - 1); i & j; j >>= 1)
+				i ^= j;
+			i ^= j;
+
+			/* backup over finished tables */
+			while ((i & ((1 << w) - 1)) != x[h]) {
+				h--;	/* don't need to update q */
+				w -= l;
+			}
+			DEBG("h6e ");
+		}
+		DEBG("h6f ");
+	}
 
-DEBG("huft7 ");
+	DEBG("huft7 ");
 
-  /* Return true (1) if we were given an incomplete table */
-  return y != 0 && g != 1;
+	/* Return true (1) if we were given an incomplete table */
+	return y != 0 && g != 1;
 }
 
-
-
-STATIC int INIT huft_free(
-	struct huft *t         /* table to free */
-	)
-/* Free the malloc'ed tables built by huft_build(), which makes a linked
-   list of the tables it made, with the links in a dummy first entry of
-   each table. */
+/*
+ * huft_free - free a huffman table
+ * @t: table to free
+ *
+ * Free the malloc'ed tables built by huft_build(), which makes a
+ * linked list of the tables it made, with the links in a dummy first
+ * entry of each table.
+ */
+STATIC int INIT huft_free(struct huft *t)
 {
-  register struct huft *p, *q;
+	register struct huft *p, *q;
 
-
-  /* Go through linked list, freeing from the malloced (t[-1]) address. */
-  p = t;
-  while (p != (struct huft *)NULL)
-  {
-    q = (--p)->v.t;
-    free((char*)p);
-    p = q;
-  } 
-  return 0;
+	/* Go through list, freeing from the malloced (t[-1]) address. */
+	p = t;
+	while (p != (struct huft *)NULL) {
+		q = (--p)->v.t;
+		free((char *)p);
+		p = q;
+	}
+	return 0;
 }
 
-
-STATIC int INIT inflate_codes(
-	struct huft *tl,    /* literal/length decoder tables */
-	struct huft *td,    /* distance decoder tables */
-	int bl,             /* number of bits decoded by tl[] */
-	int bd              /* number of bits decoded by td[] */
-	)
-/* inflate (decompress) the codes in a deflated (compressed) block.
-   Return an error code or zero if it all goes ok. */
+/*
+ * inflate_codes - decompress the codes in a deflated block
+ * @tl: literal/length decoder tables
+ * @td: distance decoder tables
+ * @bl: number of bits decoded by tl
+ * @bd: number of bits decoded by td
+ *
+ * inflate (decompress) the codes in a deflated (compressed) block.
+ * Return an error code or zero if it all goes ok.
+ */
+STATIC int inflate_codes(struct huft *tl, struct huft *td, int bl, int bd)
 {
-  register unsigned e;  /* table entry flag/number of extra bits */
-  unsigned n, d;        /* length and index for copy */
-  unsigned w;           /* current window position */
-  struct huft *t;       /* pointer to table entry */
-  unsigned ml, md;      /* masks for bl and bd bits */
-  register ulg b;       /* bit buffer */
-  register unsigned k;  /* number of bits in bit buffer */
-
-
-  /* make local copies of globals */
-  b = bb;                       /* initialize bit buffer */
-  k = bk;
-  w = wp;                       /* initialize window position */
-
-  /* inflate the coded data */
-  ml = mask_bits[bl];           /* precompute masks for speed */
-  md = mask_bits[bd];
-  for (;;)                      /* do until end of block */
-  {
-    NEEDBITS((unsigned)bl)
-    if ((e = (t = tl + ((unsigned)b & ml))->e) > 16)
-      do {
-        if (e == 99)
-          return 1;
-        DUMPBITS(t->b)
-        e -= 16;
-        NEEDBITS(e)
-      } while ((e = (t = t->v.t + ((unsigned)b & mask_bits[e]))->e) > 16);
-    DUMPBITS(t->b)
-    if (e == 16)                /* then it's a literal */
-    {
-      slide[w++] = (uch)t->v.n;
-      Tracevv((stderr, "%c", slide[w-1]));
-      if (w == WSIZE)
-      {
-        flush_output(w);
-        w = 0;
-      }
-    }
-    else                        /* it's an EOB or a length */
-    {
-      /* exit if end of block */
-      if (e == 15)
-        break;
-
-      /* get length of block to copy */
-      NEEDBITS(e)
-      n = t->v.n + ((unsigned)b & mask_bits[e]);
-      DUMPBITS(e);
-
-      /* decode distance of block to copy */
-      NEEDBITS((unsigned)bd)
-      if ((e = (t = td + ((unsigned)b & md))->e) > 16)
-        do {
-          if (e == 99)
-            return 1;
-          DUMPBITS(t->b)
-          e -= 16;
-          NEEDBITS(e)
-        } while ((e = (t = t->v.t + ((unsigned)b & mask_bits[e]))->e) > 16);
-      DUMPBITS(t->b)
-      NEEDBITS(e)
-      d = w - t->v.n - ((unsigned)b & mask_bits[e]);
-      DUMPBITS(e)
-      Tracevv((stderr,"\\[%d,%d]", w-d, n));
-
-      /* do the copy */
-      do {
-        n -= (e = (e = WSIZE - ((d &= WSIZE-1) > w ? d : w)) > n ? n : e);
+	register unsigned e;	/* table entry flag/number of extra bits */
+	unsigned n, d;		/* length and index for copy */
+	unsigned w;		/* current window position */
+	struct huft *t;		/* pointer to table entry */
+	unsigned ml, md;	/* masks for bl and bd bits */
+	register ulg b;		/* bit buffer */
+	register unsigned k;	/* number of bits in bit buffer */
+
+	/* make local copies of globals */
+	b = bb;			/* initialize bit buffer */
+	k = bk;
+	w = wp;			/* initialize window position */
+
+	/* inflate the coded data */
+	ml = mask_bits[bl];	/* precompute masks for speed */
+	md = mask_bits[bd];
+	for (;;) {		/* do until end of block */
+		NEEDBITS((unsigned)bl);
+		if ((e = (t = tl + ((unsigned)b & ml))->e) > 16)
+			do {
+				if (e == 99)
+					return 1;
+				DUMPBITS(t->b);
+				e -= 16;
+				NEEDBITS(e);
+			} while ((e = (t = t->v.t + ((unsigned)b &
+						     mask_bits[e]))->e) > 16);
+		DUMPBITS(t->b);
+		if (e == 16) {	/* then it's a literal */
+			slide[w++] = (uch)t->v.n;
+			Tracevv((stderr, "%c", slide[w - 1]));
+			if (w == WSIZE) {
+				flush_output(w);
+				w = 0;
+			}
+		} else {	/* it's an EOB or a length */
+			/* exit if end of block */
+			if (e == 15)
+				break;
+
+			/* get length of block to copy */
+			NEEDBITS(e);
+			n = t->v.n + ((unsigned)b & mask_bits[e]);
+			DUMPBITS(e);
+
+			/* decode distance of block to copy */
+			NEEDBITS((unsigned)bd);
+			if ((e = (t = td + ((unsigned)b & md))->e) > 16)
+				do {
+					if (e == 99)
+						return 1;
+					DUMPBITS(t->b);
+					e -= 16;
+					NEEDBITS(e);
+				} while ((e = (t = t->v.t + ((unsigned)b
+					   & mask_bits[e]))->e) > 16);
+			DUMPBITS(t->b);
+			NEEDBITS(e);
+			d = w - t->v.n - ((unsigned)b & mask_bits[e]);
+			DUMPBITS(e)
+			    Tracevv((stderr, "\\[%d,%d]", w - d, n));
+
+			/* do the copy */
+			do {
+				n -= (e = (e = WSIZE - ((d &= WSIZE - 1) > w ?
+							d : w)) > n ? n : e);
 #if !defined(NOMEMCPY) && !defined(DEBUG)
-        if (w - d >= e)         /* (this test assumes unsigned comparison) */
-        {
-          memcpy(slide + w, slide + d, e);
-          w += e;
-          d += e;
-        }
-        else                      /* do it slow to avoid memcpy() overlap */
-#endif /* !NOMEMCPY */
-          do {
-            slide[w++] = slide[d++];
-	    Tracevv((stderr, "%c", slide[w-1]));
-          } while (--e);
-        if (w == WSIZE)
-        {
-          flush_output(w);
-          w = 0;
-        }
-      } while (n);
-    }
-  }
-
-
-  /* restore the globals from the locals */
-  wp = w;                       /* restore global window pointer */
-  bb = b;                       /* restore global bit buffer */
-  bk = k;
+				/* (this test assumes unsigned comparison) */
+				if (w - d >= e) {
+					memcpy(slide + w, slide + d, e);
+					w += e;
+					d += e;
+				} else
+#endif				/* !NOMEMCPY */
+					/* avoid memcpy() overlap */
+					do {
+						slide[w++] = slide[d++];
+						Tracevv((stderr, "%c",
+							 slide[w - 1]));
+					} while (--e);
+				if (w == WSIZE) {
+					flush_output(w);
+					w = 0;
+				}
+			} while (n);
+		}
+	}
+
+	/* restore the globals from the locals */
+	wp = w;			/* restore global window pointer */
+	bb = b;			/* restore global bit buffer */
+	bk = k;
 
-  /* done */
-  return 0;
+	/* done */
+	return 0;
 
- underrun:
-  return 4;			/* Input underrun */
+      underrun:
+	return 4;		/* Input underrun */
 }
 
-
-
+/* inflate_stored - "decompress" an inflated type 0 (stored) block. */
 STATIC int INIT inflate_stored(void)
-/* "decompress" an inflated type 0 (stored) block. */
 {
-  unsigned n;           /* number of bytes in block */
-  unsigned w;           /* current window position */
-  register ulg b;       /* bit buffer */
-  register unsigned k;  /* number of bits in bit buffer */
-
-DEBG("<stor");
-
-  /* make local copies of globals */
-  b = bb;                       /* initialize bit buffer */
-  k = bk;
-  w = wp;                       /* initialize window position */
-
-
-  /* go to byte boundary */
-  n = k & 7;
-  DUMPBITS(n);
-
-
-  /* get the length and its complement */
-  NEEDBITS(16)
-  n = ((unsigned)b & 0xffff);
-  DUMPBITS(16)
-  NEEDBITS(16)
-  if (n != (unsigned)((~b) & 0xffff))
-    return 1;                   /* error in compressed data */
-  DUMPBITS(16)
-
-
-  /* read and output the compressed data */
-  while (n--)
-  {
-    NEEDBITS(8)
-    slide[w++] = (uch)b;
-    if (w == WSIZE)
-    {
-      flush_output(w);
-      w = 0;
-    }
-    DUMPBITS(8)
-  }
-
-
-  /* restore the globals from the locals */
-  wp = w;                       /* restore global window pointer */
-  bb = b;                       /* restore global bit buffer */
-  bk = k;
+	unsigned n;		/* number of bytes in block */
+	unsigned w;		/* current window position */
+	register ulg b;		/* bit buffer */
+	register unsigned k;	/* number of bits in bit buffer */
+
+	DEBG("<stor");
+
+	/* make local copies of globals */
+	b = bb;			/* initialize bit buffer */
+	k = bk;
+	w = wp;			/* initialize window position */
+
+	/* go to byte boundary */
+	n = k & 7;
+	DUMPBITS(n);
+
+	/* get the length and its complement */
+	NEEDBITS(16);
+	n = ((unsigned)b & 0xffff);
+	DUMPBITS(16);
+	NEEDBITS(16);
+	if (n != (unsigned)((~b) & 0xffff))
+		return 1;	/* error in compressed data */
+	DUMPBITS(16);
+
+	/* read and output the compressed data */
+	while (n--) {
+		NEEDBITS(8);
+		slide[w++] = (uch)b;
+		if (w == WSIZE) {
+			flush_output(w);
+			w = 0;
+		}
+		DUMPBITS(8);
+	}
+
+	/* restore the globals from the locals */
+	wp = w;			/* restore global window pointer */
+	bb = b;			/* restore global bit buffer */
+	bk = k;
 
-  DEBG(">");
-  return 0;
+	DEBG(">");
+	return 0;
 
- underrun:
-  return 4;			/* Input underrun */
+      underrun:
+	return 4;		/* Input underrun */
 }
 
 
-/*
+/* inflate_fixed - decompress a block with fixed Huffman codes
+ *
+ * decompress an inflated type 1 (fixed Huffman codes) block. We
+ * should either replace this with a custom decoder, or at least
+ * precompute the Huffman tables.
+ *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
 STATIC int noinline INIT inflate_fixed(void)
-/* decompress an inflated type 1 (fixed Huffman codes) block.  We should
-   either replace this with a custom decoder, or at least precompute the
-   Huffman tables. */
 {
-  int i;                /* temporary variable */
-  struct huft *tl;      /* literal/length code table */
-  struct huft *td;      /* distance code table */
-  int bl;               /* lookup bits for tl */
-  int bd;               /* lookup bits for td */
-  unsigned l[288];      /* length list for huft_build */
-
-DEBG("<fix");
-
-  /* set up literal table */
-  for (i = 0; i < 144; i++)
-    l[i] = 8;
-  for (; i < 256; i++)
-    l[i] = 9;
-  for (; i < 280; i++)
-    l[i] = 7;
-  for (; i < 288; i++)          /* make a complete, but wrong code set */
-    l[i] = 8;
-  bl = 7;
-  if ((i = huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) != 0)
-    return i;
-
-
-  /* set up distance table */
-  for (i = 0; i < 30; i++)      /* make an incomplete code set */
-    l[i] = 5;
-  bd = 5;
-  if ((i = huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1)
-  {
-    huft_free(tl);
-
-    DEBG(">");
-    return i;
-  }
-
-
-  /* decompress until an end-of-block code */
-  if (inflate_codes(tl, td, bl, bd))
-    return 1;
-
-
-  /* free the decoding tables, return */
-  huft_free(tl);
-  huft_free(td);
-  return 0;
+	int i;			/* temporary variable */
+	struct huft *tl;	/* literal/length code table */
+	struct huft *td;	/* distance code table */
+	int bl;			/* lookup bits for tl */
+	int bd;			/* lookup bits for td */
+	unsigned l[288];	/* length list for huft_build */
+
+	DEBG("<fix");
+
+	/* set up literal table */
+	for (i = 0; i < 144; i++)
+		l[i] = 8;
+	for (; i < 256; i++)
+		l[i] = 9;
+	for (; i < 280; i++)
+		l[i] = 7;
+	for (; i < 288; i++)	/* make a complete, but wrong code set */
+		l[i] = 8;
+	bl = 7;
+	if ((i = huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) != 0)
+		return i;
+
+	/* set up distance table */
+	for (i = 0; i < 30; i++)	/* make an incomplete code set */
+		l[i] = 5;
+	bd = 5;
+	if ((i = huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1) {
+		huft_free(tl);
+
+		DEBG(">");
+		return i;
+	}
+
+	/* decompress until an end-of-block code */
+	if (inflate_codes(tl, td, bl, bd))
+		return 1;
+
+	/* free the decoding tables, return */
+	huft_free(tl);
+	huft_free(td);
+	return 0;
 }
 
 
-/*
+/* inflate_dynamic - decompress a type 2 (dynamic Huffman codes) block.
+ *
  * We use `noinline' here to prevent gcc-3.5 from using too much stack space
  */
 STATIC int noinline INIT inflate_dynamic(void)
-/* decompress an inflated type 2 (dynamic Huffman codes) block. */
 {
-  int i;                /* temporary variables */
-  unsigned j;
-  unsigned l;           /* last length */
-  unsigned m;           /* mask for bit lengths table */
-  unsigned n;           /* number of lengths to get */
-  struct huft *tl;      /* literal/length code table */
-  struct huft *td;      /* distance code table */
-  int bl;               /* lookup bits for tl */
-  int bd;               /* lookup bits for td */
-  unsigned nb;          /* number of bit length codes */
-  unsigned nl;          /* number of literal/length codes */
-  unsigned nd;          /* number of distance codes */
+	int i;			/* temporary variables */
+	unsigned j;
+	unsigned l;		/* last length */
+	unsigned m;		/* mask for bit lengths table */
+	unsigned n;		/* number of lengths to get */
+	struct huft *tl;	/* literal/length code table */
+	struct huft *td;	/* distance code table */
+	int bl;			/* lookup bits for tl */
+	int bd;			/* lookup bits for td */
+	unsigned nb;		/* number of bit length codes */
+	unsigned nl;		/* number of literal/length codes */
+	unsigned nd;		/* number of distance codes */
 #ifdef PKZIP_BUG_WORKAROUND
-  unsigned ll[288+32];  /* literal/length and distance code lengths */
+	unsigned ll[288 + 32];	/* literal/length and distance code lengths */
 #else
-  unsigned ll[286+30];  /* literal/length and distance code lengths */
+	unsigned ll[286 + 30];	/* literal/length and distance code lengths */
 #endif
-  register ulg b;       /* bit buffer */
-  register unsigned k;  /* number of bits in bit buffer */
+	register ulg b;		/* bit buffer */
+	register unsigned k;	/* number of bits in bit buffer */
 
-DEBG("<dyn");
+	DEBG("<dyn");
 
-  /* make local bit buffer */
-  b = bb;
-  k = bk;
-
-
-  /* read in table lengths */
-  NEEDBITS(5)
-  nl = 257 + ((unsigned)b & 0x1f);      /* number of literal/length codes */
-  DUMPBITS(5)
-  NEEDBITS(5)
-  nd = 1 + ((unsigned)b & 0x1f);        /* number of distance codes */
-  DUMPBITS(5)
-  NEEDBITS(4)
-  nb = 4 + ((unsigned)b & 0xf);         /* number of bit length codes */
-  DUMPBITS(4)
+	/* make local bit buffer */
+	b = bb;
+	k = bk;
+
+	/* read in table lengths */
+	NEEDBITS(5);
+	nl = 257 + ((unsigned)b & 0x1f); /* number of literal/length codes */
+	DUMPBITS(5);
+	NEEDBITS(5);
+	nd = 1 + ((unsigned)b & 0x1f);	/* number of distance codes */
+	DUMPBITS(5);
+	NEEDBITS(4);
+	nb = 4 + ((unsigned)b & 0xf);	/* number of bit length codes */
+	DUMPBITS(4);
 #ifdef PKZIP_BUG_WORKAROUND
-  if (nl > 288 || nd > 32)
+	if (nl > 288 || nd > 32)
 #else
-  if (nl > 286 || nd > 30)
+	if (nl > 286 || nd > 30)
 #endif
-    return 1;                   /* bad lengths */
+		return 1;	/* bad lengths */
 
-DEBG("dyn1 ");
+	DEBG("dyn1 ");
 
-  /* read in bit-length-code lengths */
-  for (j = 0; j < nb; j++)
-  {
-    NEEDBITS(3)
-    ll[border[j]] = (unsigned)b & 7;
-    DUMPBITS(3)
-  }
-  for (; j < 19; j++)
-    ll[border[j]] = 0;
-
-DEBG("dyn2 ");
-
-  /* build decoding table for trees--single level, 7 bit lookup */
-  bl = 7;
-  if ((i = huft_build(ll, 19, 19, NULL, NULL, &tl, &bl)) != 0)
-  {
-    if (i == 1)
-      huft_free(tl);
-    return i;                   /* incomplete code set */
-  }
-
-DEBG("dyn3 ");
-
-  /* read in literal and distance code lengths */
-  n = nl + nd;
-  m = mask_bits[bl];
-  i = l = 0;
-  while ((unsigned)i < n)
-  {
-    NEEDBITS((unsigned)bl)
-    j = (td = tl + ((unsigned)b & m))->b;
-    DUMPBITS(j)
-    j = td->v.n;
-    if (j < 16)                 /* length of code in bits (0..15) */
-      ll[i++] = l = j;          /* save last length in l */
-    else if (j == 16)           /* repeat last length 3 to 6 times */
-    {
-      NEEDBITS(2)
-      j = 3 + ((unsigned)b & 3);
-      DUMPBITS(2)
-      if ((unsigned)i + j > n)
-        return 1;
-      while (j--)
-        ll[i++] = l;
-    }
-    else if (j == 17)           /* 3 to 10 zero length codes */
-    {
-      NEEDBITS(3)
-      j = 3 + ((unsigned)b & 7);
-      DUMPBITS(3)
-      if ((unsigned)i + j > n)
-        return 1;
-      while (j--)
-        ll[i++] = 0;
-      l = 0;
-    }
-    else                        /* j == 18: 11 to 138 zero length codes */
-    {
-      NEEDBITS(7)
-      j = 11 + ((unsigned)b & 0x7f);
-      DUMPBITS(7)
-      if ((unsigned)i + j > n)
-        return 1;
-      while (j--)
-        ll[i++] = 0;
-      l = 0;
-    }
-  }
-
-DEBG("dyn4 ");
-
-  /* free decoding table for trees */
-  huft_free(tl);
-
-DEBG("dyn5 ");
-
-  /* restore the global bit buffer */
-  bb = b;
-  bk = k;
-
-DEBG("dyn5a ");
-
-  /* build the decoding tables for literal/length and distance codes */
-  bl = lbits;
-  if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl)) != 0)
-  {
-DEBG("dyn5b ");
-    if (i == 1) {
-      error("incomplete literal tree");
-      huft_free(tl);
-    }
-    return i;                   /* incomplete code set */
-  }
-DEBG("dyn5c ");
-  bd = dbits;
-  if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd)) != 0)
-  {
-DEBG("dyn5d ");
-    if (i == 1) {
-      error("incomplete distance tree");
+	/* read in bit-length-code lengths */
+	for (j = 0; j < nb; j++) {
+		NEEDBITS(3);
+		ll[border[j]] = (unsigned)b & 7;
+		DUMPBITS(3);
+	}
+	for (; j < 19; j++)
+		ll[border[j]] = 0;
+
+	DEBG("dyn2 ");
+
+	/* build decoding table for trees--single level, 7 bit lookup */
+	bl = 7;
+	if ((i = huft_build(ll, 19, 19, NULL, NULL, &tl, &bl)) != 0) {
+		if (i == 1)
+			huft_free(tl);
+		return i;	/* incomplete code set */
+	}
+
+	DEBG("dyn3 ");
+
+	/* read in literal and distance code lengths */
+	n = nl + nd;
+	m = mask_bits[bl];
+	i = l = 0;
+	while ((unsigned)i < n) {
+		NEEDBITS((unsigned)bl);
+		j = (td = tl + ((unsigned)b & m))->b;
+		DUMPBITS(j);
+		j = td->v.n;
+		if (j < 16)	/* length of code in bits (0..15) */
+			ll[i++] = l = j;	/* save last length in l */
+		else if (j == 16) {	/* repeat last length 3 to 6 times */
+			NEEDBITS(2);
+			j = 3 + ((unsigned)b & 3);
+			DUMPBITS(2);
+			    if ((unsigned)i + j > n)
+				return 1;
+			while (j--)
+				ll[i++] = l;
+		} else if (j == 17) {	/* 3 to 10 zero length codes */
+			NEEDBITS(3);
+			j = 3 + ((unsigned)b & 7);
+			DUMPBITS(3);
+			if ((unsigned)i + j > n)
+				return 1;
+			while (j--)
+				ll[i++] = 0;
+			l = 0;
+		} else {	/* j == 18: 11 to 138 zero length codes */
+			NEEDBITS(7);
+			j = 11 + ((unsigned)b & 0x7f);
+			DUMPBITS(7);
+			if ((unsigned)i + j > n)
+				return 1;
+			while (j--)
+				ll[i++] = 0;
+			l = 0;
+		}
+	}
+
+	DEBG("dyn4 ");
+
+	/* free decoding table for trees */
+	huft_free(tl);
+
+	DEBG("dyn5 ");
+
+	/* restore the global bit buffer */
+	bb = b;
+	bk = k;
+
+	DEBG("dyn5a ");
+
+	/* build the decoding tables for literal/length and distance codes */
+	bl = lbits;
+	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl)) != 0) {
+		DEBG("dyn5b ");
+		if (i == 1) {
+			error("incomplete literal tree");
+			huft_free(tl);
+		}
+		return i;	/* incomplete code set */
+	}
+	DEBG("dyn5c ");
+	bd = dbits;
+	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd)) != 0) {
+		DEBG("dyn5d ");
+		if (i == 1) {
+			error("incomplete distance tree");
 #ifdef PKZIP_BUG_WORKAROUND
-      i = 0;
-    }
+			i = 0;
+		}
 #else
-      huft_free(td);
-    }
-    huft_free(tl);
-    return i;                   /* incomplete code set */
+			huft_free(td);
+		}
+		huft_free(tl);
+		return i;	/* incomplete code set */
 #endif
-  }
+	}
 
-DEBG("dyn6 ");
+	DEBG("dyn6 ");
 
-  /* decompress until an end-of-block code */
-  if (inflate_codes(tl, td, bl, bd))
-    return 1;
+	/* decompress until an end-of-block code */
+	if (inflate_codes(tl, td, bl, bd))
+		return 1;
 
-DEBG("dyn7 ");
+	DEBG("dyn7 ");
 
-  /* free the decoding tables, return */
-  huft_free(tl);
-  huft_free(td);
+	/* free the decoding tables, return */
+	huft_free(tl);
+	huft_free(td);
 
-  DEBG(">");
-  return 0;
+	DEBG(">");
+	return 0;
 
- underrun:
-  return 4;			/* Input underrun */
+      underrun:
+	return 4;		/* Input underrun */
 }
 
-
-
-STATIC int INIT inflate_block(
-	int *e                  /* last block flag */
-	)
-/* decompress an inflated block */
+/* inflate_block - decompress a deflated block
+ * @e: last block flag
+ */
+STATIC int INIT inflate_block(int *e)
 {
-  unsigned t;           /* block type */
-  register ulg b;       /* bit buffer */
-  register unsigned k;  /* number of bits in bit buffer */
+	unsigned t;		/* block type */
+	register ulg b;		/* bit buffer */
+	register unsigned k;	/* number of bits in bit buffer */
+
+	DEBG("<blk");
+
+	/* make local bit buffer */
+	b = bb;
+	k = bk;
+
+	/* read in last block bit */
+	NEEDBITS(1);
+	*e = (int)b & 1;
+	DUMPBITS(1);
+
+	/* read in block type */
+	NEEDBITS(2);
+	t = (unsigned)b & 3;
+	DUMPBITS(2);
+
+	/* restore the global bit buffer */
+	bb = b;
+	bk = k;
+
+	/* inflate that block type */
+	if (t == 2)
+		return inflate_dynamic();
+	if (t == 0)
+		return inflate_stored();
+	if (t == 1)
+		return inflate_fixed();
 
-  DEBG("<blk");
+	DEBG(">");
 
-  /* make local bit buffer */
-  b = bb;
-  k = bk;
+	/* bad block type */
+	return 2;
 
-
-  /* read in last block bit */
-  NEEDBITS(1)
-  *e = (int)b & 1;
-  DUMPBITS(1)
-
-
-  /* read in block type */
-  NEEDBITS(2)
-  t = (unsigned)b & 3;
-  DUMPBITS(2)
-
-
-  /* restore the global bit buffer */
-  bb = b;
-  bk = k;
-
-  /* inflate that block type */
-  if (t == 2)
-    return inflate_dynamic();
-  if (t == 0)
-    return inflate_stored();
-  if (t == 1)
-    return inflate_fixed();
-
-  DEBG(">");
-
-  /* bad block type */
-  return 2;
-
- underrun:
-  return 4;			/* Input underrun */
+      underrun:
+	return 4;		/* Input underrun */
 }
 
-
-
+/* inflate - decompress an inflated entry */
 STATIC int INIT inflate(void)
-/* decompress an inflated entry */
 {
-  int e;                /* last block flag */
-  int r;                /* result code */
-  unsigned h;           /* maximum struct huft's malloc'ed */
-  void *ptr;
-
-  /* initialize window, bit buffer */
-  wp = 0;
-  bk = 0;
-  bb = 0;
-
-
-  /* decompress until the last block */
-  h = 0;
-  do {
-    hufts = 0;
-    gzip_mark(&ptr);
-    if ((r = inflate_block(&e)) != 0) {
-      gzip_release(&ptr);	    
-      return r;
-    }
-    gzip_release(&ptr);
-    if (hufts > h)
-      h = hufts;
-  } while (!e);
-
-  /* Undo too much lookahead. The next read will be byte aligned so we
-   * can discard unused bits in the last meaningful byte.
-   */
-  while (bk >= 8) {
-    bk -= 8;
-    inptr--;
-  }
+	int e;			/* last block flag */
+	int r;			/* result code */
+	unsigned h;		/* maximum struct huft's malloc'ed */
+	void *ptr;
+
+	/* initialize window, bit buffer */
+	wp = 0;
+	bk = 0;
+	bb = 0;
+
+	/* decompress until the last block */
+	h = 0;
+	do {
+		hufts = 0;
+		gzip_mark(&ptr);
+		if ((r = inflate_block(&e)) != 0) {
+			gzip_release(&ptr);
+			return r;
+		}
+		gzip_release(&ptr);
+		if (hufts > h)
+			h = hufts;
+	} while (!e);
+
+	/* Undo too much lookahead. The next read will be byte aligned so we
+	 * can discard unused bits in the last meaningful byte.
+	 */
+	while (bk >= 8) {
+		bk -= 8;
+		inptr--;
+	}
 
-  /* flush out slide */
-  flush_output(wp);
+	/* flush out slide */
+	flush_output(wp);
 
-
-  /* return success */
+	/* return success */
 #ifdef DEBUG
-  fprintf(stderr, "<%u> ", h);
-#endif /* DEBUG */
-  return 0;
+	fprintf(stderr, "<%u> ", h);
+#endif				/* DEBUG */
+	return 0;
 }
 
 /**********************************************************************
@@ -1041,44 +1038,42 @@ static ulg crc;		/* initialized in makec
 #define CRC_VALUE (crc ^ 0xffffffffUL)
 
 /*
- * Code to compute the CRC-32 table. Borrowed from 
+ * Code to compute the CRC-32 table. Borrowed from
  * gzip-1.0.3/makecrc.c.
+ * Not copyrighted 1990 Mark Adler
  */
 
-static void INIT
-makecrc(void)
+static void INIT makecrc(void)
 {
-/* Not copyrighted 1990 Mark Adler	*/
 
-  unsigned long c;      /* crc shift register */
-  unsigned long e;      /* polynomial exclusive-or pattern */
-  int i;                /* counter for all possible eight bit values */
-  int k;                /* byte being shifted into crc apparatus */
-
-  /* terms of polynomial defining this crc (except x^32): */
-  static const int p[] = {0,1,2,4,5,7,8,10,11,12,16,22,23,26};
-
-  /* Make exclusive-or pattern from polynomial */
-  e = 0;
-  for (i = 0; i < sizeof(p)/sizeof(int); i++)
-    e |= 1L << (31 - p[i]);
-
-  crc_32_tab[0] = 0;
-
-  for (i = 1; i < 256; i++)
-  {
-    c = 0;
-    for (k = i | 256; k != 1; k >>= 1)
-    {
-      c = c & 1 ? (c >> 1) ^ e : c >> 1;
-      if (k & 1)
-        c ^= e;
-    }
-    crc_32_tab[i] = c;
-  }
+	unsigned long c;	/* crc shift register */
+	unsigned long e;	/* polynomial exclusive-or pattern */
+	int i;			/* counter for all possible eight bit values */
+	int k;			/* byte being shifted into crc apparatus */
+
+	/* terms of polynomial defining this crc (except x^32): */
+	static const int p[] =
+	    { 0, 1, 2, 4, 5, 7, 8, 10, 11, 12, 16, 22, 23, 26 };
+
+	/* Make exclusive-or pattern from polynomial */
+	e = 0;
+	for (i = 0; i < sizeof(p) / sizeof(int); i++)
+		e |= 1L << (31 - p[i]);
+
+	crc_32_tab[0] = 0;
+
+	for (i = 1; i < 256; i++) {
+		c = 0;
+		for (k = i | 256; k != 1; k >>= 1) {
+			c = c & 1 ? (c >> 1) ^ e : c >> 1;
+			if (k & 1)
+				c ^= e;
+		}
+		crc_32_tab[i] = c;
+	}
 
-  /* this is initialized here so this code could reside in ROM */
-  crc = (ulg)0xffffffffUL; /* shift register contents */
+	/* this is initialized here so this code could reside in ROM */
+	crc = (ulg)0xffffffffUL;	/* shift register contents */
 }
 
 /* gzip flag byte */
@@ -1095,118 +1090,118 @@ makecrc(void)
  */
 static int INIT gunzip(void)
 {
-    uch flags;
-    unsigned char magic[2]; /* magic header */
-    char method;
-    ulg orig_crc = 0;       /* original crc */
-    ulg orig_len = 0;       /* original uncompressed length */
-    int res;
-
-    magic[0] = NEXTBYTE();
-    magic[1] = NEXTBYTE();
-    method   = NEXTBYTE();
-
-    if (magic[0] != 037 ||
-	((magic[1] != 0213) && (magic[1] != 0236))) {
-	    error("bad gzip magic numbers");
-	    return -1;
-    }
-
-    /* We only support method #8, DEFLATED */
-    if (method != 8)  {
-	    error("internal error, invalid method");
-	    return -1;
-    }
-
-    flags  = (uch)get_byte();
-    if ((flags & ENCRYPTED) != 0) {
-	    error("Input is encrypted");
-	    return -1;
-    }
-    if ((flags & CONTINUATION) != 0) {
-	    error("Multi part input");
-	    return -1;
-    }
-    if ((flags & RESERVED) != 0) {
-	    error("Input has invalid flags");
-	    return -1;
-    }
-    NEXTBYTE();	/* Get timestamp */
-    NEXTBYTE();
-    NEXTBYTE();
-    NEXTBYTE();
-
-    (void)NEXTBYTE();  /* Ignore extra flags for the moment */
-    (void)NEXTBYTE();  /* Ignore OS type for the moment */
-
-    if ((flags & EXTRA_FIELD) != 0) {
-	    unsigned len = (unsigned)NEXTBYTE();
-	    len |= ((unsigned)NEXTBYTE())<<8;
-	    while (len--) (void)NEXTBYTE();
-    }
-
-    /* Get original file name if it was truncated */
-    if ((flags & ORIG_NAME) != 0) {
-	    /* Discard the old name */
-	    while (NEXTBYTE() != 0) /* null */ ;
-    } 
-
-    /* Discard file comment if any */
-    if ((flags & COMMENT) != 0) {
-	    while (NEXTBYTE() != 0) /* null */ ;
-    }
-
-    /* Decompress */
-    if ((res = inflate())) {
-	    switch (res) {
-	    case 0:
-		    break;
-	    case 1:
-		    error("invalid compressed format (err=1)");
-		    break;
-	    case 2:
-		    error("invalid compressed format (err=2)");
-		    break;
-	    case 3:
-		    error("out of memory");
-		    break;
-	    case 4:
-		    error("out of input data");
-		    break;
-	    default:
-		    error("invalid compressed format (other)");
-	    }
-	    return -1;
-    }
-	    
-    /* Get the crc and original length */
-    /* crc32  (see algorithm.doc)
-     * uncompressed input size modulo 2^32
-     */
-    orig_crc = (ulg) NEXTBYTE();
-    orig_crc |= (ulg) NEXTBYTE() << 8;
-    orig_crc |= (ulg) NEXTBYTE() << 16;
-    orig_crc |= (ulg) NEXTBYTE() << 24;
-    
-    orig_len = (ulg) NEXTBYTE();
-    orig_len |= (ulg) NEXTBYTE() << 8;
-    orig_len |= (ulg) NEXTBYTE() << 16;
-    orig_len |= (ulg) NEXTBYTE() << 24;
-    
-    /* Validate decompression */
-    if (orig_crc != CRC_VALUE) {
-	    error("crc error");
-	    return -1;
-    }
-    if (orig_len != bytes_out) {
-	    error("length error");
-	    return -1;
-    }
-    return 0;
-
- underrun:			/* NEXTBYTE() goto's here if needed */
-    error("out of input data");
-    return -1;
+	uch flags;
+	unsigned char magic[2];	/* magic header */
+	char method;
+	ulg orig_crc = 0;	/* original crc */
+	ulg orig_len = 0;	/* original uncompressed length */
+	int res;
+
+	magic[0] = NEXTBYTE();
+	magic[1] = NEXTBYTE();
+	method = NEXTBYTE();
+
+	if (magic[0] != 037 || ((magic[1] != 0213) && (magic[1] != 0236))) {
+		error("bad gzip magic numbers");
+		return -1;
+	}
+
+	/* We only support method #8, DEFLATED */
+	if (method != 8) {
+		error("internal error, invalid method");
+		return -1;
+	}
+
+	flags = (uch)get_byte();
+	if ((flags & ENCRYPTED) != 0) {
+		error("Input is encrypted");
+		return -1;
+	}
+	if ((flags & CONTINUATION) != 0) {
+		error("Multi part input");
+		return -1;
+	}
+	if ((flags & RESERVED) != 0) {
+		error("Input has invalid flags");
+		return -1;
+	}
+	NEXTBYTE();		/* Get timestamp */
+	NEXTBYTE();
+	NEXTBYTE();
+	NEXTBYTE();
+
+	(void)NEXTBYTE();	/* Ignore extra flags for the moment */
+	(void)NEXTBYTE();	/* Ignore OS type for the moment */
+
+	if ((flags & EXTRA_FIELD) != 0) {
+		unsigned len = (unsigned)NEXTBYTE();
+		len |= ((unsigned)NEXTBYTE()) << 8;
+		while (len--)
+			(void)NEXTBYTE();
+	}
+
+	/* Get original file name if it was truncated */
+	if ((flags & ORIG_NAME) != 0) {
+		/* Discard the old name */
+		while (NEXTBYTE() != 0)	/* null */
+			;
+	}
+
+	/* Discard file comment if any */
+	if ((flags & COMMENT) != 0) {
+		while (NEXTBYTE() != 0)	/* null */
+			;
+	}
+
+	/* Decompress */
+	if ((res = inflate())) {
+		switch (res) {
+		case 0:
+			break;
+		case 1:
+			error("invalid compressed format (err=1)");
+			break;
+		case 2:
+			error("invalid compressed format (err=2)");
+			break;
+		case 3:
+			error("out of memory");
+			break;
+		case 4:
+			error("out of input data");
+			break;
+		default:
+			error("invalid compressed format (other)");
+		}
+		return -1;
+	}
+
+	/* Get the crc and original length */
+	/* crc32  (see algorithm.doc)
+	 * uncompressed input size modulo 2^32
+	 */
+	orig_crc = (ulg)NEXTBYTE();
+	orig_crc |= (ulg)NEXTBYTE() << 8;
+	orig_crc |= (ulg)NEXTBYTE() << 16;
+	orig_crc |= (ulg)NEXTBYTE() << 24;
+
+	orig_len = (ulg)NEXTBYTE();
+	orig_len |= (ulg)NEXTBYTE() << 8;
+	orig_len |= (ulg)NEXTBYTE() << 16;
+	orig_len |= (ulg)NEXTBYTE() << 24;
+
+	/* Validate decompression */
+	if (orig_crc != CRC_VALUE) {
+		error("crc error");
+		return -1;
+	}
+	if (orig_len != bytes_out) {
+		error("length error");
+		return -1;
+	}
+	return 0;
+
+      underrun:		/* NEXTBYTE() goto's here if needed */
+	error("out of input data");
+	return -1;
 }
-
-
