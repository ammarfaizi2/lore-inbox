Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWGQO1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWGQO1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWGQO1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:27:08 -0400
Received: from the.earth.li ([193.201.200.66]:16865 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1750791AbWGQO1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:27:07 -0400
Date: Mon, 17 Jul 2006 15:27:05 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Status of HPT372A driver?
Message-ID: <20060717142705.GS1485@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I recently acquired a HighPoint RocketRaid 1520 SATA controller (I know,
I know, bad choice but I just need something to tide me over until I can
upgrade to a motherboard with AHCI love). This presents as a HPT372A:

00:09.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 01)
00:09.0 0104: 1103:0005 (rev 01)

The 2.6.17 hpt366.c driver is at version 0.36. I also found your patches
to l-k earlier this year, but I'm not sure whether I got them all as I
had some rejects; I ended up with a version 1.00 driver as at:

http://the.earth.li/~noodles/hpt366.c

Is there somewhere I can get your latest work without having to try to
pick the right patches from the l-k archives?

Also I'm getting fairly appalling speeds; I don't know if this is thie
card or not, but I have a SATA II capable drive (I know the controller
 is only SATA I) attached that's getting detected as:

hde: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, UDMA(33)

I'd expect UDMA(133) or similar instead? hdparm -Tt gives:

/dev/sda:
 Timing cached reads:   984 MB in  2.00 seconds = 491.58 MB/sec
 Timing buffered disk reads:   90 MB in  3.00 seconds =  30.00 MB/sec

/dev/hda:
 Timing cached reads:   940 MB in  2.00 seconds = 469.89 MB/sec
 Timing buffered disk reads:  172 MB in  3.04 seconds =  56.66 MB/sec

/dev/hde:
 Timing cached reads:   1012 MB in  2.01 seconds = 504.48 MB/sec
 Timing buffered disk reads:   44 MB in  3.05 seconds =  14.43 MB/sec

(sda is an old 36GB SCSI disk on an Adaptec 2940, hda is a Maxtor on the
internal VIA PATA controller. I'd expected hde to at least outperform
sda.)

Relevent dmesg output is:

HPT372A: IDE controller at PCI slot 0000:00:09.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] - > GSI 11 (level, low) -> IRQ 11
HPT372A: chipset revision 1
HPT372A: DPLL base: 66 MHz, f_CNT: 99, assuming 33 MHz PCI
HPT372A: using 66 MHz DPLL clock
HPT372A: 100%% native mode on irq 11
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD2500KS-00MJB0, ATA DISK drive
ide2 at 0xa000-0xa007,0xa402 on irq 11

J.

-- 
/-\                             | noodles is really a meal in itself
|@/  Debian GNU/Linux Developer |
\-                              |
