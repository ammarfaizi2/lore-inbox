Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTFFBHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTFFBHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 21:07:22 -0400
Received: from miranda.zianet.com ([216.234.192.169]:62737 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S265278AbTFFBHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 21:07:19 -0400
Subject: [PATCH] 2.5-bk Another final K&R to ANSI C cleanup of zlib
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1054862409.25621.1572.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 Jun 2003 19:20:10 -0600
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another final K&R to ANSI C cleanup patch for zlib.

This was made against the current 2.5 tree after Jörn Engel's recent
cleanups.

Steven

 lib/zlib_deflate/deflate.c |   55 ++++++++++++++++++++++++++-------------------
 lib/zlib_deflate/deftree.c |   12 +++++----
 2 files changed, 39 insertions(+), 28 deletions(-)

diff -ur bk-current/lib/zlib_deflate/deflate.c linux/lib/zlib_deflate/deflate.c
--- bk-current/lib/zlib_deflate/deflate.c	2003-06-05 18:30:07.000000000 -0600
+++ linux/lib/zlib_deflate/deflate.c	2003-06-05 19:00:20.000000000 -0600
@@ -371,9 +371,10 @@
  * IN assertion: the stream state is correct and there is enough room in
  * pending_buf.
  */
-local void putShortMSB (s, b)
-    deflate_state *s;
-    uInt b;
+local void putShortMSB(
+	deflate_state *s,
+	uInt b
+)
 {
     put_byte(s, (Byte)(b >> 8));
     put_byte(s, (Byte)(b & 0xff));
@@ -385,8 +386,9 @@
  * to avoid allocating a large strm->next_out buffer and copying into it.
  * (See also read_buf()).
  */
-local void flush_pending(strm)
-    z_streamp strm;
+local void flush_pending(
+	z_streamp strm
+)
 {
     deflate_state *s = (deflate_state *) strm->state;
     unsigned len = s->pending;
@@ -656,8 +658,9 @@
 /* ===========================================================================
  * Initialize the "longest match" routines for a new zlib stream
  */
-local void lm_init (s)
-    deflate_state *s;
+local void lm_init(
+	deflate_state *s
+)
 {
     s->window_size = (ulg)2L*s->w_size;
 
@@ -690,9 +693,10 @@
 /* For 80x86 and 680x0, an optimized version will be provided in match.asm or
  * match.S. The code will be functionally equivalent.
  */
-local uInt longest_match(s, cur_match)
-    deflate_state *s;
-    IPos cur_match;                             /* current match */
+local uInt longest_match(
+	deflate_state *s,
+	IPos cur_match			/* current match */
+)
 {
     unsigned chain_length = s->max_chain_length;/* max hash chain length */
     register Byte *scan = s->window + s->strstart; /* current string */
@@ -832,10 +836,12 @@
 /* ===========================================================================
  * Check that the match at match_start is indeed a match.
  */
-local void check_match(s, start, match, length)
-    deflate_state *s;
-    IPos start, match;
-    int length;
+local void check_match(
+	deflate_state *s,
+	IPos start,
+	IPos match,
+	int length
+)
 {
     /* check that the match is indeed a match */
     if (memcmp((char *)s->window + match,
@@ -985,9 +991,10 @@
  * NOTE: this function should be optimized to avoid extra copying from
  * window to pending_buf.
  */
-local block_state deflate_stored(s, flush)
-    deflate_state *s;
-    int flush;
+local block_state deflate_stored(
+	deflate_state *s,
+	int flush
+)
 {
     /* Stored blocks are limited to 0xffff bytes, pending_buf is limited
      * to pending_buf_size, and each stored block has a 5 byte header:
@@ -1043,9 +1050,10 @@
  * new strings in the dictionary only for unmatched strings or for short
  * matches. It is used only for the fast compression options.
  */
-local block_state deflate_fast(s, flush)
-    deflate_state *s;
-    int flush;
+local block_state deflate_fast(
+	deflate_state *s,
+	int flush
+)
 {
     IPos hash_head = NIL; /* head of the hash chain */
     int bflush;           /* set if current block must be flushed */
@@ -1136,9 +1144,10 @@
  * evaluation for matches: a match is finally adopted only if there is
  * no better match at the next window position.
  */
-local block_state deflate_slow(s, flush)
-    deflate_state *s;
-    int flush;
+local block_state deflate_slow(
+	deflate_state *s,
+	int flush
+)
 {
     IPos hash_head = NIL;    /* head of hash chain */
     int bflush;              /* set if current block must be flushed */
diff -ur bk-current/lib/zlib_deflate/deftree.c linux/lib/zlib_deflate/deftree.c
--- bk-current/lib/zlib_deflate/deftree.c	2003-06-05 18:30:41.000000000 -0600
+++ linux/lib/zlib_deflate/deftree.c	2003-06-05 19:04:11.000000000 -0600
@@ -226,7 +226,7 @@
  * this function may be called by two threads concurrently, but this is
  * harmless since both invocations do exactly the same thing.
  */
-local void tr_static_init()
+local void tr_static_init(void)
 {
     static int static_init_done = 0;
     int n;        /* iterates over tree elements */
@@ -296,8 +296,9 @@
 /* ===========================================================================
  * Initialize the tree data structures for a new zlib stream.
  */
-void zlib_tr_init(s)
-    deflate_state *s;
+void zlib_tr_init(
+	deflate_state *s
+)
 {
     tr_static_init();
 
@@ -326,8 +327,9 @@
 /* ===========================================================================
  * Initialize a new block.
  */
-local void init_block(s)
-    deflate_state *s;
+local void init_block(
+	deflate_state *s
+)
 {
     int n; /* iterates over tree elements */
 



