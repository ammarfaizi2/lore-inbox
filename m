Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWBMBT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWBMBT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWBMBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:19:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751539AbWBMBT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:19:56 -0500
Date: Sun, 12 Feb 2006 17:19:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.16-rc3
Message-ID: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 it is out there (or in the process of getting mirrored out), so go wild. 

And remember - if you get the tar-balls, you can get the patch file as a 
bonus FOR THE SAME PRICE! Have we got an unbeatable deal for you or what?

Of course, if you get the git repo, you'll get both anyway. And a nifty 
full log, since I'm just appending the short version here as a teaser.

Most of it is your run-of-the-mill fixes, with some driver updates making 
it all a bit larger (DVB in particular, but there's a few odd ones 
elsewhere too). 

The most user-visible one (eventually) is the unshare() system call, which 
glibc wanted. Along with some fixes for fstatat() (use the proper 64-bit 
interfaces, not the "newer old" one).

MIPS updates to round it up, although other architectures got their 
regularly scheduled updates too (powerpc, arm, ia64, s390..)

The shortlog gives more details.

		Linus

----

Adrian Bunk:
      VIDEO_CX88_ALSA must select SND_PCM
      V4L/DVB (3428): drivers/media/dvb/ possible cleanups
      kernel/kprobes.c: fix a warning #ifndef ARCH_SUPPORTS_KRETPROBES
      don't allow users to set CONFIG_BROKEN=y
      drivers/serial/jsm/: cleanups
      drivers/ide/ide-io.c: make __ide_end_request() static
      IDE: always enable CONFIG_PDC202XX_FORCE
      OCFS2: __init / __exit problem
      fs/ocfs2/dlm/dlmrecovery.c must #include <linux/delay.h>
      Let CDROM_PKTCDVD_WCACHE depend on EXPERIMENTAL
      i386: HIGHMEM64G must depend on X86_CMPXCHG64
      drivers/base/: proper prototypes
      V4L/DVB (3318e): DVB: remove the at76c651/tda80xx frontends
      drivers/video/Kconfig: remove unused BUS_I2C option

Akinobu Mita:
      fix generic_fls64()

Al Viro:
      cris: asm-offsets related build failure
      remove bogus asm/bug.h includes.
      bogus asm/delay.h includes
      drive_info removal outside of arch/i386
      missing includes in drivers/net/mv643xx_eth.c
      fix breakage in ocp.c
      restore power-off on sparc32
      ppc: last_task_.... is defined only on non-SMP
      drivers/scsi/mac53c94.c __iomem annotations
      fallout from ptrace consolidation patch: cris/arch-v10
      missing include in ser_a2232
      fix __user annotations in fs/select.c
      ipv4 NULL noise removal
      timer.c NULL noise removal
      kernel/sys.c NULL noise removal
      dvb NULL noise removal
      drivers/char/watchdog/sbc_epx_c3.c __user annotations
      fix __user annotations in drivers/base/memory.c
      drivers/edac/i82875p_edac.c __user annotations
      cmm NULL noise removal, __user annotations
      scsi_transport_iscsi gfp_t annotations
      sg gfp_t annotations
      eeh_driver NULL noise removal
      bogus extern in low_i2c.c
      amd64 time.c __iomem annotations
      __user annotations of video_spu_palette
      net/ipv6/mcast.c NULL noise removal
      arch/x86_64/pci/mmconfig.c NULL noise removal
      nfsroot port= parameter fix [backport of 2.4 fix]
      umount_tree() decrements mount count on wrong dentry
      arm: fix dependencies for MTD_XIP
      mips: namespace pollution - mem_... -> __mem_... in io.h
      s390x compat __user annotations
      powermac pci iomem annotations
      drivers/media/video __user annotations and fixes
      powerpc signal __user annotations
      sn3 iomem annotations and fixes
      compat_ioctl __user annotations
      s390 misc __user annotations
      fix iomem annotations in dart_iommu
      __user annotations in powerpc thread_info
      synclink_gt is PCI-only
      s390 __get_user() bogus warnings removal
      type-safe min() in prism54
      mark HISAX_AMD7930 as broken
      m32r_sio iomem annotations
      sh: lvalues abuse in arch/sh/boards/renesas/rts7751r2d/io.c

Alan Cox:
      SBC EPX does not check/claim I/O ports it uses (2nd Edition)
      rio cleanups
      Fix some ucLinux breakage from the tty updates
      ide: set latency when resetting it821x out of firmware mode

Alexey Dobriyan:
      dscc4: fix dscc4_init_dummy_skb check
      include/asm-*/bitops.h: fix more "~0UL >> size" typos
      ixj: fix writing silence check
      ipmi: mem_{in,out}[bwl] => intf_mem_{in,out}[bwl]
      dscc4: fix dscc4_init_dummy_skb check

Alexey Kuznetsov:
      [NETLINK]: Fix a severe bug
      [NETLINK]: illegal use of pid in rtnetlink

Ananth N Mavinakayanahalli:
      Kprobes: Fix deadlock in function-return probes

