Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRBSVbn>; Mon, 19 Feb 2001 16:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBSVbX>; Mon, 19 Feb 2001 16:31:23 -0500
Received: from pop.gmx.net ([194.221.183.20]:4950 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129215AbRBSVbO>;
	Mon, 19 Feb 2001 16:31:14 -0500
From: Matthias Kleine <Kleine_Matthias@gmx.de>
Reply-To: Kleine_Matthias@gmx.de
Date: Mon, 19 Feb 2001 22:35:33 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Maybe a bug
MIME-Version: 1.0
Message-Id: <01021922344107.10203@orka>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel-developers,

I do not have any experience in kernel programming, but I do have a message 
in my /var/log/messages file which advices me to post to this list. This is 
the first time for me to visit this list, so don't be too hard too me if this 
posting doesn't fit into the common list rules.

The problem appears on a machine using the pretty new ASUS CUVX-D Dual Socket 
370 Motherboard, so there may be a chance for an unknown bug ;-). With NMI 
watchdog activated, a 2.4.x Kernel is not willing to boot on this machine, it 
just stops booting at a very early time, giving the latest message 
"activating NMI watchdog ..." and then blocking completely. Therefore, I set 
nmi_watchdog = 0, when the system boots properly, but leaves some crucial 
message in /var/log/messages:

Feb 19 19:37:17 delphin kernel: testing the IO APIC.......................
Feb 19 19:37:17 delphin kernel: 
Feb 19 19:37:17 delphin kernel:  WARNING: unexpected IO-APIC, please mail
Feb 19 19:37:17 delphin kernel:           to linux-smp@vger.kernel.org
Feb 19 19:37:17 delphin kernel: .................................... done.

This is the reason for my posting in this list. This boot has been done with 
a self-compiled original 2.4.1 kernel, without any patches applied. With NMI 
watchdog activated, I could also reproduce the problem with a standard 
2.4-SMP kernel from the SuSE 7.1 distribution, but booting does not lock up 
each time. In one from 5 trials, the system boots even with NMI watchdog 
activated. Here is the output of dmesg after booting the kernel 2.4.1 with 
NMI watchdog activated:

Linux version 2.4.1 (root@delphin) (gcc version 2.95.3 19991030 (prerelease)) 
#1 SMP Sam Feb 17 19:51:27 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000001fefc000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000001fffc000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000001ffff000 (ACPI NVS)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5460
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 3, trig 3, bus 0, IRQ 13, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 11
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux24 ro root=301
Initializing CPU#0
Detected 1004.523 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2005.40 BogoMIPS
Memory: 513324k/524272k available (975k kernel code, 10560k reserved, 353k 
data, 192k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.07 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2005.40 BogoMIPS
Stack at about c188dfbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 06
CPU has booted.
Before bogomips.
Total of 2 processors activated (4010.80 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-5, 2-10, 2-11, 2-13, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    1    1   1   1    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
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
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0-> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 1004.5372 MHz.
..... host bus clock speed is 133.9380 MHz.
cpu: 0, clocks: 1339380, slice: 446460
CPU0<T0:1339376,T1:892912,D:4,S:446460,C:1339380>
cpu: 1, clocks: 1339380, slice: 446460
CPU1<T0:1339376,T1:446432,D:24,S:446460,C:1339380>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0cc0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI->APIC IRQ transform: (B0,I4,P3) -> 18
PCI->APIC IRQ transform: (B0,I4,P3) -> 18
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
49 structures occupying 1505 bytes.
DMI table at 0x000F2A40.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS CUV4X-D ACPI BIOS Revision 1004
BIOS Release: 01/09/2001
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: CUV4X-D.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
block: queued sectors max/low 341136kB/210064kB, 1024 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
hdd: CD-W58E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63
hdc: ATAPI 48X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 1280kB Cache
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
 hdb:
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xb800, IRQ 18, 00:20:18:54:44:2E.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 32M @ 0xfc000000
Creative EMU10K1 PCI Audio Driver, version 0.7, 19:52:21 Feb 17 2001
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xb400-0xb41f, IRQ 17
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 248968k swap-space (priority -1)


Let me say, that the system seems to be usable after the boot, but when 
starting X, some strange drawings hush over the screen. Afterwards, X is 
running properly. Using a 2.2.x kernel this behaviour doesn't appear, with a 
2.4.x kernel, it is reproducable.

I do not know if this is interesting for some of you guys. As the board is 
pretty new (just one or two weeks on the german market), this might be 
interesting for testing purposes. Even if I do not have the capability to 
help you debugging, I would be willing to test out whatever you want. 

Just let me know if you need further information, or send me your patches and 
how to apply them.

With kind regards,
Matthias Kleine





