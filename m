Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDTJaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDTJaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDTJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:30:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34310 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750780AbWDTJa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:30:29 -0400
Date: Thu, 20 Apr 2006 11:30:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-ID: <20060420093056.GA614@suse.de>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <17479.21320.361708.237802@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17479.21320.361708.237802@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, Neil Brown wrote:
> On Thursday April 20, akpm@osdl.org wrote:
> > > Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
> > > Signed-off-by: Neil Brown <neilb@suse.de>
> > > 
> > > ### Diffstat output
> > >  ./mm/truncate.c |   10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > 
> > > diff ./mm/truncate.c~current~ ./mm/truncate.c
> > > --- ./mm/truncate.c~current~	2006-04-20 15:27:22.000000000 +1000
> > > +++ ./mm/truncate.c	2006-04-20 15:38:20.000000000 +1000
> > > @@ -238,13 +238,11 @@ unsigned long invalidate_mapping_pages(s
> > >  		for (i = 0; i < pagevec_count(&pvec); i++) {
> > >  			struct page *page = pvec.pages[i];
> > >  
> > > -			if (TestSetPageLocked(page)) {
> > > -				next++;
> > > +			next = page->index+1;
> > > +
> > > +			if (TestSetPageLocked(page))
> > >  				continue;
> > > -			}
> > > -			if (page->index > next)
> > > -				next = page->index;
> > > -			next++;
> > > +
> > >  			if (PageDirty(page) || PageWriteback(page))
> > >  				goto unlock;
> > >  			if (page_mapped(page))
> > 
> > We're not supposed to look at page->index of an unlocked page.
> 
> We're not?  Does Jens know that?
> __generic_file_splice_read seems to violate this principle!

Hmmm, where?


-- 
Jens Axboe

