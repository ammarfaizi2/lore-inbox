Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUFQRav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUFQRav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUFQRav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:30:51 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:31179 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S261179AbUFQRaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:30:16 -0400
Message-ID: <40D1D522.3050806@ThinRope.net>
Date: Fri, 18 Jun 2004 02:30:10 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [BUG?] "bad: scheduling while atomic!" after modprobe -r aic7xxx
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030702000705030808050509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702000705030808050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I was testing 2.6.7, now with LOCAL_APIC and it seems to be working (though my SATA disk is not connected).

However when trying to remove aic7xxx a lot of badness is outputed. Trying to isolate the problem I tested without the APIC (in BIOS and kernel) but the results were the same.

I am running on ASUS A7N8X-Deluxe (v2.0) MB with Nforce2 chipset.
Apart from the badness, no crash or freeze is happening.
I can reproduce it as many times as I try (=everytime).

Attaching the relevant debug output below, the two sets of files *_after.log and *_after_modprobe-r.log are taken after i loaded and unloaded the aic7xxx module.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/



--------------030702000705030808050509
Content-Type: text/plain;
 name="boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.log"

Linux version 2.6.7-KK1_sata (root@sata) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #4 Fri Jun 18 01:30:43 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Asus A7N8X v2 detected: BIOS IRQ0 pin2 override will be ignored
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda5 hde=none hdg=none
ide_setup: hde=none
ide_setup: hdg=none
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1837.348 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515780k/524224k available (2190k kernel code, 7684k reserved, 942k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3629.05 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1837.0265 MHz.
..... host bus clock speed is 334.0048 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
00:00:01[A] -> 2-23 -> IRQ 23 level high
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
00:00:02[A] -> 2-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
00:00:02[B] -> 2-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
00:00:02[C] -> 2-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
00:01:06[A] -> 2-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
00:01:06[B] -> 2-17 -> IRQ 17 level high
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
00:01:06[C] -> 2-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
00:01:06[D] -> 2-19 -> IRQ 19 level high
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    41
 03 001 01  0    0    0   0   0    1    1    49
 04 001 01  0    0    0   0   0    1    1    51
 05 001 01  0    0    0   0   0    1    1    59
 06 001 01  0    0    0   0   0    1    1    61
 07 001 01  0    0    0   0   0    1    1    69
 08 001 01  0    0    0   0   0    1    1    71
 09 001 01  0    1    0   0   0    1    1    79
 0a 001 01  0    0    0   0   0    1    1    81
 0b 001 01  0    0    0   0   0    1    1    89
 0c 001 01  0    0    0   0   0    1    1    91
 0d 001 01  0    0    0   0   0    1    1    99
 0e 001 01  0    0    0   0   0    1    1    A1
 0f 001 01  0    0    0   0   0    1    1    A9
 10 001 01  1    1    0   0   0    1    1    D1
 11 001 01  1    1    0   0   0    1    1    D9
 12 001 01  1    1    0   0   0    1    1    E1
 13 001 01  1    1    0   0   0    1    1    E9
 14 001 01  1    1    0   0   0    1    1    C9
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   0   0    1    1    B1
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd8000000
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1000BB-00CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD2000JB-00DUA0, ATA DISK drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 18
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 >
hdc: max request size: 1024KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 < p5 p6 > p4
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Adding 1951888k swap on /dev/hda2.  Priority:-1 extents:1
Adding 1775172k swap on /dev/hdc4.  Priority:-2 extents:1
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hdc6: found reiserfs format "3.6" with standard journal
ReiserFS: hdc6: using ordered data mode
ReiserFS: hdc6: journal params: device hdc6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc6: checking transaction log (hdc6)
ReiserFS: hdc6: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub

--------------030702000705030808050509
Content-Type: text/plain;
 name="dmesg_after.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_after.log"

SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1008
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0

--------------030702000705030808050509
Content-Type: text/plain;
 name="lsmod_after.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod_after.log"

Module                  Size  Used by
sr_mod                 18404  0 
aic7xxx               166968  0 
scsi_mod               82880  2 sr_mod,aic7xxx
usbcore               112352  1 

--------------030702000705030808050509
Content-Type: text/plain;
 name="interrupts_with_aic7xxx_loaded"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts_with_aic7xxx_loaded"

           CPU0       
  0:     495132    IO-APIC-edge  timer
  1:       1558    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       1665    IO-APIC-edge  ide0
 15:        959    IO-APIC-edge  ide1
 19:        454   IO-APIC-level  aic7xxx
NMI:          0 
LOC:     495034 
ERR:          0
MIS:          0

--------------030702000705030808050509
Content-Type: text/plain;
 name="dmesg_after_modprobe-r.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_after_modprobe-r.log"

>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c016bfc2>] iput+0x62/0x80
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<e0ad9222>] sr_remove+0x22/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c027cd08>] as_next_request+0x38/0x50
 [<c0274bb6>] elv_next_request+0x16/0x110
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<e0b0f1fa>] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
 [<e0b0f46e>] scsi_wait_req+0x7e/0xb0 [scsi_mod]
 [<e0b0f360>] scsi_wait_done+0x0/0x90 [scsi_mod]
 [<e0ad9491>] sr_do_ioctl+0x91/0x2b0 [sr_mod]
 [<e0ad9175>] sr_packet+0x25/0x40 [sr_mod]
 [<c02a75f1>] cdrom_get_disc_info+0x61/0xb0
 [<c02a374b>] cdrom_mrw_exit+0x1b/0x70
 [<c016bfc2>] iput+0x62/0x80
 [<c02a3364>] unregister_cdrom+0x94/0xe0
 [<c0168da2>] dput+0x22/0x210
 [<e0ad91d2>] sr_kref_release+0x42/0x70 [sr_mod]
 [<c022738a>] kref_put+0x1a/0x20
 [<e0ad9237>] sr_remove+0x37/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c027cd08>] as_next_request+0x38/0x50
 [<c0274bb6>] elv_next_request+0x16/0x110
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<e0b0f1fa>] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
 [<e0b0f46e>] scsi_wait_req+0x7e/0xb0 [scsi_mod]
 [<e0b0f360>] scsi_wait_done+0x0/0x90 [scsi_mod]
 [<e0ad9491>] sr_do_ioctl+0x91/0x2b0 [sr_mod]
 [<e0ad9175>] sr_packet+0x25/0x40 [sr_mod]
 [<c02a762b>] cdrom_get_disc_info+0x9b/0xb0
 [<c02a374b>] cdrom_mrw_exit+0x1b/0x70
 [<c016bfc2>] iput+0x62/0x80
 [<c02a3364>] unregister_cdrom+0x94/0xe0
 [<c0168da2>] dput+0x22/0x210
 [<e0ad91d2>] sr_kref_release+0x42/0x70 [sr_mod]
 [<c022738a>] kref_put+0x1a/0x20
 [<e0ad9237>] sr_remove+0x37/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c027cd08>] as_next_request+0x38/0x50
 [<c0274bb6>] elv_next_request+0x16/0x110
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<e0b0f1fa>] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
 [<e0b0f46e>] scsi_wait_req+0x7e/0xb0 [scsi_mod]
 [<e0b0f360>] scsi_wait_done+0x0/0x90 [scsi_mod]
 [<e0ad9491>] sr_do_ioctl+0x91/0x2b0 [sr_mod]
 [<e0ad9175>] sr_packet+0x25/0x40 [sr_mod]
 [<c02a371c>] cdrom_flush_cache+0x4c/0x60
 [<c02a3768>] cdrom_mrw_exit+0x38/0x70
 [<c016bfc2>] iput+0x62/0x80
 [<c02a3364>] unregister_cdrom+0x94/0xe0
 [<c0168da2>] dput+0x22/0x210
 [<e0ad91d2>] sr_kref_release+0x42/0x70 [sr_mod]
 [<c022738a>] kref_put+0x1a/0x20
 [<e0ad9237>] sr_remove+0x37/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<c0270f40>] device_del+0x70/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c0168da2>] dput+0x22/0x210
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<c0272bd8>] class_device_del+0x88/0xb0
 [<c0272c13>] class_device_unregister+0x13/0x30
 [<e0b1300e>] scsi_remove_device+0x3e/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c016bfc2>] iput+0x62/0x80
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<e0ad9222>] sr_remove+0x22/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<c0270f40>] device_del+0x70/0xa0
 [<e0b13026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e0b12334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e0b0c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c0168da2>] dput+0x22/0x210
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<c0272bd8>] class_device_del+0x88/0xb0
 [<c0272c13>] class_device_unregister+0x13/0x30
 [<e0b0c0db>] scsi_remove_host+0x4b/0x60 [scsi_mod]
 [<e0b685f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<e0b0c281>] scsi_host_dev_release+0x81/0x90 [scsi_mod]
 [<c016bfc2>] iput+0x62/0x80
 [<c0168da2>] dput+0x22/0x210
 [<c0270b98>] device_release+0x58/0x60
 [<c0223833>] kobject_del+0x23/0x40
 [<c0223968>] kobject_cleanup+0x98/0xa0
 [<e0b68605>] ahc_platform_free+0x155/0x160 [aic7xxx]
 [<e0b5b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e0b6dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e0b6e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e0b6d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb


--------------030702000705030808050509
Content-Type: text/plain;
 name="lsmod_after_modprobe-r.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod_after_modprobe-r.log"

Module                  Size  Used by
sr_mod                 18404  0 
scsi_mod               82880  1 sr_mod
usbcore               112352  1 

--------------030702000705030808050509
Content-Type: text/plain;
 name="lspci.output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.output"

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:07.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil 3112/3112A ] (rev 02)
0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast Ethernet Controller [Tornado] (rev 40)
0000:03:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)
sata aic-debug # lspci -vv -s 07
0000:01:07.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at a000 [disabled]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]


--------------030702000705030808050509--
