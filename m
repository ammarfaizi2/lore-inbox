Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbUKQV7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbUKQV7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbUKQV5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:57:48 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:22421 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262615AbUKQVzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:55:05 -0500
Message-ID: <419BC8B0.7090109@lengard.net>
Date: Wed, 17 Nov 2004 22:54:56 +0100
From: pascal lengard <lklm@lengard.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: ide ati ixp driver evolution ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm not subscribed to the list so please CC me on replies/thread this 
might produce, thanks.

I recently bought a new PC with ATI IXP chipset for sound, video, ide.
sound is working correctly but IDE was really slow (no dma) until I
recompiled my Fedora core 3 kernel, changing include/linux/pci_ids.h
to have my chipset recognized as a ati_ixp one.

here is the result of lspci on the computer:

00:00.0 Host bridge: ATI Technologies Inc: Unknown device 7833
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 7838
00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4367 (rev 01)
00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4368 (rev 01)
00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4365 (rev 01)
00:14.0 SMBus: ATI Technologies Inc: Unknown device 4363 (rev 03)
00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4369 (rev 01)
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 436c (rev 01)
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4362 (rev 01)
00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown 
device 4361 (rev 03)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 9100 PRO IGP
02:06.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)


To have the chipset recognized, I just changed the line:
/* ATI IXP Chipset */
#define PCI_DEVICE_ID_ATI_IXP_IDE        0x4349

with this one:
#define PCI_DEVICE_ID_ATI_IXP_IDE       0x4369


after that, dmesg says kernel recognized the chip and DMA is working,
hdparm -t changed from 8MB/s to 47MB/s, nice !

messaged during boot (dmesg):
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 10 (level, low) -> IRQ 10
ATIIXP: chipset revision 1
ATIIXP: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM BDV316E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15


I guess this could be taken care of in a future release of the kernel,
or maybe you need more documentation from Ati on what have changed
between these 2 releases of the chip ?

I am volunteering to test the patches that might be produced to make
this hardware function correctly, if needed ...

Regards,
Pascal Lengard
