Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTB1Bdq>; Thu, 27 Feb 2003 20:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTB1Bdq>; Thu, 27 Feb 2003 20:33:46 -0500
Received: from asynk49.modempool.kth.se ([130.237.10.49]:9856 "EHLO
	zaphod.guide") by vger.kernel.org with ESMTP id <S267385AbTB1Bdn>;
	Thu, 27 Feb 2003 20:33:43 -0500
To: linux-kernel@vger.kernel.org
Subject: hpt374 misbehaving
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 28 Feb 2003 02:02:23 +0100
Message-ID: <yw1xd6ldw734.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having some trouble with an hpt374 based card, the S-ATA version.
The chip is detected correctly, but after that the problems start.

Here's what linux 2.5.62 has to say:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 01:0a.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x8800-0x8807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8808-0x880f, BIOS settings: hdk:pio, hdl:pio
hde: ST38641A, ATA DISK drive
hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hde: set_drive_speed_status: error=0x04 { DriveStatusError }
ide2 at 0x8c00-0x8c07,0x8c22 on irq 44
hda: TOSHIBA CD-ROM XM-5702B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hde: lost interrupt
hde: lost interrupt
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 16514064 sectors (8455 MB) w/128KiB Cache, CHS=16383/16/63
 /dev/ide/host2/bus0/target0/lun0: p1 p2


After this, booting proceeds normally (from other devices).  If I try
to access the disk, more 'hde: lost interrupt' messages show up in the
log.  The disk is inaccessible.


Using linux 2.4.21-pre4, I get these messages:

HPT374: IDE controller at PCI slot 01:0a.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x8800-0x8807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8808-0x880f, BIOS settings: hdk:pio, hdl:pio
hda: TOSHIBA CD-ROM XM-5702B, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hde: ST38641A, ATA DISK drive
blk: queue fffffc0000550410, no I/O memory limit
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8c00-0x8c07,0x8c22 on irq 44
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 16514064 sectors (8455 MB) w/128KiB Cache, CHS=16383/16/63, UDMA(33)
Partition check:
 /dev/ide/host2/bus0/target0/lun0:<3>hde: lost interrupt
 p1 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
IP-Config: Complete:
      device=eth0, addr=192.168.42.3, mask=255.255.255.0, gw=192.168.42.2,
     host=192.168.42.3, domain=, nis-domain=(none),
     bootserver=192.168.42.2, rootserver=192.168.42.2, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.42.2
Looking up port of RPC 100005/1 on 192.168.42.2
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 336k freed
eth0: Setting full-duplex based on MII#5 link partner capability of 45e1.
hde: lost interrupt
hde: dma_timer_expiry: dma status == 0x21
hde: timeout waiting for DMA
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
hde: status timeout: status=0xd0 { Busy }

hde: drive not ready for command
ide2: reset timed-out, status=0xd0
hde: status timeout: status=0xd0 { Busy }

hde: drive not ready for command
ide2: reset timed-out, status=0xd0
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6
end_request: I/O error, dev 21:00 (hde), sector 8
end_request: I/O error, dev 21:00 (hde), sector 10
end_request: I/O error, dev 21:00 (hde), sector 12
end_request: I/O error, dev 21:00 (hde), sector 14


Is this caused by the card being the S-ATA version?  Is the disk
responsible?  I'm not that keen on trying with a better disk, since
they all contain data I would like to keep.  Is there some newer
driver available?

I can use hdparm to change settings for the disk, but not read any
data from it.

-- 
Måns Rullgård
mru@users.sf.net
