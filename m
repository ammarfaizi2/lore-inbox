Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUEWGke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUEWGke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 02:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUEWGkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 02:40:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:8660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262905AbUEWGjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 02:39:08 -0400
Date: Sat, 22 May 2004 23:38:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.7-rc1
Message-ID: <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. This is stuff all over the map, but most interesting (or at least
most "core") is probably the merging of the NUMA scheduler and the anonvma
rmap code. The latter gets rid of the expensive pte chains, and instead
allows reverse page mapping by keeping track of which vma (and offset)  
each page is associated with. Special kudos to Andrea Arcangeli and Hugh
Dickins.

		Linus

---

Summary of changes from v2.6.6 to v2.6.7-rc1
============================================

<peterm:redhat.com>:
  o [NETLINK]: Fix typo in netlink_unicast

Adam Lackorzynski:
  o get_thread_area macro fixes
  o trivial: use page_to_phys in dma_map_page()

Adam Litke:
  o x86: stack dumps using frame pointers

Adam Radford:
  o 3ware driver update

Adrian Bunk:
  o remove kernel 2.2 code from drivers/net/hamradio/dmascc.c
  o telephony/ixj.h: remove kernel 2.2 #ifdef's
  o fix cyclades compile with !PCI
  o fix tlan.c for !PCI
  o fix aic7xxx_old.c for !PCI
  o JFFS2_FS_NAND=y compile error
  o more comx removal

Adrian Yee:
  o 8139too not running s3 suspend/resume pci fix

Alan Cox:
  o PCI crash with pciless box or pci=off workaround on Vaio's
  o fix linux doc errors
  o fix block layer ioctl bug

Alan Stern:
  o USB: Remove unusual_devs entries for Minolta DiMAGE 7, 7Hi
  o USB: unusual_devs.h update
  o USB: Implement endpoint_disable() for UHCI
  o USB: Eliminate dead code from the UHCI driver
  o USB: Ignore URB_NO_INTERRUPT flag in UHCI
  o USB: Cosmetic improvements for the UHCI driver
  o USB: Altsetting updates for USB media drivers
  o USB: Altsetting update for USB misc drivers
  o USB: Altsetting update for USB net drivers
  o USB: Altsetting updates for usb/serial
  o USB: Allocate interface structures dynamically
  o USB: Lock devices during tree traversal
  o USB: USB altsetting updates for IDSN Hisax driver
  o USB: Altsetting update for USB IrDA driver
  o (as255) Handle Unit Attention during INQUIRY better
  o USB: Reduce kernel stack usage
  o USB Storage: unusual_devs.h update
  o USB: Small change to CPiA USB driver
  o (as268) Import device-reset changes from gadget-2.6 tree
  o USB Gadget: Fix file-storage gadget Request Sense length
  o USB: Accept devices with funky interface/altsetting numbers
  o USB: Don't delete interfaces until all are unbound

Alessandro Fracchetti:
  o USB Storage: Kyocera Finecsm 3L -unusual_devs.h

Alexander Viro:
  o ntfs cleanup

Alexey Dobriyan:
  o Kill a warning while making pdfdocs
  o Kill some 'No description found...' warnings. (kernel-api.sgml)
  o trivial: scripts_kernel-doc should strip comments inside structs'

Andi Kleen:
  o New version of early CPU detect
  o x86-64: convert sibling map to masks
  o Add SMT setup for domain scheduler on x86-64
  o Fix x86_64 allmodconfig with gcc-3.4.0
  o x86-64 updates
  o x86-64: fix /dev/mem caching behaviour
  o Handle empty nodes in sysfs on x86-64
  o Work around gcc 3.3.3-hammer sched miscompilation on x86-64
  o fix sendfile on 64bit architectures
  o numa api: x86_64 support
  o numa api: Add i386 support
  o numa api: Add IA64 support
  o Re-add NUMA API statistics
  o numa api: Add VMA hooks for policy
  o numa api: Add shared memory support
  o numa api: Add statistics
  o numa api: Add policy support to anonymous  memory
  o numa api: fix end of memory handling in mbind

Andrea Arcangeli:
  o Add blk_run_page()
  o swap speedups and fix
  o ramfs lfs limit
  o rmap 29 VM_RESERVED safety
  o rmap 30 fix bad mapcount
  o rmap 31 unlikely bad memory
  o rmap 32 zap_pmd_range wrap

Andreas Dilger:
  o ext3 error handling fixes

Andreas Gruenbacher:
  o Subject: [PATCH] kbuild SUBDIRS="more/ than/ one/"

Andrew Morton:
  o scsi_disk_release() warning fix
  o sata_sx4.c warning fix
  o PCI Hotplug: pciehp-linkage-fix.patch
  o aic7xxx deadlock fix
  o sched_balance_exec(): don't fiddle with the cpus_allowed mask
  o Fixes in 32 bit ioctl emulation code
  o Fix ext3 bogus ENOSPC
  o shrink_slab: improved handling of GFP_NOFS allocations
  o find_user locking and leak fix
  o blk_start_queue() should use kblockd
  o fix deadlock in create_workqueue()
  o worker_thread race fix
  o readahead: keep file->f_ra sane
  o update Documentation/md.txt
  o Add sysctl to define a hugetlb-capable group
  o use core_initcall for binfmt initialisation
  o Make usermodehelper_init() use core_initcall()
  o export con_set_default_unimap()
  o remove intermezzo
  o USB: fix ohci-hcd build error
  o Make users of page->count use the provided macros
  o Implement atomic_add_negative() on various architectures
  o Implement atomic_inc_and_test() on various architectures
  o sparc64: implement atomic_add_negative()
  o Fix page double-freeing race
  o Covert drivers to use msec_to_jiffies
  o MSEC_TO_JIFFIES to msec_to_jiffies
  o revert the process-migration-speedup patch
  o do_mounts_rd-malloc-fix
  o rename rmap_lock to page_map_lock
  o rmap-5-swap_unplug-page-revert
  o blk_run_page(): fixup for swap_unplug_io_fn()
  o blk_run_page(): we don't trust bh->b_page
  o d_flags locking fixes
  o d_vfs_flags locking fix
  o dentry shrinkage
  o dentry qstr consolidation
  o dentry d_bucket fix
  o more dentry shrinkage
  o dentry layout tweaks
  o Add del_single_shot_timer()
  o befs: inode->i_flags thinko fix
  o Fix writeback_inodes-vs-umount race
  o create_workqueue locking fix
  o implement print_modules()
  o x86_64 msr.c warning fix
  o Make /proc/sysrq-trigger ignore sysrq_enabled
  o radeonfb stack space fix
  o typhoon locking fix
  o Fix botched fbdev lvalue conversion
  o i2o_config build fix
  o Fixed quota recursion fix
  o system_state splitup
  o blk_run_page() race fix
  o dpt_i2o warning fixes
  o fix radio-cadet `readq' namespace clash
  o Fix madvise length checking
  o dentry size tuning
  o fore200e.c warning fix
  o Remove blk_run_queues() remnants
  o do_generic_mapping_read() cleanup
  o vga16fb-fix
  o ramdisk fixes
  o ramdisk memory allocation fixes
  o ramdisk: lock blockdev pages during "IO"
  o ramdisk: use kmap_atomic() in rd_blkdev_pagecache_IO()
  o ramdisk: fix PageUptodate() handling
  o ramdisk: implement writepages()
  o ramdisk: separate the blockdev backing_dev_info from the hosted
    inodes'
  o getblk() BUG removal
  o Feed arch/i386/kernel/msr.c through Lindent
  o msr.c touchups
  o block device layer: separate backing_dev_info infrastructure
  o vga16fb warning fix
  o Make swapper_space tree_lock irq-safe
  o __add_to_swap_cache and add_to_pagecache() simplification
  o revert recent swapcache handling changes
  o vmscan: revert may_enter_fs changes
  o Make sync_page use swapper_space again
  o __set_page_dirty_nobuffers race fix
  o slab: consolidate panic code
  o numa api core: use SLAB_PANIC
  o unmap_mapping_range: add comment

Andrew Theurer:
  o Neaten and fix init/main.c cpu bringup message

Andrew Vasquez:
  o qla2xxx set current state fixes
  o [1/15]  qla2xxx: Firmware dump fixes
  o [2/15]  qla2xxx: Remove flash routines
  o [3/15]  qla2xxx: 2100 request-q contraints
  o [4/15]  qla2xxx: PortID binding fixes
  o [5/15]  qla2xxx: Debug messages during ISP abort
  o [6/15]  qla2xxx: LoopID downcast fix
  o [7/15]  qla2xxx: Firmware options fixes
  o [8/15]  qla2xxx: Volatile topology fixes
  o [9/15]  qla2xxx: Tape command handling fixes
  o [10/15] qla2xxx: Use readX_relaxed
  o [11/15] qla2xxx: /proc fixes
  o [12/15] qla2xxx: RIO/ZIO fixes
  o [13/15] qla2xxx: Misc. code scrubbing
  o [14/15] qla2xxx: Resync with latest released firmware -- 3.02.28
  o [15/15] qla2xxx: Update driver version
  o qla2100 fabric fixes

Anton Altaparmakov:
  o NTFS: 2.1.9 release - Fix two bugs in the decompression engine in
    handling of corner cases.
  o NTFS: Cleanup whitespace (trailing space removal, etc)
  o NTFS: 2.1.10 - Force read-only (re)mounting of volumes with
    unsupported flags
  o NTFS: Only build logfile.o if building the driver with read-write
    support
  o NTFS: Really final white space cleanups
  o NTFS: 2.1.11 - Driver internal cleanups
  o NTFS: 2.1.11 - Rename uchar_t to ntfschar
  o x86_64 has buggy ffs() implementation

Anton Blanchard:
  o sched: implement domains for i386 HT
  o ppc64: sched-domain support
  o ARCH_HAS_SCHED_WAKE_BALANCE doesnt exist
  o sched: fix setup races
  o remove some unused variables in s2io
  o ppc64: fix radix tree allocation under spinlock
  o ppc64: set MSR_RI in iseries exception code
  o ppc64: align some heavily used variables
  o ppc64: NVRAM fixes
  o ppc64: remove iseries interrupt recursion workaround
  o ppc64: fix rtas error log length
  o ppc64: add stack overflow detection
  o ppc64: fix error return in mf_proc
  o ppc64: 4GB firmware flash fix
  o ppc64: oprofile fixes
  o ppc64: Make PMC6 spin
  o ppc64: correct return code in iommu_alloc_consistent
  o ppc64: more required exports
  o ppc64: add device tree pointer for vio devices

Aristeu Sergio Rozanski Filho:
  o qlogicfas: kill horrible irq probing
  o qlogicfas: split and create a new module
  o qlogic_cs: use qlogicfas408 module

Arjan van de Ven:
  o USB: fix obsolete header usage in usb storage
  o fealnx smp bugfix

Armin Schindler:
  o i4l: Eicon driver: fix __devexit in prototype

Arnd Bergmann:
  o Consolidate sys32_readv and sys32_writev
  o Consolidate do_execve32
  o Consolidate sys32_select
  o Consolidate sys32_nfsservctl

Arthur Othieno:
  o ia64: arch/ia64/kernel/smp.c: kill duplicate #include
  o Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

Ashok Raj:
  o ia64 cpu hotplug: core kernel initialisation
  o ia64 cpu hotplug: init section fixes
  o ia64 cpu hotplug: sysfs additions
  o ia64 cpu hotplug: IRQ affinity work
  o ia64 cpu hotplug: /proc rework
  o ia64 cpu hotplug: core

Bart De Schuymer:
  o [BRIDGE]: Fix LL_RESERVED_SPACE usage in netfilter code

Bart Samwel:
  o Laptop Mode doc update
  o Reiserfs commit default fix
  o Update laptop mode control script with XFS_HZ=100
  o Export `laptop_mode' for XFS
  o Laptop mode control script support for XFS *_centisecs sysctl
    values
  o Increase xfsbufd_centisecs when in laptop mode