Andi Kleen:
      x86_64: Update defconfig
      x86_64: Disallow kprobes on NMI handlers
      x86_64: Define pmtmr_ioport to 0 when PM_TIMER is not available
      x86_64: Allow to run main time keeping from the local APIC interrupt
      x86_64: Automatically enable apicmaintimer on ATI boards
      x86_64: Fix swiotlb dma_alloc_coherent fallback
      x86_64: Undo the earlier changes to remove unrolled copy/memset functions
      x86_64: Remove CONFIG_INIT_DEBUG
      x86_64: Remove rogue default y in EDAC Kconfig
      x86_64: Clear more state when ignoring empty node in SRAT parsing
      x86_64: Do more checking in the SRAT header code
      x86_64: Fix zero mcfg entry workaround on x86-64
      x86_64: Don't allow kprobes on __switch_to
      x86_64: Calibrate APIC timer using PM timer
      i386/x86-64: Don't ack the APIC for bad interrupts when the APIC is not enabled
      x86_64: Let impossible CPUs point to reference per cpu data
      Fix bad apic fix on i386
      x86-64: Add sys_unshare
      x86_64: GART DMA merging fix

Andreas Gruenbacher:
      Fix two ext[23] uninitialized warnings
      Fix building external modules on ppc32

Andreas Mohr:
      ide Kconfig fixes

Andreas Schwab:
      ufs: fix char vs. __s8 clash in ufs

Andrew Morton:
      sx.c warning fixes
      parport_serial: printk warning fix
      quota_v2: printk warning fixes
      sx.c printk warning fixes
      uninline __sigqueue_free()
      ip2main.c warning fixes
      reiserfs_get_acl() build fix
      jbd: fix transaction batching
      uli526x warning fix
      module: strlen_user() race fix
      x86: don't initialise cpu_possible_map to all ones
      select: fix returned timeval
      tipar fixes
      fbdev: video_setup() warning fix

Andrey Panin:
      [SERIAL] SIIG 8-port serial boards support

Andy Gospodarek:
      r8169: fix forced-mode link settings

Antonino A. Daplas:
      nvidiafb: Add support for Geforce4 MX 4000

Arjan van de Ven:
      ocfs2: Semaphore to mutex conversion.

Arnaud Giersch:
      parport: add parallel port support for SGI O2
      parport: fix documentation
      parport: remove dead address in MAINTAINERS

Ashok Raj:
      x86_64: data/functions wrongly marked as __init with cpu hotplug.
      x86_64: Dont record local apic ids when they are disabled in MADT

Atsushi Nemoto:
      [SERIAL] initialize spinlock for port failed to setup console
      [MIPS] Sparse: Fix some compiler/sparse warnings in ptrace32.c
      [MIPS] Build blast_cache routines from template
      [MIPS] Sparse: Add _MIPS_SZINT and _MIPS_ISA to CHECKFLAGS to fix sparse warnings.
      [MIPS] Remove wrong __user tags.
      [MIPS] ieee754[sd]p_neg workaround
      [MIPS] Sparse: Add some __user tags to signal functions.
      [MIPS] Fix minor sparse warnings
      [MIPS] Fix dump_tlb.c warning and cleanup.
      [MIPS] TX49 MFC0 bug workaround
      [MIPS] Sparse: Add __user tags to syscall.c
      [MIPS] Add 'const' to readb and friends

Becky Bruce:
      documentation/powerpc: add bus-frequency property to SOC node
      powerpc: Add FSL USB node to documentation

Ben Dooks:
      [ARM] 3303/1: S3C24XX - add clock enable usage counting
      [ARM] 3306/1: S3C24XX - update defconfig
      [ARM] 3299/1: S3C24XX - fix irq range on adc device
      [ARM] 3326/1: H1940 - Control latches

Benjamin Herrenschmidt:
      Fix uevent buffer overflow in input layer
      powerpc: Fix sound driver use of i2c
      powerpc: Thermal control for dual core G5s

Bjorn Helgaas:
      [IA64] avoid broken SAL_CACHE_FLUSH implementations
      ia64: drop arch-specific IDE MAX_HWIFS definition

Carsten Otte:
      ext2: print xip mount option in ext2_show_options

Catalin Marinas:
      [ARM] 3290/1: Fix the FIFO size detection
      [ARM] 3313/1: Use OSC4 instead of OSC1 for CLCD

Chen, Kenneth W:
      [IA64] remove staled comments in asm/system.h
      x86_64: Fix memory policy build without CONFIG_HUGETLBFS
      [IA64] add syscall entry for *at()

Chris McDermott:
      x86-64: Fix HPET timer on x460

Chris Pascoe:
      V4L/DVB (3308): Use parallel transport for FusionHDTV Dual Digital USB

Christoph Lameter:
      hugetlb: add comment explaining reasons for Bus Errors
      hugetlbpage: return VM_FAULT_OOM on oom
      Updates for page migration
      zone reclaim: do not check references to a page during zone reclaim
      vmscan: remove duplicate increment of reclaim_in_progress
      vmscan: skip reclaim_mapped determination if we do not swap

