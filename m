Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDCJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDCJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDCJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:20:27 -0400
Received: from [213.170.72.194] ([213.170.72.194]:37840 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261626AbVDCJUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:20:18 -0400
Message-ID: <424FB550.1070105@yandex.ru>
Date: Sun, 03 Apr 2005 13:20:16 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au>
In-Reply-To: <20050403084415.GA20326@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Xu wrote:
> On Sun, Apr 03, 2005 at 12:22:12PM +0400, Artem B. Bityuckiy wrote:
> 
>>The latter case is possible if the input isn't compressible and it is up 
>>to user to detect that handle this situation properly (i.e., just not to 
>>compress this). So, IMO, there are no problems here at least for the 
>>crypto_comp_pcompress() function.
> 

I meant here, that user a-priori doesn't always know how good will his 
data be compressed. So, he *may* provide the output buffer of the same 
size as the input buffer (as you wrote, both are of 1GiB). So, if the 
input data *grows* after the compression, then crypto_comp_pcompress() 
will fill the output buffer fully and return OK, indicating that not all 
the input was compressed. And it is up to user to handle this situation. 
Probably he will just leave his data uncompressed. Probably he will 
provide more output buffers. I just wanted to say, that 
crypto_comp_pcompress() will work OK even in the case of uncompressible 
data because I thought something worries you in this case :-)

> Surely that defeats the purpose of pcompress? I thought the whole point
> was to compress as much of the input as possible into the output?
> 
> So 1G into 1G doesn't make sense here.  But 1G into 1M does and you
> want to put as much as you can in there.  Otherwise we might as well
> delete crypto_comp_pcompress :)

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
