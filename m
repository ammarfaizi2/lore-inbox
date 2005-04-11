Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVDKUSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVDKUSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVDKURk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:17:40 -0400
Received: from mail.dif.dk ([193.138.115.101]:53189 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261913AbVDKUOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:14:11 -0400
Date: Mon, 11 Apr 2005 22:16:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cifs: md5 cleanup - comments
Message-ID: <Pine.LNX.4.62.0504112214350.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


clean up comments and make them conform to the style used in other cifs 
files.

this patch can also be fetched from:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-comments.patch

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm2/fs/cifs/md5.c.with_patch2	2005-04-09 10:50:54.000000000 +0200
+++ linux-2.6.12-rc2-mm2/fs/cifs/md5.c	2005-04-09 10:51:00.000000000 +0200
@@ -15,9 +15,9 @@
  * will fill a supplied 16-byte array with the digest.
  */
 
-/* This code slightly modified to fit into Samba by 
-   abartlet@samba.org Jun 2001 
-   and to fit the cifs vfs by 
+/* This code slightly modified to fit into Samba by
+   abartlet@samba.org Jun 2001
+   and to fit the cifs vfs by
    Steve French sfrench@us.ibm.com */
 
 #include <linux/string.h>
@@ -25,9 +25,7 @@
 
 static void MD5Transform(__u32 buf[4], __u32 const in[16]);
 
-/*
- * Note: this code is harmless on little-endian machines.
- */
+/* Note: this code is harmless on little-endian machines. */
 static void byteReverse(unsigned char *buf, unsigned longs)
 {
 	__u32 t;
@@ -39,10 +37,8 @@ static void byteReverse(unsigned char *b
 	} while (--longs);
 }
 
-/*
- * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
- * initialization constants.
- */
+/* Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
+   initialization constants. */
 void MD5Init(struct MD5Context *ctx)
 {
 	ctx->buf[0] = 0x67452301;
@@ -54,10 +50,8 @@ void MD5Init(struct MD5Context *ctx)
 	ctx->bits[1] = 0;
 }
 
-/*
- * Update context to reflect the concatenation of another buffer full
- * of bytes.
- */
+/* Update context to reflect the concatenation of another buffer full of
+   bytes. */
 void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
 {
 	register __u32 t;
@@ -99,10 +93,8 @@ void MD5Update(struct MD5Context *ctx, u
 	memmove(ctx->in, buf, len);
 }
 
-/*
- * Final wrapup - pad to 64-byte boundary with the bit pattern 
- * 1 0* (64-bit count of bits processed, MSB-first)
- */
+/* Final wrapup - pad to 64-byte boundary with the bit pattern 
+   1 0* (64-bit count of bits processed, MSB-first) */
 void MD5Final(unsigned char digest[16], struct MD5Context *ctx)
 {
 	unsigned int count;
@@ -156,11 +148,9 @@ void MD5Final(unsigned char digest[16], 
 #define MD5STEP(f, w, x, y, z, data, s) \
 	( w += f(x, y, z) + data,  w = w<<s | w>>(32-s),  w += x )
 
-/*
- * The core of the MD5 algorithm, this alters an existing MD5 hash to
- * reflect the addition of 16 longwords of new data.  MD5Update blocks
- * the data and converts bytes into longwords for this routine.
- */
+/* The core of the MD5 algorithm, this alters an existing MD5 hash to reflect
+   the addition of 16 longwords of new data. MD5Update blocks the data and
+   converts bytes into longwords for this routine. */
 static void MD5Transform(__u32 buf[4], __u32 const in[16])
 {
 	register __u32 a, b, c, d;
@@ -244,9 +234,7 @@ static void MD5Transform(__u32 buf[4], _
 	buf[3] += d;
 }
 
-/***********************************************************************
- the rfc 2104 version of hmac_md5 initialisation.
-***********************************************************************/
+/* the rfc 2104 version of hmac_md5 initialisation. */
 void hmac_md5_init_rfc2104(unsigned char *key, int key_len,
 	struct HMACMD5Context *ctx)
 {
@@ -281,9 +269,7 @@ void hmac_md5_init_rfc2104(unsigned char
 	MD5Update(&ctx->ctx, ctx->k_ipad, 64);
 }
 
-/***********************************************************************
- the microsoft version of hmac_md5 initialisation.
-***********************************************************************/
+/* the microsoft version of hmac_md5 initialisation. */
 void hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
 	struct HMACMD5Context *ctx)
 {
@@ -310,18 +296,14 @@ void hmac_md5_init_limK_to_64(const unsi
 	MD5Update(&ctx->ctx, ctx->k_ipad, 64);
 }
 
-/***********************************************************************
- update hmac_md5 "inner" buffer
-***********************************************************************/
+/* update hmac_md5 "inner" buffer */
 void hmac_md5_update(const unsigned char *text, int text_len,
 	struct HMACMD5Context *ctx)
 {
 	MD5Update(&ctx->ctx, text, text_len);	/* then text of datagram */
 }
 
-/***********************************************************************
- finish off hmac_md5 "inner" buffer and generate outer one.
-***********************************************************************/
+/* finish off hmac_md5 "inner" buffer and generate outer one. */
 void hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx)
 {
 	struct MD5Context ctx_o;
@@ -334,10 +316,8 @@ void hmac_md5_final(unsigned char *diges
 	MD5Final(digest, &ctx_o);
 }
 
-/***********************************************************
- single function to calculate an HMAC MD5 digest from data.
- use the microsoft hmacmd5 init method because the key is 16 bytes.
-************************************************************/
+/* single function to calculate an HMAC MD5 digest from data.
+   use the microsoft hmacmd5 init method because the key is 16 bytes. */
 void hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
 	unsigned char *digest)
 {


