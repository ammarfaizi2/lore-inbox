Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFFSSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTFFSSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:18:12 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52660 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262145AbTFFSSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:18:03 -0400
Date: Fri, 6 Jun 2003 20:31:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib cleanup #1 local
Message-ID: <20030606183126.GA10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Simple s/local/static/.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown

--- linux-2.5.70-bk11/lib/zlib_deflate/deftree.c~zlib_cleanup_local	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deftree.c	2003-06-06 19:45:24.000000000 +0200
@@ -60,16 +60,16 @@
 #define REPZ_11_138  18
 /* repeat a zero length 11-138 times  (7 bits of repeat count) */
 
-local const int extra_lbits[LENGTH_CODES] /* extra bits for each length code */
+static const int extra_lbits[LENGTH_CODES] /* extra bits for each length code */
    = {0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0};
 
-local const int extra_dbits[D_CODES] /* extra bits for each distance code */
+static const int extra_dbits[D_CODES] /* extra bits for each distance code */
    = {0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13};
 
-local const int extra_blbits[BL_CODES]/* extra bits for each bit length code */
+static const int extra_blbits[BL_CODES]/* extra bits for each bit length code */
    = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7};
 
-local const uch bl_order[BL_CODES]
+static const uch bl_order[BL_CODES]
    = {16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15};
 /* The lengths of the bit length codes are sent in order of decreasing
  * probability, to avoid transmitting the lengths for unused bit length codes.
@@ -84,31 +84,31 @@
  * Local data. These are initialized only once.
  */
 
-local ct_data static_ltree[L_CODES+2];
+static ct_data static_ltree[L_CODES+2];
 /* The static literal tree. Since the bit lengths are imposed, there is no
  * need for the L_CODES extra codes used during heap construction. However
  * The codes 286 and 287 are needed to build a canonical tree (see zlib_tr_init
  * below).
  */
 
-local ct_data static_dtree[D_CODES];
+static ct_data static_dtree[D_CODES];
 /* The static distance tree. (Actually a trivial tree since all codes use
  * 5 bits.)
  */
 
-local uch dist_code[512];
+static uch dist_code[512];
 /* distance codes. The first 256 values correspond to the distances
  * 3 .. 258, the last 256 values correspond to the top 8 bits of
  * the 15 bit distances.
  */
 
-local uch length_code[MAX_MATCH-MIN_MATCH+1];
+static uch length_code[MAX_MATCH-MIN_MATCH+1];
 /* length code for each normalized match length (0 == MIN_MATCH) */
 
-local int base_length[LENGTH_CODES];
+static int base_length[LENGTH_CODES];
 /* First normalized length for each code (0 = MIN_MATCH) */
 
-local int base_dist[D_CODES];
+static int base_dist[D_CODES];
 /* First normalized distance for each code (0 = distance of 1) */
 
 struct static_tree_desc_s {
@@ -119,37 +119,37 @@
     int     max_length;          /* max bit length for the codes */
 };
 
-local static_tree_desc  static_l_desc =
+static static_tree_desc  static_l_desc =
 {static_ltree, extra_lbits, LITERALS+1, L_CODES, MAX_BITS};
 
-local static_tree_desc  static_d_desc =
+static static_tree_desc  static_d_desc =
 {static_dtree, extra_dbits, 0,          D_CODES, MAX_BITS};
 
-local static_tree_desc  static_bl_desc =
+static static_tree_desc  static_bl_desc =
 {(const ct_data *)0, extra_blbits, 0,   BL_CODES, MAX_BL_BITS};
 
 /* ===========================================================================
  * Local (static) routines in this file.
  */
 
