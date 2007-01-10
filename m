Return-Path: <linux-kernel-owner+w=401wt.eu-S964845AbXAJKbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbXAJKbL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 05:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbXAJKbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 05:31:10 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:2426 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964840AbXAJKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 05:31:07 -0500
Date: Wed, 10 Jan 2007 11:30:51 +0100
From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
Message-ID: <20070110103049.GB2558@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
	"Lu, Yinghai" <yinghai.lu@amd.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5986589C150B2F49A46483AC44C7BCA4907376@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907376@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lu, Yinghai wrote:
> -----Original Message-----
> From: Tobias Diedrich [mailto:ranma+kernel@tdiedrich.de] 
> Sent: Tuesday, January 09, 2007 2:01 PM
> To: Eric W. Biederman
> Cc: Linus Torvalds; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi Kleen;
> Linux Kernel Mailing List
> Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
> check_timer fails.
> 
> 
> >Works fine with BIOS 0402.
> 
> >x86_64_io_apic_fix_eric_20060108
> 
> >..TIMER: vector=0x20 apic1=0 pin1=0 apic2=-1 pin2=-1
> >..TIMER trying IO-APIC=0 PIN=0<3> .. failed
> >...apic 0 pin  2n use by irq 2
> >..MP-BIOS bug: 8254 timer not connected to IO-APIC
> >...trying to set up timer (IRQ0) through the 8259A ...
> >...ExtINT trying IO-APIC=0 PIN=0 .. success
> >Using local APIC timer interrupts.
> 
> Tobias,
> 
> Can you post whole log for my patch?

Sure:


dmesg-20070108-2.6.20-rc4-bios-0402:
Linux version 2.6.20-rc4-amd64 (ranma@melchior) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #55 Mon Jan 8 01:41:56 CET 2007
Command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose netconsole=@192.168.8.241/,514@255.255.255.255/ ro
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7ce0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003feec2c0
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec400
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec200
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   261856
On node 0 totalpages: 261759
  DMA zone: 56 pages used for memmap
  DMA zone: 1358 pages reserved
  DMA zone: 2585 pages, LIFO batch:0
  DMA32 zone: 3524 pages used for memmap
  DMA32 zone: 254236 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
