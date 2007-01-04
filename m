Return-Path: <linux-kernel-owner+w=401wt.eu-S964881AbXADSQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbXADSQI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbXADSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:16:08 -0500
Received: from cthulhu.lanfear.net ([206.124.137.179]:42225 "EHLO
	cthulhu.lanfear.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964881AbXADSQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:16:05 -0500
Date: Thu, 4 Jan 2007 10:16:01 -0800
From: Mark Wagner <mark@lanfear.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sata_sil24 lockups under heavy i/o
Message-ID: <20070104181601.GD17650@freddy.lanfear.net>
Reply-To: Mark Wagner <mark@lanfear.net>
References: <20070103173024.GB17650@freddy.lanfear.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103173024.GB17650@freddy.lanfear.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 09:30:24AM -0800, Mark Wagner wrote:

> [1.] One line summary of the problem:
> 
> sata_sil24 lockups under heavy i/o
> 
> [2.] Full description of the problem/report:
> 
> I have a PCI-based sata_sil24 card. It has 4 ports. It was functioning
> well with two disks attached. Once I attached 2 additional disks (for
> a total of 4) and started heavy i/o (extending a software raid5 device)
> the system began locking up for a few minutes at a time. After the
> system recovers the disk transfer speed is reduced from UDMA/100 to
> UDMA/66 or UDMA/44.

Last night I performed a simultaneous dd on the 4 drives on the Sil3124
card like so:

dd if=/dev/sda of=/dev/null
dd if=/dev/sdb of=/dev/null
dd if=/dev/sdc of=/dev/null
dd if=/dev/sdd of=/dev/null

Three times the system temporarily locked up and then lowered
the speeds of the drives. They are currently at PIO4. What
might be causing this?

Here is the dmesg from when the problem occurred:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 13609990(6) current 13610006(6)
  Transmit list 01beaa20 vs. c1bea5c0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 800005ea status 8c0005ea
  5: @c1bea520  length 800005ea status 8c0005ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0005ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 8000
  Flags; bus-master 1, dirty 13609990(6) current 13610006(6)
  Transmit list 01bea5c0 vs. c1bea5c0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 800005ea status 8c0005ea
  5: @c1bea520  length 800005ea status 8c0005ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0005ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
hda: dma_timer_expiry: dma status == 0x61
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 8000
  Flags; bus-master 1, dirty 13609990(6) current 13610006(6)
  Transmit list 01bea5c0 vs. c1bea5c0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 800005ea status 8c0005ea
  5: @c1bea520  length 800005ea status 8c0005ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0005ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: DMA disabled
hda: no DRQ after issuing MULTWRITE_EXT
ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: hard resetting port
ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ide0: reset: success
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/100
ata3: EH complete
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
ata4: softreset failed (SRST command error)
ata4: follow-up softreset failed, retrying in 5 secs
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata4: hard resetting port
ata2: hard resetting port
ata1: hard resetting port
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to UDMA/33
ata1: failed to recover some devices, retrying in 5 secs
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to UDMA/33
ata2: failed to recover some devices, retrying in 5 secs
ata4: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x1)
ATA: abnormal status 0xC1 on port 0xF8836007
ATA: abnormal status 0xC1 on port 0xF8836007
ata4.00: configured for UDMA/100
ata4: EH complete
ata1: hard resetting port
ata2: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/33
ata1: EH complete
ata2.00: configured for UDMA/33
ata2: EH complete
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
i2c_adapter i2c-0: Transaction error!
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 14351421(13) current 14351437(13)
  Transmit list 01bea5c0 vs. c1beaa20.
  0: @c1bea200  length 800005ea status 0c0105ea
  1: @c1bea2a0  length 800005ea status 0c0105ea
  2: @c1bea340  length 800005ea status 0c0105ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0005ea
  7: @c1bea660  length 800005ea status 0c0005ea
  8: @c1bea700  length 800005ea status 0c0005ea
  9: @c1bea7a0  length 800005ea status 0c0005ea
  10: @c1bea840  length 800005ea status 0c0005ea
  11: @c1bea8e0  length 800005ea status 8c0005ea
  12: @c1bea980  length 800005ea status 8c0005ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0105ea
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0800
  Flags; bus-master 1, dirty 14351421(13) current 14351437(13)
  Transmit list 01beaa20 vs. c1beaa20.
  0: @c1bea200  length 800005ea status 0c0105ea
  1: @c1bea2a0  length 800005ea status 0c0105ea
  2: @c1bea340  length 800005ea status 0c0105ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0005ea
  7: @c1bea660  length 800005ea status 0c0005ea
  8: @c1bea700  length 800005ea status 0c0005ea
  9: @c1bea7a0  length 800005ea status 0c0005ea
  10: @c1bea840  length 800005ea status 0c0005ea
  11: @c1bea8e0  length 800005ea status 8c0005ea
  12: @c1bea980  length 800005ea status 8c0005ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0105ea
eth0: Resetting the Tx ring pointer.
hda: dma_timer_expiry: dma status == 0x21
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0800
  Flags; bus-master 1, dirty 14351421(13) current 14351437(13)
  Transmit list 01beaa20 vs. c1beaa20.
  0: @c1bea200  length 800005ea status 0c0105ea
  1: @c1bea2a0  length 800005ea status 0c0105ea
  2: @c1bea340  length 800005ea status 0c0105ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0005ea
  7: @c1bea660  length 800005ea status 0c0005ea
  8: @c1bea700  length 800005ea status 0c0005ea
  9: @c1bea7a0  length 800005ea status 0c0005ea
  10: @c1bea840  length 800005ea status 0c0005ea
  11: @c1bea8e0  length 800005ea status 8c0005ea
  12: @c1bea980  length 800005ea status 8c0005ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0105ea
