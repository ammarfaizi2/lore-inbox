Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWAaWI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWAaWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWAaWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:08:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:13482 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751589AbWAaWI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:08:28 -0500
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
	 <1138724479.6869.201.camel@localhost.localdomain>
	 <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 09:08:42 +1100
Message-Id: <1138745323.4934.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben, code in pmac.c (+ block layer) seems to be doing something
> different then Kconfig help entry states ("Blink laptop LED on drive
> activity")?
> 
> > I'll experiment with the feasibility of the block later as I've always
> > been uneasy about the hooks into the lower level layers. There are a
> > number of issues to consider though.

The hook in the block layer was Jens idea :)

> At worst it should be handled at host driver level not device driver
> (like pmac.c and hwif->act_led).
> 
> > 1. The block layer isn't always aware of device activity (eg. flash
> > block erasing in mtd devices) (is this the case for IDE?).
> 
> Same is true for ide-disk changes - they are aware only of filesystem
> activity (no flush cache, special commands, I/O taskfiles etc.).

It wouldn't be too hard to kick the led on DMA start and off after a
timeout kicked from DMA end...

> Isn't ->end_request hook in ide_driver_t enough?
> 
> I see no reason why the custom ->end_request function cannot
> be added to ide-disk.  All needed infrastructure is there.

I'm not sure ide-disk is the right spot ... what if one wants LEDs for
CD-ROMs or other IDE devices like flash cards ?

> > Alternatively it could be made to apply to all ide activity if a
> > suitable start request point was found to hook into.
> 
> start_request() in ide-io.c
> 
> Thanks,
> Bartlomiej

