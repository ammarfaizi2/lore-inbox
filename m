Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTLORQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTLORQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:16:34 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:53120 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263695AbTLORQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:16:22 -0500
Date: Mon, 15 Dec 2003 18:16:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Miroslaw KLABA <totoro@totoro.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Double Interrupt with HT
Message-ID: <20031215171620.GA10252@MAIL.13thfloor.at>
Mail-Followup-To: Miroslaw KLABA <totoro@totoro.be>,
	linux-kernel@vger.kernel.org
References: <20031215155843.210107b6.totoro@totoro.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031215155843.210107b6.totoro@totoro.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 03:58:43PM +0100, Miroslaw KLABA wrote:
> Hello,
> 
> I've got a problem while using Hyper-Threading on a motherboard with Via P4M266A
> chipset with 2.4.23 kernel.
> Without SMP enabled, I've got no problem with this chip, but when I enable SMP, the
> clock runs twice the speed, and interrupts are handled by both virtual CPUs, instead of
> the first one, like on other servers I run.
> I haven't got this problem with other chips but with this Via chip. There is no special thing
> in dmesg.
> Have you an idea from what the problem comes? I haven't found any patch for this type
> of problem.

hmm, you could try 

 # echo "1" >/proc/irq/0/smp_affinity

which should stop the second 'cpu' from
handling the timer interrupts ...

but this doesn't explain the 2x clock,
which probably is some bug ...

HTH,
Herbert

