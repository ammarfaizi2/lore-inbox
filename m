Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVDDWEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVDDWEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDDWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:04:31 -0400
Received: from host201.dif.dk ([193.138.115.201]:9734 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261431AbVDDWC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:02:58 -0400
Date: Tue, 5 Apr 2005 00:05:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: James Morris <jmorris@intercode.com.au>
Subject: [PATCH] crypto: don't check for NULL before kfree(), it's redundant.
Message-ID: <Pine.LNX.4.62.0504050002290.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Checking a pointer for NULL before calling kfree() on it is redundant. 
This patch removes such checks from crypto/

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.12-rc1-mm4-orig/crypto/cipher.c linux-2.6.12-rc1-mm4/crypto/cipher.c
--- linux-2.6.12-rc1-mm4-orig/crypto/cipher.c	2005-03-31 21:19:49.000000000 +0200
+++ linux-2.6.12-rc1-mm4/crypto/cipher.c	2005-04-04 23:58:58.000000000 +0200
@@ -336,6 +336,5 @@ out:	
 
 void crypto_exit_cipher_ops(struct crypto_tfm *tfm)
 {
-	if (tfm->crt_cipher.cit_iv)
-		kfree(tfm->crt_cipher.cit_iv);
+	kfree(tfm->crt_cipher.cit_iv);
 }
diff -up linux-2.6.12-rc1-mm4-orig/crypto/hmac.c linux-2.6.12-rc1-mm4/crypto/hmac.c
--- linux-2.6.12-rc1-mm4-orig/crypto/hmac.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc1-mm4/crypto/hmac.c	2005-04-04 23:59:22.000000000 +0200
@@ -49,8 +49,7 @@ int crypto_alloc_hmac_block(struct crypt
 
 void crypto_free_hmac_block(struct crypto_tfm *tfm)
 {
-	if (tfm->crt_digest.dit_hmac_block)
-		kfree(tfm->crt_digest.dit_hmac_block);
+	kfree(tfm->crt_digest.dit_hmac_block);
 }
 
 void crypto_hmac_init(struct crypto_tfm *tfm, u8 *key, unsigned int *keylen)



