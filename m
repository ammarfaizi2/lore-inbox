Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVDAPmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVDAPmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVDAPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:42:55 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:27147 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262759AbVDAPmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:42:11 -0500
Date: Fri, 1 Apr 2005 16:41:44 +0100 (BST)
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
In-Reply-To: <20050401152325.GB4150@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
 <20050401152325.GB4150@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought stored blocks (incompressible blocks) were limited to 64K
> in size, no?
Blocks are limited in size by 64K, true. But why it matters for us? 

Suppose we compress 1 GiB of input, and have a 70K output buffer. We 
reserve 5 bytes at the end and start calling zlib_deflate(stream, 
Z_SYNCK_FLUSH) recurrently. It puts one 64K block, puts its end marker, 
then puts a part of a second block. Then we call zlib_deflate(strem, 
Z_FINISH) and it puts the end marker of the second block and the adler32 
checksum of the entire stream. So I don't see any problem albeit I didn't 
try yet :-) But I'll do.

> Please double check zlib_deflate/deflate.c and
> zlib_deflate/deftree.c.
Surely I'll check. I'll even test the new implementation (which I didn't 
actually do) with a large input before sending it next time.

--
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
