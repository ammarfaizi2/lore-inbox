Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVEXDvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVEXDvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEXDve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:51:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:61963 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261265AbVEXDvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:51:11 -0400
Date: Tue, 24 May 2005 13:50:56 +1000
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, davem@davemloft.net
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
Message-ID: <20050524035056.GB29699@gondor.apana.org.au>
References: <20050524024318.GB29242@gondor.apana.org.au> <Xine.LNX.4.44.0505232319450.1507-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0505232319450.1507-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 11:20:26PM -0400, James Morris wrote:
> 
> a) remove the scheudling point and see if anyone complains
> b) if so, add a flag

OK.  I think we should go with the flag though since it could
also be used for memory allocation.

I've just added some code which allocates a scratch space for
unaligned input to the VIA Padlock (IPv4 ESP traffic is normally
unaligned due to the 20-byte IP header).  It could use this flag
to determine whether it should do GFP_KERNEL or GFP_ATOMIC.

Actually, has anyone considered using a 4-byte IP option padding?
It's legal per RFC-791 but it'd be interesting to know how well
it works in the field.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
