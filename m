Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVGUR1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVGUR1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 13:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGUR1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 13:27:01 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:49416 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261819AbVGUR1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 13:27:00 -0400
Date: Thu, 21 Jul 2005 19:26:48 +0200
From: jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: often ide errors on amd64 / A8N-SLI
Message-ID: <20050721172648.GA21124@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from dmesg:
Linux version 2.6.13-rc3-mm1 (jurriaan@middle) (gcc version 4.0.1 (Debian 4.0.1-2)) #4 Thu Jul 21 19:09:25 CEST 2005
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD2000JB-32EVA0, ATA DISK drive
hdb: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

I see a lot of these errors:


hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown


           CPU0       
  0:     204642    IO-APIC-edge  timer
  1:       3710    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:        106    IO-APIC-edge  i8042
 14:      30571    IO-APIC-edge  ide0
 15:      30529    IO-APIC-edge  ide1
 50:          0   IO-APIC-level  ohci_hcd:usb2
 58:       9407   IO-APIC-level  libata
 66:         54   IO-APIC-level  libata, NVidia CK804
 74:      61503   IO-APIC-level  libata
 82:          0   IO-APIC-level  ehci_hcd:usb1
225:      56249   IO-APIC-level  ohci1394, fast
233:          0   IO-APIC-level  SysKonnect SK-98xx
NMI:        483 
LOC:     204607 
ERR:          0
MIS:          0

Is there any way to detect what exactly is causing this? To the best of
my knowledge, the disk works fine - even my raid1 set on this disk isn't
impacted, the speed stays ok, I'm wondering if there's a command being
sent the disk (or the controller) doesn't know how to handle.

smartctl isn't active, BTW.

Thanks,
Jurriaan
-- 
And the gosts of hope walk silent halls
At the death of the promised land
All is gone, all is gone
But these changing winds can turn cold and hostile
	New Model Army
Debian (Unstable) GNU/Linux 2.6.13-rc3-mm1 5149 bogomips load 0.97
