Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWCHOL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWCHOL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWCHOL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:11:58 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:54830 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1030209AbWCHOL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:11:57 -0500
Date: Wed, 08 Mar 2006 23:11:55 +0900 (JST)
Message-Id: <20060308.231155.63512624.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, akpm@osdl.org
Subject: [PATCH] crypto: fix key alignment in tcrypt
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Force 32-bit alignment on keys in tcrypt test vectors.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/crypto/tcrypt.h b/crypto/tcrypt.h
index 733d07e..050f852 100644
--- a/crypto/tcrypt.h
+++ b/crypto/tcrypt.h
@@ -31,7 +31,7 @@ struct hash_testvec {
 	char digest[MAX_DIGEST_SIZE];
 	unsigned char np;
 	unsigned char tap[MAX_TAP];
-	char key[128]; /* only used with keyed hash algorithms */
+	char key[128] __attribute__((__aligned__(4))); /* only used with keyed hash algorithms */
 	unsigned char ksize;
 };
 
@@ -48,7 +48,7 @@ struct hmac_testvec {
 struct cipher_testvec {
 	unsigned char fail;
 	unsigned char wk; /* weak key flag */
-	char key[MAX_KEYLEN];
+	char key[MAX_KEYLEN] __attribute__((__aligned__(4)));
 	unsigned char klen;
 	char iv[MAX_IVLEN];
 	char input[48];
