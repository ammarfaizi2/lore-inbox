Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUC0XXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUC0XXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:23:21 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51624 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261967AbUC0XXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:23:16 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Smietanowski <stesmi@stesmi.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 00:32:22 +0100
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com>
In-Reply-To: <40660877.3090302@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403280032.22180.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 of March 2004 00:04, Stefan Smietanowski wrote:
> Hi Jeff.
>
> > The "lba48" feature in ATA allows for addressing of sectors > 137GB, and
> > also allows for transfers of up to 64K sector, instead of the
> > traditional 256 sectors in older ATA.
> >
> > libata simply limited all transfers to a 200 sectors (just under the 256
> > sector limit).  This was mainly being careful, and making sure I had a
> > solution that worked everywhere.  I also wanted to see how the iommu S/G
> > stuff would shake out.
> >
> > Things seem to be looking pretty good, so it's now time to turn on
> > lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the
> > ones smaller than 137GB, for this and other reasons.
> >
> > With this simple patch, the max request size goes from 128K to 32MB...
> > so you can imagine this will definitely help performance.  Throughput
> > goes up.  Interrupts go down.  Fun for the whole family.

What about latency?

What about recently discussed PRD table "limit" of 256 entries?

AFAIR these are the reasons why IDE driver is currently
limiting max request size to 1024K on LBA48 disks.

> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> in most SATA disks today?

Most modern PATA disks support LBA48 and IDE driver has been using
large transfers for some time. :-)

> Is large transfers mandatory in the LBA48 spec and is LBA48 really
> mandatory in SATA?

large transfers are part of LBA48 spec

> And yes, I saw that the dmesg showed a Maxtor drive, but I'm uncertain
> if that disk of yours has a Marvel chip on or not, since newer Maxtors
> might (have) come out (already) without a Marvel chip, I just don't
> know.

Regards,
Bartlomiej

