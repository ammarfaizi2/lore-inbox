Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTFBLhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFBLhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:37:19 -0400
Received: from AToulouse-105-1-2-46.w193-253.abo.wanadoo.fr ([193.253.42.46]:39172
	"EHLO choocroot.dyndns.org") by vger.kernel.org with ESMTP
	id S262177AbTFBLhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:37:14 -0400
Date: Mon, 2 Jun 2003 13:48:38 +0200
From: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <jauge@club-internet.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 can't set IDE DMA on harddrive (HDIO_SET_DMA failed: Operation not permitted)
Message-ID: <20030602114838.GA1730@satellite.workgroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Organization: none
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm now using kernel 2.4.20-13.8 (from RH8) and 2.4.21-ck1 (from Con
Kolivas based on 2.4.21-rc6) and I'm unable to set the dma for my
harddrive with hdparm:

  # hdparm -d1 /dev/hda

  /dev/hda:
   setting using_dma to 1 (on)
   HDIO_SET_DMA failed: Operation not permitted
   using_dma    =  0 (off)

Before these kernels I was using the 2.4.18 (from RH8 too) and
2.4.20-ck1 and setting DMA was working.

I checked my logs and found that the 2.4.21 kernel use E-IDE version
7.00beta[34]-.2.4 and the 2.4.20 one use version 6.31.

Looks like something went wrong in the IDE code regarding DMA settings ?

Here is the output from 'lspci' for my IDE controler (Toshiba Satellite
2540CDT):

--8<--
00:10.0 IDE interface: Toshiba America Info Systems: Unknown device 0102 (rev 34) (prog-if f0)
        Subsystem: Toshiba America Info Systems: Unknown device 0002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-<TAbort-<MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 10000ns max)
        Region 4: I/O ports at 1800 [size=16]
-->8--

and the IDE 7.00beta3-.2.4 messages from /var/log/messages:

--8<--
May 26 12:54:10 satellite kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
May 26 12:54:10 satellite kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 26 12:54:10 satellite kernel: hda: TOSHIBA MK4309MAT, ATA DISK drive
May 26 12:54:10 satellite kernel: hdc: CD-224E, ATAPI CD/DVD-ROM drive
May 26 12:54:10 satellite kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 26 12:54:10 satellite kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 26 12:54:11 satellite kernel: hda: attached ide-disk driver.
May 26 12:54:11 satellite kernel: hda: host protected area => 1
May 26 12:54:11 satellite kernel: hda: 8452080 sectors (4327 MB), CHS=526/255/63
-->8--

and the IDE 6.31 messages:

--8<--
May 12 11:41:52 satellite kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 12 11:41:52 satellite kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 12 11:41:52 satellite kernel: PCI_IDE: unknown IDE controller on PCI bus 00 device 80, VID=1179, DID=0102
May 12 11:41:52 satellite kernel: PCI_IDE: chipset revision 52
May 12 11:41:53 satellite kernel: PCI_IDE: not 100%% native mode: will probe irqs later
May 12 11:41:53 satellite kernel:     ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
May 12 11:41:53 satellite kernel:     ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
May 12 11:41:53 satellite kernel: hda: TOSHIBA MK4309MAT, ATA DISK drive
May 12 11:41:53 satellite kernel: hdc: CD-224E, ATAPI CD/DVD-ROM drive
May 12 11:41:53 satellite kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 12 11:41:53 satellite kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 12 11:41:53 satellite kernel: blk: queue c03a7604, I/O limit 4095Mb (mask 0xffffffff)
May 12 11:41:53 satellite kernel: hda: 8452080 sectors (4327 MB), CHS=526/255/63, UDMA(33)
May 12 11:41:53 satellite kernel: hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
-->8--

Thanks.

-- 

