Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWHTQOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWHTQOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWHTQOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:14:50 -0400
Received: from 1wt.eu ([62.212.114.60]:47888 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750762AbWHTQOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:14:49 -0400
Date: Sun, 20 Aug 2006 18:13:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060820161346.GH602@1wt.eu>
References: <20060820002346.GA16995@openwall.com> <20060820080403.GA602@1wt.eu> <20060820144908.GA19602@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820144908.GA19602@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:49:08PM +0400, Solar Designer wrote:
> On Sun, Aug 20, 2006 at 10:04:03AM +0200, Willy Tarreau wrote:
> > On Sun, Aug 20, 2006 at 04:23:46AM +0400, Solar Designer wrote:
> > > The attached patch actually defines ecb_encrypt_iv() and
> > > ecb_decrypt_iv() functions that perform ECB encryption/decryption
> > > ignoring the IV, yet return -ENOSYS (just like nocrypt_iv would).
> > > The result is no more Oopses and no infoleaks either.
> > 
> > Can the cryptoloop patch use CRYPTO_TFM_MODE_CFB or CRYPTO_TFM_MODE_CTR
> > and so be redirected to nocrypt() which will leave uninitialized memory
> > too ?
> 
> At least patch-cryptoloop-jari-2.4.22.0 in particular will only do CBC
> (default, preferred) or ECB (if requested); it won't attempt to use CFB
> or CTR.
> 
> Regarding nocrypt*():
> 
> > I wonder whether we shouldn't consider that those functions must at
> > least clear the memory area that was submitted to them, such as
> > proposed below. It would also fix the problem for potential other
> > users.
> 
> This makes sense to me, although it is not perfect as Herbert has
> correctly pointed out:
> 
> > If the user is ignoring the error value here then you're in serious
> > trouble anyway since they've just lost all their data.
>
> Can we maybe define working but IV-ignoring functions for ECB (like I
> did), but use memory-clearing nocrypt*() for CFB and CTR (as long as
> these are not supported)?  Of course, all of these will return -ENOSYS.

I thought we would not have to protect users from shooting themselves in
the foot (right now they get an oops). But I agree that the cost of
protecting them is close to zero so we probably should do it. If Herbert
is OK, do you care to provide a new patch ?

> Alexander

Thanks,
willy

