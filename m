Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUGBQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUGBQiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUGBQiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:38:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19641 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264649AbUGBQiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:38:17 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [1/9]
Date: Fri, 2 Jul 2004 18:43:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200406301724.05862.bzolnier@elka.pw.edu.pl> <20040702122004.GC12889@elf.ucw.cz>
In-Reply-To: <20040702122004.GC12889@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407021843.08976.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 of July 2004 14:20, Pavel Machek wrote:
> Hi!

Hi,

> > diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes
> > drivers/ide/ide-taskfile.c ---
> > linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes	2004-06-
> >28 21:15:54.030210376 +0200 +++
> > linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28
> > 21:15:54.035209616 +0200 @@ -409,6 +409,10 @@ ide_startstop_t
> > task_out_intr (ide_drive
> >  	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY,
> > drive->bad_wstat)) { return DRIVER(drive)->error(drive, "task_out_intr",
> > stat);
> >  	}
> > +
> > +	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
> > +		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> > +
>
> Looks pretty close to obfuscated c code contents... Can't you use !=

wrrr...

> or kill ! in second clause and use == or something?
> 								Pavel

is

	if (((stat & DRQ_STAT) != 0) ^ (rq->current_nr_sectors != 0))

better?

