Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTFBRDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTFBRDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:03:03 -0400
Received: from otto.nurk.org ([208.33.7.103]:5607 "EHLO otto.nurk.org")
	by vger.kernel.org with ESMTP id S262090AbTFBRCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:02:51 -0400
Date: Mon, 2 Jun 2003 10:15:35 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
X-X-Sender: olaph@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: RocketRaid Serial ATA support (HPT374)
Message-ID: <Pine.LNX.4.44.0306021014210.31232-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I recently bought a Highpoint RocketRaid 1540. I thoght that it should
work in Linux since it used the HPT374 chipset. I have been unable to get
get it working with the driver in the kernel (kernel 2.4.20, 2.4.21-rc2,
2.4.21-rc6 and 2.5.70) or the driver from HighPoint's site.

I will be happy to provide any other information I can.

I have a RocketRaid 1540 connected to 4 60gb ata100 IBM drives 
(Model=IC35L060AVVA07-0) on a Tyan 2466N.

Upon boot, the first thing I notice is that the first 2 channels are
recognized as ata100 and the second 2 are only ata33.

HPT374: IDE controller at PCI slot 02:05.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0x3000-0x3007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x3008-0x300f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x3400-0x3407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x3408-0x340f, BIOS settings: hdk:pio, hdl:pio
hde: IC35L060AVVA07-0, ATA DISK drive
ide2 at 0x3890-0x3897,0x3886 on irq 17
hdg: IC35L060AVVA07-0, ATA DISK drive
ide3 at 0x3888-0x388f,0x3882 on irq 17
hdi: IC35L060AVVA07-0, ATA DISK drive
ide4 at 0x38a8-0x38af,0x389e on irq 17
hdk: IC35L060AVVA07-0, ATA DISK drive
ide5 at 0x38a0-0x38a7,0x389a on irq 17
hde: max request size: 128KiB
hde: host protected area => 1
hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(100)
 hde: hde1 hde2 hde3
hdg: max request size: 128KiB
hdg: host protected area => 1
hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(100)
 hdg: hdg1 hdg2
hdi: max request size: 128KiB
hdi: host protected area => 1
hdi: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(33)
 hdi: hdi1 hdi2
hdk: max request size: 128KiB
hdk: host protected area => 1
hdk: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(33)
 hdk: hdk1 hdk2

Then the second 2 start complaining...

hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdi: drive not ready for command
hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdk: drive not ready for command

And, if I try to mount them, more fun ensues...

hdk: drive not ready for command
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide5: reset: success
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide5: reset: success
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hdk, sector 120103024
md: write_disk_sb failed for device hdk2
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide4: reset: success
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide4: reset: success
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hdi, sector 120103024
md: write_disk_sb failed for device hdi2
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hdg, sector 120103024
md: write_disk_sb failed for device hdg2
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hde, sector 120103024
md: write_disk_sb failed for device hde3
md: errors occurred during superblock update, repeating
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdk: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdk: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide5: reset: success
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x53 { DriveReady SeekComplete Index Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide4: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hdg, sector 120103024
md: write_disk_sb failed for device hdg2
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
end_request: I/O error, dev hde, sector 120103024
md: write_disk_sb failed for device hde3
md: errors occurred during superblock update, repeating
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide3: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command
hde: status timeout: status=0xd0 { Busy }

hde: drive not ready for command
ide2: reset: success
kjournald starting.  Commit interval 5 seconds
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command

Thank you for your help.

-- 
Sean Swallow

