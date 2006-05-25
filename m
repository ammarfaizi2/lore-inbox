Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWEYNjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWEYNjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWEYNjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:39:52 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:27606 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030182AbWEYNjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:39:51 -0400
Date: Thu, 25 May 2006 15:39:37 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
Message-ID: <20060525133937.GB20917@fi.muni.cz>
References: <20060525122240.GG19612@fi.muni.cz> <4475B05E.5080101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4475B05E.5080101@garzik.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
: Can you narrow down which kernel version first introduces the breakage, 
: between 2.6.15-rc2 and 2.6.16.x?
: 
	It would be difficult, because the server is in production use.
I may do some tests over the weekend.

: And we will need much more information on your platform, what patches 
: (if any) you have applied, your .config, dmesg, etc.

	Tyan S2882 dual opteron 244, 12GB RAM, Fedora Core 3 system
(altough I have tried to compile the kernel with FC5 compilers as well).
Here are the lspci outout, the relevant parts of .config, and dmesg of
the kernel booted without "iommu=off" option.

	Hope this helps (or ask for more details).

-Yenya

$ /sbin/lspci
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:03.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
03:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 10)

$ egrep -v '^#|^$' /usr/src/linux-2.6.16.18/.config
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT_NONE=y
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_DISCONTIGMEM_MANUAL=y
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=2
CONFIG_HPET_TIMER=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=y
CONFIG_NET_PKTGEN=m
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_DM=y
CONFIG_NETDEVICES=y
CONFIG_TIGON3=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_WATCHDOG=y
CONFIG_W83627HF_WDT=y
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_ISA=y
CONFIG_SENSORS_EEPROM=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_W83627HF=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf-8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_UTF8=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y

$ cat /var/log/dmesg
Bootdata ok (command line is ro root=/dev/md0 max_loop=64 console=ttyS0,115200n8)
Linux version 2.6.16.18 (kas@calypso.fi.muni.cz) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #5 SMP Thu May 25 13:55:11 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000faff0000 (usable)
 BIOS-e820: 00000000faff0000 - 00000000fafff000 (ACPI data)
 BIOS-e820: 00000000fafff000 - 00000000fb000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000300000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f4620
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000304 MSFT 0x00000097) @ 0x00000000faff0000
ACPI: FADT (v002 A M I  OEMFACP  0x10000304 MSFT 0x00000097) @ 0x00000000faff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000304 MSFT 0x00000097) @ 0x00000000faff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000304 MSFT 0x00000097) @ 0x00000000fafff040
ACPI: ASF! (v016 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000faff3490
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 0000000200000000
Node 1 MemBase 0000000200000000 Limit 0000000300000000
NUMA: Using 33 for the hash shift.
Using node hash shift of 33
Bootmem setup node 0 0000000000000000-0000000200000000
Bootmem setup node 1 0000000200000000-0000000300000000
On node 0 totalpages: 2046560
  DMA zone: 2616 pages, LIFO batch:0
  DMA32 zone: 1009704 pages, LIFO batch:31
  Normal zone: 1034240 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
On node 1 totalpages: 1034240
  DMA zone: 0 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 1034240 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x5008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at fb800000 (gap: fb000000:47c0000)
Checking aperture...
CPU 0: aperture @ f6fc000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ c000000
Built 2 zonelists
Kernel command line: ro root=/dev/md0 max_loop=64 console=ttyS0,115200n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 1792.443 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 12232556k/12582912k available (2682k kernel code, 267984k reserved, 994k data, 192k init)
Calibrating delay using timer specific routine.. 3593.73 BogoMIPS (lpj=7187478)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
Using local APIC timer interrupts.
result 12447529
Detected 12.447 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3585.11 BogoMIPS (lpj=7170222)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 244 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -110 cycles, maxerr 1013 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=870
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:03:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ c000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:06.0
  IO window: 9000-afff
  MEM window: fc900000-feafffff
  PREFETCH window: ff500000-ff5fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: fc800000-fc8fffff
  PREFETCH window: ff400000-ff4fffff
PCI: Bridge: 0000:00:0b.0
  IO window: 8000-8fff
  MEM window: fb700000-fc7fffff
  PREFETCH window: ff300000-ff3fffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with ACLs, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 64 devices)
