Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbTCVNzX>; Sat, 22 Mar 2003 08:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbTCVNzX>; Sat, 22 Mar 2003 08:55:23 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:1977 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262767AbTCVNzV>; Sat, 22 Mar 2003 08:55:21 -0500
Date: Sat, 22 Mar 2003 15:03:37 +0100
From: Dominik Brodowski <linux@brodo.de>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.65-ac2 -- hda/ide trouble on ICH4
Message-ID: <20030322140337.GA1193@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

unfortunately 2.5.65-ac2 does not boot:

ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
...
hda: ICH35L080AVVA07-0, ATA DISK driver
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
...
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
 hda: [PTBL] [10011/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >

and *deadlock*...

in plain 2.5.65 I was seeing strange error messages like:

Mar 19 20:29:55 mondschein kernel: hda: dma_timer_expiry: dma status == 0x24
Mar 19 20:29:55 mondschein kernel: hda: lost interrupt
Mar 19 20:29:55 mondschein kernel: hda: dma_intr: bad DMA status (dma_stat=30)
Mar 19 20:29:55 mondschein kernel: hda: dma_intr: status=0x52 { DriveReady SeekComplete Index }
Mar 19 20:29:55 mondschein kernel:

which are not repeatable when I switch back to 2.5.62.

lspci:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE]
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

parts of dmesg in 2.5.62:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST GCE-8480B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >


	Dominik