eth0: Resetting the Tx ring pointer.
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
sd 4:0:0:0: SCSI error: return code = 0x06000000
end_request: I/O error, dev sdc, sector 211498896
Buffer I/O error on device sdc, logical block 26437362
Buffer I/O error on device sdc, logical block 26437363
Buffer I/O error on device sdc, logical block 26437364
Buffer I/O error on device sdc, logical block 26437365
Buffer I/O error on device sdc, logical block 26437366
Buffer I/O error on device sdc, logical block 26437367
Buffer I/O error on device sdc, logical block 26437368
Buffer I/O error on device sdc, logical block 26437369
Buffer I/O error on device sdc, logical block 26437370
Buffer I/O error on device sdc, logical block 26437371
sd 4:0:0:0: SCSI error: return code = 0x06000000
end_request: I/O error, dev sdc, sector 211499152
ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: hard resetting port
ide0: reset: success
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata4: softreset failed (SRST command error)
ata4: follow-up softreset failed, retrying in 5 secs
ata1: hard resetting port
ata2: hard resetting port
ata4: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to UDMA/25
ata2: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to UDMA/25
ata1: failed to recover some devices, retrying in 5 secs
ata4: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x1)
ATA: abnormal status 0xC1 on port 0xF8836007
ATA: abnormal status 0xC1 on port 0xF8836007
ata4.00: configured for UDMA/100
ata4: EH complete
ata2: hard resetting port
ata1: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/25
ata1: EH complete
ata2.00: configured for UDMA/25
ata2: EH complete
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
i2c_adapter i2c-0: Transaction error!
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 14500387(3) current 14500403(3)
  Transmit list 01bea840 vs. c1bea3e0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 8c0005ea
  2: @c1bea340  length 800005ea status 8c0005ea
  3: @c1bea3e0  length 80000456 status 0c010456
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 8000047e status 0c01047e
  10: @c1bea840  length 800005ea status 0c0005ea
  11: @c1bea8e0  length 800005ea status 0c0005ea
  12: @c1bea980  length 800005ea status 0c0005ea
  13: @c1beaa20  length 800005ea status 0c0005ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
hda: dma_timer_expiry: dma status == 0x21
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0800
  Flags; bus-master 1, dirty 14500387(3) current 14500403(3)
  Transmit list 01bea3e0 vs. c1bea3e0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 8c0005ea
  2: @c1bea340  length 800005ea status 8c0005ea
  3: @c1bea3e0  length 80000456 status 0c010456
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 8000047e status 0c01047e
  10: @c1bea840  length 800005ea status 0c0005ea
  11: @c1bea8e0  length 800005ea status 0c0005ea
  12: @c1bea980  length 800005ea status 0c0005ea
  13: @c1beaa20  length 800005ea status 0c0005ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: hard resetting port
ide0: reset: success
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata4: softreset failed (SRST command error)
ata4: follow-up softreset failed, retrying in 5 secs
ata1: hard resetting port
ata2: hard resetting port
ata4: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to UDMA/16
ata1: failed to recover some devices, retrying in 5 secs
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to UDMA/16
ata2: failed to recover some devices, retrying in 5 secs
ata4: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x3)
ATA: abnormal status 0xC1 on port 0xF8836007
ATA: abnormal status 0xC1 on port 0xF8836007
ata4.00: configured for UDMA/100
ata4: EH complete
ata1: hard resetting port
ata2: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/16
ata2: EH complete
ata1.00: configured for UDMA/16
ata1: EH complete
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 15217427(3) current 15217443(3)
  Transmit list 01beaac0 vs. c1bea3e0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 8c0005ea
  2: @c1bea340  length 800005ea status 8c0005ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 80000456 status 0c010456
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 15217427(3) current 15217443(3)
  Transmit list 01bea3e0 vs. c1bea3e0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 8c0005ea
  2: @c1bea340  length 800005ea status 8c0005ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 80000456 status 0c010456
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
hda: dma_timer_expiry: dma status == 0x21
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 8000
  Flags; bus-master 1, dirty 15217427(3) current 15217443(3)
  Transmit list 01bea3e0 vs. c1bea3e0.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 8c0005ea
  2: @c1bea340  length 800005ea status 8c0005ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 80000456 status 0c010456
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0005ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
sd 5:0:0:0: SCSI error: return code = 0x06000000
end_request: I/O error, dev sdd, sector 451246624
printk: 54 messages suppressed.
Buffer I/O error on device sdd, logical block 56405828
Buffer I/O error on device sdd, logical block 56405829
Buffer I/O error on device sdd, logical block 56405830
Buffer I/O error on device sdd, logical block 56405831
Buffer I/O error on device sdd, logical block 56405832
Buffer I/O error on device sdd, logical block 56405833
Buffer I/O error on device sdd, logical block 56405834
Buffer I/O error on device sdd, logical block 56405835
Buffer I/O error on device sdd, logical block 56405836
Buffer I/O error on device sdd, logical block 56405837
ata2.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata1: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to PIO4
ata2: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata1: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for PIO4
ata1: EH complete
ata2.00: configured for PIO4
ata2: EH complete
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!
i2c_adapter i2c-0: Transaction error!

-- 
Mark Wagner mark@lanfear.net
