Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVDSMwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVDSMwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDSMwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:52:18 -0400
Received: from [213.170.72.194] ([213.170.72.194]:6557 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261493AbVDSMwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:52:00 -0400
Message-ID: <4264FEEC.7090406@yandex.ru>
Date: Tue, 19 Apr 2005 16:51:56 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [RFC] CryptoAPI & Compression
References: <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <1112527158.3899.213.camel@localhost.localdomain> <20050403114045.GA21255@gondor.apana.org.au> <4250175D.5070704@yandex.ru> <20050403213207.GA24462@gondor.apana.org.au> <4263CDA9.7070207@yandex.ru> <20050419092522.GA5979@gondor.apana.org.au>
In-Reply-To: <20050419092522.GA5979@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Xu wrote:
>>Actually, for JFFS2 we need to leave the uncompressable data 
>>uncompressed. So if the pcompress interface have only been for JFFS2, 
>>I'd just return an error rather then expand data. Is such behavior 
>>acceptable for common Linux's parts pike CryptoAPI ?
> You mean you no longer need pcompress and we can get rid of it?
> That's fine by me.

Pardon Herbert, I didn't say anything about getting rid yet :-) I've 
just reread what I wrote and didn't find a drop of that :-) But if I was 
fuzzy, I'm sorry.

I meant there are 2 situations:
1. input data is compressible;
2. input data isn't compressible.

JFFS2 wants the following from pcompress():
1. compressible data: compress it; the offered formerly algorithm works 
just fine here.
2. non-compressible data: do not compress it, leave it uncompressed; the 
offered algorithm works fine here too - it returns an error.

So, the essence of the question was: the offered algorithm is OK for 
JFFS2 (but need some refining). May we preserve it and don't bother 
about predicting how much buffer space we need to reserve in case the 
input data is non-compressible?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
