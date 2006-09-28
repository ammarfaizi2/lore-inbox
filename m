Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWI1Sw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWI1Sw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWI1Sw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:52:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18138 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751397AbWI1Sw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:52:26 -0400
Date: Thu, 28 Sep 2006 11:52:22 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network problem with 2.6.18-mm1 ?
Message-ID: <20060928185222.GB3352@us.ibm.com>
References: <20060928013724.GA22898@us.ibm.com> <451B2D29.9040306@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <451B2D29.9040306@intel.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks. See below for additional info

Auke Kok [auke-jan.h.kok@intel.com] wrote:
| Sukadev Bhattiprolu wrote:
| >
| >I am unable to get networking to work with 2.6.18-mm1 on my system.
| >
| >But 2.6.18 kernel on same system works fine. Here is some info about
| >the system/debug attempts. Attached are the lspci output and config.
| >
| >Appreciate any help. Please let me know if you need more info. 
| >
| >Suka
| >
| >System info:
| >
| >	x326, 2 CPU (AMD Opteron Processor 250)
| >
| >Kernel info:
| >
| >	$ uname -a
| >	Linux elm3b166 2.6.18-mm1 #4 SMP PREEMPT Tue Sep 26 18:11:58 PDT 2006
| >	x86_64 GNU/Linux
| >
| >	Config tokens differing between the 2.6.18 kernel that works and
| >	the 2.6.18-mm1 that does not are:
| >
| >	Tokens in 2.6.18 but not in 2.6.18-mm1 config
| >
| >		CONFIG_SCSI_FC_ATTRS=y
| >		CONFIG_SCSI_SATA_SIL=y
| >		CONFIG_SCSI_SATA=y
| >
| >	Tokens in 2.6.18-mm1 but not in 2.6.18 config
| >
| >		CONFIG_PROC_SYSCTL=y
| >		CONFIG_SATA_SIL=y 
| >		CONFIG_ATA=y 
| >		CONFIG_ARCH_POPULATES_NODE_MAP=y
| >		CONFIG_CRYPTO_ALGAPI=y
| >		CONFIG_MICROCODE_OLD_INTERFACE=y
| >		CONFIG_BLOCK=y
| >		CONFIG_VIDEO_V4L1_COMPAT=y
| >		CONFIG_ZONE_DMA=y
| >		CONFIG_FB_DDC=y
| >
| >	All drivers compiled into kernel in both cases.
| >
| >Debug info:
| >
| >	Checked hardware connections :-) 
| >	(Rebooting on 2.6.18 kernel works - consistently)
| >	
| >	$ ethtool -i eth0
| >		driver: e1000
| >		version: 7.2.7-k2
| >		firmware-version: N/A
| >
| >	$ ip addr
| >		seems fine (up, broadcasting etc)
| >
| >	$ ip -s link
| >		shows no errors/drops/overruns
| >
| >	$ ip route
| >		shows the correct gw
| >
| >	$ ethtool -S eth0
| >
| >		shows non-zero tx/rx packets/bytes but *rx_missed_errors*
| >		quite large (~138K) and increasing over time
| >
| >	$ ping <own-ip-addr>
| >		works fine
| >
| >	$ ping <gateway>
| >		no response.
| >
| >	$ tcpdump -i eth0 host <broken-host>
| >	
| >		while pinging gateway, tcpdump shows messages like:
| >
| >		18:03:45.936161 arp who-has <gateway> tell <broken-host>
| >
| >(Config file and lspci output are attached)
| 
| how about dmesg? Perhaps it shows some valuable information.

Am attaching the dmesg.out

| 
| also, since this is a networking problem, please include `ifconfig eth0` 
| and the full output of `ethtool eth0` and `ethtool -S eth0`

$ ifconfig eth0

eth0      Link encap:Ethernet  HWaddr 00:02:B3:9D:D4:D7  
          inet addr:10.0.67.166  Bcast:10.0.67.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:564 errors:0 dropped:5927 overruns:0 frame:0
          TX packets:105 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:81803 (79.8 KiB)  TX bytes:6720 (6.5 KiB)
          Base address:0x3400 Memory:e8240000-e8260000 


