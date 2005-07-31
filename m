Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGaFuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGaFuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGaFuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:50:10 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:3857 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261722AbVGaFuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:50:08 -0400
Date: Sun, 31 Jul 2005 15:49:58 +1000
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cryptoapi deflate not handling PAGE_SIZE chunks.
Message-ID: <20050731054958.GA6485@gondor.apana.org.au>
References: <1121657195.13487.36.camel@localhost> <20050731034010.GA5564@gondor.apana.org.au> <1122786842.4351.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122786842.4351.8.camel@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 03:14:02PM +1000, Nigel Cunningham wrote:
> 
> Yes, Suspend2 if the user selects deflate as their compressor. The
> output data will be PAGE_SIZE chunks, but deflate sometimes thinks it
> has an extra byte to give us back.

Are you saying that you're feeding it PAGE_SIZE chunks and it's
giving you back something bigger than a page? That is expected
since the nature of compression in general is that not everything
is compressible.  Data streams which are not compressible will
end up bigger than what you start with.

What would be a bug is if you feed it something that's
deflateBound^-1(PAGE_SIZE) bytes long and it spits back
something that's longer than a page.

> I agree that it's ugly and don't recall using it when I had gzip support
> in an earlier version of Suspend2. Are you thinking there might be a
> better way? If so, I can dig out the old (non crypto api) code.

Well if you could give me a snippet of code that actually uses this
stuff to compress pages then I might have a better idea of what it's
trying to do.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