Chuck Ebbert:
      sched: only print migration_cost once per boot
      i386 cpu hotplug: don't access freed memory
      i386: print kernel version in register dumps
      kobject: don't oops on null kobject.name

Cornelia Huck:
      s390: fix to_channelpath macro
      s390: fix locking in __chp_add() and s390_subchannel_remove_chpid()

Daniel Jacobowitz:
      [MIPS] Support /proc/kcore for MIPS

Dave C Boutcher:
      powerpc: return correct rtas status from ibm,suspend-me
      powerpc: prod all processors after ibm,suspend-me
      powerpc: remove useless call to touch_softlockup_watchdog

Dave Jones:
      Fix build failure in recent pm_prepare_* changes.
      EDAC config cleanup
      missing license tag in intermodule
      V4L/DVB (3318c): fix saa7146 kobject register failure
      More informative message on umount failure
      Fix s390 build failure.

Davi Arnaut:
      Fix keyctl usage of strnlen_user()

David Binderman:
      [IRDA]: out of range array access 

David Brownell:
      SPI: spi_butterfly, restore lost deltas

David Chinner:
      [XFS] Account for the page we just wrote when we detect congestion during

David Gibson:
      powerpc: Cleanup, consolidating icache dirtying logic
      Hugepages need clear_user_highpage() not clear_highpage()

David S. Miller:
      [TG3]: Update driver version and release date.
      [SPARC64]: Add .gitignore file for sparc64 boot images.
      [SPARC64]: Update defconfig.
      [SPARC]: Wire up sys_unshare().
      [SPARC64]: Update defconfig.

dean gaudet:
      fcntl F_SETFL and read-only IS_APPEND files

Domen Puncer:
      drivers/isdn/sc/ioctl.c: copy_from_user() size fix

Eric Dumazet:
      percpu data: only iterate over possible CPUs

Eric Paris:
      s390: remove one set of brackets in __constant_test_bit()

Eric Sesterhenn:
      i2c: Use module_param in i2c-algo-sibyte

Eric Sesterhenn / snakebyte:
      BUG_ON() Conversion in fs/ocfs2/
      BUG_ON() Conversion in fs/configfs/

Eric W. Biederman:
      edac_mc: Remove include of version.h

Evgeniy Dushistov:
      ufs: fix oops with `ufs1' type
      ufs: fix hang during `rm'

Felix Oxley:
      fs/jffs/intrep.c: 255 is unsigned char

Fernando Luis Vazquez Cao:
      Compilation of kexec/kdump broken

Francois Romieu:
      r8169: prevent excessive busy-waiting
      8139too: fix a TX timeout watchdog thread against NAPI softirq race

Geoff Levand:
      powerpc: Fix spufs initialization sequence.

George Anzinger:
      Normalize timespec for negative values in ns_to_timespec

Grant Grundler:
      [PARISC] Remove unnecessary extern declarations from asm/pci.h

Greg Kroah-Hartman:
      USB: Fix GPL markings on usb core functions.
      kobject_add() must have a valid name in order to succeed.
      DRM: fix up classdev interface for drm core
      IB: fix up major/minor sysfs interface for IB core

Greg Ungerer:
      m68knommu: compile fixes for mcfserial.c
      m68knommu: need pm_power_off in m68knommu
      m68knommu: hardirq.h needs definition of NR_IRQS
      m68knommu: use tty_schedule_flip() in 68360serial.c
      m68knommu: use tty_schedule_flip() in 68328serial.c

Hans Verkuil:
      V4L/DVB (3403): Add probe check for the tda9840.
      V4L/DVB (3300): Add standard for South Korean NTSC-M using A2 audio.

Haren Myneni:
      kexec: fix in free initrd when overlapped with crashkernel region

Heiko Carstens:
      s390: compile fix: missing defines in asm-s390/io.h
      s390: fix compat syscall wrapper
      [SPARC64]: Fix sys_newfstatat syscall table entry for 64-bit.
      remove bogus comment from init/main.c
      s390: update default configuration
      s390: earlier initialization of cpu_possible_map
      s390: update maintainers file
      s390: fix non smp build of kexec
      s390: add support for unshare system call
      s390: add #ifdef __KERNEL__ to asm-s390/setup.h
      s390: fstatat64 support

Helge Deller:
      [PARISC] Use kzalloc and other janitor-style cleanups
      [PARISC] Drop unused do_check_pgt_cache()
      [PARISC] Clean up compiler warning in pci.c
      [PARISC] Add CONFIG_DEBUG_RODATA to protect read-only data
      [PARISC] Use DEBUG_KERNEL to catch used-after-free __init data

Herbert Poetzl:
      quota: remove unused sync_dquots_dev()
      quota: fix error code for ext2_new_inode()

Herbert Xu:
      [IPV6]: Don't hold extra ref count in ipv6_ifa_notify
      [IPV4] multipath_wrandom: Fix softirq-unsafe spin lock usage
      [IPV6]: Fix illegal dst locking in softirq context.
      [ICMP]: Fix extra dst release when ip_options_echo fails
      [PPP]: Fixed hardware RX checksum handling