-local void tr_static_init (void);
-local void init_block     (deflate_state *s);
-local void pqdownheap     (deflate_state *s, ct_data *tree, int k);
-local void gen_bitlen     (deflate_state *s, tree_desc *desc);
-local void gen_codes      (ct_data *tree, int max_code, ush *bl_count);
-local void build_tree     (deflate_state *s, tree_desc *desc);
-local void scan_tree      (deflate_state *s, ct_data *tree, int max_code);
-local void send_tree      (deflate_state *s, ct_data *tree, int max_code);
-local int  build_bl_tree  (deflate_state *s);
-local void send_all_trees (deflate_state *s, int lcodes, int dcodes,
+static void tr_static_init (void);
+static void init_block     (deflate_state *s);
+static void pqdownheap     (deflate_state *s, ct_data *tree, int k);
+static void gen_bitlen     (deflate_state *s, tree_desc *desc);
+static void gen_codes      (ct_data *tree, int max_code, ush *bl_count);
+static void build_tree     (deflate_state *s, tree_desc *desc);
+static void scan_tree      (deflate_state *s, ct_data *tree, int max_code);
+static void send_tree      (deflate_state *s, ct_data *tree, int max_code);
+static int  build_bl_tree  (deflate_state *s);
+static void send_all_trees (deflate_state *s, int lcodes, int dcodes,
                            int blcodes);
-local void compress_block (deflate_state *s, ct_data *ltree,
+static void compress_block (deflate_state *s, ct_data *ltree,
                            ct_data *dtree);
-local void set_data_type  (deflate_state *s);
-local unsigned bi_reverse (unsigned value, int length);
-local void bi_windup      (deflate_state *s);
-local void bi_flush       (deflate_state *s);
-local void copy_block     (deflate_state *s, char *buf, unsigned len,
+static void set_data_type  (deflate_state *s);
+static unsigned bi_reverse (unsigned value, int length);
+static void bi_windup      (deflate_state *s);
+static void bi_flush       (deflate_state *s);
+static void copy_block     (deflate_state *s, char *buf, unsigned len,
                            int header);
 
 #ifndef DEBUG_ZLIB
@@ -174,9 +174,9 @@
  * IN assertion: length <= 16 and value fits in length bits.
  */
 #ifdef DEBUG_ZLIB
-local void send_bits      (deflate_state *s, int value, int length);
+static void send_bits      (deflate_state *s, int value, int length);
 
-local void send_bits(
+static void send_bits(
 	deflate_state *s,
 	int value,  /* value to send */
 	int length  /* number of bits */
@@ -226,7 +226,7 @@
  * this function may be called by two threads concurrently, but this is
  * harmless since both invocations do exactly the same thing.
  */
-local void tr_static_init()
+static void tr_static_init()
 {
     static int static_init_done = 0;
     int n;        /* iterates over tree elements */
@@ -326,7 +326,7 @@
 /* ===========================================================================
  * Initialize a new block.
  */
-local void init_block(s)
+static void init_block(s)
     deflate_state *s;
 {
     int n; /* iterates over tree elements */
@@ -370,7 +370,7 @@
  * when the heap property is re-established (each father smaller than its
  * two sons).
  */
-local void pqdownheap(
+static void pqdownheap(
 	deflate_state *s,
 	ct_data *tree,  /* the tree to restore */
 	int k		/* node to move down */
@@ -406,7 +406,7 @@
  *     The length opt_len is updated; static_len is also updated if stree is
  *     not null.
  */
-local void gen_bitlen(
+static void gen_bitlen(
 	deflate_state *s,
 	tree_desc *desc    /* the tree descriptor */
 )
@@ -494,7 +494,7 @@
  * OUT assertion: the field code is set for all tree elements of non
  *     zero code length.
  */
-local void gen_codes(
+static void gen_codes(
 	ct_data *tree,             /* the tree to decorate */
 	int max_code,              /* largest code with non zero frequency */
 	ush *bl_count             /* number of codes at each bit length */
@@ -537,7 +537,7 @@
  *     and corresponding code. The length opt_len is updated; static_len is
  *     also updated if stree is not null. The field max_code is set.
  */
-local void build_tree(
+static void build_tree(
 	deflate_state *s,
 	tree_desc *desc	 /* the tree descriptor */
 )
@@ -625,7 +625,7 @@
  * Scan a literal or distance tree to determine the frequencies of the codes
  * in the bit length tree.
  */
-local void scan_tree(
+static void scan_tree(
 	deflate_state *s,
 	ct_data *tree,   /* the tree to be scanned */
 	int max_code     /* and its largest code of non zero frequency */
@@ -671,7 +671,7 @@
  * Send a literal or distance tree in compressed form, using the codes in
  * bl_tree.
  */
-local void send_tree(
+static void send_tree(
 	deflate_state *s,
 	ct_data *tree, /* the tree to be scanned */
 	int max_code   /* and its largest code of non zero frequency */
@@ -723,7 +723,7 @@
  * Construct the Huffman tree for the bit lengths and return the index in
  * bl_order of the last bit length code to send.
  */
-local int build_bl_tree(
+static int build_bl_tree(
 	deflate_state *s
 )
 {
@@ -759,7 +759,7 @@
  * lengths of the bit length codes, the literal tree and the distance tree.
  * IN assertion: lcodes >= 257, dcodes >= 1, blcodes >= 4.
  */
-local void send_all_trees(
+static void send_all_trees(
 	deflate_state *s,
 	int lcodes,  /* number of codes for each tree */
 	int dcodes,  /* number of codes for each tree */
@@ -1017,7 +1017,7 @@
 /* ===========================================================================
  * Send the block data compressed using the given Huffman trees
  */
-local void compress_block(
+static void compress_block(
 	deflate_state *s,
 	ct_data *ltree, /* literal tree */
 	ct_data *dtree  /* distance tree */
@@ -1071,7 +1071,7 @@
  * IN assertion: the fields freq of dyn_ltree are set and the total of all
  * frequencies does not exceed 64K (to fit in an int on 16 bit machines).
  */
-local void set_data_type(
+static void set_data_type(
 	deflate_state *s
 )
 {
@@ -1088,7 +1088,7 @@
  * Copy a stored block, storing first the length and its
  * one's complement if requested.
  */
-local void copy_block(
+static void copy_block(
 	deflate_state *s,
 	char    *buf,     /* the input data */
 	unsigned len,     /* its length */
--- linux-2.5.70-bk11/lib/zlib_deflate/deflate.c~zlib_cleanup_local	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deflate.c	2003-06-06 19:46:09.000000000 +0200
@@ -66,18 +66,18 @@
 typedef block_state (*compress_func) (deflate_state *s, int flush);
 /* Compression function. Returns the block state after the call. */
 
-local void fill_window    (deflate_state *s);
-local block_state deflate_stored (deflate_state *s, int flush);
-local block_state deflate_fast   (deflate_state *s, int flush);
-local block_state deflate_slow   (deflate_state *s, int flush);
-local void lm_init        (deflate_state *s);
-local void putShortMSB    (deflate_state *s, uInt b);
-local void flush_pending  (z_streamp strm);
-local int read_buf        (z_streamp strm, Byte *buf, unsigned size);
-local uInt longest_match  (deflate_state *s, IPos cur_match);
+static void fill_window    (deflate_state *s);
+static block_state deflate_stored (deflate_state *s, int flush);
+static block_state deflate_fast   (deflate_state *s, int flush);
+static block_state deflate_slow   (deflate_state *s, int flush);
+static void lm_init        (deflate_state *s);
+static void putShortMSB    (deflate_state *s, uInt b);
+static void flush_pending  (z_streamp strm);
+static int read_buf        (z_streamp strm, Byte *buf, unsigned size);
+static uInt longest_match  (deflate_state *s, IPos cur_match);
 
 #ifdef DEBUG_ZLIB
-local  void check_match (deflate_state *s, IPos start, IPos match,
+static  void check_match (deflate_state *s, IPos start, IPos match,
                          int length);
 #endif
 
@@ -111,7 +111,7 @@
    compress_func func;
 } config;
 
-local const config configuration_table[10] = {
+static const config configuration_table[10] = {
 /*      good lazy nice chain */
 /* 0 */ {0,    0,  0,    0, deflate_stored},  /* store only */
 /* 1 */ {4,    4,  8,    4, deflate_fast}, /* maximum speed, no lazy matches */
@@ -371,7 +371,7 @@
  * IN assertion: the stream state is correct and there is enough room in
  * pending_buf.
  */
-local void putShortMSB (s, b)
+static void putShortMSB (s, b)
     deflate_state *s;
     uInt b;
 {
@@ -385,7 +385,7 @@
  * to avoid allocating a large strm->next_out buffer and copying into it.
  * (See also read_buf()).
  */
-local void flush_pending(strm)
+static void flush_pending(strm)
     z_streamp strm;
 {
     deflate_state *s = (deflate_state *) strm->state;
@@ -630,7 +630,7 @@
  * allocating a large strm->next_in buffer and copying from it.
  * (See also flush_pending()).
  */
-local int read_buf(
+static int read_buf(
 	z_streamp strm,
 	Byte *buf,
 	unsigned size
@@ -656,7 +656,7 @@
 /* ===========================================================================
  * Initialize the "longest match" routines for a new zlib stream
  */
-local void lm_init (s)
+static void lm_init (s)
     deflate_state *s;
 {
     s->window_size = (ulg)2L*s->w_size;
@@ -690,7 +690,7 @@
 /* For 80x86 and 680x0, an optimized version will be provided in match.asm or
  * match.S. The code will be functionally equivalent.
  */
-local uInt longest_match(s, cur_match)
+static uInt longest_match(s, cur_match)
     deflate_state *s;
     IPos cur_match;                             /* current match */
 {
@@ -832,7 +832,7 @@
 /* ===========================================================================
  * Check that the match at match_start is indeed a match.
  */
-local void check_match(s, start, match, length)
+static void check_match(s, start, match, length)
     deflate_state *s;
     IPos start, match;
     int length;
@@ -866,7 +866,7 @@
  *    performed for at least two bytes (required for the zip translate_eol
  *    option -- not supported here).
  */
-local void fill_window(s)
+static void fill_window(s)
     deflate_state *s;
 {
     register unsigned n, m;
@@ -985,7 +985,7 @@
  * NOTE: this function should be optimized to avoid extra copying from
  * window to pending_buf.
  */
-local block_state deflate_stored(s, flush)
+static block_state deflate_stored(s, flush)
     deflate_state *s;
     int flush;
 {
@@ -1043,7 +1043,7 @@
  * new strings in the dictionary only for unmatched strings or for short
  * matches. It is used only for the fast compression options.
  */
-local block_state deflate_fast(s, flush)
+static block_state deflate_fast(s, flush)
     deflate_state *s;
     int flush;
 {
@@ -1136,7 +1136,7 @@
  * evaluation for matches: a match is finally adopted only if there is
  * no better match at the next window position.
  */
-local block_state deflate_slow(s, flush)
+static block_state deflate_slow(s, flush)
     deflate_state *s;
     int flush;
 {
--- linux-2.5.70-bk11/lib/zlib_inflate/inffixed.h~zlib_cleanup_local	2003-04-07 19:30:46.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inffixed.h	2003-06-06 19:46:27.000000000 +0200
@@ -7,9 +7,9 @@
    subject to change. Applications should only use zlib.h.
  */
 
-local uInt fixed_bl = 9;
-local uInt fixed_bd = 5;
-local inflate_huft fixed_tl[] = {
+static uInt fixed_bl = 9;
+static uInt fixed_bd = 5;
+static inflate_huft fixed_tl[] = {
     {{{96,7}},256}, {{{0,8}},80}, {{{0,8}},16}, {{{84,8}},115},
     {{{82,7}},31}, {{{0,8}},112}, {{{0,8}},48}, {{{0,9}},192},
     {{{80,7}},10}, {{{0,8}},96}, {{{0,8}},32}, {{{0,9}},160},
@@ -139,7 +139,7 @@
     {{{82,7}},27}, {{{0,8}},111}, {{{0,8}},47}, {{{0,9}},191},
     {{{0,8}},15}, {{{0,8}},143}, {{{0,8}},79}, {{{0,9}},255}
   };
-local inflate_huft fixed_td[] = {
+static inflate_huft fixed_td[] = {
     {{{80,5}},1}, {{{87,5}},257}, {{{83,5}},17}, {{{91,5}},4097},
     {{{81,5}},5}, {{{89,5}},1025}, {{{85,5}},65}, {{{93,5}},16385},
     {{{80,5}},3}, {{{88,5}},513}, {{{84,5}},33}, {{{92,5}},8193},
--- linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c~zlib_cleanup_local	2003-06-06 15:56:16.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c	2003-06-06 19:46:59.000000000 +0200
@@ -22,7 +22,7 @@
 #define bits word.what.Bits
 
 
-local int huft_build (
+static int huft_build (
     uInt *,             /* code lengths in bits */
     uInt,               /* number of codes */
     uInt,               /* number of "simple" codes */
@@ -35,18 +35,18 @@
     uInt * );           /* space for values */
 
 /* Tables for deflate from PKZIP's appnote.txt. */
-local const uInt cplens[31] = { /* Copy lengths for literal codes 257..285 */
+static const uInt cplens[31] = { /* Copy lengths for literal codes 257..285 */
         3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
         35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0};
         /* see note #13 above about 258 */
-local const uInt cplext[31] = { /* Extra bits for literal codes 257..285 */
+static const uInt cplext[31] = { /* Extra bits for literal codes 257..285 */
         0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
         3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 112, 112}; /* 112==invalid */
-local const uInt cpdist[30] = { /* Copy offsets for distance codes 0..29 */
+static const uInt cpdist[30] = { /* Copy offsets for distance codes 0..29 */
         1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
         257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
         8193, 12289, 16385, 24577};
-local const uInt cpdext[30] = { /* Extra bits for distance codes */
+static const uInt cpdext[30] = { /* Extra bits for distance codes */
         0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
         7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
         12, 12, 13, 13};
@@ -87,7 +87,7 @@
 /* If BMAX needs to be larger than 16, then h and x[] should be uLong. */
 #define BMAX 15         /* maximum bit length of any code */
 
-local int huft_build(
+static int huft_build(
 	uInt *b,               /* code lengths in bits (all assumed <= BMAX) */
 	uInt n,                /* number of codes (assumed <= 288) */
 	uInt s,                /* number of simple-valued codes (0..s-1) */
--- linux-2.5.70-bk11/lib/zlib_inflate/infblock.c~zlib_cleanup_local	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/infblock.c	2003-06-06 19:47:25.000000000 +0200
@@ -16,7 +16,7 @@
 #define bits word.what.Bits
 
 /* Table for deflate from PKZIP's appnote.txt. */
-local const uInt border[] = { /* Order of the bit length code lengths */
+static const uInt border[] = { /* Order of the bit length code lengths */
         16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
 
 /*
--- linux-2.5.70-bk11/include/linux/zutil.h~zlib_cleanup_local	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/zutil.h	2003-06-06 19:50:47.000000000 +0200
@@ -18,11 +18,6 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 
-#ifndef local
-#  define local static
-#endif
-/* compile with -Dlocal if your debugger can't find static symbols */
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
