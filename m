Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSGSTXb>; Fri, 19 Jul 2002 15:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSGSTX1>; Fri, 19 Jul 2002 15:23:27 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:17864 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S315379AbSGSTXG>; Fri, 19 Jul 2002 15:23:06 -0400
Date: Fri, 19 Jul 2002 21:26:07 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Linux Kernel 2.4.18 and 2.4.19 problems
Message-ID: <20020719192607.GA13880@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a few Dell PowerEdge 2650 machines, and thought they would
become nice fileservers, and we installed RedHat Linux 7.3 on them.
So far, so good; after the installation, pretty much was downhill
from there. With RedHat's 2.4.18-3 and 2.4.18-5 kernel we detect
all disks connected through our QLogic FC 2200 HBA's, with 
vanilla 2.4.18 and 2.4.19-rc2, we detect nothing; and we've tried
Qlogic's 6.0beta13 and 6.1beta2 drivers, as well as the driver
that comes with redhat's release. We're currently running an almost
identical configuration, only diff. is one HBA pr server, and
the servers are 2550's and not 2650's. 

Ok, to sum up problems:

With redhat kernels:
* Disks found, _but_ after about 2-3 mins with heavy I/O on
  FC HBA's the machine dies, and only thing working is cold boot

With vanilla kernels:
* Disks not found, so we don't know about I/O problems.


Anyone have any ideas?


Here's dmesg and lspci -vvvxx, if anything else is needed, please
tell me, and I'll provide you with the info:

test4:~# dmesg
 idx=8 mapped at ffff6000
ACPI table found: APIC v1 [DELL   PE2650   0.1]
__va_range(0xfdd18, 0x88): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
CPU 1 (0x0200) enabledProcessor #2 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0003] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0004] id[0x3] enabled[1])
CPU 3 (0x0300) enabledProcessor #3 Unknown CPU [15:2] APIC version 16

