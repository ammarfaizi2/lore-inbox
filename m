Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVDCKBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVDCKBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDCKBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:01:43 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:43273 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261638AbVDCKBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:01:38 -0400
Date: Sun, 3 Apr 2005 20:00:43 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403100043.GA20768@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FBB56.5090503@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 01:45:58PM +0400, Artem B. Bityuckiy wrote:
> 
> Here is a cite from RFC-1951 (page 4):
> 
>    A compressed data set consists of a series of blocks, corresponding
>    to successive blocks of input data.  The block sizes are arbitrary,
>    except that non-compressible blocks are limited to 65,535 bytes.
> 
> Thus,
> 
> 1. 64K is only applied to non-compressible data, in which case zlib just 
> copies it as it is, adding a 1-byte header and a 1-byte EOB marker.

I think the overhead could be higher.  But even if it is 2 bytes
per block, then for 1M of incompressible input the total overhead is

2 * 1048576 / 65536 = 32

bytes.

Also I'm not certain if it will actually create 64K blocks.  It might
be as low as 16K according to the zlib documentation.

> 3. If zlib compressed data (i.e., applied LZ77 & Huffman), blocks may 
> have arbitrary length.

Actually there is a limit on that too but that's not relevant to
this discussion.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
