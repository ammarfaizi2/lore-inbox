Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDCKG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDCKG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDCKG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:06:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261638AbVDCKGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:06:22 -0400
Subject: Re: [RFC] CryptoAPI & Compression
From: David Woodhouse <dwmw2@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
In-Reply-To: <20050403100043.GA20768@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
	 <20050401152325.GB4150@gondor.apana.org.au>
	 <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org>
	 <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru>
	 <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru>
	 <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru>
	 <20050403100043.GA20768@gondor.apana.org.au>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 11:06:01 +0100
Message-Id: <1112522762.3899.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 20:00 +1000, Herbert Xu wrote:
> > 1. 64K is only applied to non-compressible data, in which case zlib just 
> > copies it as it is, adding a 1-byte header and a 1-byte EOB marker.
> 
> I think the overhead could be higher.  But even if it is 2 bytes
> per block, then for 1M of incompressible input the total overhead is
> 
> 2 * 1048576 / 65536 = 32

We're not interested in the _total_ overhead, in this context. We're
interested in the number of bytes we have to have available in the
output buffer in order to let zlib finish its stream.

In the case of a 1MiB input generating 32 uncompressable 64KiB blocks,
the end markers for the first 31 blocks are going to be in our output
buffer already, so we don't need to leave space for them.

-- 
dwmw2

