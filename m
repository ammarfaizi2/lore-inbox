Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266106AbSKKLGV>; Mon, 11 Nov 2002 06:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbSKKLGV>; Mon, 11 Nov 2002 06:06:21 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:6872 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266106AbSKKLGU>;
	Mon, 11 Nov 2002 06:06:20 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: axboe@suse.de
Date: Mon, 11 Nov 2002 12:12:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: TCQ in 2.5.46 when sharing channel with non-TCQ drive
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <733078326E0@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
  just FYI: I just plugged IBM's IBM-DTLA-307045 as slave to the 
WDC1200JB-00CRA0, and because of I have enabled TCQ in kernel, it 
started using TCQ on IBM (WDC is not TCQ aware). During bootup it reported
'bad special flag: 0x03' on IBM, and later during 'rm -rf /mnt2' (where
/mnt2 is contents of IBM's disk) I got:

Linux version 2.5.46-c985 (root@vana) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 SMP Fri Nov 8 22:47:13 CET 2002
...
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00CRA0, ATA DISK drive
hdb: IBM-DTLA-307045, ATA DISK drive
hdb: bad special flag: 0x03
hdb: tagged command queueing enabled, command queue depth 8
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA MK6409MAV, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: host protected area => 1
hdb: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: host protected area => 1
hdc: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: p1
...
ide_tcq_intr_timeout: timeout waiting for service interrupt
ide_tcq_intr_timeout: missing isr!
hdb: invalidating tag queue (0 commands)
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { DriveStatusError }
ide_tcq_intr_timeout: timeout waiting for service interrupt
ide_tcq_intr_timeout: missing isr!
hdb: invalidating tag queue (0 commands)
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { DriveStatusError }
ide_tcq_intr_timeout: timeout waiting for service interrupt
ide_tcq_intr_timeout: missing isr!
hdb: invalidating tag queue (0 commands)
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { DriveStatusError }
ide_tcq_intr_timeout: timeout waiting for service interrupt
ide_tcq_intr_timeout: missing isr!
hdb: invalidating tag queue (0 commands)
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { DriveStatusError }

Machine is still alive, and seems happy.
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
