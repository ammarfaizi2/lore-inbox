Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUHWPeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUHWPeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUHWPal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:30:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48612 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265224AbUHWPL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:11:27 -0400
Date: Mon, 23 Aug 2004 17:10:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
Message-ID: <20040823151005.GV2301@suse.de>
References: <20040802131150.GR10496@suse.de> <200408211913.47982.bzolnier@elka.pw.edu.pl> <20040823121540.GN2301@suse.de> <200408231702.54426.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408231702.54426.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23 2004, Bartlomiej Zolnierkiewicz wrote:
> On Monday 23 August 2004 14:15, Jens Axboe wrote:
> > On Sat, Aug 21 2004, Bartlomiej Zolnierkiewicz wrote:
> > > On Saturday 21 August 2004 18:21, Jens Axboe wrote:
> > > > On Sat, Aug 21 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Saturday 21 August 2004 12:32, Jens Axboe wrote:
> > > > > > > What about adding new kind of REQ_SPECIAL request and converting
> > > > > > > set_using_dma(), set_xfer_rate(), ..., to be callback functions
> > > > > > > for this request?
> > > > > > >
> > > > > > > This should be a lot cleaner and will cover 100% cases.
> > > > > >
> > > > > > That will still only serialize per-channel. But yes, a lot cleaner.
> > > > >
> > > > > per hwgroup not per channel
> > > > > (serializing per host device will be better but requires even more
> > > > > work)
> > > >
> > > > Sorry yes hwgroup, that's what I meant. The case I worried about in my
> > > > patch (and noted) is that it doesn't cover per-hwif and neither would a
> > > > special request.
> > >
> > > I guess you meant 'per-host' because hwif == channel.
> > >
> > > [ You are of course right for about 'per-host' case. ]
> >
> > Yep, per host. So REQ_SPECIAL-like approach is cleaner, but doesn't
> > cover more cases than a simple hwif pinning would anyways. You'd need
> > some code to quisce the host in any case.
> 
> No, REQ_SPECIAL-like approach would serialize per ide_hwgroup_t and 
> ide_hwgroup_t may serialize more then one ide_hwif_t.  See ide-probe.c.

I see, that would work. So you would need to doctor some message type
system for these requests. Are you going to do this?

-- 
Jens Axboe

