Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUEHRDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUEHRDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUEHRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 13:03:19 -0400
Received: from mx.accld.com ([82.196.2.2]:39638 "HELO mx.accld.com")
	by vger.kernel.org with SMTP id S263215AbUEHRCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 13:02:50 -0400
Message-ID: <00e601c4351e$4aad9f40$3d00030a@chp4w2k3>
From: "Cedric Hans" <chl@mlkj.net>
To: <linux-kernel@vger.kernel.org>
Cc: <cramerj@intel.com>, <john.ronciak@intel.com>,
       <ganesh.venkatesan@intel.com>
Subject: PROBLEM: 2.6.6-rc2 e1000 oops
Date: Sat, 8 May 2004 19:02:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Problem:
Kernel panic in e1000 interrupt handler

Description:
Oops occured after one day on a slightly loaded web server (Supermicro
motherboard with integrated e1000 copper Controller).

# uname -a
Linux http0 2.6.6-rc2 #2 SMP Fri May 7 17:10:40 CEST 2004 i686 Intel(R)
Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux

Kernel was compiled with:
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.12.90.0.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

The kernel panic:

http0 login: Unable to handle kernel NULL pointer dereference at virtual
address 002
*pde = 00000000
Oops: 0002 [#1]
SMP
CPU:    0
EIP:    0060:[<c01f30a1>]    Not tainted
EFLAGS: 00010013   (2.6.6-rc2)
EIP is at netif_rx+0xd1/0x1dc
eax: 00000002   ebx: c180fd0c   ecx: c0318004   edx: 014faf60
esi: c180fce0   edi: f7536780   ebp: c02c3ef8   esp: c02c3edc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c02c2000 task=c027e980)
Stack: f7dd3a20 c183f6e0 0000004f c02c3f34 c02c2000 00000246 00000000
c02c3f34
       c01cdd20 f7536780 f7714f80 f7dd3a20 00000000 f7536780 c02c2000
c0314d80
       00000001 0000006e f7b98a50 c183f6e0 f7dd3800 f7dd3b60 c02c3f4c
c01cd7b0
Call Trace:
 [<c01cdd20>] e1000_clean_rx_irq+0x354/0x3c0
 [<c01cd7b0>] e1000_intr+0x50/0x7c
 [<c0105c0a>] handle_IRQ_event+0x2a/0x54
 [<c0105f32>] do_IRQ+0x9e/0x120
 [<c0104710>] common_interrupt+0x18/0x20
 [<c01021c0>] default_idle+0x2c/0x34
 [<c0102256>] cpu_idle+0x3a/0x48
 [<c01002b8>] rest_init+0x48/0x4c
 [<c02c4826>] start_kernel+0x16e/0x178

Code: 31 00 a8 02 74 16 b8 05 00 00 00 f0 0f ab 46 50 19 c9 ba 01
 <0>Kernel panic: Fatal exception in interrupt


ksymoops says:

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
http0 login: Unable to handle kernel NULL pointer dereference at virtual
address 002
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01f30a1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013   (2.6.6-rc2)
eax: 00000002   ebx: c180fd0c   ecx: c0318004   edx: 014faf60
esi: c180fce0   edi: f7536780   ebp: c02c3ef8   esp: c02c3edc
ds: 007b   es: 007b   ss: 0068
Stack: f7dd3a20 c183f6e0 0000004f c02c3f34 c02c2000 00000246 00000000
c02c3f34
       c01cdd20 f7536780 f7714f80 f7dd3a20 00000000 f7536780 c02c2000
c0314d80
       00000001 0000006e f7b98a50 c183f6e0 f7dd3800 f7dd3b60 c02c3f4c
c01cd7b0
Call Trace:
 [<c01cdd20>] e1000_clean_rx_irq+0x354/0x3c0
 [<c01cd7b0>] e1000_intr+0x50/0x7c
 [<c0105c0a>] handle_IRQ_event+0x2a/0x54
 [<c0105f32>] do_IRQ+0x9e/0x120
 [<c0104710>] common_interrupt+0x18/0x20
 [<c01021c0>] default_idle+0x2c/0x34
 [<c0102256>] cpu_idle+0x3a/0x48
 [<c01002b8>] rest_init+0x48/0x4c
 [<c02c4826>] start_kernel+0x16e/0x178
Code: 31 00 a8 02 74 16 b8 05 00 00 00 f0 0f ab 46 50 19 c9 ba 01


>>EIP; c01f30a1 <netif_rx+d1/1dc>   <=====

>>ebp; c02c3ef8 <_etext+8ade6/8aeee>
>>esp; c02c3edc <_etext+8adca/8aeee>

Trace; c01cdd20 <e1000_clean_rx_irq+354/3c0>
Trace; c01cd7b0 <e1000_intr+50/7c>
Trace; c0105c0a <handle_IRQ_event+2a/54>
Trace; c0105f32 <do_IRQ+9e/120>
Trace; c0104710 <common_interrupt+18/20>
Trace; c01021c0 <default_idle+2c/34>
Trace; c0102256 <cpu_idle+3a/48>
Trace; c01002b8 <rest_init+48/4c>
Trace; c02c4826 <start_kernel+16e/178>

