Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVIUBWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVIUBWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVIUBWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:22:15 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:61893 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932095AbVIUBWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:22:13 -0400
Message-ID: <4330B5C2.3080300@vc.cvut.cz>
Date: Wed, 21 Sep 2005 03:22:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 20 Sep 2005, Petr Vandrovec wrote:
> 
> 
>>slab belonging to node#1, while having acquired lock for cachep belonging
>>to node #0.  Due to this check_spinlock_acquired_node(cachep, nodeid) fails
>>(check_spinlock_acquired_node(cachep, 0) would succeed).
> 
> 
> Hmmm. If a node runs out of memory then pages from another node may end up 
> on the slab list of a node. But it seems that free_block cannot handle 
> that properly.
> 
> How are you producing the problem?

Simple... I just boot any kernel after 2.6.13, and it dies in front of me.
Currently I'm using config below, which I boot with 'rootdelay=60' so panic
in keventd happens before panic due to no root filesystem.  No ACPI.
Nothing.  100% reproducible.  Maybe I should enable embedded options and
remove all other device drivers still present in the kernel.

Below config is dmesg from 2.6.13, which has no problems with comming up.  Maybe
you'll find some clue there, but I see none.  Node #0 has 1GB of memory, so
it should have no need to borrow blocks from node #1 when this kernel is able
to boot in 16MB of memory...
								Petr


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.14-rc1-6c07
# Wed Sep 21 03:03:20 2005
#
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

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_SHOW_LOGO is not set

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
# CONFIG_MTRR is not set
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_K8_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_NUMA=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=8
CONFIG_HPET_TIMER=y
CONFIG_DUMMY_IOMMU=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
# CONFIG_PCI is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#

#
# Executable file formats / Emulations
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_IA32_EMULATION is not set

#
# Networking
#
# CONFIG_NET is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
# CONFIG_CONSOLE_KNOWS_9B is not set
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#

#
# SN Devices
#

#
# Firmware Drivers
#
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
# CONFIG_FRAME_POINTER is not set
CONFIG_INIT_DEBUG=y
# CONFIG_KPROBES is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set


