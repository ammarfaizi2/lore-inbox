Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTELD4s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTELD4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:56:48 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:22934 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261872AbTELD4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:56:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Why no DMA on this harddisk/chipset?
Date: Sun, 11 May 2003 21:09:29 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305112109.29601.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Red Hat Linux v7.3 system I was able to set DMA on my hard disk.  
After doing a clean install of RHL v9, now I can't set DMA on the exact 
same hardware (a Compaq Presario 1260, if it matters).  

My first thought was that one of the many patches that RH applied to the 
stock v2.4.20 kernel broke my capacity for DMA.  After rebuilding from 
plain-vanilla 2.4.20 source, though, I still can't set DMA access on my 
hard disk.  

I don't see either my IDE chipset or hard disk (see identity of both 
below) on the blacklist, so I am at a loss as to what further 
investigations I can do.  

Any advice on this?  Thanks.

-----------------------------

# hdparm -V
hdparm v5.2

# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

-----------------------------

kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
kernel: hda: IC25N020ATCS05-0, ATA DISK drive
kernel: hdc: TOSHIBA CD-ROM XM-1802B, ATAPI CD/DVD-ROM drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hda: host protected area => 1
kernel: hda: 39070080 sectors (20004 MB) w/7898KiB Cache,CHS=2584/240/63
kernel: Partition check:
kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >

-----------------------------

# lspci
00:00.0 Host bridge: OPTi Inc. 82C701 [FireStar Plus] (rev 32)
00:01.0 ISA bridge: OPTi Inc. 82C700 [FireStar] (rev 31)
00:0a.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:0a.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:12.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 
128XD] (rev 01)
00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10)
00:14.0 IDE interface: OPTi Inc. 82C825 [Firebridge 2] (rev 30)
01:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN 
CardBus (rev 01)

-----------------------------

# hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
        Model Number:       IC25N020ATCS05-0
        Serial Number:      CLP201F2G23TNA
        Firmware Revision:  CS2OA61A
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 3
        Supported: 5 4 3 2 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   17475
        heads           16      15
        sectors/track   63      63
        --
        CHS current addressable sectors:   16513875
        LBA    user addressable sectors:   39070080
        device size with M = 1024*1024:       19077 MBytes
        device size with M = 1000*1000:       20003 MBytes (20 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128 (0x80)
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    Device Configuration Overlay feature set
                SET MAX security extension
                Address Offset Reserved Area Boot
                Power-Up In Standby feature set
           *    Advanced Power Management feature set
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        22min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

-----------------------------

