Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHAWKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHAWKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHAWKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:10:03 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:6670 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751228AbWHAWKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:10:01 -0400
Date: Wed, 2 Aug 2006 08:09:54 +1000
From: Herbert Xu <herbert.xu@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801220954.GC11025@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au> <p73psfkz1wd.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73psfkz1wd.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:33:54PM +0200, Andi Kleen wrote:
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 71649ef..b998f08 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
> >  	BUG_ON(!buffer_locked(bh));
> >  	BUG_ON(!buffer_mapped(bh));
> >  	BUG_ON(!bh->b_end_io);
> > +	WARN_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);
> 
> What happens when someone implements direct large page IO?

Then they'll need to change submit_bh to generate more than one bvec.
At that time they can remove this warning :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