Bartlomiej Zolnierkiewicz:
  o ide-disk.c: more write cache fixes
  o remove bogus drivers/ide/pci/cmd640.h
  o add default ARM/ARM26 IDE host driver
  o ARM/ARM26 IDE cleanups
  o remove dead drivers/ide/ppc/swarm.c
  o two fixups for my ARM/ARM26 IDE changes
  o IDE PCI: don't initialize fields of static chipset tables to zero

Ben Dooks:
  o [ARM PATCH] 1874/1: S3C2410 - fix for selection of low-level debug
    UART
  o [ARM PATCH] 1875/1: SMDK2410 machine support
  o [ARM PATCH] 1876/1: Removed apostrophes from asembler source

Benjamin Herrenschmidt:
  o Fix race on tty close
  o ppc64: Add proper  SMP init on dual 970FX based machines
  o fbdev: radeonfb: fix garbled screen
  o ppc64: Fix readq & writeq

Bjorn Helgaas:
  o ia64: initialize IO-port-base early
  o remove unused acpi_irq_to_vector()

Bjørn Mork:
  o I2C: "probe" module param broken for it87 in Linux 2.6.6

Bob Tracy:
  o sym53c500_cs PCMCIA SCSI driver (round 5)
  o sym53c500_cs remove irq,ioport scsi attributes

Brian Gerst:
  o Remove hardcoded offsets from i386 asm

Brian King:
  o Make SCSI timeout modifiable
  o Add IBM power RAID driver 2.0.6

Bryan Rittmeyer:
  o ppc32: IBM PowerPC 750GX Support

Bryan W. Headley:
  o USB: Aiptek.c Driver patch

Burton N. Windle:
  o fix 3c59x.c to allow 3c905c 100bT-FD

Catalin Marinas:
  o [ARM PATCH] 1880/1: cache_type is uninitialised in the
    blockops_check() function
  o [ARM PATCH] 1881/1: Illegal strex instruction generated by gcc
  o [ARM PATCH] 1882/1: Fixes in the v6_dma_(invalidate|flush)_range
    functions
  o [ARM PATCH] 1883/1: Bit 4 in pmd should be 0 for the ARMv6
    architecture

Chen Li Tien:
  o cmpci OSS driver update

Chris Mason:
  o reiserfs: acl device node initialization
  o reiserfs: xattr support
  o reiserfs: ACL support
  o reiserfs: support trusted xattrs
  o reiserfs: selinux support
  o reiserfs: xattr locking fixes
  o reiserfs: quota support
  o reiserfs: xattr permission fix
  o Fix reiserfs inode size update race

Chris Wedgwood:
  o kill warning in r8169
  o ide.c: use less stack in ide_unregister()

Chris Wright:
  o Update aacraid MAINTAINERS entry
  o simplify mqueue_inode_info->messages allocation
  o security: remove empty build of capability.o
  o security: minor cleanups in capability.c
  o security: add disable param to capabilities module

Christian Groessler:
  o Fix AladdinCard entry in parport_pc

