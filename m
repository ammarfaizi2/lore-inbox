Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRCANCb>; Thu, 1 Mar 2001 08:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRCANCM>; Thu, 1 Mar 2001 08:02:12 -0500
Received: from NET.WAU.NL ([137.224.10.12]:65042 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S129577AbRCANCF>;
	Thu, 1 Mar 2001 08:02:05 -0500
Date: Thu, 01 Mar 2001 14:01:58 +0100
From: Hylke van der Schaaf <hylke@lx.student.wau.nl>
Subject: DMA on a AMD7409 controller with kernel 2.4.2
To: linux-kernel@vger.kernel.org
Message-id: <20010301140158.A402@hylke.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.3.15i
X-System-Uptime: 1:59pm  up 7 min,  1 user,  load average: 1.00, 0.82, 0.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernet 2.2.18 DMA mode for my harddisks worked just fine, 
getting IDE DMA working on an AMD7409 controller with kernel 2.4.2 is a problem.

questions:
Why is DMA disabled on revision < C4?
How can I gat DMA working again?

The Information:

in 2.2.18 I get:
--------- dmesg: ----------
PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022, DID=7409
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
PCI_IDE: simplex device:  DMA disabled
ide1: PCI_IDE Bus-Master DMA disabled (BIOS)
hda: IBM-DPTA-372050, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DPTA-372050, 19574MB w/1961kB Cache, CHS=2495/255/63
---------------------------

hylke:/home/hylke# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2495/255/63, sectors = 40088160, start = 0
hylke:/home/hylke# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.89 seconds =143.82 MB/sec
 Timing buffered disk reads:  64 MB in  2.85 seconds = 22.46 MB/sec
----------------------------

All was fine.
I compiled 2.4.2, with:

	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_IDEDMA_PCI_WIP=y
	CONFIG_AMD7409_OVERRIDE=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_IDEDMA_IVB=y

and I get:

--------- dmesg: ----------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
AMD7409: simplex device: DMA forced
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DPTA-372050, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63
--------------------------
hylke:/home/hylke# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2495/255/63, sectors = 40088160, start = 0
hylke:/home/hylke# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)
hylke:/home/hylke# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
 Timing buffered disk reads:  64 MB in 12.59 seconds =  5.08 MB/sec
-------------------------

My harddisk speed is down to 25%...

Greets,
Hylke van der Schaaf


-- 
Hi, I'm a signature virus. plz set me as your signature and help me
spread :)
