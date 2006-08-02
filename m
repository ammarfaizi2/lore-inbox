Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHBLGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHBLGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 07:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHBLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 07:06:06 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:61864 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750767AbWHBLGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 07:06:05 -0400
Date: Wed, 2 Aug 2006 13:06:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert.xu@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060802110607.GS20108@suse.de>
References: <20060801030443.GA2221@gondor.apana.org.au> <p73psfkz1wd.fsf@verdi.suse.de> <20060801220954.GC11025@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801220954.GC11025@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02 2006, Herbert Xu wrote:
> On Tue, Aug 01, 2006 at 09:33:54PM +0200, Andi Kleen wrote:
> > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > index 71649ef..b998f08 100644
> > > --- a/fs/buffer.c
> > > +++ b/fs/buffer.c
> > > @@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
> > >  	BUG_ON(!buffer_locked(bh));
> > >  	BUG_ON(!buffer_mapped(bh));
> > >  	BUG_ON(!bh->b_end_io);
> > > +	WARN_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);
> > 
> > What happens when someone implements direct large page IO?
> 
> Then they'll need to change submit_bh to generate more than one bvec.
> At that time they can remove this warning :)

Or just use a proper interface, no new code should touch submit_bh().

-- 
Jens Axboe