> Thanks
> Miro
> 
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       
>   0:     675819     675759    IO-APIC-edge  timer
>   1:         60         60    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:         16         16    IO-APIC-edge  serial
>   8:          1          1    IO-APIC-edge  rtc
>  14:       5859       5859    IO-APIC-edge  ide0
>  23:     248484     134979   IO-APIC-level  eth0
> NMI:          0          0 
> LOC:     675742     675741 
> ERR:          0
> MIS:          0
> 
> #dmesg
> Linux version 2.4.23 (root@xxx) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP lun déc 1 21:52:33 CET 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
>  BIOS-e820: 000000001dff0000 - 000000001dff3000 (ACPI NVS)
>  BIOS-e820: 000000001dff3000 - 000000001e000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 479MB LOWMEM available.
> found SMP MP-table at 000f5410
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f0000 reserved twice.
> hm, page 000f1000 reserved twice.
> On node 0 totalpages: 122864
> zone(0): 4096 pages.
> zone(1): 118768 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v000 VIAP4X                                    ) @ 0x000f6dc0
> ACPI: RSDT (v001 VIAP4X AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3000
> ACPI: FADT (v001 VIAP4X AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3040
> ACPI: MADT (v001 VIAP4X AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff6d80
> ACPI: DSDT (v001 VIAP4X AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
> Using ACPI for processor (LAPIC) configuration information
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> I/O APIC #2 Version 17 at 0xFEC00000.
> Enabling APIC mode: Flat.       Using 1 I/O APICs
> Processors: 2
> Kernel command line: auto BOOT_IMAGE=linux-bi ro root=301 BOOT_FILE=/boot/bzImage-2.4.23-bipiv nousb
> Initializing CPU#0
> Detected 3064.187 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 6107.95 BogoMIPS
> Memory: 482512k/491456k available (1536k kernel code, 8560k reserved, 386k data, 304k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> CPU:             Common caps: bfebfbff 00000000 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> CPU:             Common caps: bfebfbff 00000000 00000000 00000000
> CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
> per-CPU timeslice cutoff: 1462.76 usecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 6121.06 BogoMIPS
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check reporting enabled on CPU#1.
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> CPU:             Common caps: bfebfbff 00000000 00000000 00000000
> CPU1: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
> Total of 2 processors activated (12229.01 BogoMIPS).
> cpu_sibling_map[0] = 1
> cpu_sibling_map[1] = 0
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-5, 2-7, 2-12, 2-17, 2-18, 2-20 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> number of MP IRQ sources: 21.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178003
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0003
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 000 00  1    0    0   0   0    0    0    00
>  01 003 03  0    0    0   0   0    1    1    39
>  02 003 03  0    0    0   0   0    1    1    31
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 003 03  0    0    0   0   0    1    1    51
>  07 000 00  1    0    0   0   0    0    0    00
>  08 003 03  0    0    0   0   0    1    1    59
>  09 003 03  0    0    0   0   0    1    1    61
>  0a 003 03  0    0    0   0   0    1    1    69
>  0b 003 03  1    1    0   1   0    1    1    71
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 003 03  0    0    0   0   0    1    1    79
>  0e 003 03  0    0    0   0   0    1    1    81
>  0f 003 03  0    0    0   0   0    1    1    89
>  10 003 03  1    1    0   1   0    1    1    91
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 003 03  1    1    0   1   0    1    1    99
>  14 000 00  1    0    0   0   0    0    0    00
>  15 003 03  1    1    0   1   0    1    1    A1
>  16 003 03  1    1    0   1   0    1    1    A9
>  17 003 03  1    1    0   1   0    1    1    B1
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ6 -> 0:6
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ19 -> 0:19
> IRQ21 -> 0:21
> IRQ22 -> 0:22
> IRQ23 -> 0:23
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 3064.1412 MHz.
> ..... host bus clock speed is 133.2235 MHz.
> cpu: 0, clocks: 1332235, slice: 444078
> CPU0<T0:1332224,T1:888144,D:2,S:444078,C:1332235>
> cpu: 1, clocks: 1332235, slice: 444078
> CPU1<T0:1332224,T1:444064,D:4,S:444078,C:1332235>
> checking TSC synchronization across CPUs: passed.
> Waiting on wait_init_idle (map = 0x2)
> All processors have done init_idle
> PCI: PCI BIOS revision 2.10 entry at 0xfb510, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router VIA [1106/3177] at 00:11.0
> PCI->APIC IRQ transform: (B0,I16,P0) -> 21
> PCI->APIC IRQ transform: (B0,I16,P1) -> 21
> PCI->APIC IRQ transform: (B0,I16,P2) -> 21
> PCI->APIC IRQ transform: (B0,I16,P3) -> 19
> PCI->APIC IRQ transform: (B0,I17,P0) -> 11
> PCI->APIC IRQ transform: (B0,I17,P2) -> 22
> PCI->APIC IRQ transform: (B0,I18,P0) -> 23
> PCI->APIC IRQ transform: (B1,I0,P0) -> 16
> PCI: Via IRQ fixup for 00:10.0, from 11 to 5
> PCI: Via IRQ fixup for 00:10.1, from 7 to 5
> PCI: Via IRQ fixup for 00:10.2, from 12 to 5
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> Real Time Clock Driver v1.10e
> Software Watchdog Timer: 0.05, timer margin: 60 sec
> Floppy drive(s): fd0 is 1.44M
> reset set in interrupt, calling c01a4bf0
> floppy0: no floppy controllers found
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
> Copyright (c) 1999-2003 Intel Corporation.
> via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth0: VIA VT6102 Rhine-II at 0xe800, 00:0d:87:5e:d3:b9, IRQ 23.
> eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 40a1.
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
>     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
> hda: IC35L060AVV207-0, ATA DISK drive
> blk: queue c038af60, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 80418240 sectors (41174 MB) w/1821KiB Cache, CHS=5005/255/63, UDMA(100)
> Partition check:
>  hda: hda1 hda2 hda3
> SCSI subsystem driver Revision: 1.00
> md: linear personality registered as nr 1
> md: raid0 personality registered as nr 2
> md: raid1 personality registered as nr 3
> md: raid5 personality registered as nr 4
> raid5: measuring checksumming speed
>    8regs     :  3566.400 MB/sec
>    32regs    :  2193.200 MB/sec
>    pIII_sse  :  3942.400 MB/sec
>    pII_mmx   :  3625.600 MB/sec
>    p5_mmx    :  3546.000 MB/sec
> raid5: using function: pIII_sse (3942.400 MB/sec)
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> Initializing Cryptographic API
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> IPv4 over IPv4 tunneling driver
> ip_conntrack version 2.1 (3839 buckets, 30712 max) - 292 bytes per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 304k freed
> Adding Swap: 522104k swap-space (priority -1)
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
