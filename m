Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbUCTPyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUCTPyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:54:55 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49038 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263451AbUCTPyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:54:53 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Johannes Stezenbach <js@convergence.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 17:03:30 +0100
User-Agent: KMail/1.5.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200313.05681.bzolnier@elka.pw.edu.pl> <20040320025312.GA12710@convergence.de>
In-Reply-To: <20040320025312.GA12710@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201703.30403.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 03:53, Johannes Stezenbach wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 20 of March 2004 02:48, Johannes Stezenbach wrote:
> > > hdparm -i and -I ultimately both interpret WIN_IDENTIFY result, and
> > > both test bit 0x0020 of word 85. So it's unclear to me why they report
> > > a different write cache setting. I added a hexdump to dump_identity()
> > > in hdparm.c, and found that bit 0x0020 of word 85 is always set.
> >
> > or WIN_PIDENTIFY to be strict but
> >
> > -i returns _cached_ (read when the device was probed) identify data
> > (uses HDIO_GET_IDENTIFY ioctl)
> > -I reads _current_ data directly from the device
> > (uses HDIO_DRIVE_CMD ioctl)
>
> Oh, right.
>
> But: HDIO_GET_IDENTITY returns drive->id, and surely drive->id
> is used internally. So isn't it a bug that drive->id is not
> updated when the write cache setting is changed?

No, drive->id shouldn't be changed.

> I think the barrier code uses drive->id to determine if the
> write cache is enabled.

The barrier code depends on drive->wcache.

Regards,
Bartlomiej

