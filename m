Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUHUKcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUHUKcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUHUKcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 06:32:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53223 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268968AbUHUKcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 06:32:17 -0400
Date: Sat, 21 Aug 2004 12:32:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
Message-ID: <20040821103208.GF6755@suse.de>
References: <20040802131150.GR10496@suse.de> <200408191514.13022.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191514.13022.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19 2004, Bartlomiej Zolnierkiewicz wrote:
> > 2.6 breaks really really easily if you have any traffic on a device and
> > issue a hdparm (or similar) command to it. Things like set_using_dma()
> > and ide_set_xfer_rate() just stomp all over the drive regardless of what
> > it's doing right now.
> 
> Yep, known problem.

Something should be done about it, it's pretty critical imho.

> > I hacked something up for the SUSE kernel to fix this _almost_, it still
> > doesn't handle cases where you want to serialize across more than a
> > single channel. Not a common case, but I think there is such hardware
> > out there (which?).
> >
> > Clearly something needs to be done about this, it's extremely
> > frustrating not to be able to reliably turn on dma on a drive at all.
> > I'm just tossing this one out there to solve 99% of the case, I'd like
> > some input from you on what you feel we should do.
> 
> What about adding new kind of REQ_SPECIAL request and converting 
> set_using_dma(), set_xfer_rate(), ..., to be callback functions for this 
> request?
> 
> This should be a lot cleaner and will cover 100% cases.

That will still only serialize per-channel. But yes, a lot cleaner.

-- 
Jens Axboe

