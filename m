Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbTFNQTw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 12:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbTFNQTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 12:19:52 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:3265 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265683AbTFNQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 12:19:51 -0400
Message-ID: <3EEB4E63.60003@yahoo.com>
Date: Sat, 14 Jun 2003 17:33:39 +0100
From: Chris Rankin <rankincj@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@hera.kernel.org
Subject: [BUGLET?] 2.4.21-UP - Unusual IDE messages in boot-log
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I booted 2.4.21-UP last night on my ageing P200MMX / 64 MB RAM and saw some 
curious warning messages when attaching the IDE disks:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xefa0-0xefa7, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xefa8-0xefaf, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC33200L, ATA DISK drive
hdb: WDC AC35100L, ATA DISK drive
blk: queue c02a3000, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02a313c, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=787/128/63, DMA
hdb: attached ide-disk driver.
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: host protected area => 1
hdb: 10085040 sectors (5164 MB) w/256KiB Cache, CHS=667/240/63, (U)DMA
Partition check:
  hda: hda1 hda2 hda3
  hdb: hdb1 hdb2 hdb3 hdb4

Now the machine continued to boot, and so I'm guessing that these 
"task_no_data_intr" messages aren't all that serious. In fact, these lines look 
a lot like those in the Configure.help section for CONFIG_IDEDISK_MULTI_MODE:

   hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
   hda: set_multmode: error=0x04 { DriveStatusError }

However, enabling multi-mode didn't make these warning messages disappear. 
Although to be frank, I couldn't find any lines of code that depended on the 
setting of CONFIG_IDEDISK_MULTI_MODE in the first place...

Still, no other problems so far ...
Cheers,
Chris

