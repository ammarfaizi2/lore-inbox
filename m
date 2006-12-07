Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031182AbWLGFnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031182AbWLGFnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031113AbWLGFnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:43:01 -0500
Received: from smtp41.singnet.com.sg ([165.21.103.142]:46630 "EHLO
	smtp41.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031182AbWLGFm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:42:58 -0500
Message-ID: <4577AA11.6020906@homeurl.co.uk>
Date: Thu, 07 Dec 2006 13:43:45 +0800
From: Bob <spam@homeurl.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6 SMP very slow with ServerWorks LE Chipset
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I have a dual PIII Motherboard based on a ServerWorks LE chipset,
the motherboard is from an HP Netserver E 800 which is a customised 
ASUS CUR-DLS.

in UP config everything is OK in SMP the system slows right down, 
I've been searching and recompiling my kernel for days looking for 
the problem option without success, please help.

I'm using Sarge and I've tried the precompiled kernel 2.6.8-3-686-smp 
and 2.6.18.2 from Sid and I've downloaded and compiled the sources 
for 2.6.18 and 2.6.19 in dozens of different permutations, all with the 
same result that the system crawls, I've seen other people have the 
same problem but no fixes. (there are more)
http://forums.whirlpool.net.au/forum-replies.cfm?t=565813

As a test of raw CPU power I've been decompressing the kernel tree, with 
a UP 2.6 kernel this takes about 1m 15s, I don't know if bz2 is 
multithreaded but even if it's not I would expect a slight speed increase 
but in fact with a SMP 2.6 kernel it take 13 ~ 26m, with a SMP 2.4 
kernel it takes 1m 28s and with a 2.4 UP 1m 35s. 

Below is some useful output, the hdpram -tT examples below are 
under the smp kernel, the same commands under a uniprocessor 
kernel yeld fairly consistent results around
Timing cached reads:   744 MB in  2.01 seconds = 370.35 MB/sec
Timing buffered disk reads:  222 MB in  3.02 seconds =  73.48 MB/sec

I'm sorry this is so long but I'm trying to include all the relevant info,
any help greatly appreciated, I'm not subscribed but I lurk on Usenet.

Thank you

nas:~# uname -a
Linux nas 2.6.18.1.smp.1.0.HP_E800_SMP #1 SMP Thu Nov 16 15:26:09 SGT 2006 i686 GNU/Linux

nas:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   740 MB in  2.01 seconds = 369.02 MB/sec
 Timing buffered disk reads:   10 MB in  3.32 seconds =   3.01 MB/sec
nas:~# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   744 MB in  2.01 seconds = 370.35 MB/sec
 Timing buffered disk reads:   32 MB in  3.14 seconds =  10.21 MB/sec
nas:~# hdparm -tT /dev/sdb

/dev/sdb:
 Timing cached reads:    40 MB in  2.17 seconds =  18.43 MB/sec
 Timing buffered disk reads:   10 MB in  3.15 seconds =   3.18 MB/sec
nas:~# hdparm -tT /dev/sdc

/dev/sdc:
 Timing cached reads:    36 MB in  2.01 seconds =  17.91 MB/sec
 Timing buffered disk reads:   66 MB in  3.02 seconds =  21.88 MB/sec

###############################################################################################
nas:~# lspci
0000:00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
0000:00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
0000:00:04.0 Ethernet controller: Intel Corp.: Unknown device 107c (rev 05)
0000:00:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
0000:00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
0000:05:02.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc): Unknown device 3124 (rev 01)
0000:05:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
0000:05:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)

###############################################################################################
nas:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 666.711
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1334.30

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 666.711
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1334.52

###############################################################################################
nas:~# cat /proc/interrupts
           CPU0       CPU1
  0:     169863     161890    IO-APIC-edge  timer
  1:          8          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
 12:        102          1    IO-APIC-edge  i8042
129:       1426          1   IO-APIC-level  eth0
137:       4818        434   IO-APIC-level  ide0, ide1
153:       2019        432   IO-APIC-level  libata
161:         30          0   IO-APIC-level  sym53c8xx
169:         29          1   IO-APIC-level  sym53c8xx
NMI:          0          0
LOC:     331671     331671
ERR:          0
MIS:          0

