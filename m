Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbTCGThL>; Fri, 7 Mar 2003 14:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbTCGThK>; Fri, 7 Mar 2003 14:37:10 -0500
Received: from wildg.gotadsl.co.uk ([81.6.236.5]:45743 "EHLO
	xunil.mail.wildgooses.com") by vger.kernel.org with ESMTP
	id <S261746AbTCGTg6>; Fri, 7 Mar 2003 14:36:58 -0500
Message-ID: <3E68F616.3090602@Wildgooses.com>
Date: Fri, 07 Mar 2003 19:42:14 +0000
From: Ed Wildgoose <Ed@Wildgooses.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030302
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Interrupt problem, no USB on SMP machine with 2.4.19/20/21
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a dual intel P3 933Mhz machine with an EPOX EP-D3VA 
motherboard.  This has a via VT82C693A/694x [Apollo PRO133x] chipset

I cannot seem to get USB working at all on this machine.  I have tried 
2.4.19 20 and 21-ac (latest as of yesterday) with no luck.  Basically 
doing insmod usb-uhci generates errors in the log:

Mar  7 19:09:07 [kernel] usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
Mar  7 19:09:07 [kernel] usb.c: new USB bus registered, assigned bus 
number 1
Mar  7 19:09:07 [kernel] hub.c: USB hub found
Mar  7 19:09:07 [kernel] usb-uhci.c: v1.275:USB Universal Host 
Controller Interface driver
Mar  7 19:09:08 [kernel] hub.c: new USB device 00:07.2-1, assigned address 2
Mar  7 19:09:10 [/etc/hotplug/usb.agent] Setup usbcore for USB product 0/0/0
Mar  7 19:09:11 [/etc/hotplug/usb.agent] Setup usbcore for USB product 0/0/0
Mar  7 19:09:13 [kernel] usb_control/bulk_msg: timeout
Mar  7 19:09:13 [kernel] usb.c: USB device not accepting new address=2 
(error=-110)
Mar  7 19:09:13 [kernel] hub.c: new USB device 00:07.2-1, assigned address 3
Mar  7 19:09:18 [kernel] usb.c: USB device not accepting new address=3 
(error=-110)

And this is consistent across kernel versions, usb-uhci and uhci give 
similar messages.  This is using MPS 1.1 - with MPS 1.4 the IRQ is 19.

I'm assuming that the IRQ 9 is the problem and that the kernel is trying 
to assign IRQ 3?  I tried:
     setpci -s 00:07.2 INTERRUPT_LINE=3
Results of lspci -vx -s 00:07.2 are:

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 11) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 11 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 04 00 00

But I'm not sure what I am expecting to happen...?

I'm not very experienced at this so hints on how to debug further would 
be appreciated (What other information do I need to send?)

Output from dmesg is below, note this is the 2.4.21ac kernel with ACPI - 
other tests were done without ACPI or any power management with similar 
results:

Thanks

Linux version 2.4.21-pre5-ac2 (root@gentoo.wildgooses.com) (gcc version 
3.2.2) #1 SMP Fri Mar 7 07:50:43 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000f5a40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hda5
Initializing CPU#0
Detected 935.466 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1867.77 BogoMIPS
Memory: 514688k/524224k available (1607k kernel code, 9148k reserved, 
572k data, 148k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.35 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1867.77 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3735.55 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
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
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  0    0    0   0   0    1    1    51
 07 0FF 0F  0    0    0   0   0    1    1    59
 08 0FF 0F  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    1    69
 0d 0FF 0F  0    0    0   0   0    1    1    71
 0e 0FF 0F  0    0    0   0   0    1    1    79
 0f 0FF 0F  0    0    0   0   0    1    1    81
 10 0FF 0F  1    1    0   1   0    1    1    89
 11 0FF 0F  1    1    0   1   0    1    1    91
 12 0FF 0F  1    1    0   1   0    1    1    99
 13 0FF 0F  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:17
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:19
IRQ10 -> 0:18
IRQ11 -> 0:16
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 935.4640 MHz.
..... host bus clock speed is 133.6376 MHz.
cpu: 0, clocks: 1336376, slice: 445458
CPU0<T0:1336368,T1:890896,D:14,S:445458,C:1336376>
cpu: 1, clocks: 1336376, slice: 445458
CPU1<T0:1336368,T1:445440,D:12,S:445458,C:1336376>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb350, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:....................................................................................
84 Control Methods found and parsed (341 nodes total)
ACPI Namespace successfully loaded at root c03943c0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-20] Acpi_enable           : Transition to ACPI mode 
successful
Executing device _INI methods:...........................
27 Devices found: 27 _STA, 2 _INI
Completing Region and Field initialization:......................
16/20 Regions, 6/8 Fields initialized (341 nodes total)
ACPI: Subsystem enabled
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
HPT370A: IDE controller at PCI slot 00:0b.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
blk: queue c03c2cc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: RICOH DVD/CDRW MP9120, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63, 
UDMA(66)
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device ide0(3,5)): ext2_read_super: mounting ext3 
filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding Swap: 1044184k swap-space (priority -1)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.18-ac
 00:10:4b:b4:be:e3, IRQ 10
  product code 4e4b rev 00.9 date 06-19-98
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:0c.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.104 loaded
bttv: using 32 buffers with 2080k (66560k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 00:09.0, irq: 5, latency: 32, mmio: 0xdf001000
bttv0: detected: Leadtek WinFast TV 2000 [card=34], PCI subsystem ID is 
107d:6606
bttv0: using: BT878(Leadtek WinFast 2000/ W) [card=34,insmod option]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
i2c-core.o: client [Philips PAL_BG (FI1216 and compa] registered to 
adapter [bt848 #0](pos. 0).
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
SCSI subsystem driver Revision: 1.00
hdc: attached ide-cdrom driver.
hdc: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
usb-uhci.c: $Revision: 1.275 $ time 08:29:13 Mar  7 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:07.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:07.2-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
usb.c: USB disconnect on device 00:07.2-0 address 1
usb.c: USB bus 1 deregistered
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: new USB device 00:07.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:07.2-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
usb.c: USB disconnect on device 00:07.2-0 address 1
usb.c: USB bus 1 deregistered
usb-uhci.c: $Revision: 1.275 $ time 08:29:13 Mar  7 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:07.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:07.2-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)




