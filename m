Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCaLMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCaLMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCaLMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:12:20 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:55556 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261329AbVCaLMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:12:12 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dedekind@infradead.org
Subject: Re: [RFC] CryptoAPI & Compression
Cc: herbert@gondor.apana.org.au, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Organization: Core
In-Reply-To: <1112265786.21585.16.camel@sauron.oktetlabs.ru>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
Date: Thu, 31 Mar 2005 21:11:23 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityuckiy <dedekind@infradead.org> wrote:
> 
>> Good catch.  I'll apply this one.
> Only one small note: I've spotted this but didn't test. I didn't make
> sure this is OK if we haven't ever used the compression and remove the
> deflate module. (i.e, in this case we call zlib_[in|de]flateEnd() while
> we haven't ever called zlib_[in|de]flate()). Although I believe it must
> be OK, we need to try it.

It's OK because deflateReset == deflateEnd + deflateInit.  Feel free
to test it though.  You can find my tree at

bk://herbert.bkbits.net/cryptodev-2.6

> So, it seems I can't just port the JFFS2 stuff. I need to explore zlib
> more closely. Thus, I need some time. I'll inform you about my results.

For the default zlib parameters (which crypto/deflate.c does not use)
the maximum overhead is 5 bytes every 16KB plus 6 bytes.  So for input
streams less than 16KB the figure of 12 bytes is correct.  However,
in general the overhead needs to grow proportionally to the number of
blocks in the input.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
