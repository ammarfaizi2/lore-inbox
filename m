Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTBDVha>; Tue, 4 Feb 2003 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTBDVha>; Tue, 4 Feb 2003 16:37:30 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:37134 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S267405AbTBDVh3>;
	Tue, 4 Feb 2003 16:37:29 -0500
Message-ID: <3E4034D1.1020301@scssoft.com>
Date: Tue, 04 Feb 2003 22:46:57 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt8235 headache
References: <3E3EEF6E.6080107@scssoft.com> <1044360747.23312.14.camel@irongate.swansea.linux.org.uk> <20030204214212.B21554@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Feb 04, 2003 at 12:12:27PM +0000, Alan Cox wrote:
>>If you remove just the DVD drive what occurs ?

With the cdrom removed I am getting nice clean boot with
no timeouts, errors or lost interrupts:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340016A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
blk: queue c02cce00, I/O limit 4095Mb (mask 0xffffffff)
hdc: QUANTUM FIREBALL CX13.0A, ATA DISK drive
blk: queue c02cd270, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63
Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
  hdc:<6> [PTBL] [1582/255/63] hdc1

...but when trying to actually mount the disk, I'll get this:

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: DMA disabled
ide1: reset: master: error (0x00?)
hdc: lost interrupt
hdc: lost interrupt

... and the mount fails.

 >>Also do you have ACPI support enabled, as that breaks a lot of systems

ACPI was enabled, but disabling it (recompiling with ACPI disabled)
does not have any effect.

> The more reports I get the more i think this is a vt8235 hw-bug. Or
> the vt8235 registers are different from all its predecessors.
> 
> I'll send a patch soonish to fix this. (it's the address setup
> timing - it must be set to 0xff on a vt8235 or problems happen with
> ATAPI devices).

I am still unable to access the disk on IDE1 even with the cdrom
removed on that channel. (though from the dmesg it looks like the
cdrom makes things even worse)

I have also tried Alan's new 2.4.21-pre4-ac2 (btw: extraversion is
still -ac1), with no difference.

I am looking forward to try the patch!

Best regards,
Petr

