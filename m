Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWHTLUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHTLUd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 07:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWHTLUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 07:20:33 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:19473 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750740AbWHTLUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 07:20:32 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: w@1wt.eu (Willy Tarreau)
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Cc: solar@openwall.com, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Organization: Core
In-Reply-To: <20060820080403.GA602@1wt.eu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GElLd-0006HN-00@gondolin.me.apana.org.au>
Date: Sun, 20 Aug 2006 21:20:09 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> wrote:
> 
> That's what I thought after reading the code too. BTW, 2.6 does not
> initialize the pointers either.

This has been changed in the cryptodev-2.6 tree:

http://www.kernel.org/git/?p=linux/kernel/git/herbert/cryptodev-2.6.git;a=commitdiff;h=310d6a0c14eda153869adaf74e69dbd1a1256e7f

[CRYPTO] cipher: Removed special IV checks for ECB

This patch makes IV operations on ECB fail through nocrypt_iv rather than
calling BUG().  This is needed to generalise CBC/ECB using the template
mechanism.

In fact with the new block cipher type calling the IV-specific
functions on ECB will work in the same way as the IV-less functions.
This makes sense because the IV length is simply zero.
 
> I wonder whether we shouldn't consider that those functions must at
> least clear the memory area that was submitted to them, such as
> proposed below. It would also fix the problem for potential other
> users. I don't think we need to check whether dst is valid given
> the small amount of tests performed in crypt().

If the user is ignoring the error value here then you're in serious
trouble anyway since they've just lost all their data.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
