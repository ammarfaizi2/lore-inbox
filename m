Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbTGPPOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbTGPPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:14:34 -0400
Received: from izanami.macs.hw.ac.uk ([137.195.13.6]:40911 "EHLO
	izanami.macs.hw.ac.uk") by vger.kernel.org with ESMTP
	id S270926AbTGPPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:14:24 -0400
From: Ross Macintyre <raz@macs.hw.ac.uk>
To: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com
Cc: salvini@macs.hw.ac.uk, donald@macs.hw.ac.uk
Message-ID: <SIMEON.10307161613.A@pcraz.macs.hw.ac.uk>
Date: Wed, 16 Jul 2003 16:29:13 +0100 (GMT Daylight Time)
X-Mailer: Simeon for Win32 Version 4.1.4 Build (40)
X-Authentication: none
MIME-Version: 1.0
Subject: new raid server crashed - no idea why!
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just configured a new server to run Redhat 8.0 and it was dead on 
arrival this morning - wouldn't respond to pings. It has all the latest 
RedHat 8.0 software and the latest raid drivers from LSILogic.
The spec of the machine is dual processor - AMD MP 2400+ with
LSILogic MegaRAID 320-2, and adaptec ultra wide scsi.

I have a similar machine that I want to bring online but before I do I 
want to know if I'm doing anything wrong in its setup. This is my first 
experience of RAID.

I really need to know how to interpret what's in /var/log/messages.
I have included the relevant part of /var/log/messages and I hope that 
someone can spot what's going wrong. If someone can point me at useful 
information on interpreting this data I'd be most grateful. 
(I'll also include the output of 'dmesg' at the end so you can see 
what's happening at boot time, and also cause I am wondering what these 
meant:
  BIOS failed to enable PCI standards compliance, fixing this error.
  mtrr: your CPUs had inconsistent fixed MTRR settings
  mtrr: probably your BIOS does not setup all CPUs)

Anyway here's the bit in messages that shows things going wrong:

################## /var/log/messages ########################
Jul 15 23:14:44 shakti kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000078
Jul 15 23:14:44 shakti kernel:  printing eip:
Jul 15 23:14:44 shakti kernel: c0148519
Jul 15 23:14:44 shakti kernel: *pde = 00000000
Jul 15 23:14:44 shakti kernel: Oops: 0000
Jul 15 23:14:44 shakti kernel: nfs nfsd lockd sunrpc autofs4 3c59x iptable_filte
r ip_tables mousedev keybdev hid input usb-ohci usbcore ext3 jbd megaraid aic7xx
x sd_mod scsi_mod  
Jul 15 23:14:44 shakti kernel: CPU:    1
Jul 15 23:14:44 shakti kernel: EIP:    0010:[<c0148519>]    Not tainted
Jul 15 23:14:44 shakti kernel: EFLAGS: 00010246
Jul 15 23:14:44 shakti kernel: 
Jul 15 23:14:44 shakti kernel: EIP is at page_referenced [kernel] 0xe9 (2.4.20-1
8.8smp)
Jul 15 23:14:44 shakti kernel: eax: c1000030   ebx: c1000030   ecx: 00000000   e
dx: 00000000
Jul 15 23:14:44 shakti kernel: esi: c1000030   edi: 00000000   ebp: 000001d0   e
sp: c2c2df60
Jul 15 23:14:44 shakti kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 23:14:44 shakti kernel: Process kswapd (pid: 5, stackpage=c2c2d000)
Jul 15 23:14:44 shakti kernel: Stack: 00000282 00000003 d15717e0 d15717e0 000000
00 00000000 c2c2dfa0 c101da38 
Jul 15 23:14:44 shakti kernel:        c101da38 c101da54 c032d780 000001d0 c013f6
12 c100f808 000001d0 00000100 
Jul 15 23:14:44 shakti kernel:        00000001 0000001c c032d780 c032e138 000000
23 c0140b3f c032d780 000001d0 
Jul 15 23:14:44 shakti kernel: Call Trace:   [<c013f612>] launder_page [kernel] 
0x1c2 (0xc2c2df90))
Jul 15 23:14:44 shakti kernel: [<c0140b3f>] rebalance_dirty_zone [kernel] 0x8f (
0xc2c2dfb4))
Jul 15 23:14:44 shakti kernel: [<c0141130>] kswapd [kernel] 0x140 (0xc2c2dfd4))
Jul 15 23:14:44 shakti kernel: [<c0105000>] stext [kernel] 0x0 (0xc2c2dfec))
Jul 15 23:14:44 shakti kernel: [<c01073ce>] arch_kernel_thread [kernel] 0x2e (0x
c2c2dff0))
Jul 15 23:14:44 shakti kernel: [<c0140ff0>] kswapd [kernel] 0x0 (0xc2c2dff8))
Jul 15 23:14:44 shakti kernel: 
Jul 15 23:14:44 shakti kernel: 
Jul 15 23:14:44 shakti kernel: Code: 8b 41 78 39 41 64 b8 01 00 00 00 0f 43 44 2
4 10 89 44 24 10 
################## end of /var/log/messages ########################

