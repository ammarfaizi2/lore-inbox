Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWILLTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWILLTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWILLTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:19:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:3564 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030192AbWILKl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:41:58 -0400
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Lockdep Warning with LVM on DMRAID
Date: Tue, 12 Sep 2006 12:40:08 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121240.08462.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.18-rc6 I get a lockdep warning involving lvm and dm. I'm using 
dmraid (nvidia fakeraid) with LVM volumes and XFS/etx3 filesystem.

[    0.000000] Bootdata ok (command line is 
root=/dev/mapper/VolGroup00-LogVol00 ro)
[    0.000000] Linux version 2.6.18-rc6 (user@ubuntu.localnet) (gcc version 
4.1.2 20060906 (prerelease) (Ubuntu 4.1.1-13ubuntu2)) #1 SMP Sun Sep 10 
16:05:16 CEST 2006
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
[    0.000000] On node 0 totalpages: 511139
[    0.000000]   DMA zone: 2138 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 509001 pages, LIFO batch:31
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
[    0.000000] Built 1 zonelists.  Total pages: 511139
[    0.000000] Kernel command line: root=/dev/mapper/VolGroup00-LogVol00 ro
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Disabling vsyscall due to use of PM timer
[    0.000000] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[    0.000000] time.c: Detected 2651.331 MHz processor.
[   24.485222] Console: colour VGA+ 80x25
[   24.487265] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., 
Ingo Molnar
[   24.487348] ... MAX_LOCKDEP_SUBCLASSES:    8
[   24.487399] ... MAX_LOCK_DEPTH:          30
[   24.487450] ... MAX_LOCKDEP_KEYS:        2048
[   24.487501] ... CLASSHASH_SIZE:           1024
[   24.487552] ... MAX_LOCKDEP_ENTRIES:     8192
[   24.487604] ... MAX_LOCKDEP_CHAINS:      8192
[   24.487655] ... CHAINHASH_SIZE:          4096
[   24.487706]  memory used by lock dependency info: 1120 kB
[   24.487758]  per task-struct memory footprint: 1680 bytes
[   24.487810] ------------------------
[   24.487861] | Locking API testsuite:
[   
24.487912] ----------------------------------------------------------------------------
[   24.487994]                                  | spin |wlock |rlock |mutex | 
wsem | rsem |
[   
24.488077]   --------------------------------------------------------------------------
[   24.488164]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.488835]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.489511]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.490205]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.490893]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.491599]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.492304]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.493011]                     double unlock:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.493671]                   initialize held:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   24.494338]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  
ok  |  ok  |
[   
24.495012]   --------------------------------------------------------------------------
[   24.495094]               recursive read-lock:             |  
ok  |             |  ok  |
[   24.495419]            recursive read-lock #2:             |  
ok  |             |  ok  |
[   24.495744]             mixed read-write-lock:             |  
ok  |             |  ok  |
[   24.496070]             mixed write-read-lock:             |  
ok  |             |  ok  |
[   
24.496395]   --------------------------------------------------------------------------
[   24.496478]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   24.496829]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   24.497181]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   24.497532]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   24.497883]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   24.498242]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   24.498593]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   24.498944]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   24.499296]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   24.499647]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   24.499998]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   24.500356]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   24.500713]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   24.501070]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   24.501426]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   24.501783]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   24.502141]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   24.502504]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   24.502860]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   24.503212]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   24.503566]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   24.503921]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   24.504278]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   24.504635]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   24.504992]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   24.505349]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   24.505707]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   24.506063]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   24.506428]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   24.506785]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   24.507142]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   24.507498]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   24.507856]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   24.508213]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   24.508570]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   24.508927]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   24.509285]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   24.509643]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   24.510001]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   24.510367]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   24.510724]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   24.511081]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   24.511439]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   24.511796]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   24.512154]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.512511]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.512869]       hard-irq read-recursion/123:  ok  |
[   24.513034]       soft-irq read-recursion/123:  ok  |
[   24.513200]       hard-irq read-recursion/132:  ok  |
[   24.513365]       soft-irq read-recursion/132:  ok  |
[   24.513531]       hard-irq read-recursion/213:  ok  |
[   24.513697]       soft-irq read-recursion/213:  ok  |
[   24.513862]       hard-irq read-recursion/231:  ok  |
[   24.514028]       soft-irq read-recursion/231:  ok  |
[   24.514202]       hard-irq read-recursion/312:  ok  |
[   24.514367]       soft-irq read-recursion/312:  ok  |
[   24.514533]       hard-irq read-recursion/321:  ok  |
[   24.514698]       soft-irq read-recursion/321:  ok  |
[   24.514863] -------------------------------------------------------
[   24.514916] Good, all 218 testcases passed! |
[   24.514967] ---------------------------------
[   24.515812] Dentry cache hash table entries: 262144 (order: 9, 2097152 
bytes)
[   24.517094] Inode-cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[   24.517564] Checking aperture...
[   24.517616] CPU 0: aperture @ 4460000000 size 32 MB
[   24.517668] Aperture too small (32 MB)
[   24.522412] No AGP bridge found
[   24.543769] Memory: 2034524k/2097088k available (2310k kernel code, 62168k 
reserved, 1675k data, 204k init)
[   24.622115] Calibrating delay using timer specific routine.. 5307.59 
BogoMIPS (lpj=10615197)
[   24.622408] Security Framework v1.0.0 initialized
[   24.622463] SELinux:  Disabled at boot.
[   24.622601] Mount-cache hash table entries: 256
[   24.623148] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   24.623203] CPU: L2 Cache: 512K (64 bytes/line)
[   24.623255] CPU 0/0 -> Node 0
[   24.623305] CPU: Physical Processor ID: 0
[   24.623356] CPU: Processor Core ID: 0
[   24.623422] lockdep: not fixing up alternatives.
[   24.623474] ACPI: Core revision 20060707
[   24.674320] Using local APIC timer interrupts.
[   24.712068] result 16570841
[   24.712119] Detected 16.570 MHz APIC timer.
[   24.714891] lockdep: not fixing up alternatives.
[   24.714988] Booting processor 1/2 APIC 0x1
[   24.723066] Initializing CPU#1
[   24.803795] Calibrating delay using timer specific routine.. 5303.00 
BogoMIPS (lpj=10606010)
[   24.803800] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   24.803802] CPU: L2 Cache: 512K (64 bytes/line)
[   24.803804] CPU 1/1 -> Node 0
[   24.803805] CPU: Physical Processor ID: 0
[   24.803806] CPU: Processor Core ID: 1
[   24.803875] AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
[   24.807798] CPU 1: Syncing TSC to CPU 0.
[   24.810100] CPU 1: synchronized TSC with CPU 0 (last diff -74 cycles, 
maxerr 527 cycles)
[   24.810110] Brought up 2 CPUs
[   24.811344] testing NMI watchdog ... OK.
[   25.501849] migration_cost=126
[   25.502433] checking if image is initramfs... it is
[   25.987754] Freeing initrd memory: 6641k freed
[   25.991909] NET: Registered protocol family 16
[   25.992249] ACPI: bus type pci registered
[   25.995110] PCI: Using MMCONFIG at e0000000
[   25.995195] PCI: No mmconfig possible on device 0:18
[   26.010194] ACPI: Interpreter enabled
[   26.010249] ACPI: Using IOAPIC for interrupt routing
[   26.011786] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   26.011847] PCI: Probing PCI hardware (bus 00)
[   26.018136] PCI: Transparent bridge - 0000:00:09.0
[   26.018752] Boot video device is 0000:01:00.0
[   26.018836] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   26.137785] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   26.143600] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   26.144391] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   26.145166] ACPI: PCI Interrupt Link [LNK3] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   26.145948] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.146799] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.147643] ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   26.148418] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.149275] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 *12 14 
15)
[   26.150065] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   26.150837] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.151683] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 
15)
[   26.152457] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   26.153229] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.154098] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   26.154885] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   26.155671] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   26.156620] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   26.157376] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   26.158110] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   26.158851] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   26.159433] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   26.160183] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, 
disabled.
[   26.161012] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, 
disabled.
[   26.161838] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, 
disabled.
[   26.162655] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, 
disabled.
[   26.163480] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, 
disabled.
[   26.164305] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, 
disabled.
[   26.165122] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, 
disabled.
[   26.165957] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, 
disabled.
[   26.166789] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, 
disabled.
[   26.167619] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, 
disabled.
[   26.168459] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, 
disabled.
[   26.175031] Linux Plug and Play Support v0.97 (c) Adam Belay
[   26.175121] pnp: PnP ACPI init
[   26.185366] pnp: PnP ACPI: found 15 devices
[   26.185651] PCI: Using ACPI for IRQ routing
[   26.185705] PCI: If a device doesn't work, try "pci=routeirq".  If it 
helps, post a report
[   26.186098] PCI-DMA: Disabling IOMMU.
[   26.186987] pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
[   26.187043] pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
[   26.187097] pnp: 00:01: ioport range 0x4400-0x447f has been reserved
[   26.187152] pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
[   26.187207] pnp: 00:01: ioport range 0x4800-0x487f has been reserved
[   26.187261] pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
[   26.188354] PCI: Bridge: 0000:00:09.0
[   26.188406]   IO window: a000-afff
[   26.188458]   MEM window: d3000000-d4ffffff
[   26.188510]   PREFETCH window: 88000000-880fffff
[   26.188562] PCI: Bridge: 0000:00:0b.0
[   26.188613]   IO window: disabled.
[   26.188664]   MEM window: disabled.
[   26.188715]   PREFETCH window: disabled.
[   26.188767] PCI: Bridge: 0000:00:0c.0
[   26.188817]   IO window: disabled.
[   26.188868]   MEM window: disabled.
[   26.188919]   PREFETCH window: disabled.
[   26.188971] PCI: Bridge: 0000:00:0d.0
[   26.189021]   IO window: disabled.
[   26.189072]   MEM window: disabled.
[   26.189123]   PREFETCH window: disabled.
[   26.189176] PCI: Bridge: 0000:00:0e.0
[   26.189235]   IO window: 9000-9fff
[   26.189286]   MEM window: d0000000-d2ffffff
[   26.189343]   PREFETCH window: c0000000-cfffffff
[   26.189399] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   26.189406] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   26.189412] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   26.189418] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   26.189423] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   26.189883] NET: Registered protocol family 2
[   26.233324] IP route cache hash table entries: 65536 (order: 7, 524288 
bytes)
[   26.233882] TCP established hash table entries: 65536 (order: 9, 3670016 
bytes)
[   26.240031] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[   26.243081] TCP: Hash tables configured (established 65536 bind 32768)
[   26.243151] TCP reno registered
[   26.248474] Initializing RT-Tester: OK
[   26.248650] audit: initializing netlink socket (disabled)
[   26.248736] audit(1158055889.732:1): initialized
[   26.249345] VFS: Disk quotas dquot_6.5.1
[   26.249446] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   26.249669] Initializing Cryptographic API
[   26.249730] io scheduler noop registered
[   26.249821] io scheduler anticipatory registered
[   26.249914] io scheduler deadline registered
[   26.250045] io scheduler cfq registered (default)
[   26.269482] PCI: Linking AER extended capability on 0000:00:0b.0
[   26.269541] PCI: Linking AER extended capability on 0000:00:0c.0
[   26.269595] PCI: Linking AER extended capability on 0000:00:0d.0
[   26.269649] PCI: Linking AER extended capability on 0000:00:0e.0
[   26.270136] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   26.270139] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   26.270239] assign_interrupt_mode Found MSI capability
[   26.270354] Allocate Port Service[0000:00:0b.0:pcie00]
[   26.270496] Allocate Port Service[0000:00:0b.0:pcie03]
[   26.270635] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   26.270637] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   26.270736] assign_interrupt_mode Found MSI capability
[   26.270807] Allocate Port Service[0000:00:0c.0:pcie00]
[   26.270936] Allocate Port Service[0000:00:0c.0:pcie03]
[   26.271071] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   26.271074] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   26.271179] assign_interrupt_mode Found MSI capability
[   26.271249] Allocate Port Service[0000:00:0d.0:pcie00]
[   26.271383] Allocate Port Service[0000:00:0d.0:pcie03]
[   26.271515] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   26.271518] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   26.271616] assign_interrupt_mode Found MSI capability
[   26.271686] Allocate Port Service[0000:00:0e.0:pcie00]
[   26.271817] Allocate Port Service[0000:00:0e.0:pcie03]
[   26.343707] Real Time Clock Driver v1.12ac
[   26.343894] Linux agpgart interface v0.101 (c) Dave Jones
[   26.343947] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing enabled
[   26.344311] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   26.345729] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   26.348857] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 
blocksize
[   26.349709] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   26.349768] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[   26.350304] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   26.350357] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   26.352447] serio: i8042 AUX port at 0x60,0x64 irq 12
[   26.352671] serio: i8042 KBD port at 0x60,0x64 irq 1
[   26.353231] mice: PS/2 mouse device common for all mice
[   26.354333] TCP bic registered
[   26.354417] NET: Registered protocol family 1
[   26.354486] NET: Registered protocol family 8
[   26.354537] NET: Registered protocol family 20
[   26.355143] ACPI: (supports S0 S1 S3 S4 S5)
[   26.355390] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   26.355490] Freeing unused kernel memory: 204k freed
[   26.355817] Write protecting the kernel read-only data: 913k
[   26.451515] ACPI: Fan [FAN] (on)
[   26.457609] ACPI: Thermal Zone [THRM] (40 C)
[   26.669658] input: AT Translated Set 2 keyboard as /class/input/input0
[   27.230227] SCSI subsystem initialized
[   27.234327] libata version 2.00 loaded.
[   27.235923] sata_nv 0000:00:07.0: version 2.0
[   27.236906] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[   27.236967] GSI 16 sharing vector 0xD9 and IRQ 16
[   27.237022] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 
(level, low) -> IRQ 217
[   27.237299] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   27.237567] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 
217
[   27.237737] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 
217
[   27.237808] scsi0 : sata_nv
[   27.552394] ata1: SATA link down (SStatus 0 SControl 300)
[   27.552464] scsi1 : sata_nv
[   27.868211] ata2: SATA link down (SStatus 0 SControl 300)
[   27.869073] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[   27.869129] GSI 17 sharing vector 0xE1 and IRQ 17
[   27.869184] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 
(level, low) -> IRQ 225
[   27.869436] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   27.869593] ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 
225
[   27.869749] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 
225
[   27.869817] scsi2 : sata_nv
[   28.339955] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   28.344938] ata3.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[   28.345021] ata3.00: ata3: dev 0 multi count 16
[   28.350064] ata3.00: configured for UDMA/133
[   28.350129] scsi3 : sata_nv
[   28.819677] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   28.823313] ata4.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[   28.823396] ata4.00: ata4: dev 0 multi count 16
[   28.849470] ata4.00: configured for UDMA/133
[   28.849795]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   28.850428]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   28.851028]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   28.851667]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   28.865975] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   28.866061] sda: Write Protect is off
[   28.866112] sda: Mode Sense: 00 3a 00 00
[   28.866164] SCSI device sda: drive cache: write back
[   28.866428] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   28.866511] sda: Write Protect is off
[   28.866562] sda: Mode Sense: 00 3a 00 00
[   28.866622] SCSI device sda: drive cache: write back
[   28.866691]  sda: sda1 sda2 sda3
[   28.875893]  sda: p3 exceeds device capacity
[   28.876242] sd 2:0:0:0: Attached scsi disk sda
[   28.876503] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   28.876598] sdb: Write Protect is off
[   28.876649] sdb: Mode Sense: 00 3a 00 00
[   28.876725] SCSI device sdb: drive cache: write back
[   28.877000] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   28.877132] sdb: Write Protect is off
[   28.877183] sdb: Mode Sense: 00 3a 00 00
[   28.877268] SCSI device sdb: drive cache: write back
[   28.877337]  sdb: unknown partition table
[   28.881769] sd 3:0:0:0: Attached scsi disk sdb
[   29.014966] Buffer I/O error on device sda3, logical block 669380224
[   29.015027] Buffer I/O error on device sda3, logical block 669380225
[   29.015082] Buffer I/O error on device sda3, logical block 669380226
[   29.015137] Buffer I/O error on device sda3, logical block 669380227
[   29.015191] Buffer I/O error on device sda3, logical block 669380228
[   29.015246] Buffer I/O error on device sda3, logical block 669380229
[   29.015300] Buffer I/O error on device sda3, logical block 669380230
[   29.015355] Buffer I/O error on device sda3, logical block 669380231
[   29.015477] Buffer I/O error on device sda3, logical block 669380224
[   29.015556] Buffer I/O error on device sda3, logical block 669380225
[   29.136019] NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
[   29.136098] NFORCE-CK804: chipset revision 242
[   29.136150] NFORCE-CK804: not 100% native mode: will probe irqs later
[   29.136207] NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
[   29.136269]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:DMA
[   29.136399]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, 
hdd:DMA
[   29.136527] Probing IDE interface ide0...
[   29.707174] Probing IDE interface ide1...
[   30.446915] hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
[   31.234460] hdd: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
[   31.297550] ide1 at 0x170-0x177,0x376 on irq 15
[   31.314208] hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
[   31.314393] Uniform CD-ROM driver Revision: 3.20
[   31.323516] hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, 
UDMA(33)
[   31.436171] Probing IDE interface ide0...
[   31.454554] ieee1394: Initialized config rom entry `ip1394'
[   31.456774] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   31.456833] GSI 18 sharing vector 0xE9 and IRQ 18
[   31.456888] ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 
(level, low) -> IRQ 233
[   31.507557] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 
0.56.
[   31.515047] usbcore: registered new driver usbfs
[   31.515910] usbcore: registered new driver hub
[   31.527261] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[   31.531476] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[233]  
MMIO=[d4008000-d40087ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   31.533894] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
[   31.533953] GSI 19 sharing vector 0x32 and IRQ 19
[   31.534009] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 
(level, low) -> IRQ 50
[   31.534222] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   31.534232] forcedeth: using HIGHDMA
[   32.058217] eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
[   32.059535] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
[   32.059593] GSI 20 sharing vector 0x3A and IRQ 20
[   32.059650] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 
(level, low) -> IRQ 58
[   32.059903] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   32.059909] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   32.060370] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 1
[   32.060530] ehci_hcd 0000:00:02.1: debug port 1
[   32.060584] PCI: cache line size of 64 is not supported by device 
0000:00:02.1
[   32.060600] ehci_hcd 0000:00:02.1: irq 58, io mem 0xfeb00000
[   32.060655] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[   32.061253] usb usb1: configuration #1 chosen from 1 choice
[   32.061460] hub 1-0:1.0: USB hub found
[   32.061538] hub 1-0:1.0: 10 ports detected
[   32.167065] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[   32.167121] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 
(level, low) -> IRQ 217
[   32.167355] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   32.167360] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   32.167615] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 2
[   32.167723] ohci_hcd 0000:00:02.0: irq 217, io mem 0xd5004000
[   32.228249] usb usb2: configuration #1 chosen from 1 choice
[   32.228471] hub 2-0:1.0: USB hub found
[   32.228551] hub 2-0:1.0: 10 ports detected
[   32.361650] device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
[   32.405633] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   32.506210] 
[   32.506212] =============================================
[   32.506315] [ INFO: possible recursive locking detected ]
[   32.506367] ---------------------------------------------
[   32.506419] vgchange/2026 is trying to acquire lock:
[   32.506470]  (&md->io_lock){----}, at: [<ffffffff88151465>] 
dm_request+0x25/0x140 [dm_mod]
[   32.506637] 
[   32.506638] but task is already holding lock:
[   32.506736]  (&md->io_lock){----}, at: [<ffffffff88151465>] 
dm_request+0x25/0x140 [dm_mod]
[   32.506898] 
[   32.506899] other info that might help us debug this:
[   32.506998] 1 lock held by vgchange/2026:
[   32.507048]  #0:  (&md->io_lock){----}, at: [<ffffffff88151465>] 
dm_request+0x25/0x140 [dm_mod]
[   32.507229] 
[   32.507229] stack backtrace:
[   32.507326] 
[   32.507327] Call Trace:
[   32.507431]  [<ffffffff802b1cdc>] __lock_acquire+0x97c/0xd20
[   32.507489]  [<ffffffff88151465>] :dm_mod:dm_request+0x25/0x140
[   32.507543]  [<ffffffff802b2108>] lock_acquire+0x88/0xc0
[   32.507600]  [<ffffffff88151465>] :dm_mod:dm_request+0x25/0x140
[   32.507655]  [<ffffffff802ae40e>] down_read+0x3e/0x50
[   32.507711]  [<ffffffff88151465>] :dm_mod:dm_request+0x25/0x140
[   32.507767]  [<ffffffff8021dc4f>] generic_make_request+0x18f/0x1b0
[   32.507825]  [<ffffffff88150419>] :dm_mod:__map_bio+0x69/0xc0
[   32.507882]  [<ffffffff88151010>] :dm_mod:__split_bio+0x180/0x3d0
[   32.507937]  [<ffffffff8026f3eb>] _spin_unlock_irq+0x2b/0x40
[   32.507995]  [<ffffffff8815156a>] :dm_mod:dm_request+0x12a/0x140
[   32.508049]  [<ffffffff8026f489>] _spin_unlock_irqrestore+0x49/0x60
[   32.508103]  [<ffffffff8021dc4f>] generic_make_request+0x18f/0x1b0
[   32.508158]  [<ffffffff802f9a2a>] dio_bio_submit+0x4a/0xa0
[   32.508213]  [<ffffffff8023906e>] submit_bio+0xde/0xf0
[   32.508267]  [<ffffffff802f9a54>] dio_bio_submit+0x74/0xa0
[   32.508320]  [<ffffffff802faa17>] __blockdev_direct_IO+0x987/0xd70
[   32.508378]  [<ffffffff802eb319>] blkdev_direct_IO+0x49/0x50
[   32.508431]  [<ffffffff802eb200>] blkdev_get_blocks+0x0/0xd0
[   32.508486]  [<ffffffff802ccdca>] generic_file_direct_IO+0xba/0x110
[   32.508541]  [<ffffffff8020c5da>] __generic_file_aio_read+0xca/0x1e0
[   32.508597]  [<ffffffff802cd476>] generic_file_read+0xc6/0xe0
[   32.508653]  [<ffffffff802aba70>] autoremove_wake_function+0x0/0x40
[   32.508707]  [<ffffffff802b0fad>] trace_hardirqs_on+0x11d/0x150
[   32.508763]  [<ffffffff8020b54c>] vfs_read+0xdc/0x1a0
[   32.508816]  [<ffffffff80211e10>] sys_read+0x50/0x90
[   32.508871]  [<ffffffff80267cce>] system_call+0x7e/0x83
[   32.508924] 
[   32.546268] usb 1-1: configuration #1 chosen from 1 choice
[   32.657415] SGI XFS with ACLs, security attributes, realtime, large 
block/inode numbers, no debug enabled
[   32.658017] SGI XFS Quota Management subsystem
[   32.659014] Filesystem "dm-4": Disabling barriers, not supported by the 
underlying device
[   32.667848] XFS mounting filesystem dm-4
[   32.735854] Ending clean XFS mount for filesystem: dm-4
[   32.789384] usb 1-2: new high speed USB device using ehci_hcd and address 3
[   32.805640] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000077be63]
[   32.927168] usb 1-2: configuration #1 chosen from 1 choice
[   33.113226] ohci_hcd 0000:00:02.0: wakeup
[   33.496966] usb 2-4: new low speed USB device using ohci_hcd and address 2
[   33.715992] usb 2-4: configuration #1 chosen from 1 choice
[   39.901742] usbcore: registered new driver hiddev
[   39.912450] input: HID 1241:1177 as /class/input/input1
[   39.912558] input: USB HID v1.10 Mouse [HID 1241:1177] on 
usb-0000:00:02.0-4
[   39.912664] usbcore: registered new driver usbhid
[   39.912716] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   40.015728] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   40.020990] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   40.081021] input: PC Speaker as /class/input/input2
[   40.241659] Floppy drive(s): fd0 is 1.44M
[   40.264564] FDC 0 is a post-1991 82077
[   40.321504] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   40.321563] GSI 21 sharing vector 0x42 and IRQ 21
[   40.322220] ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 
(level, low) -> IRQ 66
[   40.322505] skge 1.6 addr 0xd4000000 irq 66 chip Yukon-Lite rev 9
[   40.322778] skge eth1: addr 00:15:f2:3f:26:5c
[   40.325025] printk: 78 messages suppressed.
[   40.325082] Buffer I/O error on device sda3, logical block 669380224
[   40.325139] Buffer I/O error on device sda3, logical block 669380225
[   40.460110] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   40.460228] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   40.513842] skge eth1: enabling interface
[   40.689174] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   40.689300] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   40.728292] parport: PnPBIOS parport detected.
[   40.728396] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   40.865202] ts: Compaq touchscreen protocol output
[   41.158606] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
[   41.158663] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 
(level, low) -> IRQ 225
[   41.158947] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   41.484325] intel8x0_measure_ac97_clock: measured 58612 usecs
[   41.484380] intel8x0: clocking to 47020
[   41.554605] NET: Registered protocol family 17
[   42.060017] it87: Found IT8712F chip at 0x290, revision 7
[   42.131355] Unable to find swap-space signature
[   42.219982] Filesystem "dm-4": Disabling barriers, not supported by the 
underlying device
[   42.921812] Filesystem "dm-6": Disabling barriers, not supported by the 
underlying device
[   42.942206] XFS mounting filesystem dm-6
[   43.029193] Ending clean XFS mount for filesystem: dm-6
[   43.116580] kjournald starting.  Commit interval 5 seconds
[   43.116766] EXT3 FS on dm-2, internal journal
[   43.116771] EXT3-fs: mounted filesystem with ordered data mode.
[   43.143583] NTFS driver 2.1.27 [Flags: R/O MODULE].
[   43.228009] NTFS volume version 3.1.
[   43.266979] Unable to find swap-space signature
[   49.385866] ACPI: Power Button (FF) [PWRF]
[   49.385880] ACPI: Power Button (CM) [PWRB]
[   49.415888] Using specific hotkey driver
[   49.479650] ibm_acpi: ec object not found
[   49.538377] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   49.808754] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 
3800+ processors (version 2.00.00)
[   49.808845] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8
[   49.808848] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa
[   49.808850] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[   49.810062] powernow-k8: ph2 null fid transition 0xc
[   50.287468] lp0: using parport0 (interrupt-driven).
[   50.299580] ppdev: user-space parallel port driver
[   53.678891] printk: 54 messages suppressed.
[   53.678895] Buffer I/O error on device sda3, logical block 669380224
[   53.678981] Buffer I/O error on device sda3, logical block 669380225
[   53.908228] Capability LSM initialized
[   54.104463] NET: Registered protocol family 10
[   54.104688] lo: Disabled Privacy Extensions
[   54.105149] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   54.105221] IPv6 over IPv4 tunneling driver
[   60.838743] eth0: no IPv6 routers present
[  122.035070] Unable to find swap-space signature
[  140.368579] Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 
extents:1 across:2031608k
[  186.747245] nvidia: module license 'NVIDIA' taints kernel.
[  186.750669] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[  186.750675] GSI 22 sharing vector 0x4A and IRQ 22
[  186.750680] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 
(level, low) -> IRQ 74
[  186.750688] PCI: Setting latency timer of device 0000:01:00.0 to 64
[  186.750846] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8774  Tue 
Aug  1 21:42:17 PDT 2006
[  293.990894] PCI: Setting latency timer of device 0000:01:00.0 to 64
[  293.991001] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8774  Tue 
Aug  1 21:42:17 PDT 2006
[  294.249905] i2c_adapter i2c-2: SMBus Quick command not supported, can't 
probe for chips
[  294.251678] i2c_adapter i2c-3: SMBus Quick command not supported, can't 
probe for chips
[  294.253076] i2c_adapter i2c-4: SMBus Quick command not supported, can't 
probe for chips
[  318.912165] Bluetooth: Core ver 2.10
[  318.912278] NET: Registered protocol family 31
[  318.912280] Bluetooth: HCI device and connection manager initialized
[  318.912283] Bluetooth: HCI socket layer initialized
