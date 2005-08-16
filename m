Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVHPTUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVHPTUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVHPTUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:20:34 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:2781
	"HELO linuxace.com") by vger.kernel.org with SMTP id S932371AbVHPTUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:20:33 -0400
Date: Tue, 16 Aug 2005 12:20:32 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: e1000 dual-port nic failures
Message-ID: <20050816192032.GA4079@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing some odd behaviour from a dual port Intel e1000
nic.  When I have only one port of the dual port nic
plugged in, all is well.  But when I plug the 2nd port in,
the box goes to pieces.  The counters for the interfaces on the
nic start moving in reverse, and the interfaces start spewing
the logs with these errors:

kernel: NETDEV WATCHDOG: eth2: transmit timed out
kernel: e1000: eth2: e1000_reset: Hardware Error
kernel: e1000: eth2: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex

I'm currently testing with 2.6.13-rc6, but tried with 2.6.10
and had the same problem.  I've got two identical boxes (Dell
Optiplex GX280s) exhibiting the same problem, so really don't
think its a hardware problem.  I upgraded one to the latest
BIOS just for kicks, but it didn't help.

I've tried removing ACPI, SMT, using pci=routeirq, all to no
avail.  Below is dmesg output with PCI debugging enabled. The
problematic nic is eth[23].

Any suggestions?

Phil


