Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWIFGQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWIFGQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWIFGQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:16:01 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:38151 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932593AbWIFGQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:16:00 -0400
Date: Wed, 6 Sep 2006 16:15:53 +1000
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3 crypto issues with encrypted disks
Message-ID: <20060906061553.GA20723@gondor.apana.org.au>
References: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 04:02:28PM +0000, Valdis.Kletnieks@vt.edu wrote:
> Sorry for not catching this one earlier..  Sometime between 2.6.18-rc4-mm2
> and -mm3, something crept into the git-cryptodev.patch that breaks mounting
> encrypted disks.  What I have in /etc/fstab:

Thanks for the report!  I set the wrong default when I changed the
cryptoloop init code.  This patch should fix the problem.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index c6bbdbe..4053503 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -67,7 +67,7 @@ cryptoloop_init(struct loop_device *lo, 
 	}
 
 	if (!mode_len) {
-		mode = "ecb";
+		mode = "cbc";
 		mode_len = 3;
 	}
 
