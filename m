Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJBNlj>; Tue, 2 Oct 2001 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274034AbRJBNla>; Tue, 2 Oct 2001 09:41:30 -0400
Received: from pc3gra.u-strasbg.fr ([130.79.73.47]:56580 "EHLO
	pc3gra.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S273904AbRJBNlQ>; Tue, 2 Oct 2001 09:41:16 -0400
Message-ID: <3BB9C413.A208AA7E@gravir.u-strasbg.fr>
Date: Tue, 02 Oct 2001 15:41:39 +0200
From: jacques@gravir.u-strasbg.fr
Organization: GRAViR
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Interrupt balancing problem on dual XEON 1.7GHz
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my dual XEON 1.7 GHz box (DELL precision 530), the command
cat /proc/interrupts outputs (kernel 2.4.10):

           CPU0       CPU1
  0:     524147          0    IO-APIC-edge  timer
  1:       2094          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:      95533          0    IO-APIC-edge  PS/2 Mouse
 14:       5804          1    IO-APIC-edge  ide0
 15:          5          1    IO-APIC-edge  ide1
 23:      21805          0   IO-APIC-level  eth0
NMI:          0          0
LOC:     524075     524073
ERR:          0
MIS:          0

According to this, it seems that hardware interrupts are
always handled by the CPU 0. Is this a bug or a feature ?

I have seen that other people have the same problem but
I have not found any answer.

Thanks for your help.

Jacques

If it can help, here is the output of dmesg:

Linux version 2.4.10 (root@pc3gra) (gcc version 2.95.3 20010315
(release)) #1 SMP Tue Oct 2 11:31:04 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007f77000 (usable)
 BIOS-e820: 0000000007f77000 - 0000000007f79000 (ACPI NVS)
 BIOS-e820: 0000000007f79000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 32631
zone(0): 4096 pages.
zone(1): 28535 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 530       APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) APIC version 20
Processor #1 Pentium 4(tm) APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=linux ro root=303
Initializing CPU#0
Detected 1694.911 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 125868k/130524k available (1187k kernel code, 4272k reserved,
343k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 1700MHz stepping 0a
per-CPU timeslice cutoff: 731.73 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3381.65 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 1700MHz stepping 0a
Total of 2 processors activated (6763.31 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-13 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 44.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
 10 003 03  1    1    0   1   0    1    1    A1
 11 003 03  1    1    0   1   0    1    1    A9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    B9
 14 003 03  1    1    0   1   0    1    1    C1
 15 003 03  1    1    0   1   0    1    1    C9
 16 003 03  1    1    0   1   0    1    1    D1
 17 003 03  1    1    0   1   0    1    1    D9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
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
..... CPU clock speed is 1694.8643 MHz.
..... host bus clock speed is 99.6977 MHz.
cpu: 0, clocks: 996977, slice: 332325
CPU0<T0:996976,T1:664640,D:11,S:332325,C:996977>
cpu: 1, clocks: 996977, slice: 332325
CPU1<T0:996976,T1:332320,D:6,S:332325,C:996977>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfbe8e, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B4,I11,P0) -> 23
PCI->APIC IRQ transform: (B4,I12,P0) -> 16
  got res[fe300000:fe300fff] for resource 0 of Intel Corporation 82806AA

PCI64 Hub Advanced Programmable Interrupt Controller
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT

SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 4
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 5T020H2, ATA DISK drive
hdc: CRD-8482B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63,
UDMA(100)
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
04:0b.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.16
ide-floppy driver 0.97.sv
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 136544k swap-space (priority -1)

