Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVDCIW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDCIW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 04:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDCIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:22:26 -0400
Received: from [213.170.72.194] ([213.170.72.194]:7627 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261614AbVDCIWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:22:16 -0400
Message-ID: <424FA7B4.6050008@yandex.ru>
Date: Sun, 03 Apr 2005 12:22:12 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au>
In-Reply-To: <20050401221303.GA6557@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Xu wrote:
> The question is what happens when you compress 1 1GiB input buffer into
> a 1GiB output buffer.
If user provides 1 GB output buffer then either we successfully compress 
all the 1 GB input or we compress just a part of it.

In the former case user may provide a second output buffer and 
crypto_comp_pcompress() will compress the rest of the input to it. And 
the user will have two independently de-compressible buffers.

The latter case is possible if the input isn't compressible and it is up 
to user to detect that handle this situation properly (i.e., just not to 
compress this). So, IMO, there are no problems here at least for the 
crypto_comp_pcompress() function.

In case of crypto_comp_pcompress() if the input isn't compressible, 
error will be returned.

If somebody needs a more flexible compression interface, he may think 
about implementing an deflate-like Crypto API interface. Or something 
else like crypto_comp_compress() which saves its internal state between 
calls and may be called several times with more input/output. I didn't 
think on it but we might as well.

> It'd be a good idea to use /dev/urandom as your input.
Yes, this is what I think about. I'm going to extend the tcrypt.ko test.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