Christoph Hellwig:
  o ia64: fix MOD_{INC,DEC}_USE_COUNT use in prominfo
  o imm/ppa style police
  o missing pci_set_master in megaraid
  o mca_53c9x needs CONFIG_MCA_LEGACY
  o fixup 68360 module refcounting
  o kill useless MOD_{INC,DEC}_USE_COUNT in sound/oss/msnd.c
  o kill MOD_{INC,DEC}_USE_COUNT gunk in
    arch/cris/arch-v10/drivers/pcf8563.c
  o fix MOD_{INC,DEC}_USE_COUNT gunk in arch/um/drivers/net_kern.c
  o drivers/video/* MOD_INC_USE_COUNT fixes
  o fix MOD_INC_USE_COUNT usage in mtd
  o remove MOD_INC_USE_COUNT usage in arch/um/drivers/harddog_kern.c
  o fix some typos in sound docs
  o [netdrvr gt961000eth] remove useless MOD_{INC,DEC}_USE_COUNT
  o [netdrvr wan] remove comx driver
  o remove driver model code in mwave driver
  o ppc32: fix MOD_{INC,DEC}_USE_COUNT abuse in 4xx/8xx code
  o replace MOD_INC_USE_COUNT in cyber2000fb
  o don't mention MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT in docs
  o mark the `planb' video driver broken
  o small numa api fixups
  o rmap.c comment/style fixups

Christophe Lucas:
  o USB: esthetic and trivial patch

Colin Leroy:
  o USB: cosmetic fixes for cdc-acm

Con Kolivas:
  o sched: SMT niceness handling

Coywolf Qi Hunt:
  o Remove bootsect_helper and a comment fix
  o Remove bootsect_helper on x86_64 and pc98

Daniel A. Nobuto:
  o trivial: remove duplicated #includes

Daniel Ritz:
  o USB: add support for eGalax Touchscreen USB

Daniele Bellucci:
  o USB: audits in usb_init()
  o missing audit in bus_register()

Dave Airlie:
  o Converted Linux drivers to initialize DRM instances based on PCI
    IDs, not just a single instance. The PCI ID lists include a driver
    private field, which may be used by drivers for chip family or
    other information. Based on work by jonsmirl and Eric Anholt. I've
    left out the PCI device naming for this patch as that might be a
    bit controversial. clean up tdfx to look like everyone else..
  o From: Eric Anholt
  o left gamma_dma.c out of last changeset
  o Add DRM_GET_PRIV_WITH_RETURN macro. This can be used in shared code
    to get the drm_file_t * based on the filp passed in ioctl handlers.   o From Eric Anholt
  o From: Michel Daenzer
  o From Eric Anholt: some cleanups from AlanH
  o From Eric Anholt
  o From Eric Anholt + Jon Smirl
  o From Michel Daenzer
  o More differentiated error codes for DRM(agp_acquire)
  o drm_ctx_dtor.patch Submitted by: Erdi Chen
  o Miscellaneous changes from DRM CVS
  o radeon_drm.h
  o * Introduce COMMIT_RING() as in radeon DRM, stop using error prone
    writeback for ring read pointer (Paul Mackerras)
  o From Jon Smirl
  o define an empty driver pci ids for ffb driver
  o convert DRM to use pci device structures on Linux, move pci ids
    into a separate include file (this is auto-generated from the DRM
    tree)
  o drmP.h
  o drm_irq.h
  o drm_pciids.h

Dave Jones:
  o [CPUFREQ] powernow-k8 cpuid changes
  o [CPUFREQ] powernow-k8 ignore invalid p-states
  o [CPUFREQ] powernow-k8: prevent BIOSs offering a vid of 0x1f, which
    means off
  o [CPUFREQ] Export scaling cur frequencies Many users want to know
    the current cpu freqeuncy, even if not using the userspace
    frequency. On ->target cpufreq drivers (if they do their calls to
    cpufreq_notify_transition correctly) this just means reading
  o [CPUFREQ] Move cpufreq_get() from the userspace governor to the
    core
  o [CPUFREQ] Export cpufreq_get() to userspace
  o [CPUFREQ] Fix 'out of sync' issue
  o [CPUFREQ] (Hopefully) fix cpufreq resume support
  o [CPUFREQ] Handle CPUFREQ_RESUMECHANGE notifications Notifications
    in i386, sparc64, x86_64, sh-sci and sa11xx-pcmcia notifiers.
  o [CPUFREQ] use elanfreq's internal get function as ->get()
  o [CPUFREQ] use gx-suspmod's internal get function as ->get()
  o [CPUFREQ] Add a longhaul_get function
  o [CPUFREQ] Add longrun ->get Longrun users might be interested in
    their CPU's current frequency as well, so use a longrun-specific
    cpuid-call in longrun_get().
  o [CPUFREQ] Add p4-clockmod ->get p4-clockmod is a bit more
    complicated as it might run on SMP, HT, and the instructions need
    to run on the specific (physical) CPU.
  o [CPUFREQ] powernow-k6 ->get powernow_k6 has almost all pieces in
    place for its own ->get() function.
  o [CPUFREQ] powernow-k7->get() implementation by Bruno Ducrot
  o [CPUFREQ] Add powernowk8_get() but be careful as some code needs to
    run on specified CPU only.
  o [CPUFREQ] use speedstep_centrino's internal get function as ->get()
  o [CPUFREQ] Use speedstep_lib's capabilites for ->get() in
    speedstep-ich.c
  o [CPUFREQ] Use speedstep_lib's capabilites for ->get() in
    speedstep-smi.c
  o [CPUFREQ] arm-integrator ->get() implementation arm-integrator had
    its ->get() implementation inside integrator_cpufreq_init(). Move
    it to an extra function, and add it as ->get() function.
  o [CPUFREQ] sa11x0 ->get sa11x0_getspeed can be used by both
    cpu-sa1100.c and cpu-sa1110.c as
  o [CPUFREQ] Handle CPU frequency changing behind our back
  o [CPUFREQ] Also check whether the CPU frequency is out of sync once
    we get to cpufreq_notify_transition
  o [CPUFREQ] Handle P4 TSC scaling
  o [CPUFREQ] Clean up P4 centrino detection
  o [CPUFREQ] Improved Banias detection
  o [CPUFREQ] Add support for Pentium M (Dothan) processors
  o [CPUFREQ] Add support for Pentium M (Dothan) processors for
    p4-clockmod
  o [CPUFREQ] Warning fixes
  o [CPUFREQ] cpu_sibling_mask fixup
  o [CPUFREQ] Latency is in nanoseconds -- speedstep-centrino got it
    wrong
  o [CPUFREQ] Avoid scheduling cpufreq_delayed_get_work() twice; but do
    call it a bit earlier
  o [CPUFREQ] Fix for longrun.c for degenerate case From H. Peter Anvin
  o [CPUFREQ] Nehemiah improvements for longhaul driver
  o Use -msoft-float
  o [CPUFREQ] Fix several operator precedence bugs
  o [CPUFREQ] Makefile reordering issues
  o [CPUFREQ] Sync p4-clockmod MSR access across logical CPUs
  o [CPUFREQ] Fix an invalid comment in speedstep-ich This driver is
    for ICH only, not for PIIX4. Thanks to Christian Hilberg for noting
    this.
  o  Remove a local 1k array.

Dave Kleikamp:
  o JFS: Avoid race invalidating metadata page
  o JFS: reduce stack usage
  o JFS: [CHECKER] More robust error recovery in add_index
  o JFS: module unload was not removing /proc/fs/jfs/
  o JFS: error in __get_metapage caused by invalid size from ea_get
  o JFS: Don't return -EPERM for system xattrs
  o JFS: Implement multiple commit threads
  o JFS: set GFP_NOFS to avoid recursing back into file system code
  o JFS: [CHECKER] Memory leak on commonly executed path
  o JFS: [CHECKER] if txCommit fails, don't call d_instantiate

David Brownell:
  o USB: fix usbfs iso interval problem
  o USB: root hubs can report remote wakeup feature
  o USB: usbtest, smp unlink modes
  o USB: re-factor enumeration logic
  o USB: khubd fixes
  o USB: fix sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c
    hubstatus
  o USB Gadget: gadget zero and USB suspend/resume
  o USB: reject urb submissions to suspended devices
  o USB: dummy_hcd, root port wakeup/suspend
  o USB: usbnet handles Billionton Systems USB2AR
  o USB: EHCI power management updates
  o USB: more functional HCD PCI PM glue
  o USB: OHCI resume/reset stops deadlocking in PM code
  o USB: OHCI cleanups
  o USB: khubd turns port power back on after reset
  o USB: OHCI root hub suspend/resume/wakeup
  o USB: missing probe() diagnostics for CDC Ethernet
  o USB: usbhid calls itself "hid"
  o USB: ohci resume fix
  o USB: hcd-pci suspend tweak
  o USB: fix CONFIG_PM build issues
  o USB: fix MSEC_TO_JIFFIES in usb code
  o USB: RNDIS (and CDC) filter flag handling
  o USB: ethernet/rndis gadget address params

David Eger:
  o radeon: fix overlapping copyarea
  o trivial: MAINTAINERS fbdev - web site change

David Gibson:
  o ppc64: use generic ipc syscall translation
  o hugepage: fix add_to_page_cache() error handling
  o ppc64: trivial cleanup

David Mosberger:
  o ia64: Avoid ".save rp, r0" since the kernel unwinder doesn't
    support it yet
  o ia64: rename "mem" boot parameter to "max_addr" and implement
    proper "mem"
  o ia64: Fix spurious GAS dependency-violation (dv) warnings by taking
    advantage of two new GAS directives
    (.serialize.{data,instruction}).
  o ia64: Add support to the kernel unwinder for the ".save rp, r0"
    idiom
  o ia64: Minor changes to get a (mostly) clean compile with GCC
    pre-3.5
  o ia64: Call print_modules() before printing tombstone
  o ia64: fix spurious "timer tick before it's due" problem
  o ia64: Correct atomic_inc_and_test() and atomic64_inc_and_test()
  o ia64 atomic_inc_and_test fix
  o s390 atomic_inc_and_test() fix
  o ia64: Fix bug in fsys_rt_sigprocmask() reported by Andreas Schwab
  o ia64: Reserve syscall number for kexec_load()
  o fbmem: rename sys_inbuf() and sys_outbuf()
  o drop left-over #ifndef __ia64__
  o ia64: Kill a warning when arch/ia64/kernel/machvec.c gets compiled
    on UP
  o ia64: Update defconfig
  o Sanitise handling of unneeded syscall stubs

David S. Miller:
  o [TG3]: Add 572x/575x PCI IDs
  o [TG3]: Add 5750 chip and PHY IDs
  o [TG3]: Prepare for 5750 support plus minor fixes
  o [TIGON3]: Detect and record PCI Express
  o [TG3]: PCI Express 5750_A0 chips need 5701_REG_WRITE_BUG treatment
  o [TG3]: Fix chiprev test in previous change
  o [TG3]: Do not set CLOCK_CTRL_DELAY_PCI_GRANT on PCI Express
  o [TG3]: Double delay after writing MAC_MI_MODE reg
  o [TG3]: Correct RDMAC/WDMAC mode settings on 5705/5750
  o [TG3]: Do not write stats coalescing ticks reg on 5705/5750
  o [SCHED]: Fix double slash in include directive
  o [SPARC64]: Export pci_domain_nr to modules
  o [TG3]: Update to 5788 capable 5705 TSO firmware, version 1.2.0
  o [TG3]: Update to non-5705 TSO firmware version 1.6.0
  o [TG3]: If asked to load TSO firmware on 5750, just return success
  o [TG3]: Add 5750 NVRAM programming plus 5704 MAC offset bug fix
  o [TG3]: Update LED programming to support 5750
  o [TG3]: Updated ASF handling for 5750
  o [TG3]: Include mss in every txd, not just the first, on 5750
  o [TG3]: On 5750 with TSO, need to set some special reg bits
  o [TG3]: Full chip reset tweaks for 5750
  o [TG3]: More 5750 chip reset tweaks
  o [TG3]: Do not enable slow clocks on 5750 with ASF
  o [TG3]: Rewrite dma_rwctrl settings to handle PCIX/PCIE
  o [TG3]: Add 572x/575x PCI IDs to driver table, update vers/reldate
  o Resolve merge conflicts
  o [SPARC64]: Update defconfig
  o [SPARC64]: Mark sort_memlist static

David Vrabel:
  o [ARM] Fix IXP4xx CLOCK_TICK_RATE to match HW 66.66... MHz
  o [ARM] Fix IXP4XX_OST_RELOAD_MASK definition to not mask proper bits

Deepak Saxena:
  o PCI: pci.ids update from sf.net + add IXP4xx to pci_ids.h
  o I2C: Update IXP4xx I2C bus driver
  o First of a set of eight patches that adds support for Intel's
    IXP4xx family of network processors. The code still needs some
    cleanup here and there, but it's to the point that it's should be
    OK to push upstream.
  o entry-armv.S, debug.S, bios32.c
  o head.S, Makefile
  o proc-xscale.S, Kconfig
  o Add IXP4xx support
  o pci_ids.h
  o common.c
  o common.c
  o prpmc1100-setup.c, ixdp425-setup.c, coyote-setup.c
  o [ARM] Remove Documentation/ARM/XScale
  o MTD driver for Intel IXP4xx platform (from MTD CVS tree)
  o [ARM] Add config help and documentation for Intel IXP4xx platforms
  o I2C: Missed ixp42x -> ixp4xx conversion
  o Watchdog timer for Intel IXP4xx CPUs
  o [ARM] Fix bogus variable name in dev_dbg() call in dmabounce code

Denis Vlasenko:
  o fealnx #0: replace dev->base_addr with ioaddr
  o fealnx #1: replace magic constants with enums
  o fealnx #2: add 'static'; fix wrapped comment
  o fealnx #3: fix pointer substraction bug
  o fealnx #4: stop doing stop_nic_rx/writel(np->crvalue) in
    reset_rx_descriptors
  o fealnx #5: introduce stop_nic_rxtx(), use it where makes sense
  o fealnx #6: Francois' fixes for low memory handling; remove
    free_one_rx_descriptor (not used anymore)
  o fealnx #7: Garzik fix (IIRC): add locking to tx_timeout
  o fealnx #8: rework error handling
  o fealnx #9: fix locking for set_rx_mode
  o fealnx #10: replace local delay functions with udelay
  o fealnx #11: cleanup and coding style

Don Fry:
  o pcnet32 add register dump capability
  o pcnet32 timer to free tx skbs for 79C971/972

Duncan Sands:
  o USB usbfs: take a reference to the usb device
  o USB usbfs: replace the per-file semaphore with the per-device
    semaphore
  o USB usbfs: remove obsolete comment from proc_resetdevice
  o USB usbfs: fix up proc_setconfig
  o USB usbfs: fix up proc_ioctl
  o USB usbfs: fix up releaseintf
  o USB usbfs: destroy submitted urbs only on the disconnected
    interface
  o USB usbfs: missing lock in proc_getdriver
  o USB usbfs: drop pointless racy check
  o USB: be assertive in usbfs
  o USB: usbfs: change extern inline to static inline
  o USB: fix WARN_ON in usbfs
  o USB: Patch to remove interface indices from devio.c
  o USB: compile fix for usbfs snooping

Eric Dean Moore:
  o MPT Fusion add back FC909 support
  o MPT Fusion driver 3.01.06 update

Fabian Frederick:
  o partitioning cleanup: use DOS_EXTENDED_PARTITION

Fabian.Frederick:
  o ppc32: remove 'mem_pieces_append'

Fabrice Menard:
  o fbdev: Fix fbcon and unimap

Frank Cornelis:
  o sched: improved resolution in find_busiest_node

François Romieu:
  o x86 cpuid cache info update

Gary Wong:
  o [sound i810] silently ignore invalid PCM_ENABLE_xxx bits from
    userland

Gaston D:
  o I2C: ICH6/6300ESB i2c support

Geert Uytterhoeven:
  o Sun3x dummycon
  o M68k missing <linux/compiler.h>
  o M68k superfluous whitespace
  o fbdev: Vesa Fbdev update fix
  o m68k: use print_modules()

Geoffrey LEVAND:
  o ppc32: some fixes for 'make O=...'

Greg Aumann:
  o com90xx error message patch: check_region() gone

Greg Edwards:
  o calculate NGROUPS_PER_BLOCK from PAGE_SIZE

Greg Kroah-Hartman:
  o USB: fix devio compiler warnings created by previous patch
  o USB: switch struct urb to use a kref instead of it's own atomic_t
  o USB: removed unused atomic_t in keyspan driver structure
  o USB: make ehci driver use a kref instead of an atomic_t
  o USB: fix incorrect usb-serial conversion for cur_altsetting from
    previous patch
  o USB: fix compiler warnings in devices.c file
  o My cleanups to the smbios driver
  o USB: remove the wait_for_urb function from bfusb driver as it's no
    longer needed
  o USB: fix build error in hci_usb driver due to urb reference count
    change
  o PCI Hotplug: fix stupid build bugs caused by previous patches
  o PCI Hotplug: fix build error due to previous patches
  o I2C: rename i2c-ip4xx.c driver
  o PCI Hotplug: revert broken PCI Express hotplug patch
  o USB: add support for Zire 31 devices
  o Driver core: handle error if we run out of memory in kmap code
  o Add modules to sysfs
  o USB: make functions static in usb drivers that should be
  o Module attributes: fix build error if CONFIG_MODULE_UNLOAD=n
  o USB: add snooping capability to usbfs for control messages
  o USB: remove magic number field from usb_serial_port as it's pretty
    useless
  o USB: remove magic number field from struct usb_serial as it's
    pretty useless
  o USB: removed port_paranoia_check() call for usb serial drivers
  o USB: remove serial_paranoia_check() function
  o USB: remove get_usb_serial() as it's pretty much unneeded
  o USB: change usbserial core to use module_param()
  o USB: convert pl2303 to use module_param()
  o USB: convert visor to use module_param()
  o USB: fix build error in drivers/usb/serial/console.c
  o USB: fix dumb compile error in aiptek driver
  o USB: fix up formatting issues with aiptek driver
  o PCI Hotplug: clean up a lot of global symbols that do not need to
    be
  o Add msleep function to the kernel core to prevent duplication
  o Delete block/carmel.c's version of msleep()
  o Remove libata's version of msleep()
  o USB: remove usb_uninterruptible_sleep_ms() now that we have
    msleep()
  o USB: clean up usages of wait_ms() now that we have msleep()
  o USB: remove ehci and ohci's private sleep function and use msleep()
    instead
  o USB: remove wait_ms() from usb.h as it's no longer needed
  o I2C: change i2c_delay() to use msleep() instead
  o Input: remove wait_ms() in place of using msleep()
  o Some more misc wait_ms() conversions to use msleep()

Greg Ungerer:
  o ucLinux: return 0 on success from do_munmap() for nommu version
  o m68knommu: fix cache flush for 5407 ColdFire CPU
  o m68knommu: big clean/fix of Dragonball frame buffer driver
  o m68knommu: add find_next_bit() to bitops.h
  o m68knommu: add init points for Dragonball frame buffer driver
  o m68knommu: un-define IO instructions when using smc driver
  o m68knommu: remove ColdFire specific atomic functions
  o m68knommu: correct build line for Dragonbakk frame buffer driver
  o m68knommu: remove un-used libgcc symbols
  o m68knommu: add newlines to debug trace in comempci.c

Hanna V. Linder:
  o Add class support to drivers/char/ip2main.c
  o add class support to drivers/block/paride/pg.c
  o add class support to drivers/block/paride/pt.c
  o add class support to drivers/char/tipar.c
  o Lindent arch/i386/kernel/cpuid.c
  o Add class support to drivers/net/wan/cosa.c
  o USB: Add class support to drivers/usb/misc/tiglusb.c

Herbert Xu:
  o aic7xxx: fix oops whe hardware is not present
  o USB Storage: Sony Clie
  o [sound/oss i810] fix wait queue race in drain_dac
  o [sound/oss i810] fix race
  o [sound/oss] remove bogus CIV_TO_LVI
  o [sound/oss i810] clean up with macros
  o [sound/oss i810] fix partial DMA transfers
  o [sound/oss i810] fix playback SETTRIGGER
  o [sound/oss i810] fix OSS fragments
  o [sound/oss i810] remove divides on playback
  o [sound/oss i810] fix drain_dac loop when signals_allowed==0
  o [sound/oss i810] fix reads/writes % 4 != 0
  o [sound/oss i810] fix deadlock in drain_dac
  o acpiphp_glue.c oops fix
  o Module ref counting for vt console drivers
  o [IPSEC]: Fix state modifications in xfrm_state_update()
  o [IPSEC]: Lock policy in policy timer

Hideaki Yoshifuji:
  o [IPV6] handle return value from ip6_push_pending_frames()
  o [IPV6] unify XXX_push_pending_frames() code path for rawv6 sockets
  o [IPV6] unify csum_ipv6_magic() code path for rawv6 sockets
  o [IPV6] put appropriate checksum for rawv6 sockets even if it was
    not initialized
  o [IPV6] ensure to evaluate the checksum for sockets with the
    IPV6_CHECKSUM option
  o [IPV4]: Fix deadlock in IP tunnel error path

Hirofumi Ogawa:
  o 8139too: more useful debug info for tx_timeout

Hugh Dickins:
  o VM accounting fix
  o autofs4: readdir fixes
  o rmap 7 object-based rmap
  o rmap 8 unmap nonlinear
  o rmap 9 remove pte_chains
  o rmap 10 add anonmm rmap
  o rmap 11 mremap moves
  o rmap 12 pgtable remove rmap
  o rmap 13 include/asm deletions
  o Convert i_shared_sem back to a spinlock
  o rmap 14: i_shared_lock fixes
  o mpol in copy_vma
  o rmap 15: vma_adjust
  o rmap 16: pretend prio_tree
  o rmap 17: real prio_tree
  o rmap 18: i_mmap_nonlinear
  o rmap 19: arch prio_tree
  o vm_area_struct size comment
  o rmap 20 i_mmap_shared into i_mmap
  o rmap 21 try_to_unmap_one mapcount
  o rmap 22 flush_dcache_mmap_lock
  o rmap 23 empty flush_dcache_mmap_lock
  o rmap 24 no rmap fastcalls
  o rmap 27 memset 0 vma
  o rmap 28 remove_vm_struct
  o rmap 33 install_arg_page vma
  o rmap 34 vm_flags page_table_lock
  o rmap 35 mmap.c cleanups
  o rmap 36 mprotect use vma_merge
  o rmap 37 page_add_anon_rmap vma
  o rmap 38 remove anonmm rmap
  o rmap 39 add anon_vma rmap
  o rmap 40 better anon_vma sharing

Ian Campbell:
  o [ARM PATCH] 1827/1: PXAFB patch updated based on comments in 1826
  o [ARM] Fix use of page->count

Ian Kent:
  o Fix deadlock in journalled quota
  o autofs4: printk cleanups and memory leak fix
  o autofs4: locking rework
  o autofs4: expiry refcount fixes
  o autofs4: may_umount_tree() cleanup
  o autofs4: fix handling of chdir and chroot
  o autofs4: add ioctl to query unmountability
  o autofs4: readdir futureproofing
  o autofs4 race fix
  o autofs4 compat ioctls
  o autofs4: printk cleanup
  o autofs4: MAINTAINERS update

Ingo Molnar:
  o small scheduler cleanup
  o sched: scheduler domain support
  o sched: trivial fixes, cleanups
  o sched: uninlinings
  o sched: add enqueeu_task_head()
  o sched: extend sync wakeups
  o sched: cleanups
  o sched: cpu load management cleanup
  o sched: balance-on-clone
  o [netdrvr dmfe] netpoll support

Ivan Kokshaysky:
  o alpha: atomic_inc_and_test()
  o alpha: fix GP-load symbol linkage
  o alpha fp-emu vs module refcounting

J. Bruce Fields:
  o kNFSd: Fix race conditions in idmapper
  o kNFSd: Improve idmapper behaviour on failure
  o kNFSd: Reduce timeout when waiting for idmapper userspace daemon
  o kNFSd: Remove check on number of threads waiting on user-space
  o kNFSd: Add a warning when upcalls fail,
  o svc_recv() fix
  o gss_api build fix

Jakub Jermar:
  o bfs filesystem read past the end of dir

James Bottomley:
  o aic7xxx: compile fix for EISA only case
  o Cset exclude: jejb@mulgrave.(none)|ChangeSet|20040404150128|05866
  o Fix errors in [PATCH] aic7xxx: fix oops whe hardware is not present
  o Add SCSI IPR PCI Ids to pci_ids.h
  o fix LLD module refcounting in sr.c
  o fix dev_printk to work even in the absence of an attached driver

James Simmons:
  o fbdev: Neomagic driver update
  o fbdev: clean up logo handling
  o fbdev: remove redundant p->vrows calculation
  o fbdev: remove redundant local
  o fbdev: set a default access_align value
  o fbdev: Virtual fbdev updates
  o fbdev: Vesa Fbdev update
  o fbdev: New Asiliant framebuffer driver
  o fbdev: Q40 fbdev updates
  o fbdev: mode switching fix

Jan Kara:
  o dquot_release oops fix
  o Quota fix 2
  o Quota fix 3 - quota file corruption

Jean Delvare:
  o I2C: Add LM99 support to the lm90 driver
  o I2C: Voltage conversions in via686a
  o I2C: Sensors (W83627HF) in Tyan S2882
  o I2C: Invert as99127f beep bits in kernel space
  o I2C: Rewrite temperature conversions in via686a driver
  o I2C: Fix memory leaks in w83781d and asb100
  o I2C: kill duplicate includes in i2c bus drivers
  o I2C: Rename hardware monitoring I2C class

Jeff Garzik:
  o [libata sata_sis] add new PCI id
  o [libata] Promise driver split part 1: clone to sx4
  o [libata] Promise driver split part 2: remove SX4 code from
    sata_promise
  o [libata] Promise driver split part 3: remove TX2/4 code from
    sata_sx4
  o [libata] Promise driver split part 4: common header
  o [libata] add ata_tf_{to,from}_fis helpers
  o [libata] clean up taskfile submission to hardware
  o [libata] move ATAPI startup from katad thread to workqueue thread
  o [libata] move PIO data xfer from katad thread to workqueue thread
  o [libata] move probe execution from katad thread to workqueue thread
  o [libata] move ATAPI command initiation code from libata-scsi to
    libata-core
  o [libata] make ata_wq workqueue local to libata-core module
  o [libata] internal cleanup: kill ata_pio_start
  o [libata] some work on the ATAPI path
  o [libata] work queueing cleanups and fixes
  o [libata] increase max-sectors limit for modern drives
  o [libata] replace per-command semaphore with optional completion
  o [libata promise] make sure our schedule_timeout(N) are never with
    N==0
  o [libata] remove unused struct ata_engine
  o [libata sata_sx4] trivial: fix filename in header
  o [netdrvr b44] ethtool_ops support
  o [netdrvr b44] use netdev_priv
  o [netdrvr b44] use miilib for MII ioctl handling
  o [libata] preparation for writeback caching support
  o [libata] Maintainer annotations
  o [libata] add new ->bmdma_setup hook
  o [libata] use new ->bmdma_{start,setup} method to properly support
    ATAPI
  o [libata] more ATAPI work - translate SCSI CDB to ATA PACKET
  o [libata] random minor bug fixes
  o [libata] kill ATA_QCFLAG_POLL flag
  o [netdrvr] remove rcpci driver, for Red Creek Hardware VPNs
  o [sound/oss i810] bump driver to version 1.00
  o [sound/oss i810] pci id cleanups
  o [libata] internal cleanups
  o [libata] minor stuff
  o [libata] handle non-data ATAPI commands via interrupt
  o [libata] DMADIR support
  o [libata] remove redundant use of ATA_QCFLAG_SG in ATAPI packet
    translation
  o [libata] SCSI->ATA simulator hacking: INQUIRY command
  o [libata] comments and constants
  o [libata] scsi simulator improvements: MODE SENSE, SEEK(6,10),
    REZERO_UNIT
  o [libata] replace ATA_QCFLAG_ATAPI with inline helper
  o [libata] polish DocBook docs a bit

Jeff Mahoney:
  o reiserfs: add device info to diagnostic messages
  o autofs4: dnotify + autofs may create signal/restart syscall loop

Jens Axboe:
  o as-iosched barrier fix
  o slabify iocontext + request_queue
  o expose backing dev max read-ahead
  o blk: clear completion stack pointer on return

Jeremy Higdon:
  o sata_vsc initialization fix
  o minor changes to qla1280 driver

Jesse Barnes:
  o ia64: sn_get_node_first_cpu() is redundant
  o ia64: kill warnings in sn2 specific pci init
  o ia64: This patch kills some unused lines and redundant functions
  o ia64: map display option ROMs on SN2

Jim Hague:
  o fbdev: Fix NULL-ptr dereference in pm2fb_probe

Jochen Hein:
  o PCI: I'm moving
  o PCI: message cleanup in PCI probe

John Lenz:
  o [ARM PATCH] 1851/1: sa1100 fb support for collie

John Rose:
  o PCI Hotplug: RPA DLPAR remove slot, return code fix
  o ppc64: fix rtas flash driver

John Stultz:
  o jiffies-to-clockt fix

Jonathan Corbet:
  o Remove drivers/net/auto_irq.c
  o SubmittingDrivers completeness

Jonathan McDowell:
  o Initio INI-9X00U/UW error handling in 2.6

Jose R. Santos:
  o dentry and inode cache hash algorithm performance changes

Joseph Parmelee:
  o Crystal cs4235 mixer fix

Jörn Engel:
  o fix ramdisk size assembler warning

Jürgen Stuber:
  o USB: LEGO USB Tower driver v0.95

Kai Mäkisara:
  o SCSI tape log message fixes

Karsten Keil:
  o fix typo in avm_cs PCMCIA AVM B1 cardservice driver

Keith Owens:
  o Allow architectures to reenable interrupts on contended spinlocks
  o Warn when smp_call_function() is called with interrupts disabled
  o make buildcheck

Kenn Humborg:
  o Re: Platform device matching

Kenneth W. Chen:
  o blk: cache queue_congestion_on/off_threshold values
  o trivial: Fix name of biovec slab

Kevin O'Connor:
  o I2C: support I2C_M_NO_RD_ACK in i2c-algo-bit

Kurt Garloff:
  o scsi: don't attach device if PQ indicates not connected

Len Brown:
  o [ACPI] handle _CRS outside _PRS -- even when non-zero avoid sharing
    IRQ12 http://bugzilla.kernel.org/show_bug.cgi?id=2665
  o [ACPI] create platform_rename_gsi() so ES7000 can munge IRQ numbers
    from Natalie Protasevich
  o [ACPI] if _STA.functional, set _STA.present (Bjorn Helgaas)
    workaround for Big Sur and Bull systems
  o [ACPI] Add MADT error checking (Yi Zhu)
    http://bugzilla.kernel.org/show_bug.cgi?id=1434
  o [ACPI] create kacpid thread to handle ACPI work in process context
  o [ACPI] delete IOAPIC-disable workaround on x86_64/VIA
    http://bugme.osdl.org/show_bug.cgi?id=1530
  o [ACPI] revert button module unload fix (2281) Cset exclude:
    len.brown@intel.com|ChangeSet|20040503042906|02093 Cset exclude:
    len.brown@intel.com|ChangeSet|20040428081825|02121 Cset exclude:
    len.brown@intel.com[lenb]|ChangeSet|20040428071221|03892
  o [ACPI] remove /proc files before unloading modules from Sau Dan
    Lee, Zhenyu Wang http://bugzilla.kernel.org/show_bug.cgi?id=2705

Linda Xie:
  o PCI Hotplug: rpaphp: set eeh option (enabled ) prior to any i/o to
    newly added IOA
  o PCI Hotplug: rpaphp doesn't initialize slot's name

Linus Torvalds:
  o Remove intermezzo, per instructions from Peter Braam
  o Make dev_dbg() "use" it's 'dev' argument even when not debugging
  o Fix typo nonsense test in radeon PMAC backlight code
  o Fix bogus debug code in usb/misc/cytherm.c
  o Fix gidsetsize == 0 for real this time
  o We need to use "memset_io()" when accessing PCI mapped memory.
  o Fixed mismerge of cpufreq and pcmcia updates
  o Shorten some PCI device names
  o Add 'mode' argument to vfs_symlink
  o [REDO] ramdisk: separate the blockdev backing_dev_info from the
    hosted inodes
  o Avoid type warning in comparison by making it explicit
  o Linux 2.6.7-rc1

Luebs K:
  o [ARM PATCH] 1848/1: PXA suspend/resume improvements

Luiz Capitulino:
  o pcmcia/i82365.c warning fix
  o pcmcia/tcic.c warning fix
  o fix wrong var used in hotplug/shpchp_ctrl.c
  o PCI Hotplug: fix wrong var used in hotplug/shpchp_ctrl.c
  o USB: fix media/dsbr100.c unused variable
  o fbdev: video/tridentfb.c warning fix
  o fbdev: video/hgafb.c warning fix
  o fbdev: video/tdfxfb.c warning fix
  o fbdev: video/imsttfb.c warning fix
  o floppy.c: better floppy_init error handling
  o floppy.c: better/cleaner use of debugt
  o drivers/cdrom/aztcd.c warning fix

Maneesh Soni:
  o kobject_set_name - error handling
  o kobject/sysfs race fix
  o sysfs_rename_dir-cleanup
  o Fix !CONFIG_SYSFS build

Manfred Spraul:
  o slab: enable runtime cache line size on i386
  o slab: allow arch override for kmem_bufctl_t
  o slab: add kmem_cache_alloc_node

Marcel Holtmann:
  o [Bluetooth] Fix disconnect race on ISOC interface
  o [Bluetooth] Adapt changes for USB core altsettings
  o [Bluetooth] Use type of the parent socket

Marcel Sebek:
  o Class support for ppdev.c

Marcelo Tosatti:
  o cyclades MAINTAINERS update
  o cyclades cleanups

Marco Cova:
  o trivial: fix old URLs in initrd doc

Mark Haverkamp:
  o aacraid reset handler fix

Mark Huth:
  o [IPV6]: Fix sock identity checking bug in
    tcp_ipv6_check_established

Markus Demleitner:
  o USB: DSBR-100 tiny patch

Markus Lidel:
  o I2O subsystem fixing and cleanup for 2.6 - i2o-config-clean.patch
  o I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch
  o i2o: 64-bit fixes
  o I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch
  o I2O subsystem fixing and cleanup for 2.6 - i2o-64-bit-fix.patch
  o I2O subsystem fixing and cleanup for 2.6 -
    i2o-makefile-cleanup.patch
  o Fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct
  o i2o: reorder of fields in i2o_cmd_passthru structure

Martin Diehl:
  o sir_dev locking fix

Martin Hicks:
  o Reduce TLB flushing during process migration

Martin Schaffner:
  o trivial: add parantheses for if (necessary for cross-compilation)

Martin Schwidefsky:
  o s390: core
  o s390: common i/o layer
  o s390: dasd driver
  o s390: 3270 console driver
  o s390: zfcp host adapter
  o s390: network driver
  o s390: core s390
  o s390: dasd driver
  o s390: zfcp host adapater
  o s390: network driver

Mathieu Chouquet-Stringer:
  o [SPARC]: Mark unaligned_panic as attribute used to workaround
    gcc-3.4 problem
  o [MODULES]: Fix endianness in modprobe
  o Fix endianess in modpost when cross-compiling for sparc on i386
  o Fix for Makefiles to get KBUILD_OUTPUT working

Matt Domsch:
  o PCI: PCI devices with no PCI_CACHE_LINE_SIZE implemented
  o EDD: follow sysfs convention, MODULE_VERSION, remove dead SCSI
    symlink
  o remove blk_queue_bounce() printks
  o EDD: remove unused SCSI header files
  o efivars: add MODULE_VERSION, remove unnecessary check in exit

Matt Mackall:
  o VFS cache sizing fix for small machines

Matt Porter:
  o PPC32: Fix __flush_dcache_icache_phys() for Book E
  o PPC32: Fix copy prefetch on non coherent PPCs
  o PPC32: Add Book E / PPC44x specific exception support
  o PPC32: Add Book E / PPC44x specific exception support
  o PPC32: New OCP core support (updated)
  o PPC32: Bubinga/405EP for new OCP
  o PPC32: PPC44x lib support
  o PPC32: IBM PPC4xx-specific OCP support
  o PPC32: 4xx core fixes and 440gx PIC support
  o PPC32: Update 4xx defconfigs
  o PPC32: PPC40x ports for new OCP
  o PPC32: PPC44x ports for new OCP
  o ppc32: Fix ocp_register_driver() return value
  o ppc32: PPC4xx fixes
  o PPC32: Minor OCP cleanups

Matthew Dharm:
  o USB: usb-storage driver changes for 2.6.x [1/4]
  o USB: usb-storage driver changes for 2.6.x [2/4]
  o USB: usb-storage driver changes for 2.6.x [3/4]
  o USB: usb-storage driver changes for 2.6.x [4/4]

Matthew Dobson:
  o numa api: Core NUMA API code

Matthew Wilcox:
  o PA-RISC updates for 2.6.6

Max Asbock:
  o add ibmasm driver warning message

Maximilian Attems:
  o trivial: add CC Trivial Patch Monkey to SubmittingPatches

Michael Buesch:
  o bootmem.c cleanup

Michael E. Brown:
  o add SMBIOS tables to sysfs -- UPDATED

Michael Hunold:
  o I2C: add .class to i2c drivers

Michael Veeck:
  o (5/5) pcmcia/nsp: use kernel.h min/max/ARRAY_SIZE
  o (2/5) aic7xyz_old: use kernel.h min/max/ARRAY_SIZE
  o (4/5) nsp32 (ninja): use kernel.h min/max/ARRAY_SIZE
  o (3/5) ncr53c8x: use kernel.h min/max

Mikael Pettersson:
  o reduce NMI watchdog call frequency with local APIC
  o gcc-3.4.0 fixes for 2.6.6-rc3 x86_64 kernel

Mike Anderson:
  o fix module unload problem in sd

Mike Miller:
  o cpqarray update for 2.6

Mingming Cao:
  o use-before-uninitialized value in ext3(2)_find_ goal

Natalie Protasevich:
  o es7000 subarch update
  o es7000 subarch update for generic arch

Nathan Lynch:
  o ppc64: fix rtas error log location

Neil Brown:
  o md: Fix user-after-free bug in multipath
  o kNFSd: Use correct _bh locking on sv_lock
  o kNFSd: Make sure CACHE_NEGATIVE is cleared when a cache entry is
    updates
  o kNFSd: Allow larger writes to sunrpc/svc caches
  o kNFSd: Change fh_compose to NOT consume a reference to the dentry
  o kNFSd: Protect reference to exp across calls to nfsd_cross_mnt
  o raid locking fix
  o Invalid notify_change(symlink, [ATTR_MODE]) in nfsd
  o Fix NFSD oops in readdir

Nick Piggin:
  o sched_domain debugging
  o scheduler domain balancing improvements
  o sched: handle inter-CPU jiffies skew
  o sched-group-power
  o sched_domains: use cpu_possible_map
  o sched: add local load metrics
  o sched: wakeup balancing fixes
  o sched: fix imbalance calculations
  o sched: altix tuning
  o sched: oops fix
  o sched: minor cleanups
  o sched: lock cpu_attach_domain for hotplug
  o sched: passive balancing damping
  o sched: reduce idle time
  o sched: micro-optimisation for wake_up
  o sched: Look at another CPU's domain
  o AS: increase batch expiry intervals
  o sched: add missing local_irq_enable()
  o sched: improved cpu_load rounding
  o sched: fix scheduler for unsynched processor sched_clock
  o sched: less locking in balancing
  o Fix arithmetic in shrink_zone()

Nicolas Pitre:
  o [ARM PATCH] 1828/2: rework SA11xx PCMCIA code structure for better
    sharing of generic code
  o [ARM PATCH] 1829/1: base support for PCMCIA on the Intel PXA2xx
    chip
  o [ARM PATCH] 1830/2: PCMCIA support for Lubbock (PXA2xx based)
  o [ARM PATCH] 1831/1: remove outdated SA11xx PCMCIA documentation
  o [ARM PATCH] 1843/2: supress PCMCIA build warnings
  o [ARM PATCH] 1842/1: fix/clarify some comments
  o [ARM PATCH] 1863/2: definitions and mapping for the Intel PXA27x
    internal registers
  o [ARM PATCH] 1864/1: separate PXA25x and PXA27x specific code
  o [ARM PATCH] 1865/1: DMA changes for PXA27x
  o [ARM PATCH] 1871/1: faster IRQ retrieval for PXA27x
  o [ARM PATCH] 1867/1: support for the Intel Mainstone (PXA27x based)
    eval board
  o [ARM PATCH] 1868/1: support for LEDs on Mainstone
  o [ARM PATCH] 1870/1: defconfig for Mainstone
  o [ARM PATCH] 1889/1: don't select CONFIG_IWMMXT just yet with
    Mainstone

Nuno Monteiro:
  o cleanup double semicolons

Olaf Dabrunz:
  o SElinux interface for reporting size of printk buffer

Olaf Hering:
  o add simple class for adb
  o mptfusion depends on scsi
  o make tags for selinux
  o export clear_pages on ppc32
  o PPC64 iSeries virtual ethernet locking fix
  o console autodetection for pmac

Olaf Kirch:
  o groups_alloc(0) clobbers memory past end of block

Oleg Drokin:
  o Fix reiserfs oom crash

Oliver Neukum:
  o USB: fixes of assumptions about waitqueues
  o USB: further fix to mdc800
  o USB: new delay helper safe wrt waitqueues
  o USB: purge wait_ms from core

Olof Johansson:
  o ppc64: fix non-SMP build break

Pat Gefre:
  o ia64: SN2 - remove node_first_cpu member

Patrice Bouchand:
  o ib700wdt watchdog driver fix
  o ib700wdt watchdog driver fix #2

Patrick Finnegan:
  o [SPARC64]: Verify that boot CPU number is less than NR_CPUS

Paul Jackson:
  o Revisited: ia64-cpu-hotplug-cpu_present.patch

Paul Mackerras:
  o Un-inline spinlocks on ppc64
  o PPC termio fix
  o ppc64: extra barrier in I/O operations
  o ppc32: Fix pmac compile after OCP changes
  o ppc32: Move declarations into headers
  o ppc64: Kconfig bits for CONFIG_SPINLINE
  o ppc64: strengthen I/O and memory barriers
  o ppc32: some whitespace fixes
  o ppc32: Handle altivec assist exception properly
  o ppc32: update defconfigs
  o Fix incorrect PT_FPSCR definition
  o put module license in swim3.c
  o PPC32: Get full register set on bad kernel accesses
  o ppc64: move kmem_bufctl_t inside #ifndef __ASSEMBLY__
  o ppc64: fix inline version of _raw_spin_trylock
  o ppc64: update xmon debugger
  o ppc64: make enter_rtas() take unsigned long arg

Paul Mundt:
  o Remove old sh-sci driver

Pavel Machek:
  o Cleanups for b44
  o support swsusp for aic7xxx
  o swsusp documentation updates
  o trivial: Fix #endif comment in linux_moduleparam.h
  o trivial: swsusp section usage
  o swsusp: kill unneccessary debugging
  o swsusp: fix devfs breakage introduced in 2.6.6

Pavel Roskin:
  o PCI debug compile fix in sis_router_probe()

Pekka Pietikäinen:
  o [netdrvr b44] better reset behavior

Peter Chubb:
  o ia64: Make cond_syscall() declare a dummy prototype so GCC doesn't
    complain

Philippe Elie:
  o Fix nmi_watchdog=2 and P4 HT

Prof. BJ:
  o ppc32: ppc8xx build fixes

Rajesh Venkatasubramanian:
  o partial prefetch for vma_prio_tree_next

Ralf Bächle:
  o MIPS update
  o mips: fix 2.6 fb setup
  o mips: Simplify expression
  o mips: newport driver fixes
  o mips: remove VIDEO_TYPE_SNI_RM
  o mips: GBE Video Driver
  o mips: add missing IP22 Zilog bit
  o mips: 64-bit MIPS needs compat stuff
  o mips: remove dz driver
  o mips: sgiwd93 2.6 fixes and crapectomy

Ram Pai:
  o speed up readahead for seeky loads

Randy Dunlap:
  o efivars: check that it's enabled
  o videodev: handle class_register() failure
  o reserve syscall slots for kexec
  o correct ps2esdi module parm name
  o initialise mca_bus_type even if !MCA_bus

Rene Herman:
  o ide-disk.c: don't put disks in STANDBY mode on reboot

René Scharfe:
  o trivial: Make JFFS2 ready for Linux 2.7

Robin Farine:
  o [ARM PATCH] 1879/1: fix a few xscale "drain write & fill buffer"
    instructions

Roger Luethi:
  o Fix power/shutdown.c comments

Roland McGrath:
  o bogus sigaltstack calls by rt_sigreturn

Rolf Eike Beer:
  o PCI Hotplug: Clean up acpiphp_core.c: null checks
  o PCI Hotplug: Clean up acpiphp_core.c: slot_paranoia_check
  o PCI Hotplug: Clean up acpiphp_core.c: coding style
  o PCI Hotplug: Clean up acpiphp_core.c: kill hardware_test
  o PCI Hotplug: Clean up acpiphp_core.c: use goto for error handling
  o PCI Hotplug: Clean up acpiphp_core.c: return
  o PCI Hotplug: Clean up acpiphp_core.c: remove 3 get_* functions
  o CompactPCI Hotplug: remove unneeded funtion for parameter handling
  o CompactPCI Hotplug: kill magic number
  o CompactPCI Hotplug ZT5550: use new style of module parameters
  o ACPI PCI Hotplug: use new style of module parameters
  o ACPI PCI Hotplug: kill magic number
  o ACPI PCI Hotplug: use goto for error handling
  o ACPI PCI Hotplug: coding style fixes
  o ACPI PCI Hotplug: add a BUG() where one should be
  o PCI Hotplug skeleton: use new style of module parameters
  o PCI Hotplug skeleton: remove useless NULL checks
  o PCI Hotplug skeleton: fix codingstyle
  o PCI Hotplug skeleton: mark functions __init/__exit
  o PCI Hotplug skeleton: use goto for error handling
  o PCI Hotplug skeleton: final cleanups
  o PCI Express Hotplug: fix coding style
  o PCI Express Hotplug: remove useless kmalloc casts
  o PCI Express Hotplug: splut pciehp_ctrl.c::configure_new_function
  o Compaq PCI Hotplug: coding style fixes
  o Compaq PCI Hotplug: remove useless NULL checks
  o Compaq PCI Hotplug: move huge inline function out of header file
  o Compaq PCI Hotplug: use new style of module parameters
  o Compaq PCI Hotplug: more coding style fixes
  o Compaq PCI Hotplug: split up hardware_test
  o Compaq PCI Hotplug: use goto for error handling
  o Compaq PCI Hotplug: remove useless NULL checks from cpqphp_core.c
  o Compaq PCI Hotplug: fix C++ style comments
  o Compaq PCI Hotplug: use goto for error handling in cpqphp_ctrl.c
  o Compaq PCI Hotplug: coding style fixes for cpqphp_ctrl.c
  o Compaq PCI Hotplug: some final fixes for cpqphp_core.c
  o PCI Hotplug: Remove type magic from kmalloc
  o [BUGFIX] shpchp_pci.c: fix missing braces after if
  o PCI Hotplug Core: use new style of module parameters
  o PCI Hotplug: Move an often used while loop to an inline function
  o PCI Express Hotplug: use new style of module parameters
  o Compaq PCI Hotplug: fix missing braces
  o PCI Express Hotplug: remove useless NULL checks
  o RPA PCI Hotplug: Remove useless NULL checks
  o Compaq PCI Hotplug: kill useless kmalloc casts
  o PCI Express Hotplug: kill hardware_test
  o Compaq PCI Hotplug: remove useless NULL checks from cpqphp_ctrl.c
  o PCI Express Hotplug: use goto for error handling
  o PCI Express Hotplug: codingstyle fixes for pciehp.h
  o PCI Express Hotplug: remove useless kmalloc casts
  o PCI Express Hotplug: some cleanups
  o PCI Express Hotplug: mark global variables static
  o PCI Express Hotplug: kill more useless casts
  o PCI Express Hotplug: codingstyle fixes for pciehp_pci.c
  o RPA PCI Hotplug: use new style of module parameters
  o RPA PCI Hotplug: kill get_cur_bus_speed from rpaphp_core.c
  o RPA PCI Hotplug: codingstyle fixes for rpaphp_core.c
  o RPA PCI Hotplug: fix up init_slots in rpaphp_core.c
  o RPA PCI Hotplug: remove useless NULL checks from rpaphp_core.c
  o RPA PCI Hotplug: use goto for error handling in rpaphp_slot.c
  o RPA PCI Hotplug: codingstyle fixes for rpaphp_pci.c
  o SHPC PCI Hotplug: use new style of module parameters
  o SHPC PCI Hotplug: kill hardware_test
  o SHPC PCI Hotplug: fix cleanup_slots to use a release function
  o SHPC PCI Hotplug: use goto for error handling
  o SHPC PCI Hotplug: codingstyle fixes
  o SHPC PCI Hotplug: kill useless NULL checks
  o SHPC PCI Hotplug: more coding style fixes
  o SHPC PCI Hotplug: remove some useless casts
  o CompactPCI: remove set_attention_status
  o CompactPCI: remove two useless checks
  o CompactPCI: use goto for error handling
  o CompactPCI: remove useless NULL checks
  o CompactPCI: remove slot_paranoia_check and get_slot
  o CompactPCI: remove two useless functions
  o PCI Express, SHPCHP: fix freeing wrong resources
  o SHPC PCI Hotplug: fix cleanup_slots again

Ronald S. Bultje:
  o I2C: new i2c video decoder calls
  o I2C: new i2c video decoder calls: saa7111 driver

Russell King:
  o Fix MTD suspend/resume
  o [SERIAL] Fix exit function pointer initialisers
  o [SERIAL] Remove base_baud default from 8250_pci
  o [ARM] Move a bunch of symbol exports from armksyms.c
  o [ARM] Convert execve() to be a function rather than a SWI call
  o [ARM] Update atomic.h
  o [ARM] Add linux/module.h include for ioremap
  o [ARM] Initialise an uninitialised spinlock

Rusty Russell:
  o Hotplug CPU sched_balance_exec Fix
  o sched: in_sched_functions() cleanup
  o Only Print Taint Message Once
  o Fix __down Tainting Kernel with CONFIG_MODVERSIONS=y
  o show last kernel-image symbol in /proc/kallsyms
  o Include Aliases in kallsyms
  o Fix overzealous use of online cpu iterators
  o fix for stuck cpus at boot]
  o Debugging option to put data symbols in kallsyms
  o trivial: drivers/media/video_ir-kbd-gpio.c: kill duplicate include
  o Fix i386/x86_64 cpuid/msr BUG() on impossible CPUs

Santiago Leon:
  o PowerPC Virtual Ethernet duplicate MAC addresses
  o PowerPC Virtual Ethernet links to /sys/class/net/ethX

Sau Dan Lee:
  o laptop-mode documentation fix

Scott Feldman:
  o e100: fix for incoherent arches
  o e100: big-endian fix for ethtool -e/E
  o e100: netdev->priv to netdev_priv()

Sean Young:
  o USB: add new USB PhidgetServo driver
  o USB: fix PhidgetServo driver

Sepp Wijnands:
  o USB: Alcatel TD10 Serial to USB converter cable support

Sergey S. Kostyliov:
  o befs: LBD support
  o befs: microoptimisation, use befs_bread() instead of
    befs_bread_iaddr()
  o befs: binary search microoptimisation
  o befs: typo fix
  o befs: debugging code cleanup
  o befs: maintainer update
  o BeFS MAINTAINERS update

Shai Fultheim:
  o Multiple (ICH3) IDE-controllers in a system

Srivatsa Vaddagiri:
  o Move migrate_all_tasks to CPU_DEAD handling
  o sched_getaffinity vs cpu hotplug race fix
  o migration_thread() race fix

Stefan Eletzhofer:
  o I2C: add I2C epson 8564 RTC chip driver
  o USB Gadget: fix pxa define in gadget_chips.h
  o USB Gadget: fix g_serial debug module parm

Stephen D. Smalley:
  o selinux: reopen descriptors closed on exec to /dev/null
  o SELinux: fix error handling in selinuxfs

Stephen Hemminger:
  o minor RCU optimization
  o [BRIDGE]: Allow multiple interfaces with same address (necessary
    for VLAN's)
  o [BRIDGE]: Handle delete of multiple devices with same address
  o [BRIDGE]: Cleanup of bridge allocation
  o [BRIDGE]: Relax locking on add/delete
  o [BRIDGE]: Ioctl cleanup and consolidation
  o [BRIDGE]: Fix deadlock on device removal
  o [BRIDGE]: Read forwarding table chunk at a time
  o [BRIDGE]: Expose timer_residue function for use by sysfs
  o [BRIDGE]: Add sysfs support
  o [BRIDGE]: New ioctl interface for 32/64 compatability
  o [BRIDGE]: Compat hooks for new-ioctl interface
  o [BRIDGE]: Forwarding table sanity checks

Stephen Leonard:
  o trivial: fix counter in build_zonelists()

Stephen Rothwell:
  o ppc64 iSeries: allow read only virtual disks
  o PPC64: iSeries virtual ethernet transmit errors

Steve French:
  o Update cifs change log
  o Add missing cifs protocol data unit definitions
  o Add smb copy function
  o fix truncated directory listings on large directories to Samba
    (when Unicode and Unix extensions enabled)
  o update readme for mode,uid,gid description
  o Update readme with new information on symlinks to Samba
  o Fix oops when smb buffer can not be allocated
  o Add missing mount parameters
  o do not try to grab the i_sem ever during revalidate path since the
    rename code can grab it before we get here
  o switch to mempools for cifs request buf and mid allocation to avoid
    deadlocks in out of memory conditions
  o free mempool in correct order
  o do not recurse into the filesystem allocating sk buffs

Stéphane Eranian:
  o ia64: perfmon update
  o ia64: make perfmon treat Ski simulator like real Itanium chip
  o ia64: perfmon dv serialization patch
  o ia64: switch /proc/perfmon to seq_file avoid buffer overflows
  o ia64: fix 1-CPU PMC/PMD dump for /proc/perfmon when PFM_DEBUG is on

Suresh B. Siddha:
  o sched: reduce node balancing interval

Theodore Y. T'so:
  o Improve laptop mode's block_dump output

Thorsten Kranzkowski:
  o CLOCK_TICK_RATE: introduce asm-*/8253pit.h, #define PIT_TICK_RATE
    constant
  o CLOCK_TICK_RATE: use PIT_TICK_RATE in *spkr.c
  o CLOCK_TICK_RATE: use CLOCK_TICK_RATE

