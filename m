Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTJHOAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTJHOAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:00:14 -0400
Received: from ns1.astral.ro ([193.230.240.21]:63952 "EHLO ns1.astral.ro")
	by vger.kernel.org with ESMTP id S261362AbTJHOAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:00:08 -0400
Date: Wed, 8 Oct 2003 17:01:17 +0300
From: Catalin Muresan <catalin.muresan@astral.ro>
To: linux-kernel@vger.kernel.org
Subject: SII680 problems (IDE)
Message-ID: <20031008140117.GA2392@astral.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.6.0-test6-c3 i686
Organization: ASTRAL Telecom
X-NCC-RegID: ro.dnt
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (ns1.astral.ro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	i have an IDE controller with Silicon Image 0680A chipset (Class
0140: 1095:0680 Subsystem: 1771:1680) and have problems using any ide device
on it (tested with Seagate and Quantum disks). i can read from the disk fine
(hdparm -t shows about 40MB/sec at 100% sys load ?? but this is not the
issue, first to get it working) but as soon as i try to write a single
sector (partition table) i get:

hde: dma_timer_expiry: dma status == 0x20
hde: DMA timeout retry
hde: timeout waiting for DMA
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command
hde: status timeout: status=0xd0 { Busy }

hde: no DRQ after issuing MULTWRITE
ide2: reset: success
 hde: hde1
 hde: hde1

	(last 2 lines are because of fdisk) and it disables DMA and
continues to work but very very slow (in PIO mode i think).
	this is on linux-2.6.0-test6 and 2.4.22 (siimage.c ver. 1.06), this
is the boot message:

SiI680: IDE controller at PCI slot 0000:00:0d.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 10
    ide2: MMIO-DMA at 0xf0808000-0xf0808007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf0808008-0xf080800f, BIOS settings: hdg:pio, hdh:pio
hde: ST340016A, ATA DISK drive
ide2 at 0xf0808080-0xf0808087,0xf080808a on irq 10
hde: max request size: 64KiB
hde: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hde:

	patches, questions, solutions are wellcome, please CC: to me as I am
not on linux-kernel.

	thank you.

-- 
 Catalin Muresan
