Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWCHOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWCHOKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCHOKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:10:38 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:18990 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1030202AbWCHOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:10:36 -0500
Date: Wed, 08 Mar 2006 23:10:35 +0900 (JST)
Message-Id: <20060308.231035.44604898.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, akpm@osdl.org
Subject: [PATCH] crypto: add missing cra_alignmask
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "des3_ede" and "serpent" lack cra_alignmask.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/crypto/des.c b/crypto/des.c
index 7bb5486..2d74cab 100644
--- a/crypto/des.c
+++ b/crypto/des.c
@@ -965,6 +965,7 @@ static struct crypto_alg des3_ede_alg = 
 	.cra_blocksize		=	DES3_EDE_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct des3_ede_ctx),
 	.cra_module		=	THIS_MODULE,
+	.cra_alignmask		=	3,
 	.cra_list		=	LIST_HEAD_INIT(des3_ede_alg.cra_list),
 	.cra_u			=	{ .cipher = {
 	.cia_min_keysize	=	DES3_EDE_KEY_SIZE,
diff --git a/crypto/serpent.c b/crypto/serpent.c
index 52ad1a4..e366406 100644
--- a/crypto/serpent.c
+++ b/crypto/serpent.c
@@ -481,6 +481,7 @@ static struct crypto_alg serpent_alg = {
 	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
 	.cra_blocksize		=	SERPENT_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct serpent_ctx),
+	.cra_alignmask		=	3,
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(serpent_alg.cra_list),
 	.cra_u			=	{ .cipher = {
