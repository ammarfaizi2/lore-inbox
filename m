Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUAQXWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUAQXWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:22:38 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:63460 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266212AbUAQXWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:22:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Can't enable DMA on my DVD in 2.6.1?
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 17 Jan 2004 18:22:33 -0500
Message-ID: <873cae17pi.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Now I have a strange situation. I finally got the dvd-rom and cd burner
devices to be recognized at all under 2.6.1 and now they work but DMA seems to
be off.

The situation: Asus P4P800 motherboard with Intel ICH5 chipset in Enhanced
mode "SATA Only". Using 2.6.1 with ata_piix handling the two SATA hard drives
(sda, sdb) and ide-cdrom handling the PATA drive, cd burner, and dvd (hda,
hdc, hdd).

When I play DVDs using Xine it seems to be barely able to keep up and
occasionally stutters. Much as if DMA were disabled. And indeed I see it
apparently isn't. 

Moreoever when I try to turn it on I get EPERM. And I don't see the kernel
option to use DMA by default any more. I suppose that went out with 2.6.1?

bash-2.05b# hdparm -v /dev/hdd

/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

bash-2.05b# hdparm -d 1 /dev/hdd

/dev/hdd:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


bash-2.05b# hdparm -I /dev/hdd

/dev/hdd:

ATAPI CD-ROM, with removable media
	Model Number:       LG       DVD-ROM DRD-8160B              
	Serial Number:      
	Firmware Revision:  1.01    
Standards:
	Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
	Supported: CD-ROM ATAPI-2 
Configuration:
	DRQ response: 50us.
	Packet size: 12 bytes
Capabilities:
	LBA, IORDY(can be disabled)
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
	     Cycle time: min=120ns recommended=150ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=227ns  IORDY flow control=120ns


bash-2.05b# hdparm -i /dev/hdd

/dev/hdd:

 Model=LG DVD-ROM DRD-8160B, FwRev=1.01, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

 * signifies the current active mode

-- 
greg

