Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWEWOT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWEWOT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWEWOT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:19:57 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59329 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932110AbWEWOT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:19:56 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Yann.LEPROVOST@wavecom.fr
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <OF20E79D4D.33810FF5-ONC1257177.00493588-C1257177.004BB870@wavecom.fr>
References: <OF20E79D4D.33810FF5-ONC1257177.00493588-C1257177.004BB870@wavecom.fr>
Content-Type: text/plain
Date: Tue, 23 May 2006 10:19:31 -0400
Message-Id: <1148393971.4997.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending using my normal email, since my other email doesn't use a registered server)

I just CC'd Thomas Gleixner on this, because he does a lot of arm for
the -rt patch, as well as included Ingo Molnar since he is the
maintainer.

On Tue, 2006-05-23 at 15:40 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Hi all,
> 
> I applied last Ingo Molnar's realtime_preempt patch (-rt23) on a vanilla
> 2.6.16 kernel.
> My architecture is an ARM based CSB637 evaluation board from Cogent.
> 
> I obtain the following kernel oops :
> 
> Uncompressing Linux............................................... done,
> booting the kernel.
> Linux version 2.6.16-rt23 (yleprovost@wmp-ylplinux) (gcc version 3.4.4) #1
> PREEMPT Tue May 23 15:24:21 CEST 2006
> CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)
> Machine: Cogent CSB637
> Warning: bad configuration page, trying to continue
> Memory policy: ECC disabled, Data cache writeback
> Clocks: CPU 184 MHz, master 46 MHz, main 3.686 MHz
> CPU0: D VIVT write-back cache
> CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
> CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
> Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
> Built 1 zonelists
> Kernel command line: mem=32M console=ttyS0,38400 initrd=0x20410000,3145728
> root=/dev/ram0 rw
> WARNING: experimental RCU implementation.
> AT91: 128 gpio irqs in 4 banks
> PID hash table entries: 256 (order: 8, 4096 bytes)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 32MB = 32MB total
> Memory: 27828KB available (1100K code, 324K data, 76K init)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000040
> pgd = c0004000
> [00000040] *pgd=00000000
> Internal error: Oops: 5 [#1]
> Modules linked in:
> CPU: 0
> PC is at profile_tick+0x34/0xa4
> LR is at timer_tick+0x1c/0xe4
> pc : [<c0032724>]    lr : [<c001fd34>]    Not tainted
> sp : c0409f04  ip : c0409f1c  fp : c0409f18
> r10: 00000000  r9 : 00000001  r8 : 00000000
> r7 : 00000001  r6 : 00000000  r5 : 00000001  r4 : 00000000
> r3 : 00000000  r2 : 000043ea  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
> Control: C000717F  Table: 20004000  DAC: 00000017
> Process IRQ 1 (pid: 2, stack limit = 0xc0408198)
> Stack: (0xc0409f04 to 0xc040a000)
> 9f00:          00000000 c016eaf0 c0409f34 c0409f1c c001fd34 c0032700
> fefff000
> 9f20: c016eaf0 00000000 c0409f50 c0409f38 c0025030 c001fd28 c0139a58
> c0408000
> 9f40: 00000000 c0409f80 c0409f54 c0053024 c0024fd4 00000000 00000000
> c01320c0
> 9f60: c0139a58 00000001 fffffffc 00000000 00000000 c0409fa0 c0409f84
> c0053c80
> 9f80: c0052fcc c0132040 c01320c0 c0405edc c0408000 c0409fc4 c0409fa4
> c0053db0
> 9fa0: c0053c30 00000031 c01320c0 c0408000 c0405edc c0053cdc c0409ff4
> c0409fc8
> 9fc0: c00463ac c0053cec 00000001 ffffffff ffffffff 00000000 00000000
> 00000000
> 9fe0: 00000000 00000000 00000000 c0409ff8 c00338e0 c00462cc 6fdb904a
> ff3b1884
> Backtrace:
> [<c00326f0>] (profile_tick+0x0/0xa4) from [<c001fd34>]
> (timer_tick+0x1c/0xe4)
>  r5 = C016EAF0  r4 = 00000000
> [<c001fd18>] (timer_tick+0x0/0xe4) from [<c0025030>]
> (at91rm9200_timer_interrupt+0x6c/0xbc)

The above does look arm specific.

>  r6 = 00000000  r5 = C016EAF0  r4 = FEFFF000
> [<c0024fc4>] (at91rm9200_timer_interrupt+0x0/0xbc) from [<c0053024>]
> (handle_IRQ_event+0x68/0xf0)
>  r6 = 00000000  r5 = C0408000  r4 = C0139A58
> [<c0052fbc>] (handle_IRQ_event+0x0/0xf0) from [<c0053c80>]
> (thread_simple_irq+0x60/0xbc)
> [<c0053c20>] (thread_simple_irq+0x0/0xbc) from [<c0053db0>]
> (do_irqd+0xd4/0x278)
>  r7 = C0408000  r6 = C0405EDC  r5 = C01320C0  r4 = C0132040
> [<c0053cdc>] (do_irqd+0x0/0x278) from [<c00463ac>] (kthread+0xf0/0x120)
>  r7 = C0053CDC  r6 = C0405EDC  r5 = C0408000  r4 = C01320C0
> [<c00462bc>] (kthread+0x0/0x120) from [<c00338e0>] (do_exit+0x0/0x8bc)
>  r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
>  r4 = 00000000
> Code: e5933000 e3530000 11a0e00f 11a0f003 (e5943040)
>  <6>note: IRQ 1[2] exited with preempt_count 1
> BUG: scheduling while atomic: IRQ 1/0x00000001/2
> caller is do_exit+0x838/0x8bc
> prev->state: 2 != TASK_RUNNING??
> IRQ 1/2[CPU#0]: BUG in __schedule at kernel/sched.c:3382
> 
> < ..... Then kernel freezes .....>
> 
> This appears only when CONFIG_PREEMPT_HARDIRQS is enabled.

Thomas,

The fault is at 0x40 and looking at profile_tick it calls
user_mode(regs).  user_mode(x) is defined in arm as 
   (((regs)->ARM_cpsr & 0xf) == 0)

And ARM_cpsr is uregs[16]  So if arm has 4 byte words and regs was NULL,
it would fault on 16*4 = 64 or 0x40

It looks like the timer interrupt on this board is having a NULL regs
passed to it when hard interrupts are threads.  Which might mean that
the timer interrupt is itself a thread.

-- Steve


> The last trace is obtained using CONFIG_RT_PREEMPT which forces
> CONFIG_PREEMPT_HARDIRQS to "yes".
> For others configurations, when PREEMPT_HARDIRQS is disabled, it works
> great.
> 
> It seems to be something dealing with bad irq returns when hardirq
> serializing is enabled ?!?
> 
> Has anyone had ever seen this oops before ?
> Any clue to solve that ?
> 
> Regards
> 
> Yann Leprovost
> 
> 
> Here is my current .config file :
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.16-rt23
> # Tue May 23 15:18:53 2006
> #
> CONFIG_ARM=y
> CONFIG_MMU=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> # CONFIG_SWAP is not set
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_IKCONFIG is not set
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_UID16=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_RT_MUTEXES=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> CONFIG_SLAB=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> # CONFIG_SLOB is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> 
> #
> # Block layer
> #
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_AS=y
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="anticipatory"
> 
> #
> # System Type
> #
> # CONFIG_ARCH_CLPS7500 is not set
> # CONFIG_ARCH_CLPS711X is not set
> # CONFIG_ARCH_CO285 is not set
> # CONFIG_ARCH_EBSA110 is not set
> # CONFIG_ARCH_FOOTBRIDGE is not set
> # CONFIG_ARCH_INTEGRATOR is not set
> # CONFIG_ARCH_IOP3XX is not set
> # CONFIG_ARCH_IXP4XX is not set
> # CONFIG_ARCH_IXP2000 is not set
> # CONFIG_ARCH_L7200 is not set
> # CONFIG_ARCH_PXA is not set
> # CONFIG_ARCH_RPC is not set
> # CONFIG_ARCH_SA1100 is not set
> # CONFIG_ARCH_S3C2410 is not set
> # CONFIG_ARCH_SHARK is not set
> # CONFIG_ARCH_LH7A40X is not set
> # CONFIG_ARCH_OMAP is not set
> # CONFIG_ARCH_VERSATILE is not set
> # CONFIG_ARCH_REALVIEW is not set
> # CONFIG_ARCH_IMX is not set
> # CONFIG_ARCH_H720X is not set
> # CONFIG_ARCH_AAEC2000 is not set
> CONFIG_ARCH_AT91=y
> 
> #
> # Atmel AT91 System-on-Chip
> #
> CONFIG_ARCH_AT91RM9200=y
> 
> #
> # AT91RM9200 Board Type
> #
> # CONFIG_ARCH_AT91RM9200DK is not set
> # CONFIG_MACH_AT91RM9200EK is not set
> # CONFIG_MACH_CSB337 is not set
> CONFIG_MACH_CSB637=y
> # CONFIG_MACH_CARMEVA is not set
> # CONFIG_MACH_KB9200 is not set
> # CONFIG_MACH_ATEB9200 is not set
> # CONFIG_MACH_KAFA is not set
> # CONFIG_ARCH_AT91SAM9261 is not set
> 
> #
> # AT91 Feature Selections
> #
> CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
> 
> #
> # Processor Type
> #
> CONFIG_CPU_32=y
> CONFIG_CPU_ARM920T=y
> CONFIG_CPU_32v4=y
> CONFIG_CPU_ABRT_EV4T=y
> CONFIG_CPU_CACHE_V4WT=y
> CONFIG_CPU_CACHE_VIVT=y
> CONFIG_CPU_COPY_V4WB=y
> CONFIG_CPU_TLB_V4WBI=y
> 
> #
> # Processor Features
> #
> # CONFIG_ARM_THUMB is not set
> # CONFIG_CPU_ICACHE_DISABLE is not set
> # CONFIG_CPU_DCACHE_DISABLE is not set
> # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
> 
> #
> # Bus support
> #
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA_DEBUG is not set
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_LOAD_CIS=y
> CONFIG_PCMCIA_IOCTL=y
> 
> #
> # PC-card bridges
> #
> CONFIG_AT91_CF=y
> 
> #
> # Kernel Features
> #
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> CONFIG_PREEMPT_BKL=y
> # CONFIG_CLASSIC_RCU is not set
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_STATS=y
> # CONFIG_NO_IDLE_HZ is not set
> # CONFIG_AEABI is not set
> # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4096
> # CONFIG_LEDS is not set
> CONFIG_ALIGNMENT_TRAP=y
> 
> #
> # Boot options
> #
> CONFIG_ZBOOT_ROM_TEXT=0x0
> CONFIG_ZBOOT_ROM_BSS=0x0
> CONFIG_CMDLINE="mem=32M console=ttyS0,38400 initrd=0x20410000,3145728
> root=/dev/ram0 rw"
> # CONFIG_XIP_KERNEL is not set
> 
> #
> # Floating point emulation
> #
> 
> #
> # At least one emulation must be selected
> #
> CONFIG_FPE_NWFPE=y
> # CONFIG_FPE_NWFPE_XP is not set
> # CONFIG_FPE_FASTFPE is not set
> 
> #
> # Userspace binary formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_ARTHUR is not set
> 
> #
> # Power management options
> #
> # CONFIG_PM is not set
> # CONFIG_APM is not set
> 
> #
> # Networking
> #
> # CONFIG_NET is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> 
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_CDROM_PKTCDVD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
> # CONFIG_CHR_DEV_SCH is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # PCMCIA SCSI adapter support
> #
> # CONFIG_PCMCIA_AHA152X is not set
> # CONFIG_PCMCIA_FDOMAIN is not set
> # CONFIG_PCMCIA_NINJA_SCSI is not set
> # CONFIG_PCMCIA_QLOGIC is not set
> # CONFIG_PCMCIA_SYM53C500 is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> 
> #
> # I2O device support
> #
> 
> #
> # ISDN subsystem
> #
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_AT91=y
> CONFIG_SERIAL_AT91_CONSOLE=y
> # CONFIG_SERIAL_AT91_TTYAT is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_NOWAYOUT=y
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> CONFIG_AT91_WATCHDOG=y
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_RTC_HISTOGRAM is not set
> # CONFIG_AT91_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> 
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_CARDMAN_4000 is not set
> # CONFIG_CARDMAN_4040 is not set
> # CONFIG_RAW_DRIVER is not set
> 
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> CONFIG_AT91_SPI=y
> CONFIG_AT91_SPIDEV=y
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Hardware Monitoring support
> #
> # CONFIG_HWMON is not set
> # CONFIG_HWMON_VID is not set
> 
> #
> # Misc devices
> #
> 
> #
> # Multimedia Capabilities Port drivers
> #
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> 
> #
> # Console display driver support
> #
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> # CONFIG_USB is not set
> 
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT2_FS_XIP is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_INOTIFY=y
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=y
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> # CONFIG_RELAYFS_FS is not set
> # CONFIG_CONFIGFS_FS is not set
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=y
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> # CONFIG_NLS is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
> # CONFIG_MAGIC_SYSRQ is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_PI_LIST=y
> # CONFIG_RT_MUTEX_TESTER is not set
> CONFIG_WAKEUP_TIMING=y
> # CONFIG_WAKEUP_LATENCY_HIST is not set
> CONFIG_PREEMPT_TRACE=y
> # CONFIG_CRITICAL_PREEMPT_TIMING is not set
> # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
> CONFIG_LATENCY_TIMING=y
> # CONFIG_LATENCY_TRACE is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_FORCED_INLINING=y
> CONFIG_FRAME_POINTER=y
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_DEBUG_USER=y
> # CONFIG_DEBUG_WAITQ is not set
> # CONFIG_DEBUG_ERRORS is not set
> CONFIG_DEBUG_LL=y
> # CONFIG_DEBUG_ICEDCC is not set
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Hardware crypto devices
> #
> 
> #
> # Library routines
> #
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_PLIST=y
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


