Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJAQMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJAQMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUJAQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:09:55 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:52208 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264531AbUJAQIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:08:06 -0400
Subject: EXT3-fs errors after going into S1
From: Alexander Nyberg <alexn@dsv.su.se>
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1096646879.636.27.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 18:07:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was playing a bit with suspend on 2.6.9-rc3 (latest -bk tree) and noticed this.
I run the script below and do "echo -n 1 > /proc/acpi/sleep" maybe 2-3 times and
after that ext3 sends some stuff on my console.
Reproducible, happens with & without preempt. UP box running debian, no highmem.

#!/bin/sh
for i in 0 1 2 3 4 5 6 7 8 9
do
	find / &> /dev/null &
done

I also did a `fsck.ext3 -f -c /dev/hda9` to make sure there were no bad sectors.


Linux version 2.6.9-rc3 (alex@boxen) (gcc version 3.3.4 (Debian 1:3.3.4-12)) #1 Fri Oct 1 14:12:36 UTC 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 VT8371                                    ) @ 0x000f7aa0
ACPI: RSDT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 VT8371 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: BOOT_IMAGE=x86_kernel root=/dev/hda9 nmi_watchdog=1 profile=1 elevator=cfq console=tty0 console=ttyS1,38400 
kernel profiling enabled (shift: 1)
Initializing CPU#0
CPU 0 irqstacks, hard=c04d2000 soft=c04d1000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1400.232 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 508380k/524224k available (2618k kernel code, 14268k reserved, 838k data, 424k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2768.89 BogoMIPS (lpj=1384448)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After vendor identify, caps:  0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183fbff c1c7fbff 00000000 00000020
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ11 SCI: Level Trigger.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9<7>spurious 8259A interrupt: IRQ7.

ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:0f.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
SGI XFS with no debug enabled
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC35L040AVER07-0, ATA DISK drive
hdb: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdb: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
SLPB PCI0 USB0 USB1 MODM UAR1 UAR2 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 424k freed
Unable to find swap-space signature
EXT3 FS on hda9, internal journal
md: raidstart(pid 149) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6
md: could not open unknown-block(8,0).
md: autostart failed!
cdrom: open failed.
Unable to find swap-space signature
Stopping tasks: ==================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
Stopping tasks: ==================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
Stopping tasks: ========================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
Stopping tasks: ============================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
Remounting filesystem read-only
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #472830: rec_len % 4 != 0 - offset=132, inode=3538997, rec_len=55, name_len=40
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem


A second time:


Stopping tasks: ============================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
Stopping tasks: ============================|
Back to C!
APIC error on CPU0: 00(00)
Restarting tasks... done
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
Remounting filesystem read-only
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9): ext3_readdir: bad entry in directory #97988: rec_len is smaller than minimal - offset=516, inode=0, rec_len=0, name_len=0
EXT3-fs error (device hda9) in start_transaction: Readonly filesystem



