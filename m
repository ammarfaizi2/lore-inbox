Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTEIKzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTEIKzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:55:19 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61666 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262431AbTEIKzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:55:18 -0400
Date: Fri, 9 May 2003 13:07:09 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Sanitize hwif/drive addressing (was Re: [PATCH]
 2.5 ide 48-bit usage)
In-Reply-To: <20030509082837.GG20941@suse.de>
Message-ID: <Pine.SOL.4.30.0305091305080.2995-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 May 2003, Jens Axboe wrote:

> On Fri, May 09 2003, Jens Axboe wrote:
> > On Thu, May 08 2003, Alan Cox wrote:
> > > On Iau, 2003-05-08 at 17:34, Jens Axboe wrote:
> > > > Might not be a bad idea, drive->address_mode is a heck of a lot more to
> > > > the point. I'll do a swipe of this tomorrow, if no one beats me to it.
> > >
> > > We don't know if in the future drives will support some random mask of modes.
> > > Would
> > >
> > > 	drive->lba48
> > > 	drive->lba96
> > > 	drive->..
> > >
> > > be safer ?
> >
> > I had the same thought yesterday, that just because a device does lba89
> > does not need it supports all of the lower modes. How about just using

Actually it does for 48-bit.

> > the drive->address_mode as a supported field of modes?
> >
> > if (drive->address_mode & IDE_LBA48)
> > 	lba48 = 1;
>
> How about something like the attached? Removes ->addressing from both
> drive and hwif, and adds:
>
> drive->addr_mode: capability mask of addressing modes the drive supports
> hwif->na_addr_mode: negated capability mask

Sounds sane.
--
Bartlomiej

> Patch isn't tested, so this is just a RFC. If we agree on the concept, I
> can finalize it.

