Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVISQCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVISQCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVISQCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:02:15 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:44947 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932482AbVISQCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:02:14 -0400
Message-ID: <432EE103.5020105@vc.cvut.cz>
Date: Mon, 19 Sep 2005 18:02:11 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz>	<20050916023005.4146e499.akpm@osdl.org>	<432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
In-Reply-To: <20050916230809.789d6b0b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> 
>>Andrew Morton wrote:
>> > Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>> > 
>> >>   so now once crashes on UP system were sorted out, I tried to
>> >> put new kernel on my SMP host - and sorry to say, but it does not
>> >> seem to work as advertised :-(
>> > 
>> > .config (again), please.
>>
>> Any SMP with NUMA.  One which I'm trying to debug now is attached.
>> It is available at http://vana.vc.cvut.cz/config as well.
> 
> I can get 2.6.14-rc1 to crash with your .config, but current -linus is OK.

It still dies for me, with current git (tree 7513cdadc661cfe0bd1625145a4876e54df191ca,
commit 6c0741fbdee5bd0f8ed13ac287c4ab18e8ba7d83).  Config is available at
http://platan.vc.cvut.cz/config-vana.txt.  Box is dual opteron Tyan K8W, S2885.

Any idea how to track problem down?  I'm not sure bisect will work without
lot of interaction & patching, as almost all kernels after 2.6.13 were dying
with some other problems on that box...
						Thanks,
							Petr Vandrovec


Bootdata ok (command line is BOOT_IMAGE=Linux ro root=801 ramdisk=0 console=ttyS0,115200 console=tty0 nmi_watchdog=2 psmouse_noext=1 verbose)
Linux version 2.6.14-rc1-6c07 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #4 SMP Mon Sep 19 17:44:44 CEST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-3fffffff
SRAT: Node 1 PXM 1 40000000-7fffffff
SRAT: Node 0 PXM 0 0-3fffffff
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ffeffff
ACPI: PM-Timer IO Port: 0x5008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xff4ff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xff4ff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xff4fe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xff4fe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f780000)
Checking aperture...
CPU 0: aperture @ c0000000 size 512 MB
CPU 1: aperture @ c0000000 size 512 MB
Built 2 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=801 ramdisk=0 console=ttyS0,115200 console=tty0 nmi_watchdog=2 psmouse_noext=1 verbose
Parameter psmouse_noext is obsolete, ignored
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1993.374 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2056328k/2097088k available (2616k kernel code, 40372k reserved, 1869k data, 248k init)
Calibrating delay using timer specific routine.. 3991.40 BogoMIPS (lpj=19957004)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.458 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3986.60 BogoMIPS (lpj=19933040)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -8 cycles, maxerr 1095 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
time.c: Using HPET based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCIB] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
agpgart: Detected AMD 8151 AGP Bridge rev B3
agpgart: AGP aperture is 512M @ 0xc0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
pnp: 00:09: ioport range 0xb78-0xb7f has been reserved
pnp: 00:09: ioport range 0xf78-0xf7f has been reserved
PCI: Bridge: 0000:00:06.0
   IO window: 9000-afff
   MEM window: ff100000-ff2fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
   IO window: disabled.
   MEM window: ff300000-ff3fffff
   PREFETCH window: 9e900000-9e9fffff
PCI: Bridge: 0000:00:0b.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:04:01.0
   IO window: c000-cfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: 9eb00000-beafffff
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1127144995.320:1): initialized
Total HugeTLB memory allocated, 0
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 240x75
radeonfb (0000:05:00.0): ATI Radeon Yd
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:1849
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 8, comm: events/0 Not tainted 2.6.14-rc1-6c07 #1
RIP: 0010:[<ffffffff8016d316>] <ffffffff8016d316>{free_block+294}
RSP: 0000:ffff81007ff21d88  EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000310
RDX: 0000000000000000 RSI: ffff81007ffddd10 RDI: ffff81007ffda080
RBP: ffff81007ffde000 R08: ffff81003ffa0d50 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81007ffc9b50
R13: ffff81007ffde048 R14: ffff81007ffda080 R15: ffff81007ffda080
FS:  0000000000000000(0000) GS:ffffffff805f2800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process events/0 (pid: 8, threadinfo ffff81007ff20000, task ffff81003ff8c790)
Stack: 0000000000000000 0000000000000000 0000000000000292 hda: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
0000000200000000
        ffff81007ffddd10 ffff81007ffddd10 ffff81007ffddce8 0000000000000002
        0000000000000000 ffff81007ffda080
Call Trace:<ffffffff8016e8b7>{drain_array_locked+167} <ffffffff8016e9f7>{cache_reap+231}
        <ffffffff80131e23>{__wake_up+67} <ffffffff8016e910>{cache_reap+0}
        <ffffffff8014930c>{worker_thread+476} <ffffffff80131d60>{default_wake_function+0}
        <ffffffff80131d60>{default_wake_function+0} <ffffffff80149130>{worker_thread+0}
        <ffffffff8014db82>{kthread+146} <ffffffff8010ec22>{child_rip+8}
        <ffffffff80149130>{worker_thread+0} <ffffffff8014daf0>{kthread+0}
        <ffffffff8010ec1a>{child_rip+0}

Code: 0f 0b 68 9d 26 3d 80 c2 39 07 48 89 ee 4c 89 ff 4c 8d 75 30
RIP <ffffffff8016d316>{free_block+294} RSP <ffff81007ff21d88>
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD1200JB-00CRA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes not supported
  hdc: hdc1
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:0b.0[A] -> GSI 17 (level, low) -> IRQ 177