Hidetoshi Seto:
      [IA64] mca_drv: Add minstate validation

Holger Eitzenberger:
      [NETFILTER]: ULOG/nfnetlink_log: Use better default value for 'nlbufsiz'

Horms:
      [IPV4]: Document icmp_errors_use_inbound_ifaddr sysctl
      [IPV4]: Remove suprious use of goto out: in icmp_reply

Hugh Dickins:
      x86: fix stack trace facility level

Ian Campbell:
      [WATCHDOG] sa1100_wdt.c sparse clean (2)

Ian Pickworth:
      V4L/DVB (3416): Recognise Hauppauge card #34519

Ingo Molnar:
      sem2mutex: drivers/macintosh/windfarm_core.c
      solve false-positive soft lockup messages during IDE init
      Fix spinlock debugging delays to not time out too early
      SLOB=y && SMP=y fix
      x86: print out early faults via early_printk()

Ivan Kokshaysky:
      alpha: set cpu_possible_map much earlier

J. Bruce Fields:
      [OCFS2] Documentation Fix
      knfsd: fix nfs4_open lock leak

Jack Steiner:
      [IA64-SGI] Update TLB flushing code for SN platform

Jake Moilanen:
      powerpc: IOMMU SG paranoia

James Bottomley:
      [PARISC] Fix floating point invalid exception trap handler

Jan Beulich:
      x86_64: small fix for CFI annotations
      x86_64: minor odering correction to dump_pagetable()
      prevent recursive panic from softlockup watchdog

Jan Glauber:
      s390: timer interface visibility

JANAK DESAI:
      unshare system call -v5: Documentation file
      unshare system call -v5: system call handler function
      unshare system call -v5: unshare filesystem info
      unshare system call -v5: unshare namespace
      unshare system call -v5: unshare vm
      unshare system call -v5: unshare files
      unshare system call -v5: system call registration for i386
      powerpc: unshare system call registration

Janak Desai:
      [IA64] unshare system call registration for ia64

Jason Gaston:
      piix: add Intel ICH8M device IDs
      i2c-i801: I2C patch for Intel ICH8

Jay Vosburgh:
      bonding: allow bond to use TSO if slaves support it

Jayachandran C:
      UDF: Fix issues reported by Coverity in namei.c
      IPMI: fix issues reported by Coverity in ipmi_msghandler.c

Jean Delvare:
      ide-disk: Restore missing space in log message
      I2C: Resurrect i2c_smbus_write_i2c_block_data.
      hwmon: Fix negative temperature readings in lm77 driver
      hwmon: Inline w83792d register access functions
      hwmon: Add f71805f documentation
      hwmon: New f71805f driver
      hwmon: Fix reboot on it87 driver load

Jeff Dike:
      uml: add debug switch for skas mode
      uml: close TUN/TAP file descriptors
      uml: balance list_add and list_del in the network driver
      uml: block SIGWINCH in ptrace tester child
      uml: initialize process FP registers properly
      uml: remove a dead file

Jeff Garzik:
      [libata sata_sil] implement 'slow_down' module parameter
      [libata sata_mv] do not enable PCI MSI by default

Jeff Mahoney:
      ocfs2/dlm: fix compilation on ia64
      reiserfs: disable automatic enabling of reiserfs inode attributes

Jeff Moyer:
      fix O_DIRECT read of last block in a sparse file

Jens Axboe:
      fix ordering on requeued request drainage
      cciss: softirq handler needs to save interrupt flags
      blk: Fix SG_IO ioctl failure retry looping

Jes Sorensen:
      drivers/sn/ must be entered for CONFIG_SGI_IOC3
      [IA64-SGI] sn2 housekeeping
      [IA64-SGI] include/asm-ia64/sn/intr.h more sn2 housekeeping
      [IA64] prevent sn2 specific code to be run in generic kernels

Jesper Juhl:
      Don't check pointer for NULL before passing it to kfree [arch/powerpc/kernel/rtas_flash.c]
      wrong firmware location in IPW2100 Kconfig entry
      netfilter: fix build error due to missing has_bridge_parent macro

Jesse Allen:
      orinoco: support smc2532w

Jesse Brandeburg:
      e100: remove init_hw call to fix panic

Jiri Slaby:
      V4L/DVB (3439a): media video stradis memory fix

Joel Becker:
      o Remove confusing Kconfig text for CONFIGFS_FS.
      configfs: Clean up MAINTAINERS entry
      configfs: Add permission and ownership to configfs objects.

John Blackwood:
      arch/x86_64/kernel/traps.c PTRACE_SINGLESTEP oops

John Heffner:
      [TCP]: rcvbuf lock when tcp_moderate_rcvbuf enabled

Jon Mason:
      x86_64: IOMMU printk cleanup

Jordan Crouse:
      [SERIAL] Fix compile error in 8250_au1x00.c
      [MMC] Remove extra character in AU1XXX MMC Kconfig entry

KAMBAROV, ZAUR:
      coverity: udf/balloc.c null deref fix

