Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBHGLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBHGLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:11:36 -0500
Received: from mailgate01.ctimail.com ([203.186.94.111]:57314 "EHLO
	mailgate01.ctimail.com") by vger.kernel.org with ESMTP
	id S262130AbUBHGL1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:11:27 -0500
Message-Id: <200402080610.i186AEp19152@mailgate01.ctimail.com>
From: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>
To: <linux-kernel@vger.kernel.org>
Subject: USB 2.0 mass storage problem
Date: Sun, 8 Feb 2004 14:11:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPuCmCmVBAygxvcTLOCehEYopySIQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have my laptop installed with Fedora Core (Kernel 2.4.22), and I want to
use a USB 2.0 120G hard drive via a Cardbus USB2.0 adaptor.
I plug the Cardbus card, and then the USB2.0 HD, (after a few config) linux
recognize my HD and I can use mount /dev/sda1 /mnt/extra to mount it.

HOWEVER, the disk fail after a few read or write operation. From error log:
Feb  8 12:57:15 wind kernel: SCSI device sda: 234441648 512-byte hdwr
sectors (120034 MB) Feb  8 12:57:15 wind kernel: sda: assuming drive cache:
write through Feb  8 12:57:16 wind kernel:  sda: sda1 sda2 < sda5 > Feb  8
12:57:16 wind kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun
0 Feb  8 12:57:16 wind kernel: EXT2-fs warning: mounting unchecked fs,
running e2fsck is recommended Feb  8 13:13:40 wind kernel: SCSI error : <0 0
0 0> return code = 0x6000000 Feb  8 13:13:40 wind kernel: end_request: I/O
error, dev sda, sector 76276607 Feb  8 13:15:30 wind kernel: SCSI error : <0
0 0 0> return code = 0x6000000 Feb  8 13:15:30 wind kernel: end_request: I/O
error, dev sda, sector 76276615

The drive than cannot recognize by the USB2.0 port again until reboot.

The same hardware work perfectly in Windows 2000, It works too when I
connect the USB to a USB1.0 port in my machine, so I'm quite sure it is the
problem with the ehci-hcd driver.

I have updated to 2.6.2 kernel, it doesn¡¦t help. 
Kernel setting like "acpi=off" "pci=biosirq" "acpi=off" doesn¡¦t help
neither.

Could any give me a help? Thank you very much!

Following is the related info:

[root@wind root]# lspci
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad 00:04.0 VGA
compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13) 00:06.0
Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller
Audio Device (rev 01) 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA
Bridge [Aladdin IV] 00:0e.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 08) 00:10.0 IDE interface: ALi Corporation M5229 IDE
(rev c3) 00:11.0 Bridge: ALi Corporation M7101 PMU 00:12.0 CardBus bridge:
Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support
(rev 32) 00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
01:00.0 USB Controller: NEC Corporation USB (rev 43)
01:00.1 USB Controller: NEC Corporation USB (rev 43)
01:00.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

[root@wind root]# dmesg output
Linux version 2.6.2 (root@wind.siuying.net) (gcc version 3.3.2 20031022 (Red
Hat Linux 3.3.2-1)) #1 Sat Feb 7 21:25:54 HKT 2004 BIOS-provided physical
RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000016f5c000 (usable)
 BIOS-e820: 0000000016f5c000 - 0000000016f60000 (reserved)
 BIOS-e820: 0000000016f60000 - 0000000016f70000 (ACPI data)
 BIOS-e820: 0000000016f70000 - 0000000017070000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved) 0MB HIGHMEM
available.
367MB LOWMEM available.
On node 0 totalpages: 94044
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 89948 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f01a0
ACPI: RSDT (v001 TOSHIB L1       0x20010130 TASM 0x04010000) @ 0x16f60000
ACPI: FADT (v002 TOSHIB L1       0x20010130 TASM 0x04010000) @ 0x16f60058
ACPI: DBGP (v001 TOSHIB L1       0x20010130 TASM 0x04010000) @ 0x16f600dc
ACPI: BOOT (v001 TOSHIB L1       0x20010130 TASM 0x04010000) @ 0x16f60030
ACPI: DSDT (v001 TOSHIB GT       0x20010621 MSFT 0x0100000a) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/123 acpi=on pci=biosirq Initializing
CPU#0 PID hash table entries: 2048 (order 11: 16384 bytes) Detected 597.505
MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 368728k/376176k available (1652k kernel code, 6660k reserved, 691k
data, 160k init, 0k highmem) Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Calibrating delay loop... 1179.64 BogoMIPS Dentry cache hash table entries:
65536 (order: 6, 262144 bytes) Inode-cache hash table entries: 32768 (order:
5, 131072 bytes) Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd Freeing initrd memory: 180k freed
CPU:     After generic identify, caps: 0080893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0080893f 0081813f 0000000e 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.2.5-8-148
CPU: 20010503 11:00 official release 4.2.5#1
CPU:     After all inits, caps: 0080893f 0081813f 0000000e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03 Checking 'hlt'
instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfcd73, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ
255
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 7
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS not found.
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo Uniform
Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ
255
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xedb0-0xedb7, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device: DMA forced
    ide1: BM-DMA at 0xedb8-0xedbf, BIOS settings: hdc:DMA, hdd:DMA
