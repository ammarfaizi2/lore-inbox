Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWCIKa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWCIKa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCIKa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:30:59 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:36871 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S1751785AbWCIKa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:30:58 -0500
X-Obalka-From: mmokrejs@ribosome.natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Message-ID: <441003E5.3090904@ribosome.natur.cuni.cz>
Date: Thu, 09 Mar 2006 11:31:01 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 huge memory detection regression
References: <440D6581.9080000@ribosome.natur.cuni.cz>	 <20060307041532.3ef45392.akpm@osdl.org>	 <440D7BB8.40106@ribosome.natur.cuni.cz>	 <20060307113631.36ac029d.akpm@osdl.org> <1141765722.9274.105.camel@localhost.localdomain>
In-Reply-To: <1141765722.9274.105.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020006060802030507040308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020006060802030507040308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey, it happened on my third reboot retry. This time only 12GB detected.

Dave Hansen wrote:
> On Tue, 2006-03-07 at 11:36 -0800, Andrew Morton wrote:
> 
>>Because there was a change which could have affected this.  But it was
>>merged in late October and was present in 2.6.15.
> 
> 
> It certainly is possible that my patch caused the bug.  However, my
> patch only affects limit_regions(), which is only called when the user
> specifies a mem= argument on the command-line.  When they do this, in
> addition to the BIOS-e820 printout, they should also see a "user-defined
> physical RAM map:", which I don't see in the diff.  Also, I'm pretty
> sure that this e820 printout runs before parse_cmdline_early(), where
> limit_regions() is called.
> 
> Martin, in any case, I have debugged things in that code recently, and
> I'd be happy to help you fix your problem.  I've attached a patch that
> does a ton of e820 debug printks.  If you could get me a full copy of
> your dmesg with that applied, I should be able to locate the problem a
> bit more quickly.

--------------020006060802030507040308
Content-Type: text/plain;
 name="boot-2.6.16-rc5-git12-e820-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-2.6.16-rc5-git12-e820-patch"

Linux version 2.6.16-rc5-git12 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #5 SMP Thu Mar 9 11:22:22 MET 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009a800 end: 000000000009a800 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000000000, 000000000009a800, 1)
copy_e820_map() start: 000000000009a800 size: 0000000000005800 end: 00000000000a0000 type: 2
add_memory_region(000000000009a800, 0000000000005800, 2)
copy_e820_map() start: 00000000000e0000 size: 0000000000020000 end: 0000000000100000 type: 2
add_memory_region(00000000000e0000, 0000000000020000, 2)
copy_e820_map() start: 0000000000100000 size: 00000000cfe70000 end: 00000000cff70000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000100000, 00000000cfe70000, 1)
copy_e820_map() start: 00000000cff70000 size: 0000000000007000 end: 00000000cff77000 type: 3
add_memory_region(00000000cff70000, 0000000000007000, 3)
copy_e820_map() start: 00000000cff77000 size: 0000000000009000 end: 00000000cff80000 type: 4
add_memory_region(00000000cff77000, 0000000000009000, 4)
copy_e820_map() start: 00000000cff80000 size: 0000000000080000 end: 00000000d0000000 type: 2
add_memory_region(00000000cff80000, 0000000000080000, 2)
copy_e820_map() start: 00000000e0000000 size: 0000000010000000 end: 00000000f0000000 type: 2
add_memory_region(00000000e0000000, 0000000010000000, 2)
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
add_memory_region(00000000fec00000, 0000000000010000, 2)
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
add_memory_region(00000000fee00000, 0000000000001000, 2)
copy_e820_map() start: 00000000ff800000 size: 0000000000400000 end: 00000000ffc00000 type: 2
add_memory_region(00000000ff800000, 0000000000400000, 2)
copy_e820_map() start: 00000000fffffc00 size: 0000000000000400 end: 0000000100000000 type: 2
add_memory_region(00000000fffffc00, 0000000000000400, 2)
copy_e820_map() start: 0000000100000000 size: 0000000230000000 end: 0000000330000000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000100000000, 0000000230000000, 1)
 BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
 BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cff70000 (usable)
 BIOS-e820: 00000000cff70000 - 00000000cff77000 (ACPI data)
 BIOS-e820: 00000000cff77000 - 00000000cff80000 (ACPI NVS)
 BIOS-e820: 00000000cff80000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000330000000 (usable)
