Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTIISer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTIISer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:34:47 -0400
Received: from sol.cobite.com ([208.222.80.183]:5760 "EHLO sol.cobite.com")
	by vger.kernel.org with ESMTP id S264294AbTIISed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:34:33 -0400
Date: Tue, 9 Sep 2003 14:34:22 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@sol.cobite.com
To: acpi-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
cc: akpm@osdl.org
Subject: ACPI kernel panic at boot on 2.6.0-test5-mm1
Message-ID: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew, all,

I get the following 100% reproducible (copied by hand) kernel oops and
panic at boot when ACPI is enabled.  I'm not sure if other versions have
this problem as the config options seem to have changed recently.

Kernel was patched with the #ifdef DEBUG patch to mm/slab.c required for
compilation.  System is UP Athlon 1.3ghz, 512mb ram, Redhat 9, gcc version
3.2.2 20030222 (Red Hat Linux 3.2.2-5).

oops/panic:

at acpi_pci_link_calc_penalties

stack trace:
   acpi_acpi_irq_init+0x8/0x41
   pci_acpi_init+0x22/0x60
   do_initcalls+0x2b/0xa0
   init_workqueues+0xf/0x40
   init+0x2e/0x190
   init+0x0/0x190
   kernel_thread_helper+0x5/0xc
Kernel panic: attempted to kill init.

Also, the acpi=off is broken, and doesn't stop the ACPI code from oopsing.  
Instead I had to use pci=noacpi for it to boot.  This is a documentation 
bug.  acpi=off is supposed to disable the acpi code.

As far as supporting info, I have included 'lspci -v', 'dmesg' of the
kernel booting with the pci=noacpi, and the .config file.  If you want
anything else, please feel free to ask.

lspci -v:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
	Flags: bus master, medium devsel, latency 32
	Memory at d8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a01
	Flags: bus master, fast devsel, latency 16
	I/O ports at 4000 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0

00:01.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] SiS7001 USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at dd100000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] Onboard USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at dd101000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a01
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at e000 [size=256]
	Memory at dd103000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dd000000-dd0fffff
	Prefetchable memory behind bridge: d0000000-d7ffffff

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e400 [size=256]
	Memory at dd102000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a01
	Flags: 66Mhz, medium devsel
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dd000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at d000 [size=128]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0


Boot messages:
Linux version 2.6.0-test5-mm1 (root@sol.cobite.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #14 Tue Sep 9 13:18:38 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
448MB LOWMEM available.
On node 0 totalpages: 114688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: Unable to locate RSDP
Building zonelist for node : 0
Kernel command line: root=/dev/hda2 pci=noacpi
current: c03e19c0
current->thread_info: c0438000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1393.915 MHz processor.
Console: colour VGA+ 80x25
Memory: 449608k/458752k available (2612k kernel code, 8396k reserved, 681k data, 332k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: System description tables not found
    ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
    ACPI-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 0000:00:01.0
pty: 2048 Unix98 ptys configured
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 730 chipset
agpgart: Maximum main memory to use for agp memory: 381M
agpgart: AGP aperture is 64M @ 0xd8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:01.2
PCI: Sharing IRQ 11 with 0000:00:01.3
eth0: RealTek RTL8139 at 0xdc823000, 00:d0:09:de:c0:01, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:00.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS730 ATA 100 (1st gen) controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:DMA
hda: ST360020A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
PCI: Found IRQ 11 for device 0000:00:01.2
PCI: Sharing IRQ 11 with 0000:00:01.3
PCI: Sharing IRQ 11 with 0000:00:0d.0
ohci-hcd 0000:00:01.2: OHCI Host Controller
ohci-hcd 0000:00:01.2: irq 11, pci mem dc825000
ohci-hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 3 ports detected
PCI: Found IRQ 11 for device 0000:00:01.3
PCI: Sharing IRQ 11 with 0000:00:01.2
PCI: Sharing IRQ 11 with 0000:00:0d.0
ohci-hcd 0000:00:01.3: OHCI Host Controller
ohci-hcd 0000:00:01.3: irq 11, pci mem dc827000
ohci-hcd 0000:00:01.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2112.000 MB/sec
   8regs_prefetch:  2000.000 MB/sec
   32regs    :  1576.000 MB/sec
   32regs_prefetch:  1448.000 MB/sec
   pII_mmx   :  3720.000 MB/sec
   p5_mmx    :  4972.000 MB/sec
raid5: using function: p5_mmx (4972.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
PCI: Found IRQ 12 for device 0000:00:01.4
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 2, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:01.3-2
ALSA device list:
  #0: SiS SI7018 PCI Audio at 0xe000, irq 12
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 332k freed
EXT3 FS on hda2, internal journal
Adding 524656k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kudzu: numerical sysctl 1 23 is obsolete.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
nfs warning: mount version older than kernel
cdrom: This disc doesn't have any tracks I recognize!

My config:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_IOCTL_V4=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_8139TOO_8129=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=y
CONFIG_PPDEV=y
CONFIG_BUSMOUSE=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_SIS=y
CONFIG_RAW_DRIVER=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_MINIX_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_TRIDENT=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_INFO=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


