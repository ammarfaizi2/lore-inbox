Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314146AbSDZT7L>; Fri, 26 Apr 2002 15:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSDZT7K>; Fri, 26 Apr 2002 15:59:10 -0400
Received: from web14307.mail.yahoo.com ([216.136.173.83]:34568 "HELO
	web14307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314146AbSDZT7G>; Fri, 26 Apr 2002 15:59:06 -0400
Message-ID: <20020426195905.3670.qmail@web14307.mail.yahoo.com>
Date: Fri, 26 Apr 2002 20:59:05 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Spiller?= <chrissyspill@yahoo.co.uk>
Subject: kernel panic while trying to mount cd (2.5.10)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Everytime I try to mount a cd in my ide cd drive under
2.5.10, the kernel panics, I have a SCSI writer which
behaves fine, here is the oops message, ksymoops
output and I've also put my dmesg below.

Has anyone else experienced this problem?

Cheers,

Chris

[root@boo root]# mount /dev/hdc /mnt/cdrom
mount: block device /dev/scd0 is write-protected,
mounting read-only

Unable to handle kernel NULL pointer dereference at
virtual address 00000008
*pde = 00000000
Oops:   0002
CPU:    0
EIP:    0010:[<c02172a87>] Not tainted
EFLAGS: 00010002
eax: 00000004 ebx: caf5db5c ecx: 000000e7 edx:
00000001
esi: caf5dac4 edi: c03e5d8c ebp: 00000282 esp:
c0339ea4
ds: 0018 es: 0018 ss:0018
Process swapper (pid:0, threadinfo=c0338000
task=c0319280)
Stack: 
00000001 caf5db5c caf5dac4 c03e5d8c 00000001 c021b311
c03e5d8c 00000001
00000000 c0223a6a c03e5d8c 00000001 caf5da94 00000000
caf5dac4  caf5db5c
c0338000 c022462b c0339f04 c03e5d8c 00000000 c0339f08
0000000f c0218b63

Call Trace: [<c021b311>] [<c0223a6a>] [<c022462b>]
[<c0218b63>]
[<c0219122>] [<c0224600>] [<c0109a3e>] [<c0109c95>]
[<c0105330>]
[<c0107dce>] [<c0105330>] [<c0105330>] [<c010535a>]
[<c0105402>]
[<c0105000>]

Code: c7 04 90 00 00 00 00 8b 53 0c 8b 87 34 02 00 00
0f b3 10 8b

<0>Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing

ksymoops output
---------------
 ksymoops 2.4.3 on i686 2.5.10.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.5.10/ (specified)
     -m /boot/System.map-2.5.10 (specified)

Unable to handle kernel NULL pointer dereference at
virtual address 00000008
*pde = 00000000
Oops:   0002
CPU:    0
EIP:    0010:[<c02172a87>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000004 ebx: caf5db5c ecx: 000000e7 edx:
00000001
esi: caf5dac4 edi: c03e5d8c ebp: 00000282 esp:
c0339ea4
ds: 0018 es: 0018 ss:0018
Stack: 
00000001 caf5db5c caf5dac4 c03e5d8c 00000001 c021b311
c03e5d8c 00000001
00000000 c0223a6a c03e5d8c 00000001 caf5da94 00000000
caf5dac4  caf5db5c
c0338000 c022462b c0339f04 c03e5d8c 00000000 c0339f08
0000000f c0218b63
Call Trace: [<c021b311>] [<c0223a6a>] [<c022462b>]
[<c0218b63>]
[<c0219122>] [<c0224600>] [<c0109a3e>] [<c0109c95>]
[<c0105330>]
[<c0107dce>] [<c0105330>] [<c0105330>] [<c010535a>]
[<c0105402>]
[<c0105000>]
Code: c7 04 90 00 00 00 00 8b 53 0c 8b 87 34 02 00 00
0f b3 10 8b

>>EIP; c02172a86 <END_OF_CODE+b318dd508/????>   <=====
Trace; c021b310 <ide_end_request+10/20>
Trace; c0223a6a <cdrom_decode_status+12a/240>
Trace; c022462a <cdrom_pc_intr+2a/1e0>
Trace; c0218b62 <ide_do_request+72/80>
Trace; c0219122 <ide_intr+102/1c0>
Trace; c0224600 <cdrom_pc_intr+0/1e0>
Trace; c0109a3e <handle_IRQ_event+5e/90>
Trace; c0109c94 <do_IRQ+b4/130>
Trace; c0105330 <default_idle+0/40>
Trace; c0107dce <common_interrupt+22/28>
Trace; c0105330 <default_idle+0/40>
Trace; c0105330 <default_idle+0/40>
Trace; c010535a <default_idle+2a/40>
Trace; c0105402 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  02172a86 Before first symbol
00000000 <_EIP>:
Code;  02172a86 Before first symbol
   0:   c7 04 90 00 00 00 00      movl  
$0x0,(%eax,%edx,4)
Code;  02172a8c Before first symbol
   7:   8b 53 0c                  mov   
0xc(%ebx),%edx
Code;  02172a90 Before first symbol
   a:   8b 87 34 02 00 00         mov   
0x234(%edi),%eax
Code;  02172a96 Before first symbol
  10:   0f b3 10                  btr    %edx,(%eax)
Code;  02172a98 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

<0>Kernel panic: Aiee, killing interrupt handler!

I've also had a bit of a play in gdb

[root@boo root]# gdb /usr/src/linux/vmlinux
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General
Public License, and you are
welcome to change it and/or distribute copies of it
under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show
warranty" for details.
This GDB was configured as "i386-mandrake-linux"...
(no debugging symbols found)...
(gdb) disassemble ide_end_request
Dump of assembler code for function ide_end_request:
0xc021b300 <ide_end_request>:   push   $0x0
0xc021b302 <ide_end_request+2>: mov   
0xc(%esp,1),%ecx
0xc021b306 <ide_end_request+6>: push   %ecx
0xc021b307 <ide_end_request+7>: mov   
0xc(%esp,1),%edx
0xc021b30b <ide_end_request+11>:        push   %edx
0xc021b30c <ide_end_request+12>:        call  
0xc0217190 <__ide_end_request>
0xc021b311 <ide_end_request+17>:        add   
$0xc,%esp
0xc021b314 <ide_end_request+20>:        ret    
0xc021b315 <ide_end_request+21>:        lea   
0x0(%esi,1),%esi
0xc021b319 <ide_end_request+25>:        lea   
0x0(%edi,1),%edi
End of assembler dump.
(gdb)

This is the disassembly of Code:

[root@boo chris]# gdb a.out
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General
Public License, and you are
welcome to change it and/or distribute copies of it
under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show
warranty" for details.
This GDB was configured as "i386-mandrake-linux"...
(gdb) disassemble str
Dump of assembler code for function str:
0x8049458 <str>:        movl   $0x0,(%eax,%edx,4)
0x804945f <str+7>:      mov    0xc(%ebx),%edx
0x8049462 <str+10>:     mov    0x234(%edi),%eax
0x8049468 <str+16>:     btr    %edx,(%eax)
0x804946b <str+19>:     mov    (%eax),%eax
0x804946d <str+21>:     add    %al,(%eax)
0x804946f <str+23>:     add    %al,(%eax)
End of assembler dump.
(gdb) 

dmesg output
------------
Linux version 2.5.10 (root@boo.house.org) (gcc version
2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1
SMP Fri Apr 26 17:50:16 BST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000
(usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI
NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI
data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000
(reserved)
255MB LOWMEM available.
found SMP MP-table at 000f5700
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at:
0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=linux-2.5.10 ro
root=341
Initializing CPU#0
Detected 998.375 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 256304k/262080k available (1780k kernel code,
5388k reserved, 485k data, 276k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6,
262144 bytes)
Inode-cache hash table entries: 16384 (order: 5,
131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer-cache hash table entries: 16384 (order: 4,
65536 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000
00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000
00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.97 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1992.29 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000
00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3984.58 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20,
2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 002 02  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 003 03  1    1    0   1   0    1    1    A1
 13 003 03  1    1    0   1   0    1    1    A9
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
IRQ9 -> 0:9
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
..... CPU clock speed is 998.3213 MHz.
..... host bus clock speed is 133.1091 MHz.
cpu: 0, clocks: 1331091, slice: 443697
CPU0<T0:1331088,T1:887376,D:15,S:443697,C:1331091>
cpu: 1, clocks: 1331091, slice: 443697
CPU1<T0:1331088,T1:443680,D:14,S:443697,C:1331091>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR
settings
mtrr: probably your BIOS does not setup all CPUs
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 5 to 3
PCI: Via IRQ fixup for 00:07.3, from 5 to 3
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at
0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0,
dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by
driver
usb.c: registered new driver usbfs
usb.c: registered new driver hub
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
devfs: v1.13 (20020406) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
203M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] Initialized r128 2.1.6 20010405 on minor 0
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: IDE controller
on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset
revision 6
VIA Technologies, Inc. Bus Master IDE: not 100% native
mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller
on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings:
hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings:
hdc:DMA, hdd:pio
Triones Technologies, Inc. HPT366 / HPT370: IDE
controller on PCI slot 00:0e.0
Triones Technologies, Inc. HPT366 / HPT370: chipset
revision 4
Triones Technologies, Inc. HPT366 / HPT370: not 100%
native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings:
hde:pio, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings:
hdg:pio, hdh:pio
hda: ST320423A, ATA DISK drive
hdb: ST34313A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI
CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: 40011300 sectors (20486 MB) w/512KiB Cache,
CHS=39693/16/63, UDMA(66)
ide: unexpected interrupt 0 14
hdb: 8405775 sectors (4304 MB) w/512KiB Cache,
CHS=8895/15/63, UDMA(66)
ide: unexpected interrupt 1 15
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector
size, 2941 rpm
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL]
[2490/255/63] p1 p4 < p5 >
 /dev/ide/host0/bus0/target1/lun0: [PTBL] [555/240/63]
p1 p2
ide-floppy driver 0.99
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 10 function
0 irq 17
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20,
Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI
revision: 04
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6,
lun 0
sym53c875-0-<6,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns,
offset 15)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2
cdda tray
usb.c: registered new driver usblp
printer.c: v0.12: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb.c: registered new driver usbscanner
scanner.c: 0.4.6:USB Scanner Driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind
16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly
filesystem.
EXT3-fs: write access will be enabled during recovery.
(recovery.c, 252): journal_recover: JBD: recovery,
exit status 0, recovered transactions 20984 to 21010
(recovery.c, 255): journal_recover: JBD: Replayed 1320
and revoked 0/2 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,65),
internal journal
Adding Swap: 309476k swap-space (priority -1)
scsi1 : SCSI host adapter emulation for IDE ATAPI
devices
Linux Tulip driver version 1.1.12 (Mar 07, 2002)
eth0: ADMtek Comet rev 17 at 0xac00,
00:04:E2:23:72:94, IRQ 16.
8139too Fast Ethernet driver 0.9.24
eth1: RealTek RTL8139 Fast Ethernet at 0xd085c000,
00:40:f4:41:86:94, IRQ 19
eth1:  Identified 8139 chip type 'RTL-8139C'
usb-uhci.c: $Revision: 1.275 $ time 17:55:11 Apr 26
2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 19
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 19
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller
Interface driver


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