12160MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6af0
NX (Execute Disable) protection: active
On node 0 totalpages: 3342336
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 3112960 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6a70
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xcff726a2
ACPI: FADT (v001 INTEL  LINDHRST 0x06040000 PTL  0x00000003) @ 0xcff76e61
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0xcff76ed5
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0xcff76f25
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xcff76f99
ACPI: MCFG (v001 PTLTD  	 MCFG   0x06040000  LTP 0x00000000) @ 0xcff76fc1
ACPI: DSDT (v001  Intel LINDHRST 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
Built 1 zonelists
Kernel command line: root=/dev/sda4 ide=reverse console=ttyS0,57600n8 console=tty0 idebus=66 udev
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
ide_setup: idebus=66
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.119 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 12470940k/13369344k available (2725k kernel code, 110224k reserved, 1415k data, 200k init, 11664832k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5995.45 BogoMIPS (lpj=11990905)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 404 Objects with 54 Devices 136 Methods 12 Regions
ACPI Namespace successfully loaded at root c0588170
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 01
Booting processor 1/6 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5985.56 BogoMIPS (lpj=11971132)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 01
Total of 2 processors activated (11981.01 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=4000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xfd663, last bus=9
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 5 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...................................................
Initialized 12/12 Regions 0/0 Fields 36/36 Buffers 3/15 Packages (413 nodes)
Executing all Device _STA and_INI methods:............................................................
60 Devices found - executed 1 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:08:01.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE1A.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE2A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE2B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE3A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE3B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIX._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *9
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
pnp: PnP ACPI: found 11 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:01:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: d0200000-d02fffff
  PREFETCH window: d1000000-d10fffff
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:01:00.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:01:00.2 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:05.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:08:01.0[A] -> GSI 24 (level, low) -> IRQ 17
radeonfb (0000:08:01.0): Found 0k of DDR 32 bits wide videoram
radeonfb (0000:08:01.0): cannot map FB
ACPI: PCI interrupt for device 0000:08:01.0 disabled
radeonfb: probe of 0000:08:01.0 failed with error -5
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
acpi_processor-0495 [06] processor_get_info    : Error getting cpuindex for acpiid 0x2
acpi_processor-0495 [06] processor_get_info    : Error getting cpuindex for acpiid 0x3
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4
Copyright (c) 1999-2005 Intel Corporation.
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:08:02.0[A] -> GSI 25 (level, low) -> IRQ 18
e1000: 0000:08:02.0: e1000_probe: (PCI:66MHz:32-bit) 00:11:09:b6:c1:7a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 26 (level, low) -> IRQ 19
e1000: 0000:08:03.0: e1000_probe: (PCI:66MHz:32-bit) 00:11:09:b6:c1:7b
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:09:01.0[A] -> GSI 17 (level, low) -> IRQ 20
e1000: 0000:09:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:84:83:71
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
LXT970: Registered new driver
LXT971: Registered new driver
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 21
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD-ROM DDU1615, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM drive, 254kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x14A8 ctl 0x149E bmdma 0x1470 irq 21
ata2: SATA max UDMA/133 cmd 0x14A0 ctl 0x149A bmdma 0x1478 irq 21
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: ST3200826AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200826AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
ieee1394: Initialized config rom entry `ip1394'
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 9, 2097152 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
UDF-fs: No VRS found
XFS mounting filesystem sda4
Ending clean XFS mount for filesystem: sda4
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding 31254448k swap on /dev/sda2.  Priority:-1 extents:1 across:31254448k
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001420
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0001400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
process `named' is using obsolete setsockopt SO_BSDCOMPAT

--------------020006060802030507040308--