hda: TOSHIBA MK1016GAP, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 19640880 sectors (10056 MB), CHS=19485/16/63, UDMA(66)
 hda: hda1 hda2 < hda5 hda6 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 160k freed
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (41 C)
Toshiba Laptop ACPI Extras version 0.16
EXT3 FS on hda5, internal journal
Adding 522072k swap on /dev/hda6.  Priority:-1 extents:1 Linux Kernel Card
Services
  options:  [pci] [cardbus] [pm]
Intel ISA PCIC probe: not found.
PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:00:12.0 [1179:0001]
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x1e0-0x1e7 0x3c0-0x3df
0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
kudzu: numerical sysctl 1 23 is obsolete.
request_module: failed /sbin/modprobe -- char-major-4-64. error = 256 SCSI
subsystem initialized
request_module: failed /sbin/modprobe -- char-major-21-6. error = 256
request_module: failed /sbin/modprobe -- char-major-21-18. error = 256
request_module: failed /sbin/modprobe -- char-major-21. error = 256
inserting floppy driver for 2.6.2
floppy0: no floppy controllers found
request_module: failed /sbin/modprobe -- block-major-2-0. error = 256
inserting floppy driver for 2.6.2
floppy0: no floppy controllers found
request_module: failed /sbin/modprobe -- block-major-2. error = 256
kudzu: numerical sysctl 1 49 is obsolete.
Intel(R) PRO/100 Network Driver - version 2.3.30-k1 Copyright (c) 2003 Intel
Corporation

divert: allocating divert_blk for eth0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

kudzu: numerical sysctl 1 49 is obsolete.
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Enabling device 0000:01:00.2 (0000 -> 0002)
ACPI: No IRQ known for interrupt pin C of device 0000:01:00.2 ehci_hcd 0000:
01:00.2: EHCI Host Controller ehci_hcd 0000:01:00.2: irq 11, pci mem
d784d000 ehci_hcd 0000:01:00.2: new USB bus registered, assigned bus number
1 ehci_hcd 0000:01:00.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29 hub
1-0:1.0: USB hub found hub 1-0:1.0: 5 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:14.0: OHCI Host Controller ohci_hcd 0000:00:14.0: irq 7,
pci mem d784f000 ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus
number 2 hub 2-0:1.0: USB hub found hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0000:01:00.0 (0000 -> 0002) ohci_hcd 0000:01:00.0: OHCI
Host Controller
PCI: Setting latency timer of device 0000:01:00.0 to 64 ohci_hcd 0000:01:00.
0: irq 11, pci mem d78c8000 ohci_hcd 0000:01:00.0: new USB bus registered,
assigned bus number 3 hub 3-0:1.0: USB hub found hub 3-0:1.0: 3 ports
detected
PCI: Enabling device 0000:01:00.1 (0000 -> 0002)
ACPI: No IRQ known for interrupt pin B of device 0000:01:00.1 ohci_hcd 0000:
01:00.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:01:00.1 to 64 ohci_hcd 0000:01:00.
1: irq 11, pci mem d78ff000 ohci_hcd 0000:01:00.1: new USB bus registered,
assigned bus number 4 hub 4-0:1.0: USB hub found hub 4-0:1.0: 2 ports
detected
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256 hub
1-0:1.0: new USB device on port 2, assigned address 2 Initializing USB Mass
Storage driver...
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256 scsi0
: SCSI emulation for USB Mass Storage devices
  Vendor: WDC WD12  Model: 00JB-00DUA3       Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured USB Mass Storage device
found at 2
drivers/usb/core/usb.c: registered new driver usb-storage USB Mass Storage
support registered.
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256
updfstab: numerical sysctl 1 23 is obsolete.
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256
inserting floppy driver for 2.6.2
floppy0: no floppy controllers found
request_module: failed /sbin/modprobe -- block-major-2-0. error = 256
inserting floppy driver for 2.6.2
floppy0: no floppy controllers found
request_module: failed /sbin/modprobe -- block-major-2. error = 256
request_module: failed /sbin/modprobe -- block-major-8-1. error = 256 SCSI
device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: assuming drive cache: write through
 sda: sda1 sda2 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0 EXT2-fs warning:
mounting unchecked fs, running e2fsck is recommended SCSI error : <0 0 0 0>
return code = 0x6000000
end_request: I/O error, dev sda, sector 76276607 SCSI error : <0 0 0 0>
return code = 0x6000000
end_request: I/O error, dev sda, sector 76276615

--
Seeing is believing
Siuying





