Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135237AbRAHD3U>; Sun, 7 Jan 2001 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbRAHD3K>; Sun, 7 Jan 2001 22:29:10 -0500
Received: from [216.114.12.3] ([216.114.12.3]:3294 "EHLO mail.nconnect.net")
	by vger.kernel.org with ESMTP id <S135237AbRAHD25>;
	Sun, 7 Jan 2001 22:28:57 -0500
From: "Josh Straub" <tookycat@nconnect.net>
To: <linux-kernel@vger.kernel.org>
Cc: <andre@linux-ide.org>
Subject: IDE HD DMA not being enabled in 2.4.0
Date: Sun, 7 Jan 2001 21:28:50 -0600
Message-ID: <003701c07923$1e642630$0101010a@jstraub128nt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is my first post to Linux-Kernel so I hope I get this right.

On my Pentium 200 system with Intel i430VX chipset and PIIX3, my Maxtor
3.5GB IDE HD would always have DMA enabled even in 2.4.0-test10, but then
sometime between 2.4.0-test12 and 2.4.0 (final), DMA was not being enabled
anymore upon boot.

Here is my relevant "dmesg" from 2.4.0-test10:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 83500A4, ATA DISK drive
hdb: ST31220A, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6839440 sectors (3502 MB) w/256KiB Cache, CHS=848/128/63, (U)DMA
hdb: 2116296 sectors (1084 MB) w/256KiB Cache, CHS=524/64/63, DMA

Notice the drive being picked up as (U)DMA, and the Seagate 1.2GB being
picked up as DMA.

Now look at my 2.4.0 dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 83500A4, ATA DISK drive
hdb: ST31220A, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6839440 sectors (3502 MB) w/256KiB Cache, CHS=848/128/63
hdb: 2116296 sectors (1084 MB) w/256KiB Cache, CHS=524/64/63, DMA

Here you can see that DMA is still configured, because the Seagate retains
DMA.  But for some reason the Maxtor is now getting no DMA at all.  I can
use "hdparm" to enable it manually and I did an "updatedb" to generate some
heavy test disk activity, and it worked fine.  So I cannot assume that DMA
is being disabled on my Maxtor on purpose, because of some bad hardware or
something, and I am guessing something changed in the IDE driver recently
that buggered the DMA enabling.

Please CC all correspondence to my email, since I don't subscribe to
Linux-Kernel.  Thanks!

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Josh Straub ô¿ô tookycat@nconnect.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
