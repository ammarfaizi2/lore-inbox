Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUCKHVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCKHVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:21:32 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:48388
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261449AbUCKHVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:21:30 -0500
Date: Wed, 10 Mar 2004 23:20:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Rumi Szabolcs <rumi_ml@rtfm.hu>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Marvell PATA-SATA bridge meets 2.4.x
In-Reply-To: <404A9D14.5030107@matchmail.com>
Message-ID: <Pine.LNX.4.10.10403102318430.19317-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It was me who pointed this fact out.

ATA-7 fails to address SATA w/ cable detect and now it reverts back to
ATA-5 mess :-(

I will post a patch for 2.4 for siimage.[ch] later showing how to fudge
the driver.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Sat, 6 Mar 2004, Mike Fedyk wrote:

> Rumi Szabolcs wrote:
> > Hello!
> > 
> > A while ago I reported a problem with the 2.4.22 kernel and the
> > tiny Marvell PATA to SATA bridge chip that is used on many of
> > the now-not-so-recent motherboards which don't have native
> > SATA ports in their southbridges.
> > 
> > As it can be seen below, a native SATA150 drive is connected
> > to a SATA port implemented using that Marvell chip hooked up
> > to the ICH4's parallel ATA133 port and this way the drive is
> > only recognized (and used) as UDMA33:
> > 
> > ICH4: IDE controller at PCI slot 00:1f.1
> > ICH4: chipset revision 2
> > ICH4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> > hdc: ST3160023AS, ATA DISK drive
> > blk: queue c04a1ff4, I/O limit 4095Mb (mask 0xffffffff)
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hdc: attached ide-disk driver.
> > hdc: host protected area => 1
> > hdc: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(33)
> > 
> > As far as I can remember someone (Jeff Garzik?) suspected the
> > SATA cable not being recognized as a 80-conductor thus >=UDMA66
> > capable cable. Then it was told that there is a fix underway that
> > will be included in the 2.4.23 kernel. The above snippet shows
> > that the 2.4.25 kernel still has this problem. Any comments?
> 
> You want to use a 2.6 kernel and talk to Bart, and Jeff about this...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

