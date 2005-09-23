Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVIWRK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIWRK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIWRK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:10:57 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:1692 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750732AbVIWRK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:10:56 -0400
Date: Fri, 23 Sep 2005 19:10:54 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: PCI/IRQ regressions in 2.6.13.2
Message-ID: <20050923171054.GB19763@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

I've tried to upgrade my Linux boxes to 2.6.13.2, and on some configurations
I have problems that IRQ stopped working or devices are not visible on
the PCI bus. These problems may be completely unrelated, though:

---------------------------------------------------------------------------
Case 1: HP DL-585 quad Opteron box - 2.6.11.10 to 2.6.13.2: The QLA 2312
	fibre channel HBA is not visible on the PCI bus - here is a diff -u
	between lspci on 2.6.13.2 and 2.6.11.10

--- /tmp/lspci-2.6.13.2  2005-09-23 18:16:24.000000000 +0200
+++ /tmp/lspci-2.6.11.10 2005-09-23 18:20:28.000000000 +0200
@@ -30,3 +30,12 @@
 02:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 5i/532 (rev 01)
 02:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
 02:06.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
+04:09.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)+04:09.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
+04:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)+04:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
+04:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)+04:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
+04:0c.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)+04:0c.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
+06:0e.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)


--------------------------------------------------------------------------
Case 2: ASUS A7V600 Athlon box (I have six of those boxes, and the problem
	is only on one of them): During boot the IDE controller complains
	about IRQ probe failing:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: IRQ 14 for device 0000:00:0f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: setting IRQ 14 as level-triggered
PCI: Assigned IRQ 14 for device 0000:00:0f.1
IRQ routing conflict for 0000:00:10.0, have irq 12, want irq 14
IRQ routing conflict for 0000:00:10.1, have irq 12, want irq 14
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
hda: IRQ probe failed (0xffffbbfa)
hdb: IRQ probe failed (0xfffffbfa)
hdb: IRQ probe failed (0xfffffbfa)
irq 14: nobody cared (try booting with the "irqpoll" option)
 [<c01306c4>] __report_bad_irq+0x24/0x80
 [<c01307c2>] note_interrupt+0x72/0xc0
 [<c01301b0>] __do_IRQ+0xe0/0xf0
 [<c0104e59>] do_IRQ+0x19/0x30
 [<c0103492>] common_interrupt+0x1a/0x20
 [<c011aa50>] __do_softirq+0x30/0x90
 [<c011aad6>] do_softirq+0x26/0x30
 [<c0104e5e>] do_IRQ+0x1e/0x30
 [<c0103492>] common_interrupt+0x1a/0x20
 [<c01303a7>] setup_irq+0x77/0xf0
 [<c0214da0>] ide_intr+0x0/0x170
 [<c013057d>] request_irq+0x9d/0xb0
 [<c0218aca>] init_irq+0x19a/0x400
 [<c02191b2>] hwif_init+0xd2/0x290
 [<c021873d>] probe_hwif_init_with_fixup+0x1d/0x80
 [<c021ba93>] ide_setup_pci_device+0x43/0x80
 [<c03623f1>] ide_scan_pcidev+0x31/0x60
 [<c036243d>] ide_scan_pcibus+0x1d/0xa0
 [<c03623a8>] ide_init+0x48/0x60
 [<c0350897>] do_initcalls+0x57/0xc0
 [<c0154205>] kern_mount+0x15/0x19
 [<c0100280>] init+0x0/0x100
 [<c01002aa>] init+0x2a/0x100
 [<c0100f00>] kernel_thread_helper+0x0/0x10
 [<c0100f05>] kernel_thread_helper+0x5/0x10
handlers:
[<c0214da0>] (ide_intr+0x0/0x170)
Disabling IRQ #14
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD2500JB-00EVA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: lost interrupt
irq 14: nobody cared (try booting with the "irqpoll" option)
[...]

	The pci=usepirqmask boot option seems to fix the problem.

	The only difference in "lspci -vv" between 2.6.12.3 and 2.6.13.2
is the following line in the IDE controller section:

-       Interrupt: pin A routed to IRQ 14
+       Interrupt: pin A routed to IRQ 11

(altough according to /proc/interrupts, ide uses IRQ 14/15 as usual both
on 2.6.12.3 and 2.6.12.2).

-------------------------------------------------------------------------
Case 3: ASUS A7V8X Athlon box (again, I have six of those boxes, only
	one of them does not work): During boot the tg3 NIC is detected,
	but does not work (probably no interrupts comming through).
	The relevant part of dmesg(8) is

PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:07.0 doesn't match PIRQ mask - try pci=usepirqmaskPCI: Found IRQ 10 for device 0000:00:07.0
PCI: Sharing IRQ 10 with 0000:00:08.0
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmaskPCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d6000000-d7dfffff
  PREFETCH window: d7f00000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
highmem bounce pool size: 64 pages
Generic RTC Driver v1.07
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
tg3.c:v3.37 (August 25, 2005)
PCI: Enabling device 0000:00:09.0 (0014 -> 0016)
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmaskPCI: setting IRQ 9 as level-triggered
PCI: Assigned IRQ 9 for device 0000:00:09.0
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:b6:6b:c7
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[763f0000]

	Here the pci=usepirqmask does not fix the problem.
Thanks for any solution!

-Yenya


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
>>> $ cd my-kernel-tree-2.6                                              <<<
>>> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts  <<<
