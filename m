Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTIGTOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTIGTOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:14:14 -0400
Received: from maja.beep.pl ([195.245.198.10]:8973 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261297AbTIGTOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:14:08 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0test4 bk1 and
Date: Sun, 7 Sep 2003 21:11:21 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200309051559.18910.arekm@pld-linux.org> <20030905085419.6ea00d78.akpm@osdl.org>
In-Reply-To: <20030905085419.6ea00d78.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309072111.21900.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of September 2003 17:54, Andrew Morton wrote:

> > > bad: scheduling while atomic!
> > > Call Trace:
> > >  [<c0105000>] _stext+0x0/0x60
> > >  [<c011ccd0>] schedule+0x3b0/0x3c0
> > >  [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
> > >  [<c0105000>] _stext+0x0/0x60
> > >  [<c01090eb>] cpu_idle+0x3b/0x40
> > >  [<c0328734>] start_kernel+0x184/0x1b0
> > >  [<c0328480>] unknown_bootoption+0x0/0x100

> Grab the latest snapshot from
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ (the very first
> link) and see if it's still happening.

I've tested test4 with changeset patch 20030906_2214 and this problem no 
longer happens but there are few new like:

- ide thing
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free.
hda: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 3 for ide0
ide1: I/O resource 0x376-0x376 not free.
hdc: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 22 for ide1
Module via82cxxx cannot be unloaded due to unsafe usage in 
include/linux/module.h:483

- usb thing
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:11.2: UHCI Host Controller
irq 11: nobody cared!
Call Trace:
 [<c010cbdb>] __report_bad_irq+0x2b/0x90
 [<c010ccd4>] note_interrupt+0x64/0xa0

- pcmcia thing
WARNING: Loop detected: 
/lib/modules/2.6.0-test4cset20030906rel0.1/kernel/drivers/pcmcia/pcmcia_core.ko 
which needs pcmcia_core.ko again!

Details in separate mail(s) to LKML in few minutes.
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

