Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbULWNtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbULWNtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 08:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULWNtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 08:49:22 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:40386 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261238AbULWNtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 08:49:15 -0500
Date: Thu, 23 Dec 2004 14:49:15 +0100 (CET)
From: Folkert van Heusden <folkert@vanheusden.com>
X-X-Sender: <folkert@muur.intranet.vanheusden.com>
To: bert hubert <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: pc stalling when processing large files [2.6.9]
In-Reply-To: <20041223131135.GA11257@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0412231447070.28376-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a P-III with 384MB of ram running kernel 2.6.9. It has one IDE disk.
> > When processing a large mailbox with sa-learn (the bayes learn tool of
> > spamassassin), the system gets very unresponsive. Like: when typing commands
> > on it via ssh, the system doesn't respond several times for seconds (1 or 2
> > maybe 3). Then when I continue to type, it gets a little better but when
> > idling for say 10 seconds it gets unresponsive again. The large mailbox is
> > aprox 200MB.
> Sounds obvious, but can you show the output of hdparm /dev/hda ? You have
> IDE DMA support enabled, but does the kernel recognize your IDE controller?

I thought it did. It's a via board.
/dev/hda:
 multcount    =  0 (off)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 39813/16/63, sectors = 20547841536, start = 0

> What you describe vould very well be caused by DMA being switched off for
> IDE.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdb: HL-DT-ST CD-ROM GCR-8520B, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 40132503 sectors (20547 MB) w/1902KiB Cache, CHS=39813/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

At startup, this is executed:
/usr/sbin/hdparm -c 3 -d 1 -X 69 -u 1 /dev/hda
which gives:
/dev/hda:
 setting 32-bit IO_support flag to 3
 setting unmaskirq to 1 (on)
 setting using_dma to 1 (on)
 setting xfermode to 69 (UltraDMA mode5)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+

