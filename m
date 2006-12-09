Return-Path: <linux-kernel-owner+w=401wt.eu-S1759118AbWLIWus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbWLIWus (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759119AbWLIWus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:50:48 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:2071 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759074AbWLIWus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:50:48 -0500
Date: Sun, 10 Dec 2006 09:50:36 +1100
To: Rene Herman <rene.herman@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 08/32] cryptoloop: Select CRYPTO_CBC
Message-ID: <20061209225035.GA12802@gondor.apana.org.au>
References: <20061208235751.890503000@sous-sol.org> <20061208235942.464993000@sous-sol.org> <457A5862.1020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457A5862.1020006@gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 07:32:02AM +0100, Rene Herman wrote:
> 
> dm-crypt needs CBC in the same manner -- normal (via howto) use of 
> cryptsetup doesn't work otherwise, same as with cryptoloop.

Good point.  Here's the patch for 2.6.19 and 2.6.20.

[CRYPTO] dm-crypt: Select CRYPTO_CBC

As CBC is the default chaining method for cryptoloop, we should select
it from cryptoloop to ease the transition.  Spotted by Rene Herman.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
7cd650c7e042e3c201fb3c401780c909d44b0e5d
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c92c152..4540ade 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -215,6 +215,7 @@ config DM_CRYPT
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM && EXPERIMENTAL
 	select CRYPTO
+	select CRYPTO_CBC
 	---help---
 	  This device-mapper target allows you to create a device that
 	  transparently encrypts the data on it. You'll need to activate
