Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266984AbSLJWu2>; Tue, 10 Dec 2002 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbSLJWu2>; Tue, 10 Dec 2002 17:50:28 -0500
Received: from inetgw.eenterprises.com ([212.27.173.62]:11782 "EHLO
	inetgw.eenterprises.com") by vger.kernel.org with ESMTP
	id <S266984AbSLJWuQ>; Tue, 10 Dec 2002 17:50:16 -0500
Message-ID: <E8EE16A19D69D611B40000D0B73EBB250F06BE@exchange.intern.eproduction.ch>
From: =?iso-8859-1?Q?=22R=FCegg=2C_Peter_H=2E=22?= 
	<peter.ruegg@eenterprises.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Complete freeze with 2.4.20 on 4-proc IBM xSeries 350
Date: Tue, 10 Dec 2002 23:58:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear all,

I'm experiencing serious problems with Kernel 2.4.20 on a IBM xSeries 350
machine, having 4 700 MHz processors and 4 GB RAM (same on another machine
with the same configuration, but only 3 GB RAM). The machine just com-
pletely freezes after some time, ranging from 20 minutes to 3 hours. It
is running IBM DB/2 with quite some load, the base system is RedHat 7.2
with all the updates applied. There is no oops or other fault, just a
plain freeze.

I first thought, this might be related to the ips-driver, as the firmware
wasn't up-to-date on the first run, but updating this didn't help at all.

2.4.20 is the first 2.4-kernel I ran, thinking that earlier ones might
not be ready for real production systems yet. The machine has been rock-
stable on several 2.2-kernels for months.

The only change I did to the source was some small patch to sem.h which
set SEMMNI and SEMMSL to 1024, and SEMOPM to 512.

I had a small loop on a network-shell that simply wrote the date to a
file as well as stdout. This seems to work 5 to 10 seconds longer on
the network than on the disc.

If anybody has any idea what else I could try I'd be more than happy -
we're experiencing a bit of a problem with "only" 2GB RAM... I'm willing
to try anything, but as this is a production machine it could take some
time to find a timeframe.

Attached there's a dmesg as well as the kernel-config if that helps any-
thing.

Greets


Peter H. Ruegg
Systems-/Networkadministrator RHCE eEnterprises Technology

-
--8<------------------------------------------------------------------------
-
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int
i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}