tg3.c:v3.49 (Feb 2, 2006)
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:de:17
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 17
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:de:18
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
3ware Storage Controller device driver for Linux v1.26.02.001.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 18
scsi0 : 3ware Storage Controller
3w-xxxx: scsi0: Found a 3ware Storage Controller at 0x8c00, IRQ: 18.
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 4    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 5    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 6    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 7    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
SCSI device sdb: drive cache: write back w/ FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi disk sdb
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 00 00 00
SCSI device sdc: drive cache: write back w/ FUA
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 00 00 00
SCSI device sdc: drive cache: write back w/ FUA
 sdc: sdc1 sdc2 sdc3
sd 0:0:2:0: Attached scsi disk sdc
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 00 00 00
SCSI device sdd: drive cache: write back w/ FUA
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 00 00 00
SCSI device sdd: drive cache: write back w/ FUA
 sdd: sdd1 sdd2 sdd3
sd 0:0:3:0: Attached scsi disk sdd
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 00 00 00
SCSI device sde: drive cache: write back w/ FUA
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 00 00 00
SCSI device sde: drive cache: write back w/ FUA
 sde: sde1 sde2 sde3 sde4
sd 0:0:4:0: Attached scsi disk sde
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 00 00 00
SCSI device sdf: drive cache: write back w/ FUA
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 00 00 00
SCSI device sdf: drive cache: write back w/ FUA
 sdf: sdf1 sdf2 sdf3 sdf4
sd 0:0:5:0: Attached scsi disk sdf
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 00 00 00
SCSI device sdg: drive cache: write back w/ FUA
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 00 00 00
SCSI device sdg: drive cache: write back w/ FUA
 sdg: sdg1 sdg2 sdg3
sd 0:0:6:0: Attached scsi disk sdg
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 00 00 00
SCSI device sdh: drive cache: write back w/ FUA
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 00 00 00
SCSI device sdh: drive cache: write back w/ FUA
 sdh: sdh1 sdh2 sdh3 sdh4
