Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDITiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDITiv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 15:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVDITiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 15:38:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4869 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261373AbVDITio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 15:38:44 -0400
Date: Sat, 9 Apr 2005 21:38:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] crypto/api.c: make crypto_alg_lookup static
Message-ID: <20050409193841.GK3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 crypto/api.c      |    9 ++++++++-
 crypto/internal.h |    9 ---------
 2 files changed, 8 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc2-mm2-full/crypto/internal.h.old	2005-04-09 21:13:40.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/crypto/internal.h	2005-04-09 21:15:14.000000000 +0200
@@ -47,15 +47,6 @@
 	return (void *)&tfm[1];
 }
 
-struct crypto_alg *crypto_alg_lookup(const char *name);
-
-/* A far more intelligent version of this is planned.  For now, just
- * try an exact match on the name of the algorithm. */
-static inline struct crypto_alg *crypto_alg_mod_lookup(const char *name)
-{
-	return try_then_request_module(crypto_alg_lookup(name), name);
-}
-
 #ifdef CONFIG_CRYPTO_HMAC
 int crypto_alloc_hmac_block(struct crypto_tfm *tfm);
 void crypto_free_hmac_block(struct crypto_tfm *tfm);
--- linux-2.6.12-rc2-mm2-full/crypto/api.c.old	2005-04-09 21:13:59.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/crypto/api.c	2005-04-09 21:15:07.000000000 +0200
@@ -33,7 +33,7 @@
 	module_put(alg->cra_module);
 }
 
-struct crypto_alg *crypto_alg_lookup(const char *name)
+static struct crypto_alg *crypto_alg_lookup(const char *name)
 {
 	struct crypto_alg *q, *alg = NULL;
 
@@ -54,6 +54,13 @@
 	return alg;
 }
 
+/* A far more intelligent version of this is planned.  For now, just
+ * try an exact match on the name of the algorithm. */
+static inline struct crypto_alg *crypto_alg_mod_lookup(const char *name)
+{
+	return try_then_request_module(crypto_alg_lookup(name), name);
+}
+
 static int crypto_init_flags(struct crypto_tfm *tfm, u32 flags)
 {
 	tfm->crt_flags = 0;

