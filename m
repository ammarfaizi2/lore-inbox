Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWHOLwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWHOLwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWHOLwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:52:08 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:1540 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030272AbWHOLwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:52:06 -0400
Date: Tue, 15 Aug 2006 21:52:00 +1000
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [1/2] [PATCH] scatterlist: Add const to sg_set_buf/sg_init_one pointer argument
Message-ID: <20060815115200.GA14517@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I'm adding these two patches to cryptodev-2.6.

[PATCH] scatterlist: Add const to sg_set_buf/sg_init_one pointer argument

This patch adds a const modifier to the buf argument of sg_set_buf and
sg_init_one.  This lets people call it with pointers that are const.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -5,7 +5,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 
-static inline void sg_set_buf(struct scatterlist *sg, void *buf,
+static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
 			      unsigned int buflen)
 {
 	sg->page = virt_to_page(buf);
@@ -13,7 +13,7 @@ static inline void sg_set_buf(struct sca
 	sg->length = buflen;
 }
 
-static inline void sg_init_one(struct scatterlist *sg, void *buf,
+static inline void sg_init_one(struct scatterlist *sg, const void *buf,
 			       unsigned int buflen)
 {
 	memset(sg, 0, sizeof(*sg));