###############################################################################################
nas:~# dmesg
Linux version 2.6.18.1.smp.1.0.HP_E800_SMP (root@nas) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Thu Nov 16 15:26:09 SGT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f6f60
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6f40
ACPI: RSDT (v001 HP     HWPC20F  0x06040012  PTL 0x00000000) @ 0x1fffc5eb
ACPI: FADT (v001 HP     HWPC20F  0x06040012 PTL  0x00000001) @ 0x1ffffb05
ACPI: MADT (v001 PTLTD    APIC   0x06040012  LTP 0x00000000) @ 0x1ffffb79
ACPI: BOOT (v001 HP     HWPC20F  0x06040012  PTL 0x00000001) @ 0x1ffffbd9
ACPI: DSDT (v001     HP  HWPC20F 0x06040012 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1208
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 2, version 17, address 0xfec01000, GSI 16-31
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 666.786 MHz processor.
Built 1 zonelists.  Total pages: 131056
Kernel command line: root=/dev/hda1 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 516260k/524224k available (1781k kernel code, 7472k reserved, 665k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1334.32 BogoMIPS (lpj=2668659)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel Pentium III (Coppermine) stepping 03
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1334.49 BogoMIPS (lpj=2668996)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2668.82 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had -2 usecs TSC skew, fixed it up.
CPU#1 had 2 usecs TSC skew, fixed it up.
Brought up 2 CPUs
migration_cost=739
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=7
PCI: Using configuration type 1
Setting up standard PCI resources
mtrr: your CPUs had inconsistent MTRRdefType settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Firmware left 0000:00:02.0 e100 interrupts enabled, disabling
Boot video device is 0000:00:07.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKU] (IRQs 5) *10
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK9] (IRQs 3 4 5 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: Blank IRQ resource
ACPI: Resource is not an IRQ entry
ACPI: PCI Interrupt Link [LNKX] (IRQs) *0, disabled.
ACPI: PCI Root Bridge [PCI1] (0000:05)
PCI: Probing PCI hardware (bus 05)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0xf50-0xf58 has been reserved
pnp: 00:05: ioport range 0x1100-0x111f could not be reserved
pnp: 00:05: ioport range 0x1200-0x121f could not be reserved
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1163680853.896:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = -1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 0000:00:05.0
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 18 (level, low) -> IRQ 177
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 177
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Hitachi HDS721680PLAT80, ATA DISK drive
ide0 at 0xe0802080-0xe0802087,0xe080208a on irq 177
Probing IDE interface ide1...
hdc: TSSTcorpDVD-ROM TS-H352A, ATAPI CD/DVD-ROM drive
ide1 at 0xe08020c0-0xe08020c7,0xe08020ca on irq 177
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x1890-0x1897, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1898-0x189f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: max request size: 64KiB
hda: 66055248 sectors (33820 MB) w/7384KiB Cache, CHS=16383/255/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 >
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.1 Nov 16 2006
TCP bic registered
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
NET: Registered protocol family 1
Adding 1365484k swap on /dev/hda5.  Priority:-1 extents:1 across:1365484k
EXT3 FS on hda1, internal journal
Generic RTC Driver v1.07
SCSI subsystem initialized
libata version 2.00 loaded.
sata_sil24 0000:05:02.0: version 0.3
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 21 (level, low) -> IRQ 185
ata1: SATA max UDMA/100 cmd 0xE08F0000 ctl 0x0 bmdma 0x0 irq 185
ata2: SATA max UDMA/100 cmd 0xE08F2000 ctl 0x0 bmdma 0x0 irq 185
ata3: SATA max UDMA/100 cmd 0xE08F4000 ctl 0x0 bmdma 0x0 irq 185
ata4: SATA max UDMA/100 cmd 0xE08F6000 ctl 0x0 bmdma 0x0 irq 185
scsi0 : sata_sil24
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_sil24
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi2 : sata_sil24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : sata_sil24
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/100
  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 1:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 2:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 3:0:0:0: Attached scsi disk sdc
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 17 (level, low) -> IRQ 193
e1000: 0000:00:04.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:bc:ae:b5
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 20 (level, low) -> IRQ 201
e100: eth1: e100_probe: addr 0xfd100000, irq 201, MAC addr 00:E0:18:6B:8E:B4
ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 24 (level, low) -> IRQ 209
sym0: <896> rev 0x7 at pci 0000:05:05.0 irq 209
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi4 : sym-2.2.3
ACPI: PCI Interrupt 0000:05:05.1[B] -> GSI 25 (level, low) -> IRQ 217
sym1: <896> rev 0x7 at pci 0000:05:05.1 irq 217
sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi5 : sym-2.2.3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:0f.2[A] -> Link [LNKU] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:0f.2: OHCI Host Controller
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: irq 5, io mem 0xfd103000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
input: PC Speaker as /class/input/input2
pnp: Evaluate _CRS failed
pnp: Failed to activate device 00:0a.
parport_pc: probe of 00:0a failed with error -5
floppy0: no floppy controllers found
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
NET: Registered protocol family 17
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

###############################################################################################
#

CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_UID16=y
CONFIG_SYSCTL=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_DEFAULT_AS=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_PREEMPT_NONE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_VMSPLIT_3G_OPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_COMPAT_VDSO=y
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IP_VS=m
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRCOMM=m
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y
CONFIG_IRTTY_SIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_VIA_FIR=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_SCSI_SATA=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIL24=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
CONFIG_NS83820=m
CONFIG_R8169=m
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
CONFIG_BNX2=m
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_DTLK=m
CONFIG_DRM=m
CONFIG_DRM_R128=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_RAW_DRIVER=m
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_HDAPS=m
CONFIG_VIDEO_V4L2=y
CONFIG_DVB=y
CONFIG_DVB_CORE=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_STV0297=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_PLL=m
CONFIG_DVB_LNBP21=m
CONFIG_FIRMWARE_EDID=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_MON=y
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_EDAC=y
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_POLL=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFSPLUS_FS=m
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_CIFS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y