Todd E. Johnson:
  o USB: mtouchusb update for 2.6.6-rc2
  o USB: update for mtouchusb

Tom Rini:
  o ppc32: update Motorola LoPEC and Sandpoint defconfigs

Tommi Virtanen:
  o trivial: fix /proc documentation lies about file-nr

Tony Cureington:
  o [TG3]: Add eeprom dump support

Tony Lindgren:
  o [ARM PATCH] 1853/1: Update OMAP low level debug functions
  o [ARM PATCH] 1854/1: Remove old board specific OMAP files
  o USB: Merge support for Keyspan UPR-112 USB serial adapter from 2.4
    to 2.6
  o [CPUFREQ] Make powernow-k8 work right when ACPI is built as a
    module
  o [ARM PATCH] 1884/1: OMAP update 1/2: arch files
  o [ARM PATCH] 1885/1: OMAP update 2/2: include files
  o [ARM PATCH] 1887/1: Update OMAP low level debug functions again

Trond Myklebust:
  o Fix NFS long symlinks checks
  o RPC: Ensure that if we reconnect, we delay by at least 15 seconds
    in order to avoid flooding of servers.
  o NFS_O_DIRECT: there's a code path in nfs_direct_write_seg where
    NFS_I(inode)->data_updates can get out of sync with reality, which
    will lead to a BUG() in nfs_clear_inode later on.
  o NFS O_DIRECT: Change the NFS O_DIRECT path so that it no longer
    calls the generic VFS read and write routines.
  o NFSv4: Fix a bug in the open reboot-recovery code
  o Following a suggestion by Jamie Lokier
  o NFS: Patch by Steve Dickson to improve error reporting when
    mounting an NFS filesystem.
  o RPCSEC_GSS: this adds some new trace messages and makes existing
    ones consistent with other trace messages in the RPC client.
  o RPCSEC_GSS: Make a couple functions in the krb5 code more generally
    useful. This will help prepare for the spkm3 and lipkey mechanisms.
  o RPCSEC_GSS: Fix module reference counting
  o RPCSEC_GSS: Move EXPORT_SYMBOL's to place where functions are
    defined.
  o RPCSEC_GSS: Split out integrity code in wrap and unwrap procedures;
    otherwise they're going to be ridiculously long after we add
    privacy support.
  o RPCSEC_GSS: The expiration time passed down in the gss context is
    (duh!) in seconds, not jiffies!
  o nfs_writepage_sync stack reduction
  o From: Arjan van de Ven <arjanv@redhat.com> and akpm

