Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVDCLsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVDCLsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDCLsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:48:22 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:37131 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261684AbVDCLsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:48:15 -0400
Date: Sun, 3 Apr 2005 21:47:04 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403114704.GC21255@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FD653.7020204@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 03:41:07PM +0400, Artem B. Bityuckiy wrote:
> 
> I also wonder, does it at all correct to use negative windowBits in 
> crypto API? I mean, if windowBits is negative, zlib doesn't produce the 

It's absolutely correct for IPComp.  For other uses it may or may not
be correct.

For instance for JFFS2 it's absolutely incorrect since it breaks
compatibility.  Incidentally, JFFS should create a new compression
type that doesn't include the zlib header so that we don't need the
head-skipping speed hack.

> proper zstream header, which is incorrect according to RFC-1950. It also 

Can you please point me to the paragraph in RFC 1950 that says this?
 
> Isn't it conceptually right to produce *correct* zstream, with the 
> header and the proper adler32 ?

Not really.  However it should be possible if the user needs it which
is why we should make windowBits configurable.

> Yes, for JFFS2 we would like to have no adler32, we anyway protect our 
> data by CRC32. But I suppose this should be an additional feature.

Yes, I'd love to see a patch that makes windowBits configurable in
crypto/deflate.c.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