Bootdata ok (command line is BOOT_IMAGE=2.6.13-64 ro root=801 ramdisk=0 console=ttyS0,115200 console=tty0 nmi_watchdog=2 psmouse_noext=1 verbose)
Linux version 2.6.13 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #2 SMP Tue Aug 30 02:41:20 CEST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f6e10
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000514 MSFT 0x00000097) @ 0x000000007fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x06000514 MSFT 0x00000097) @ 0x000000007fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x06000514 MSFT 0x00000097) @ 0x000000007fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000514 MSFT 0x00000097) @ 0x000000007ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x06000514 MSFT 0x00000097) @ 0x000000007fff4260
ACPI: HPET (v001 A M I  OEMHPET  0x06000514 MSFT 0x00000097) @ 0x000000007fff4370
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000007fff43b0
ACPI: DSDT (v001  0AAAA 0AAAA001 0x00000001 INTL 0x02002026) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> CPU 1 -> Node 1
SRAT: Node 0 PXM 0 100000-3fffffff
SRAT: Node 1 PXM 1 40000000-7fffffff
SRAT: Node 0 PXM 0 0-3fffffff
Using 24 for the hash shift. Max adder is 7fffffff
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ffeffff
On node 0 totalpages: 262046
   DMA zone: 3999 pages, LIFO batch:1
   Normal zone: 258047 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262127
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 262127 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x5008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xff4ff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xff4ff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xff4fe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xff4fe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7f780000)
Checking aperture...
CPU 0: aperture @ c0000000 size 512 MB
CPU 1: aperture @ c0000000 size 512 MB
Built 2 zonelists
Kernel command line: BOOT_IMAGE=2.6.13-64 ro root=801 ramdisk=0 console=ttyS0,115200 console=tty0 nmi_watchdog=2 psmouse_noext=1 verbose
Parameter psmouse_noext is obsolete, ignored
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1991.621 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2055660k/2097088k available (2668k kernel code, 0k reserved, 2318k data, 232k init)
Calibrating delay using timer specific routine.. 3988.04 BogoMIPS (lpj=19940224)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.447 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3983.13 BogoMIPS (lpj=19915667)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -136 cycles, maxerr 901 cycles)
Brought up 2 CPUs
time.c: Using HPET based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCIB] segment is 0
PCI: Scanning bus 0000:00
PCI: Found 0000:00:06.0 [1022/7460] 000604 01
PCI: Found 0000:00:07.0 [1022/7468] 000601 00
PCI: Found 0000:00:07.1 [1022/7469] 000101 00
PCI: Found 0000:00:07.2 [1022/746a] 000c05 00
PCI: Found 0000:00:07.3 [1022/746b] 000680 00
PCI: Found 0000:00:07.5 [1022/746d] 000401 00
PCI: Found 0000:00:0a.0 [1022/7450] 000604 01
PCI: Found 0000:00:0a.1 [1022/7451] 000800 00
PCI: Found 0000:00:0b.0 [1022/7450] 000604 01
PCI: Found 0000:00:0b.1 [1022/7451] 000800 00
PCI: Found 0000:00:18.0 [1022/1100] 000600 00
PCI: Found 0000:00:18.1 [1022/1101] 000600 00
PCI: Found 0000:00:18.2 [1022/1102] 000600 00
PCI: Found 0000:00:18.3 [1022/1103] 000600 00
PCI: Found 0000:00:19.0 [1022/1100] 000600 00
PCI: Found 0000:00:19.1 [1022/1101] 000600 00
PCI: Found 0000:00:19.2 [1022/1102] 000600 00
PCI: Found 0000:00:19.3 [1022/1103] 000600 00
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:06.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [1022/7464] 000c03 00
PCI: Found 0000:01:00.1 [1022/7464] 000c03 00
PCI: Found 0000:01:0b.0 [1095/3114] 000180 00
PCI: Found 0000:01:0c.0 [104c/8023] 000c00 00
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:0a.0, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:07.0 [1131/7146] 000480 00
PCI: Found 0000:02:09.0 [14e4/16a7] 000200 00
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:0b.0, config 030300, pass 0
PCI: Scanning bus 0000:03
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:06.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:0a.0, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:0b.0, config 030300, pass 1
PCI: Bus scan for 0000:00 returning with max=03
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Root Bridge [PCIB] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCIB] segment is 0
PCI: Scanning bus 0000:04
PCI: Found 0000:04:00.0 [1022/7454] 000600 00
PCI: Found 0000:04:01.0 [1022/7455] 000604 01
PCI: Fixups for bus 0000:04
PCI: Scanning behind PCI bridge 0000:04:01.0, config 050504, pass 0
PCI: Scanning bus 0000:05
PCI: Found 0000:05:00.0 [1002/5964] 000300 00
Boot video device is 0000:05:00.0
PCI: Found 0000:05:00.1 [1002/5d44] 000380 00
PCI: Fixups for bus 0000:05
PCI: Bus scan for 0000:05 returning with max=05
PCI: Scanning behind PCI bridge 0000:04:01.0, config 050504, pass 1
PCI: Bus scan for 0000:04 returning with max=05
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.PBP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
   got res [80000000:8007ffff] bus [80000000:8007ffff] flags 7200 for BAR 6 of 0000:01:0b.0
PCI: Bridge: 0000:00:06.0
   IO window: 9000-afff
   MEM window: ff100000-ff2fffff
   PREFETCH window: 80000000-800fffff
   got res [9e900000:9e90ffff] bus [9e900000:9e90ffff] flags 7200 for BAR 6 of 0000:02:09.0
PCI: Bridge: 0000:00:0a.0
   IO window: disabled.
   MEM window: ff300000-ff3fffff
   PREFETCH window: 9e900000-9e9fffff
PCI: Bridge: 0000:00:0b.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
   got res [9eb00000:9eb1ffff] bus [9eb00000:9eb1ffff] flags 7202 for BAR 6 of 0000:05:00.0
