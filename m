Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRJTS4U>; Sat, 20 Oct 2001 14:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274055AbRJTS4L>; Sat, 20 Oct 2001 14:56:11 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:9200 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S273976AbRJTS4C>; Sat, 20 Oct 2001 14:56:02 -0400
Date: Sat, 20 Oct 2001 14:57:12 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: SMP lockup with 2.4.12 on VIA chipset (still does it)
Message-ID: <Pine.LNX.4.20.0110201436050.305-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*PLEASE* CC: me in any replies, I am not subscribed to this list.  Thanks.

Ok, all.  I finally got some time (and a null modem cable) to look at this
lockup a bit more.  To refresh everyone's memory, this is a dual CPU PIII
on a VIA chipset with a Matrox G400.  If I start X, switch to a text
console, and switch back to X, there's a 99% chance the box will lock up -
no keyboard, mouse, or network.  (This was brought up two months ago in
the 'Are we going too fast?' thread.)

Included at the bottom of this message are the kernel messages upon
boot.  NMI watchdog reported absolutely NOTHING when the lockup
occured.  Note that these messages are from the boot after the crash -
you'll notice that NMI watchdog is now reporting it's stuck on CPU#0.  In
the first boot (before the lockup), NMI watchdog seemed to be fine:
testing NMI watchdog ... OK.     

Please note that this lockup does *NOT* happen with 2.2.19 with SMP, nor
does it happen with 2.4.x WITHOUT SMP.  Therefore, I would think
whatever's causing this has to do with something that changed in SMP
between 2.2.x and 2.4.x.  Please feel free to yell at me if I should post
this elsewhere.

Without further ado, I present eriador's boot messages:

Linux version 2.4.12 (root@eriador) (gcc version 2.95.3 20010315 (release)) #1 SMP Sat Oct 20 01:53:08 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000fb170
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=Linux ro root=301 nmi_watchdog=1 console=ttyS0,115200
Initializing CPU#0
Detected 1000.221 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 512604k/524288k available (1039k kernel code, 10272k reserved, 394k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.00 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1998.84 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3991.14 BogoMIPS).
ENABLING IO-APIC IRQs                              
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0               
activating NMI Watchdog ... done. 
testing NMI watchdog ... CPU#0: NMI appears to be stuck!
testing the IO APIC.......................              
                                          
.................................... done.
Using local APIC timer interrupts.        
calibrating APIC timer ...        
..... CPU clock speed is 1000.0940 MHz.
..... host bus clock speed is 133.3457 MHz.
cpu: 0, clocks: 1333457, slice: 444485     
CPU0<T0:1333456,T1:888960,D:11,S:444485,C:1333457>
cpu: 1, clocks: 1333457, slice: 444485            
CPU1<T0:1333456,T1:444480,D:6,S:444485,C:1333457>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)            
All processors have done init_idle   
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs       
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1                         
PCI: Probing PCI hardware      
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Enabling Via external APIC routing         
Linux NET4.0 for Linux 2.4             
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket                         
apm: BIOS not found.          
Starting kswapd     
VFS: Diskquotas version dquot_6.4.0 initialized
ACPI: System description tables not found      
    ACPI-0076: *** Error: Acpi_load_tables: Could not get RSDP, AE_ERROR
    ACPI-0124: *** Error: Acpi_load_tables: Could not load tables: AE_ERROR
ACPI: System description table load failed                                 
pty: 256 Unix98 ptys configured           
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A                                               
Real Time Clock Driver v1.10e         
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 kdev 39                               
VP_IDE: chipset revision 16                                 
VP_IDE: not 100% native mode: will probe irqs later
hda: WDC WD205AA, ATA DISK drive                   
hdb: WDC WD307AA, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-116 0107, ATAPI CD/DVD-ROM drive
hdd: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive                  
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14               
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40079088 sectors (20520 MB) w/2048KiB Cache, CHS=2494/255/63
hdb: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63
Partition check:                                                 
 hda: hda1 hda2 hda3
 hdb: hdb1          
SCSI subsystem driver Revision: 1.00
Linux Kernel Card Services 3.1.22   
  options:  [pci] [cardbus] [pm] 
Intel PCIC probe: not found.    
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
ds: no socket drivers loaded!                              
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed     
INIT: version 2.76 booting              
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

