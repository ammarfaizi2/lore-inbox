Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUHWMRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUHWMRy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUHWMRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:17:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9632 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263769AbUHWMRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:17:03 -0400
Date: Mon, 23 Aug 2004 14:15:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
Message-ID: <20040823121540.GN2301@suse.de>
References: <20040802131150.GR10496@suse.de> <200408211643.55531.bzolnier@elka.pw.edu.pl> <20040821162155.GC7490@suse.de> <200408211913.47982.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408211913.47982.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21 2004, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 21 August 2004 18:21, Jens Axboe wrote:
> > On Sat, Aug 21 2004, Bartlomiej Zolnierkiewicz wrote:
> > > On Saturday 21 August 2004 12:32, Jens Axboe wrote:
> > > > > What about adding new kind of REQ_SPECIAL request and converting
> > > > > set_using_dma(), set_xfer_rate(), ..., to be callback functions for
> > > > > this request?
> > > > >
> > > > > This should be a lot cleaner and will cover 100% cases.
> > > >
> > > > That will still only serialize per-channel. But yes, a lot cleaner.
> > >
> > > per hwgroup not per channel
> > > (serializing per host device will be better but requires even more work)
> >
> > Sorry yes hwgroup, that's what I meant. The case I worried about in my
> > patch (and noted) is that it doesn't cover per-hwif and neither would a
> > special request.
> 
> I guess you meant 'per-host' because hwif == channel.
> 
> [ You are of course right for about 'per-host' case. ]

Yep, per host. So REQ_SPECIAL-like approach is cleaner, but doesn't
cover more cases than a simple hwif pinning would anyways. You'd need
some code to quisce the host in any case.

-- 
Jens Axboe

