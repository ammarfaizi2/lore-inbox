Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVDCMBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDCMBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVDCMBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:01:25 -0400
Received: from [213.170.72.194] ([213.170.72.194]:29153 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261701AbVDCMBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:01:20 -0400
Message-ID: <424FDB0F.6000304@yandex.ru>
Date: Sun, 03 Apr 2005 16:01:19 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru> <20050403114704.GC21255@gondor.apana.org.au>
In-Reply-To: <20050403114704.GC21255@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Xu wrote:
> On Sun, Apr 03, 2005 at 03:41:07PM +0400, Artem B. Bityuckiy wrote:
> 
>>I also wonder, does it at all correct to use negative windowBits in 
>>crypto API? I mean, if windowBits is negative, zlib doesn't produce the 
> 
> 
> It's absolutely correct for IPComp.  For other uses it may or may not
> be correct.
I've looked through RFC-2394 quickly, but didn't found any mention about 
non-complient zstreams. I suppose they must be complient by default. 
Although I'm far not an expert in the area.

> For instance for JFFS2 it's absolutely incorrect since it breaks
> compatibility.  Incidentally, JFFS should create a new compression
> type that doesn't include the zlib header so that we don't need the
> head-skipping speed hack.
Anyway, in JFFS2 we may do that "hack" before calling pcompress(), so it 
isn't big problem.

> Yes, I'd love to see a patch that makes windowBits configurable in
> crypto/deflate.c.
I wonder, do we really want this?

Imagine we have 100 different compressors, and each is differently 
configurable. It may make cryptoAPI messy. May be it is better to stand 
that user must use deflate (and the other 99 compressors) directly if he 
wants something not standard/compliant?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
