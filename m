Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVB1RkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVB1RkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVB1RkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:40:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46511 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261705AbVB1RkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:40:17 -0500
Date: Mon, 28 Feb 2005 18:40:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Olien <dmo@osdl.org>
Cc: Mark Haverkamp <markh@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
Message-ID: <20050228174012.GL8868@suse.de>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net> <20050225161947.5fd6d343.akpm@osdl.org> <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org> <20050226123934.GA1254@suse.de> <1109604737.30227.3.camel@markh1.pdx.osdl.net> <20050228155127.GI8868@suse.de> <20050228173542.GA16815@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228173542.GA16815@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28 2005, Dave Olien wrote:
> 
> Just trivial, I think you're missing the final "0" argument
> in the __bio_for_each_segment().

Yep indeed, was just a hasty edit...

> 
> On Mon, Feb 28, 2005 at 04:51:28PM +0100, Jens Axboe wrote:
> > This should fix it.
> > 
> > Signed-off-by: Jens Axboe <axboe@suse.de>
> > 
> > 
> > ===== mm/highmem.c 1.55 vs edited =====
> > --- 1.55/mm/highmem.c	2005-01-08 06:44:13 +01:00
> > +++ edited/mm/highmem.c	2005-02-28 16:50:59 +01:00
> > @@ -425,7 +425,7 @@
> >  	 * at least one page was bounced, fill in possible non-highmem
> >  	 * pages
> >  	 */
> > -	bio_for_each_segment(from, *bio_orig, i) {
> > +	__bio_for_each_segment(from, *bio_orig, i) {
> >  		to = bio_iovec_idx(bio, i);
> >  		if (!to->bv_page) {
> >  			to->bv_page = from->bv_page;
> > 
> > -- 
> > Jens Axboe
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Jens Axboe

