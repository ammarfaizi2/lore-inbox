Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTF0OdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTF0OdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:33:23 -0400
Received: from ck408323-a.dokku1.fr.home.nl ([217.122.140.78]:50872 "EHLO
	ck408323-a.dokku1.fr.home.nl") by vger.kernel.org with ESMTP
	id S264380AbTF0Occ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:32:32 -0400
Message-ID: <1256.212.187.32.129.1056725249.squirrel@jgc.homeip.net>
Date: Fri, 27 Jun 2003 16:47:29 +0200 (CEST)
Subject: Serverworks OSB4 issues
From: "Jan de Groot" <admin@jgc.homeip.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: enabling DMA on the Serverworks OSB4: IDE timeouts, a bus reset
and a DMA disabled harddisk
This morning I upgraded from 2.4.20 to 2.4.21, because I needed some extra
options and someone told me the "OSB4 in impossible state"-problem when
running a CD-ROM in DMA should be fixed.After booting, the disk runs completely in PIO mode, slow as hell. With
2.4.20 it was working without problems in UDMA33 mode. I use hdparm to
turn on DMA mode (hdparm -d1 /dev/hdb). Also trying MWDMA2 doesn't help:
still IDE reset.
Kernel version:
Linux version 2.4.21 (root@server) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 SMP Tue Jun 24 08:55:05 CEST 2003
IDE initialisation logs:
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
hda: CD-540E, ATAPI CD/DVD-ROM drive
hdb: MAXTOR 4K040H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 78198750 sectors (40038 MB) w/2000KiB Cache, CHS=5171/240/63
Partition check:
 hdb: hdb1 < hdb5 hdb6 >

When it goes wrong:
hda: attached ide-cdrom driver.
hda: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
hda: CHECK for good STATUS
blk: queue c02d136c, I/O limit 4095Mb (mask 0xffffffff)
hdb: dma_timer_expiry: dma status == 0x41
hdb: timeout waiting for DMA
hdb: timeout waiting for DMA
hdb: (__ide_dma_test_irq) called while not waiting
hdb: status timeout: status=0xd0 { Busy }

hdb: drive not ready for command
ide0: reset: success
hdb: DMA disabled
EXT3-fs error (device ide0(3,70)): ext3_add_entry: bad entry in directory
#196225: rec_len is smaller than minimal - offset=0, inode=4269932543,
rec_len=2, name_len=12