Uwe Bugla:
  o ac97_plugin_ad1980 porting fix

Venkatesh Pallipadi:
  o sched: cpu_sibling_map to cpu_mask

Vernon A. Fort:
  o mxser.c kernel-2.6.5

Vesselin Kostadiov:
  o lance.c: fix for card with signature 0x52 0x49

Warren Togami:
  o i2o_proc module owner fix

William Lee Irwin III:
  o MSEC_TO_JIFFIES consolidation
  o filtered wakeups
  o filtered wakeups: wakeup enhancements
  o filtered wakeups: apply to pagecache functions
  o filtered wakeups: apply to buffer_head functions

Yoshinori Sato:
  o H8/300: bitops.h add find_next_bit
  o H8/300: ldscripts fix
  o H8/300: pic support
  o H/8300 pic support fix
  o H8/300: preempt support
  o H8/300: SCI driver fix
  o H8/300: ne driver
  o H8/300: Kconfig
  o H8/300: delete headers
  o H8/300: more cleanup
  o H8/300 IDE support update
  o H8/300 mtd setup fix
  o H8/300 new ide driver support
  o H8/300 module support update

Yves Rutschle:
  o [ARM] Fix broken IXP4xx GPIO0 IRQ handling

Zhenmin Li:
  o [SPARC]: Fix prom_prom_taken[].theres_more setting

Zwane Mwaikambo:
  o throttle P4 thermal warnings
  o USB: fix usb-serial serial_open oops

