Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbTICNTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbTICNTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:19:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26600 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262020AbTICNTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:19:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: LBA48 on PDC20265 (again and again...)
Date: Wed, 3 Sep 2003 15:20:49 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <BFC117A6765@vcnet.vc.cvut.cz>
In-Reply-To: <BFC117A6765@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031520.49352.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

There was a recent threads on this issue:
"IDE bug - was: Re: uncorrectable ext2 errors"
and "Promise IDE patches".

One of conclusions was that there is no reason not to enable LBA48
on PDC20265.  I will send Jan's patches to Linus.  Thanks for verifying this.

--bartlomiej

On Wednesday 03 of September 2003 14:46, Petr Vandrovec wrote:
> Hi,
>   during last year there was couple of complaints that pdc202xx_old
> driver does not allow LBA48 on first channel, and couple of confirmations
> that just removing these two lines which do:
>
>   if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
>       hwif->no_lba48 = (hwif->channel) ? 0 : 1;
>
> fixes problem, and both channels run with lba48 drives just fine...
>
>   Yesterday I bring home two nice 160GB seagates, hooked them up to
> the Promise, and booted. And to my surprise we still do not enable
> lba48 on primary channel...
>
>   Is there some reason for doing that? I removed this, and I was able
> to copy contents of my old 120GB disk to the 160GB one, with 40G offset
> (so lba48 has to work, otherwise first 40GB holding an VFAT partition with
> some gzipped test files gets corrupted). Currently these two drives
> are unused (they just hold backup copy of dying 120GB wd), so I can do
> any experiments you may want to confirm/decline idea that we should
> remove this no_lba48 hack. Of course unless you have datasheet which says
> that it cannot work. But as Promise BIOS happily says that two 149GB disks
> (149 * 2^30 == 160 * 10^9) running UDMA5 are attached, I assume that it
> is willing to handle LBA48 on both channels.
>                                               Thanks,
>                                                   Petr Vandrovec

