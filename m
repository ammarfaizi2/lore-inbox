Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTGMTIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTGMTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:08:41 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:24369 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270345AbTGMTIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:08:40 -0400
Date: Sun, 13 Jul 2003 21:22:25 +0200
From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: ide and udma2 with WDC Caviar
Message-ID: <20030713192225.GA3276@tangerine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've an ASUS P5A motherboard with 2 ide disks.
The first one is a quantum fireball 30Gb
The second is a WDC caviar 40Gb

Here is how they are detected by the kernel (2.4.21):

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLP LM30, ATA DISK drive
hdb: WDC WD400BB-00DEA0, ATA DISK drive
hdc: GoldStar CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
hdd: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=3649/255/63
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
Partition check:
  hda: hda1 hda2 hda3 hda4
  hdb: [PTBL] [4865/255/63] hdb1


The second disk is not found by my BIOS due to the 32Gb limit.

The first disk runs fine and the throughput measured with hdparm -t is 
about 23Mb/s

For the second one the throughput is only 14Mb/s. If I check the 
settings with hdparm -I, I can see that it is running mdma2.

I tried to force it to udma2:
[root@tangerine] /home/jean-luc # hdparm -X66 /dev/hdb

/dev/hdb:
  setting xfermode to 66 (UltraDMA mode2)


The command is accepted but does nothing : the disk stays in mdma2 mode.

I've this problem with both 2.4.21 and 2.5.75.

I've done a test with Knoppix 3.2 ... and it works : I can setup the 
dma mode to udma2. I've asked to the Knoppix list to know if there is 
something special in the Knoppix kernel but I've not get any answer.

Any clue?

---
Regards
	Jean-Luc
