Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbUCTFtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 00:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUCTFtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 00:49:52 -0500
Received: from nest.8D.com ([209.47.172.23]:23433 "EHLO nest.8d.com")
	by vger.kernel.org with ESMTP id S263235AbUCTFts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 00:49:48 -0500
Date: Sat, 20 Mar 2004 00:49:47 -0500
From: xavier <list.linux-kernel@natch.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx, DMA and performance problem
Message-ID: <20040320054947.GB2505@pecos.8d.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FCCB0F4.9010907@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCCB0F4.9010907@free.fr>
X-Archive: encrypt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 03:34:12PM +0000, shal wrote:
|Hello,
|
|I have a MSI KT3 Ultra2 mother card with the VT82C586 IDE interface.
|
|I have a question about IDE performance.
|


Hi, I've the MSI 6380, with the kt266A chipset,
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1

and i got dma working on the first ide controler but not on the second...

if i plug the cable and both devices on ide0 (hda : burner , hdb : disk),
 every thing works fine (udma5 for the disk), and on ide1 everything
breaks with 

hdd: dma_timer_expiry: dma status == 0x60
hdd: DMA timeout retry
hdd: timeout waiting for DMA


I tried kernels 2.4.24, and 2.6.3, sources from debian,
compiled myself, all included (ide chipset, dma...)

any clues what might be wrong ?

thanks



00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:05.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev 01)
00:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)
00:08.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)



Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
hdb: WDC WD1200JB-34EVA0, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-117 0107, ATAPI CD/DVD-ROM drive
hdd: IBM-DTTA-350840, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdb: max request size: 1024KiB
hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: p1
hdd: max request size: 128KiB
hdd: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=16383/16/63, UDMA(33)
 /dev/ide/host0/bus1/target1/lun0:<4>hdd: dma_timer_expiry: dma status == 0x60
hdd: DMA timeout retry
hdd: timeout waiting for DMA
 p1
hda: ATAPI 40X CD-ROM CD-R/RW CD-MRW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(66)


root@albert> hdparm -d1 /dev/hdd                                             0:47:33~

/dev/hdd:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
root@albert> hdparm /dev/hdd                                                 0:47:43~

/dev/hdd:
 multcount    = 16 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  0 (off)
 geometry     = 16383/16/63, sectors = 16514064, start = 0
root@albert> hdparm -t /dev/hdd                                              0:48:01~

/dev/hdd:
 Timing buffered disk reads:    2 MB in 20.39 seconds = 100.45 kB/sec

Mar 20 00:48:27 albert kernel: hdd: dma_timer_expiry: dma status == 0x40
Mar 20 00:48:27 albert kernel: hdd: DMA timeout retry
Mar 20 00:48:27 albert kernel: hdd: timeout waiting for DMA


-- 
xavier
