Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUCTCE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 21:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUCTCE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 21:04:26 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:442 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262193AbUCTCEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 21:04:25 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Johannes Stezenbach <js@convergence.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 03:13:05 +0100
User-Agent: KMail/1.5.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200102.39716.bzolnier@elka.pw.edu.pl> <20040320014837.GB11865@convergence.de>
In-Reply-To: <20040320014837.GB11865@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403200313.05681.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 02:48, Johannes Stezenbach wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 20 of March 2004 00:01, Matthias Andree wrote:
> > > BTW, speaking of identify-device, hdparm -i (which uses
> > > HDIO_GET_IDENTITY) always returns "WriteCache=enabled" while hdparm -I
> > > that uses HDIO_DRIVE_CMD with WIN_PIDENTIFY reports the "correct" state
> > > that I've previously set with -W0. This is an i386 machine w/
> > > 2.6.5-rc1.
> > >
> > > Is HDIO_GET_IDENTITY working correctly?
> >
> > There were reports that on some drives you can't disable write cache
> > and even (?) that some drives lie (WC still enabled but marked as
> > disabled).

Doh, I misunderstood the question.

Correct answer is: everything is fine, RTFM (man hdparm). ;-)

> hdparm -i and -I ultimately both interpret WIN_IDENTIFY result, and both
> test bit 0x0020 of word 85. So it's unclear to me why they report a
> different write cache setting. I added a hexdump to dump_identity()
> in hdparm.c, and found that bit 0x0020 of word 85 is always set.

or WIN_PIDENTIFY to be strict but

-i returns _cached_ (read when the device was probed) identify data
(uses HDIO_GET_IDENTIFY ioctl)
-I reads _current_ data directly from the device
(uses HDIO_DRIVE_CMD ioctl)

> BTW, 'cat /proc/ide/hda/identify' or 'hdparm -Istdin
> </dev/ide/hda/identify' reports the same value as hdparm -I, and that is
> consistent with
> the value I set with hdparm -W x.
>
>
> So, is HDIO_GET_IDENTITY broken?

No.

Regards,
Bartlomiej

