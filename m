Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWJMQtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWJMQtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWJMQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:49:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751384AbWJMQti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:49:38 -0400
Date: Fri, 13 Oct 2006 09:49:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.19-rc2
Message-ID: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's a week since -rc1, so -rc2 is out there.

The diff itself is pretty huge, mainly because of two things:

 - we did the big interrupt handler argument passing cleanup, which 
   affects a _lot_ of drivers in very trivial ways.

   As a result, the diffstat shows a lot of files with a single line 
   changed (mostly just removing the unused "pt_regs" argument), but the 
   fallout also ended up being a lot of architectures cleaning up their 
   irq handling.

 - the initial ext4 code-drop (a lot of it is copyign the ext3 files and 
   renaming functions and variables to "ext4_xyzzy" instead of "ext3_xyzzy")

Both of those changes were done _after_ the -rc1, because nobody wanted to 
handle the combination of large merges and a lot of fairly cosmetic 
changes. The irq thing turned out to be perhaps a bit more painful than 
expected (lots of arch fallout), but it all looks a lot better now.

Aside from those two things, we've got some arch updates (PowerPC, MIPS, 
SH), and various random fixes. Oh, and Al has been busy annotating things. 

So if you had issues with -rc1 (which had a ton of merges - even more so 
than most -rc1 releases, I think), this should hopefully be a lot better.

		Linus
---
Adrian Bunk (2):
      HT_IRQ must depend on PCI
      [DLM] Kconfig: don't show an empty DLM menu

Akinbou Mita (1):
      [PKT_SCHED] sch_htb: use rb_first() cleanup

Al Viro (103):
      m68k: dma_alloc_coherent() has gfp_t as the last argument
      m68k pt_regs fixes
      minimal alpha pt_regs fixes
      m32r pt_regs fixes
      sparc32 pt_regs fixes
      sparc64 pt_regs fixes
      sparc32 rwlock fix
      m68k pt_regs fixes, part 2
      alpha pt_regs cleanups: device_interrupt
      alpha pt_regs cleanups: handle_irq()
      alpha pt_regs cleanups: machine_check()
      alpha pt_regs cleanups: collapse set_irq_regs() in titan_dispatch_irqs()
      missed ia64 pt_regs fixes
      misc arm pt_regs fixes
      misc ppc pt_regs fixes
      missing include in pdaudiocf_irq
      missing include of scatterlist.h
      missing forward declaration of pt_regs (asm-m68k/signal.h)
      linux/io.h needs types.h
      uml pt_regs fixes
      arm: it's OK to pass pointer to volatile as iounmap() argument...
      m68k/kernel/dma.c assumes !MMU_SUN3
      sparc64 irq pt_regs fallout
      fallout from alpha pt_regs patches
      more ia64 irq handlers
      extern doesn't make sense on a definition of function...
      trivial iomem annotations (arch/powerpc/platfroms/parsemi/pci.c)
      mv64630_pic NULL noise removal
      wrong order of arguments in copy_to_user() in ncpfs
      dlm gfp_t annotations
      hppfs: readdir callback missed in prototype change
      s390 traps.c __user annotations
      mos7840 annotations
      tifm __iomem annotations, NULL noise removal
      [POWERPC] ARCH=ppc pt_regs fixes
      advansys __iomem annotations
      more fs/compat.c __user annotations
      drivers/s390 misc sparse annotations
      dccp __user annotations
      __iomem annotations in sunzilog
      NULL noise removal: advansys
      fix misannotations in loop.c
      misc sata __iomem annotations
      hwdep_compat missed __user annotations
      devio __user annotations
      drivers/dma trivial annotations
      tipc __user annotations
      __user annotations: futex
      ia64/hp NULL noise removal
      ia64/sn __iomem annotations
      mtd: remove several bogus casts to void * in iounmap() argument
      fix misannotation in ioc4.h
      make kernel/relay.c __user-clean
      passing pointer to setup_timer() should be via unsigned long
      acpi NULL noise removal
      trivial iomem annotations: istallion
      ptrace32 trivial __user annotations
      gfp annotations: scsi_error
      gfp annotations: radix_tree_root
      trivial iomem annotations: sata_promise
      openprom NULL noise removal
      __user annotations: loop.c
      em28xx NULL noise removal
      fs/inode.c NULL noise removal
      cpuset ANSI prototype
      ptrdiff_t is %t, not %z
      strndup() would better take size_t, not int
      net/sunrpc/auth_gss/svcauth_gss.c endianness regression
      missed const in prototype
      use %zu for size_t
      use %p for pointers
      befs: remove bogus typedef
      befs: prepare to sanitizing headers
      befs: introduce on-disk endian types
      befs: missing fs32_to_cpu() in debug.c
      befs: endianness annotations
      fs/fat endianness annotations
      hpfs endianness annotations
      smbfs endianness annotations
      isofs endianness annotations
      fs/partitions endianness annotations
      ufs endianness annotations
      endianness annotations in s2io
      arm __user annotations
      arm: use unsigned long instead of unsigned int in get_user()
      arm-versatile iomem annotations
      m32r: C99 initializers in setup.c
      m32r: signal __user annotations
      m32r: NULL noise removal
      m32r: more __user annotations
      misuse of strstr
      m68k uaccess __user annotations
      misc m68k __user annotations
      sun3 __iomem annotations
      clean m68k ksyms
      amiga_floppy_init() in non-modular case
      z2_init() in non-modular case
      remove bogus arch-specific syscall exports
      alpha_ksyms.c cleanup
      i2Output always takes kernel data now
      fixing includes in alpha_ksyms.c
      more kernel_execve() fallout (sbus)
      uml shouldn't do HEADERS_CHECK

