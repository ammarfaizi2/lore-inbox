Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWI0NjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWI0NjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWI0NjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:39:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:30943 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932079AbWI0NjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:39:22 -0400
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Bad PTE VM: killing process hald-addon-keyb
Date: Wed, 27 Sep 2006 15:38:58 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271538.58248.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the following dmesg output:

[11926.720530] Bad pte = 4800000010ba1842, process = hald-addon-keyb, vm_flags 
= 100073, vaddr = 2b1ced112ea0
[11926.720535]
[11926.720536] Call Trace:
[11926.720560] [<ffffffff8020890f>] __handle_mm_fault+0x575/0x91b
[11926.720567] [<ffffffff8025d4d4>] thread_return+0x0/0xd1
[11926.720574] [<ffffffff80260fab>] do_page_fault+0x44a/0x7be
[11926.720580] [<ffffffff8024b84e>] finish_wait+0x32/0x5d
[11926.720588] [<ffffffff88268dfb>] :evdev:evdev_read+0x19f/0x247
[11926.720596] [<ffffffff8020fe8f>] sys_read+0x2d/0x6e
[11926.720602] [<ffffffff80259c5d>] error_exit+0x0/0x84
[11926.720612]
[11926.720614] VM: killing process hald-addon-keyb

CPU load went up to 100% in kernel mode with top showing no process causing 
this. This never happened before. I think I can not reproduce it anymore with 
an untainted kernel.