Linux version 2.6.13-rc6 (root@) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #7 Tue Aug 16 14:21:31 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f686c00 (usable)
 BIOS-e820: 000000003f686c00 - 000000003f688c00 (ACPI NVS)
 BIOS-e820: 000000003f688c00 - 000000003f68ac00 (ACPI data)
 BIOS-e820: 000000003f68ac00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 259718
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 30342 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fec00
ACPI: RSDT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcbfd
ACPI: FADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcc3d
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd43fc
ACPI: MADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fccb1
ACPI: BOOT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd23
ACPI: ASF! (v016 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd4b
ACPI: MCFG (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdb2
ACPI: HPET (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdf0
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro nofirewire root=/dev/sda9 console=tty0 console=ttyS0,9600 panic=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0336000 soft=c0335000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.117 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1026500k/1038872k available (1591k kernel code, 11500k reserved, 491k data, 152k init, 121368k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5995.10 BogoMIPS (lpj=11990207)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=4
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/2580] 000600 00
PCI: Calling quirk c0199946 for 0000:00:00.0
PCI: Calling quirk c0199dc5 for 0000:00:00.0
PCI: Calling quirk c02339ea for 0000:00:00.0
PCI: Calling quirk c0233ba4 for 0000:00:00.0
PCI: Calling quirk c0233d08 for 0000:00:00.0
PCI: Found 0000:00:01.0 [8086/2581] 000604 01
PCI: Calling quirk c0199946 for 0000:00:01.0
PCI: Calling quirk c0199dc5 for 0000:00:01.0
PCI: Calling quirk c02339ea for 0000:00:01.0
PCI: Calling quirk c0233ba4 for 0000:00:01.0
PCI: Calling quirk c0233d08 for 0000:00:01.0
PCI: Found 0000:00:02.0 [8086/2582] 000300 00
PCI: Calling quirk c0199946 for 0000:00:02.0
PCI: Calling quirk c0199dc5 for 0000:00:02.0
PCI: Calling quirk c02339ea for 0000:00:02.0
PCI: Calling quirk c0233ba4 for 0000:00:02.0
PCI: Calling quirk c0233d08 for 0000:00:02.0
Boot video device is 0000:00:02.0
PCI: Found 0000:00:02.1 [8086/2782] 000380 00
PCI: Calling quirk c0199946 for 0000:00:02.1
PCI: Calling quirk c0199dc5 for 0000:00:02.1
PCI: Calling quirk c02339ea for 0000:00:02.1
PCI: Calling quirk c0233ba4 for 0000:00:02.1
PCI: Calling quirk c0233d08 for 0000:00:02.1
PCI: Found 0000:00:1c.0 [8086/2660] 000604 01
PCI: Calling quirk c0199946 for 0000:00:1c.0
PCI: Calling quirk c0199dc5 for 0000:00:1c.0
PCI: Calling quirk c02339ea for 0000:00:1c.0
PCI: Calling quirk c0233ba4 for 0000:00:1c.0
PCI: Calling quirk c0233d08 for 0000:00:1c.0
PCI: Found 0000:00:1c.1 [8086/2662] 000604 01
PCI: Calling quirk c0199946 for 0000:00:1c.1
PCI: Calling quirk c0199dc5 for 0000:00:1c.1
PCI: Calling quirk c02339ea for 0000:00:1c.1
PCI: Calling quirk c0233ba4 for 0000:00:1c.1
PCI: Calling quirk c0233d08 for 0000:00:1c.1
PCI: Found 0000:00:1d.0 [8086/2658] 000c03 00
PCI: Calling quirk c0199946 for 0000:00:1d.0
PCI: Calling quirk c0199dc5 for 0000:00:1d.0
PCI: Calling quirk c02339ea for 0000:00:1d.0
PCI: Calling quirk c0233ba4 for 0000:00:1d.0
PCI: Calling quirk c0233d08 for 0000:00:1d.0
PCI: Found 0000:00:1d.1 [8086/2659] 000c03 00
PCI: Calling quirk c0199946 for 0000:00:1d.1
PCI: Calling quirk c0199dc5 for 0000:00:1d.1
PCI: Calling quirk c02339ea for 0000:00:1d.1
PCI: Calling quirk c0233ba4 for 0000:00:1d.1
PCI: Calling quirk c0233d08 for 0000:00:1d.1
PCI: Found 0000:00:1d.2 [8086/265a] 000c03 00
PCI: Calling quirk c0199946 for 0000:00:1d.2
PCI: Calling quirk c0199dc5 for 0000:00:1d.2
PCI: Calling quirk c02339ea for 0000:00:1d.2
PCI: Calling quirk c0233ba4 for 0000:00:1d.2
PCI: Calling quirk c0233d08 for 0000:00:1d.2
PCI: Found 0000:00:1d.3 [8086/265b] 000c03 00
PCI: Calling quirk c0199946 for 0000:00:1d.3
PCI: Calling quirk c0199dc5 for 0000:00:1d.3
PCI: Calling quirk c02339ea for 0000:00:1d.3
PCI: Calling quirk c0233ba4 for 0000:00:1d.3
PCI: Calling quirk c0233d08 for 0000:00:1d.3
PCI: Found 0000:00:1d.7 [8086/265c] 000c03 00
PCI: Calling quirk c0199946 for 0000:00:1d.7
PCI: Calling quirk c0199dc5 for 0000:00:1d.7
PCI: Calling quirk c02339ea for 0000:00:1d.7
PCI: Calling quirk c0233ba4 for 0000:00:1d.7
PCI: Calling quirk c0233d08 for 0000:00:1d.7
PCI: Found 0000:00:1e.0 [8086/244e] 000604 01
PCI: Calling quirk c0199946 for 0000:00:1e.0
PCI: Calling quirk c0199dc5 for 0000:00:1e.0
PCI: Calling quirk c02339ea for 0000:00:1e.0
PCI: Calling quirk c0233ba4 for 0000:00:1e.0
PCI: Calling quirk c0233d08 for 0000:00:1e.0
PCI: Found 0000:00:1e.2 [8086/266e] 000401 00
PCI: Calling quirk c0199946 for 0000:00:1e.2
PCI: Calling quirk c0199dc5 for 0000:00:1e.2
PCI: Calling quirk c02339ea for 0000:00:1e.2
PCI: Calling quirk c0233ba4 for 0000:00:1e.2
PCI: Calling quirk c0233d08 for 0000:00:1e.2
PCI: Found 0000:00:1f.0 [8086/2640] 000601 00
PCI: Calling quirk c0199946 for 0000:00:1f.0
PCI: Calling quirk c0199dc5 for 0000:00:1f.0
PCI: Calling quirk c02339ea for 0000:00:1f.0
PCI: Calling quirk c0233ba4 for 0000:00:1f.0
PCI: Calling quirk c0233d08 for 0000:00:1f.0
PCI: Found 0000:00:1f.1 [8086/266f] 000101 00
PCI: Calling quirk c0199946 for 0000:00:1f.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Calling quirk c0199dc5 for 0000:00:1f.1
PCI: Calling quirk c02339ea for 0000:00:1f.1
PCI: Calling quirk c0233ba4 for 0000:00:1f.1
PCI: Calling quirk c0233d08 for 0000:00:1f.1
PCI: Found 0000:00:1f.2 [8086/2651] 000101 00
PCI: Calling quirk c0199946 for 0000:00:1f.2
PCI: Calling quirk c0199dc5 for 0000:00:1f.2
PCI: Calling quirk c02339ea for 0000:00:1f.2
PCI: Calling quirk c0233ba4 for 0000:00:1f.2
PCI: Calling quirk c0233d08 for 0000:00:1f.2
PCI: Found 0000:00:1f.3 [8086/266a] 000c05 00
PCI: Calling quirk c0199946 for 0000:00:1f.3
PCI: Calling quirk c0199dc5 for 0000:00:1f.3
PCI: Calling quirk c02339ea for 0000:00:1f.3
PCI: Calling quirk c0233ba4 for 0000:00:1f.3
PCI: Calling quirk c0233d08 for 0000:00:1f.3
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 030300, pass 0
PCI: Scanning bus 0000:03
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 040400, pass 0
PCI: Scanning bus 0000:04
PCI: Found 0000:04:00.0 [8086/1010] 000200 00
PCI: Calling quirk c0199946 for 0000:04:00.0
PCI: Calling quirk c0199dc5 for 0000:04:00.0
PCI: Calling quirk c02339ea for 0000:04:00.0
PCI: Calling quirk c0233ba4 for 0000:04:00.0
PCI: Calling quirk c0233d08 for 0000:04:00.0
PCI: Found 0000:04:00.1 [8086/1010] 000200 00
PCI: Calling quirk c0199946 for 0000:04:00.1
PCI: Calling quirk c0199dc5 for 0000:04:00.1
PCI: Calling quirk c02339ea for 0000:04:00.1
PCI: Calling quirk c0233ba4 for 0000:04:00.1
PCI: Calling quirk c0233d08 for 0000:04:00.1
PCI: Found 0000:04:01.0 [8086/1079] 000200 00
PCI: Calling quirk c0199946 for 0000:04:01.0
PCI: Calling quirk c0199dc5 for 0000:04:01.0
PCI: Calling quirk c02339ea for 0000:04:01.0
PCI: Calling quirk c0233ba4 for 0000:04:01.0
PCI: Calling quirk c0233d08 for 0000:04:01.0
PCI: Found 0000:04:01.1 [8086/1079] 000200 00
PCI: Calling quirk c0199946 for 0000:04:01.1
PCI: Calling quirk c0199dc5 for 0000:04:01.1
PCI: Calling quirk c02339ea for 0000:04:01.1
PCI: Calling quirk c0233ba4 for 0000:04:01.1
PCI: Calling quirk c0233d08 for 0000:04:01.1
PCI: Found 0000:04:02.0 [8086/1229] 000200 00
PCI: Calling quirk c0199946 for 0000:04:02.0
PCI: Calling quirk c0199dc5 for 0000:04:02.0
PCI: Calling quirk c02339ea for 0000:04:02.0
PCI: Calling quirk c0233ba4 for 0000:04:02.0
PCI: Calling quirk c0233d08 for 0000:04:02.0
PCI: Fixups for bus 0000:04
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus scan for 0000:04 returning with max=04
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 030300, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 040400, pass 1
PCI: Bus scan for 0000:00 returning with max=04
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
SCSI subsystem initialized
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfc00000-dfcfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: dfb00000-dfbfffff
  PREFETCH window: disabled.
  got res [40000000:400fffff] bus [40000000:400fffff] flags 7200 for BAR 6 of 0000:04:02.0
PCI: moved device 0000:04:02.0 resource 6 (7200) to 40000000
  got res [df700000:df73ffff] bus [df700000:df73ffff] flags 204 for BAR 2 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 2 (204) to 0
  got res [40100000:4013ffff] bus [40100000:4013ffff] flags 7200 for BAR 6 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 6 (7200) to 40100000
  got res [df740000:df77ffff] bus [df740000:df77ffff] flags 204 for BAR 2 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 2 (204) to 0
  got res [40140000:4017ffff] bus [40140000:4017ffff] flags 7200 for BAR 6 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 6 (7200) to 40140000
  got res [df780000:df79ffff] bus [df780000:df79ffff] flags 204 for BAR 0 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 0 (204) to 0
  got res [df7a0000:df7bffff] bus [df7a0000:df7bffff] flags 204 for BAR 0 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 0 (204) to 0
  got res [d000:d03f] bus [d000:d03f] flags 101 for BAR 4 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 4 (101) to d000
  got res [d040:d07f] bus [d040:d07f] flags 101 for BAR 4 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 4 (101) to d040
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: df700000-dfafffff
  PREFETCH window: 40000000-401fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x7a set to 0x1
highmem bounce pool size: 64 pages
PCI: Calling quirk c019986f for 0000:00:00.0
PCI: Calling quirk c0199e05 for 0000:00:00.0
PCI: Calling quirk c019986f for 0000:00:01.0
PCI: Calling quirk c0199e05 for 0000:00:01.0
PCI: Calling quirk c019986f for 0000:00:02.0
PCI: Calling quirk c0199e05 for 0000:00:02.0
PCI: Calling quirk c019986f for 0000:00:02.1
PCI: Calling quirk c0199e05 for 0000:00:02.1
PCI: Calling quirk c019986f for 0000:00:1c.0
PCI: Calling quirk c0199e05 for 0000:00:1c.0
PCI: Calling quirk c019986f for 0000:00:1c.1
PCI: Calling quirk c0199e05 for 0000:00:1c.1
PCI: Calling quirk c019986f for 0000:00:1d.0
PCI: Calling quirk c0199e05 for 0000:00:1d.0
PCI: Calling quirk c019986f for 0000:00:1d.1
PCI: Calling quirk c0199e05 for 0000:00:1d.1
PCI: Calling quirk c019986f for 0000:00:1d.2
PCI: Calling quirk c0199e05 for 0000:00:1d.2
PCI: Calling quirk c019986f for 0000:00:1d.3
PCI: Calling quirk c0199e05 for 0000:00:1d.3
PCI: Calling quirk c019986f for 0000:00:1d.7
PCI: Calling quirk c0199e05 for 0000:00:1d.7
PCI: Calling quirk c019986f for 0000:00:1e.0
PCI: Calling quirk c0199e05 for 0000:00:1e.0
PCI: Calling quirk c019986f for 0000:00:1e.2
PCI: Calling quirk c0199e05 for 0000:00:1e.2
PCI: Calling quirk c019986f for 0000:00:1f.0
PCI: Calling quirk c0199e05 for 0000:00:1f.0
PCI: Calling quirk c019986f for 0000:00:1f.1
PCI: Calling quirk c0199e05 for 0000:00:1f.1
PCI: Calling quirk c019986f for 0000:00:1f.2
PCI: Calling quirk c0199e05 for 0000:00:1f.2
PCI: Calling quirk c019986f for 0000:00:1f.3
PCI: Calling quirk c0199e05 for 0000:00:1f.3
PCI: Calling quirk c019986f for 0000:04:00.0
PCI: Calling quirk c0199e05 for 0000:04:00.0
PCI: Calling quirk c019986f for 0000:04:00.1
PCI: Calling quirk c0199e05 for 0000:04:00.1
PCI: Calling quirk c019986f for 0000:04:01.0
PCI: Calling quirk c0199e05 for 0000:04:01.0
PCI: Calling quirk c019986f for 0000:04:01.1
PCI: Calling quirk c0199e05 for 0000:04:01.1
PCI: Calling quirk c019986f for 0000:04:02.0
PCI: Calling quirk c0199e05 for 0000:04:02.0
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: CPU0 (power states: C1[C1])
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
  got res [df800000:df81ffff] bus [df800000:df81ffff] flags 204 for BAR 0 of 0000:04:00.0
PCI: moved device 0000:04:00.0 resource 0 (204) to 0
  got res [d8c0:d8ff] bus [d8c0:d8ff] flags 101 for BAR 4 of 0000:04:00.0
PCI: moved device 0000:04:00.0 resource 4 (101) to d8c0
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
  got res [df820000:df83ffff] bus [df820000:df83ffff] flags 204 for BAR 0 of 0000:04:00.1
PCI: moved device 0000:04:00.1 resource 0 (204) to 0
  got res [dc00:dc3f] bus [dc00:dc3f] flags 101 for BAR 4 of 0000:04:00.1
PCI: moved device 0000:04:00.1 resource 4 (101) to dc00
ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 17 (level, low) -> IRQ 17
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
  got res [df780000:df79ffff] bus [df780000:df79ffff] flags 204 for BAR 0 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 0 (204) to 0
  got res [df700000:df73ffff] bus [df700000:df73ffff] flags 204 for BAR 2 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 2 (204) to 0
  got res [d000:d03f] bus [d000:d03f] flags 101 for BAR 4 of 0000:04:01.0
PCI: moved device 0000:04:01.0 resource 4 (101) to d000
PCI: Enabling device 0000:04:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Enabling bus mastering for device 0000:04:01.0
PCI: Setting latency timer of device 0000:04:01.0 to 64
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
  got res [df7a0000:df7bffff] bus [df7a0000:df7bffff] flags 204 for BAR 0 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 0 (204) to 0
  got res [df740000:df77ffff] bus [df740000:df77ffff] flags 204 for BAR 2 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 2 (204) to 0
  got res [d040:d07f] bus [d040:d07f] flags 101 for BAR 4 of 0000:04:01.1
PCI: moved device 0000:04:01.1 resource 4 (101) to d040
PCI: Enabling device 0000:04:01.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:04:01.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Enabling bus mastering for device 0000:04:01.1
PCI: Setting latency timer of device 0000:04:01.1 to 64
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
  got res [df7ff000:df7fffff] bus [df7ff000:df7fffff] flags 200 for BAR 0 of 0000:04:02.0
PCI: moved device 0000:04:02.0 resource 0 (200) to df7ff000
  got res [dcc0:dcff] bus [dcc0:dcff] flags 101 for BAR 1 of 0000:04:02.0
PCI: moved device 0000:04:02.0 resource 1 (101) to dcc0
  got res [df900000:df9fffff] bus [df900000:df9fffff] flags 200 for BAR 2 of 0000:04:02.0
PCI: moved device 0000:04:02.0 resource 2 (200) to df900000
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 18 (level, low) -> IRQ 18
e100: eth4: e100_probe: addr 0xdf7ff000, irq 18, MAC addr 00:90:27:BB:15:67
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: JLMS DVD-ROM XJ-HD166, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
libata version 1.11 loaded.
ata_piix version 1.03
  got res [fe00:fe07] bus [fe00:fe07] flags 101 for BAR 0 of 0000:00:1f.2
PCI: moved device 0000:00:1f.2 resource 0 (101) to fe00
  got res [fe10:fe13] bus [fe10:fe13] flags 101 for BAR 1 of 0000:00:1f.2
PCI: moved device 0000:00:1f.2 resource 1 (101) to fe10
  got res [fe20:fe27] bus [fe20:fe27] flags 101 for BAR 2 of 0000:00:1f.2
PCI: moved device 0000:00:1f.2 resource 2 (101) to fe20
  got res [fe30:fe33] bus [fe30:fe33] flags 101 for BAR 3 of 0000:00:1f.2
PCI: moved device 0000:00:1f.2 resource 3 (101) to fe30
  got res [fea0:feaf] bus [fea0:feaf] flags 101 for BAR 4 of 0000:00:1f.2
PCI: moved device 0000:00:1f.2 resource 4 (101) to fea0
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 19
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 78125000 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0xFF on port 0xFE27
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: ST340014AS        Rev: 8.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 78125000 512-byte hdwr sectors (40000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 78125000 512-byte hdwr sectors (40000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  got res [ffa80800:ffa80bff] bus [ffa80800:ffa80bff] flags 200 for BAR 0 of 0000:00:1d.7
PCI: moved device 0000:00:1d.7 resource 0 (200) to ffa80800
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffa80800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000ff80
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000ff60
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 22, io base 0x0000ff20
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.1 (8116 buckets, 64928 max) - 208 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 4
Using IPI Shortcut mode
ACPI wakeup devices: 
VBTN PCI0 PCI1 PCI2 PCI3 PCI4 USB0 USB1 USB2 USB3 
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
