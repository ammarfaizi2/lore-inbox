Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTENSiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTENSiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:38:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29350 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263493AbTENSiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:38:12 -0400
Date: Wed, 14 May 2003 20:50:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: "Mudama, Eric" <eric_mudama@maxtor.com>,
       "'Rafal Bujnowski'" <bujnor@go2.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
In-Reply-To: <20030514174050.GQ15261@suse.de>
Message-ID: <Pine.SOL.4.30.0305142036310.21741-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Jens Axboe wrote:

> On Wed, May 14 2003, Mudama, Eric wrote:
> > 0x5104 is a different can of worms from the other stuff you guys were
> > reporting.
> >
> > 5104 (status register = 0x51, error register 0x04) is the all-encompassing
> > "command abort" which is what the drive does any time you issue a command
> > with bad parameters, an invalid (immoral?) command, or some of the security
> > stuff out of sequence.  Most commonly it is seen attempting to enable
> > features on a drive that doesn't support them.

In reality its harmless, only noisy, ide driver tryied to do something
like checking max native address and drive doesn't support it.

> Which reminds me that it has always annoyed me that Linux doesn't print
> the failed command. Just leaves a lot of guess work... I'll try and
> remedy that.

Which reminds me that somebody (me?) should fix hdparm to not use
WIN_IDENTIFY with HDIO_DRIVE_CMD ioctl but use HDIO_GET_IDENTIFY ioctl.
This command will be aborted by ATAPI device and hdparm don't know
if device is ATA or ATAPI, it currently only works because ioctl handler
reads data from device *before* checking status (or something like that).

Back on topic: Jens, you can also check current status of per driver
->abort() introduced by Alan.

btw. I will be quite busy for next 3 weeks (exams), so expect long
     delays in replies and slower ide progress.

--
Bartlomiej

> --
> Jens Axboe

