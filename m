Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUDZPz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUDZPz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUDZPz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:55:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23790 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262766AbUDZPy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:54:57 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Mon, 26 Apr 2004 17:54:27 +0200
User-Agent: KMail/1.5.3
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404261650.40801.bzolnier@elka.pw.edu.pl> <20040426152345.GE14074@harddisk-recovery.com>
In-Reply-To: <20040426152345.GE14074@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404261754.27823.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 of April 2004 17:23, Erik Mouw wrote:
> On Mon, Apr 26, 2004 at 04:50:40PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > BTW I think there is a common misunderstanding about libata:
> >     it will not replace IDE drivers any time soon.
> >
> > I want to rewrite+merge current IDE code with libata during 2.7
> > (and yes, legacy naming and ordering will be preserved!).
> >
> > I hope nobody starts rewriting existing IDE drivers for libata and
> > pushing them upstream -> it will mean maintenance problems much bigger
> > than OSS+ALSA.
>
> I don't think it's bad to have two drivers for the same hardware. We've
> seen that with the USB UHCI host controller, RTL 8139, Intel e100,

USB and networks drivers are _actively_ developed by _many_ people
(in comparison to IDE).

> Adaptec aic7xxx, NCR/Symbios sym53c8x. Having two drivers makes it easy
> for people to switch. The difference with OSS+ALSA is that the drivers

It is much easier to pull out network driver from kernel than IDE driver
and some people just won't switch until old driver works.

Just think how much effort it took to make people use ide_cd not ide_scsi
for CD writing and it's nothing compared to make them switch from
(ordered) /dev/hdX to (random) /dev/sdX.

Please remember about device ordering issues and hardcoded 'root=/'.

Not to even mention problems like that SCSI emulation won't some support
some devices supported by ide_floppy and ide_cd etc.

> I just mentioned have been "developed" in the tree, while ALSA was
> developed outside the tree.

No, the biggest difference is that subsystem core was also changed in ALSA.
-> OSS emulation in ALSA etc.

> > However writing _new_ libata driver for 'exotic' PATA hardware is OK.
>
> Is AMD 760/762 (amd74xx driver) considered "exotic"? ;-)

NO! 8)

The main problem is that even with well tested amd74xx driver for libata
it won't be possible to remove old amd74xx driver so we'll have to maintain
both for really long time and it won't be funny et all.

Bartlomiej