$ ethtool eth0

Settings for eth0:
	Supported ports: [ TP ]
	Supported link modes:   10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Supports auto-negotiation: Yes
	Advertised link modes:  10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Advertised auto-negotiation: Yes
	Speed: 100Mb/s
	Duplex: Full
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: on
	Supports Wake-on: umbg
	Wake-on: g
	Current message level: 0x00000007 (7)
	Link detected: yes

$ ethtool -S eth0

NIC statistics:
     rx_packets: 564
     tx_packets: 105
     rx_bytes: 81803
     tx_bytes: 6720
     rx_errors: 0
     tx_errors: 0
     tx_dropped: 0
     multicast: 11
     collisions: 0
     rx_length_errors: 0
     rx_over_errors: 0
     rx_crc_errors: 0
     rx_frame_errors: 0
     rx_no_buffer_count: 310
     rx_missed_errors: 5865
     tx_aborted_errors: 0
     tx_carrier_errors: 0
     tx_fifo_errors: 0
     tx_heartbeat_errors: 0
     tx_window_errors: 0
     tx_abort_late_coll: 0
     tx_deferred_ok: 0
     tx_single_coll_ok: 0
     tx_multi_coll_ok: 0
     tx_timeout_count: 0
     rx_long_length_errors: 0
     rx_short_length_errors: 0
     rx_align_errors: 0
     tx_tcp_seg_good: 0
     tx_tcp_seg_failed: 0
     rx_flow_control_xon: 0
     rx_flow_control_xoff: 0
     tx_flow_control_xon: 0
     tx_flow_control_xoff: 0
     rx_long_byte_count: 81803
     rx_csum_offload_good: 0
     rx_csum_offload_errors: 0
     rx_header_split: 0
     alloc_rx_buff_failed: 0

Hope this helps. Let me know if you need more info.

Suka

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg-2.6.18-mm1.out
Content-Disposition: attachment; filename="dmesg-mm1.out"

