Return-Path: <linux-kernel-owner+w=401wt.eu-S937627AbWLKVs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937627AbWLKVs7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937672AbWLKVs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:48:59 -0500
Received: from smtp3.wanadoo.co.uk ([193.252.22.156]:23702 "EHLO
	smtp3.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937627AbWLKVs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:48:57 -0500
X-ME-UUID: 20061211214854242.3B396B000094@mwinf3213.me.freeserve.com
Message-ID: <457DD232.2010409@Aspex-Semi.com>
Date: Mon, 11 Dec 2006 21:48:34 +0000
From: Steve Murphy <Steve.Murphy@Aspex-Semi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI resource allocation problem
Content-Type: multipart/mixed;
 boundary="------------060600010908030003050003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060600010908030003050003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
I've got a card that presents a PCIe to PCI transparent
bridge to the slot connector - behind which is a non
transparent bridge with 3 bars - 1 non prefetchable,
2 prefetchable. The non prefetchable is not assigned
after boot on some machines. It seems that if resource
allocation fails on linux it fails on XP too. I presume the
OS has failed to correct a bios device enumeration error.
Running identical install on some machines is fine ( some HP
and Dells) but I have some ASUS and Intel board machines
that show this fault.

I've tried loading the kernel with pci=assign-busses (BTW
how can verify the params a running kernel is using?) but
no result.  The prefetchable bar in question is only 64K -
I never see a problem assigning the PF bars (256M and 64M).

from syslog

Dec 11 18:45:28 brambling kernel: [   42.691399] PCI: Failed to allocate 
mem resource #8:100000@28300000 for 0000:01:00.0
Dec 11 18:45:28 brambling kernel: [   42.691498] PCI: Failed to allocate 
mem resource #0:10000@0 for 0000:02:0c.0
Dec 11 18:45:28 brambling kernel: [   42.691561] PCI: Bridge: 0000:01:00.0
Dec 11 18:45:28 brambling kernel: [   42.691617]   IO window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.691679]   MEM window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.691739]   PREFETCH window: 
30000000-47ffffff


from lspci -v

0000:01:00.0 PCI bridge: PLX Technology, Inc.: Unknown device 8114 (rev 
ba) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at 28200000 (32-bit, non-prefetchable) [size=8K]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        Prefetchable memory behind bridge: 0000000030000000-0000000047f00000
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
        Capabilities: [58] PCI-X bridge device.
        Capabilities: [68] #10 [0071]

0000:02:0c.0 Bridge: Intel Corporation: Unknown device 5378 (rev 02)
        Subsystem: Aspex Semiconductor Ltd: Unknown device 3416
        Flags: 66MHz, medium devsel
        Memory at <unassigned> (64-bit, non-prefetchable) [disabled]
        Memory at 30000000 (64-bit, prefetchable) [disabled] [size=256M]
        Memory at 40000000 (64-bit, prefetchable) [disabled] [size=64M]
        Expansion ROM at 44000000 [disabled] [size=32M]
        Capabilities: [c8] Slot ID: 0 slots, First-, chassis 00
        Capabilities: [cc] Power Management version 2
        Capabilities: [d4] #06 [0000]
        Capabilities: [e0] Message Signalled Interrupts: 64bit+ 
Queue=0/2 Enable-
        Capabilities: [f0] PCI-X non-bridge device.


I'd be very grateful for any help. 
Steve


