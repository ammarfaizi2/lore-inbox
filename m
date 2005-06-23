Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVFWVxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVFWVxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVFWVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:49:24 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18184 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262715AbVFWViq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:38:46 -0400
Date: Fri, 24 Jun 2005 07:38:30 +1000
To: "Kluba, Patrik" <pajko@halom.u-szeged.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Ferenc Havasi <havasi@inf.u-szeged.hu>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Michal Ludvig <michal@logix.cz>
Subject: Re: cryptoapi compression modules & JFFSx
Message-ID: <20050623213830.GA3803@gondor.apana.org.au>
References: <1119555217l.7540l.1l@detonator>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119555217l.7540l.1l@detonator>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 07:33:37PM +0000, Kluba, Patrik wrote:
> 
> I'm going to port JFFS2's compression modules to CryptoApi except  
> {in|de}flate, which Artem is working(?) on.
> I've noticed that the pcompress thing (slen <-> *slen and partial  
> compression which about a discussion was on the list) is in Herbert's  
> repository. Does it mean that it will get into the kernel once? I just  
> would like to be sure whether should I implement pcompress or not.

Well I've removed it actually because Artem said he didn't need it
anymore.

However, if you can provide an implementation of pcompress for deflate
that's generic enough then I'm happy to put it back.  By genericity
I mean not making assumptions such as the input buffer size being
less than 4K.

> The second thing is that we would like to use CryptoApi from user  
> space. This way it won't be necessary to reimplement compression  
> algorithms in user space filesystem image creation programs  
> (mkfs.jffsx), and it would make using & distributing closed-source  
> proprietary compression methods easier.
> There's a patch at http://www.logix.cz/michal/devel/cryptodev/, written  
> by Michal Ludvig, which adds a /dev/crypto device for this purpose, as  
> on *BSD. Is there a chance that this can get into the kernel?

Something liks this will be included once we have async crypto.  However,
that could be a while yet so I suggest that you start by including the
deflate implementation in user-space.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
