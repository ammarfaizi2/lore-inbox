Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWJJMs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWJJMs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWJJMs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:48:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:59790 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965135AbWJJMsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=uTdzcLo4eidJta2ukN1fuN8jU3GgOh9Lp2UjPNLYjH8Ms6WXhjoG6cHqfasCrODCEFZpuYU6wqhgJZw1ZdciKEmIL84M4sXdbda/R43aMnHvodwtU41moZL2sz6g2kBpu6NkfQ0hq71YmNFzwYD49Tatpc4CY+QkVrdRjpDoBVA=
Date: Tue, 10 Oct 2006 21:48:40 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: mark crypto_alloc_tfm() __deprecated
Message-ID: <20061010124840.GB17432@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks crypto_alloc_tfm() as __deprecated.
And converts from crypto_alloc_tfm() to crypto_alloc_comp() in
tcrypt crypto testing module.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 crypto/tcrypt.c        |    4 ++--
 include/linux/crypto.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: work-fault-inject/include/linux/crypto.h
===================================================================
--- work-fault-inject.orig/include/linux/crypto.h
+++ work-fault-inject/include/linux/crypto.h
@@ -367,7 +367,8 @@ struct crypto_attr_alg {
  * Transform user interface.
  */
  
-struct crypto_tfm *crypto_alloc_tfm(const char *alg_name, u32 tfm_flags);
+struct crypto_tfm *crypto_alloc_tfm(const char *alg_name, u32 tfm_flags)
+	__deprecated;
 struct crypto_tfm *crypto_alloc_base(const char *alg_name, u32 type, u32 mask);
 void crypto_free_tfm(struct crypto_tfm *tfm);
 
Index: work-fault-inject/crypto/tcrypt.c
===================================================================
--- work-fault-inject.orig/crypto/tcrypt.c
+++ work-fault-inject/crypto/tcrypt.c
@@ -765,8 +765,8 @@ static void test_deflate(void)
 	memcpy(tvmem, deflate_comp_tv_template, tsize);
 	tv = (void *)tvmem;
 
-	tfm = crypto_alloc_tfm("deflate", 0);
-	if (tfm == NULL) {
+	tfm = crypto_alloc_comp("deflate", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
 		printk("failed to load transform for deflate\n");
 		return;
 	}
