Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUBIGBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 01:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUBIGBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 01:01:32 -0500
Received: from [220.249.10.10] ([220.249.10.10]:40605 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S264889AbUBIGBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 01:01:16 -0500
Date: Mon, 9 Feb 2004 11:53:56 +0800
From: lepton <lepton@sina.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@gver.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Message-ID: <20040209035356.GA27697@lepton.goldenhope.com.cn>
References: <20040208143740.GA25010@lepton.goldenhope.com.cn.suse.lists.linux.kernel> <p73y8rdk3ng.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y8rdk3ng.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I untar a linux-2.4.24 kernel, then make menuconfig , make dep, make
bzImage to get a clean kernel.

If I disabled "Node Memory Interleave" setting in BIOS. The kernel will
boot. It saids It could't find numa configuration.But the scsi disk is
unusable after boot.File system on scsi disk can not be mounted. The kernel
complain about some file system error.

If I set "Node Memoey Interleave" to "Auto",the kernel will panic in the
init process of scsi.

Another problem perhaps has no relation with this problem is that the
system won't reboot automatic after panic although I have set panic=1
in boot.

The scsi card I am using is a Adaptec SCSI Card 29160LP.

I have tested linux kernel-2.6.1/2.6.2, all of them has no such problem.
Others has use United Linux in the server serveral moths ago.I know the 
kernel comes with the distrbution (2.4.19) works fine too.

The following is the decode output of panic info:

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference<1> at 0000000000000180 RIP: [<ffffffff8013b420>]PML4 0 
Oops: 0000
CPU 1
Pid: 1, comm: swapper Not tainted                                                                                           
RIP: 0010:[<ffffffff8013b420>]                                                                                              
Using defaults from ksymoops -t elf32-i386
RSP: 0000:000001007ffe3e78  EFLAGS: 00010016                                                                                
RAX: 0000000000000000 RBX: 0000010080000000 RCX: 0000000000000021                                                           
RDX: 0000010080000548 RSI: 0000000000000000 RDI: 0000000000000000                                                           
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000                                                           
R10: 0000010003c2f380 R11: 0000000000000046 R12: 0000000000000021                                                           
R13: 0000010080000000 R14: 0000000000000000 R15: 0000000000000021                                                           
FS:  0000000000000000(0000) GS:ffffffff8035eec0(0000) knlGS:0000000000000000                                                
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b                                                                           
CR2: 0000000000000180 CR3: 000000007ffed000 CR4: 00000000000006e0                                                           
Process swapper (pid: 1, stackpage=1007ffe3000)                                                                             
Stack: 000001007ffe3e78 0000000000000000 ffffffff802d5c00 0000000000000000                                                  
       0000010080000548 0000000000000000 0000010080000000 0000000000000000                                                  
       0000000000000021 0000010080000000 0000000000000000 0000000000000000                                                  
Call Trace: [<ffffffff8013e15d>] [<ffffffff8013b6bd>]                                                                       
       [<ffffffff801fb46d>] [<ffffffff8010b0b8>] [<ffffffff8010de10>]                                                       
       [<ffffffff8010b090>] [<ffffffff8010de08>]                                                                            
Code: 48 2b 80 80 01 00 00 48 c1 f8 03 41 89 c6 41 89 f4 48 89 d3                                                           


>>EIP; ffffffff8013b420 <__alloc_pages+20/2b0>   <=====

>>RBX; 0000010080000000 Before first symbol
>>RDX; 0000010080000548 Before first symbol
>>R10; 0000010003c2f380 Before first symbol
>>R13; 0000010080000000 Before first symbol

Trace; ffffffff8013e15d <_alloc_pages+6d/b9>
Trace; ffffffff8013b6bd <__get_free_pages+d/60>
Trace; ffffffff801fb46d <scsi_init_minimal_dma_pool+9d/116>
Trace; ffffffff8010b0b8 <init+28/140>
Trace; ffffffff8010de10 <child_rip+8/10>
Trace; ffffffff8010b090 <init+0/140>
Trace; ffffffff8010de08 <child_rip+0/10>

Code;  ffffffff8013b420 <__alloc_pages+20/2b0>
00000000 <_EIP>:
Code;  ffffffff8013b420 <__alloc_pages+20/2b0>   <=====
   0:   48                        dec    %eax   <=====
Code;  ffffffff8013b421 <__alloc_pages+21/2b0>
   1:   2b 80 80 01 00 00         sub    0x180(%eax),%eax
Code;  ffffffff8013b427 <__alloc_pages+27/2b0>
   7:   48                        dec    %eax
Code;  ffffffff8013b428 <__alloc_pages+28/2b0>
   8:   c1 f8 03                  sar    $0x3,%eax
Code;  ffffffff8013b42b <__alloc_pages+2b/2b0>
   b:   41                        inc    %ecx
Code;  ffffffff8013b42c <__alloc_pages+2c/2b0>
   c:   89 c6                     mov    %eax,%esi
Code;  ffffffff8013b42e <__alloc_pages+2e/2b0>
   e:   41                        inc    %ecx
Code;  ffffffff8013b42f <__alloc_pages+2f/2b0>
   f:   89 f4                     mov    %esi,%esp
Code;  ffffffff8013b431 <__alloc_pages+31/2b0>
  11:   48                        dec    %eax
Code;  ffffffff8013b432 <__alloc_pages+32/2b0>
  12:   89 d3                     mov    %edx,%ebx

CR2: 0000000000000180                                                                                                       
 <0>Kernel panic: Attempted to kill init!                                                                                  


The following is the all output of boot process when kernel panic:

Bootdata ok (command line is ro root=/dev/hda2 console=ttyS0,19200 panic=1)
Linux version 2.4.24 (root@amd64.ytht.net) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP Mon Feb 9 02:01:47 UTC 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbf80000 (usable)
 BIOS-e820: 00000000fbf80000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-d000
Scanning NUMA topology in Northbridge 24
Node 0 MemBase 0000000000000000 Limit 000000007fffffff
Node 1 MemBase 0000000080000000 Limit 00000000fbf80000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000fbf80000
Scan SMP from 0000010000000000 for 1024 bytes.
Scan SMP from 000001000009fc00 for 1024 bytes.
Scan SMP from 00000100000f0000 for 65536 bytes.
found SMP MP-table at 00000000000f6af0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
setting up node 0 0-7ffff
On node 0 totalpages: 524287
zone(0): 4096 pages.
zone(1): 520191 pages.
zone(2): 0 pages.
setting up node 1 80000-fbf80
On node 1 totalpages: 507776
zone(0): 0 pages.
zone(1): 507776 pages.
zone(2): 0 pages.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: AMD      Product ID: HAMMER       APIC at: 0xFEE00000
Processor #0 15:5 APIC version 16
Processor #1 15:5 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFC000000.
I/O APIC #4 Version 17 at 0xFC001000.
Processors: 2
Kernel command line: ro root=/dev/hda2 console=ttyS0,19200 panic=1
Initializing CPU#0
time.c: Detected 1.193182 MHz PIT timer.
time.c: Detected 1804.122 MHz TSC timer.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 4036176k/4128256k available (1552k kernel code, 0k reserved, 383k data, 116k init)
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 9, 2097152 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer cache hash table entries: 262144 (order: 9, 2097152 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#0
POSIX conformance testing by UNIFIX
mtrr: v2.02 (20020716))
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
CPU0: AMD Opteron(tm) Processor 244 stepping 08
per-CPU timeslice cutoff: 5117.91 usecs.
Booting processor 1/1 rip 6000 page 000001007fff0000
Initializing CPU#1
Calibrating delay loop... 3604.48 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#1
CPU1: AMD Opteron(tm) Processor 244 stepping 08
Total of 2 processors activated (7195.85 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
cpu: 0, clocks: 2004581, slice: 668193
CPU0<T0:2004576,T1:1336368,D:15,S:668193,C:2004581>
cpu: 1, clocks: 2004581, slice: 668193
CPU1<T0:2004576,T1:668176,D:14,S:668193,C:2004581>
checking TSC synchronization across CPUs: passed.
testing NMI watchdog ... OK.
time.c: Using PIT/TSC based timekeeping.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: Using configuration type 1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1022/746b] at 00:07.3
PCI->APIC IRQ transform: (B1,I0,P3) -> 19
PCI->APIC IRQ transform: (B1,I0,P3) -> 19
PCI->APIC IRQ transform: (B1,I6,P0) -> 18
PCI->APIC IRQ transform: (B2,I1,P0) -> 25
PCI->APIC IRQ transform: (B2,I3,P0) -> 27
PCI->APIC IRQ transform: (B2,I4,P0) -> 27
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
IA32 emulation $Id: sys_ia32.c,v 1.66 2003/11/10 13:09:54 ak Exp $
initialize_kbd: Keyboard interface failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
hw_random: AMD768 system management I/O registers at 0x8000.
hw_random hardware driver 1.0.0 loaded
tg3.c:v2.3 (November 5, 2003)
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:9c:ba
eth1: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:9c:bb
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: PCI device 1022:7469 (rev 03) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 4D080H4, ATA DISK drive
hdb: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
blk: queue ffffffff803487a0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
Unable to handle kernel NULL pointer dereference<1> at 0000000000000180 RIP: [<ffffffff8013b420>]PML4 0 
Oops: 0000
CPU 1
Pid: 1, comm: swapper Not tainted                                                                                           
RIP: 0010:[<ffffffff8013b420>]                                                                                              
RSP: 0000:000001007ffe3e78  EFLAGS: 00010016                                                                                
RAX: 0000000000000000 RBX: 0000010080000000 RCX: 0000000000000021                                                           
RDX: 0000010080000548 RSI: 0000000000000000 RDI: 0000000000000000                                                           
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000                                                           
R10: 0000010003c2f380 R11: 0000000000000046 R12: 0000000000000021                                                           
R13: 0000010080000000 R14: 0000000000000000 R15: 0000000000000021                                                           
FS:  0000000000000000(0000) GS:ffffffff8035eec0(0000) knlGS:0000000000000000                                                
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b                                                                           
CR2: 0000000000000180 CR3: 000000007ffed000 CR4: 00000000000006e0                                                           
Process swapper (pid: 1, stackpage=1007ffe3000)                                                                             
Stack: 000001007ffe3e78 0000000000000000 ffffffff802d5c00 0000000000000000                                                  
       0000010080000548 0000000000000000 0000010080000000 0000000000000000                                                  
       0000000000000021 0000010080000000 0000000000000000 0000000000000000                                                  
Call Trace: [<ffffffff8013e15d>] [<ffffffff8013b6bd>]                                                                       
       [<ffffffff801fb46d>] [<ffffffff8010b0b8>] [<ffffffff8010de10>]                                                       
       [<ffffffff8010b090>] [<ffffffff8010de08>]                                                                            
                                                                                                                            
Code: 48 2b 80 80 01 00 00 48 c1 f8 03 41 89 c6 41 89 f4 48 89 d3                                                           
RIP [<ffffffff8013b420>] RSP <000001007ffe3e78>                                                                             
CR2: 0000000000000180                                                                                                       
 <0>Kernel panic: Attempted to kill init!                                                                                   
 <0>Rebooting in 1 seconds.. 


The following is the output of kernel boot when it not panic

Bootdata ok (command line is ro root=/dev/hda2 console=ttyS0,19200 panic=1)
Linux version 2.4.24 (root@amd64.ytht.net) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP Mon Feb 9 02:01:47 UTC 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbf80000 (usable)
 BIOS-e820: 00000000fbf80000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-d000
Scanning NUMA topology in Northbridge 24
Node 0 using interleaving mode 1/0
No NUMA configuration found
Faking a node at 0000000000000000-00000000fbf80000
Bootmem setup node 0 0000000000000000-00000000fbf80000
Scan SMP from 0000010000000000 for 1024 bytes.
Scan SMP from 000001000009fc00 for 1024 bytes.
Scan SMP from 00000100000f0000 for 65536 bytes.
found SMP MP-table at 00000000000f6af0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
setting up node 0 0-fbf80
On node 0 totalpages: 1032064
zone(0): 4096 pages.
zone(1): 1027968 pages.
zone(2): 0 pages.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: AMD      Product ID: HAMMER       APIC at: 0xFEE00000
Processor #0 15:5 APIC version 16
Processor #1 15:5 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFC000000.
I/O APIC #4 Version 17 at 0xFC001000.
Processors: 2
Kernel command line: ro root=/dev/hda2 console=ttyS0,19200 panic=1
Initializing CPU#0
time.c: Detected 1.193182 MHz PIT timer.
time.c: Detected 1804.135 MHz TSC timer.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 4036184k/4128256k available (1552k kernel code, 0k reserved, 383k data, 116k init)
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 9, 2097152 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer cache hash table entries: 262144 (order: 9, 2097152 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#0
POSIX conformance testing by UNIFIX
mtrr: v2.02 (20020716))
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
CPU0: AMD Opteron(tm) Processor 244 stepping 08
per-CPU timeslice cutoff: 5117.91 usecs.
Booting processor 1/1 rip 6000 page 00000100fbf78000
Initializing CPU#1
Calibrating delay loop... 3604.48 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#1
CPU1: AMD Opteron(tm) Processor 244 stepping 08
Total of 2 processors activated (7195.85 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-20, 2-21, 2-22, 2-23, 3-0, 3-2, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  1    1    0   1   0    1    1    B9
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  1    1    0   1   0    1    1    C1

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
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
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ25 -> 1:1
IRQ27 -> 1:3
.................................... done.
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
cpu: 0, clocks: 2004596, slice: 668198
CPU0<T0:2004592,T1:1336384,D:10,S:668198,C:2004596>
cpu: 1, clocks: 2004596, slice: 668198
CPU1<T0:2004592,T1:668192,D:4,S:668198,C:2004596>
checking TSC synchronization across CPUs: passed.
testing NMI watchdog ... OK.
time.c: Using PIT/TSC based timekeeping.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: Using configuration type 1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1022/746b] at 00:07.3
PCI->APIC IRQ transform: (B1,I0,P3) -> 19
PCI->APIC IRQ transform: (B1,I0,P3) -> 19
PCI->APIC IRQ transform: (B1,I6,P0) -> 18
PCI->APIC IRQ transform: (B2,I1,P0) -> 25
PCI->APIC IRQ transform: (B2,I3,P0) -> 27
PCI->APIC IRQ transform: (B2,I4,P0) -> 27
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
IA32 emulation $Id: sys_ia32.c,v 1.66 2003/11/10 13:09:54 ak Exp $
initialize_kbd: Keyboard interface failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
hw_random: AMD768 system management I/O registers at 0x8000.
hw_random hardware driver 1.0.0 loaded
tg3.c:v2.3 (November 5, 2003)
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:9c:ba
eth1: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:9c:bb
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: PCI device 1022:7469 (rev 03) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 4D080H4, ATA DISK drive
hdb: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
blk: queue ffffffff803487a0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
 sda: sda1
LVM version 1.0.7(28/03/2003)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
IPv4 over IPv4 tunneling driver
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,2)) ...
for (ide0(3,2))
ide0(3,2):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 524624k swap-space (priority -1)
cdrom: open failed.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.

If you like any other information,I will provide as you request.

On Sun, Feb 08, 2004 at 04:10:59PM +0100, Andi Kleen wrote:
> lepton <lepton@sina.com> writes:
> > 
> > 	If you'd like any other information,I will provide as you
> > reguest.
> 
> Do a make distclean and try again. Most likely you miscompiled your
> kernel.
> 
> If that doesn't help please submit a proper bug report, in particular
> run oopses through ksymoops and specify the SCSI device in question.
> 
> -Andi
> 