KAMEZAWA Hiroyuki:
      shmdt cannot detach not-alined shm segment cleanly.

Karsten Keil:
      i4l: warning fixes

Keith Owens:
      [IA64-SGI] Recursive flags do not work for selective builds
      Tell kallsyms_lookup_name() to ignore type U entries

Kevin VanMaren:
      x86_64: When allocation of merged SG lists fails in the IOMMU don't merge

Kirill Korotaev:
      [NETFILTER]: Fix possible overflow in netfilters do_replace()

Kristian Slavov:
      [IPV6]: Address autoconfiguration does not work after device down/up cycle

Kumar Gala:
      gianfar: Fix sparse warnings
      [SERIAL] 8250 serial console update uart_8250_port ier
      powerpc: Add CONFIG_DEFAULT_UIMAGE for embedded boards

Kurt Hackel:
      ocfs2/dlm: fixes

Kyle McMartin:
      [PARISC] Use F_EXTEND() for COMMAND_GLOBAL
      [PARISC] atomic64 support
      [PARISC] Move pm_power_off export to process.c
      [PARISC] Remove obsolete _hlt cruft
      [PARISC] Add chassis_power_off routine
      [PARISC] Clean up printk in superio.c
      [PARISC] Arch-specific compat signals
      [PARISC] Simplify DISCONTIGMEM in Kconfig
      [PARISC] New syscalls (inotify, *at, pselect6/ppoll, migrate_pages)
      [IA64] Remove stale comment from ia64/Kconfig
      sys_hpux: fix strlen_user() race

Latchesar Ionkov:
      v9fs: symlink support fixes
      v9fs: v9fs_put_str fix
      v9fs: fix corner cases when flushing request

Lennert Buytenhek:
      sis900: remove cfgpmcsr I/O space register define
      [ARM] 3300/1: make ixdp2x01 co-exist with other ixp2000 machine types
      [ARM] 3301/1: remove unnecessary clock default from ixdp2801 defconfig
      [ARM] 3302/1: make pci=firmware the default for ixp2000

Linas Vepstas:
      Clean up Documentation/driver-model/overview.txt
      Documentation: Updated PCI Error Recovery

Linus Torvalds:
      Revert "x86_64: Fix the node cpumask of a cpu going down"
      mm/slab.c (non-NUMA): Fix compile warning and clean up code
      ppc: fix up trivial Kconfig config selection
      Revert "kconfig: detect if -lintl is needed when linking conf,mconf"
      Linux v2.6.16-rc3

Loren M. Lang:
      RocketPoint 1520 [hpt366] fails clock stabilization

Lucas Correia Villa Real:
      [ARM] 3284/1: S3C2400 - adds support to GPIO
      [ARM] 3286/2: S3C2400 - adds to the table of supported CPUs
      [ARM] 3283/1: S3C2400 - defines the number of serial ports
      [ARM] 3314/1: S3C2400 - adds s3c2400.h

Luiz Fernando Capitulino:
      bonding: Sparse warnings fix

Manu Abraham:
      V4L/DVB (3294): Fix [Bug 5895] to correct snd_87x autodetect

Marcelo Tosatti:
      make "struct d_cookie" depend on CONFIG_PROFILING
      powerpc/8xx: last two 8MB D-TLB entries are incorrectly set

Marcin Rudowski:
      V4L/DVB (3266): Fix NICAM buzz on analog sound

Marco Manenti:
      V4L/DVB (3297): Add IR support to KWorld DVB-T (cx22702-based)

Marcus Sundberg:
      [NETFILTER]: ctnetlink: Fix subsystem used for expectation events

Mark Fasheh:
      [OCFS2] Make ip_io_sem a mutex
      ocfs2: fix compile warnings
      ocfs2: don't wait on recovery when locking journal

Mark Mason:
      [MIPS] BCM1125 PCI fixes
      [MIPS] BCM1480: Cleanup debug code left behind in the PCI driver.
      [MIPS] SB1: Add oprofile support.

Mark Maule:
      [IA64-SGI] fix smp_affinity redirection when using CONFIG_PCI_MSI
      [IA64-SGI] disable msi for all altix pci devices

Markus Lidel:
      I2O: don't disable PCI device if it is enabled before probing
      I2O: fix and workaround for Motorola/Freescale controller
      Fix i2o_scsi oops on abort

Markus Rechberger:
      V4L/DVB (3429): Missing break statement on tuner-core
      V4L/DVB (3434): changed comment in tuner-core.c
      V4L/DVB (3281): Added signal detection support to tvp5150
      V4L/DVB (3306): Fixed i2c return value, conversion mdelay to msleep
      V4L/DVB (3325): Disabled debug on by default in tvp5150

Martin Michlmayr:
      Fix compilation errors in maps/dc21285.c
      [ARM] 3304/1: Add help descriptions to ARCH config items that don't have one
      [ARM] 3305/1: Minor typographical and spelling fixes in Konfig

Matt Waddel:
      Add wording to m68k .S files to help clarify license info

