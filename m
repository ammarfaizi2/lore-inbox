Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbRBARBb>; Thu, 1 Feb 2001 12:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRBARBV>; Thu, 1 Feb 2001 12:01:21 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:12299 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129686AbRBARBC>;
	Thu, 1 Feb 2001 12:01:02 -0500
Date: Thu, 01 Feb 2001 18:00:45 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Possible VIA IDE driver bug
To: linux-kernel@vger.kernel.org
Message-id: <3A79963D.EBE92353@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I maybe discovered a VIA IDE driver bug ( or maybe it is "just"
a bug in my BIOS ) :

( linux 2.4.0 and 2.4.1 same results )

1. Disable IDE Channel 0 in BIOS -> only ide1 is visible in linux
2. Disable IDE Channel 1 in BIOS -> only ide0 is visible in linux
3. Disable both channels -> linux reports ( on VT4 ) :
<4>VP_IDE:neither IDE port enabled (BIOS)

This is OK, alltough one may say that linux should use the
hardware regardless of BIOS settings.

The problem :
I enable both IDE channels in BIOS.
In BIOS I set all 4 units to "NONE",
except secondary master to MANUAL/CHS with
some dummy geometry ( otherwise the BIOS
checks the unit and initializes it; I have a CDROM
here and it seems that the BIOS always autodetects
them, no matter what I set in the CMOS setup )

When I now boot linux , ide0 is not detected !
This is the output on VT4:
...
<6> Uniform Multi Platform E-IDE driver 6.31
<4> ide: assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
<4>VP_IDE: IDE controller on PCIbus 00 dev 39
<4>VP_IDE:chipset revision 16
<4>VP_IDE:not 100% native mode: will probe irqs later
<4>VP_IDE:VIA vt82c686a IDE UDMA66 controller on pci0:7.1
<4> ide0: BM-DMA at 0xd000-0xd007, BIOS setting: hda:pio, hdb:pio
<4> ide1: BM-DMA at 0xd008-0xd00f, BIOS setting: hdc:pio, hdd:pio
<4> hdc: CD-532E-B, ATAPI CDROM drive
<4> ide: assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hdc: ATAPI 32x CD-ROM drive, 128kB Cache,DMA
<4>Uniform CD-ROM driver Revision: 3.11
... SCSI stuff ...

Observations:
We have a "ide0: BM-DMA at 0x..." line for ide0, but nothing else.
hda is not detected, no "ide0 at 0xxxx...." line.



Hardware: 
MSI K7T Pro2 motherboard , AWARD BIOS 6.0 v1.8
VIA KT133 chipset , v82c686a southbridge
AMD Duron 700MHz CPU
IDE Primary master   : Quantum Fireball lct20 harddisk 20 GB
IDE Primary slave    : nothing
IDE Secondary master : Teac CD532E-B , CDROM drive
IDE Secondary slave  : nothing
both set to "cable select"
both cables are ATA-66 , 80-wire cables
( the system is not oveclocked :-)
-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
