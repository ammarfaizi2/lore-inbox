Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTEHNEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTEHNEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:04:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28300 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261399AbTEHNEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:04:13 -0400
Date: Thu, 8 May 2003 15:16:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030508123617.GX823@suse.de>
Message-ID: <Pine.SOL.4.30.0305081502430.12362-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:

> n Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> > 	if (!hwif->rqsize)
> > 		hwif->rqsize = hwif->addressing ? 65536 : 256;
>
> btw, you didn't get this right this time either :-)

It is right.
hwif->addressing means hwif supports 48-bit
hwif->rqsize means max rq size for _hwif_

> drive->addressing == 1, 48-bit is ok
> hwif->addressing == 1, 48-bit is _not_ ok

And?
Even if !drive->addressing, hwif->addressing can be 1,
so hwif->rqsize can be 65536.

> below patch covers the lat change as well, boots and works on my router.

Patch still misses pdx202xx_old.c changes :-).
Two new ones:
- rq_lba48(rq) should check for rq->hard_* values
- after some thought, drop _all_ changes to ide_dump_status()
  (we may hit error when rq->nr_sectors is already < 256)

--
Bartlomiej