IOAPIC (id[0x4] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x5] address[0xfec01000] global_irq_base[0x10])
IOAPIC (id[0x6] address[0xfec02000] global_irq_base[0x20])
LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0004] polarity[0x1] trigger[0x1] lint[0x1])
4 CPUs total
Local APIC address fee00000
__va_range(0xfdda0, 0x24): idx=8 mapped at ffff6000
__va_range(0xfdda0, 0x50): idx=8 mapped at ffff6000
ACPI table found: SPCR v1 [DELL   PE2650   0.1]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0121      APIC at: 0xFEE00000
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
I/O APIC #6 Version 17 at 0xFEC02000.
Processors: 4
Kernel command line: auto BOOT_IMAGE=linux ro root=802 BOOT_FILE=/boot/bzImage-2.4.18-3 max_scsi_luns=128
Initializing CPU#0
Detected 1794.244 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 2065004k/2097088k available (1578k kernel code, 31700k reserved, 469k data, 220k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
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
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU2: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU3: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Total of 4 processors activated (14313.06 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-7, 4-10, 4-11, 4-13, 6-0, 6-1, 6-2, 6-3, 6-4, 6-5, 6-6, 6-7, 6-8, 6-9, 6-10, 6-11, 6-12, 6-13, 
6-14, 6-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 35.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
number of IO-APIC #6 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  0    0    0   0   0    1    1    31
 01 00F 0F  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  1    1    0   1   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 00F 0F  0    0    0   0   0    1    1    61
 09 00F 0F  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 00F 0F  0    0    0   0   0    1    1    79
 0f 00F 0F  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 05000000
.......     : arbitration: 05
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  1    1    0   1   0    1    1    89
 01 00F 0F  1    1    0   1   0    1    1    91
 02 00F 0F  1    1    0   1   0    1    1    99
 03 00F 0F  1    1    0   1   0    1    1    A1
 04 00F 0F  1    1    0   1   0    1    1    A9
 05 00F 0F  1    1    0   1   0    1    1    B1
 06 00F 0F  1    1    0   1   0    1    1    B9
 07 00F 0F  1    1    0   1   0    1    1    C1
 08 00F 0F  1    1    0   1   0    1    1    C9
 09 00F 0F  1    1    0   1   0    1    1    D1
 0a 00F 0F  1    1    0   1   0    1    1    D9
 0b 00F 0F  1    1    0   1   0    1    1    E1
 0c 00F 0F  1    1    0   1   0    1    1    E9
 0d 00F 0F  1    1    0   1   0    1    1    32
 0e 00F 0F  1    1    0   1   0    1    1    3A
 0f 00F 0F  1    1    0   1   0    1    1    42

IO APIC #6......
.... register #00: 06000000
.......    : physical APIC id: 06
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 06000000
.......     : arbitration: 06
.... IRQ redirection table:
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
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ9 -> 0:9
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
..... CPU clock speed is 1794.1617 MHz.
..... host bus clock speed is 99.6755 MHz.
cpu: 0, clocks: 996755, slice: 199351
CPU0<T0:996752,T1:797392,D:9,S:199351,C:996755>
cpu: 1, clocks: 996755, slice: 199351
cpu: 3, clocks: 996755, slice: 199351
cpu: 2, clocks: 996755, slice: 199351
CPU2<T0:996752,T1:398688,D:11,S:199351,C:996755>
CPU3<T0:996752,T1:199328,D:20,S:199351,C:996755>
CPU1<T0:996752,T1:598048,D:2,S:199351,C:996755>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfc98e, last bus=6
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 03 [IRQ]
PCI: Discovered primary peer bus 04 [IRQ]
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI->APIC IRQ transform: (B0,I4,P0) -> 19
PCI->APIC IRQ transform: (B0,I4,P1) -> 23
PCI->APIC IRQ transform: (B0,I4,P2) -> 27
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I5,P0) -> 17
PCI->APIC IRQ transform: (B4,I6,P0) -> 28
PCI->APIC IRQ transform: (B4,I8,P0) -> 29
PCI->APIC IRQ transform: (B5,I8,P0) -> 30
PCI->APIC IRQ transform: (B6,I6,P0) -> 30
PCI->APIC IRQ transform: (B6,I6,P1) -> 31
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:DMA
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
tg3.c:v0.97 (Mar 13, 2002)
eth0: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:06:5b:3e:f4:6a
eth1: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:06:5b:3e:f4:6b
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver, Jul 18 2002
scsi0 : percraid
  Vendor: DELL      Model: PERCRAID Mirror   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35544576 512-byte hdwr sectors (18199 MB)
sda: Write Protect is off
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 220k freed
qla2x00_set_info starts at address = f8836060
qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
scsi1: Found a QLA2200  @ bus 2, device 0x4, irq 16, iobase 0xdc00
scsi(1): Allocated 4096 SRB(s)
PCI: Setting latency timer of device 02:04.0 to 64
scsi(1): Configure NVRAM parameters...
scsi(1): 64 Bit PCI Addressing Enabled
scsi(1): Verifying loaded RISC code...
scsi(1): Verifying chip...
scsi(1): Waiting for LIP to complete...
scsi(1): Cable is unplugged...
qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
scsi2: Found a QLA2200  @ bus 2, device 0x5, irq 17, iobase 0xd800
scsi(2): Allocated 4096 SRB(s)
PCI: Setting latency timer of device 02:05.0 to 64
scsi(2): Configure NVRAM parameters...
scsi(2): 64 Bit PCI Addressing Enabled
scsi(2): Verifying loaded RISC code...
scsi(2): Verifying chip...
scsi(2): Waiting for LIP to complete...
scsi(2): Cable is unplugged...
scsi1 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 2 device 4 irq 16
        Firmware version:  2.02.03, Driver version 6.1b2
scsi2 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 2 device 5 irq 17
        Firmware version:  2.02.03, Driver version 6.1b2
usb.c: registered new driver hub
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
eth0: Link is up at 1000 Mbps, full duplex.
eth0: Flow control is on for TX and on for RX.




test4:~# lspci -vvvxx 
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 12 00 00 00 00 00 13 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: ServerWorks: Unknown device 0012
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 12 00 00 00 00 00 00 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 00 00 00 00 00 00 00 00 00 06 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Class ff00: Dell Computer Corporation Embedded Systems Management Device 4
        Subsystem: Dell Computer Corporation Embedded Systems Management Device 4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at feb80000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ecf8 [size=8]
        Region 2: I/O ports at ece8 [size=8]
        Expansion ROM at fe000000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 28 10 0c 00 17 01 90 02 00 00 00 ff 08 20 80 00
10: 08 00 b8 fe f9 ec 00 00 e9 ec 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 0c 00
30: 00 00 00 fe 48 00 00 00 00 00 00 00 0b 01 00 00

00:04.1 Class ff00: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
        Subsystem: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 23
        Region 0: Memory at fe102000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at ec80 [size=64]
        Region 2: Memory at feb00000 (32-bit, prefetchable) [size=512K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 28 10 08 00 03 01 90 02 00 00 00 ff 08 20 80 00
10: 00 20 10 fe 81 ec 00 00 08 00 b0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 08 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 02 00 00

00:04.2 Class 0c07: Dell Computer Corporation: Unknown device 000d
        Subsystem: Dell Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 27
        Region 0: I/O ports at ecf4 [size=4]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 28 10 0d 00 03 01 90 02 00 00 07 0c 08 20 80 00
10: f5 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 0d 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 07 03 00 00

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0121
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 a7 00 90 02 27 00 00 03 08 20 00 00
10: 00 00 00 fd 01 e8 00 00 00 10 10 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 21 01
30: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 00 08 00

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
00: 66 11 01 02 47 01 00 22 93 00 00 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 08c0 [size=8]
        Region 1: I/O ports at 08c8 [size=4]
        Region 2: I/O ports at 08d0 [size=8]
        Region 3: I/O ports at 08d8 [size=4]
        Region 4: I/O ports at 08b0 [size=16]
00: 66 11 12 02 45 01 00 02 93 82 01 01 00 40 80 00
10: c1 08 00 00 c9 08 00 00 d1 08 00 00 d9 08 00 00
20: b1 08 00 00 00 00 00 00 00 00 00 00 66 11 12 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 57 01 80 02 05 10 03 0c 08 20 80 00
10: 00 00 10 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50

00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 66 11 25 02 05 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 30 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 30 22 03 00 00 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 b0 22 03 00 00 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 b0 22 03 00 00 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00: 66 11 01 01 42 01 30 22 03 00 00 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

01:06.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fce00000-fcffffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
00: 11 10 26 00 07 01 b0 02 05 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 01 02 02 20 d1 d1 a0 22
20: e0 fc f0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 00

02:04.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
        Subsystem: QLogic Corp.: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at fceff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcf00000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 77 10 00 22 17 01 b0 02 05 00 00 01 08 40 00 00
10: 01 dc 00 00 00 f0 ef fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 77 10 02 00
30: 00 00 f0 fc 44 00 00 00 00 00 00 00 0b 01 40 00

02:05.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
        Subsystem: QLogic Corp.: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at fcefe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcf00000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 77 10 00 22 17 01 b0 02 05 00 00 01 08 40 00 00
10: 01 d8 00 00 00 e0 ef fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 77 10 02 00
30: 00 00 f0 fc 44 00 00 00 00 00 00 00 0a 01 40 00

04:06.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: Dell Computer Corporation NetXtreme BCM5701 1000BaseTX
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at fcc10000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: e7034b36f4f5c52c  Data: bbee
00: e4 14 45 16 06 01 b0 02 15 00 00 02 08 40 00 00
10: 04 00 c1 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 21 01
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 01 40 00

04:08.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: Dell Computer Corporation NetXtreme BCM5701 1000BaseTX
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at fcc00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: b2d787bec57f9e4c  Data: 98b9
00: e4 14 45 16 06 01 b0 02 15 00 00 02 08 40 00 00
10: 04 00 c0 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 21 01
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 40 00

05:08.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fc900000-fcafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 09 03 07 01 b0 04 01 00 04 06 10 20 81 00
10: 00 00 00 00 00 00 00 00 05 06 06 20 a0 a0 a0 22
20: 90 fc a0 fc f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 06 00

05:08.1 RAID bus controller: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 0121
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 30
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fc800000 [disabled] [size=64K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 28 10 0a 00 16 01 b0 24 01 00 04 01 08 20 80 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 21 01
30: 00 00 80 fc 80 00 00 00 00 00 00 00 0a 01 00 00

06:06.0 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00c5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 30
        BIST result: 00
        Region 0: I/O ports at ac00 [size=256]
        Region 1: Memory at fc9ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fca00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 c5 00 17 01 b0 02 01 00 00 01 08 20 80 80
10: 01 ac 00 00 04 f0 9f fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 c5 00
30: 00 00 a0 fc dc 00 00 00 00 00 00 00 0a 01 28 19

06:06.1 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00c5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 31
        BIST result: 00
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at fc9fe000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fca00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 c5 00 17 01 b0 02 01 00 00 01 08 20 80 80
10: 01 a8 00 00 04 e0 9f fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 c5 00
30: 00 00 a0 fc dc 00 00 00 00 00 00 00 07 02 28 19



-- 
Thomas