Matthew Wilcox:
      [PARISC] Make flush_tlb_all_local take a void *
      [PARISC] Update b180_defconfig
      [PARISC] Remove {,un}lock_kernel from perf ioctl

Mauro Carvalho Chehab:
      V4L/DVB (3406): Added credits for em28xx-video.c
      V4L/DVB (3405): Fixes tvp5150a/am1 detection.
      V4L/DVB (3453a): Alters MAINTAINERS file to point to newer v4l-dvb email
      V4L/DVB (3318a): Makes Some symbols static.

Michael Chan:
      [TG3]: Flush tg3_reset_task()

Michael Ellerman:
      powerpc: Don't allocate zero bytes in finish_device_tree()
      powerpc: Make sure we don't create empty lmb regions
      powerpc: Refuse to boot a kdump kernel via OF
      powerpc: Fix !SMP build of rtas.c
      powerpc: Don't overwrite flat device tree with kdump kernel
      powerpc: Don't use toc in decrementer_iSeries_masked

Michael Krufky:
      V4L/DVB (3392): Add PCI ID for DigitalNow DVB-T Dual, rebranded DViCO FusionHDTV DVB-T Dual.
      V4L/DVB (3413): Kill nxt2002 in favor of the nxt200x module
      V4L/DVB (3414): rename dvb_pll_tbmv30111in to dvb_pll_samsung_tbmv
      V4L/DVB (3417): make VP-3054 Secondary I2C Bus Support a Kconfig option.
      V4L/DVB (3431): fixed spelling error, exectuted --> executed.
      V4L/DVB (3442): Allow tristate build for cx88-vp3054-i2c
      V4L/DVB (3299): Kconfig: DVB_USB_CXUSB depends on DVB_LGDT330X and DVB_MT352
      V4L/DVB (3310): Use MT352 parallel transport function for all Bluebird FusionHDTV DVB-T boxes.

Michael Neuling:
      powerpc: hypervisor check in pseries_kexec_cpu_down

Michael Richardson:
      ide: cast arguments to pr_debug() properly

Michal Ostrowski:
      Fix RocketPort driver

Mike Isely:
      V4L/DVB (3418): Cause tda9887 to use I2C_DRIVERID_TDA9887

Miklos Szeredi:
      fuse: fix request_end() vs fuse_reset_request() race

Nathan Lynch:
      powerpc: avoid timer interrupt replay effect when onlining cpu

Nathan Scott:
      [XFS] Fix missing inode atime update from the utime syscall.

NeilBrown:
      md: Handle overflow of mdu_array_info_t->size better
      md: Assorted little md fixes
      md: Make sure rdev->size gets set for version-1 superblocks

Nick Piggin:
      mm: compound release fix
      sched: remove smpnice

Nicolas Pitre:
      [ARM] 3293/1: don't invalidate the whole I-cache with xscale_coherent_user_range
      [ARM] 3294/1: don't invalidate individual BTB entries on ARMv6
      [ARM] 3307/1: old ABI compat: mark it experimental
      [ARM] 3308/1: old ABI compat: struct sockaddr_un
      [ARM] 3309/1: disable the pre-ARMv5 NPTL kernel helper in the non MMU case
      [ARM] 3310/1: add a comment about the possible __kuser_cmpxchg transient false
      [ARM] 3311/1: clean up include/asm-arm/mutex.h

OGAWA Hirofumi:
      fat: Replace an own implementation with ll_rw_block(SWRITE,)
      Trivial optimization of ll_rw_block()
      fat: Fix truncate() write ordering

Olaf Hering:
      powerpc: remove pointer/integer confusion in generic_calibrate_decr
      powerpc: restore clock speed in /proc/cpuinfo
      powerpc: remove pointer/integer confusion in of_find_node_by_name
      powerpc: add refcounting to setup_peg2 and of_get_pci_address
      powerpc: fix compile warning in udbg_init_maple_realmode

Oleg Nesterov:
      sys_signal: initialize ->sa_mask
      do_sigaction: cleanup ->sa_mask manipulation

Oliver Endriss:
      V4L/DVB (3307): Support for Galaxis DVB-S rev1.3

Pablo Neira Ayuso:
      [TEXTSEARCH]: Fix broken good shift array calculation in Boyer-Moore
      [NETFILTER]: ctnetlink: add MODULE_ALIAS for expectation subsystem

Paolo 'Blaisorblade' Giarrusso:
      Kbuild menu - hide empty NETDEVICES menu when NET is disabled

Patrick Boettcher:
      V4L/DVB (3312): FIX: Multiple usage of VP7045-based devices
      V4L/DVB (3313): FIX: Check if FW was downloaded or not + new firmware file

Patrick McHardy:
      [NETFILTER]: Fix undersized skb allocation in ipt_ULOG/ebt_ulog/nfnetlink_log
      [NETFILTER]: nfnetlink_queue: fix packet marking over netlink
      [NETFILTER]: Fix missing src port initialization in tftp expectation mask
      [NETFILTER]: Check policy length in policy match strict mode
      [NETFILTER]: Fix ip6t_policy address matching
      [NETFILTER]: Prepare {ipt,ip6t}_policy match for x_tables unification
      [NETFILTER]: Fix check whether dst_entry needs to be released after NAT