sd 0:0:7:0: Attached scsi disk sdh
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  5515.000 MB/sec
raid5: using function: generic_sse (5515.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdh3 ...
md:  adding sdh3 ...
md: sdh2 has different UUID to sdh3
md: sdh1 has different UUID to sdh3
md:  adding sdg3 ...
md: sdg2 has different UUID to sdh3
md: sdg1 has different UUID to sdh3
md:  adding sdf3 ...
md: sdf2 has different UUID to sdh3
md: sdf1 has different UUID to sdh3
md:  adding sde3 ...
md: sde2 has different UUID to sdh3
md: sde1 has different UUID to sdh3
md:  adding sdd3 ...
md: sdd2 has different UUID to sdh3
md: sdd1 has different UUID to sdh3
md:  adding sdc3 ...
md: sdc2 has different UUID to sdh3
md: sdc1 has different UUID to sdh3
md:  adding sdb3 ...
md: sdb2 has different UUID to sdh3
md: sdb1 has different UUID to sdh3
md:  adding sda3 ...
md: sda2 has different UUID to sdh3
md: sda1 has different UUID to sdh3
md: created md5
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: bind<sdd3>
md: bind<sde3>
md: bind<sdf3>
md: bind<sdg3>
md: bind<sdh3>
md: running: <sdh3><sdg3><sdf3><sde3><sdd3><sdc3><sdb3><sda3>
raid5: device sdh3 operational as raid disk 7
raid5: device sdg3 operational as raid disk 6
raid5: device sdf3 operational as raid disk 5
raid5: device sde3 operational as raid disk 4
raid5: device sdd3 operational as raid disk 3
raid5: device sdc3 operational as raid disk 2
raid5: device sdb3 operational as raid disk 1
raid5: device sda3 operational as raid disk 0
raid5: allocated 8462kB for md5
raid5: raid level 5 set md5 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8 fd:0
 disk 0, o:1, dev:sda3
 disk 1, o:1, dev:sdb3
 disk 2, o:1, dev:sdc3
 disk 3, o:1, dev:sdd3
 disk 4, o:1, dev:sde3
 disk 5, o:1, dev:sdf3
 disk 6, o:1, dev:sdg3
 disk 7, o:1, dev:sdh3
md: considering sdh2 ...
md:  adding sdh2 ...
md: sdh1 has different UUID to sdh2
md:  adding sdg2 ...
md: sdg1 has different UUID to sdh2
md:  adding sdf2 ...
md: sdf1 has different UUID to sdh2
md:  adding sde2 ...
md: sde1 has different UUID to sdh2
md:  adding sdd2 ...
md: sdd1 has different UUID to sdh2
md:  adding sdc2 ...
md: sdc1 has different UUID to sdh2
md:  adding sdb2 ...
md: sdb1 has different UUID to sdh2
md:  adding sda2 ...
md: sda1 has different UUID to sdh2
md: created md4
md: bind<sda2>
md: bind<sdb2>
md: bind<sdc2>
md: bind<sdd2>
md: bind<sde2>
md: bind<sdf2>
md: bind<sdg2>
md: bind<sdh2>
md: running: <sdh2><sdg2><sdf2><sde2><sdd2><sdc2><sdb2><sda2>
md4: setting max_sectors to 512, segment boundary to 131071
raid0: looking at sdh2
raid0:   comparing sdh2(4891648) with sdh2(4891648)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdg2
raid0:   comparing sdg2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sdf2
raid0:   comparing sdf2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sde2
raid0:   comparing sde2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sdd2
raid0:   comparing sdd2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sdc2
raid0:   comparing sdc2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sdb2
raid0:   comparing sdb2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: looking at sda2
raid0:   comparing sda2(4891648) with sdh2(4891648)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 39133184 blocks.
raid0 : conf->hash_spacing is 39133184 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md: sdf1 has different UUID to sdh1
md: sde1 has different UUID to sdh1
md: sdd1 has different UUID to sdh1
md: sdc1 has different UUID to sdh1
md: sdb1 has different UUID to sdh1
md: sda1 has different UUID to sdh1
md: created md3
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdf1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md: sdd1 has different UUID to sdf1
md: sdc1 has different UUID to sdf1
md: sdb1 has different UUID to sdf1
md: sda1 has different UUID to sdf1
md: created md2
md: bind<sde1>
md: bind<sdf1>
md: running: <sdf1><sde1>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb1 has different UUID to sdd1
md: sda1 has different UUID to sdd1
md: created md1
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on md0, internal journal
md: md6 stopped.
md: bind<md2>
md: bind<md3>
md6: setting max_sectors to 128, segment boundary to 32767
raid0: looking at md3
raid0:   comparing md3(9775360) with md3(9775360)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at md2
raid0:   comparing md2(9775360) with md3(9775360)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 19550720 blocks.
raid0 : conf->hash_spacing is 19550720 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem md4
Ending clean XFS mount for filesystem: md4
XFS mounting filesystem md5
Ending clean XFS mount for filesystem: md5
ISO 9660 Extensions: Microsoft Joliet Level 1
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 1
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 1
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 1
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
Unable to load NLS charset utf-8
Unable to load NLS charset utf-8
ISO 9660 Extensions: RRIP_1991A
Adding 4883752k swap on /dev/sde4.  Priority:10 extents:1 across:4883752k
Adding 4883752k swap on /dev/sdf4.  Priority:10 extents:1 across:4883752k
Adding 4883752k swap on /dev/sdh4.  Priority:10 extents:1 across:4883752k
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
