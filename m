Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTDTGoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 02:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTDTGoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 02:44:11 -0400
Received: from [66.78.41.84] ([66.78.41.84]:25278 "EHLO cell01.cell01.com")
	by vger.kernel.org with ESMTP id S263535AbTDTGoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 02:44:01 -0400
From: Eric Northup <lkml@digitaleric.net>
Reply-To: mailing-lists@digitaleric.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 IDE Oops at boot
Date: Sun, 20 Apr 2003 02:51:31 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304200251.31970.lkml@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cell01.cell01.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is RedHat 9 running on an Athlon, Asus A7N8X motherboard - nForce2 
chipset (with on-board Silicon Image SATA controller).  I also tried 
2.5.67-ac2, with the same result.  Modules are disabled, but preempt, ACPI, 
and APIC are on (full .config appended at the end this message)

I will be happy to provide more information or test any patches.  Thanks,

	--Eric Northup



Linux version 2.5.68 (eric@localhost.localdomain) (gcc version 3.2.2 20030222 
(Red Hat Linux 3.2.2-5)) #1 Sun Apr 20 01:02:57 EDT 2003

[. . . snip non-ide lines, full log follows . . .]

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA at 0xf8808000-0xf8808007, BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA at 0xf8808008-0xf880800f, BIOS settings: hdc:pio, hdd:pio
hda: MAXTOR 6L080L4, ATA DISK drive
hdc: MAXTOR 6L080L4, ATA DISK drive
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller 
on pci00:09.0
    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
hde: MAXTOR 6L040L2, ATA DISK drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
hdh: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
ide3 at 0x170-0x177,0x376 on irq 15
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046
EIP is at 0x0
eax: f7f9fddc   ebx: c051131c   ecx: 00000001   edx: c051130c
esi: 00000000   edi: 00000202   ebp: f7f9fd90   esp: f7f9fd78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c040)
Stack: c02839e3 c051131c f7f9fddc 00000000 f7f9e000 f7f9fddc f7f9fdc8 c02afcc5
       c051131c f7f9fddc 00000001 00000000 c1b06210 00000000 f7f9fdb0 f7f9fdb0
       000001ff f7f9fea4 00000000 f7f9fddc f7f9fe78 c02b580b c051130c f7f9fddc
Call Trace:
 [<c02839e3>] __elv_add_request+0x33/0x50
 [<c02afcc5>] ide_do_drive_cmd+0x85/0x100
 [<c02b580b>] ide_diag_taskfile+0x7b/0xb0
 [<c02b5867>] ide_raw_taskfile+0x27/0x30
 [<c02bbe29>] idedisk_read_native_max_address+0x49/0x90
 [<c02b4b00>] task_no_data_intr+0x0/0xa0
 [<c02bbf64>] init_idedisk_capacity+0x34/0x240
 [<c02bd068>] idedisk_setup+0x118/0x2f0
 [<c02b9c3d>] ide_register_subdriver+0x16d/0x1a0
 [<c02bd594>] idedisk_attach+0xa4/0x1c0
 [<c02b8f3e>] ata_attach+0x4e/0x110
 [<c02b9ea6>] ide_register_driver+0xf6/0x110
 [<c02bd6c2>] idedisk_init+0x12/0x50
 [<c04c678c>] do_initcalls+0x2c/0xa0
 [<c0130e92>] init_workqueues+0x12/0x40
 [<c01050a6>] init+0x36/0x190
 [<c0105070>] init+0x0/0x190
 [<c010924d>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!




-------------------------------------------------------------
snipped portion of the boot log:

Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
ACPI: RSDP (v000 Nvidia                     ) @ 0x000f6d80
ACPI: RSDT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x3fff7500
ACPI: DSDT (v001 NVIDIA AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ console=ttyS0,9600n8 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1830.365 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3612.67 BogoMIPS
Memory: 1032872k/1048512k available (2824k kernel code, 14700k reserved, 1023k 
d
ata, 144k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1829.0618 MHz.
..... host bus clock speed is 332.0657 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=3
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:....................................................
................................................................................
................................................................................
................................................
Table [DSDT] - 710 Objects with 76 Devices 260 Methods 28 Regions
ACPI Namespace successfully loaded at root c050459c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
[snip a bunch of ACPI lines]
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 10
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LIDE] enabled at IRQ 11
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off
'
Machine check exception polling timer started.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
ppdev: user-space parallel port driver
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 
sec
onds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:01.0: 3Com PCI 3c920 Tornado at 0xb000. Vers LK1.1.19

---------------------------------------------------------------
.config:

# Automatically generated make config: don't edit
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
# Code maturity level options
CONFIG_EXPERIMENTAL=y
# General setup
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
# Loadable module support
# CONFIG_MODULES is not set
# Processor type and features
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HUGETLB_PAGE=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

# Power management options (ACPI, APM)
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
# Executable file formats
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# Memory Technology Devices (MTD)
# Parallel port support
# Plug and Play support
# Block devices
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y


# SCSI device support
# Multi-device support (RAID and LVM)
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
# I2O device support
# Networking support
CONFIG_NET=y
# Networking options
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_ETHERTAP=y
# Ethernet (10 or 100Mbit)
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
# Wan interfaces
# Amateur Radio support
# IrDA (infrared) support
# ISDN subsystem
# Telephony Support

# Input device support
CONFIG_INPUT=y
# Userland interfaces
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_EVDEV=y
# Input I/O drivers
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# Input Device Drivers
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# Character devices
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# Serial drivers
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# Non-8250 serial port support
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# I2C support
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ELV=y
CONFIG_I2C_VELLEMAN=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ELEKTOR=y
CONFIG_I2C_CHARDEV=y
# I2C Hardware Sensors Mainboard support
CONFIG_I2C_AMD756=y
# I2C Hardware Sensors Chip support
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_W83781D=y
CONFIG_I2C_SENSOR=y
# IPMI
# Watchdog Cards
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_AMD7XX_TCO=y
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
# Ftape, the floppy tape device driver
CONFIG_AGP=y
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_RAW_DRIVER=y
CONFIG_HANGCHECK_TIMER=y
# Multimedia devices
# Digital Video Broadcasting Devices
# File systems
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y
# CD-ROM/DVD Filesystems
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
# DOS/FAT/NT Filesystems
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# Pseudo filesystems
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_RAMFS=y
# Network File Systems
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SUNRPC=y
# Partition Types
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
# Native Language Support
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_UTF8=y
# Graphics support
# Console display driver support
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
# Sound
CONFIG_SOUND=y
# Advanced Linux Sound Architecture
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# PCI devices
CONFIG_SND_INTEL8X0=y
# Open Sound System
# USB support
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# USB Host Controller Drivers
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
# USB Device Class drivers
# USB Human Interface Devices (HID)
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# USB Network adaptors
CONFIG_USB_USBNET=y
# Bluetooth support
# Profiling support
# Kernel hacking
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# Security options
# Cryptographic options
# Library routines
CONFIG_X86_BIOS_REBOOT=y

