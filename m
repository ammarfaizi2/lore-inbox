Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSEOBgG>; Tue, 14 May 2002 21:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316205AbSEOBgF>; Tue, 14 May 2002 21:36:05 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:39159 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S316204AbSEOBf4>;
	Tue, 14 May 2002 21:35:56 -0400
Message-ID: <3CE153A6.6020909@zianet.com>
Date: Tue, 14 May 2002 12:12:54 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, osb4-bug@ide.cabal.tm
Subject: Lost interrupts/freeze on Serverworks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error on a Dell PowerEdge 1650 server.  It has the 
serverworks SWC-SB7440-P01 chipset in it, and a Severworks CSB5 IDE 
chipset.  It happens when I try to copy information of the IDE cdrom 
drive.  I can mount the drive and browse the drive without any problems 
but once I try to copy or execute something on the drive it bombs.  This 
is on RedHat 7.3 with the stock updated kernel, 2.4.18smp-4.  I turned 
off the dma on the cdrom and it appeared to work good again.  I am going 
to just leave DMA off and be happy with it, but this still should not 
happen.  A copy of dmesg, and lsmod are attached for extra info as well. 
 Lemme know if more info is needed, I usually forget something important.


ide_dmaproc: chipset supported ide_dma_lastirq func only: 13
hda: lost interrupt
Serverworks OSB4 in impossible state.
Disable UDMA or if you are using a Seagate then try switching disk types
on this controller.  Please report this event to osb4-bug@ide.cabal.tm
OSB4: continuing might cause disk corruption

And then it pretty much freezes, but if I mash the keyboard a bit it 
pops out with this, I had to type this in so I hope it is all correct:

wait_on_irq, CPU 0:
irq1: 0 [ 0 0 ]
bh: 1 [ 0 1 ]
Stack dumps:
CPU 1: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
       00000000 01000000 00000020 00000400 00000000 c171a7e0 c171a6e0 
c171a760
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000

Call Trace:
CPU 0: c1737f28 c0241921 00000000 00000000 ffffffff 00000000 c010a372 
c0241936
       00000000 de30a000 00000001 c017ccd9 de30a168 c02f4444 c1737f74 
00000000
       c1736000 c01213fe de30a000 de30a130 c02f4444 c02eff20 00000000 
c0129e65

Call Trace: [<c010a372>] __global_cli [kernel] 0xe2
[<c017ccd9>] flush_to_ldisc [kernel] 0xd9
[<c01213fe>] __run_task_queue [kernel] 0x5e
[<c0129e65>] context_thread [kernel] 0x155
[<c0129d10>] context_thread [kernel] 0x0
[<c0105000>] stext [kernel] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<c0129d10>] context_thread [kernel] 0x0

Dmesg output:

Linux version 2.4.18-4smp (bhcompile@stripples.devel.redhat.com) (gcc 
version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu May 2 
18:32:34 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fffec00 (ACPI data)
 BIOS-e820: 000000001fffec00 - 000000001ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 011B      APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Processors: 2
Kernel command line: ro root=/dev/sda6
Initializing CPU#0
Detected 1130.497 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2254.43 BogoMIPS
Memory: 513380k/524224k available (1232k kernel code, 10460k reserved, 
842k data, 304k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
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
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.49 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2260.99 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Total of 2 processors activated (4515.43 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-3, 2-5, 2-7, 2-13 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 34.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  0    0    0   0   0    1    1    41
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    49
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  0    0    0   0   0    1    1    51
 09 003 03  0    0    0   0   0    1    1    59
 0a 003 03  0    0    0   0   0    1    1    61
 0b 003 03  1    1    0   1   0    1    1    69
 0c 003 03  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0E000000
.......     : arbitration: 0E
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 003 03  1    1    0   1   0    1    1    89
 01 003 03  1    1    0   1   0    1    1    91
 02 003 03  1    1    0   1   0    1    1    99
 03 003 03  1    1    0   1   0    1    1    A1
 04 003 03  1    1    0   1   0    1    1    A9
 05 003 03  1    1    0   1   0    1    1    B1
 06 003 03  1    1    0   1   0    1    1    B9
 07 003 03  1    1    0   1   0    1    1    C1
 08 003 03  1    1    0   1   0    1    1    C9
 09 003 03  1    1    0   1   0    1    1    D1
 0a 003 03  1    1    0   1   0    1    1    D9
 0b 003 03  1    1    0   1   0    1    1    E1
 0c 003 03  1    1    0   1   0    1    1    E9
 0d 003 03  1    1    0   1   0    1    1    32
 0e 003 03  1    1    0   1   0    1    1    3A
 0f 003 03  1    1    0   1   0    1    1    42
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
IRQ27 -> 1:11
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
IRQ31 -> 1:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1130.3715 MHz.
..... host bus clock speed is 132.9848 MHz.
cpu: 0, clocks: 1329848, slice: 443282
CPU0<T0:1329840,T1:886544,D:14,S:443282,C:1329848>
cpu: 1, clocks: 1329848, slice: 443282
CPU1<T0:1329840,T1:443264,D:12,S:443282,C:1329848>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfc6ce, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI->APIC IRQ transform: (B1,I2,P0) -> 17
PCI->APIC IRQ transform: (B1,I4,P0) -> 16
PCI->APIC IRQ transform: (B1,I6,P0) -> 18
PCI->APIC IRQ transform: (B1,I6,P1) -> 19
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 241k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: HITACHI   Model: DK32DJ-18MC       Rev: D4D4
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: PE/PV     Model: 1x3 SCSI BP       Rev: 0.26
  Type:   Processor                          ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 100, 16bit)
SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Journalled Block Device driver loaded
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 304k freed
Adding Swap: 1044216k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xe0911000, IRQ 11
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,6), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_conntrack (4095 buckets, 32760 max)

lsmod output:

Module                  Size  Used by    Not tainted

nls_iso8859-1           3488   1  (autoclean)
ide-cd                 30368   1  (autoclean)
cdrom                  32608   0  (autoclean) [ide-cd]
autofs                 12804   0  (autoclean) (unused)
ipchains               46184  12
usb-ohci               21600   0  (unused)
usbcore                77024   1  [usb-ohci]
ext3                   70752   5
jbd                    53664   5  [ext3]
aic7xxx               125440   6
sd_mod                 12896  12
scsi_mod              112272   2  [aic7xxx sd_mod]




