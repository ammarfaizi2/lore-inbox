Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTEHFE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTEHFE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:04:27 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:7896 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261176AbTEHFEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:04:23 -0400
Message-ID: <3EB9F541.7060008@blue-labs.org>
Date: Thu, 08 May 2003 02:12:17 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.69, IDE problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hda: dma_timer_expiry: dma status == 0x24
drivers/ide/ide-io.c:108: spin_lock(drivers/ide/ide.c:c04fb648) already 
locked by drivers/ide/ide-io.c/948
drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c04fb648) not locked
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

hda: dma_timer_expiry: dma status == 0x24
drivers/ide/ide-io.c:108: spin_lock(drivers/ide/ide.c:c04fb648) already 
locked by drivers/ide/ide-io.c/948
drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c04fb648) not locked
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }


Got these messages while compiling XFree86.

# lspci (trimmed)
00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266/KL266] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)

# hdparm -v /dev/ide/host0/bus0/target0/lun0/disc

/dev/ide/host0/bus0/target0/lun0/disc:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 12009/16/63, sectors = 78165360, start = 0


# hdparm -I /dev/ide/host0/bus0/target0/lun0/disc

/dev/ide/host0/bus0/target0/lun0/disc:

ATA device, with non-removable media
        Model Number:       WDC WD400BB-00CAA1                     
        Serial Number:      WD-WMA8F2412631
        Firmware Revision:  17.07W17
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78165360
        device size with M = 1024*1024:       38166 MBytes
        device size with M = 1000*1000:       40020 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    Device Configuration Overlay feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- below Vih
        Device num = 0 determined by the jumper
Checksum: correct


