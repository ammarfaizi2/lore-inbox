Return-Path: <linux-kernel-owner+w=401wt.eu-S1751091AbXAFC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbXAFC0S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXAFC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:26:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47753 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbXAFCZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:25:57 -0500
Message-Id: <20070106022909.248975000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:27:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [patch 02/50] sha512: Fix sha384 block size
Content-Disposition: inline; filename=sha512-fix-sha384-block-size.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

The SHA384 block size should be 128 bytes, not 96 bytes.  This was
spotted by Andrew Donofrio.

This breaks HMAC which uses the block size during setup and the final
calculation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 crypto/sha512.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/crypto/sha512.c
+++ linux-2.6.19.1/crypto/sha512.c
@@ -24,7 +24,7 @@
 
 #define SHA384_DIGEST_SIZE 48
 #define SHA512_DIGEST_SIZE 64
-#define SHA384_HMAC_BLOCK_SIZE  96
+#define SHA384_HMAC_BLOCK_SIZE 128
 #define SHA512_HMAC_BLOCK_SIZE 128
 
 struct sha512_ctx {

--
