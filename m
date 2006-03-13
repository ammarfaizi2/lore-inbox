Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWCMKoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCMKoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCMKoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:44:00 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:18956
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751536AbWCMKn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:43:58 -0500
Date: Mon, 13 Mar 2006 21:43:36 +1100
To: Matt Mackall <mpm@selenic.com>
Cc: Andreas Schwab <schwab@suse.de>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] crypto: fix key alignment in tcrypt
Message-ID: <20060313104336.GB7269@gondor.apana.org.au>
References: <20060308.231155.63512624.nemoto@toshiba-tops.co.jp> <20060311231238.GJ7110@waste.org> <jeirqktvb0.fsf@sykes.suse.de> <20060311234841.GI28168@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311234841.GI28168@waste.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 05:48:41PM -0600, Matt Mackall wrote:
>
> > > Wouldn't it be better to simply move this to the head of the structure?
> > 
> > That wouldn't help, since the whole structure will still be only 8-bit
> > aligned.
> 
> Ahh, hadn't noticed the struct was entirely populated by chars.

Actually moving it to the head is good anyway because we may reduce the
amount of padding between vectors.  On i386 however it is size-neutral
with respect to the vectors.  However, it did save 45 bytes on the code
front.

I've applied the patch with the structure rearrangement so that the large
power-of-2 sized members come first.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
