Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSKIPKs>; Sat, 9 Nov 2002 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265914AbSKIPKs>; Sat, 9 Nov 2002 10:10:48 -0500
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:4111 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S265939AbSKIPKo>; Sat, 9 Nov 2002 10:10:44 -0500
Date: Sat, 9 Nov 2002 16:21:44 +0100
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Kernel Bug at drivers/ide/ide-cd.c: 860!
Message-ID: <20021109152144.GB358@gouv>
References: <20021103080514.GC748@gouv> <20021103094306.GK3612@suse.de> <20021104233831.GA510@gouv> <20021105070414.GQ29449@suse.de> <20021105161720.GA4968@gouv> <20021105174540.GA3515@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105174540.GA3515@suse.de>
User-Agent: Mutt/1.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 06:45:40PM +0100, Jens Axboe wrote:
> On Tue, Nov 05 2002, Leopold Gouverneur wrote:
> > I tried 2.5.43 with mixed results. In dmesg i see:
> 
> 2.5.42 is the one you should test, like I said in the mail.
> 
> > But I am still able to mount /dev/hdc and /dev/hdd
> > Hope it helps. Thanx for caring!
> 
> So 2.5.43 sort-of works?
> 
> -- 
> Jens Axboe
Sorry to bother you again but I am still unables to mount cdroms in Bk
current.  I was able to get some messages on the console( copied by
hand):

hdd: cdrom_decode_status: status=0xd0 {Busy}
hdd: cdrom_decode_status: error=0xd0LastFailedSense 0x0d
hdd: DMA disabled

-----------------[cut here]-------------------
Kernel BUG at drivers/ide/ide-cd.c:860!
invalid operand: 0000
ip_state ipt_Log ip_tables ip_conntrack_ftp ip_conntrack
CPU: 1
EIP: 0060:[<c01f0f74>]  Not tainted
EFLAGS: 00010282
eax: c01e4210 ebx: c033cfc0 ecx:00008000 edx: c033ec94
esi: c1398600 edi: c01f1770 ebp: 00000040 esp: c12bfe28
ds: oo6 es: 0068 ss: 0068
Process swapper( pid:0 threadinfo=c12bc000 task=c1290660 )
Stack: 00000000 00000376 00000000 00000080 0000001e c137eaa0 c137eaa0
       c033efc0 c1398600 c01f1af0 c033efc0 00008000 c01f1770 c033efc0
       c137eaa0 c1398600 c01f2925 c033efc0 00000040 00888898 c033efc0
       00000040 c137eaa0 00000000
Call Trace:[<c01f1af0>][<c01f1770>][<c01f2925>][<c01e926b>][<c01e947f>]
[<c01e97b3>][<c01e9670>][<c0128ef8>][c0124ac7>][<c01247e5>][c0107070>]

Passing it through ksymoops, I get:

ksymoops 2.4.6 on i686 2.5.46.  Options used
     -v /usr/src/linus-2.5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.46/ (default)
     -m /usr/src/linus-2.5/System.map (specified)

Kernel BUG at drivers/ide/ide-cd.c:860!
invalid operand: 0000
CPU: 1
EIP: 0060:[<c01f0f74>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c01e4210 ebx: c033cfc0 ecx:00008000 edx: c033ec94
esi: c1398600 edi: c01f1770 ebp: 00000040 esp: c12bfe28
ds: oo6 es: 0068 ss: 0068
Stack: 00000000 00000376 00000000 00000080 0000001e c137eaa0 c137eaa0
c033efc0 c1398600 c01f1af0 c033efc0 00008000 c01f1770 c033efc0 c137eaa0
c1398600 c01f2925 c033efc0 00000040 00888898 c033efc0 00000040 c137eaa0 
00000000
Call Trace:[<c01f1af0>][<c01f1770>][<c01f2925>][<c01e926b>][<c01e947f>]
[<c01e97b3>][<c01e9670>][<c0128ef8>][c0124ac7>][<c01247e5>][c0107070>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c01f0f74 <cdrom_start_packet_command+134/200>   <=====

>>eax; c01e4210 <atapi_reset_pollfunc+0/120>
>>ebx; c033cfc0 <dkstat+1280/1400>
>>edx; c033ec94 <ide_hwifs+7d4/4e48>
>>esi; c1398600 <_end+104d3e4/104dde44>
>>edi; c01f1770 <cdrom_start_read_continuation+0/c0>
>>esp; c12bfe28 <_end+f74c0c/104dde44>

Trace; c01f1af0 <cdrom_start_read+b0/c0>
Trace; c01f1770 <cdrom_start_read_continuation+0/c0>
Trace; c01f2925 <ide_do_rw_cdrom+75/1b0>
Trace; c01e926b <start_request+fb/1c0>
Trace; c01e947f <ide_do_request+ff/220>
Trace; c01e97b3 <ide_timer_expiry+143/260>
Trace; c01e9670 <ide_timer_expiry+0/260>
Trace; c0128ef8 <__run_timers+88/172>


1 warning issued.  Results may not be reliable.

With 21.5.42 i mounted hdc and hdd many times without problem
except that one time i got this on the console but the disk was mounted


>Nov  9 14:45:52 gouv kernel: hdd: DMA interrupt recovery
>Nov  9 14:45:52 gouv kernel: hdd: lost interrupt
>Nov  9 14:45:52 gouv kernel: hdd: cdrom_decode_status:
		      status=0xd0 { Busy }
>Nov  9 14:45:52 gouv kernel: hdd: cdrom_decode_status:
                      error=0xd0LastFailedSense 0x0d 
>Nov  9 14:45:52 gouv kernel: hdd: DMA disabled
>Nov  9 14:45:52 gouv kernel: hdd: ATAPI reset complete

Here is the boot messages for 2.5.42


Linux version 2.5.42 (root@gouv) (gcc version 3.2.1 20021103 
(Debian prerelease)) #4 SMP Sat Nov 9 14:35:35 CET 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
  DMA zone: 4096 pages
  Normal zone: 61440 pages
  HighMem zone: 0 pages
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
Processor #1 6:6 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/hde6
Initializing CPU#0
Detected 434.326 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 856.06 BogoMIPS
Memory: 256184k/262144k available (1455k kernel code, 5572k reserved,
295k data, 284k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 868.35 BogoMIPS
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1724.41 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22,
 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
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
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
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
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 434.0266 MHz.
..... host bus clock speed is 66.0810 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
adding '' to cpu class interfaces
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I17,P0) -> 19
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P1) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Starting kswapd
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Brother HL-1440 series
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xd0000000
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd0816000, 00:50:bf:61:ac:dc, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: ST34321A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-R/RW DRIVE SW-224B, ATAPI CD/DVD-ROM drive
hdd: FX140S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller at PCI slot 00:13.0
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc000-0xc007, BIOS settings: hdg:pio, hdh:pio
hde: IBM-DTLA-307030, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 18
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 8404830 sectors (4303 MB) w/128KiB Cache, CHS=523/255/63, UDMA(33)
 hda: hda1 hda2
hde: host protected area => 1
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(44)
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 >
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 16X CD-ROM drive, 256kB Cache, DMA
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 284k freed
Adding 124984k swap on /dev/hde2.  Priority:-1 extents:1
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 156 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
MTRR: setting reg 1
MTRR: setting reg 1
MTRR: setting reg 1
MTRR: setting reg 1
MTRR: setting reg 1
MTRR: setting reg 1
