Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbUANBM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUANBM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:12:57 -0500
Received: from 206-171-8-200.opus.com ([206.171.8.200]:37597 "helo
	206-171-8-200.opus.com") by vger.kernel.org with SMTP
	id S266260AbUANBMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:12:41 -0500
Subject: 2.4.21 oops under network load
From: "Z. Levow" <zlevow@affinitypath.com>
Message-Id: <S266260AbUANBMl/20040114011241Z+29573@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Date: Tue, 13 Jan 2004 20:12:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a dual xeon system (standard Mandrake 9.1 install patched to 2.4.21-0.26) that keeps oopsing under network load...

I can reproduce this at will and I have tried this with different memory and cpu's - the system has 2GB of ram and isn't even swapping.  The cpu is also barely utilized.

ksymoops/dmesg/uname output below - TIA!

Z. Levow
zlevow@affinitypath.com

ksymoops output:
Jan 13 12:55:46 Linux kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 13 12:55:46 Linux kernel: f77ad7e5
Jan 13 12:55:46 Linux kernel: *pde = 00000000
Jan 13 12:55:46 Linux kernel: Oops: 0000
Jan 13 12:55:46 Linux kernel: CPU:    0
Jan 13 12:55:46 Linux kernel: EIP:    0010:[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.26mdkenterprise/k+-19724315/96]    Not tainted
Jan 13 12:55:46 Linux kernel: EIP:    0010:[<f77ad7e5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 13 12:55:46 Linux kernel: EFLAGS: 00010282
Jan 13 12:55:46 Linux kernel: eax: bffff354   ebx: f4438000   ecx: 00000000   edx: 00000000
Jan 13 12:55:46 Linux kernel: esi: c010962f   edi: 0000000b   ebp: f4439fb8   esp: f4439f80
Jan 13 12:55:46 Linux kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 12:55:46 Linux kernel: Process file (pid: 1875, stackpage=f4439000)
Jan 13 12:55:46 Linux kernel: Stack: f4438000 c010962f 0000000b f7b44000 00000000 f7b44000 0000000b f4439fbc
Jan 13 12:55:46 Linux kernel:        c0107d0f bffff354 f7b44000 00000000 00000a3a 00000020 bffff348 f77ad9ce
Jan 13 12:55:46 Linux kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Jan 13 12:55:46 Linux kernel: Call Trace:
Jan 13 12:55:46 Linux kernel:  [<c010962f>] system_call+0x33/0x38 [kernel]
Jan 13 12:55:46 Linux kernel:  [<c0107d0f>] sys_execve+0x6f/0x80 [kernel]
Jan 13 12:55:46 Linux kernel: Code: 8b 42 04 83 f8 ff 0f 84 69 01 00 00 83 f8 fc 77 07 c7 42 04


>>EIP; f77ad7e5 <_end+3735f739/383b1fa4>   <=====

>>ebx; f4438000 <_end+33fe9f54/383b1fa4>
>>esi; c010962f <system_call+33/38>
>>ebp; f4439fb8 <_end+33febf0c/383b1fa4>
>>esp; f4439f80 <_end+33febed4/383b1fa4>

Trace; c010962f <system_call+33/38>
Trace; c0107d0f <sys_execve+6f/80>

Code;  f77ad7e5 <_end+3735f739/383b1fa4>
00000000 <_EIP>:
Code;  f77ad7e5 <_end+3735f739/383b1fa4>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f77ad7e8 <_end+3735f73c/383b1fa4>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f77ad7eb <_end+3735f73f/383b1fa4>
   6:   0f 84 69 01 00 00         je     175 <_EIP+0x175>
Code;  f77ad7f1 <_end+3735f745/383b1fa4>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f77ad7f4 <_end+3735f748/383b1fa4>
   f:   77 07                     ja     18 <_EIP+0x18>
Code;  f77ad7f6 <_end+3735f74a/383b1fa4>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)


Uname -a output:
Linux Linux 2.4.21-0.26mdkenterprise #1 SMP Sat Nov 29 15:53:09 MST 2003 i686 unknown unknown GNU/Linux

Dmesg output:
[root@206.171.8.225] # dmesg
PIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Enabling APIC mode: Flat.       Using 3 I/O APICs
Processors: 4
Kernel command line: auto BOOT_IMAGE=linux ro root=801 devfs=mount acpi=off sda=ide-scsi quiet
Initializing CPU#0
Detected 2666.843 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5321.52 BogoMIPS
Memory: 2067676k/2096640k available (1588k kernel code, 28512k reserved, 1138k data, 156k init, 1179072k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
per-CPU timeslice cutoff: 1463.12 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5321.52 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
Booting processor 2/6 eip 3000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5321.52 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
Booting processor 3/7 eip 3000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5321.52 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
Total of 4 processors activated (21286.09 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17, 2-20, 2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-1, 4-2, 4-3, 4-4, 4-5, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23 not connected.
.TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #2......
... register #00: 02008000
......    : physical APIC id: 02
......    : Delivery Type: 1
......    : LTS          : 0
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 00000000
......     : arbitration: 00
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    51
 07 00F 0F  0    0    0   0   0    1    1    59
 08 00F 0F  0    0    0   0   0    1    1    61
 09 00F 0F  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    71
 0d 00F 0F  0    0    0   0   0    1    1    79
 0e 00F 0F  0    0    0   0   0    1    1    81
 0f 00F 0F  0    0    0   0   0    1    1    89
 10 00F 0F  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 00F 0F  1    1    0   1   0    1    1    99
 13 00F 0F  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 00F 0F  1    1    0   1   0    1    1    A9
 16 00F 0F  1    1    0   1   0    1    1    B1
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
... register #00: 03000000
......    : physical APIC id: 03
......    : Delivery Type: 0
......    : LTS          : 0
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 03000000
......     : arbitration: 03
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
... register #00: 04000000
......    : physical APIC id: 04
......    : Delivery Type: 0
......    : LTS          : 0
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 04000000
......     : arbitration: 04
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    B9
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  1    1    0   1   0    1    1    C1
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
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
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ48 -> 2:0
IRQ54 -> 2:6
................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 2666.7355 MHz.
.... host bus clock speed is 133.3366 MHz.
cpu: 0, clocks: 1333366, slice: 266673
CPU0<T0:1333360,T1:1066672,D:15,S:266673,C:1333366>
cpu: 1, clocks: 1333366, slice: 266673
cpu: 2, clocks: 1333366, slice: 266673
cpu: 3, clocks: 1333366, slice: 266673
CPU1<T0:1333360,T1:800000,D:14,S:266673,C:1333366>
CPU2<T0:1333360,T1:533328,D:13,S:266673,C:1333366>
CPU3<T0:1333360,T1:266656,D:12,S:266673,C:1333366>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
ACPI: Subsystem revision 20030122
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfd8b5, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Discovered primary peer bus 10 [IRQ]
PCI: Discovered primary peer bus 11 [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B2,I1,P0) -> 48
PCI->APIC IRQ transform: (B2,I3,P0) -> 54
PCI->APIC IRQ transform: (B4,I4,P0) -> 21
PCI->APIC IRQ transform: (B4,I5,P0) -> 22
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
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
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
Freeing initrd memory: 419k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem driver Revision: 1.00
3ware Storage Controller device driver for Linux v1.02.00.031.
scsi0 : Found a 3ware Storage Controller at 0x3040, IRQ: 48, P-chip: 1.3
scsi0 : 3ware Storage Controller
blk: queue f7bec218, I/O limit 4095Mb (mask 0xffffffff)
3w-xxxx: scsi0: AEN: WARNING: Unclean shutdown detected: Unit #0.
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
blk: queue f7bec018, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 490232704 512-byte hdwr sectors (250999 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
SGI XFS 1.3.0pre2 with ACLs, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sd(8,1)
Starting XFS recovery on filesystem: sd(8,1) (dev: 8/1)
Ending XFS recovery on filesystem: sd(8,1) (dev: 8/1)
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Real Time Clock Driver v1.10e
Adding Swap: 2096440k swap-space (priority -1)
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
XFS mounting filesystem sd(8,6)
Starting XFS recovery on filesystem: sd(8,6) (dev: 8/6)
Ending XFS recovery on filesystem: sd(8,6) (dev: 8/6)
XFS mounting filesystem sd(8,9)
Starting XFS recovery on filesystem: sd(8,9) (dev: 8/9)
Ending XFS recovery on filesystem: sd(8,9) (dev: 8/9)
XFS mounting filesystem sd(8,7)
Starting XFS recovery on filesystem: sd(8,7) (dev: 8/7)
Ending XFS recovery on filesystem: sd(8,7) (dev: 8/7)
XFS mounting filesystem sd(8,8)
Starting XFS recovery on filesystem: sd(8,8) (dev: 8/8)
Ending XFS recovery on filesystem: sd(8,8) (dev: 8/8)
Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 320 bytes per conntrack
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-i801.o version 2.7.0 (20021208)
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
adm1021.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
inserting floppy driver for 2.4.21-0.26mdkenterprise
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
e1000: eth0 NIC Link is Down
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
3w-xxxx: scsi0: AEN: INFO: Initialization started: Unit #0.
