Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTHCJrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHCJrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:47:11 -0400
Received: from 3eea282f.cable.wanadoo.nl ([62.234.40.47]:34566 "EHLO
	diana.kozmix.org") by vger.kernel.org with ESMTP id S271090AbTHCJqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:46:54 -0400
Date: Sun, 3 Aug 2003 11:46:34 +0200
From: Sander van Malssen <svm@kozmix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030803094634.GA430@kozmix.org>
Mail-Followup-To: Sander van Malssen <svm@kozmix.org>,
	Andrew Morton <akpm@osdl.org>, yoh@onerussian.com,
	linux-kernel@vger.kernel.org
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org> <20030730170432.GA692@kozmix.org> <20030730120002.29c13b0c.akpm@osdl.org> <20030730191115.GA733@kozmix.org> <20030803091007.GA885@kozmix.org> <20030803021727.3b54cd17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803021727.3b54cd17.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 03 August 2003 at 02:17:27 -0700, Andrew Morton wrote:

> Sander van Malssen <svm@kozmix.org> wrote:
> >
> > Well, that's funny. If I run a pristine test2-mm3-1 kernel I don't get
> >  those "Buffer I/O error on device ..." kernel messages anymore, but I do
> >  get the actual I/O error itself.
> 
> The readahead problem got itself fixed.  You are seeing something
> unrelated.
> 
> Please send a lot more details.

Alas no interesting kernel messages to show. FS is an ext3 on an IDE
disk, no initrd.

The problem is easily reproduced thusly:

root@ava:~ # cat /var/log/kozmix/brooksie.log > /dev/null
cat: /var/log/kozmix/brooksie.log: Input/output error

As before, the problem goes away when booting a mm1+readahead patch
kernel and the FS checks out OK with fsck, so not an on-disk problem.

Kernel config and bootup messages follow below. Any other info you need?


Cheers,
Sander

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
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
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_JOYDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_CS461x=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ISA=y
CONFIG_SENSORS_VIA686A=y
CONFIG_I2C_SENSOR=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
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
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_SCANNER=y
CONFIG_USB_OV511=y
CONFIG_USB_KAWETH=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
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
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y


Linux version 2.6.0-test2-mm3 (svm@ava.kozmix.org) (gcc version 3.2.2) #4 Sun Aug 3 11:29:19 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
touching all pages ...
done.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.6.0-test2-mm3 ro console=tty0 panic=15 panicmorse=3 devfs=nomount ide0=autotune ide1=autotune ide2=autotune ide3=autotune parport=auto
ide_setup: ide0=autotune
ide_setup: ide1=autotune
ide_setup: ide2=autotune
ide_setup: ide3=autotune
current: c03c39c0
current->thread_info: c0440000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1000.466 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1970.17 BogoMIPS
Memory: 514508k/524224k available (2427k kernel code, 8968k reserved, 899k data, 208k init, 0k highmem)
zapping low mappings.
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
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbff0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc020, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
Applying VIA southbridge workaround.
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT133/KM133/TwisterK chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (interrupt-driven).
lp0: console ready
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 0000:00:0f.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0823000, 00:c1:26:06:bc:74, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340823A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC NR-7700A, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 78165361 sectors (40021 MB) w/1024KiB Cache, CHS=77545/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(25)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 5 for device 0000:00:07.2
PCI: Sharing IRQ 5 with 0000:00:07.3
PCI: Sharing IRQ 5 with 0000:00:08.0
PCI: Sharing IRQ 5 with 0000:00:0b.0
PCI: Sharing IRQ 5 with 0000:00:0b.1
uhci-hcd 0000:00:07.2: VIA Technologies, In USB
uhci-hcd 0000:00:07.2: irq 5, io base 0000e400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:07.3
PCI: Sharing IRQ 5 with 0000:00:07.2
PCI: Sharing IRQ 5 with 0000:00:08.0
PCI: Sharing IRQ 5 with 0000:00:0b.0
PCI: Sharing IRQ 5 with 0000:00:0b.1
uhci-hcd 0000:00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:07.3: irq 5, io base 0000e800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
drivers/usb/net/kaweth.c: Driver loading
drivers/usb/core/usb.c: registered new driver kaweth
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
registering 0-6000
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
Adding 500464k swap on /dev/dsk/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
EXT3 FS on hda1, internal journal
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 30 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
blk: queue c0492efc, I/O limit 4095Mb (mask 0xffffffff)
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

-- 
     Sander van Malssen -- svm@kozmix.org -- http://www.kozmix.org/
      http://www.peteandtommysdayout.com/ -- http://www.1-2-5.net/