mapped APIC to ffffffffff5fd000 (        fee00000)
mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 40000000 (gap: 3ff00000:b0100000)
Built 1 zonelists.  Total pages: 256821
Kernel command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose netconsole=@192.168.8.241/,514@255.255.255.255/ ro
netconsole: local port 6665
netconsole: local IP 192.168.8.241
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 255.255.255.255
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
trying to force-enable HPET
HPET force-enabled at 0xfef00000
time.c: Using 25.000000 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2009.512 MHz processor.
Console: colour VGA+ 80x60
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ b2c2000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1025348k/1047424k available (3242k kernel code, 21444k reserved, 1470k data, 200k init)
Calibrating delay using timer specific routine.. 4023.44 BogoMIPS (lpj=6703119)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
ACPI: Core revision 20060707
ACPI (tbget-0289): Table [DSDT] replaced by host OS [20060707]
enabled ExtINT on CPU#0
ESR value after enabling vector: 00000000, after 00000004
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x20 apic1=0 pin1=0 apic2=-1 pin2=-1
..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled<3> .. failed
..TIMER: trying IO-APIC=0 PIN=2 fallback with 8259 IRQ0 disabled<6>Using local APIC timer interrupts.
result 12559465
Detected 12.559 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Firmware left 0000:01:07.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:06.0
Boot video device is 0000:07:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LMC1] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSA2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
IOAPIC[0]: Set PCI routing entry (2-8 -> 0x28 -> IRQ 8 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (2-13 -> 0x2d -> IRQ 13 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (2-4 -> 0x24 -> IRQ 4 Mode:0 Active:0)
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    21
 02 001 01  0    0    0   0   0    1    1    20
 03 001 01  0    0    0   0   0    1    1    23
 04 001 01  1    0    0   0   0    1    1    24
 05 001 01  1    0    0   0   0    1    1    25
 06 001 01  0    0    0   0   0    1    1    26
 07 001 01  1    0    0   0   0    1    1    27
 08 001 01  1    0    0   0   0    1    1    28
 09 001 01  0    1    0   0   0    1    1    29
 0a 001 01  1    0    0   0   0    1    1    2A
 0b 001 01  1    0    0   0   0    1    1    2B
 0c 001 01  0    0    0   0   0    1    1    2C
 0d 001 01  1    0    0   0   0    1    1    2D
 0e 001 01  0    0    0   0   0    1    1    2E
 0f 001 01  0    0    0   0   0    1    1    2F
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
hpet0: at MMIO 0xfef00000, IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: fdc00000-fdefffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: b000-cfff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0f.0
  IO window: a000-afff
  MEM window: fda00000-fdafffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:0a.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Setting latency timer of device 0000:00:0f.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
fuse init (API version 7.8)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:0a.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0a.0:pcie00]
Allocate Port Service[0000:00:0a.0:pcie03]
PCI: Setting latency timer of device 0000:00:0b.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
PCI: Setting latency timer of device 0000:00:0f.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0f.0:pcie00]
Allocate Port Service[0000:00:0f.0:pcie03]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (28 C)
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
Linux agpgart interface v0.101 (c) Dave Jones
loop: loaded (max 8 devices)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: eth0 doesn't exist, aborting.
ahci 0000:06:00.0: version 2.0
ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0x69 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [APC7] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:06:00.0 to 64
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000064100 ctl 0x0 bmdma 0x0 irq 16
ata2: SATA max UDMA/133 cmd 0xFFFFC20000064180 ctl 0x0 bmdma 0x0 irq 16
scsi0 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda4 < sda5 sda6 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
pata_amd 0000:00:04.0: version 0.2.7
PCI: Setting latency timer of device 0000:00:04.0 to 64
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi2 : pata_amd
ata3.00: ATAPI, max UDMA/33
ata3.01: ATAPI, max UDMA/66
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/66
scsi3 : pata_amd
ata4: port disabled. ignoring.
ata4: reset failed, giving up
scsi 2:0:0:0: CD-ROM            _NEC     DVD_RW ND-3500AG 2.1A PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
sr 2:0:0:0: Attached scsi generic sg1 type 5
scsi 2:0:1:0: CD-ROM            PIONEER  DVD-ROM DVD-106  1.22 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
sr 2:0:1:0: Attached scsi CD-ROM sr1
sr 2:0:1:0: Attached scsi generic sg2 type 5
block2mtd: version $Revision: 1.30 $
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0x71 -> IRQ 23 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 23, io mem 0xfe02e000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0x79 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 22, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb usb2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
it87: Found IT8716F chip at 0x290, revision 0
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
md: raid1 personality registered for level 1
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
GACT probability on
Mirror/redirect action on
u32 classifier
    Performance counters on
    input device check on 
    Actions configured 
nf_conntrack version 0.5.0 (4091 buckets, 32728 max)
IPv4 over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
TCP cubic registered
TCP westwood registered
TCP htcp registered
TCP vegas registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
usb 1-2: new high speed USB device using ehci_hcd and address 2
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 2-3: new full speed USB device using ohci_hcd and address 2
usb 2-3: configuration #1 chosen from 1 choice
usb 2-4: new full speed USB device using ohci_hcd and address 3
usb 2-4: configuration #1 chosen from 1 choice
usb 1-2.3: new low speed USB device using ehci_hcd and address 5
usb 1-2.3: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-2.3
usb 1-2.4: new low speed USB device using ehci_hcd and address 6
usb 1-2.4: configuration #1 chosen from 1 choice
input: HID 046a:0001 as /class/input/input3
input: USB HID v1.00 Keyboard [HID 046a:0001] on usb-0000:00:02.1-2.4
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0x81 -> IRQ 21 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
forcedeth: using HIGHDMA
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 2-4:1.0: pl2303 converter detected
usb 2-4: pl2303 converter now attached to ttyUSB0
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
eth0: forcedeth.c: subsystem: 01043:8239 bound to 0000:00:08.0
ACPI: PCI Interrupt Link [AMC1] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0x89 -> IRQ 20 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [AMC1] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:09.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:8239 bound to 0000:00:09.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0x91 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
e100: eth2: e100_probe: addr 0xfdeff000, irq 17, MAC addr 00:02:B3:1C:8B:4F
gameport: EMU10K1 is pci0000:01:08.1/gameport0, io 0xd400, speed 1203kHz
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0x99 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
ALSA sound/pci/emu10k1/emu10k1_main.c:1176: vendor=0x1102, device=0x2, subsystem_vendor_id=0x80641102, subsystem_id=0x8064
ALSA sound/pci/emu10k1/emu10k1_main.c:1201: Sound card name=SB Live 5.1
Adding 1951856k swap on /dev/sda6.  Priority:-1 extents:1 across:1951856k
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
ReiserFS: dm-4: using ordered data mode
ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-4: checking transaction log (dm-4)
ReiserFS: dm-4: Using r5 hash to sort names
eth0: no IPv6 routers present
lp: driver loaded but no devices found
ppdev: user-space parallel port driver





