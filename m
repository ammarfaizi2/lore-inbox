Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVBUIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVBUIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVBUIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:45:25 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:1244 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261924AbVBUInT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:43:19 -0500
Message-ID: <42199F22.8070407@candelatech.com>
Date: Mon, 21 Feb 2005 00:43:14 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Panic in 2.6.11-rc4
References: <4218E251.1010000@candelatech.com> <20050220220627.487a2fc7.akpm@osdl.org>
In-Reply-To: <20050220220627.487a2fc7.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000502000804070105000801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502000804070105000801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Ben Greear <greearb@candelatech.com> wrote:
> 
>> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
>> SCSI device sda: drive cache: write back
>> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
>> SCSI device sda: drive cache: write back
>>   sda: sda1 sda2 sda3
>> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>> Unable to handle kernel paging request at virtual address e09a68e8
>>   printing eip:
>> c014976e
>> *pde = 0151f067
>> Oops: 0000 [#1]
>> PREEMPT SMP
>> Modules linked in: ext3 jbd ata_piix libata sd_mod scsi_mod
>> CPU:    1
>> EIP:    0060:[<c014976e>]    Not tainted VLI
>> EFLAGS: 00010006   (2.6.11-rc4)
>> EIP is at cache_alloc_refill+0x20e/0x240
> 
> 
> I assume something has wrecked the slab caches.  Please enable
> CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.

Being in a rush, I had to return this system for a replacement
system.  Since this machine also had issues saving it's BIOS
settings, the problem may be hardware related.  (We did replace
the RAM but that did NOT fix the BIOS problem, at least...)

Continuing a bad weekend, the replacment system (Shuttle SB61G2) with
same CPU, HD, CDROM, floppy and the new stick of RAM, also had issues.
It did boot the various 2.6 kernels without problem, but when I put a 4-port tulip (DFE570tx)
NIC in the system, and started traffic on all four ports, the system locked up
within about 5 seconds.  Interestingly, with HT enabled, I would get partial
freeze for a bit, and then total freeze.  I assume one of the virtual CPUs was
locked and the other one managed to run a bit longer untill it also hit a deadlock.
With HT disabled, when it locked, it locked completely at once.  With HT, often
the mouse worked much longer than the keyboard.  I assume some problem with
interrupts.  Booting with noapic didn't help.

I tried 3 different 4-port tulip NICs (two different manufacturers), same behaviour.

In a final bit of desperation, I installed RedHat 9 with a custom 2.4.27
kernel.  Wouldn't you know it:  The system has been rock solid ever since.


This system will probably be shipped out on Monday, so I can't offer much
debugging info here either.  I am attaching the lspci and dmesg output
(from the 2.4.27 kernel, RedHat 9 install) in case someone else hits similar
problems and a pattern emerges...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


--------------000502000804070105000801
Content-Type: text/plain;
 name="sb61g2.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb61g2.dmesg"

ACPI: RSDP (v000 XPC                                       ) @ 0x000f6ea0
ACPI: RSDT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f3000
ACPI: FADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f3040
ACPI: MADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f6b80
ACPI: DSDT (v001 XPC        SB61 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Unknown CPU [15:4] APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 Unknown CPU [15:4] APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 3007.273 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5947.39 BogoMIPS
Memory: 506924k/516032k available (1417k kernel code, 8720k reserved, 523k data, 156k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
per-CPU timeslice cutoff: 2925.19 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5996.54 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Total of 2 processors activated (11943.93 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-3, 2-5, 2-9, 2-10, 2-11 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 27.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  0    0    0   0   0    1    1    41
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    49
 07 003 03  0    0    0   0   0    1    1    51
 08 003 03  0    0    0   0   0    1    1    59
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    61
 0d 003 03  0    0    0   0   0    1    1    69
 0e 003 03  0    0    0   0   0    1    1    71
 0f 003 03  0    0    0   0   0    1    1    79
 10 003 03  1    1    0   1   0    1    1    81
 11 003 03  1    1    0   1   0    1    1    89
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 003 03  1    1    0   1   0    1    1    A1
 15 003 03  1    1    0   1   0    1    1    A9
 16 003 03  1    1    0   1   0    1    1    B1
 17 003 03  1    1    0   1   0    1    1    B9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3006.0468 MHz.
..... host bus clock speed is 200.0431 MHz.
cpu: 0, clocks: 200431, slice: 66810
CPU0<T0:200416,T1:133600,D:6,S:66810,C:200431>
cpu: 1, clocks: 200431, slice: 66810
CPU1<T0:200416,T1:66784,D:12,S:66810,C:200431>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.2
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I6,P0) -> 18
PCI->APIC IRQ transform: (B1,I8,P0) -> 20
PCI->APIC IRQ transform: (B2,I4,P0) -> 19
PCI->APIC IRQ transform: (B2,I5,P0) -> 20
PCI->APIC IRQ transform: (B2,I6,P0) -> 21
PCI->APIC IRQ transform: (B2,I7,P0) -> 22
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380817AS, ATA DISK drive
blk: queue c0353a60, I/O limit 4095Mb (mask 0xffffffff)
hdc: CRW-5232AS, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 147k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 156k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
ehci_hcd 00:1d.7: irq 23, pci mem e004e000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 00:1d.7
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 8 ports detected
usb-uhci.c: $Revision: 1.275 $ time 15:30:12 Oct 14 2004
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
usb-uhci.c: USB UHCI at I/O 0xbc00, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1044216k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[fc111000-fc1117ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00301bb6000004bf]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor:           Model: CRW-5232AS        Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xe0155000, 00:30:1b:b6:04:5b, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
divert: allocating divert_blk for eth1
eth1: Digital DS21143 Tulip rev 65 at 0xe0163000, 00:80:C8:B9:1E:45, IRQ 19.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
divert: allocating divert_blk for eth2
eth2: Digital DS21143 Tulip rev 65 at 0xe0165000, 00:80:C8:B9:1E:46, IRQ 20.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
divert: allocating divert_blk for eth3
eth3: Digital DS21143 Tulip rev 65 at 0xe0167000, 00:80:C8:B9:1E:47, IRQ 21.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
divert: allocating divert_blk for eth4
eth4: Digital DS21143 Tulip rev 65 at 0xe0169000, 00:80:C8:B9:1E:48, IRQ 22.
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
lp0: console ready
pktgen.c: v1.9.2 (nospin): Packet Generator for packet performance testing.
pktgen: cycles_calibrate, cycles_per_ns: 3  per_us: 3006  per_ms: 3006000
Initializing WanLink module, version 4.1.9
Copyright 2003-2004 Candela Technologies <support@candelatech.com>
wl_nr_cpus: 1  initial_wlp_cache: 10000  debug_lvl: 0 HZ: 1000
WanLink: cycles_calibrated, cycles_per_ns: 3  per_us: 3006  per_ms: 3006000
wanlink:  Recorder thread: kwanrec_d0 (0) starting.
wanlink:  Recorder thread: kwanrec_d1 (0) starting.
WanLink: Created writer thread, tid: 4056
WanLink: Created record thread[0], record_tid: 4057
WanLink: Created record thread[1], record_tid: 4058
MAC address based VLAN support Revision: 1.3
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth2: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth3: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth4: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth2: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth3: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth4: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth3: Promiscuous mode enabled.
device eth3 entered promiscuous mode
eth4: Promiscuous mode enabled.
device eth4 entered promiscuous mode
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth2: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth3: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth4: Setting full-duplex based on MII#1 link partner capability of 41e1.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected an Intel(R) 865G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000

--------------000502000804070105000801
Content-Type: text/plain;
 name="sb61g2.lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb61g2.lspci"

00:00.0 Host bridge: Intel Corp. 82865G [Springdale-G] Chipset Host Bridge (rev 02)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [0106]

00:02.0 VGA compatible controller: Intel Corp. 82865G [Springdale-G] Chipset Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at fc200000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at c000 [size=8]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at b000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at b400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at b800 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB EHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at bc00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at fc280000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: fc000000-fc1fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus (rev 02)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb61
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio (rev 02)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device c09d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=64]
	Region 2: Memory at fc281000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at fc282000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at fc110000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fc000000-fc0fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fc111000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at a400 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 9000 [size=128]
	Region 1: Memory at fc040000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at 9400 [size=128]
	Region 1: Memory at fc041000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at 9800 [size=128]
	Region 1: Memory at fc042000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 9c00 [size=128]
	Region 1: Memory at fc043000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]


--------------000502000804070105000801--
