Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424862AbWKQBTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424862AbWKQBTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424864AbWKQBTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:19:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424862AbWKQBTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:30 -0500
Date: Fri, 17 Nov 2006 02:19:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [-mm patch] crypto/xcbc.c: make some code static
Message-ID: <20061117011929.GP31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-cryptodev.patch
>...
>  git trees
>...

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 crypto/xcbc.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.19-rc5-mm2/crypto/xcbc.c.old	2006-11-16 22:56:01.000000000 +0100
+++ linux-2.6.19-rc5-mm2/crypto/xcbc.c	2006-11-16 22:57:12.000000000 +0100
@@ -28,9 +28,9 @@
 #include <linux/scatterlist.h>
 #include "internal.h"
 
-u_int32_t ks[12] = {0x01010101, 0x01010101, 0x01010101, 0x01010101,
-		    0x02020202, 0x02020202, 0x02020202, 0x02020202,
-		    0x03030303, 0x03030303, 0x03030303, 0x03030303};
+static u_int32_t ks[12] = {0x01010101, 0x01010101, 0x01010101, 0x01010101,
+			   0x02020202, 0x02020202, 0x02020202, 0x02020202,
+			   0x03030303, 0x03030303, 0x03030303, 0x03030303};
 /*
  * +------------------------
  * | <parent tfm>
@@ -96,7 +96,7 @@
 	return _crypto_xcbc_digest_setkey(parent, ctx);
 }
 
-int crypto_xcbc_digest_init(struct hash_desc *pdesc)
+static int crypto_xcbc_digest_init(struct hash_desc *pdesc)
 {
 	struct crypto_xcbc_ctx *ctx = crypto_hash_ctx_aligned(pdesc->tfm);
 	int bs = crypto_hash_blocksize(pdesc->tfm);
@@ -108,7 +108,9 @@
 	return 0;
 }
 
-int crypto_xcbc_digest_update(struct hash_desc *pdesc, struct scatterlist *sg, unsigned int nbytes)
+static int crypto_xcbc_digest_update(struct hash_desc *pdesc,
+				     struct scatterlist *sg,
+				     unsigned int nbytes)
 {
 	struct crypto_hash *parent = pdesc->tfm;
 	struct crypto_xcbc_ctx *ctx = crypto_hash_ctx_aligned(parent);
@@ -181,7 +183,7 @@
 	return 0;
 }
 
-int crypto_xcbc_digest_final(struct hash_desc *pdesc, u8 *out)
+static int crypto_xcbc_digest_final(struct hash_desc *pdesc, u8 *out)
 {
 	struct crypto_hash *parent = pdesc->tfm;
 	struct crypto_xcbc_ctx *ctx = crypto_hash_ctx_aligned(parent);

