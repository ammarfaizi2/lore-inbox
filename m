Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVDCJqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVDCJqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDCJqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:46:07 -0400
Received: from [213.170.72.194] ([213.170.72.194]:468 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261628AbVDCJqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:46:01 -0400
Message-ID: <424FBB56.5090503@yandex.ru>
Date: Sun, 03 Apr 2005 13:45:58 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au>
In-Reply-To: <20050403093044.GA20608@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Xu wrote:
> You can't compress 1M-12bytes into 1M using zlib when the block size
> is 64K.
Here is a cite from RFC-1951 (page 4):

    A compressed data set consists of a series of blocks, corresponding
    to successive blocks of input data.  The block sizes are arbitrary,
    except that non-compressible blocks are limited to 65,535 bytes.

Thus,

1. 64K is only applied to non-compressible data, in which case zlib just 
copies it as it is, adding a 1-byte header and a 1-byte EOB marker.

2. 64K is just the *upper limit*, and blocks may be shorter.

3. If zlib compressed data (i.e., applied LZ77 & Huffman), blocks may 
have arbitrary length.

So, I don't see any reason why I can't.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