Alan Cox (2):
      libata: Don't believe bogus claims in the older PIO mode register
      ide-generic: jmicron fix

Alex Tomas (2):
      ext3: add extent map support
      ext4: 48bit physical block number support in extents

Alexandre Ratchov (2):
      ext4: allow larger descriptor size
      ext4: move block number hi bits

Alexey Dobriyan (8):
      cdrom: add endianness annotations
      serpent: fix endian warnings
      chelsio: add endian annotations
      Finish annotations of struct vlan_ethhdr
      fs/*: use BUILD_BUG_ON
      DAC960: use memmove for overlapping areas
      lockdep: use BUILD_BUG_ON
      md: use BUILD_BUG_ON

Amol Lad (1):
      [ALSA] sound/pci/au88x0/au88x0.c: ioremap balanced with iounmap

Andi Kleen (6):
      x86-64: Update defconfig
      i386: Update defconfig
      i386: Fix PCI BIOS config space access
      x86: Terminate the kernel stacks for the unwinder
      x86-64: Fix FPU corruption
      x86-64: Annotate interrupt frame backlink in interrupt handlers

Andreas Mohr (1):
      fs/bio.c: tweaks

Andrew Morton (15):
      i386: irqs build fix
      kauditd_thread warning fix
      Fix WARN_ON / WARN_ON_ONCE regression
      irq_reqs: export __irq_regs
      x86_64 irq_regs fix
      ibmveth irq fix
      revert "nvidiafb: use generic ddc reading"
      ext4 uninline ext4_get_group_no_and_offset()
      ext4 64 bit divide fix
      ext4: rename logic_sb_block
      ext4 whitespace cleanups
      grow_buffers() infinite loop fix
      invalidate_inode_pages2_range() debug
      dell_rbu: printk() warning fix
      [CIFS] cifs Kconfig: don't select CONNECTOR

Aneesh Kumar (2):
      Fix typos in mm/shmem_acl.c
      fix lockdep-design.txt

Aneesh Kumar K.V (1):
      use struct irq_chip instead of struct hw_interrupt_type

Anton Blanchard (1):
      [POWERPC] Update MTFSF_L() comment

Arnaud Patard (1):
      [ALSA] emu10k1: Fix outl() in snd_emu10k1_resume_regs()

Atsushi Nemoto (5):
      [MIPS] ret_from_irq adjustment
      [MIPS] Fix build errors related to wbflush.h on tx4927/tx4938.
      [MIPS] Make sure cpu_has_fpu is used only in atomic context
      [MIPS] <asm/irq.h> does not need pt_regs anymore.
      [MIPS] Optimize and cleanup get_saved_sp, set_saved_sp

Badari Pulavarty (1):
      ext4: 48bit i_file_acl

Benjamin Herrenschmidt (8):
      [POWERPC] Fix zImage decompress location
      [POWERPC] Don't get PCI IRQ from OF for devices with no IRQ
      page fault retry with NOPAGE_REFAULT
      [POWERPC] Make U4 PCIe work on maple
      [POWERPC] Fix Maple secondary IDE interrupt
      [POWERPC] Update maple defconfig
      [POWERPC] Fix i2c-powermac platform device usage
      [POWERPC] Fix windfarm platform device usage

Bill Nottingham (1):
      Introduce vfs_listxattr

Brian King (1):
      [POWERPC] Update pSeries defconfig for SATA

Chad Sellers (1):
      SELinux: Bug fix in polidydb_destroy

Chen, Kenneth W (1):
      hugetlb: fix linked list corruption in unmap_hugepage_range()

Christian Borntraeger (2):
      [S390] ap bus poll thread priority.
      [S390] stacktrace bug.

Christoph Lameter (2):
      slab: remove wrongly placed BUG_ON
      mm: kevent threads: use MPOL_DEFAULT

Cornelia Huck (5):
      [S390] cio: 0 is a valid chpid.
      [S390] cio: add missing KERN_INFO printk header.
      [S390] cio: Use ccw_dev_id and subchannel_id in ccw_device_private
      [S390] cio: Remove grace period for vary off chpid.
      [S390] cio: remove casts from/to (void *).

Dan Cyr (1):
      [ALSA] hda-intel - New pci id for Nvidia MCP61

Dave Jones (2):
      [HEADERS] Put linux/config.h out of its misery.
      move rmap BUG_ON outside DEBUG_VM

Dave Kleikamp (4):
      ext4: initial copy of files from ext3
      jbd2: initial copy of files from jbd
      jbd2: cleanup ext4_jbd.h
      Documentation/filesystems/ext4.txt

David Brownell (1):
      ohci: don't play with IRQ regs

David Howells (7):
      IRQ: Typedef the IRQ flow handler function type
      IRQ: Typedef the IRQ handler function type
      IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
      IRQ: Use the new typedef for interrupt handler function pointers
      ReiserFS: Make sure all dentries refs are released before calling kill_block_super()
      AUTOFS: Make sure all dentries refs are released before calling kill_anon_super()
      VFS: Destroy the dentries contributed by a superblock on unmounting

David S. Miller (5):
      [SPARC64]: Update MAINTAINERS entry.
      [SPARC64]: Fix of_device bus_id settings.
      [SPARC64]: Update defconfig.
      [SPARC32]: pcic.c needs asm/irq_regs.h
      [NET]: Do not memcmp() over pad bytes of struct flowi.

David Woodhouse (2):
      Add CONFIG_HEADERS_CHECK option to automatically run 'make headers_check'
      Fix headers_check for O= builds; disable automatic check on UML.

Davide Libenzi (1):
      epoll_pwait()

Deepak Saxena (1):
      Update smc91x driver with ARM Versatile board info

Dmitry Mishin (2):
      ext4: errors behaviour fix
      ext3: errors behaviour fix

Eran Tromer (1):
      libata: return sense data in HDIO_DRIVE_CMD ioctl

Eric Eric Sesterhenn (1):
      reiserfs: null pointer dereferencing in reiserfs_read_bitmap_block

Eric Sesterhenn (3):
      [ALSA] Fix memory leak in sound/isa/es18xx.c
      null dereference in fs/jbd/journal.c
      Remove unnecessary check in fs/fat/inode.c

Eric W. Biederman (5):
      i386/x86_64: FIX pci_enable_irq to set dev->irq to the irq number
      i386/x86_64: Remove global IO_APIC_VECTOR
      x86_64 irq: Allocate a vector across all cpus for genapic_flat.
      x86_64 irq: Scream but don't die if we receive an unexpected irq
      x86_64 irq: Properly update vector_irq

Florin Malita (2):
      [ALSA] Dereference after free in snd_hwdep_release()
      fix Module taint flags listing in Oops/panic

Franck Bui-Huu (1):
      Fix up mmap_kmem

Frederik Deweerdt (2):
      fix qla{2,4} build error
      ixp4xxdefconfig arm fixes

Geert Uytterhoeven (8):
      m68k: syscall updates
      m68k: more syscall updates
      m68k/HP300: Enable HIL configuration options
      m68k/Atari: Interrupt updates
      m68k/Apollo: Remove obsolete arch/m68k/apollo/dma.c
      m68k/MVME167: SERIAL167 is no longer broken
      m68k/MVME167: SERIAL167 tty flip buffer updates
      m68knommu: sync syscalls with m68k

Geoff Levand (2):
      [POWERPC] Minor fix for bootargs property
      [POWERPC] cell: fix default zImage build target

Haavard Skinnemoen (1):
      IRQ: Fix AVR32 breakage

Heiko Carstens (4):
      [S390] irq change build fixes.
      sysrq: irq change build fix.
      [S390] irq change improvements.
      Disable DETECT_SOFTLOCKUP for s390

Helge Deller (1):
      Fix section mismatch in de2104x.c

Henne (1):
      sched: fix a kerneldoc error on is_init()

Ingo Molnar (2):
      i386: fix rwsem build bug on CONFIG_M386=y
      lockdep: fix printk recursion logic

Ishai Rabinovitz (2):
      IB/srp: Remove redundant memset()
      IB/srp: Enable multiple connections to the same target

Jack Morgenstein (1):
      IB/mthca: Query port fix

James Bottomley (3):
      [VOYAGER] fix genirq mess
      [VOYAGER] fix up attribute packed specifiers in voyager.h
      [VOYAGER] fix up ptregs removal mess

James Morris (1):
      IPsec: propagate security module errors up from flow_cache_lookup

Jamie Lenehan (1):
      sh: Fix pr_debug statements for sh4

Jan Blunck (1):
      Fix typo in "syntax error if percpu macros are incorrectly used" patch

Jan-Bernd Themann (2):
      ehea: firmware (hvcall) interface changes
      ehea: fix port state notification, default queue sizes

Jaroslav Kysela (1):
      [ALSA] version 1.0.13

Jeff Garzik (17):
      [netdrvr] b44: handle excessive multicast groups
      arch/i386/kernel/time: don't shadow 'irq' function arg
      drivers/net: eliminate irq handler impossible checks, needless casts
      Various drivers' irq handlers: kill dead code, needless casts
      drivers/net/eepro: kill dead code
      drivers/isdn/act2000: kill irq2card_map
      irda: donauboe fixes, cleanups
      firmware/dcdbas: fix bug in error cleanup
      [libata] sata_promise: add PCI ID
      tpm: fix error handling
      x86/microcode: handle sysfs error
      firmware/dell_rbu: handle sysfs errors
      ipmi: handle sysfs errors
      EISA: handle sysfs errors
      firmware/efivars: handle error
      drivers/mca: handle sysfs errors
      ISDN: several minor fixes

Jens Axboe (4):
      elevator: elevator_type member not used
      splice: fix pipe_to_file() ->prepare_write() error path
      ide-cd: fix breakage with internally queued commands
      ide-cd: one more missing REQ_TYPE_CMD_ATA check

Jim Cromie (1):
      MAINTAINERS: take over scx200-* and pc8736* drivers

Jiri Kosina (1):
      make kernels with CONFIG_X86_GENERIC and !CONFIG_SMP compilable

Joerg Roedel (2):
      [IPV6]: Seperate sit driver to extra module
      [IPV6]: Seperate sit driver to extra module (addrconf.c changes)

Johann Lombardi (1):
      jbd2: rename slab

Jon Mason (4):
      x86-64: Calgary IOMMU: deobfuscate calgary_init
      x86-64: Calgary IOMMU: Fix off by one when calculating register space location
      x86-64: Calgary IOMMU: Update Jon's contact info
      x86-64: Calgary IOMMU: print PCI bus numbers in hex

Karl-Johan Karlsson (1):
      [MIPS] Show actual CPU information in /proc/cpuinfo

Karsten Keil (1):
      bonding: fix deadlock on high loads in bond_alb_monitor()

Karsten Wiese (3):
      [ALSA] Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()
      [ALSA] Repair snd-usb-usx2y for usb 2.6.18
      [ALSA] Handle file operations during snd_card disconnects using static file->f_op

Keith Owens (1):
      Fix do_mbind warning with CONFIG_MIGRATION=n

Kyle McMartin (1):
      [PARISC] Make firmware calls irqsafe-ish...

Laurent Vivier (1):
      ext4: 64bit metadata

Linas Vepstas (20):
      powerpc/cell spidernet ethtool -i version number info.
      powerpc/cell spidernet burst alignment patch.
      Spidernet module parm permissions
      powerpc/cell spidernet force-end fix
      powerpc/cell spidernet zlen min packet length
      powerpc/cell spidernet add missing netdev watchdog
      Spidernet fix register field definitions
      Spidernet stop queue when queue is full.
      powerpc/cell spidernet bogus rx interrupt bit
      powerpc/cell spidernet fix error interrupt print
      powerpc/cell spidernet stop error printing patch.
      powerpc/cell spidernet incorrect offset
      powerpc/cell spidernet low watermark patch.
      powerpc/cell spidernet NAPI polling info.
      powerpc/cell spidernet refine locking
      powerpc/cell spidernet
      powerpc/cell spidernet reduce DMA kicking
      powerpc/cell spidernet variable name change
      powerpc/cell spidernet DMA direction fix
      powerpc/cell spidernet release all descrs

Linus Torvalds (7):
      Initial blind fixup for arm for irq changes
      ARM: fix up nested irq regs usage
      Revert "[POWERPC] Don't get PCI IRQ from OF for devices with no IRQ"
      Fix extraneous '&' in recent NFS client cleanup
      ACPI: Allow setting SCI_EN bit in PM1_CONTROL register
      Include proper header file for PFN_DOWN()
      Linux 2.6.19-rc2

Luca Tettamanti (1):
      Fix menuconfig build failure due to missing stdbool.h

Luke Zhang (1):
      [ALSA] WM9712 fixes for ac97_patch.c

Maciej W. Rozycki (2):
      swarm: Actually initialize the IDE driver
      32-bit compatibility HDIO IOCTLs

Mark Mason (1):
      [MIPS] Fix compilation warnings in arch/mips/sibyte/bcm1480/smp.c

Martin Habets (4):
      [SPARC32]: Fix prom.c build warning
      [SPARC32]: Mark srmmu_nocache_init as __init.
      [SPARC32]: Fix sparc32 modpost warnings with sunzilog
      [SPARC32]: Fix sparc32 modpost warnings.

Martin Schwidefsky (1):
      [S390] Use CONFIG_GENERIC_TIME and define TOD clock source.

Matthew Wilcox (7):
      Build fixes for struct pt_regs removal
      [PARISC] Use set_irq_regs
      [PA-RISC] Fix boot breakage
      [PARISC] pdc_init no longer exists
      [PARISC] More pt_regs removal
      Use linux/io.h instead of asm/io.h
      Consolidate check_signature

Matthias Urlichs (1):
      document the core-dump-to-a-pipe patch

Maxime Bizon (1):
      mv643xx_eth: Fix ethtool stats

Mel Gorman (2):
      mm: use symbolic names instead of indices for zone initialisation
      mm: remove memmap_zone_idx()

Melissa Howland (2):
      [S390] monwriter buffer limit.
      [S390] monwriter kzalloc size.

Michael Buesch (1):
      b44: fix eeprom endianess issue

Michael Ellerman (2):
      ibmveth: Harden driver initilisation
      [POWERPC] Fix boot wrapper invocation if CROSS_COMPILE contains spaces

Michael S. Tsirkin (1):
      IB/mthca: Fix off-by-one in mthca SRQ creation

Mike Frysinger (1):
      include linux/types.h in linux/nbd.h

Miklos Szeredi (1):
      [NET]: File descriptor loss while receiving SCM_RIGHTS

Mingming Cao (9):
      ext4: rename ext4 symbols to avoid duplication of ext3 symbols
      ext4: enable building of ext4
      jbd2: rename jbd2 symbols to avoid duplication of jbd symbols
      jbd2: enable building of jbd2 and have ext4 use it rather than jbd
      ext4: switch fsblk to sector_t
      jbd2: sector_t conversion
      ext4: blk_type from sector_t to unsigned long long
      ext4: removesector_t bits check
      jbd2: switch blks_type from sector_t to ull

Monakhov Dmitriy (1):
      D-cache aliasing issue in __block_prepare_write

Nathan Lynch (1):
      [POWERPC] linux,tce-size property is 32 bits

NeilBrown (2):
      md: fix bug where new drives added to an md array sometimes don't sync properly
      knfsd: tidy up up meaning of 'buffer size' in nfsd/sunrpc

Nick Piggin (5):
      [POWERPC] Fix harmless typo
      mm: bug in set_page_dirty_buffers
      mm: arch_free_page fix
      mm: locks_freed fix
      sched: likely profiling

Olaf Hering (4):
      fix mesh compile errors after irq changes
      [POWERPC] Fix up after irq changes
      [POWERPC] SPU fixup after irq changes
      [POWERPC] PReP fixup after irq changes

Olof Johansson (2):
      powerpc: irq change build breaks
      [POWERPC] Fix fsl_soc build breaks

Paolo 'Blaisorblade' Giarrusso (13):
      uml: revert wrong patch
      uml: correct removal of pte_mkexec
      uml: readd forgot prototype
      uml: make TT mode compile after setjmp-related changes
      uml: make UML_SETJMP always safe
      uml: fix processor selection to exclude unsupported processors and features
      uml: fix uname under setarch i386
      uml: declare in Kconfig our partial LOCKDEP support
      uml: allow using again x86/x86_64 crypto code
      uml: asm offsets duplication removal
      uml: remove duplicate export
      uml: deprecate CONFIG_MODE_TT
      uml: allow finer tuning for host VMSPLIT setting

Patrick Caulfield (1):
      [DLM] fix iovec length in recvmsg

Patrick McHardy (2):
      [DECNET]: Fix sfuzz hanging on 2.6.18
      [RTNETLINK]: Fix use of wrong skb in do_getlink()

Paul Mackerras (3):
      [PPC] Fix some irq breakage with ARCH=ppc
      [POWERPC] Fix xmon IRQ handler for pt_regs removal
      [POWERPC] Fix secondary CPU startup on old "powersurge" SMP powermacs

Paul Mundt (9):
      sh: First step at generic timeofday support.
      sh: Kill off timer_ops get_frequency().
      sh: Updates for IRQ handler changes.
      sh: Convert r7780rp IRQ handler to IRQ chip.
      sh: Convert INTC2 IRQ handler to irq_chip.
      sh: Convert IPR-IRQ to IRQ chip.
      sh: Zero-out coherent buffer in consistent_alloc().
      sh: Default enable R7780RP IRQs.
      sh: interrupt exception handling rework

paul.moore@hp.com (2):
      NetLabel: fix a cache race condition
      NetLabel: use SECINITSID_UNLABELED for a base SID

Pekka Enberg (2):
      slab: reduce numa text size
      um: irq changes break build

Peter Korsgaard (1):
      pata-qdi: fix le32 in data_xfer

Peter Osterlund (1):
      UDF: Fix mounting read-write

Peter Zijlstra (1):
      forcedeth: hardirq lockdep warning

Petr Vandrovec (1):
      Get core dump code to work...

Pierre Ossman (1):
      mmc: multi sector write transfers

Rafael J. Wysocki (2):
      swsusp: Make userland suspend work on SMP again
      swsusp: Use suspend_console

Ralf Baechle (23):
      [MIPS] Update Malta config.
      [MIPS] Complete fixes after removal of pt_regs argument to int handlers.
      handle_sysrq lost its pt_regs * argument
      [MIPS] DEC: pt_regs fixes for dec_intr_halt.
      [MIPS] Jazz: Fix I/O port resources.
      [MIPS] Jazz: Remove warning.  After 7 years probably somebody test this ;)
      [MIPS] Jazz: build fix - include <linux/screen_info.h>
      [MIPS] Jazz defconfig file.
      [MIPS] Ocelot C: Build fix - ll_mv64340_irq takes no more regs argument.
      [MIPS] Fix return type of gt64120_irq.
      [MIPS] DEC: pt_regs fixes for buserror handlers
      [MIPS] Cleanup unnecessary <asm/ptrace.h> inclusions.
      [MIPS] Fix RM9000 wait instruction detection.
      [MIPS] qtronix: remove driver.
      [MIPS] NUMA: Register all nodes before cpus or sysfs will barf.
      [RTC] Consistently use of tabs for formatting.
      [MIPS] Malta: Fix build for non-MIPS32/64 configuration.
      [MIPS] Alchemy: nuke usbdev; it's useless as is ...
      [MIPS] Workaround for bug in gcc -EB / -EL options.
      [MIPS] Cleanup definitions of speed_t and tcflag_t.
      [MIPS] BigSur: More useful defconfig.
      [MIPS] IP27: Make declaration of setup_replication_mask a proper prototype.
      [MIPS] Pass NULL not 0 for pointer value.

Randy Dunlap (6):
      x86-64: Fix compilation without CONFIG_KALLSYMS
      ext4: clean up comments in ext4-extents patch
      kernel-doc: fix function name in usercopy.c
      uaccess.h: match kernel-doc and function names
      kernel-doc: drop various "inline" qualifiers
      kernel-doc: make parameter description indentation uniform

Ravikiran Thirumalai (1):
      Fix build breakage with CONFIG_X86_VSMP

Reinette Chatre (1):
      bitmap: parse input from kernel and user buffers

Roland Dreier (2):
      RDMA/amso1100: Fix build with debugging off
      IPoIB: Check for DMA mapping error for TX packets

Roman Zippel (5):
      provide tickadj define
      m68k: cleanup string functions
      m68k: fix typo in __generic_copy_to_user
      m68k: small system.h cleanup
      m68k: fix NBPG define

Russell Cattelan (2):
      [GFS2] Fix a size calculation error
      [GFS2] Pass the correct value to kunmap_atomic

Ryusuke Sakato (1):
      sh: SH-4A UBC support

Santiago Leon (4):
      ibmveth: Add netpoll function
      ibmveth: kdump interrupt fix
      ibmveth: rename proc entry name
      ibmveth: fix int rollover panic

Sasha Khapyorsky (1):
      [ALSA] hda/patch_si3054: new codec vendor IDs

Scott Ashcroft (1):
      [MIPS] Cobalt: Time runs too quickly

Sean Hefty (2):
      IB/cm: Fix timewait crash after module unload
      IB/cm: Send DREP in response to unmatched DREQ

Stefan Richter (1):
      ieee1394: nodemgr: fix startup of knodemgrd

Stephane Eranian (1):
      Add carta_random32() library routine

Stephen Hemminger (8):
      sky2: incorrect length on receive packets
      skge: fix stuck irq when fiber down
      skge: pause mapping for fiber
      skge: better flow control negotiation
      skge: version 1.9
      sky2: revert pci express extensions
      sky2: set lower pause threshold to prevent overrun
      thermal throttle: sysfs error checking

Stephen Rothwell (3):
      [POWERPC] Update iseries_defconfig
      [POWERPC] Fix viocons for irq breakage
      [POWERPC] Fix iseries/smp.c for irq breakage

Steve French (26):
      CIFS: Use SEEK_END instead of hardcoded value
      [CIFS] Legacy time handling for Win9x and OS/2 part 1
      [CIFS] Remove static and unused symbols
      [CIFS] Fix build break
      [CIFS] Remove unused prototypes
      [CIFS] More removing of unused functions
      [CIFS] Fix build break ifdef in wrong place
      [CIFS] CIFS support for /proc/<pid>/mountstats part 1
      [CIFS] Handle legacy servers which return undefined time zone
      [CIFS] Rename server time zone field
      [CIFS] Fix typo in name of new cifs_show_stats
      [CIFS] Do not send newer QFSInfo to legacy servers which can not support it
      [CIFS] Make use of newer QFSInfo dependent on capability bit instead of
      [CIFS] Allow LANMAN21 support even in both POSIX non-POSIX path
      [CIFS] Fix readdir of large directories for backlevel servers
      [CIFS] Allow for 15 minute TZs (e.g. Nepal) and be more explicit about
      [CIFS] Fix typo
      [CIFS] Fix compiler warning with previous patch
      [CIFS] readdir (ffirst) enablement of accurate timestamps from legacy servers
      [CIFS] Fix leaps year calculation for years after 2100
      [CIFS] Do not need to adjust for Jan/Feb for leap day
      [CIFS] Fix old DOS time conversion to handle timezone
      [CIFS] fix typo in previous patch
      [CIFS] Level 1 QPathInfo needed for proper OS2 support
      [CIFS] Workaround incomplete byte length returned by some
      [CIFS] Missing flags2 for DFS

Steven Whitehouse (3):
      [GFS2] Fix uninitialised variable
      [GFS2] Fix bug where lock not held
      [GFS2] Update git tree name/location

Suparna Bhattacharya (1):
      ext4: uninitialised extent handling

Timur Tabi (1):
      [POWERPC] Add DTS for MPC8349E-mITX board

Tobin Davis (1):
      [ALSA] Add new subdevice ids for hda-intel

Tom Tucker (1):
      RDMA/amso1100: Add spinlocks to serialize ib_post_send/ib_post_recv

Tony Luck (1):
      [IA64] Fix breakage from irq change

Trond Myklebust (3):
      NFS: Fix typo in nfs_get_client()
      NFS: Fix typo in nfs_get_client()
      VM: Fix the gfp_mask in invalidate_complete_page2

Vasily Averin (1):
      ext2: errors behaviour fix

Vasily Tarasov (3):
      block layer: elevator_find function cleanup
      block layer: elv_iosched_show should get elv_list_lock
      block layer: ioprio_best function fix

Venkat Yekkirala (2):
      IPsec: correct semantics for SELinux policy matching
      IPsec: fix handling of errors for socket policies

Vlad Yasevich (2):
      [SCTP]: Fix receive buffer accounting.
      [SCTP]: Fix the RX queue size shown in /proc/net/sctp/assocs output.

Yoichi Yuasa (2):
      [MIPS] Fix DECserial build error by IRQ hander change
      [MIPS] Fix timer setup for Jazz

YOSHIFUJI Hideaki (4):
      [TCP]: Use TCPOLEN_TSTAMP_ALIGNED macro instead of magic number.
      [NET]: Use hton{l,s}() for non-initializers.
      [NET]: Use typesafe inet_twsk() inline function instead of cast.
      [NET]: Introduce protocol-specific destructor for time-wait sockets.

Zach Brown (1):
      64-bit jbd2 core