PCI: Bridge: 0000:04:01.0
   IO window: c000-cfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: 9eb00000-beafffff
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
agpgart: Detected AMD 8151 AGP Bridge rev B3
agpgart: AGP aperture is 512M @ 0xc0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
pnp: 00:09: ioport range 0xb78-0xb7f has been reserved
pnp: 00:09: ioport range 0xf78-0xf7f has been reserved
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1127264758.390:1): initialized
Total HugeTLB memory allocated, 0
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 240x75
radeonfb (0000:05:00.0): ATI Radeon Yd
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD1200JB-00CRA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes not supported
  hdc: hdc1
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:0b.0[A] -> GSI 17 (level, low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 0xFFFFC20000004C8A bmdma 0xFFFFC20000004C00 irq 177
ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 0xFFFFC20000004CCA bmdma 0xFFFFC20000004C08 irq 177
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004E80 ctl 0xFFFFC20000004E8A bmdma 0xFFFFC20000004E00 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFC20000004EC0 ctl 0xFFFFC20000004ECA bmdma 0xFFFFC20000004E08 irq 177
ata1: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e8 86:3c03 87:4123 88:207f
ata1: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
   Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
Fusion MPT misc device (ioctl) driver 3.03.02
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
aoe: aoe_init: AoE v2.6-10 initialised.
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
input: AT Translated Set 2 keyboard on isa0060/serio0
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Found 512b device! Using larger block size...
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
kjournald starting.  Commit interval 5 seconds
Found 512b device! Using larger block size...
Found 512b device! Using larger block size...
Adding 1959916k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
i2c_adapter i2c-6: Detecting device at 6,0x2e with COMPANY: 0x41 and VERSTEP: 0x62
i2c_adapter i2c-6: Autodetecting device at 6,0x2e ...
lm85 6-002e: Initializing device
lm85 6-002e: LM85_REG_CONFIG is: 0x05
lm85 6-002e: Setting CONFIG to: 0x05
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.3)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
tg3.c:v3.37 (August 25, 2005)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 185
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2c:90:0a
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[763f0000]
Found 512b device! Using larger block size...
Found 512b device! Using larger block size...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Found 512b device! Using larger block size...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel 810 + AC97 Audio, version 1.01, 19:40:55 Aug 29 2005
ACPI: PCI Interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 177
i810: AMD-8111 IOHub found at IO 0xbc00 and 0xb800, MEM 0x0000 and 0x0000, IRQ 177
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS116 (Analog Devices AD1981B)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:01:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 193, io mem 0xff2fd000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:01:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 193, io mem 0xff2fe000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 19 (level, low) -> IRQ 193
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[ff2ff000-ff2ff7ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0810000303bdf]
lm85 6-002e: Reading sensor values
eth1394: $Rev: 1264 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
lm85 6-002e: Reading config values
NET: Registered protocol family 15
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: HPC vendor_id 1022 device_id 7460 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: HPC vendor_id 1022 device_id 7455 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
saa7146: register extension 'budget_ci dvb'.
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 26 (level, low) -> IRQ 201
saa7146: found saa7146 @ mem ffffc20000198c00 (revision 1, irq 201) (0x13c2,0x1011).
DVB: registering new adapter (TT-Budget/WinTV-NOVA-T	 PCI).
adapter has MAC addr = 00:d0:5c:03:23:34
DVB: registering frontend 0 (Philips TDA10045H DVB-T)...
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8052efc0(lo)
IPv6 over IPv4 tunneling driver
WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
w83627hf WDT: initialized. timeout=60 sec (nowayout=0)
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
crc32c: Unknown symbol crc32c_le
Initializing IPsec netlink socket
ipcomp6: Unknown symbol xfrm6_tunnel_free_spi
ipcomp6: Unknown symbol xfrm6_tunnel_alloc_spi
ipcomp6: Unknown symbol xfrm6_tunnel_spi_lookup
NET: Registered protocol family 4
ioctl32(ipx_configure:6768): Unknown cmd fd(3) cmd(000089e1){00} arg(ffffd85b) on socket:[13557]
Process accounting paused
lm85 6-002e: Reading sensor values

