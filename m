Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVDCKS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDCKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDCKS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:18:27 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62729 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261638AbVDCKSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:18:21 -0400
Date: Sun, 3 Apr 2005 20:17:52 +1000
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403101752.GA20866@gondor.apana.org.au>
References: <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112522762.3899.182.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 11:06:01AM +0100, David Woodhouse wrote:
> 
> We're not interested in the _total_ overhead, in this context. We're
> interested in the number of bytes we have to have available in the
> output buffer in order to let zlib finish its stream.
> 
> In the case of a 1MiB input generating 32 uncompressable 64KiB blocks,
> the end markers for the first 31 blocks are going to be in our output
> buffer already, so we don't need to leave space for them.

You might be right.  But I'm not sure yet.

If we use the current code and supply zlib_deflate with 1048576-12 bytes
of (incompressible) input and 1048576 bytes of output buffer, wouldn't
zlib keep writing incompressible blocks and return when it can't do that
anymore because the output buffer has been exhausted?

When it does return it has to finish writing the last block it's on.

So if the total overhead is 32 bytes then the last block would need
another 20 bytes of output space which we don't have, no?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