[    0.000000] Bootdata ok (command line is 
root=/dev/mapper/VolGroup00-LogVol00 ro quiet splash)
[    0.000000] Linux version 2.6.18-rc7 (user@ubuntu.localnet) (gcc version 
4.1.2 20060906 (prerelease) (Ubuntu 4.1.1-13ubuntu2)) #2 SMP Wed Sep 13 
11:28:41 CEST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
[    0.000000]  BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
[    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f7d70
[    0.000000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff3040
[    0.000000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff30c0
[    0.000000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x000000007fff9900
[    0.000000] ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 
0x000000007fff9b00
[    0.000000] ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9c00
[    0.000000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9840
[    0.000000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 0-a0000
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] NUMA: Using 63 for the hash shift.
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fff0000
[    0.000000] On node 0 totalpages: 516034
[    0.000000]   DMA zone: 2969 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 513065 pages, LIFO batch:31
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 
80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] Built 1 zonelists.  Total pages: 516034
[    0.000000] Kernel command line: root=/dev/mapper/VolGroup00-LogVol00 ro 
quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Disabling vsyscall due to use of PM timer
[    0.000000] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[    0.000000] time.c: Detected 2664.117 MHz processor.
[   16.608032] Console: colour VGA+ 80x25
[   16.609101] Dentry cache hash table entries: 262144 (order: 9, 2097152 
bytes)
[   16.610478] Inode-cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[   16.610929] Checking aperture...
[   16.610932] CPU 0: aperture @ 4e60000000 size 32 MB
[   16.610934] Aperture too small (32 MB)
[   16.615620] No AGP bridge found
[   16.630442] Memory: 2054452k/2097088k available (1879k kernel code, 42240k 
reserved, 1270k data, 180k init)
[   16.706898] Calibrating delay using timer specific routine.. 5332.16 
BogoMIPS (lpj=10664322)
[   16.706942] Security Framework v1.0.0 initialized
[   16.706946] SELinux:  Disabled at boot.
[   16.706964] Mount-cache hash table entries: 256
[   16.707066] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   16.707068] CPU: L2 Cache: 512K (64 bytes/line)
[   16.707070] CPU 0/0 -> Node 0
[   16.707071] CPU: Physical Processor ID: 0
[   16.707073] CPU: Processor Core ID: 0
[   16.707089] SMP alternatives: switching to UP code
[   16.707186] ACPI: Core revision 20060707
[   16.753510] Using local APIC timer interrupts.
[   16.791012] result 16650755
[   16.791013] Detected 16.650 MHz APIC timer.
[   16.794982] SMP alternatives: switching to SMP code
[   16.795056] Booting processor 1/2 APIC 0x1
[   16.804230] Initializing CPU#1
[   16.881667] Calibrating delay using timer specific routine.. 5328.38 
BogoMIPS (lpj=10656767)
[   16.881673] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   16.881674] CPU: L2 Cache: 512K (64 bytes/line)
[   16.881676] CPU 1/1 -> Node 0
[   16.881678] CPU: Physical Processor ID: 0
[   16.881679] CPU: Processor Core ID: 1
[   16.881741] AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
[   16.885667] CPU 1: Syncing TSC to CPU 0.
[   16.886804] CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 
518 cycles)
[   16.886808] Brought up 2 CPUs
[   16.886836] testing NMI watchdog ... OK.
[   17.602483] migration_cost=159
[   17.602575] checking if image is initramfs... it is
[   17.947465] Freeing initrd memory: 6373k freed
[   17.950396] NET: Registered protocol family 16
[   17.950457] ACPI: bus type pci registered
[   17.953227] PCI: Using MMCONFIG at e0000000
[   17.953245] PCI: No mmconfig possible on device 0:18
[   17.960523] ACPI: Interpreter enabled
[   17.960525] ACPI: Using IOAPIC for interrupt routing
[   17.960987] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   17.960989] PCI: Probing PCI hardware (bus 00)
[   17.964409] PCI: Transparent bridge - 0000:00:09.0
[   17.964578] Boot video device is 0000:01:00.0
[   17.964625] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   18.029964] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   18.031687] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   18.031947] ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   18.032206] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   18.032465] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.032722] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.032981] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   18.033237] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.033498] ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   18.033762] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   18.034027] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.034287] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   18.034549] ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   18.034809] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.035080] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   18.035348] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   18.035619] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   18.035921] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   18.036218] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   18.036513] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   18.036809] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   18.037034] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   18.037344] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, 
disabled.
[   18.037654] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, 
disabled.
[   18.037965] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, 
disabled.
[   18.038269] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, 
disabled.
[   18.038578] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, 
disabled.
[   18.038884] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, 
disabled.
[   18.039191] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, 
disabled.
[   18.039497] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, 
disabled.
[   18.039813] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, 
disabled.
[   18.040131] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, 
disabled.
[   18.040446] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, 
disabled.
[   18.043510] Linux Plug and Play Support v0.97 (c) Adam Belay
[   18.043519] pnp: PnP ACPI init
[   18.048702] pnp: PnP ACPI: found 16 devices
[   18.048759] PCI: Using ACPI for IRQ routing
[   18.048762] PCI: If a device doesn't work, try "pci=routeirq".  If it 
helps, post a report
[   18.048845] PCI-DMA: Disabling IOMMU.
[   18.049203] pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
[   18.049206] pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
[   18.049208] pnp: 00:01: ioport range 0x4400-0x447f has been reserved
[   18.049211] pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
[   18.049213] pnp: 00:01: ioport range 0x4800-0x487f has been reserved
[   18.049215] pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
[   18.049425] PCI: Bridge: 0000:00:09.0
[   18.049427]   IO window: a000-afff
[   18.049429]   MEM window: d3000000-d4ffffff
[   18.049432]   PREFETCH window: 88000000-880fffff
[   18.049434] PCI: Bridge: 0000:00:0b.0
[   18.049435]   IO window: disabled.
[   18.049436]   MEM window: disabled.
[   18.049438]   PREFETCH window: disabled.
[   18.049439] PCI: Bridge: 0000:00:0c.0
[   18.049441]   IO window: disabled.
[   18.049442]   MEM window: disabled.
[   18.049443]   PREFETCH window: disabled.
[   18.049445] PCI: Bridge: 0000:00:0d.0
[   18.049446]   IO window: disabled.
[   18.049448]   MEM window: disabled.
[   18.049449]   PREFETCH window: disabled.
[   18.049452] PCI: Bridge: 0000:00:0e.0
[   18.049453]   IO window: 9000-9fff
[   18.049455]   MEM window: d0000000-d2ffffff
[   18.049457]   PREFETCH window: c0000000-cfffffff
[   18.049462] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   18.049467] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   18.049470] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   18.049474] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   18.049477] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   18.049544] NET: Registered protocol family 2
[   18.093628] IP route cache hash table entries: 65536 (order: 7, 524288 
bytes)
[   18.093971] TCP established hash table entries: 262144 (order: 10, 4194304 
bytes)
[   18.095721] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   18.096158] TCP: Hash tables configured (established 262144 bind 65536)
[   18.096161] TCP reno registered
[   18.096955] audit: initializing netlink socket (disabled)
[   18.096967] audit(1159351880.456:1): initialized
[   18.097134] VFS: Disk quotas dquot_6.5.1
[   18.097152] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   18.097187] Initializing Cryptographic API
[   18.097191] io scheduler noop registered
[   18.097198] io scheduler anticipatory registered
[   18.097204] io scheduler deadline registered
[   18.097220] io scheduler cfq registered (default)
[   18.097635] PCI: Linking AER extended capability on 0000:00:0b.0
[   18.097639] PCI: Linking AER extended capability on 0000:00:0c.0
[   18.097641] PCI: Linking AER extended capability on 0000:00:0d.0
[   18.097644] PCI: Linking AER extended capability on 0000:00:0e.0
[   18.097806] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   18.097808] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   18.097819] assign_interrupt_mode Found MSI capability
[   18.097844] Allocate Port Service[0000:00:0b.0:pcie00]
[   18.097873] Allocate Port Service[0000:00:0b.0:pcie03]
[   18.097901] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   18.097904] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   18.097914] assign_interrupt_mode Found MSI capability
[   18.097924] Allocate Port Service[0000:00:0c.0:pcie00]
[   18.097949] Allocate Port Service[0000:00:0c.0:pcie03]
[   18.097975] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   18.097977] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   18.097987] assign_interrupt_mode Found MSI capability
[   18.097997] Allocate Port Service[0000:00:0d.0:pcie00]
[   18.098021] Allocate Port Service[0000:00:0d.0:pcie03]
[   18.098047] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   18.098050] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   18.098059] assign_interrupt_mode Found MSI capability
[   18.098068] Allocate Port Service[0000:00:0e.0:pcie00]
[   18.098093] Allocate Port Service[0000:00:0e.0:pcie03]
[   18.115957] Real Time Clock Driver v1.12ac
[   18.115989] Linux agpgart interface v0.101 (c) Dave Jones
[   18.115991] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing enabled
[   18.116091] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   18.116519] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   18.117069] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 
blocksize
[   18.117209] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   18.117211] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[   18.117349] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 
irq 1,12
[   18.119369] serio: i8042 AUX port at 0x60,0x64 irq 12
[   18.119585] serio: i8042 KBD port at 0x60,0x64 irq 1
[   18.119652] mice: PS/2 mouse device common for all mice
[   18.119834] TCP bic registered
[   18.119842] NET: Registered protocol family 1
[   18.119846] NET: Registered protocol family 8
[   18.119848] NET: Registered protocol family 20
[   18.119940] ACPI: (supports S0 S1 S3 S4 S5)
[   18.119981] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   18.120006] Freeing unused kernel memory: 180k freed
[   18.145522] input: AT Translated Set 2 keyboard as /class/input/input0
[   19.193414] ACPI: Fan [FAN] (on)
[   19.199873] ACPI: Thermal Zone [THRM] (40 C)
[   19.501518] SCSI subsystem initialized
[   19.505042] libata version 2.00 loaded.
[   19.506129] sata_nv 0000:00:07.0: version 2.0
[   19.506545] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[   19.506549] GSI 16 sharing vector 0xD9 and IRQ 16
[   19.506553] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 
(level, low) -> IRQ 217
[   19.506686] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   19.506756] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 
217
[   19.506781] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 
217
[   19.506791] scsi0 : sata_nv
[   19.819920] ata1: SATA link down (SStatus 0 SControl 300)
[   19.819926] scsi1 : sata_nv
[   20.131621] ata2: SATA link down (SStatus 0 SControl 300)
[   20.132028] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[   20.132032] GSI 17 sharing vector 0xE1 and IRQ 17
[   20.132035] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 
(level, low) -> IRQ 225
[   20.132146] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   20.132194] ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 
225
[   20.132216] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 
225
[   20.132226] scsi2 : sata_nv
[   20.603187] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   20.608118] ata3.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[   20.608122] ata3.00: ata3: dev 0 multi count 16
[   20.613082] ata3.00: configured for UDMA/133
[   20.613083] scsi3 : sata_nv
[   21.082728] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   21.085727] ata4.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[   21.085730] ata4.00: ata4: dev 0 multi count 16
[   21.106920] ata4.00: configured for UDMA/133
[   21.114687]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   21.114694]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   21.122688]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   21.122694]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   21.129145] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   21.129155] sda: Write Protect is off
[   21.129157] sda: Mode Sense: 00 3a 00 00
[   21.129167] SCSI device sda: drive cache: write back
[   21.129207] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   21.129213] sda: Write Protect is off
[   21.129215] sda: Mode Sense: 00 3a 00 00
[   21.129225] SCSI device sda: drive cache: write back
[   21.129227]  sda: sda1 sda2 sda3
[   21.134570]  sda: p3 exceeds device capacity
[   21.134614] sd 2:0:0:0: Attached scsi disk sda
[   21.135933] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   21.135950] sdb: Write Protect is off
[   21.135951] sdb: Mode Sense: 00 3a 00 00
[   21.135963] SCSI device sdb: drive cache: write back
[   21.136005] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   21.136011] sdb: Write Protect is off
[   21.136012] sdb: Mode Sense: 00 3a 00 00
[   21.136022] SCSI device sdb: drive cache: write back
[   21.136024]  sdb: unknown partition table
[   21.138964] sd 3:0:0:0: Attached scsi disk sdb
[   21.230699] Buffer I/O error on device sda3, logical block 669380224
[   21.230728] Buffer I/O error on device sda3, logical block 669380225
[   21.230753] Buffer I/O error on device sda3, logical block 669380226
[   21.230779] Buffer I/O error on device sda3, logical block 669380227
[   21.230804] Buffer I/O error on device sda3, logical block 669380228
[   21.230829] Buffer I/O error on device sda3, logical block 669380229
[   21.230854] Buffer I/O error on device sda3, logical block 669380230
[   21.230879] Buffer I/O error on device sda3, logical block 669380231
[   21.230915] Buffer I/O error on device sda3, logical block 669380224
[   21.230943] Buffer I/O error on device sda3, logical block 669380225
[   21.367604] NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
[   21.367618] NFORCE-CK804: chipset revision 242
[   21.367620] NFORCE-CK804: not 100% native mode: will probe irqs later
[   21.367624] NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
[   21.367630]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:DMA
[   21.367636]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, 
hdd:DMA
[   21.367642] Probing IDE interface ide0...
[   21.937896] Probing IDE interface ide1...
[   22.677359] hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
[   23.460611] hdd: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
[   23.523606] ide1 at 0x170-0x177,0x376 on irq 15
[   23.532939] hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
[   23.532945] Uniform CD-ROM driver Revision: 3.20
[   23.541844] hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, 
UDMA(33)
[   23.619407] Probing IDE interface ide0...
[   23.656487] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 
0.56.
[   23.657061] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
[   23.657065] GSI 18 sharing vector 0xE9 and IRQ 18
[   23.657069] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 
(level, low) -> IRQ 233
[   23.657074] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   23.657080] forcedeth: using HIGHDMA
[   23.660878] usbcore: registered new driver usbfs
[   23.660896] usbcore: registered new driver hub
[   23.662502] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[   23.666708] ieee1394: Initialized config rom entry `ip1394'
[   24.180052] eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
[   24.180401] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
[   24.180406] GSI 19 sharing vector 0x32 and IRQ 19
[   24.180410] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 
(level, low) -> IRQ 50
[   24.180510] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   24.180515] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   24.180627] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 1
[   24.180657] ehci_hcd 0000:00:02.1: debug port 1
[   24.180660] PCI: cache line size of 64 is not supported by device 
0000:00:02.1
[   24.180668] ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
[   24.180673] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[   24.180743] usb usb1: configuration #1 chosen from 1 choice
[   24.180760] hub 1-0:1.0: USB hub found
[   24.180766] hub 1-0:1.0: 10 ports detected
[   24.288065] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[   24.288068] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 
(level, low) -> IRQ 217
[   24.288167] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   24.288172] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   24.288214] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 2
[   24.288227] ohci_hcd 0000:00:02.0: irq 217, io mem 0xd5004000
[   24.349667] usb usb2: configuration #1 chosen from 1 choice
[   24.349686] hub 2-0:1.0: USB hub found
[   24.349695] hub 2-0:1.0: 10 ports detected
[   24.455867] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   24.455871] GSI 20 sharing vector 0x3A and IRQ 20
[   24.455874] ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 
(level, low) -> IRQ 58
[   24.506043] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58]  
MMIO=[d4008000-d40087ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   24.527431] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   24.567330] device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
[   24.667892] usb 1-1: configuration #1 chosen from 1 choice
[   24.832206] SGI XFS with ACLs, security attributes, realtime, large 
block/inode numbers, no debug enabled
[   24.832379] SGI XFS Quota Management subsystem
[   24.835689] Filesystem "dm-4": Disabling barriers, not supported by the 
underlying device
[   24.850410] XFS mounting filesystem dm-4
[   24.911048] usb 1-2: new high speed USB device using ehci_hcd and address 3
[   24.911288] Ending clean XFS mount for filesystem: dm-4
[   25.052631] usb 1-2: configuration #1 chosen from 1 choice
[   25.778351] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000077be63]
[   33.974467] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   34.067575] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   34.098546] input: PC Speaker as /class/input/input1
[   34.126503] Floppy drive(s): fd0 is 1.44M
[   34.142045] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   34.142071] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   34.151858] FDC 0 is a post-1991 82077
[   34.162155] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   34.162160] GSI 21 sharing vector 0x42 and IRQ 21
[   34.162164] ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 
(level, low) -> IRQ 66
[   34.162306] skge 1.6 addr 0xd4000000 irq 66 chip Yukon-Lite rev 9
[   34.162401] skge eth1: addr 00:15:f2:3f:26:5c
[   34.247435] parport: PnPBIOS parport detected.
[   34.247852] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   34.481921] printk: 78 messages suppressed.
[   34.481925] Buffer I/O error on device sda3, logical block 669380224
[   34.481953] Buffer I/O error on device sda3, logical block 669380225
[   34.923125] skge eth1: enabling interface
[   35.036871] nvidia: module license 'NVIDIA' taints kernel.
[   35.041856] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   35.041860] GSI 22 sharing vector 0x4A and IRQ 22
[   35.041865] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 
(level, low) -> IRQ 74
[   35.041873] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   35.042033] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8774  Tue 
Aug  1 21:42:17 PDT 2006
[   35.293203] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   35.293222] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   35.320034] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
[   35.411358] ts: Compaq touchscreen protocol output
[   35.433524] NET: Registered protocol family 17
[   35.543889] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
[   35.543893] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 
(level, low) -> IRQ 225
[   35.544003] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   35.868578] intel8x0_measure_ac97_clock: measured 58698 usecs
[   35.868581] intel8x0: clocking to 46959
[   36.384108] it87: Found IT8712F chip at 0x290, revision 7
[   36.430758] Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 
extents:1 across:2031608k
[   36.512824] Filesystem "dm-4": Disabling barriers, not supported by the 
underlying device
[   36.704895] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   36.704899] md: bitmap version 4.39
[   37.474212] Filesystem "dm-6": Disabling barriers, not supported by the 
underlying device
[   37.491397] XFS mounting filesystem dm-6
[   37.589747] Ending clean XFS mount for filesystem: dm-6
[   37.673228] kjournald starting.  Commit interval 5 seconds
[   37.673404] EXT3 FS on dm-2, internal journal
[   37.673409] EXT3-fs: mounted filesystem with ordered data mode.
[   37.701409] NTFS driver 2.1.27 [Flags: R/O MODULE].
[   37.791047] NTFS volume version 3.1.
[   38.906851] i2c_adapter i2c-2: SMBus Quick command not supported, can't 
probe for chips
[   38.907611] i2c_adapter i2c-3: SMBus Quick command not supported, can't 
probe for chips
[   38.908379] i2c_adapter i2c-4: SMBus Quick command not supported, can't 
probe for chips
[   44.578512] ACPI: Power Button (FF) [PWRF]
[   44.578520] ACPI: Power Button (CM) [PWRB]
[   44.652634] Using specific hotkey driver
[   44.729876] ibm_acpi: ec object not found
[   44.781350] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   45.454365] NET: Registered protocol family 10
[   45.454452] lo: Disabled Privacy Extensions
[   45.454777] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   45.454798] IPv6 over IPv4 tunneling driver
[   47.581378] printk: 54 messages suppressed.
[   47.581383] Buffer I/O error on device sda3, logical block 669380224
[   47.581412] Buffer I/O error on device sda3, logical block 669380225
[   47.581438] Buffer I/O error on device sda3, logical block 669380226
[   47.964910] Capability LSM initialized
[   55.973334] eth0: no IPv6 routers present
[   66.756385] Bluetooth: Core ver 2.10
[   66.756433] NET: Registered protocol family 31
[   66.756435] Bluetooth: HCI device and connection manager initialized
[   66.756438] Bluetooth: HCI socket layer initialized
[11926.720530] Bad pte = 4800000010ba1842, process = hald-addon-keyb, vm_flags 
= 100073, vaddr = 2b1ced112ea0
[11926.720535] 
[11926.720536] Call Trace:
[11926.720560]  [<ffffffff8020890f>] __handle_mm_fault+0x575/0x91b
[11926.720567]  [<ffffffff8025d4d4>] thread_return+0x0/0xd1
[11926.720574]  [<ffffffff80260fab>] do_page_fault+0x44a/0x7be
[11926.720580]  [<ffffffff8024b84e>] finish_wait+0x32/0x5d
[11926.720588]  [<ffffffff88268dfb>] :evdev:evdev_read+0x19f/0x247
[11926.720596]  [<ffffffff8020fe8f>] sys_read+0x2d/0x6e
[11926.720602]  [<ffffffff80259c5d>] error_exit+0x0/0x84
[11926.720612] 
[11926.720614] VM: killing process hald-addon-keyb


-Christian
