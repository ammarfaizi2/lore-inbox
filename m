Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTIWWwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTIWWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:52:45 -0400
Received: from s383.jpl.nasa.gov ([137.79.94.127]:21656 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S261649AbTIWWwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:52:35 -0400
Message-ID: <3F70CEA3.70905@jpl.nasa.gov>
Date: Tue, 23 Sep 2003 15:52:19 -0700
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: expert@linux-mandrake.com, linux-xfs@oss.sgi.com
Subject: File access error fixed with mount -o remount ?
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020005090909010500090005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005090909010500090005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have run across a problem with files that seem to become randomly 
"broken" but after a "mount -o remount" the files start working normally 
again.

I emailed the lkml even tho the kernel is a distro kernel hoping someone 
has at least an idea on what area of the kernel would *most likley* 
cause this problem to happen.

The kernel running is "2.4.19-35mdkenterprise". This is a distro kernel 
that is basically 2.4.19+patches.

[root@micro root]# cat /export/project/mam/jshupe/mam_ta/gizmos/ft/Makefile
cat: /export/project/mam/jshupe/mam_ta/gizmos/ft/Makefile: Invalid argument
[root@micro root]$ ls -al 
/export/project/mam/jshupe/mam_ta/gizmos/ft/Makefile
Makefile
-rw-rw-r--    1 jshupe   optint       1.2K Jun 24 16:40 Makefile

Other files in the same directory do not have this problem.

the filesystem is mounted like this:
[root@micro root]# cat /proc/mounts | grep project
/dev/sdb1 /export/project xfs rw 0 0
/dev/sdc1 /export/project1 xfs rw 0 0

This fixes the problem:

[root@micro root]# mount -o remount /export/project
[root@micro root]# cat /export/project/mam/jshupe/mam_ta/gizmos/ft/Makefile
[Makefile contents print out with no errors or data curruption]

I attached the boot up logs if needed.

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry and Large Optical Systems
Phone: 818 354 2903
driver@jpl.nasa.gov

--------------020005090909010500090005
Content-Type: text/plain;
 name="micro.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="micro.dmesg"

Linux version 2.4.19-35mdkenterprise (qateam@updates.mandrakesoft.com) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 SMP Wed Jul 9 15:03:47 MDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff77000 (usable)
 BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff79000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
Advanced speculative caching feature not present
On node 0 totalpages: 262007
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32631 pages.
ACPI: RSDP (v000 DELL                       ) @ 0x000fd550
ACPI: RSDT (v001 DELL    WS 530  00000.00008) @ 0x000fd564
ACPI: FADT (v001 DELL    WS 530  00000.00008) @ 0x000fd598
ACPI: SSDT (v001   DELL    st_ex 00000.04096) @ 0xfffe62b8
ACPI: MADT (v001 DELL    WS 530  00000.00008) @ 0x000fd60c
ACPI: BOOT (v001 DELL    WS 530  00000.00008) @ 0x000fd678
ACPI: DSDT (v001   DELL    dt_ex 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Unknown CPU [15:1] APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Unknown CPU [15:1] APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 530       APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 2
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux-enterpris ro root=805 devfs=mount hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1694.864 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 1032304k/1048028k available (1395k kernel code, 15340k reserved, 486k data, 152k init, 130524k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
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
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
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
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Total of 2 processors activated (6763.31 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
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
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
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
..... CPU clock speed is 1694.7637 MHz.
..... host bus clock speed is 99.6918 MHz.
cpu: 0, clocks: 996918, slice: 332306
CPU0<T0:996912,T1:664592,D:14,S:332306,C:996918>
cpu: 1, clocks: 996918, slice: 332306
CPU1<T0:996912,T1:332288,D:12,S:332306,C:996918>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfbe4e, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I14,P0) -> 22
PCI->APIC IRQ transform: (B4,I11,P0) -> 23
PCI->APIC IRQ transform: (B4,I12,P0) -> 16
PCI->APIC IRQ transform: (B4,I13,P0) -> 17
PCI->APIC IRQ transform: (B4,I14,P0) -> 18
PCI->APIC IRQ transform: (B4,I15,P0) -> 19
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller on PCI bus 00 dev f9
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99b
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
ide-floppy driver 0.99b
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 486k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAN3184MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 143374744 512-byte hdwr sectors (73408 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1
SGI XFS with ACLs, DMAPI, realtime, quota, no debug enabled
XFS mounting filesystem sd(8,5)
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 16:04:03 Jul  9 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1f.2 to 64
usb-uhci.c: USB UHCI at I/O 0xff80, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
usb-uhci.c: USB UHCI at I/O 0xff60, IRQ 23
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usbdevfs: remount parameter error
Adding Swap: 1020088k swap-space (priority -1)
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8160B   Rev: 2.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
XFS mounting filesystem sd(8,7)
XFS mounting filesystem sd(8,8)
XFS mounting filesystem sd(8,17)
XFS mounting filesystem sd(8,33)
ohci1394: $Rev: 530 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fe1ff000-fe1ff800]  Max Packet=[2048]
ieee1394: Host added: Node[00:1023]  GUID[805b0600077c8700]  [Linux OHCI-1394]
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
04:0b.0: 3Com PCI 3c905C Tornado at 0xdc80. Vers LK1.1.16
04:0e.0: 3Com PCI 3c905C Tornado at 0xd880. Vers LK1.1.16
04:0f.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.16
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
inserting floppy driver for 2.4.19-35mdkenterprise
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

--------------020005090909010500090005--

