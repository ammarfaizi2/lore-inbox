Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVDAP0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVDAP0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDAPYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:24:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:16132 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262771AbVDAPYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:24:14 -0500
Date: Sat, 2 Apr 2005 01:23:25 +1000
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050401152325.GB4150@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 03:36:23PM +0100, Artem B. Bityuckiy wrote:
> 
> In our code we do zlib_deflate(stream, Z_SYNC_FLUSH), so we always flush 
> the output. So the final zlib_deflate(stream, Z_FINISH) requires 1 byte 
> for the EOB marker and 4 bytes for adler32 (5 bytes total). Thats all. If 
> we compress a huge buffer, then we still need to output those 5 bytes as 
> well. I.e, the overhead of each block *is not accumulated* ! I even need 
> to make the reserved space less then 12 bytes!

I thought stored blocks (incompressible blocks) were limited to 64K
in size, no? Please double check zlib_deflate/deflate.c and
zlib_deflate/deftree.c.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
