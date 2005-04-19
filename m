Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVDSWLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVDSWLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVDSWLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:11:33 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9740 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261685AbVDSWL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:11:26 -0400
Date: Wed, 20 Apr 2005 08:10:36 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050419221036.GA26756@gondor.apana.org.au>
References: <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <1112527158.3899.213.camel@localhost.localdomain> <20050403114045.GA21255@gondor.apana.org.au> <4250175D.5070704@yandex.ru> <20050403213207.GA24462@gondor.apana.org.au> <4263CDA9.7070207@yandex.ru> <20050419092522.GA5979@gondor.apana.org.au> <4264FEEC.7090406@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4264FEEC.7090406@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 04:51:56PM +0400, Artem B. Bityuckiy wrote:
> 
> JFFS2 wants the following from pcompress():
> 1. compressible data: compress it; the offered formerly algorithm works 
> just fine here.

Yes but the existing JFFS algorithm does a lot more than that.  It tries
to pack as much data as possible into the output buffer.

> 2. non-compressible data: do not compress it, leave it uncompressed; the 
> offered algorithm works fine here too - it returns an error.

If all you need is to compress what's compressible you don't need
pcompress at all.  You just need to call the normal compress method
with the input length clamped by the output buffer size.  If the
function returns OK then it's compressible, otherwise it isn't.

You can even do the existing JFFS loop this way too.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
