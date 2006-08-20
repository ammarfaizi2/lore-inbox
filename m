Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWHTXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWHTXEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWHTXEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:04:45 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:27652 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751773AbWHTXEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:04:44 -0400
Date: Mon, 21 Aug 2006 09:04:15 +1000
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Michal Ludvig <michal@logix.cz>
Subject: Re: [-mm patch] CRYPTO_DEV_PADLOCK_AES must select CRYPTO_BLKCIPHER
Message-ID: <20060820230415.GB31693@gondor.apana.org.au>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060820160928.GN7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820160928.GN7813@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:09:28PM +0200, Adrian Bunk wrote:
> 
> BTW: The Kconfig+Makefile parts for padlock-sha seem to be missing.

Thanks Adrian.

> --- linux-2.6.18-rc4-mm2/drivers/crypto/Kconfig.old	2006-08-20 17:28:46.000000000 +0200
> +++ linux-2.6.18-rc4-mm2/drivers/crypto/Kconfig	2006-08-20 17:44:56.000000000 +0200
> @@ -16,6 +16,7 @@
>  config CRYPTO_DEV_PADLOCK_AES
>  	bool "Support for AES in VIA PadLock"
>  	depends on CRYPTO_DEV_PADLOCK
> +	select CRYPTO_BLKCIPHER
>  	default y
>  	help
>  	  Use VIA PadLock for AES algorithm.

Andrew, there is definitely something screwed up.  If you look at
my tree this patch is already in the top changeset that was
supposedly picked up by yout pull:

GIT aabffae140135096195f6fb04d165bb204517db2 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

commit aabffae140135096195f6fb04d165bb204517db2
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Aug 15 22:49:54 2006 +1000

    [CRYPTO] Kconfig: Added missing selects on BLKCIPHER
    
    Since padlock-aes and aes-s390/des-s390 now use the block cipher interface,
    they need to select the BLKCIPHER Kconfig option.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Indeed, the s390 bits are there.  However, the padlock bits have
gong missing.  Perhaps there was a problem when it was merged with
the geode tree? This could explain why the Makefile bits for padlock
went missing too.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