Code;  c01f30a1 <netif_rx+d1/1dc>
00000000 <_EIP>:
Code;  c01f30a1 <netif_rx+d1/1dc>   <=====
   0:   31 00                     xor    %eax,(%eax)   <=====
Code;  c01f30a3 <netif_rx+d3/1dc>
   2:   a8 02                     test   $0x2,%al
Code;  c01f30a5 <netif_rx+d5/1dc>
   4:   74 16                     je     1c <_EIP+0x1c>
Code;  c01f30a7 <netif_rx+d7/1dc>
   6:   b8 05 00 00 00            mov    $0x5,%eax
Code;  c01f30ac <netif_rx+dc/1dc>
   b:   f0 0f ab 46 50            lock bts %eax,0x50(%esi)
Code;  c01f30b1 <netif_rx+e1/1dc>
  10:   19 c9                     sbb    %ecx,%ecx
Code;  c01f30b3 <netif_rx+e3/1dc>
  12:   ba 01 00 00 00            mov    $0x1,%edx

 <0>Kernel panic: Fatal exception in interrupt



Linux version 2.6.6-rc2 (root@compiler) (gcc version 2.95.4 20011002 (Debian
prerelease)) #2 SMP Fri May 7 17:10:40 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5720
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7400
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7640
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: root=/dev/sda2 console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2595.860 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1036832k/1048512k available (1252k kernel code, 10760k reserved,
543k data, 328k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5128.19 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
per-CPU timeslice cutoff: 1463.33 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Total of 2 processors activated (10305.53 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-12, 2-20, 2-21 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
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
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    69
 0e 001 01  0    0    0   0   0    1    1    71
 0f 001 01  0    0    0   0   0    1    1    79
 10 001 01  1    1    0   1   0    1    1    81
 11 001 01  1    1    0   1   0    1    1    89
 12 001 01  1    1    0   1   0    1    1    91
 13 001 01  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    A1
 17 001 01  1    1    0   1   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2595.0130 MHz.
..... host bus clock speed is 199.0625 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1b0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B2,I3,P0) -> 17
PCI->APIC IRQ transform: (B2,I9,P0) -> 16
PCI->APIC IRQ transform: (B2,I10,P0) -> 22
PCI->APIC IRQ transform: (B2,I11,P0) -> 23
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.39-k2
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eth1: Intel(R) PRO/1000 Network Connection
3ware Storage Controller device driver for Linux v1.02.00.037.
scsi0 : Found a 3ware Storage Controller at 0xa000, IRQ: 17, P-chip: 1.3
scsi0 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 1991475200 512-byte hdwr sectors (1019635 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 328k freed
Adding 1959888k swap on /dev/sda1.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
e1000: eth1 NIC Link is Up 100 Mbps Full Duplex

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2595.860
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5128.19

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2595.860
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5177.34

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 2).
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 2).
      Master Capable.  Latency=32.  Min Gnt=4.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801EB USB (rev 2).
      IRQ 16.
      I/O at 0xbc00 [0xbc1f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801EB USB (rev 2).
      IRQ 19.
      I/O at 0xb000 [0xb01f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801EB USB (rev 2).
      IRQ 18.
      I/O at 0xb400 [0xb41f].
  Bus  0, device  29, function  3:
    USB Controller: Intel Corp. 82801EB USB (rev 2).
      IRQ 16.
      I/O at 0xb800 [0xb81f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801EB USB2 (rev 2).
      IRQ 23.
      Non-prefetchable 32 bit memory at 0xf3000000 [0xf30003ff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 194).
      Master Capable.  No bursts.  Min Gnt=14.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 2).
      IRQ 18.
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x40000000 [0x400003ff].
  Bus  0, device  31, function  2:
    IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 2).
      IRQ 18.
      I/O at 0xc000 [0xc007].
      I/O at 0xc400 [0xc403].
      I/O at 0xc800 [0xc807].
      I/O at 0xcc00 [0xcc03].
      I/O at 0xd000 [0xd00f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801EB SMBus Controller (rev 2).
      IRQ 17.
      I/O at 0x500 [0x51f].
  Bus  2, device   3, function  0:
    RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 1).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=9.
      I/O at 0xa000 [0xa00f].
      Non-prefetchable 32 bit memory at 0xf2851000 [0xf285100f].
      Non-prefetchable 32 bit memory at 0xf2000000 [0xf27fffff].
  Bus  2, device   9, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 16.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xf1000000 [0xf1ffffff].
      I/O at 0xa400 [0xa4ff].
      Non-prefetchable 32 bit memory at 0xf2850000 [0xf2850fff].
  Bus  2, device  10, function  0:
    Ethernet controller: PCI device 8086:1013 (Intel Corp.) (rev 0).
      IRQ 22.
      Master Capable.  Latency=32.  Min Gnt=255.
      Non-prefetchable 64 bit memory at 0xf2800000 [0xf281ffff].
      Non-prefetchable 64 bit memory at 0xf2840000 [0xf284ffff].
      I/O at 0xa800 [0xa83f].
  Bus  2, device  11, function  0:
    Ethernet controller: PCI device 8086:1013 (Intel Corp.) (rev 0).
      IRQ 23.
      Master Capable.  Latency=32.  Min Gnt=255.
      Non-prefetchable 32 bit memory at 0xf2820000 [0xf283ffff].
      I/O at 0xac00 [0xac3f].