Dec 10 21:42:33 db03 syslogd 1.4.1: restart.
Dec 10 21:42:33 db03 syslog: syslogd startup succeeded
Dec 10 21:42:33 db03 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Dec 10 21:42:33 db03 kernel: Inspecting /boot/System.map-2.4.20-0.2.smp
Dec 10 21:42:33 db03 syslog: klogd startup succeeded
Dec 10 21:42:33 db03 keytable: Loading keymap:  succeeded
Dec 10 21:42:33 db03 kernel: Loaded 18185 symbols from
/boot/System.map-2.4.20-0.2.smp.
Dec 10 21:42:33 db03 kernel: Symbols match kernel version 2.4.20.
Dec 10 21:42:33 db03 kernel: Loaded 11 symbols from 2 modules.
Dec 10 21:42:33 db03 kernel: Linux version 2.4.20-0.2.smp
(root@devint.eproduction.ch) (gcc version 2.96 20000731 (Red Hat Linux 7.2
2.96-112.7.2)) #1 SMP Tue Dec 10 21:01:29 CET 2002
Dec 10 21:42:33 db03 kernel: BIOS-provided physical RAM map:
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 0000000000000000 - 000000000009c800
(usable)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 000000000009c800 - 00000000000a0000
(reserved)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 0000000000100000 - 00000000eb7f9380
(usable)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 00000000eb7f9380 - 00000000eb800000
(ACPI data)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
Dec 10 21:42:33 db03 kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
Dec 10 21:42:33 db03 kernel: 2871MB HIGHMEM available.
Dec 10 21:42:33 db03 keytable: Loading system font:  succeeded
Dec 10 21:42:33 db03 kernel: 896MB LOWMEM available.
Dec 10 21:42:33 db03 kernel: found SMP MP-table at 0009c9d0
Dec 10 21:42:33 db03 kernel: hm, page 0009c000 reserved twice.
Dec 10 21:42:33 db03 kernel: hm, page 0009d000 reserved twice.
Dec 10 21:42:33 db03 kernel: hm, page 0009c000 reserved twice.
Dec 10 21:42:33 db03 kernel: hm, page 0009d000 reserved twice.
Dec 10 21:42:33 db03 random: Initializing random number generator:
succeeded
Dec 10 21:42:33 db03 kernel: WARNING: MP table in the EBDA can be UNSAFE,
contact linux-smp@vger.kernel.org if you experience SMP problems!
Dec 10 21:42:33 db03 kernel: On node 0 totalpages: 964601
Dec 10 21:42:33 db03 kernel: zone(0): 4096 pages.
Dec 10 21:42:33 db03 kernel: zone(1): 225280 pages.
Dec 10 21:42:33 db03 kernel: zone(2): 735225 pages.
Dec 10 21:42:33 db03 kernel: Intel MultiProcessor Specification v1.4
Dec 10 21:42:34 db03 kernel:     Virtual Wire compatibility mode.
Dec 10 21:42:34 db03 ntpd[610]: ntpd 4.1.0 Wed Sep  5 06:54:30 EDT 2001 (1)
Dec 10 21:42:34 db03 ntpd: ntpd startup succeeded
Dec 10 21:42:34 db03 kernel: OEM ID: IBM ENSW Product ID: NF 6000R SMP APIC
at: 0xFEE00000
Dec 10 21:42:34 db03 kernel: Processor #3 Pentium(tm) Pro APIC version 17
Dec 10 21:42:34 db03 kernel: Processor #0 Pentium(tm) Pro APIC version 17
Dec 10 21:42:34 db03 kernel: Processor #1 Pentium(tm) Pro APIC version 17
Dec 10 21:42:34 db03 kernel: Processor #2 Pentium(tm) Pro APIC version 17
Dec 10 21:42:34 db03 kernel: I/O APIC #14 Version 17 at 0xFEC00000.
Dec 10 21:42:34 db03 ntpd[610]: precision = 8 usec
Dec 10 21:42:34 db03 kernel: I/O APIC #13 Version 17 at 0xFEC01000.
Dec 10 21:42:34 db03 ntpd[610]: kernel time discipline status 0040
Dec 10 21:42:34 db03 kernel: Processors: 4
Dec 10 21:42:34 db03 kernel: IBM machine detected. Enabling interrupts
during APM calls.
Dec 10 21:42:34 db03 ntpd[610]: frequency initialized 229.359 from
/etc/ntp/drift
Dec 10 21:42:34 db03 kernel: Kernel command line: ro root=/dev/sda2
vga=extended
Dec 10 21:42:34 db03 kernel: Initializing CPU#0
Dec 10 21:42:34 db03 kernel: Detected 699.475 MHz processor.
Dec 10 21:42:34 db03 kernel: Console: colour VGA+ 80x50
Dec 10 21:42:34 db03 kernel: Calibrating delay loop... 1395.91 BogoMIPS
Dec 10 21:42:34 db03 kernel: Memory: 3809868k/3858404k available (1563k
kernel code, 48136k reserved, 573k data, 108k init, 2940900k highmem)
Dec 10 21:42:34 db03 kernel: Dentry cache hash table entries: 262144 (order:
9, 2097152 bytes)
Dec 10 21:42:34 db03 kernel: Inode cache hash table entries: 262144 (order:
9, 2097152 bytes)
Dec 10 21:42:34 db03 kernel: Mount-cache hash table entries: 65536 (order:
7, 524288 bytes)
Dec 10 21:42:34 db03 kernel: Buffer-cache hash table entries: 262144 (order:
8, 1048576 bytes)
Dec 10 21:42:34 db03 kernel: Page-cache hash table entries: 524288 (order:
9, 2097152 bytes)
Dec 10 21:42:34 db03 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 21:42:34 db03 kernel: CPU: L2 cache: 1024K
Dec 10 21:42:34 db03 kernel: Intel machine check architecture supported.
Dec 10 21:42:35 db03 kernel: Intel machine check reporting enabled on CPU#0.
Dec 10 21:42:35 db03 kernel: Enabling fast FPU save and restore... done.
Dec 10 21:42:35 db03 kernel: Enabling unmasked SIMD FPU exception support...
done.
Dec 10 21:42:35 db03 kernel: Checking 'hlt' instruction... OK.
Dec 10 21:42:35 db03 kernel: POSIX conformance testing by UNIFIX
Dec 10 21:42:35 db03 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 10 21:42:35 db03 snmpd: snmpd startup succeeded
Dec 10 21:42:35 db03 kernel: mtrr: detected mtrr type: Intel
Dec 10 21:42:35 db03 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 21:42:30 db03 sysctl: fs.file-max = 32768 
Dec 10 21:42:35 db03 kernel: CPU: L2 cache: 1024K
Dec 10 21:42:35 db03 sshd: Starting sshd: 
Dec 10 21:42:35 db03 kernel: Intel machine check reporting enabled on CPU#0.
Dec 10 21:42:30 db03 sysctl: kernel.msgmni = 1024 
Dec 10 21:42:30 db03 network: Setting network parameters:  succeeded 
Dec 10 21:42:30 db03 network: Bringing up interface lo:  succeeded 
Dec 10 21:42:35 db03 kernel: CPU0: Intel Pentium III (Cascades) stepping 01
Dec 10 21:42:35 db03 kernel: per-CPU timeslice cutoff: 2927.35 usecs.
Dec 10 21:42:35 db03 kernel: enabled ExtINT on CPU#0
Dec 10 21:42:35 db03 kernel: ESR value before enabling vector: 00000000
Dec 10 21:42:35 db03 sshd[647]: Server listening on 0.0.0.0 port 22.
Dec 10 21:42:35 db03 sshd: sshd startup succeeded
Dec 10 21:42:35 db03 kernel: ESR value after enabling vector: 00000000
Dec 10 21:42:35 db03 sshd: ^[[60G
Dec 10 21:42:35 db03 kernel: Booting processor 1/0 eip 2000
Dec 10 21:42:35 db03 kernel: Initializing CPU#1
Dec 10 21:42:36 db03 kernel: masked ExtINT on CPU#1
Dec 10 21:42:36 db03 sshd: 
Dec 10 21:42:36 db03 kernel: ESR value before enabling vector: 00000000
Dec 10 21:42:36 db03 rc: Starting sshd:  succeeded
Dec 10 21:42:36 db03 kernel: ESR value after enabling vector: 00000000
Dec 10 21:42:36 db03 kernel: Calibrating delay loop... 1395.91 BogoMIPS
Dec 10 21:42:36 db03 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 21:42:36 db03 kernel: CPU: L2 cache: 1024K
Dec 10 21:42:36 db03 kernel: Intel machine check reporting enabled on CPU#1.
Dec 10 21:42:36 db03 ucd-snmp[629]: UCD-SNMP version 4.2.5 
Dec 10 21:42:36 db03 kernel: CPU1: Intel Pentium III (Cascades) stepping 01
Dec 10 21:42:36 db03 kernel: Booting processor 2/1 eip 2000
Dec 10 21:42:36 db03 kernel: Initializing CPU#2
Dec 10 21:42:36 db03 kernel: masked ExtINT on CPU#2
Dec 10 21:42:36 db03 kernel: ESR value before enabling vector: 00000000
Dec 10 21:42:36 db03 kernel: ESR value after enabling vector: 00000000
Dec 10 21:42:36 db03 kernel: Calibrating delay loop... 1395.91 BogoMIPS
Dec 10 21:42:36 db03 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 21:42:36 db03 kernel: CPU: L2 cache: 1024K
Dec 10 21:42:36 db03 kernel: Intel machine check reporting enabled on CPU#2.
Dec 10 21:42:36 db03 kernel: CPU2: Intel Pentium III (Cascades) stepping 01
Dec 10 21:42:36 db03 kernel: Booting processor 3/2 eip 2000
Dec 10 21:42:36 db03 kernel: Initializing CPU#3
Dec 10 21:42:36 db03 kernel: masked ExtINT on CPU#3
Dec 10 21:42:36 db03 kernel: ESR value before enabling vector: 00000000
Dec 10 21:42:36 db03 kernel: ESR value after enabling vector: 00000000
Dec 10 21:42:36 db03 kernel: Calibrating delay loop... 1395.91 BogoMIPS
Dec 10 21:42:36 db03 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 21:42:36 db03 kernel: CPU: L2 cache: 1024K
Dec 10 21:42:36 db03 kernel: Intel machine check reporting enabled on CPU#3.
Dec 10 21:42:36 db03 kernel: CPU3: Intel Pentium III (Cascades) stepping 01
Dec 10 21:42:36 db03 kernel: Total of 4 processors activated (5583.66
BogoMIPS).
Dec 10 21:42:36 db03 kernel: ENABLING IO-APIC IRQs
Dec 10 21:42:36 db03 xinetd[680]: xinetd Version 2.3.7 started with libwrap
options compiled in.
Dec 10 21:42:36 db03 kernel: Setting 14 in the phys_id_present_map
Dec 10 21:42:36 db03 xinetd[680]: Started working: 0 available services
Dec 10 21:42:36 db03 kernel: ...changing IO-APIC physical APIC ID to 14 ...
ok.
Dec 10 21:42:36 db03 kernel: Setting 13 in the phys_id_present_map
Dec 10 21:42:36 db03 kernel: ...changing IO-APIC physical APIC ID to 13 ...
ok.
Dec 10 21:42:36 db03 kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Dec 10 21:42:36 db03 kernel: ..MP-BIOS bug: 8254 timer not connected to
IO-APIC
Dec 10 21:42:36 db03 kernel: ...trying to set up timer (IRQ0) through the
8259A ...  failed.
Dec 10 21:42:36 db03 kernel: ...trying to set up timer as Virtual Wire
IRQ... works.
Dec 10 21:42:37 db03 kernel: testing the IO APIC.......................
Dec 10 21:42:37 db03 kernel: 
Dec 10 21:42:37 db03 kernel: 
Dec 10 21:42:37 db03 kernel: .................................... done.
Dec 10 21:42:37 db03 kernel: Using local APIC timer interrupts.
Dec 10 21:42:37 db03 kernel: calibrating APIC timer ...
Dec 10 21:42:37 db03 kernel: ..... CPU clock speed is 699.3801 MHz.
Dec 10 21:42:37 db03 kernel: ..... host bus clock speed is 99.9113 MHz.
Dec 10 21:42:37 db03 kernel: cpu: 0, clocks: 999113, slice: 199822
Dec 10 21:42:37 db03 kernel: CPU0<T0:999104,T1:799280,D:2,S:199822,C:999113>
Dec 10 21:42:37 db03 kernel: cpu: 1, clocks: 999113, slice: 199822
Dec 10 21:42:37 db03 kernel: cpu: 2, clocks: 999113, slice: 199822
Dec 10 21:42:37 db03 kernel: cpu: 3, clocks: 999113, slice: 199822
Dec 10 21:42:37 db03 kernel: CPU2<T0:999104,T1:399632,D:6,S:199822,C:999113>
Dec 10 21:42:37 db03 kernel: CPU3<T0:999104,T1:199808,D:8,S:199822,C:999113>
Dec 10 21:42:37 db03 kernel: CPU1<T0:999104,T1:599456,D:4,S:199822,C:999113>
Dec 10 21:42:37 db03 kernel: checking TSC synchronization across CPUs:
passed.
Dec 10 21:42:37 db03 kernel: Waiting on wait_init_idle (map = 0xe)
Dec 10 21:42:37 db03 kernel: All processors have done init_idle
Dec 10 21:42:37 db03 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd32c,
last bus=8
Dec 10 21:42:37 db03 kernel: PCI: Using configuration type 1
Dec 10 21:42:37 db03 kernel: PCI: Probing PCI hardware
Dec 10 21:42:37 db03 kernel: PCI: Discovered peer bus 02
Dec 10 21:42:37 db03 kernel: PCI->APIC IRQ transform: (B0,I5,P0) -> 16
Dec 10 21:42:37 db03 kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 19
Dec 10 21:42:37 db03 kernel: PCI->APIC IRQ transform: (B2,I1,P0) -> 17
Dec 10 21:42:37 db03 kernel: PCI->APIC IRQ transform: (B2,I1,P1) -> 18
Dec 10 21:42:37 db03 kernel: PCI->APIC IRQ transform: (B2,I6,P0) -> 25
Dec 10 21:42:37 db03 kernel: Linux NET4.0 for Linux 2.4
Dec 10 21:42:37 db03 kernel: Based upon Swansea University Computer Society
NET3.039
Dec 10 21:42:37 db03 kernel: Initializing RT netlink socket
Dec 10 21:42:37 db03 kernel: Starting kswapd
Dec 10 21:42:37 db03 kernel: allocated 32 pages and 32 bhs reserved for the
highmem bounces
Dec 10 21:42:37 db03 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Dec 10 21:42:37 db03 kernel: Journalled Block Device driver loaded
Dec 10 21:42:37 db03 kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Dec 10 21:42:37 db03 kernel: pty: 256 Unix98 ptys configured
Dec 10 21:42:37 db03 kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec 10 21:42:37 db03 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 10 21:42:37 db03 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 10 21:42:37 db03 kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Dec 10 21:42:37 db03 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 10 21:42:37 db03 kernel: ServerWorks OSB4: IDE controller on PCI bus 00
dev 79
Dec 10 21:42:37 db03 kernel: ServerWorks OSB4: detected chipset, but driver
not compiled in!
Dec 10 21:42:37 db03 kernel: ServerWorks OSB4: chipset revision 0
Dec 10 21:42:37 db03 kernel: ServerWorks OSB4: not 100%% native mode: will
probe irqs later
Dec 10 21:42:37 db03 kernel:     ide0: BM-DMA at 0x0700-0x0707, BIOS
settings: hda:DMA, hdb:DMA
Dec 10 21:42:37 db03 kernel:     ide1: BM-DMA at 0x0708-0x070f, BIOS
settings: hdc:pio, hdd:pio
Dec 10 21:42:37 db03 kernel: hda: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM
drive
Dec 10 21:42:37 db03 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 10 21:42:37 db03 kernel: Floppy drive(s): fd0 is 1.44M
Dec 10 21:42:37 db03 kernel: FDC 0 is a National Semiconductor PC87306
Dec 10 21:42:37 db03 kernel: SCSI subsystem driver Revision: 1.00
Dec 10 21:42:37 db03 kernel: Red Hat/Adaptec aacraid driver, Dec 10 2002
Dec 10 21:42:37 db03 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Dec 10 21:42:37 db03 kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Dec 10 21:42:37 db03 kernel:         aic7899: Ultra160 Wide Channel A, SCSI
Id=7, 32/253 SCBs
Dec 10 21:42:37 db03 kernel: 
Dec 10 21:42:37 db03 kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Dec 10 21:42:37 db03 kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Dec 10 21:42:37 db03 kernel:         aic7899: Ultra160 Wide Channel B, SCSI
Id=7, 32/253 SCBs
Dec 10 21:42:37 db03 kernel: 
Dec 10 21:42:37 db03 kernel: blk: queue f7963c18, I/O limit 4095Mb (mask
0xffffffff)
Dec 10 21:42:37 db03 kernel: scsi2 : IBM PCI ServeRAID 5.10.21  <ServeRAID
4H>
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: SERVERAID
Rev: 1.00
Dec 10 21:42:37 db03 kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: SERVERAID
Rev: 1.00
Dec 10 21:42:37 db03 kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: SERVERAID
Rev: 1.00
Dec 10 21:42:37 db03 kernel:   Type:   Processor
ANSI SCSI revision: 02
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: YGLv3 S2
Rev: 0   
Dec 10 21:42:37 db03 kernel:   Type:   Processor
ANSI SCSI revision: 02
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: EXP300   S160
Rev: D014
Dec 10 21:42:37 db03 kernel:   Type:   Processor
ANSI SCSI revision: 03
Dec 10 21:42:37 db03 kernel:   Vendor: IBM       Model: EXP300   S160
Rev: D014
Dec 10 21:42:37 db03 kernel:   Type:   Processor
ANSI SCSI revision: 03
Dec 10 21:42:37 db03 kernel: megaraid: v1.18 (Release Date: Thu Oct 11
15:02:53 EDT 2001)
Dec 10 21:42:37 db03 kernel: megaraid: no BIOS enabled.
Dec 10 21:42:37 db03 kernel: Attached scsi disk sda at scsi2, channel 0, id
0, lun 0
Dec 10 21:42:37 db03 kernel: Attached scsi disk sdb at scsi2, channel 0, id
1, lun 0
Dec 10 21:42:37 db03 kernel: SCSI device sda: 35547136 512-byte hdwr sectors
(18200 MB)
Dec 10 21:42:37 db03 kernel: Partition check:
Dec 10 21:42:37 db03 kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8
>
Dec 10 21:42:37 db03 kernel: SCSI device sdb: 177735680 512-byte hdwr
sectors (91001 MB)
Dec 10 21:42:37 db03 kernel:  sdb: sdb1
Dec 10 21:42:37 db03 kernel: md: raid1 personality registered as nr 3
Dec 10 21:42:37 db03 kernel: md: raid5 personality registered as nr 4
Dec 10 21:42:37 db03 kernel: raid5: measuring checksumming speed
Dec 10 21:42:37 db03 kernel:    8regs     :  1291.200 MB/sec
Dec 10 21:42:37 db03 kernel:    32regs    :   606.800 MB/sec
Dec 10 21:42:37 db03 kernel:    pIII_sse  :  1406.000 MB/sec
Dec 10 21:42:37 db03 kernel:    pII_mmx   :  1599.600 MB/sec
Dec 10 21:42:37 db03 kernel:    p5_mmx    :  1668.400 MB/sec
Dec 10 21:42:38 db03 kernel: raid5: using function: pIII_sse (1406.000
MB/sec)
Dec 10 21:42:38 db03 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Dec 10 21:42:38 db03 kernel: md: Autodetecting RAID arrays.
Dec 10 21:42:38 db03 kernel: md: autorun ...
Dec 10 21:42:38 db03 kernel: md: ... autorun DONE.
Dec 10 21:42:38 db03 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 10 21:42:38 db03 kernel: IP Protocols: ICMP, UDP, TCP
Dec 10 21:42:38 db03 kernel: IP: routing cache hash table of 32768 buckets,
256Kbytes
Dec 10 21:42:38 db03 kernel: TCP: Hash tables configured (established 262144
bind 65536)
Dec 10 21:42:38 db03 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Dec 10 21:42:38 db03 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec 10 21:42:38 db03 kernel: Freeing unused kernel memory: 108k freed
Dec 10 21:42:38 db03 kernel: Real Time Clock Driver v1.10e
Dec 10 21:42:38 db03 kernel: Adding Swap: 2097136k swap-space (priority -1)
Dec 10 21:42:38 db03 kernel: pcnet32.c:v1.27b 01.10.2002
tsbogend@alpha.franken.de
Dec 10 21:42:38 db03 kernel: pcnet32: PCnet/FAST III 79C975 at 0x2200, 00 02
55 fc 32 5c assigned IRQ 16.
Dec 10 21:42:38 db03 kernel: eth0: registered as PCnet/FAST III 79C975
Dec 10 21:42:38 db03 kernel: pcnet32: 1 cards_found.
Dec 10 21:42:38 db03 kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Dec 10 21:42:39 db03 xinetd: xinetd startup succeeded
Dec 10 21:42:40 db03 sendmail: sendmail startup succeeded
Dec 10 21:42:40 db03 crond: crond startup succeeded
Dec 10 21:42:40 db03 atd: atd startup succeeded
Dec 10 21:42:41 db03 su(pam_unix)[789]: session opened for user db2admin by
(uid=0)
Dec 10 21:42:44 db03 su(pam_unix)[789]: session closed for user db2admin
Dec 10 21:42:44 db03 su(pam_unix)[875]: session opened for user db2iholy by
(uid=0)
Dec 10 21:42:46 db03 su(pam_unix)[875]: session closed for user db2iholy
Dec 10 21:42:46 db03 su(pam_unix)[940]: session opened for user db2ijava by
(uid=0)
Dec 10 21:42:47 db03 su(pam_unix)[940]: session closed for user db2ijava
Dec 10 21:42:47 db03 su(pam_unix)[1005]: session opened for user db2ietsb by
(uid=0)
Dec 10 21:42:49 db03 su(pam_unix)[1005]: session closed for user db2ietsb




CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_STATS=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPV6=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_ATALK=m
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_GDTH=y
CONFIG_SCSI_IPS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_EEPRO100=y
CONFIG_NE2K_PCI=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_SHAPER=m
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_RTC=m
CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

-----BEGIN PGP SIGNATURE-----
Version: PGP 7.0.4

iQA/AwUBPfZxrVcv4X0c4GKrEQJ5WACfZvlo9cK/se4vxUVx0uOuYRoIlrEAn2/9
TOMLYwBnm6iHgKqu5a+K9BWO
=v4EB
-----END PGP SIGNATURE-----