--------------060600010908030003050003
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Dec 11 18:45:28 brambling syslogd 1.4.1#17ubuntu7: restart.
Dec 11 18:45:28 brambling kernel: Inspecting /boot/System.map-2.6.19
Dec 11 18:45:28 brambling kernel: Loaded 23693 symbols from /boot/System.map-2.6.19.
Dec 11 18:45:28 brambling kernel: Symbols match kernel version 2.6.19.
Dec 11 18:45:28 brambling kernel: No module symbols loaded - kernel modules not enabled. 
Dec 11 18:45:28 brambling kernel: [    0.000000] Linux version 2.6.19 (radspm@brambling) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Sat Dec 9 01:41:11 GMT 2006
Dec 11 18:45:28 brambling kernel: [    0.000000] BIOS-provided physical RAM map:
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000000009fc00 - 0000000000100000 (reserved)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 000000001e9b5000 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001e9b5000 - 000000001ea9e000 (ACPI NVS)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001ea9e000 - 000000001fe0e000 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001fe0e000 - 000000001fe5f000 (reserved)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001fe5f000 - 000000001fe82000 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001fe82000 - 000000001fedf000 (ACPI NVS)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001fedf000 - 000000001fef2000 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001fef2000 - 000000001feff000 (ACPI data)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 000000001feff000 - 000000001ff00000 (usable)
Dec 11 18:45:28 brambling kernel: [    0.000000]  BIOS-e820: 00000000fffc0000 - 00000000fffd0000 (reserved)
Dec 11 18:45:28 brambling kernel: [    0.000000] 0MB HIGHMEM available.
Dec 11 18:45:28 brambling kernel: [    0.000000] 511MB LOWMEM available.
Dec 11 18:45:28 brambling kernel: [    0.000000] found SMP MP-table at 000fd980
Dec 11 18:45:28 brambling kernel: [    0.000000] NX (Execute Disable) protection: active
Dec 11 18:45:28 brambling kernel: [    0.000000] Entering add_active_range(0, 0, 130816) 0 entries of 256 used
Dec 11 18:45:28 brambling kernel: [    0.000000] Zone PFN ranges:
Dec 11 18:45:28 brambling kernel: [    0.000000]   DMA             0 ->     4096
Dec 11 18:45:28 brambling kernel: [    0.000000]   Normal       4096 ->   130816
Dec 11 18:45:28 brambling kernel: [    0.000000]   HighMem    130816 ->   130816
Dec 11 18:45:28 brambling kernel: [    0.000000] early_node_map[1] active PFN ranges
Dec 11 18:45:28 brambling kernel: [    0.000000]     0:        0 ->   130816
Dec 11 18:45:28 brambling kernel: [    0.000000] On node 0 totalpages: 130816
Dec 11 18:45:28 brambling kernel: [    0.000000]   DMA zone: 32 pages used for memmap
Dec 11 18:45:28 brambling kernel: [    0.000000]   DMA zone: 0 pages reserved
Dec 11 18:45:28 brambling kernel: [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
Dec 11 18:45:28 brambling kernel: [    0.000000]   Normal zone: 990 pages used for memmap
Dec 11 18:45:28 brambling kernel: [    0.000000]   Normal zone: 125730 pages, LIFO batch:31
Dec 11 18:45:28 brambling kernel: [    0.000000]   HighMem zone: 0 pages used for memmap
Dec 11 18:45:28 brambling kernel: [    0.000000] DMI 2.4 present.
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: RSDP (v002 INTEL                                 ) @ 0x000f0350
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: XSDT (v001 INTEL   S3000AH 0x00000000 INTL 0x01000013) @ 0x1fefe120
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: FADT (v003 INTEL   S3000AH 0x00000000 MSFT 0x01000013) @ 0x1fefb000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: MADT (v001 INTEL   S3000AH 0x00000000 MSFT 0x01000013) @ 0x1fef5000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: WDDT (v001 INTEL   S3000AH 0x00000000 MSFT 0x01000013) @ 0x1fef4000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: MCFG (v001 INTEL   S3000AH 0x00000000 MSFT 0x01000013) @ 0x1fef3000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: ASF! (v032 INTEL   S3000AH 0x00000001 MSFT 0x01000013) @ 0x1fef2000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: DSDT (v001 INTEL   S3000AH 0x00000000 MSFT 0x01000013) @ 0x00000000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x408
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Dec 11 18:45:28 brambling kernel: [    0.000000] Processor #0 15:6 APIC version 20
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec00000] gsi_base[0])
Dec 11 18:45:28 brambling kernel: [    0.000000] IOAPIC[0]: apic_id 5, version 32, address 0xfec00000, GSI 0-23
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: IRQ0 used by override.
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: IRQ2 used by override.
Dec 11 18:45:28 brambling kernel: [    0.000000] ACPI: IRQ9 used by override.
Dec 11 18:45:28 brambling kernel: [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 11 18:45:28 brambling kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Dec 11 18:45:28 brambling kernel: [    0.000000] Allocating PCI resources starting at 20000000 (gap: 1ff00000:e00c0000)
Dec 11 18:45:28 brambling kernel: [    0.000000] Detected 3333.786 MHz processor.
Dec 11 18:45:28 brambling kernel: [   42.232571] Built 1 zonelists.  Total pages: 129794
Dec 11 18:45:28 brambling kernel: [   42.232575] Kernel command line: root=/dev/hda1 ro single
Dec 11 18:45:28 brambling kernel: [   42.232723] mapped APIC to ffffd000 (fee00000)
Dec 11 18:45:28 brambling kernel: [   42.232725] mapped IOAPIC to ffffc000 (fec00000)
Dec 11 18:45:28 brambling kernel: [   42.232727] Enabling fast FPU save and restore... done.
Dec 11 18:45:28 brambling kernel: [   42.232730] Enabling unmasked SIMD FPU exception support... done.
Dec 11 18:45:28 brambling kernel: [   42.232734] Initializing CPU#0
Dec 11 18:45:28 brambling kernel: [   42.232798] PID hash table entries: 2048 (order: 11, 8192 bytes)
Dec 11 18:45:28 brambling kernel: [   42.235132] Console: colour VGA+ 80x25
Dec 11 18:45:28 brambling kernel: [   42.237936] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 11 18:45:28 brambling kernel: [   42.238186] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec 11 18:45:28 brambling kernel: [   42.245073] Memory: 508076k/523264k available (1934k kernel code, 12808k reserved, 636k data, 316k init, 0k highmem)
Dec 11 18:45:28 brambling kernel: [   42.245165] virtual kernel memory layout:
Dec 11 18:45:28 brambling kernel: [   42.245166]     fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
Dec 11 18:45:28 brambling kernel: [   42.245167]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
Dec 11 18:45:28 brambling kernel: [   42.245168]     vmalloc : 0xe0800000 - 0xffbfe000   ( 499 MB)
Dec 11 18:45:28 brambling kernel: [   42.245169]     lowmem  : 0xc0000000 - 0xdff00000   ( 511 MB)
Dec 11 18:45:28 brambling kernel: [   42.245170]       .init : 0xc0389000 - 0xc03d8000   ( 316 kB)
Dec 11 18:45:28 brambling kernel: [   42.245171]       .data : 0xc02e3bc4 - 0xc0382bd0   ( 636 kB)
Dec 11 18:45:28 brambling kernel: [   42.245172]       .text : 0xc0100000 - 0xc02e3bc4   (1934 kB)
Dec 11 18:45:28 brambling kernel: [   42.245638] Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 11 18:45:28 brambling kernel: [   42.392708] Calibrating delay using timer specific routine.. 6671.65 BogoMIPS (lpj=33358265)
Dec 11 18:45:28 brambling kernel: [   42.392854] Security Framework v1.0.0 initialized
Dec 11 18:45:28 brambling kernel: [   42.392915] SELinux:  Disabled at boot.
Dec 11 18:45:28 brambling kernel: [   42.392983] Mount-cache hash table entries: 512
Dec 11 18:45:28 brambling kernel: [   42.393142] CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e41d 00000000 00000001
Dec 11 18:45:28 brambling kernel: [   42.393149] monitor/mwait feature present.
Dec 11 18:45:28 brambling kernel: [   42.393206] using mwait in idle threads.
Dec 11 18:45:28 brambling kernel: [   42.393267] CPU: Trace cache: 12K uops, L1 D cache: 16K
Dec 11 18:45:28 brambling kernel: [   42.393362] CPU: L2 cache: 512K
Dec 11 18:45:28 brambling kernel: [   42.393418] CPU: Hyper-Threading is disabled
Dec 11 18:45:28 brambling kernel: [   42.393475] CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000e41d 00000000 00000001
Dec 11 18:45:28 brambling kernel: [   42.393484] Compat vDSO mapped to ffffe000.
Dec 11 18:45:28 brambling kernel: [   42.393551] Checking 'hlt' instruction... OK.
Dec 11 18:45:28 brambling kernel: [   42.432791] SMP alternatives: switching to UP code
Dec 11 18:45:28 brambling kernel: [   42.432971] Freeing SMP alternatives: 12k freed
Dec 11 18:45:28 brambling kernel: [   42.433030] ACPI: Core revision 20060707
Dec 11 18:45:28 brambling kernel: [   42.436051] CPU0: Intel(R) Celeron(R) D CPU 3.33GHz stepping 04
Dec 11 18:45:28 brambling kernel: [   42.436214] Total of 1 processors activated (6671.65 BogoMIPS).
Dec 11 18:45:28 brambling kernel: [   42.436423] ENABLING IO-APIC IRQs
Dec 11 18:45:28 brambling kernel: [   42.436645] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 11 18:45:28 brambling kernel: [   42.652586] Brought up 1 CPUs
Dec 11 18:45:28 brambling kernel: [   42.652751] checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Dec 11 18:45:28 brambling kernel: [   42.661032] Freeing initrd memory: 4984k freed
Dec 11 18:45:28 brambling kernel: [   42.661385] NET: Registered protocol family 16
Dec 11 18:45:28 brambling kernel: [   42.661525] EISA bus registered
Dec 11 18:45:28 brambling kernel: [   42.661584] ACPI: bus type pci registered
Dec 11 18:45:28 brambling kernel: [   42.661649] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
Dec 11 18:45:28 brambling kernel: [   42.661710] PCI: Not using MMCONFIG.
Dec 11 18:45:28 brambling kernel: [   42.663085] PCI: Using configuration type 1
Dec 11 18:45:28 brambling kernel: [   42.663143] Setting up standard PCI resources
Dec 11 18:45:28 brambling kernel: [   42.671910] ACPI: Interpreter enabled
Dec 11 18:45:28 brambling kernel: [   42.671970] ACPI: Using IOAPIC for interrupt routing
Dec 11 18:45:28 brambling kernel: [   42.672442] ACPI: PCI Root Bridge [PCI0] (0000:00)
Dec 11 18:45:28 brambling kernel: [   42.672504] PCI: Probing PCI hardware (bus 00)
Dec 11 18:45:28 brambling kernel: [   42.672521] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Dec 11 18:45:28 brambling kernel: [   42.675096] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
Dec 11 18:45:28 brambling kernel: [   42.675161] PCI quirk: region 0500-053f claimed by ICH6 GPIO
Dec 11 18:45:28 brambling kernel: [   42.675267] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Dec 11 18:45:28 brambling kernel: [   42.676206] Boot video device is 0000:05:04.0
Dec 11 18:45:28 brambling kernel: [   42.676309] PCI: Transparent bridge - 0000:00:1e.0
Dec 11 18:45:28 brambling kernel: [   42.676424] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec 11 18:45:28 brambling kernel: [   42.678907] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
Dec 11 18:45:28 brambling kernel: [   42.679456] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
Dec 11 18:45:28 brambling kernel: [   42.680104] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12)
Dec 11 18:45:28 brambling kernel: [   42.680742] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
Dec 11 18:45:28 brambling kernel: [   42.681379] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
Dec 11 18:45:28 brambling kernel: [   42.682013] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Dec 11 18:45:28 brambling kernel: [   42.682750] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Dec 11 18:45:28 brambling kernel: [   42.683471] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Dec 11 18:45:28 brambling kernel: [   42.684195] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
Dec 11 18:45:28 brambling kernel: [   42.685788] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Dec 11 18:45:28 brambling kernel: [   42.686157] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
Dec 11 18:45:28 brambling kernel: [   42.686366] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
Dec 11 18:45:28 brambling kernel: [   42.687434] Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 11 18:45:28 brambling kernel: [   42.687505] pnp: PnP ACPI init
Dec 11 18:45:28 brambling kernel: [   42.690360] pnp: PnP ACPI: found 12 devices
Dec 11 18:45:28 brambling kernel: [   42.690422] PnPBIOS: Disabled by ACPI PNP
Dec 11 18:45:28 brambling kernel: [   42.690515] intel_rng: FWH not detected
Dec 11 18:45:28 brambling kernel: [   42.690603] PCI: Using ACPI for IRQ routing
Dec 11 18:45:28 brambling kernel: [   42.690662] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Dec 11 18:45:28 brambling kernel: [   42.690906] pnp: 00:01: ioport range 0x779-0x780 has been reserved
Dec 11 18:45:28 brambling kernel: [   42.690974] pnp: 00:06: ioport range 0x500-0x53f has been reserved
Dec 11 18:45:28 brambling kernel: [   42.691036] pnp: 00:06: ioport range 0x400-0x47f could not be reserved
Dec 11 18:45:28 brambling kernel: [   42.691097] pnp: 00:06: ioport range 0x680-0x6ff has been reserved
Dec 11 18:45:28 brambling kernel: [   42.691399] PCI: Failed to allocate mem resource #8:100000@28300000 for 0000:01:00.0
Dec 11 18:45:28 brambling kernel: [   42.691498] PCI: Failed to allocate mem resource #0:10000@0 for 0000:02:0c.0
Dec 11 18:45:28 brambling kernel: [   42.691561] PCI: Bridge: 0000:01:00.0
Dec 11 18:45:28 brambling kernel: [   42.691617]   IO window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.691679]   MEM window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.691739]   PREFETCH window: 30000000-47ffffff
Dec 11 18:45:28 brambling kernel: [   42.691804] PCI: Bridge: 0000:00:1c.0
Dec 11 18:45:28 brambling kernel: [   42.691860]   IO window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.691919]   MEM window: 28200000-282fffff
Dec 11 18:45:28 brambling kernel: [   42.691978]   PREFETCH window: 30000000-47ffffff
Dec 11 18:45:28 brambling kernel: [   42.692039] PCI: Bridge: 0000:00:1c.4
Dec 11 18:45:28 brambling kernel: [   42.692095]   IO window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.692153]   MEM window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.692211]   PREFETCH window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.692270] PCI: Bridge: 0000:00:1c.5
Dec 11 18:45:28 brambling kernel: [   42.692328]   IO window: 2000-2fff
Dec 11 18:45:28 brambling kernel: [   42.692387]   MEM window: 28100000-281fffff
Dec 11 18:45:28 brambling kernel: [   42.692445]   PREFETCH window: disabled.
Dec 11 18:45:28 brambling kernel: [   42.692506] PCI: Bridge: 0000:00:1e.0
Dec 11 18:45:28 brambling kernel: [   42.692578]   IO window: 1000-1fff
Dec 11 18:45:28 brambling kernel: [   42.692637]   MEM window: 28000000-280fffff
Dec 11 18:45:28 brambling kernel: [   42.692696]   PREFETCH window: 20000000-27ffffff
Dec 11 18:45:28 brambling kernel: [   42.692779] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
Dec 11 18:45:28 brambling kernel: [   42.692895] PCI: Setting latency timer of device 0000:00:1c.0 to 64
Dec 11 18:45:28 brambling kernel: [   42.692914] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 17
Dec 11 18:45:28 brambling kernel: [   42.693030] PCI: Setting latency timer of device 0000:01:00.0 to 64
Dec 11 18:45:28 brambling kernel: [   42.693049] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 16
Dec 11 18:45:28 brambling kernel: [   42.693163] PCI: Setting latency timer of device 0000:00:1c.4 to 64
Dec 11 18:45:28 brambling kernel: [   42.693180] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 17
Dec 11 18:45:28 brambling kernel: [   42.693294] PCI: Setting latency timer of device 0000:00:1c.5 to 64
Dec 11 18:45:28 brambling kernel: [   42.693305] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Dec 11 18:45:28 brambling kernel: [   42.693329] NET: Registered protocol family 2
Dec 11 18:45:28 brambling kernel: [   42.762548] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Dec 11 18:45:28 brambling kernel: [   42.762678] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
Dec 11 18:45:28 brambling kernel: [   42.762826] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 11 18:45:28 brambling kernel: [   42.762923] TCP: Hash tables configured (established 16384 bind 8192)
Dec 11 18:45:28 brambling kernel: [   42.762984] TCP reno registered
Dec 11 18:45:28 brambling kernel: [   42.763376] audit: initializing netlink socket (disabled)
Dec 11 18:45:28 brambling kernel: [   42.763445] audit(1165862698.390:1): initialized
Dec 11 18:45:28 brambling kernel: [   42.763583] VFS: Disk quotas dquot_6.5.1
Dec 11 18:45:28 brambling kernel: [   42.763655] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 11 18:45:28 brambling kernel: [   42.763757] io scheduler noop registered
Dec 11 18:45:28 brambling kernel: [   42.763850] io scheduler anticipatory registered
Dec 11 18:45:28 brambling kernel: [   42.763943] io scheduler deadline registered (default)
Dec 11 18:45:28 brambling kernel: [   42.764077] io scheduler cfq registered
Dec 11 18:45:28 brambling kernel: [   52.756542] 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
Dec 11 18:45:28 brambling kernel: [   52.756849] PCI: Setting latency timer of device 0000:00:1c.0 to 64
Dec 11 18:45:28 brambling kernel: [   52.756893] assign_interrupt_mode Found MSI capability
Dec 11 18:45:28 brambling kernel: [   52.756998] Allocate Port Service[0000:00:1c.0:pcie00]
Dec 11 18:45:28 brambling kernel: [   52.757034] Allocate Port Service[0000:00:1c.0:pcie02]
Dec 11 18:45:28 brambling kernel: [   52.757121] PCI: Setting latency timer of device 0000:00:1c.4 to 64
Dec 11 18:45:28 brambling kernel: [   52.757164] assign_interrupt_mode Found MSI capability
Dec 11 18:45:28 brambling kernel: [   52.757258] Allocate Port Service[0000:00:1c.4:pcie00]
Dec 11 18:45:28 brambling kernel: [   52.757285] Allocate Port Service[0000:00:1c.4:pcie02]
Dec 11 18:45:28 brambling kernel: [   52.757375] PCI: Setting latency timer of device 0000:00:1c.5 to 64
Dec 11 18:45:28 brambling kernel: [   52.757418] assign_interrupt_mode Found MSI capability
Dec 11 18:45:28 brambling kernel: [   52.757512] Allocate Port Service[0000:00:1c.5:pcie00]
Dec 11 18:45:28 brambling kernel: [   52.757541] Allocate Port Service[0000:00:1c.5:pcie02]
Dec 11 18:45:28 brambling kernel: [   52.757699] isapnp: Scanning for PnP cards...
Dec 11 18:45:28 brambling kernel: [   53.112220] isapnp: No Plug & Play device found
Dec 11 18:45:28 brambling kernel: [   53.135526] Real Time Clock Driver v1.12ac
Dec 11 18:45:28 brambling kernel: [   53.135627] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Dec 11 18:45:28 brambling kernel: [   53.135826] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 11 18:45:28 brambling kernel: [   53.136673] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 11 18:45:28 brambling kernel: [   53.137392] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Dec 11 18:45:28 brambling kernel: [   53.137558] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec 11 18:45:28 brambling kernel: [   53.137621] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec 11 18:45:28 brambling kernel: [   53.137887] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 11 18:45:28 brambling kernel: [   53.140581] serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 11 18:45:28 brambling kernel: [   53.140643] serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 11 18:45:28 brambling kernel: [   53.140804] mice: PS/2 mouse device common for all mice
Dec 11 18:45:28 brambling kernel: [   53.140964] EISA: Probing bus 0 at eisa.0
Dec 11 18:45:28 brambling kernel: [   53.141028] Cannot allocate resource for EISA slot 1
Dec 11 18:45:28 brambling kernel: [   53.142945] Cannot allocate resource for EISA slot 2
Dec 11 18:45:28 brambling kernel: [   53.143003] Cannot allocate resource for EISA slot 3
Dec 11 18:45:28 brambling kernel: [   53.143079] EISA: Detected 0 cards.
Dec 11 18:45:28 brambling kernel: [   53.143205] TCP cubic registered
Dec 11 18:45:28 brambling kernel: [   53.143266] NET: Registered protocol family 1
Dec 11 18:45:28 brambling kernel: [   53.143327] NET: Registered protocol family 8
Dec 11 18:45:28 brambling kernel: [   53.143384] NET: Registered protocol family 20
Dec 11 18:45:28 brambling kernel: [   53.143472] Using IPI No-Shortcut mode
Dec 11 18:45:28 brambling kernel: [   53.143580] ACPI: (supports S0 S1 S4 S5)


--------------060600010908030003050003--

