Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVCBTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVCBTns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCBTns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:43:48 -0500
Received: from news.cistron.nl ([62.216.30.38]:22224 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262441AbVCBTnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:43:32 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.6.11: iostat values broken, or IDE siimage driver ?
Date: Wed, 2 Mar 2005 19:43:31 +0000 (UTC)
Organization: Cistron
Message-ID: <d05513$8fr$1@news.cistron.nl>
References: <d053g8$6et$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1109792611 8699 194.109.0.112 (2 Mar 2005 19:43:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <d053g8$6et$1@news.cistron.nl>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>I just upgrades one of our newsservers from 2.6.9 to 2.6.11. I
>use "iostat -k -x 2" to see live how busy the disks are. But
>I don't believe that Linux optimizes things so much that a disk
>can be 1849.55% busy :)
>

The stats also show 10-30 MB/sec writes to the disks, which make
no sense at all. The system feels very slow and (being a usenet
news server) can only keep up with about 8 mbit/sec (so it should
in this case write 1 MB/sec to all disks combined).

Perhaps this is the cause:

Mar  2 19:55:25 hdg: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
Mar  2 19:55:26 quantum last message repeated 12 times
hdg: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
Mar  2 19:55:57 quantum last message repeated 172 times
Mar  2 19:56:58 quantum last message repeated 551 times
Mar  2 19:57:59 quantum last message repeated 517 times
Mar  2 19:59:00 quantum last message repeated 608 times
.. etc etc ..

I have a serial console attached, so that probably explains why
the system feels so slow when it is spewing these errors (but
it doesn't explain the weird iostat values, or does it ?)

This is the config:

ICH5-SATA: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y080M0, ATA DISK drive
hdd: Maxtor 6Y080M0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:03.0
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 19
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100%% native mode on irq 19
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y080M0, ATA DISK drive
ide2 at 0xf8802e80-0xf8802e87,0xf8802e8a on irq 19
Probing IDE interface ide3...
hdg: Maxtor 6Y080M0, ATA DISK drive
ide3 at 0xf8802ec0-0xf8802ec7,0xf8802eca on irq 19
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2
hdd: max request size: 128KiB
hdd: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
hdd: cache flushes supported
 hdd: hdd1
hde: max request size: 64KiB
hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
hde: cache flushes supported
 hde: hde1
hdg: max request size: 64KiB
hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
hdg: cache flushes supported
 hdg:<4>hdg: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
 hdg1

I've now rebooted to 2.6.9 and that kernel runs just fine.

Mike.

