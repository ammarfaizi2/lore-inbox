Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRC3NXT>; Fri, 30 Mar 2001 08:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRC3NXK>; Fri, 30 Mar 2001 08:23:10 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:14475 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S131407AbRC3NWu>; Fri, 30 Mar 2001 08:22:50 -0500
Date: Fri, 30 Mar 2001 14:22:01 +0100
From: Ian G Batten <I.G.Batten@ftel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: ide_cs post 2.4.1
Message-ID: <20010330142200.O14482@himalia.ftel.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: Fujitsu Telecommunications Europe Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my laptop, a Fujitsu B110, I have started having trouble with the
ide_cs portion of the in-kernel PCMCIA package.  Up to 2.4.1 I was able
to successfully use either a Freecom PCMCIA CD R/W unit or to insert a
compact flash module from my TRGPro or digital camera via an adapter.
In subsequent releases (2.4.2, 2.4.3-pre3, 2.4.3-pre6, 2.4.2-ac28) I
have tried, they are not recognised.

>From bootup on 2.4.1, the following facts seem salient when I boot with
an ethernet card in (the machine only has one, type 2, slot):

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 09
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf4d0-0xf4d7, BIOS settings: hda:DMA, hdb:pio
hda: HITACHI_DK23AA-60, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 11733120 sectors (6007 MB) w/512KiB Cache, CHS=776/240/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
[...]
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 00:13.0
Intel PCIC probe: not found.
[...]
Yenta IRQ list 0c98, PCI irq9
Socket status: 30000410
[...]
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@cesdis.gsfc.nasa.gov.
eth0: 3Com 3c574 at io 0x300, irq 10, hw_addr 00:00:86:33:D3:29.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.

If I eject that board and insert some compact flash, I see:

hdc: SunDisk SDCFB-8, ATA DISK drive
ide1 at 0x100-0x107,0x10e on irq 10
hdc: 15680 sectors (8 MB) w/1KiB Cache, CHS=245/2/32
 hdc: hdc1
ide_cs: hdc: Vcc = 3.3, Vpp = 0.0
VFS: Disk change detected on device ide1(22,1)
 hdc: hdc1
VFS: Disk change detected on device ide1(22,1)
 hdc: hdc1

However, if I reboot on 2.4.2-ac28 or some other post-2.4.1 kernel, the
bootup messages are the same and the ethernet card works correctly.
However, although the compact flash is recognised when inserted or
present at boot (cardmgr says ``socket 0: ATA/IDE Fixed Disk'' and
cardctl ident shows it present and detected with the right type, ide-cs
module loaded) you cannot mount the filesystem ENODEV.  Likewise,
inserting the Freecom CD R/W gadget identifies correctly, and loads the
correct stack (ide-cs, ide-scsi, sg, scsi_mod) but cdrecord -scanbus
again reports ENODEV.

Any thoughts?  Offers?  Suggestions as where to investigate?  I haven't
been deep in a kernel since Systen V Release 3...

ian