[    0.000000] Linux version 2.6.18-mm1 (suka@elm3b166) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #4 SMP PREEMPT Tue Sep 26 18:11:58 PDT 2006
[    0.000000] Command line: root=/dev/sda1 ro quiet console=ttyS0,57600 debug pci=noacpi acpi=off
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
[    0.000000]  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
[    0.000000]  BIOS-e820: 000000007ff70000 - 000000007ff7b000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff7b000 - 000000007ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 154) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 524144) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] Number of nodes 2
[    0.000000] Node 0 MemBase 0000000000000000 Limit 0000000040000000
[    0.000000] Entering add_active_range(0, 0, 154) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 262144) 1 entries of 3200 used
[    0.000000] Node 1 MemBase 0000000040000000 Limit 000000007ff70000
[    0.000000] Entering add_active_range(1, 262144, 524144) 2 entries of 3200 used
[    0.000000] NUMA: Using 30 for the hash shift.
[    0.000000] Using node hash shift of 30
[    0.000000] Bootmem setup node 0 0000000000000000-0000000040000000
[    0.000000] Bootmem setup node 1 0000000040000000-000000007ff70000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->  1048576
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      154
[    0.000000]     0:      256 ->   262144
[    0.000000]     1:   262144 ->   524144
[    0.000000] On node 0 totalpages: 262042
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1615 pages reserved
[    0.000000]   DMA zone: 2323 pages, LIFO batch:0
[    0.000000]   Normal zone: 3528 pages used for memmap
[    0.000000]   Normal zone: 254520 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 262000
[    0.000000]   DMA zone: 0 pages used for memmap
[    0.000000]   Normal zone: 3582 pages used for memmap
[    0.000000]   Normal zone: 258418 pages, LIFO batch:31
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000] MPTABLE: OEM ID: AMD      MPTABLE: Product ID: HAMMER       MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] Processor #1
[    0.000000] I/O APIC #2 at 0xFEC00000.
[    0.000000] I/O APIC #3 at 0xE8000000.
[    0.000000] I/O APIC #4 at 0xE8001000.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Processors: 2
[    0.000000] Nosave address range: 000000000009a000 - 000000000009b000
[    0.000000] Nosave address range: 000000000009b000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000d0000
[    0.000000] Nosave address range: 00000000000d0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34176 bytes of per cpu data
[    0.000000] Built 2 zonelists.  Total pages: 515261
[    0.000000] Kernel command line: root=/dev/sda1 ro quiet console=ttyS0,57600 debug pci=noacpi acpi=off
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   95.697829] Console: colour VGA+ 80x25
[   96.406338] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   96.422658] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   96.436902] Checking aperture...
[   96.443355] CPU 0: aperture @ 0 size 32 MB
[   96.457962] No AGP bridge found
[   96.464228] Your BIOS doesn't leave a aperture memory hole
[   96.475174] Please enable the IOMMU option in the BIOS setup
[   96.486466] This costs you 64 MB of RAM
[   96.535791] Mapping aperture over 65536 KB of RAM @ 4000000
[   96.568325] Memory: 1992256k/2096576k available (3997k kernel code, 103912k reserved, 1437k data, 316k init)
[   96.663979] Calibrating delay using timer specific routine.. 4794.74 BogoMIPS (lpj=9589489)
[   96.680762] Mount-cache hash table entries: 256
[   96.689925] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   96.704159] CPU: L2 Cache: 1024K (64 bytes/line)
[   96.713375] CPU 0/0 -> Node 0
[   96.719325] SMP alternatives: switching to UP code
[   96.769355] Using local APIC timer interrupts.
[   96.819919] result 12461204
[   96.825491] Detected 12.461 MHz APIC timer.
[   96.835806] SMP alternatives: switching to SMP code
[   96.845570] Booting processor 1/2 APIC 0x1
[   96.864027] Initializing CPU#1
[   96.943336] Calibrating delay using timer specific routine.. 4785.43 BogoMIPS (lpj=9570867)
[   96.943343] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   96.943345] CPU: L2 Cache: 1024K (64 bytes/line)
[   96.943348] CPU 1/1 -> Node 1
[   96.943470] AMD Opteron(tm) Processor 250 stepping 0a
[   96.947334] CPU 1: Syncing TSC to CPU 0.
[   96.947518] CPU 1: synchronized TSC with CPU 0 (last diff -145 cycles, maxerr 1296 cycles)
[   96.947525] Brought up 2 CPUs
[   97.039910] testing NMI watchdog ... OK.
[   97.087760] time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
[   97.100261] time.c: Detected 2392.549 MHz processor.
[   97.239553] migration_cost=745
[   97.246198] NET: Registered protocol family 16
[   97.255190] PCI: Using configuration type 1
[   97.265594] ACPI: Interpreter disabled.
[   97.273448] SCSI subsystem initialized
[   97.280973] usbcore: registered new interface driver usbfs
[   97.291945] usbcore: registered new interface driver hub
[   97.302591] usbcore: registered new device driver usb
[   97.312728] PCI: Probing PCI hardware
[   97.320027] PCI: Probing PCI hardware (bus 00)
[   97.329650] Boot video device is 0000:03:04.0
[   97.339359] PCI: Using IRQ router default [1022/746b] at 0000:00:07.3
[   97.352211] PCI->APIC IRQ transform: 0000:01:00.0[D] -> IRQ 19
[   97.363850] PCI->APIC IRQ transform: 0000:01:00.1[D] -> IRQ 19
[   97.375489] PCI->APIC IRQ transform: 0000:01:06.0[A] -> IRQ 17
[   97.387127] PCI->APIC IRQ transform: 0000:03:03.0[A] -> IRQ 28
[   97.398764] PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 29
[   97.410411] PCI: Cannot allocate resource region 0 of device 0000:00:0a.1
[   97.423945] PCI: Cannot allocate resource region 0 of device 0000:00:0b.1
[   97.437564] PCI-DMA: Disabling AGP.
[   97.444553] PCI-DMA: aperture base @ 4000000 size 65536 KB
[   97.455487] PCI-DMA: using GART IOMMU.
[   97.462975] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[   97.476162] PCI: Bridge: 0000:00:06.0
[   97.483469]   IO window: 2000-2fff
[   97.490267]   MEM window: e8100000-e81fffff
[   97.498619]   PREFETCH window: 88000000-880fffff
[   97.507836] PCI: Bridge: 0000:00:0a.0
[   97.515147]   IO window: disabled.
[   97.521929]   MEM window: disabled.
[   97.528898]   PREFETCH window: disabled.
[   97.536733] PCI: Bridge: 0000:00:0b.0
[   97.544047]   IO window: 3000-3fff
[   97.550845]   MEM window: e8200000-e82fffff
[   97.559197]   PREFETCH window: f0000000-f7ffffff
[   97.568507] NET: Registered protocol family 2
[   97.609825] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   97.624494] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   97.642662] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   97.656781] TCP: Hash tables configured (established 262144 bind 65536)
[   97.669960] TCP reno registered
[   97.676710] microcode: CPU0 not a capable Intel processor
[   97.687492] microcode: CPU1 not a capable Intel processor
[   97.698260] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[   97.711884] audit: initializing netlink socket (disabled)
[   97.722661] audit(1159404999.820:1): initialized
[   97.731965] Total HugeTLB memory allocated, 0
[   97.740993] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   97.753866] NTFS driver 2.1.27 [Flags: R/O].
[   97.762414] fuse init (API version 7.7)
[   97.770152] JFS: nTxBlock = 8192, nTxLock = 65536
[   97.782708] io scheduler noop registered
[   97.790555] io scheduler anticipatory registered (default)
[   97.801555] io scheduler deadline registered
[   97.810116] io scheduler cfq registered
[   97.817802] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 0000:00:0a.0 subordinate bus.
[   97.835143] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 0000:00:0b.0 subordinate bus.
[   98.276823] radeonfb (0000:03:04.0): cannot map FB
[   98.286403] radeonfb: probe of 0000:03:04.0 failed with error -5
[   98.298443] vga16fb: initializing
[   98.305066] vga16fb: mapped to 0xffff8100000a0000
[   98.445748] Console: switching to colour frame buffer device 80x30
[   98.465861] fb0: VGA16 VGA frame buffer device
[   98.498130] Real Time Clock Driver v1.12ac
[   98.506345] Non-volatile memory driver v1.2
[   98.514696] Linux agpgart interface v0.101 (c) Dave Jones
[   98.525481] [drm] Initialized drm 1.0.1 20051102
[   98.534792] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   98.546614] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   98.564465] Hangcheck: Using monotonic_clock().
[   98.573498] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   98.589297] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   98.602224] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   98.617616] loop: loaded (max 8 devices)
[   98.625445] Intel(R) PRO/1000 Network Driver - version 7.2.7-k2
[   98.637256] Copyright (c) 1999-2006 Intel Corporation.
[   98.896379] e1000: 0000:03:03.0: e1000_probe: (PCI:66MHz:64-bit) 00:02:b3:9d:d4:d7
[   98.944078] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   98.957877] Linux video capture interface: v2.00
[   98.967102] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   98.979771] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   98.995809] AMD8111: IDE controller at PCI slot 0000:00:07.1
[   99.007102] AMD8111: chipset revision 3
[   99.014753] AMD8111: not 100% native mode: will probe irqs later
[   99.026727] AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
[   99.038192]     ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio
[   99.052671]     ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
[   99.067146] Probing IDE interface ide0...
[   99.644997] Probing IDE interface ide1...
[  100.223891] Probing IDE interface ide0...
[  100.802282] Probing IDE interface ide1...
[  101.381169] libata version 2.00 loaded.
[  101.388912] sata_sil 0000:01:06.0: version 2.0
[  101.398482] ata1: SATA max UDMA/100 cmd 0xFFFFC200005FE080 ctl 0xFFFFC200005FE08A bmdma 0xFFFFC200005FE000 irq 17
[  101.418978] ata2: SATA max UDMA/100 cmd 0xFFFFC200005FE0C0 ctl 0xFFFFC200005FE0CA bmdma 0xFFFFC200005FE008 irq 17
[  101.439440] scsi0 : sata_sil
[  102.031444] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  102.047558] ata1.00: ATA-6, max UDMA/133, 156312576 sectors: LBA48 
[  102.060055] ata1.00: ata1: dev 0 multi count 16
[  102.073140] ata1.00: configured for UDMA/100
[  102.081663] scsi1 : sata_sil
[  102.398555] ata2: SATA link down (SStatus 0 SControl 310)
[  102.409385] scsi 0:0:0:0: Direct-Access     ATA      ST380013AS       3.25 PQ: 0 ANSI: 5
[  102.425618] SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
[  102.438815] sda: Write Protect is off
[  102.446114] sda: Mode Sense: 00 3a 00 00
[  102.453940] SCSI device sda: drive cache: write back
[  102.463877] SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
[  102.477074] sda: Write Protect is off
[  102.484384] sda: Mode Sense: 00 3a 00 00
[  102.492228] SCSI device sda: drive cache: write back
[  102.502128]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
[  102.567864] sd 0:0:0:0: Attached scsi disk sda
[  102.576802] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  102.587531] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[  102.603768] ohci_hcd 0000:01:00.0: OHCI Host Controller
[  102.614340] ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[  102.629103] ohci_hcd 0000:01:00.0: irq 19, io mem 0xe8100000
[  102.699885] usb usb1: new device found, idVendor=0000, idProduct=0000
[  102.712727] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[  102.726476] usb usb1: Product: OHCI Host Controller
[  102.736211] usb usb1: Manufacturer: Linux 2.6.18-mm1 ohci_hcd
[  102.747660] usb usb1: SerialNumber: 0000:01:00.0
[  102.756965] usb usb1: configuration #1 chosen from 1 choice
[  102.768125] hub 1-0:1.0: USB hub found
[  102.775617] hub 1-0:1.0: 3 ports detected
[  102.889686] ohci_hcd 0000:01:00.1: OHCI Host Controller
[  102.900250] ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
[  102.915011] ohci_hcd 0000:01:00.1: irq 19, io mem 0xe8101000
[  102.987213] usb usb2: new device found, idVendor=0000, idProduct=0000
[  103.000115] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[  103.013824] usb usb2: Product: OHCI Host Controller
[  103.023543] usb usb2: Manufacturer: Linux 2.6.18-mm1 ohci_hcd
[  103.034992] usb usb2: SerialNumber: 0000:01:00.1
[  103.044288] usb usb2: configuration #1 chosen from 1 choice
[  103.055441] hub 2-0:1.0: USB hub found
[  103.062929] hub 2-0:1.0: 3 ports detected
[  103.176811] USB Universal Host Controller Interface driver v3.0
[  103.188681] sl811: driver sl811-hcd, 19 May 2005
[  103.197981] Initializing USB Mass Storage driver...
[  103.200674] usb 1-1: new full speed USB device using ohci_hcd and address 2
[  103.435167] usb 1-1: new device found, idVendor=04b3, idProduct=4001
[  103.447845] usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
[  103.461381] usb 1-1: Product: PPC I/F
[  103.468694] usb 1-1: Manufacturer: IBM
[  103.476165] usb 1-1: SerialNumber: 001125913285
[  103.485284] usb 1-1: configuration #1 chosen from 1 choice
[  103.815216] usb 2-1: new full speed USB device using ohci_hcd and address 2
[  104.046746] usb 2-1: new device found, idVendor=04b3, idProduct=3006
[  104.059414] usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  104.072947] usb 2-1: Product: IBM USB HUB KEYBOARD
[  104.082494] usb 2-1: Manufacturer: Silitek
[  104.090767] usb 2-1: configuration #1 chosen from 1 choice
[  104.106648] hub 2-1:1.0: USB hub found
[  104.115587] hub 2-1:1.0: 3 ports detected
[  104.549493] usb 2-2: new low speed USB device using ohci_hcd and address 3
[  104.778062] usb 2-2: new device found, idVendor=04b3, idProduct=310c
[  104.790738] usb 2-2: new device strings: Mfr=0, Product=2, SerialNumber=0
[  104.804273] usb 2-2: Product: USB Optical Mouse
[  104.813473] usb 2-2: configuration #1 chosen from 1 choice
[  105.053427] usb 2-1.1: new full speed USB device using ohci_hcd and address 4
[  105.188117] usb 2-1.1: new device found, idVendor=04b3, idProduct=3005
[  105.201132] usb 2-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  105.215011] usb 2-1.1: Product: IBM USB HUB KEYBOARD
[  105.224969] usb 2-1.1: Manufacturer: Silitek
[  105.233569] usb 2-1.1: configuration #1 chosen from 1 choice
[  105.258958] usbcore: registered new interface driver usb-storage
[  105.270946] USB Mass Storage support registered.
[  105.280186] usbcore: registered new interface driver hiddev
[  105.298957] input: IBM PPC I/F as /class/input/input0
[  105.309051] input: USB HID v1.10 Keyboard [IBM PPC I/F] on usb-0000:01:00.0-1
[  105.333883] input: IBM PPC I/F as /class/input/input1
[  105.343960] input: USB HID v1.10 Mouse [IBM PPC I/F] on usb-0000:01:00.0-1
[  105.362806] input: USB Optical Mouse as /class/input/input2
[  105.373928] input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:01:00.1-2
[  105.393753] input: Silitek IBM USB HUB KEYBOARD as /class/input/input3
[  105.406823] input: USB HID v1.10 Keyboard [Silitek IBM USB HUB KEYBOARD] on usb-0000:01:00.1-1.1
[  105.424416] usbcore: registered new interface driver usbhid
[  105.435522] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  105.449738] serio: i8042 AUX port at 0x60,0x64 irq 12
[  105.459880] serio: i8042 KBD port at 0x60,0x64 irq 1
[  105.469921] mice: PS/2 mouse device common for all mice
[  105.480822] oprofile: using NMI interrupt.
[  105.489022] Netfilter messages via NETLINK v0.30.
[  105.498417] ip_conntrack version 2.4 (8192 buckets, 65536 max) - 272 bytes per conntrack
[  105.619007] ctnetlink v0.90: registering with nfnetlink.
[  105.629611] ip_conntrack_pptp version 3.1 loaded
[  105.638842] TCP bic registered
[  105.644954] NET: Registered protocol family 1
[  105.653649] NET: Registered protocol family 17
[  105.662516] NET: Registered protocol family 15
[  105.904813] kjournald starting.  Commit interval 5 seconds
[  105.915754] EXT3-fs: mounted filesystem with ordered data mode.
[  105.927586] VFS: Mounted root (ext3 filesystem) readonly.
[  105.938425] Freeing unused kernel memory: 316k freed
[  107.794446] warning: process `ls' used the removed sysctl system call
[  108.879759] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
[  108.956672] warning: process `touch' used the removed sysctl system call
[  109.291388] EXT3 FS on sda1, internal journal
[  109.318904] warning: process `touch' used the removed sysctl system call
[  109.382769] warning: process `touch' used the removed sysctl system call
[  109.579204] warning: process `evms_activate' used the removed sysctl system call
[  110.689106] Adding 9783544k swap on /dev/sda8.  Priority:-1 extents:1 across:9783544k
[  468.252583] device eth0 entered promiscuous mode
[  468.261805] audit(1159405373.265:2): dev=eth0 prom=256 old_prom=0 auid=4294967295
[  527.250201] device eth0 left promiscuous mode
[  527.261023] audit(1159405432.384:3): dev=eth0 prom=0 old_prom=256 auid=4294967295

--wac7ysb48OaltWcw--