dmesg-20070108-2.6.20-rc4-bios-0609:
Linux version 2.6.20-rc4-amd64 (ranma@melchior) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #55 Mon Jan 8 01:41:56 CET 2007
Command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose netconsole=@192.168.8.241/,514@255.255.255.255/ ro
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP (v002 Nvidia                                ) @ 0x00000000000f7b70
ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec5c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003feec7c0
ACPI: HPET (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000098) @ 0x000000003feec900
ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec980
ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec700
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x03000000) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   261856
On node 0 totalpages: 261759
  DMA zone: 56 pages used for memmap
  DMA zone: 1358 pages reserved
  DMA zone: 2585 pages, LIFO batch:0
  DMA32 zone: 3524 pages used for memmap
  DMA32 zone: 254236 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10de8201 base: 0xfefff000
Using ACPI (MADT) for SMP configuration information
mapped APIC to ffffffffff5fd000 (        fee00000)
mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 40000000 (gap: 3ff00000:b0100000)
Built 1 zonelists.  Total pages: 256821
Kernel command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose netconsole=@192.168.8.241/,514@255.255.255.255/ ro
netconsole: local port 6665
netconsole: local IP 192.168.8.241
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 255.255.255.255
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 25.000000 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2009.511 MHz processor.
Console: colour VGA+ 80x60
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ b2c2000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1025348k/1047424k available (3242k kernel code, 21444k reserved, 1470k data, 200k init)
Calibrating delay using timer specific routine.. 4023.45 BogoMIPS (lpj=6703124)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
ACPI: Core revision 20060707
ACPI (tbget-0289): Table [DSDT] replaced by host OS [20060707]
enabled ExtINT on CPU#0
ESR value after enabling vector: 00000000, after 00000004
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
..TIMER: trying IO-APIC=0 PIN=2 with 8259 IRQ0 disabled<6>Using local APIC timer interrupts.
result 12559463
Detected 12.559 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Firmware left 0000:01:07.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:06.0
Boot video device is 0000:07:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LMC1] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSA2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
IOAPIC[0]: Set PCI routing entry (2-8 -> 0x28 -> IRQ 8 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (2-13 -> 0x2d -> IRQ 13 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (2-4 -> 0x24 -> IRQ 4 Mode:0 Active:0)
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    21
 02 001 01  0    0    0   0   0    1    1    20
 03 001 01  0    0    0   0   0    1    1    23
 04 001 01  1    0    0   0   0    1    1    24
 05 001 01  1    0    0   0   0    1    1    25
 06 001 01  0    0    0   0   0    1    1    26
 07 001 01  1    0    0   0   0    1    1    27
 08 001 01  1    0    0   0   0    1    1    28
 09 001 01  0    1    0   0   0    1    1    29
 0a 001 01  1    0    0   0   0    1    1    2A
 0b 001 01  1    0    0   0   0    1    1    2B
 0c 001 01  0    0    0   0   0    1    1    2C
 0d 001 01  1    0    0   0   0    1    1    2D
 0e 001 01  0    0    0   0   0    1    1    2E
 0f 001 01  0    0    0   0   0    1    1    2F
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
hpet0: at MMIO 0xfefff000, IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: fdc00000-fdefffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: b000-cfff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0f.0
  IO window: a000-afff
  MEM window: fda00000-fdafffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:0a.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Setting latency timer of device 0000:00:0f.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
fuse init (API version 7.8)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:0a.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0a.0:pcie00]
Allocate Port Service[0000:00:0a.0:pcie03]
PCI: Setting latency timer of device 0000:00:0b.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
PCI: Setting latency timer of device 0000:00:0f.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0f.0:pcie00]
Allocate Port Service[0000:00:0f.0:pcie03]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (24 C)
Real Time Clock Driver v1.12ac
hpet_resources: 0xfefff000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
loop: loaded (max 8 devices)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: eth0 doesn't exist, aborting.
ahci 0000:06:00.0: version 2.0
ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0x69 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [APC7] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:06:00.0 to 64
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000060100 ctl 0x0 bmdma 0x0 irq 16
ata2: SATA max UDMA/133 cmd 0xFFFFC20000060180 ctl 0x0 bmdma 0x0 irq 16
scsi0 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda4 < sda5 sda6 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
pata_amd 0000:00:04.0: version 0.2.7
PCI: Setting latency timer of device 0000:00:04.0 to 64
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi2 : pata_amd
ata3.00: ATAPI, max UDMA/33
ata3.01: ATAPI, max UDMA/66
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/66
scsi3 : pata_amd
ata4: port disabled. ignoring.
ata4: reset failed, giving up
scsi 2:0:0:0: CD-ROM            _NEC     DVD_RW ND-3500AG 2.1A PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
sr 2:0:0:0: Attached scsi generic sg1 type 5
scsi 2:0:1:0: CD-ROM            PIONEER  DVD-ROM DVD-106  1.22 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
sr 2:0:1:0: Attached scsi CD-ROM sr1
sr 2:0:1:0: Attached scsi generic sg2 type 5
block2mtd: version $Revision: 1.30 $
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0x71 -> IRQ 23 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 23, io mem 0xfe02e000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0x79 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 22, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb usb2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
it87: Found IT8716F chip at 0x290, revision 0
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
md: raid1 personality registered for level 1
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
GACT probability on
Mirror/redirect action on
u32 classifier
    Performance counters on
    input device check on 
    Actions configured 
