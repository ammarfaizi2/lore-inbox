Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTFFEV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 00:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTFFEV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 00:21:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1189 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265295AbTFFEV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 00:21:56 -0400
Date: Fri, 6 Jun 2003 06:35:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 2
Message-ID: <20030606043530.GD470@suse.de>
References: <1054820805.766.10.camel@gaston> <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05 2003, Bartlomiej Zolnierkiewicz wrote:
> > Jens, Bart, what do you think ? Should I add pm_step & pm_state to
> > struct request ? Do the "extended taskfile structure" thing ? Or just
> > keep things like they are in this new patch and forget about carrying
> > the PM state value ?
> 
> I think extending struct request is the way to go,
> pm_step & pm_state or even pointer to rq_pm_struct.

Agree

> > I also added another rq->flags bit for requests forced at the head of
> > the queue with ide_preempt. This is typically for sense requests done
> > by ide-cd (though I also spotted a user in the tcq stuff). I need that
> > to make sure that if such a request ever happens to be pushed in front
> > of the current PM request (with the drive->blocked flag already set),
> > we don't enter an endless loop, fetching that new request and dropping
> > it right away because we only accept PM requests from the queue once
> > the drive is suspended.
> 
> Jens, I think generic version of ide_do_drive_cmd() would be useful for
> other block devices, what do you think?

Yes very much so, scsi_ioctl also basically implements part of this
functionality.

-- 
Jens Axboe

