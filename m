Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262749AbSI1Iq6>; Sat, 28 Sep 2002 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSI1Iq6>; Sat, 28 Sep 2002 04:46:58 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:41996 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S262749AbSI1Iq4>;
	Sat, 28 Sep 2002 04:46:56 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: IDE C/H/S questions
Organization: Who, me?
User-Agent: tin/1.5.13-20020703-gzp ("Chop Suey!") (UNIX) (Linux/2.4.20-pre8 (i686))
Message-ID: <104e.3d956dbf.ce25b@gzp1.gzp.hu>
Date: Sat, 28 Sep 2002 08:52:15 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developers,

running recent 2.4.20-preX and -ac kernels I'm getting weird
CHS infos about my ide disks on the primary onboard IHC2
controller:

Kernel 2.4.20-pre8, or 2.4.20-pre7-ac3 both:

ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
PDC20268: IDE controller at PCI slot 02:0d.0
PCI: Found IRQ 9 for device 02:0d.0
PCI: Sharing IRQ 9 with 02:09.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio

hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
hde: host protected area => 1
hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
hdg: host protected area => 1
hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)

I started to use pre7-ac3 because its drives well my
PDC20268 in UDMA100 instead of UDMA33 as in pre-8.

When I'm appending the correct CHS with lilo it works fine,
but why its not autodetected?

hda: IC35L060AVVA07-0, ATA DISK drive
blk: queue c02e1900, I/O limit 4095Mb (mask 0xffffffff)
hdc: IC35L060AVVA07-0, ATA DISK drive
blk: queue c02e1d6c, I/O limit 4095Mb (mask 0xffffffff)
hde: IC35L060AVVA07-0, ATA DISK drive
blk: queue c02e21d8, I/O limit 4095Mb (mask 0xffffffff)
hdg: IC35L060AVVA07-0, ATA DISK drive
blk: queue c02e2644, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xb402 on irq 9
ide3 at 0xb000-0xb007,0xa802 on irq 9

Also discovered, that mke2fs see different block numbers on
the PDC20268 as on the onboard (Asus TUSL2-C) controller:

mke2fs 1.26 (3-Feb-2002)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
7520256 inodes, 15012734 blocks
750636 blocks (5.00%) reserved for the super user
First data block=0
459 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group

On PDC I get:

mke2fs 1.26 (3-Feb-2002)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
7520256 inodes, 15012892 blocks
750644 blocks (5.00%) reserved for the super user
First data block=0
459 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group

Again, why?