nf_conntrack version 0.5.0 (4091 buckets, 32728 max)
IPv4 over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
TCP cubic registered
TCP westwood registered
TCP htcp registered
TCP vegas registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
usb 1-2: new high speed USB device using ehci_hcd and address 2
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 2-3: new full speed USB device using ohci_hcd and address 2
usb 2-3: configuration #1 chosen from 1 choice
usb 2-4: new full speed USB device using ohci_hcd and address 3
usb 2-4: configuration #1 chosen from 1 choice
usb 2-5: new full speed USB device using ohci_hcd and address 4
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0x81 -> IRQ 21 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
forcedeth: using HIGHDMA
usb 2-5: configuration #1 chosen from 1 choice
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
usb 1-2.3: new low speed USB device using ehci_hcd and address 6
usb 1-2.3: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-2.3
usb 1-2.4: new low speed USB device using ehci_hcd and address 7
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
scsi4 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usb 1-2.4: configuration #1 chosen from 1 choice
input: HID 046a:0001 as /class/input/input3
input: USB HID v1.00 Keyboard [HID 046a:0001] on usb-0000:00:02.1-2.4
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 2-4:1.0: pl2303 converter detected
usb 2-4: pl2303 converter now attached to ttyUSB0
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
eth0: forcedeth.c: subsystem: 01043:8239 bound to 0000:00:08.0
ACPI: PCI Interrupt Link [AMC1] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0x89 -> IRQ 20 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [AMC1] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:09.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:8239 bound to 0000:00:09.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0x91 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
e100: eth2: e100_probe: addr 0xfdeff000, irq 17, MAC addr 00:02:B3:1C:8B:4F
gameport: EMU10K1 is pci0000:01:08.1/gameport0, io 0xd400, speed 1195kHz
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0x99 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
ALSA sound/pci/emu10k1/emu10k1_main.c:1176: vendor=0x1102, device=0x2, subsystem_vendor_id=0x80641102, subsystem_id=0x8064
ALSA sound/pci/emu10k1/emu10k1_main.c:1201: Sound card name=SB Live 5.1
Adding 1951856k swap on /dev/sda6.  Priority:-1 extents:1 across:1951856k
EXT3 FS on sda5, internal journal
scsi 4:0:0:0: Direct-Access     USB      Flash Disk       7.78 PQ: 0 ANSI: 2
SCSI device sdb: 128000 512-byte hdwr sectors (66 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 128000 512-byte hdwr sectors (66 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1
sd 4:0:0:0: Attached scsi removable disk sdb
sd 4:0:0:0: Attached scsi generic sg3 type 0
usb-storage: device scan complete
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
ReiserFS: dm-4: using ordered data mode
ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-4: checking transaction log (dm-4)
ReiserFS: dm-4: Using r5 hash to sort names
eth0: no IPv6 routers present
lp: driver loaded but no devices found
ppdev: user-space parallel port driver

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
このメールは十割再利用されたビットで作られています。