Paul E. McKenney:
      Fix comment to synchronize_sched()

Paul Fulghum:
      new tty buffering locking fix
      tty buffering stall fix

Paul Mackerras:
      powerpc/64: Fix bug in setting floating-point exception mode
      ppc: Use the system call table from arch/powerpc/kernel/systbl.S

Pavel Machek:
      Fix Userspace interface breakage in power/state
      swsusp: kill unneeded/unbalanced bio_get

Peter Horton:
      [MIPS] Fix Cobalt PCI cache line sizes

Peter Missel:
      V4L/DVB (3409): Mark Typhoon cards as Lifeview OEM's

Peter Oberparleiter:
      s390: fix sclp memory corruption in tty pages list

Peter Osterlund:
      pktcdvd: remove version string
      pktcdvd: Don't waste kernel memory

Peter Williams:
      lib: Fix bug in int_sqrt() for 64 bit longs

Phillip Susi:
      pktcdvd: Fix overflow for discs with large packets
      pktcdvd: Allow larger packets

Prarit Bhargava:
      [IA64-SGI] Hotplug driver related fix in the SN ia64 code.
      [IA64-SGI] Small cleanup for misuse of list_for_each to list_for_each_safe.

Rafael J. Wysocki:
      Fix build failure in recent pm_prepare_* changes.

Ralf Baechle:
      [MIPS] Remove stray .set mips3 resulting in 64-bit instruction in 32-bit kernels.
      [MIPS] Fix C version of ssnop to use the right opcode.
      [MIPS] Get rid of unnecessary prototypes.  Fixes and optimizations for HZ > 100.
      [MIPS] RTLX compile fixes.
      [MIPS] Revert "mips: add pm_power_off"
      [MIPS] Check function pointers are non-zero before calling.
      [MIPS] Rename _machine_power_off to pm_power_off so the kernel builds again.
      [MIPS] Rename include/asm-mips/cobalt to include/asm-mips/mach-cobalt.
      [MIPS] CPU definitions for Cobalt.
      [MIPS] Nevada support for SGI O2.
      [MIPS] Bullet proof uaccess.h against 4.0.1 miss-compilation.
      [MIPS] Get rid of CONFIG_SB1_PASS_1_WORKAROUNDS #ifdef crapola.
      [MIPS] Sibyte: Make all setup functions __init.
      [MIPS] Reformat to 80 columns.
      [MIPS] Remove commented out code to add -mmad for Nevada.
      [MIPS] local_irq_restore wasn't safe to be used in other macros mode.
      [MIPS] Cleanup fls implementation.
      [MIPS] IP22: Fix serial console detection
      [MIPS] Shrink Qemu configuration to the bare minimum that is need and tested.
      [MIPS] Remove buggy inline version of memscan.
      [MIPS] MIPS R2 optimized endianess swapping.
      [MIPS] Oprofile: Support for 34K UP kernels.
      [MIPS] Fix linker script to work for non-4K page size.
      [MIPS] Clear ST0_RE on bootup.
      [MIPS] Add support for TIF_RESTORE_SIGMASK.
      [MIPS] Make do_signal return void.
      [MIPS] Wire up new syscalls.
      [SERIAL] ip22zilog: Whitespace cleanup.

Randy Dunlap:
      V4L/DVB (3433): Fix printk type warning
      parport: fix printk format warning
      cpuset: fix sparse warning
      edac: use C99 initializers (sparse warnings)

Ravikiran G Thirumalai:
      x86_64: Fix the node cpumask of a cpu going down
      NUMA slab locking fixes: move color_next to l3
      NUMA slab locking fixes: irq disabling from cahep->spinlock to l3 lock
      NUMA slab locking fixes: fix cpu down and up locking
      x86_64: Fix the node cpumask of a cpu going down
      slab: Avoid deadlock at kmem_cache_create/kmem_cache_destroy

Richard Purdie:
      [ARM] 3291/1: PXA27x: Correct get_clk_frequency_khz turbo flag handling
      [ARM] 3292/1: Fix memory corruption in asm-arm/checksum.h: ip_fast_csum()
      stop CompactFlash devices being marked as removable

Robb, Sam:
      kconfig: detect if -lintl is needed when linking conf,mconf

Robert Love:
      inotify: fix one-shot support

Robin Holt:
      [IA64-SGI] Fix XPC code which sleeps with spin_lock_irqsave().

Rudolf Marek:
      i2c: Rename i2c-sis96x documentation file

Russ Anderson:
      [IA64-SGI] Shub2 BTE address fix

Russ Dill:
      [ARM] 3295/1: Fix oprofile init return value

Russell King:
      [MMC] Add MMC command type flags
      [SERIAL] 8250: limit range of runtime ports
      [ARM] Remove ARCH_CAMELOT from at91 defconfigs
      [SERIAL] uart_port iotype member should use UPIO_*
      [SERIAL] uart_port flags member should use UPF_*
      [SERIAL] Remove unnecessary serial.h include
      Fix compiler warning in driver core for CONFIG_HOTPLUG=N
      drivers/base/bus.c warning fixes
      [ARM] Experimental config options should have (EXPERIMENTAL)
      [SERIAL] Remove incorrect code from ioc4 serial driver

