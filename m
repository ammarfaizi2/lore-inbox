Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWGUChA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWGUChA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 22:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWGUCg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 22:36:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030440AbWGUCg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 22:36:59 -0400
Date: Fri, 21 Jul 2006 04:36:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060721023647.GA29220@suse.de>
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com> <44BFF539.4000700@garzik.org> <1153439728.4754.19.camel@mulgrave> <44C01CD7.4030308@garzik.org> <20060721010724.GB24176@suse.de> <44C02D1E.4090206@garzik.org> <20060721013822.GA25504@suse.de> <44C037B3.4080707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C037B3.4080707@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Thu, Jul 20 2006, Jeff Garzik wrote:
> >>Jens Axboe wrote:
> >>>On Thu, Jul 20 2006, Jeff Garzik wrote:
> >>>>James Bottomley wrote:
> >>>>>On Thu, 2006-07-20 at 17:27 -0400, Jeff Garzik wrote:
> >>>>>>Since _no individual SCSI driver_ uses the block layer
> >>>>>>tagging, it is likely that some instability and core kernel
> >>>>>>development
> >>>>>>will occur, in order to make that work.
> >>>>>That's not quite true: 53c700 and tmscsim both use it ... I could with
> >>>>>the usage were wider, but at least 53c700 has pretty regular and
> >>>>>constant usage ... enough I think to validate the block tag code (it's
> >>>>>been using it for the last three years).
> >>>>Not for the case being discussed in this thread, adapter-wide tags.
> >>>That just means the map is shared, otherwise there should be little if
> >>>any difference.
> >>>
> >>>>AFAICS, no file in include/scsi/* or drivers/scsi/* ever calls 
> >>>>blk_queue_init_tags() with a non-NULL third arg.
> >>>grpe again, it's in scsi_tcq.h.
> >>What tree are you looking at?
> >>
> >>There is only one user in the entire tree, and NULL is hardcoded as the 
> >>third arg.  This is 2.6.18-rc2:
> >
> >Sorry, missed your non-NULL statement, I thought you meant in generel.
> >
> >As long as you get the locking right for the map access, there's really
> >nothing that seperates shared vs non-shared tag mappings. So I don't
> >think it's a big deal.
> >
> >If we don't encourage new drivers to use the block layer tagging, we
> >might as well not bother with it.
> 
> I don't disagree it's a good thing to have.
> 
> I only assert that a --completely unused-- sub-feature cannot be a merge 
> requirement for a new driver.  That's an unreasonable standard.  We have 
> a driver that is clean and works with all well-known and well-used APIs.

The feature is used, by far the main part of it is just the tagging
itself, not the shared map feature.

> As I discovered painfully via libata, using an unused API upstream 
> (->eh_strategy_handler) can often be a destabilizing or limiting factor.
> 
> You _hope_ that this feature works, but it's far better IMO to debug an 
> unused core feature upstream.  If the upstream driver breaks when 
> host-wide blktag support is added, then it's trivial to find where the 
> breakage occurred: the stex blktag-update patch.

If I thought that it would ever be updated to use block tagging, I would
not care at all. The motivation to add it from the Promise end would be
zero, as it doesn't really bring any immediate improvements for them. So
it would have to be done by someone else, which means me or you. I don't
have the hardware to actually test it, so unless you do and would want
to do it, chances are looking slim :-)

It's a bit of a chicken and egg problem, unfortunately. The block layer
tagging _should_ be _the_ way to do it, and as such could be labelled a
requirement. I know that's a bit harsh for the Promise folks, but
unfortunately someone has to pay the price...

-- 
Jens Axboe