################## output of dmesg ########################
Linux version 2.4.20-18.8smp (bhcompile@daffy.perf.redhat.com) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Thu May 29 06:52:54 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007fef6000 (ACPI data)
 BIOS-e820: 000000007fef6000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7110
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524160
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294784 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Kernel command line: auto BOOT_IMAGE=2.4.20-18.athln ro BOOT_FILE=/boot/vmlinuz-2.4.20-18.8smp root=/dev/sda1
Initializing CPU#0
Detected 2000.127 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 2059600k/2096640k available (1429k kernel code, 32364k reserved, 1065k data, 156k init, 1179072k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 2400+ stepping 01
per-CPU timeslice cutoff: 731.38 usecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 01
Total of 2 processors activated (7982.28 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
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
 02 0FF 0F  0    0    0   0   0    1    1    31
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.1839 MHz.
..... host bus clock speed is 266.6912 MHz.
cpu: 0, clocks: 2666912, slice: 888970
CPU0<T0:2666912,T1:1777936,D:6,S:888970,C:2666912>
cpu: 1, clocks: 2666912, slice: 888970
CPU1<T0:2666912,T1:888960,D:12,S:888970,C:2666912>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd790, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P1) -> 17
PCI->APIC IRQ transform: (B2,I0,P3) -> 19
PCI->APIC IRQ transform: (B2,I8,P0) -> 18
PCI->APIC IRQ transform: (B2,I9,P0) -> 19
BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: CD-956E/AKV, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 272k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c4691618, I/O limit 4095Mb (mask 0xffffffff)
megaraid: v1.18h (Release Date: Thu Feb  6 17:25:43 EST 2003)
megaraid: found 0x1000:0x1960:idx 0:bus 0:slot 8:func 0
scsi2 : Found a MegaRAID controller at 0xf885e000, IRQ: 16
scsi2 : Enabling 64 bit support
megaraid: [1L24:G110] detected 1 logical drives
megaraid: supports extended CDBs.
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
scsi2 : LSI Logic MegaRAID 1L24 254 commands 15 targs 5 chans 7 luns
blk: queue c467a818, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning virtual channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 80091R  Rev: 1L24
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c467aa18, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning virtual channel 1 for logical drives.
scsi2: scanning virtual channel 2 for logical drives.
scsi2: scanning physical channel 0 for devices.
scsi2: scanning physical channel 1 for devices.
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sda: 2007226368 512-byte hdwr sectors (1027700 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 >
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 156k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf889f000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
Adding Swap: 4819492k swap-space (priority -1)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:08.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x2400. Vers LK1.1.18-ac
 00:e0:81:24:26:d4, IRQ 18
  product code 0000 rev 00.6 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
02:08.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
See Documentation/networking/vortex.txt
02:09.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x2480. Vers LK1.1.18-ac
 00:e0:81:24:26:d5, IRQ 19
  product code 0000 rev 00.6 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
02:09.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
################## end of output of dmesg ########################
--
Ross Macintyre
Heriot-Watt University
raz@macs.hw.ac.uk


