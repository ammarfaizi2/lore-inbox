Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWHCIDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHCIDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 04:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHCIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 04:03:12 -0400
Received: from mx10.go2.pl ([193.17.41.74]:38044 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932386AbWHCIDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 04:03:10 -0400
Date: Thu, 3 Aug 2006 10:05:11 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: [ BUG: bad unlock balance detected! ] in 2.6.18-rc3
Message-ID: <20060803080511.GA2510@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope it will help. Box is notebook FUJITSU-SIEMENS AMILO Pro
v2030 CEL-M370.

Jarek P.


#dmesg

Linux version 2.6.18-rc3 (root@ami) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 SMP PREEMPT Thu Aug 3 00:13:42 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000deb0000 (usable)
 BIOS-e820: 000000000deb0000 - 000000000deb8000 (ACPI data)
 BIOS-e820: 000000000deb8000 - 000000000df00000 (ACPI NVS)
 BIOS-e820: 000000000df00000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
222MB LOWMEM available.
found SMP MP-table at 000f64d0
On node 0 totalpages: 57008
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 52912 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f64a0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0deb3c1c
ACPI: FADT (v001 VN800  FIC_LM7R 0x06040000 PTL_ 0x000f4240) @ 0x0deb7eec
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x0deb7f60
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x0deb7fb0
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x0deb3d91
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x0deb3c54
ACPI: DSDT (v001 FIC    LM7R     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])

=====================================
[ BUG: bad unlock balance detected! ]
-------------------------------------
swapper/0 is trying to release lock (ioapic_lock) at:
[<c034722c>] io_apic_get_version+0x56/0x64
but there are no more locks to release!

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
 [<c0103a79>] show_trace+0x12/0x16
 [<c0103b78>] dump_stack+0x19/0x1d
 [<c0134d70>] print_unlock_inbalance_bug+0xd9/0xde
 [<c0134db2>] check_unlock+0x3d/0x77
 [<c0135045>] __lock_release+0x28/0x63
 [<c0135163>] lock_release+0x52/0x74
 [<c027b0e7>] _spin_unlock_irqrestore+0x21/0x54
 [<c034722c>] io_apic_get_version+0x56/0x64
 [<c034453a>] mp_register_ioapic+0xa4/0x14b
 [<c0342420>] acpi_parse_ioapic+0x35/0x39
 [<c034e211>] acpi_table_parse_madt_family+0xbf/0x10d
 [<c034e275>] acpi_table_parse_madt+0x16/0x18
 [<c0342865>] acpi_parse_madt_ioapic_entries+0x53/0xfc
 [<c0342986>] acpi_process_madt+0x78/0xc5
 [<c0342beb>] acpi_boot_init+0x3f/0x52
 [<c033ebab>] setup_arch+0x27d/0x2c0
 [<c033772e>] start_kernel+0x3b/0x1e9
 [<c0100210>] 0xc0100210
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 16 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 10000000:effe0000)
Detected 1507.551 MHz processor.
Built 1 zonelists.  Total pages: 57008
Kernel command line: root=/dev/sda9 ro ramdisk_size=50000 vga=791 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 219888k/228032k available (1520k kernel code, 7628k reserved, 727k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3019.15 BogoMIPS (lpj=6038312)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: afe9fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Celeron(R) M processor         1.50GHz stepping 08
Total of 1 processors activated (3019.15 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=16 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Brought up 1 CPUs
migration_cost=0
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 1600k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8ec, last bus=1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *5, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 9 10 11 12) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 9 10 11 12) *8
ACPI: Power Resource [PFAN] (off)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Failed to allocate mem resource #6:10000@f4000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d1000000-d1ffffff
  PREFETCH window: f0000000-f3ffffff
PCI: Bus 2, cardbus bridge: 0000:00:0c.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0c.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 6, 294912 bytes)
TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
PCI: Bypassing VIA 8237 APIC De-Assert Message
...

#lspci -n -v

0000:00:00.0 0600: 1106:0314
	Subsystem: 1734:109b
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [50] Power Management version 2

0000:00:00.1 0600: 1106:1314
	Flags: bus master, medium devsel, latency 0

0000:00:00.2 0600: 1106:2314
	Flags: bus master, medium devsel, latency 0

0000:00:00.3 0600: 1106:3208
	Flags: bus master, medium devsel, latency 0

0000:00:00.4 0600: 1106:4314
	Flags: bus master, medium devsel, latency 0

0000:00:00.7 0600: 1106:7314
	Flags: bus master, medium devsel, latency 0

0000:00:01.0 0604: 1106:b198
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d1000000-d1ffffff
	Prefetchable memory behind bridge: f0000000-f3ffffff
	Secondary status: SERR
	Capabilities: [70] Power Management version 2

0000:00:06.0 0280: 14e4:4318 (rev 02)
	Subsystem: 17f9:0006
	Flags: fast devsel, IRQ 255
	Memory at d0000000 (32-bit, non-prefetchable) [disabled] [size=8K]

0000:00:0c.0 0607: 104c:8031
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 16
	Memory at 24000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000 (prefetchable)
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001

0000:00:0c.2 0c00: 104c:8032 (prog-if 10)
	Subsystem: 1734:109b
	Flags: medium devsel, IRQ 255
	Memory at d0002000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Memory at d0004000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2

0000:00:0f.0 0101: 1106:3149 (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 17
	I/O ports at 1430 [size=8]
	I/O ports at 1424 [size=4]
	I/O ports at 1428 [size=8]
	I/O ports at 1420 [size=4]
	I/O ports at 1400 [size=16]
	I/O ports at 1000 [size=256]
	Capabilities: [c0] Power Management version 2

0000:00:0f.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1410 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:10.0 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 18
	I/O ports at 1440 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 18
	I/O ports at 1460 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 18
	Memory at d0002800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

0000:00:11.0 0601: 1106:3227
	Subsystem: 109b:1734
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 1734:109b
	Flags: medium devsel, IRQ 255
	I/O ports at 1800 [disabled] [size=256]
	Capabilities: [c0] Power Management version 2

0000:00:11.6 0780: 1106:3068 (rev 80)
	Subsystem: 1734:109b
	Flags: medium devsel, IRQ 255
	I/O ports at 1c00 [disabled] [size=256]
	Capabilities: [d0] Power Management version 2

0000:00:12.0 0200: 1106:3065 (rev 78)
	Subsystem: 1734:109b
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at 2000 [size=256]
	Memory at d0002c00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:01:00.0 0300: 1106:3344 (rev 01)
	Subsystem: 1734:109b
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0


#cat .config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.18-rc3
# Wed Aug  2 23:45:48 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_HOTPLUG_CPU is not set
CONFIG_COMPAT_VDSO=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

...

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_UNWIND_INFO is not set
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

...
#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y
