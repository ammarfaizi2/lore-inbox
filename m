Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVDAPXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVDAPXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVDAPXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:23:10 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:25355 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262766AbVDAPXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:23:02 -0500
Date: Fri, 1 Apr 2005 16:22:50 +0100 (BST)
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
In-Reply-To: <1112367926.3899.70.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0504011622350.9305@phoenix.infradead.org>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> 
 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> 
 <1112366647.3899.66.camel@localhost.localdomain>  <424D6175.8000700@yandex.ru>
 <1112367926.3899.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Fri, 2005-04-01 at 18:57 +0400, Artem B. Bityuckiy wrote:
> 
>>Yes, the compression will be better. But the implementation will be more 
>>complicated.
>>We can try to use the "bound" functions to predict how many bytes to 
>>pass to the deflate's input, but there is no guarantee they'll fit into 
>>the output buffer. In this case we'll need to try again.
> 
> 
> Can we not predict the maximum number of bytes it'll take to flush the
> stream when we're not using Z_SYNC_FLUSH?

AFAIU, no. Zlib may eat a lot of input and do not produce much output, but 
on Z_FINISH it may ask an undetermined amount of additional output space. 
So, we must even regulate the amount of input we pass to zlib_deflate(). 
In case of Z_SYNC_FLUSH, things are more determined.

Another question, does JFFSx *really* need the peaces of a 4K page to be 
independently uncompressable? It it wouldn't be required, we would achieve 
better compression if we have saved the zstream state. :-) But it is too 
late to change things at least for JFFS2.

--
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
