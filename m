Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGGDyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGGDyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWGGDyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:54:50 -0400
Received: from web52605.mail.yahoo.com ([206.190.48.208]:26264 "HELO
	web52605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751175AbWGGDyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:54:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e0x3z8h0/DBnvWcH7Ddv6jKaag8d+jSIsFfFWLQbSbXGrYSozI8Ctr7swQp24yP//CNSEO5IOJMWnCVEaU/hgoR+ltm1hzsozW55mwnuaSkmloB0cuEYAmR0LqgPay+Wr1FC0t7G7ack+9mtYJ7C64w54u2iD0cQh0sFY8qXJeg=  ;
Message-ID: <20060707035448.31952.qmail@web52605.mail.yahoo.com>
Date: Fri, 7 Jul 2006 13:54:48 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: 2.6.18-rc1 Freezes on CDROM Access
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I insert a CD in the CDROM or CD-RW drive, it
freezes solid. No serial console output (OOPS, BUGs or
panics) or sysrq response.

I narrowed it down to 2.6.17-git21-git22 (using the
daily git snapshots), which is rather a huge patch.
Any particular candidate?

Here's the lspci:
00:00.0 Host bridge: Intel Corporation
82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub
Interface (rev 01)
00:02.0 VGA compatible controller: Intel Corporation
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics
Device (rev 01)
00:1d.0 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM
(ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge
(rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL
(ICH4/ICH4-L) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DB
(ICH4) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio
Controller (rev 01)
02:08.0 Ethernet controller: Intel Corporation 82801DB
PRO/100 VE (LOM) Ethernet Controller (rev 81)

Here's the CD drives info:
...
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] ->
GSI 5 (level, low) -> IRQ 5
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings:
hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 512KiB
hda: 78156288 sectors (40016 MB) w/1821KiB Cache,
CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9
hda10 hda11 >
Probing IDE interface ide1...
hdc: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
...
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache,
UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
...

More info on request.

Thanks



		
____________________________________________________ 
Do you Yahoo!? 
Check out gigs in your area on the comprehensive Yahoo! Music Gig Guide 
http://au.music.yahoo.com/gig-guide
