Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVI3KUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVI3KUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVI3KUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:20:46 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:21633 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965016AbVI3KUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:20:46 -0400
Date: Fri, 30 Sep 2005 12:20:41 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI/IRQ regressions in 2.6.13.2
Message-ID: <20050930102041.GD10110@fi.muni.cz>
References: <20050923171054.GB19763@fi.muni.cz> <20050928204510.GC19285@kroah.com> <20050929144320.GO1901@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929144320.GO1901@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: Greg KH wrote:
: : On Fri, Sep 23, 2005 at 07:10:54PM +0200, Jan Kasprzak wrote:
: : > 	Hello,
: : > 
: : > I've tried to upgrade my Linux boxes to 2.6.13.2, and on some configurations
: : > I have problems that IRQ stopped working or devices are not visible on
: : > the PCI bus. These problems may be completely unrelated, though:
: : 
: : Can you see if 2.6.14-rc2 fixes the pci issues?
: : 
: 	I have not been able to test the issue with part of PCI bus
: missing from the lspci output on HP DL-585 quad opteron (the server is
: in production use, I cannot reboot it just now), however the two other
: problems (IRQ timeout on IDE controller and no IRQs on tg3 NIC) seem
: to be fixed on 2.6.14-rc2.

	I have found that this is because I have accidentally
compiled the 2.6.14-rc2 with CONFIG_ACPI. With this option the problem
disappears, but with CONFIG_ACPI=n it is still there even in 2.6.14-rc2.

	And what is worse, I have tried to copy the 2.6.14-rc2 with
CONFIG_ACPI=y to all servers in my cluster, and on two of them
(different ones than manifest the previous problem) the kernel
does not boot - and it complains about lost interrupts on /dev/hda
(dmesg attached - note the "VIA IRQ fixup" and "Unknown interrupt or fault"
lines around the IDE initialization). Sorry for the previous incomplete
report, but 2.6.14-rc2 does not work for me with or without CONFIG_ACPI
(albeit on different hosts).

-Yenya

Linux version 2.6.14-rc2 (root@...) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #3 Fri Sep 30 12:05:46 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda1 console=ttyS0,38400n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2000.448 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036104k/1048560k available (1748k kernel code, 11688k reserved, 553k data, 148k init, 131056k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4007.15 BogoMIPS (lpj=8014314)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(TM) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1ad0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ee000000-efdfffff
  PREFETCH window: eff00000-f7ffffff
Simple Boot Flag at 0x3a set to 0x1
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
tg3.c:v3.40 (September 15, 2005)
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:b6:64:fa
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
hda: ST360021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD2500JB-32FUA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
Unknown interrupt or fault at EIP 00000246 00000060 c0100c86
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 1024KiB
hdc: lost interrupt
hdc: lost interrupt
hdc: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdc: lost interrupt
hdc: cache flushes supported
 hdc: hdc1 hdc2
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.3 (8191 buckets, 65528 max) - 216 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
>>> $ cd my-kernel-tree-2.6                                              <<<
>>> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts  <<<
