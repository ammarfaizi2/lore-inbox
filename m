Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423336AbWJSM2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423336AbWJSM2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423325AbWJSM2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:28:11 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:33439 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S1423337AbWJSM2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:28:10 -0400
Date: Thu, 19 Oct 2006 14:28:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-ID: <20061019122802.GA26637@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get irq warnings with current Linus tree on Pegasos.
The EDID handling for radeonfb appears to be broken as well,
but thats a different story:


Using CHRP machine description
Total memory = 256MB; using 512kB for hash table (at cff80000)
Linux version 2.6.19-rc2-git3-default (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #1 Thu Oct 19 14:19:35 CEST 2006
Found legacy serial port 0 for /pci@80000000/isa@C/serial@i2F8
  port=2f8, taddr=fe0002f8, irq=0, clk=1843200, speed=0
Entering add_active_range(0, 0, 65536) 0 entries of 256 used
chrp type = 6 [Genesi Pegasos]
Pegasos l2cr : L2 cache was not active, activating
PCI bus 0 controlled by /pci@80000000 at 80000000
PCI bus 0 controlled by /pci@C0000000 at c0000000
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
  HighMem     65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
On node 0 totalpages: 65536
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 65024 pages, LIFO batch:15
  Normal zone: 0 pages used for memmap
  HighMem zone: 0 pages used for memmap
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/hda7 quiet console=ttyS0,115200
i8259 legacy interrupt controller initialized
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 999.999990 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
High memory: 0k
Memory: 254012k/262144k available (3768k kernel code, 7780k reserved, 540k data, 439k bss, 204k init)
Calibrating delay loop... 66.56 BogoMIPS (lpj=133120)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
device-tree: Duplicate name in /pci@80000000/usb@C,2/device@1, renamed to "data@1#1"
device-tree: Duplicate name in /pci@80000000/usb@C,2/device@1, renamed to "data@1#2"
NET: Registered protocol family 16
PCI: Probing PCI hardware
Boot video device is 0001:01:08.0
irq_create_mapping called for NULL host, hwirq=0
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=e
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=0
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
irq_create_mapping called for NULL host, hwirq=9
Badness in irq_create_mapping at /home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/arch/powerpc/kernel/irq.c:527
Call Trace:
[C06EDDF0] [C0008728] show_stack+0x50/0x184 (unreliable)
[C06EDE10] [C001126C] program_check_exception+0x194/0x54c
[C06EDE60] [C0012C10] ret_from_except_full+0x0/0x4c
--- Exception: 700 at irq_create_mapping+0x38/0x11c
    LR = irq_create_mapping+0x38/0x11c
[C06EDF40] [C0015AFC] pci_read_irq_line+0x78/0xdc
[C06EDF70] [C038F828] chrp_pcibios_fixup+0x1c/0x48
[C06EDF80] [C03883A0] pcibios_init+0x100/0x224
[C06EDFA0] [C0003DB0] init+0x9c/0x268
[C06EDFF0] [C0013604] kernel_thread+0x44/0x60
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Thermal assist unit not available
audit: initializing netlink socket (disabled)
audit(1161260512.148:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
__ioremap(): phys addr 000c0000 is RAM lr c016d7bc
radeonfb (0001:01:08.0): ROM failed to map
radeonfb: No ATY,RefCLK property !
xtal calculation failed: 22967
radeonfb: Used default PLL infos
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=166.00 Mhz, System=166.00 MHz
radeonfb: PLL min 12000 max 35000
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
i2c_adapter i2c-3: unable to read EDID block.
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 80x30
radeonfb (0001:01:08.0): ATI Radeon Yd 
can't get 2 addresses for control
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x2f8 (irq = 0) is a 16550A
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x3BC
parport0: PC-style at 0x3bc, irq 7 [PCSPP]
parport_pc: VIA parallel port: io=0x3BC, irq=7
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
loop: loaded (max 8 devices)
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 1 with MAC address 00:2b:2f:de:ad:01
eth0: Scatter Gather Enabled
eth0: TX TCP/IP Checksumming Supported
eth0: RX TCP/UDP Checksum Offload ON 
eth0: RX NAPI Enabled 
eth0: Using SRAM
input: Macintosh mouse button emulation as /class/input/input0
apm_emu: Requires a machine with a PMU.
Warning: no ADB interface detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0c.1
VP_IDE: chipset revision 6
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:0c.1
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST340014A, ATA DISK drive
ide0 at 0x1000-0x1007,0x100e on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CDRW/DVD SM-352N, ATAPI CD/DVD-ROM drive
ide1 at 0x1010-0x1017,0x101e on irq 15
hda: max request size: 512KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: RDSK (512) hda1 (DOS^A)(res 2 spb 1) hda2 (DOS^E)(res 2 spb 2) hda3 (DOS^E)(res 2 spb 2) hda4 (LNX^@)(res 2 spb 1) hda5 (LNX^@)(res 2 spb 1) hda6 (SWP^@)(res 2 spb 1) hda7 (LNX^@)(res 2 spb 1) hda8 (LNX^@)(res 2 spb 1)
hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
/home/olaf/kernel/olh/pegasos/linux-2.6.19-rc2/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver appletouch
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
atkbd.c: keyboard reset failed on isa0060/serio0
atkbd.c: keyboard reset failed on isa0060/serio1
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k init
warning: process `showconsole' used the removed sysctl system call
warning: process `showconsole' used the removed sysctl system call
EXT3 FS on hda7, internal journal
warning: process `ls' used the removed sysctl system call
warning: process `ls' used the removed sysctl system call
warning: process `showconsole' used the removed sysctl system call
Adding 976744k swap on /dev/hda6.  Priority:-1 extents:1 across:976744k
audit(1161260543.595:2): audit_pid=2357 old=0 by auid=4294967295
