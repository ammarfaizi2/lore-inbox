Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269877AbTGKKlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbTGKKlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:41:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48025 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269877AbTGKKlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:41:04 -0400
Date: Fri, 11 Jul 2003 12:55:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-ID: <20030711105543.GS843@suse.de>
References: <20030711083437.GG843@suse.de> <Pine.SOL.4.30.0307111250430.23682-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307111250430.23682-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On Fri, 11 Jul 2003, Jens Axboe wrote:
> 
> > On Fri, Jul 11 2003, Jens Axboe wrote:
> > > On Fri, Jul 11 2003, Jens Axboe wrote:
> > > > On Thu, Jul 10 2003, Ivan Gyurdiev wrote:
> > > > > See,
> > > > >
> > > > > http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html
> > > > >
> > > > > where the bug is described for 2.5.74.
> > > > > I got no replies, and the bug persists in 2.5.75 (+bk patches).
> > > > >
> > > > > Note:
> > > > > The machine boots with TASKFILE on, TCQ is causing the problem.
> > > >
> > > > Looks like IDE using the queue before it has been setup, probably Bart
> > > > broke it when he moved the TCQ init around. I'll take a look.
> > >
> > > Here's the fix. Bart, you moved the tcq init to a much earlier fase
> > > (saying ide_init_drive() was too early, well ide_dma_on is much earlier
> > > in the init fase). ide_init_drive() _is_ the correct location in my
> > > oppinion, drive and queue has been set up at this point.
> 
> Yes, but hey you've acked this change ;-).

I know, I'll carry (let me see) 30% of the blame :)

> > Better still (and later in the probe) is this version. This is in my
> > oppinion the correct place to init tcq, and also contains it to ide-disk
> > where it should be.
> 
> Looks okay, thanks.

Thanks, I'll forward it then.

-- 
Jens Axboe

