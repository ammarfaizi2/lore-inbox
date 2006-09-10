Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWIJKB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWIJKB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWIJKB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:01:58 -0400
Received: from mailfe04.tele2.fr ([212.247.154.108]:10149 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932076AbWIJKB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:01:57 -0400
X-T2-Posting-ID: C+rpYiNZ2NzjjSrGUeFwNg==
X-Cloudmark-Score: 0.000000 []
From: Simon MORIN <simon-morin@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: DMA activation problem on Intel ICH7 82801GBM/GHMA
Date: Sun, 10 Sep 2006 12:01:52 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101201.52167.simon-morin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I have installed Gentoo Linux on my Acer Aspire 9410 laptop (Core Duo).

The hard drive and the cdrom are PATA devices and activating DMA on them seems 
to be impossible. The IDE controller is an Intel 82801GBM/GHM (ICH7 Family).

I checked the option "Intel PIIXn chipsets support" (CONFIG_BLK_DEV_PIIX=y) 
in "ATA/ATAPI/MFM/RLL" but it doesn't recognise the chipset (nothing appear 
about this in dmesg), so I can only use the generic ide driver. 

When I run hdparm as root,  it shows me this :

> hdparm -d1 /dev/sda
/dev/sda:
    setting using_dma to 1 (on)
    HDIO_SET_DMA failed: Invalid argument


If I try the SATA driver for this chipset (CONFIG_SCSI_ATA_PIIX), the chipset 
is recognised as show in the dmesg listing below but no drives is detected 
(it is normal, I don't have any SATA drives).

----- dmesg information shown when loading SATA driver
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ XX XX XX XX ]
ata_piix 0000:00:1f.2: invalid MAP value 1
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata: 0x1f0 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi0 : ata_piix
ata1: SATA port has no device.
ATA: abnormal status 0x7F on port 0x177
-----------------------------------------------------------------------------

I also try to enable both drivers but this does nothing for the DMA.

Kernel version is 2.6.17

----- My lspci :
00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port (rev 
03)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 
(rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 
(rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 
(rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 
(rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge 
(rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA 
Storage Controllers cc=IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 
02)
01:00.0 VGA compatible controller: nVidia Corporation Unknown device 01d7 (rev 
a1)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Unknown device 
8168 (rev 01)
05:00.0 Network controller: Intel Corporation Unknown device 4222 (rev 02)
0a:06.0 CardBus bridge: Texas Instruments Unknown device 8039
0a:06.2 Mass storage controller: Texas Instruments Unknown device 803b
0a:06.3 Class 0805: Texas Instruments Unknown device 803c
------------------

Best regards and thank you for any help

Simon MORIN
