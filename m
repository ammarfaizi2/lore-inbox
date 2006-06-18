Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWFRLbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFRLbv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFRLbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:31:51 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:13829 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751162AbWFRLbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:31:50 -0400
Date: Sun, 18 Jun 2006 21:31:38 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060618113138.GA22097@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <200606080920.04480.jfritschi@freenet.de> <20060608072735.GA10613@gondor.apana.org.au> <200606161358.53036.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606161358.53036.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 01:58:52PM +0200, Joachim Fritschi wrote:
>
> I have done the changes you requested. twofish and twofish_common are now 2
> seperate modules. twofish_common is hidden from the user and can be shared by 
> both generic-c and the asm implementation.

Thanks, but unfortunately your patch doesn't apply for me.  You should
base your work on the tree at

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/

  
> +config CRYPTO_TWOFISH_COMMON
> +        tristate	
> +        depends on CRYPTO
> +        help
> +	  Common parts of the Twofish cipher algorithm shared by the 
> +	  generic c and the assembler implementations.

Please drop the help (it's not meant to be visible) and add a 'default n'
instead.

> diff -uprN linux-2.6.17-rc5/crypto/twofish_common.c linux-2.6.17-rc5.twofish/crypto/twofish_common.c
> --- linux-2.6.17-rc5/crypto/twofish_common.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc5.twofish/crypto/twofish_common.c	2006-06-11 15:58:20.319984126 +0200
> @@ -0,0 +1,740 @@

...

> +static const u8 q0[256] = {
> +   0xA9, 0x67, 0xB3, 0xE8, 0x04, 0xFD, 0xA3, 0x76, 0x9A, 0x92, 0x80, 0x78,

Please take the opportunity to reformat this to use tabs.

> diff -uprN linux-2.6.17-rc5/include/crypto/twofish.h linux-2.6.17-rc5.twofish/include/crypto/twofish.h
> --- linux-2.6.17-rc5/include/crypto/twofish.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc5.twofish/include/crypto/twofish.h	2006-06-11 15:58:20.319984126 +0200
> @@ -0,0 +1,14 @@

Please add the usual preamble (see include/linux/xfrm.h for example).

> +int twofish_setkey(void *cx, const u8 *key,unsigned int key_len, u32 *flags);
					      ^ needs space here

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