Sam Ravnborg:
      kconfig: fix /dev/null breakage
      kbuild: fix build with O=..

Samir Bellabes:
      [NETFILTER]: nf_conntrack: fix incorrect memset() size in FTP helper

Samuel Ortiz:
      [IRDA]: Set proper IrLAP device address length

schwab@suse.de:
      disable per cpu intr in /proc/stat

Sergei Shtylylov:
      [MIPS] TX49x7: Fix timer register #define's
      [MIPS] Au1xx0: really set KSEG0 to uncached on reboot
      [MIPS] Au1200: Make KGDB compile
      [MIPS] TX49x7: Fix reporting of the CPU name and PCI clock

Shaohua Li:
      x86_64: timer resume
      x86_64: mark two routines as __cpuinit

Stefan Weinhuber:
      s390: dasd extended error reporting module

Steffen Klassert:
      3c59x: collision statistic fix

Stephen Hemminger:
      [NET] snap: needs hardware checksum fix
      [NET]: Add CONFIG_NETDEBUG to suppress bad packet messages.
      sky2: power management fix
      sky2: pci config space checking
      sky2: ethtool rx_coalesce settings fix
      sky2: set mac address fix
      sky2: clear irq race
      sky2: add irq to entropy pool
      sky2: support msi interrupt (revised)
      sky2: version 0.15 update
      [BRIDGE]: fix for RCU and deadlock on device removal
      [BRIDGE]: netfilter handle RCU during removal
      [BRIDGE]: fix error handling for add interface to bridge

Stephen Smalley:
      SELinux: fix size-128 slab leak
      MAINTAINERS/CREDITS: Update SELinux contact info
      selinux: require SECURITY_NETWORK
      selinux: require AUDIT

Steve Langasek:
      __cmpxchg() must really always be inlined on alpha

Suzuki:
      Fix do_path_lookup() to add the check for error in link_path_walk()

Takashi Iwai:
      Fix "value computed is not used" compile warnings with gcc-4.1

Tejun Heo:
      block: request_queue->ordcolor must not be flipped on SOFTBARRIER
      block: implement elv_insert and use it (fix ordcolor flipping bug)

Thibaut VARENE:
      [PARISC] pdc_stable version 0.22
      ide: restore support for AEC6280M cards in aec62xx.c

Tobias Klauser:
      umem: check pci_set_dma_mask return value correctly
      i2c: Use ARRAY_SIZE macro

Tong Li:
      OProfile: fixed x86_64 incorrect kernel call graphs

Tony Lindgren:
      [ARM] 3279/1: OMAP: 1/3 Fix low-level io init
      [ARM] 3280/1: OMAP: 2/3 Fix low-level io init for omap1 boards
      [ARM] 3278/1: OMAP: 3/3 Fix low-level io init for omap2 boards

Tony Luck:
      [IA64] Fix CONFIG_PRINTK_TIME
      [IA64] sys32_signal() forgets to initialize ->sa_mask

Trond Myklebust:
      VFS: Ensure LOOKUP_CONTINUE flag is preserved by link_path_walk()

Ulrich Drepper:
      namei.c: unlock missing in error case
      fstatat64 support

V. Ananda Krishnan:
      jsm: update for tty buffering revamp

Venkatesh Pallipadi:
      x86_64: Only switch to IPI broadcast timer on Intel when C3 is supported

Vincent Hanquez:
      debugfs: hard link count wrong
      debugfs: trivial comment fix

Vitaly Bordug:
      [SERIAL] PPC32 CPM_UART: update to utilize the new TTY flip API

Vitaly Fertman:
      someone broke reiserfs V3 mount options, this fixes it

Vlad Yasevich:
      [SCTP]: Fix 'fast retransmit' to send a TSN only once.

Wim Van Sebroeck:
      [WATCHDOG] pcwd.c add comments + tabs
      [WATCHDOG] pcwd.c card_found-- fix.
      [WATCHDOG] pcwd.c private data struct patch
      [WATCHDOG] pcwd.c Control Status #2 patch
      [WATCHDOG] pcwd.c move get_support to pcwd_check_temperature_support
      [WATCHDOG] pcwd.c show card info patch
      [WATCHDOG] pcwd.c - update module version info

Yasuyuki Kozakai:
      [NETFILTER]: nf_conntrack: check address family when finding protocol module
      [NETFILTER]: iptables: fix typos in ipt_connbytes.h

Yoichi Yuasa:
      [SERIAL] 8250_pci: add new PCI serial card support

Zach Brown:
      list.h: don't evaluate macro args multiple times
      x86_64: align per-cpu section to configured cache bytes

Zhang, Yanmin:
      Export cpu topology in sysfs

Zou Nan hai:
      [IA64] Fix a possible buffer overflow in efi.c
      [IA64] Fix wrong use of memparse in efi.c

