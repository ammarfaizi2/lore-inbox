Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVDAO6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVDAO6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDAO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:58:06 -0500
Received: from fobos.marketsite.ru ([62.152.84.30]:25351 "EHLO
	relay1.dataart.com") by vger.kernel.org with ESMTP id S262756AbVDAO6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:58:02 -0500
Message-ID: <424D6175.8000700@yandex.ru>
Date: Fri, 01 Apr 2005 18:57:57 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>	 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <1112366647.3899.66.camel@localhost.localdomain>
In-Reply-To: <1112366647.3899.66.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> Hm. Could we avoid using Z_SYNC_FLUSH and stick with a larger amount?
> That would give us better compression.

Yes, the compression will be better. But the implementation will be more 
complicated.
We can try to use the "bound" functions to predict how many bytes to 
pass to the deflate's input, but there is no guarantee they'll fit into 
the output buffer. In this case we'll need to try again.

Possibly, we may do something like this:

Try good compression using the prediction technique.
If we didn't fit the output buffer, use the old but determined algorithm.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
