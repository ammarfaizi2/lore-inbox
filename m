Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWI2N57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWI2N57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 09:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWI2N57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 09:57:59 -0400
Received: from smtp.ono.com ([62.42.230.12]:52983 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932156AbWI2N54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 09:57:56 -0400
Date: Fri, 29 Sep 2006 15:57:38 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060929155738.7076f0c8@werewolf>
In-Reply-To: <20060928014623.ccc9b885.akpm@osdl.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.5.2cvs12 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 01:46:23 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> 
> 

aic7xxx oopses on boot:

PCI: Setting latency timer of device 0000:00:0e.0 to 64
IRQ handler type mismatch for IRQ 0
 [<c013c697>] setup_irq+0xb7/0x1b0
 [<c0274770>] ahc_linux_isr+0x0/0x50
 [<c013c833>] request_irq+0xa3/0xc0
 [<c027605c>] ahc_pci_map_int+0x2c/0x50
 [<c027167a>] ahc_pci_config+0x5ea/0xcf0
 [<c0208c00>] pci_bus_write_config_byte+0x30/0x70
 [<c02761dc>] ahc_linux_pci_dev_probe+0xec/0x1e0
 [<c01983b5>] sysfs_dirent_exist+0x45/0x70
 [<c019927b>] sysfs_create_link+0x7b/0x180
 [<c020d643>] pci_match_device+0x13/0xd0
 [<c0202b2f>] kobject_get+0xf/0x20
 [<c020d776>] pci_device_probe+0x56/0x80
 [<c024ea7b>] really_probe+0x3b/0xe0
 [<c024eb5f>] driver_probe_device+0x3f/0xa0
 [<c030c7a3>] klist_next+0x53/0xa0
 [<c024ecba>] __driver_attach+0x7a/0x80
 [<c024e01a>] bus_for_each_dev+0x3a/0x60
 [<c024e986>] driver_attach+0x16/0x20
 [<c024ec40>] __driver_attach+0x0/0x80
 [<c024e39c>] bus_add_driver+0x7c/0x1a0
 [<c020d935>] __pci_register_driver+0x65/0x90
 [<c0405749>] ahc_linux_init+0x79/0x90
 [<c01004b0>] init+0x120/0x330
 [<c0102eca>] ret_from_fork+0x6/0x1c
 [<c0100390>] init+0x0/0x330
 [<c0100390>] init+0x0/0x330
 [<c0103b13>] kernel_thread_helper+0x7/0x14
 =======================
aic7xxx: probe of 0000:00:0e.0 failed with error -16

lspci:

leda:~# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0d.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:12.1 Input device controller: Creative Labs SB Live! Game Port (rev 07)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)

(the 2940 is onboard and the U160 is a PCI card).

Full dmesg follows:

Linux version 2.6.18-jam02 (root@rescue) (gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP Fri Sep 29 12:31:45 CEST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000e0000 size: 0000000000020000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001ff00000 end: 0000000020000000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
copy_e820_map() start: 00000000fffc0000 size: 0000000000040000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 000fb4c0
Entering add_active_range(0, 0, 131072) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131072
  HighMem    131072 ->   131072
early_node_map[1] active PFN ranges
    0:        0 ->   131072
On node 0 totalpages: 131072
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 992 pages used for memmap
  Normal zone: 125984 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.1 present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 6:7 APIC version 17
Processor #1 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 501.164 MHz processor.
Built 1 zonelists.  Total pages: 130048
Kernel command line: vga=6 root=/dev/sda1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x60
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515792k/524288k available (2111k kernel code, 8076k reserved, 845k data, 204k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
      .init : 0xc03ea000 - 0xc041d000   ( 204 kB)
      .data : 0xc030fe3a - 0xc03e33a4   ( 845 kB)
      .text : 0xc0100000 - 0xc030fe3a   (2111 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1003.12 BogoMIPS (lpj=5015604)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1002.31 BogoMIPS (lpj=5011557)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2005.43 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=2850
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 0400-043f claimed by PIIX4 ACPI
PCI quirk: region 0440-044f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Cannot allocate resource region 0 of device 0000:00:0e.0
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fca00000-feafffff
  PREFETCH window: e4800000-f48fffff
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi 0:0:0:0: Direct-Access     IBM      IC35L018UWD210-0 S5BS PQ: 0 ANSI: 3
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
scsi 0:0:5:0: CD-ROM            TOSHIBA  CD-ROM XM-6401TA 1015 PQ: 0 ANSI: 2
 target0:0:5: Beginning Domain Validation
 target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:5: Domain Validation skipping write tests
 target0:0:5: Ending Domain Validation
PCI: Enabling device 0000:00:0e.0 (0000 -> 0003)
PCI: No IRQ known for interrupt pin A of device 0000:00:0e.0. Probably buggy MP table.
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IRQ handler type mismatch for IRQ 0
 [<c013c697>] setup_irq+0xb7/0x1b0
 [<c0274770>] ahc_linux_isr+0x0/0x50
 [<c013c833>] request_irq+0xa3/0xc0
 [<c027605c>] ahc_pci_map_int+0x2c/0x50
 [<c027167a>] ahc_pci_config+0x5ea/0xcf0
 [<c0208c00>] pci_bus_write_config_byte+0x30/0x70
 [<c02761dc>] ahc_linux_pci_dev_probe+0xec/0x1e0
 [<c01983b5>] sysfs_dirent_exist+0x45/0x70
 [<c019927b>] sysfs_create_link+0x7b/0x180
 [<c020d643>] pci_match_device+0x13/0xd0
 [<c0202b2f>] kobject_get+0xf/0x20
 [<c020d776>] pci_device_probe+0x56/0x80
 [<c024ea7b>] really_probe+0x3b/0xe0
 [<c024eb5f>] driver_probe_device+0x3f/0xa0
 [<c030c7a3>] klist_next+0x53/0xa0
 [<c024ecba>] __driver_attach+0x7a/0x80
 [<c024e01a>] bus_for_each_dev+0x3a/0x60
 [<c024e986>] driver_attach+0x16/0x20
 [<c024ec40>] __driver_attach+0x0/0x80
 [<c024e39c>] bus_add_driver+0x7c/0x1a0
 [<c020d935>] __pci_register_driver+0x65/0x90
 [<c0405749>] ahc_linux_init+0x79/0x90
 [<c01004b0>] init+0x120/0x330
 [<c0102eca>] ret_from_fork+0x6/0x1c
 [<c0100390>] init+0x0/0x330
 [<c0100390>] init+0x0/0x330
 [<c0103b13>] kernel_thread_helper+0x7/0x14
 =======================
aic7xxx: probe of 0000:00:0e.0 failed with error -16
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
 sda: sda1 sda2 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
input: AT Translated Set 2 keyboard as /class/input/input0
raid6: int32x1     95 MB/s
logips2pp: Detected unknown logitech mouse model 1
raid6: int32x2     98 MB/s
raid6: int32x4    114 MB/s
raid6: int32x8    117 MB/s
input: PS/2 Logitech Mouse as /class/input/input1
raid6: mmxx1      217 MB/s
raid6: mmxx2      323 MB/s
raid6: sse1x1     245 MB/s
raid6: sse1x2     329 MB/s
raid6: using algorithm sse1x2 (329 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1014.400 MB/sec
raid5: using function: pIII_sse (1014.400 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Time: tsc clocksource has been installed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 9, io base 0x0000ef80
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-jam02 uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:5:0: Attached scsi CD-ROM sr0
EXT3 FS on sda1, internal journal
libata version 2.00 loaded.
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi1 : ata_piix
scsi2 : ata_piix
ATA: abnormal status 0x7F on port 0x177
ATA: abnormal status 0x7F on port 0x177
ata2.00: ATAPI, max MWDMA0, CDB intr
ata2.00: configured for PIO3
scsi 2:0:0:0: Direct-Access     IOMEGA   ZIP 250          51.G PQ: 0 ANSI: 5
sd 2:0:0:0: Attached scsi removable disk sdb
Adding 1148608k swap on /dev/sda5.  Priority:-1 extents:1 across:1148608k
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at e0804f80.
eth0:  setting full-duplex.
nfsd: last server has exited
nfsd: unexporting all filesystems
Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-9625  Thu Sep 14 15:33:21 PDT 2006

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.18-jam02 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
