Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVALFT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVALFT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVALFT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:19:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:59285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263093AbVALFJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:09:26 -0500
Date: Tue, 11 Jan 2005 21:09:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.11-rc1
Message-ID: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out 
there.

Lots of small cleanups, although that inevitable qlogic firmware update 
makes pretty much _everything_ look small in comparison. 

SCSI, USB, IDE, x86-64, FRV, PPC64, ARM, input layer, ALSA, network
drivers, pcmcia, knfsd, ACPI, sparse cleanups... You name it. Lots of
(mostly) small updates all over the landscape.

What gets hidden in the noise of all the updates is things like the
conversion to 4-level page tables by Andi Kleen and Nick Piggin. That
makes us able to use the full virtual memory space on 64-bit
architectures. The patches may not be very large, and in fact it was 
interesting to see just how smoothly it seems to integrate.

		Linus

----

Summary of changes from v2.6.10 to v2.6.11-rc1
============================================

Adrian Bunk:
  o net/wan/n2.c: remove an unused function
  o bonding: remove an unused function
  o net/3c505.c: remove unused functions
  o net/skfp/smt.c: remove an unused function
  o kill scsi_syms.c
  o SCSI aic7xxx_old.c: make a function static
  o remove bouncing email address of Deanna Bonds
  o MTD: Use select in Kconfig where appropriate
  o [CRYPTO]: Make some code static
  o i386 mca.c: small cleanups
  o select HOTPLUG
  o PCI: arch/i386/pci/: make some code static
  o PCI Hotplug: drivers/pci/hotplug/ : simply use MODULE
  o SCSI ibmmca.c: make a struct static
  o SCSI mca_53c9x.c: make 2 functions static
  o SCSI NCR53C9x.c: some cleanups
  o drivers/char/hw_random.c: make a variable static
  o [SUNRPC]: Remove unused file
    net/sunrpc/auth_gss/gss_pseudoflavors.c
  o [SUNRPC]: Remove unused file net/sunrpc/svcauth_des.c
  o [SUNRPC]: Remove unused file net/sunrpc/auth_gss/sunrpcgss_syms.c
  o [APPLETALK]: Make some code static
  o [AX25]: Staticize functions, and remove unused global function
  o [NET]: No need to export sock_readv_writev
  o [SUNRPC]: Staticize, kill unused functions, and remove unneeded
    exports
  o [AF_UNIX]: Mark needlessly global code static
  o [X25]: Staticize, and remove unused global functions
  o [XFRM]: Staticize, and remove unused global functions
  o [NET]: Mark eth_header_parse static
  o [AF_NET]: Mark pfkey_table static
  o [NETLINK]: Staticize and remove unused functions
  o [AF_PACKET]: Make needlessly global code static
  o [IPVS]: Make needlessly global code static
  o [IPX]: Make needlessly global code static
  o [IPV4]: Staticize and remove unneeded exports
  o [IRDA]: Staticize and remove unnecessary exports
  o [LLC]: Staticize and remove unnecessary functions and exports
  o [NETROM]: Make needlessly global code static
  o [ROSE]: Staticize and remove unused global functions
  o [RXRPC]: Staticize and remove unused globals and exports
  o [PKT_SCHED]: Staticize and other cleanups
  o [IPVS]: Remove subscribers-only mailing list from MAINTAINERS
  o kill blk.h
  o compile with -ffreestanding
  o remove ip2 programs
  o fix MTD_BLOCK2MTD dependency
  o OSS via82cxxx_audio.c: remove unused CONFIG_SOUND_VIA82CXXX_PROCFS
    code
  o small drivers/char/rio/ cleanups
  o small char/generic_serial.c cleanup
  o DEBUG_BUGVERBOSE for i386
  o telephony/ixj.c cleanup
  o char/cyclades.c: remove unused code
  o small ftape cleanups
  o reiser3 cleanups
  o cdrom.c: make several functions static (fwd)
  o fs/coda/psdev.c shouldn't include lp.h
  o lockd: fix two struct definitions
  o small MCA cleanups
  o small drivers/media/radio/ cleanups
  o DRM: remove unused functions
  o floppy.c: remove an unused function
  o media/video/ir-kbd-i2c.c: remove an unused function
  o NFS: remove an unused function
  o watchdog/machzwd.c: remove unused functions
  o video drivers: remove unused functions
  o ISDN b1pcmcia.c: remove an unused variable
  o binfmt_script.c: make struct script_format static
  o bio.c: make bio_destructor static
  o devpts/inode.c: make one struct static
  o small proc_fs cleanups
  o mark QNX4FS_RW as BROKEN
  o OSS: remove unused functions
  o DVB av7110_hw.c: remove unused functions
  o sched.c: remove an unused macro
  o scsi/ahci.c: remove an unused function
  o scsi/aic7xxx/aic79xx_osm.c: remove an unused function
  o sched.c: remove an unused function
  o prism54: small prismcompat cleanup
  o some parport_pc.c cleanups
  o cris: remove kernel 2.0 #ifdef's
  o AFS: afs_voltypes isn't always required
  o befs: #if 0 two unused global functions
  o remove unused include/asm-m68k/adb_mouse.h
  o scsi/aic7xxx/: remove two useless variables
  o remove IN_STRING_C
  o bttv-driver.c: make some variables static
  o init/initramfs.c: make unpack_to_rootfs static
  o OSS: misc cleanups
  o quota: make some code static
  o Remove InterMezzo MAINTAINERS entry
  o remove umsdos from tree
  o drivers/char/: misc cleanups
  o smbfs: make some functions static
  o efs: make a struct static (fwd)
  o ext3 cleanups
  o fs/ext2/xattr.c: make ext2_xattr_list static
  o fs/hugetlbfs/inode.c: make 4 functions static
  o remove outdated smbfs ChangeLog

Akinobu Mita:
  o seclvl: add missing dependency

Al Borchers:
  o USB: serial driver for TI USB 3410/5052 chips (3/3)
  o USB: serial driver for TI USB 3410/5052 chips (1/3)
  o USB: serial driver for TI USB 3410/5052 chips (2/3)

Alan Cox:
  o i810 more AC97 tunings
  o make microcode text less confusing
  o Paul Laufer CREDITS address update
  o quiet scsi ioctls warnings
  o Early ALI watchdog support
  o [ide] serverworks: add support for CSB6 RAID
  o [ide] it8172: incorrect return from it8172_init_one()
  o [ide] fix return codes in the generic PCI IDE driver
  o Resurrect ISICOM serial
  o First cut at setsid/tty locking
  o ULi support for 526X tulip variants
  o SDLA firmware upgrade should require CAP_SYS_RAWIO (not just
    CAP_NET_ADMIN)
  o IDE CD is very noisy

Alan Stern:
  o USB: dummy_hcd: update to match the new endpoint changes
  o USB: Create usb_hcd structures within usbcore [1/13]
  o USB: Create usb_hcd structures within usbcore [2/13]
  o USB: Create usb_hcd structures within usbcore [3/13]
  o USB: Create usb_hcd structures within usbcore [4/13]
  o USB: Create usb_hcd structures within usbcore [5/13]
  o USB: Create usb_hcd structures within usbcore [6/13]
  o USB: Hub driver: several bug fixes and simplifications [11/13]
  o USB: Hub driver cleanups [12/13]
  o USB: Another hub driver cleanup [13/13]

Albert Lee:
  o [libata] use PIO mode for request sense
  o [libata] PIO error handling improvement
  o [libata] verify ATAPI DMA for a given request is OK

Alex Tomas:
  o ext3: support for EA in inode

Alex Williamson:
  o collect page_states only from online cpus

Alexander Kern:
  o new PCI_ID for tulip

Alexander Nyberg:
  o Off by one in drivers/parport/probe.c

Alexander Viro:
  o iomem annotations in r8169
  o ac3200 iomem annotations and fixes
  o ne3210 iomem annotations
  o starfire iomem annotations
  o killed isa_... in 3c507
  o depca iomem annotations
  o 3c359 iomem annotations
  o e2100 iomem annotations and fixes
  o (25/32) lanstreamer iomem annotations
  o netdev_priv() in arlan
  o netdev_priv() in netwave_cs
  o arlan iomem annotations and cleanups
  o netwave iomem annotations
  o net/pcmcia iomem annotations
  o via-rhine iomem annotations, switch to io{read,write}
  o sundance iomem annotations, switch to io{read,write}
  o olympic_open() cleanup and fixes
  o skfp iomem annotations, switch to io{read,write}
  o lne390 iomem annotations and fixes
  o wavelan_cs iomem annotations
  o airo iomem annotations
  o mace iomem annotations - trivial part
  o affs headers cleanup
  o zatm fix
  o mxser annotations and compile fixes
  o cinergy __user annotations
  o x86_64 io.h annotations
  o ppc io.h annotations
  o hotplug NULL noise removal
  o more isa-ectomy
  o tda80xx.c portability fix
  o dib3000 portability fix
  o av7110_hw __user annotations fix
  o ppc __iomem annotations - ->cfg_data
  o ppc __iomem annotations - gg2
  o ppc __iomem annotations - openpic
  o ppc __iomem annotations - ->cfg_addr
  o i386 uaccess annotations
  o ppc uaccess annotations
  o pc300 portability fixes
  o diskonchip missing iomem annotations
  o Fix megaraid oops on unload
  o Fix up compiler inefficiencies
  o dmi_iterate() fix

Ananth N. Mavinakayanahalli:
  o ppc64: kprobes implementation
  o Kprobes: wrapper to define jprobe.entry

Andi Kleen:
  o split copy_page_range
  o convert Linux to 4-level page tables
  o convert i386 to generic nopud header
  o convert x86_64 to 4 level page tables
  o x86_64: Add a real pfn_valid
  o x86_64: Fix bugs in the AMD K8 CMP support code
  o x86_64: Reenable MGA DRI on x86-64
  o x86_64: Remove duplicated FAKE_STACK_FRAME macro
  o x86_64: Remove BIOS reboot code
  o x86_64: Add reboot=force
  o x86_64: Collected ioremap fixes
  o x86_64: Handle NX correctly in pageattr
  o x86_64: Split ACPI boot table parsing
  o x86_64: Add SRAT NUMA discovery to x86-64
  o x86_64: Update uptime after suspend
  o x86_64: Allow a kernel debugger to hide single steps in more cases
  o x86_64: Remove debug information for vsyscalls
  o x86_64: Rename HTVALID to CMP_LEGACY
  o x86_64: Scheduler support for AMD CMP
  o x86_64: Add a missing __iomem pointed out by Linus
  o x86_64: Add a missing newline in /proc/cpuinfo
  o x86_64: Always print segfaults for init
  o x86_64: Export phys_proc_id
  o x86_64: Allow to configure more CPUs and nodes
  o x86_64: Fix a warning in the CMP support code for !CONFIG_NUMA
  o x86_64: Fix some outdated assumptions that CPU numbers are equal
    numbers
  o x86_64: Remove unneeded ifdef in hardirq.h
  o x86_64: Add SLIT (inter node distance) information to sysfs
  o x86_64: Add x86_64 support for Jack Steiner's SLIT sysfs patch
  o x86_64: Eliminate some useless printks in ACPI numa.c
  o Sync in core time granuality with filesystems
  o Fix ADMtek Comet on x86-64
  o Fix gcc 4 compilation in ACPI
  o Fix gcc 4 compilation in DRM
  o Fix gcc 4 compilation in drivers/eisa
  o Fix gcc 4 compilation in bttv
  o x86_64: Work around another aperture BIOS bug on Opteron
  o x86_64: Hack to disable clustered mode on AMD systems
  o x86_64: Updates for x86-64 boot-options.txt
  o x86_64: Update defconfig
  o x86_64: Remove old-checksum.c
  o x86_64: Fix sparse warnings
  o x86_64: Fix some gcc 4 warnings in arch/x86_64
  o i386: Port missing cpuid bits from x86-64 to i386
  o i386: AMD dual core support for i386
  o i386: Count both multi cores and SMP siblings in   /proc/cpuinfo
    siblings
  o i386: Export phys_proc_id
  o x86_64: Move memset_io out of line to avoid warnings
  o x86_64: Fix ioremap attribute restoration on i386 and   x86-64
  o x86_64: Fix TLB reporting on K8
  o x86_64: change_page_attr logic fixes from Andrea
  o x86_64: Fix mptables printk
  o x86_64: Add new key syscalls
  o x86_64: Remove direct mem_map references
  o x86_64: Remove check that limited max number of IO-APIC to 8
  o x86_64: Prevent gcc from generating MMX code by mistake
  o x86_64: Don't sync APIC ARBs on P4s
  o x86_64: Cleanups preparing for memory hotplug
  o x86_64: Remove unused prototypes
  o x86_64: Fix a lot of broken white space in
    arch/x86_64/kernel/setup.c
  o x86_64: Fix signal FPU leak on i386 and x86-64
  o x86_64: Disable conforming bit on USER32_CS segment

Andrea Arcangeli:
  o mempolicy optimisation

Andreas Gruenbacher:
  o Ext[23]: apply umask to symlinks with ACLs configured out

Andrew Hendry:
  o [X25]: When receiving a call, check listening sockets for matching
    call user data
  o [X25]: Remove unused header files

Andrew Morton:
  o r8169 module_param build fix
  o iscsi_transport build fix
  o setup_pci.c build fix
  o sparc64 pmd_offset() fix
  o ia64 PTRS_PER_PGD build fix
  o fix inet6_sk for non IPV6 builds again
  o floppy build fix
  o vmscan: total_scanned fix
  o do_anonymous_page() use SetPageReferenced
  o swsusp-try_to_freeze-to-make-freezing-hooks-nicer fix
  o bk-kbuild-in_gate_area_no_task-warning-fix
  o suppress might_sleep() if oopsing
  o Reduce i_sem usage during file sync operations
  o get_blkdev_list() cleanup
  o msync(): set PF_SYNCWRITE
  o __GFP_ZERO pktcdvd fix
  o mmc build fix
  o debugfs-typo-fix
  o via-rhine warning fix
  o xircom_tulip_cb.c build fix
  o cs416x: use upcase in config
  o block2mtd: avoid touching truncate_count
  o readpage-vs-invalidate fix
  o invalidate_inode_pages2() mmap coherency fix
  o remove early_param test code
  o MODULE_PARM conversions
  o MODULE_PARM conversions
  o Fix ppc64 !HOTPLUG_CPU build
  o uninline __do_page_cache_readahead()
  o acpi_smp_processor_id() warning fix

Andrew Theurer:
  o sched: more agressive wake_idle()
  o sched: can_migrate exception for idle cpus
  o sched: newidle fix

Andrew Vasquez:
  o qla2xxx: Tx/Rx Sensitivity additions
  o qla2xxx: NVRAM updates
  o qla2xxx: NVRAM id-list updates
  o qla2xxx: Small fixes
  o qla2xxx: ISR fixes
  o qla2xxx: Code scrubbing
  o qla2xxx: Consolidate ISP63xx support
  o qla2xxx: 23xx/63xx firmware updates
  o qla2xxx: Update driver version
  o ipr: PCI-X capabilities setup fix

Andries E. Brouwer:
  o mm: overcommit updates
  o remove duplicated patch fragment
  o remove NR_SUPER define

Anton Blanchard:
  o ppc64: limit xmon dump length
  o ppc64: catch bad xmon read/write SPR commands
  o ppc64: Clarify rtasd printk
  o ppc64: fix some compiler warnings
  o ppc64: remove stale prom.h code
  o sched: reset cache_hot_time
  o update hugetlb documentation
  o ppc64: kprobes breaks BUG() handling
  o ppc64: Fix NUMA build
  o ppc64: enhance oops printing
  o ppc64: fix xmon longjmp handling
  o ppc64: make xmon print BUG() warnings
  o ppc64: xtime <-> gettimeofday can get out of sync
  o ppc64: PCI cleanup
  o ppc64: Remove flush_instruction_cache
  o ppc64: interrupt code cleanup
  o ppc64: Fix rtas_set_indicator(9005)
  o ppc64: reduce paca[] where possible

Antonino Daplas:
  o fbdev: Cleanup i2c code of rivafb
  o fbdev: Revive BIOS-less booting for Rage XL cards
  o fbdev: Revive global_mode_option
  o fbcon/fbdev: Add blanking notification
  o fbdev: Check return value of fb_add_videomode
  o fbdev: Do a symbol_put for each symbol_get in savagefb
  o fbdev: Add Viewsonic PF775a to broken display database
  o fbdev: Fix default timings in vga16fb
  o fbdev: Reduce stack usage of intelfb

Arjan van de Ven:
  o ray_cs export cleanup
  o drivers/acpi/ibm_acpi.o .init.text refers to .exit.text

Arnaldo Carvalho de Melo:
  o fix  platform_rename_gsi related ia32 build breakage
  o [XFRM]: Export xfrm_policy_delete()
  o [INET] move inet_sock into inet_opt and rename it to inet_sock
  o [TCP] merge tcp_sock with tcp_opt
  o Fix net/core/sock.o build failure

Art Haas:
  o kbuild: Trivial Makefile patch

Artem Bityuckiy:
  o JFFS2: Include vmalloc.h to fix compile warning
  o JFFS2: jffs2_get_inode_nodes(): Remove gratuitous memset on new
    nodes
  o MTD NAND flash simulator update

Arthur Othieno:
  o ppc32: Resurrect Documentation/powerpc/cpu_features.txt
  o arch/alpha/Kconfig: Kill stale reference to Documentation/smp.tex

Badari Pulavarty:
  o x86_64: numa_add_cpu() fix

Barry K. Nathan:
  o swsusp: device power management fix
  o swsusp: properly suspend and resume all devices

Bart De Schuymer:
  o [EBTABLES]: Add userspace logging via netlink socket

Bartlomiej Zolnierkiewicz:
  o [ide] add "ide=nodma" to documentation
  o [ide] ide-proc: kill destroy_proc_ide_interfaces()
  o [ide] fix cleanup_module() in ide.c
  o [ide] propagation of error code in PCI IDE setup
  o [ide] clean up error path in do_ide_setup_pci_device()
  o [ide] propagate the error status in
    ide_pci_enable/ide_setup_pci_controller
  o [ide] make host drivers aware of the changes made to
    ide_setup_pci_device{s}
  o [ide] remove pci_disable_device() calls from setup-pci.c and
    sgiioc4.c
  o [ide] remove CRD-8480C from the DMA blacklist
  o [ide] disable debug in IDE ppc/pmac driver
  o [ide] kill write-only ide_driver_t->sense
  o [ide] add ide_dump_opcode()
  o [ide] cleanup ide_dump_status()
  o [ide] cleanup ide_error()
  o [ide] rework ide_driver_t->error
  o [ide] ide_driver_t->abort() cleanup
  o [ide] kill current_capacity()

Ben Dooks:
  o [ARM PATCH] 2343/1: S3C2410 / S3C2440 MAINTAINERS entries
  o [ARM PATCH] 2344/1: S3C2440 - fix mapping of watchdog for reboot
  o [ARM PATCH] 2345/1: S3C24XX - serial init depending on cpu detected
  o [ARM PATCH] 2372/1: S3C2410 - remove s3c2410_clock_tick_rate
  o [ARM PATCH] 2373/1: S3C2410 -  fix possible loop in irq macro
  o [ARM PATCH] 2374/1: S3C2410 - remove unused code from entry-macro.S

Bernard Blackham:
  o sched: fix scheduling latencies in mttr.c

Bill Rugolsky:
  o NFS client O_DIRECT error case fix

Bjorn Helgaas:
  o Input: Add ACPI-based i8042 keyboard and aux controller
    enumeration; can be disabled by passing i8042.noacpi as a boot
    parameter.
  o ia64: remove HCDP support for early printk
  o use modern format for PCI->APIC IRQ transform printks

Bodo Stroesser:
  o uml: unregister signal handlers at reboot
  o uml: small vsyscall fixes
  o uml: export end_iomem
  o uml: Fix setting of TIF_SIGPENDING
  o uml: Allow vsyscall code to build on 2.4
  o uml: SYSEMU fixes
  o uml: correctly restore extramask in sigreturn
  o uml: fix update_process_times call
  o uml: detect SYSEMU_SINGLESTEP
  o UML: Don't use __NR_waitpid on arches which don't have it
  o UML: Use va_copy

Brent Casavant:
  o alloc_large_system_hash: NUMA interleaving
  o filesystem hashes: NUMA interleaving
  o TCP hashes: NUMA interleaving

Brian King:
  o ipr: Allow Query Resource State adapter command to
  o ipr: new RAID error
  o ipr: Remove dead code
  o ipr: whitespace fixes
  o ipr: Bump driver version to 2.0.12

Carsten Otte:
  o s390: DCSS driver cleanup fix

Catalin Boie:
  o [PKT_SCHED]: Allow using nfmark as key in U32 classifier

Catalin Marinas:
  o [ARM PATCH] 2322/1: Enable ARM922T configuration option for
    Integrator

Chas Williams:
  o [ATM]: small atm cleanups (from Adrian Bunk <bunk@stusta.de>)

Chris Mason:
  o __getblk_slow can loop forever when pages are partially mapped

Chris Wedgwood:
  o sn2 trivial nodemask.h include fix

Chris Wright:
  o sysfs: Allocate sysfs_dirent structures from their own slab
  o track capabilities in default dummy security module code
  o fix up dummy security module code merge
  o binfmt_script.c: make em86_format static
  o remove duplicate rlim assignment in acct_stack_growth()
  o acct_stack_growth nitpicks

Christoph Hellwig:
  o unexport ei_tx_timeout
  o [NET]: Kill drivers/net/net_init.c
  o [NET]: Use local_softirq_pending instead of softirq_pending in
    netif_rx_ni
  o feed eata.c through Lindent
  o convert eata to pass pointers around
  o qla2xxx: Dead code removal
  o move irq_enter and irq_exit to common code
  o remove unused irq_cpustat fields
  o udf: simplify udf_iget, fix race
  o udf: fix reservation discarding
  o remove dead ext3_put_inode prototype
  o ppc64: export ppc64_caches for afs/ntfs
  o fix double iget in romfs_fill_super
  o Direct write vs truncate deadlock
  o cleanup virtual console <-> selection.c interface
  o warn about cli, sti & co uses even on UP
  o fix ->setattr ATTR_SIZE locking for nfsd

Christoph Lameter:
  o Make page allocator aware of requests for zeroed memory

Con Kolivas:
  o net: Netconsole poll support for 3c509
  o sched.c whitespace mangler
  o sched: alter_kthread_prio
  o sched: adjust_timeslice_granularity
  o sched: add_requeue_task
  o sched: requeue_granularity
  o sched: remove_interactive_credit

Corey Minyard:
  o PPC debug setcontext syscall implementation
  o Cleanups for the IPMI driver

Cornelia Huck:
  o s390: Common I/O layer

Coywolf Qi Hunt:
  o remove redundant sys_delete_module()

Daniele Venzano:
  o Add Altimata PHY to sis900 driver
  o convert sis900 to new style parameters

Dave Airlie:
  o drm: initial core move infrastructure change
  o drm: device minor fixups and /proc fixups
  o drm: core/personality split for 2.6 kernel
  o drm: drm_memory.c missing from build
  o drm: rename fn_tbl to driver as it is no longer a function table
  o drm: make pcigart functions inline
  o drm: fix warning for missing vunmap
  o drm: remove use of drm_agp use agp backend directly
  o drm: move the enable device before filling in device info
  o Make 1-bit fields be unsigned (no sign bit :)
  o drm: core changes broke i810/830
  o drm: mark ffb as broken because it actually is

Dave Boutcher:
  o ibmvscsi: replace schedule_timeout() with msleep()

Dave Hansen:
  o kill off highmem_start_page
  o make sure ioremap only tests valid addresses
  o remove pfn_to_pgdat() on x86
  o kill off highmem_start_page

Dave Jiang:
  o [ARM PATCH] 2352/1: Increase amount of physical memory addressable
    on IOP platforms
  o [ARM PATCH] 2355/1: cleanup of PCI defines for IOP33x platforms
  o [ARM PATCH] 2356/1: cleanup for compliance of machine ID and ATAG
    for IOP platforms
  o [ARM PATCH] 2361/1: clean up irq handling code for IOP33x platforms
  o [ARM PATCH] 2362/1: cleanup of PCI defines for IOP321 platforms
  o [ARM PATCH] 2363/1: IQ80332 platform port

Dave Jones:
  o [AGPGART] amd64-agp.c replace pci_find_device with pci_get_device
    As pci_find_device is going away soon I have converted this file to
    use pci_get_device instead. I have compile tested it.
  o [AGPGART] generic.c: replace pci_find_device with pci_get_device
  o [AGPGART] intel-agp.c: replace pci_find_device with pci_get_device
  o [AGPGART] intel-mch-agp.c: replace pci_find_device with
    pci_get_device
  o [AGPGART] isoch.c: replace pci_find_device with pci_get_device
  o [AGPGART] Simplify global_cache_flush
  o [AGPGART] Add support for ALI M1681/M1683
  o [AGPGART] Fix TLB flushing issues with change_page_attr()
  o [AGPGART] Fix up PCI posting bugs
  o [AGPGART] More PCI Posting bugs
  o [AGPGART] Another missing PCI Posting bugfix
  o [AGPGART] Remove unnecessary parenthesis on return statements
  o [AGPGART] Add missing cache flush to the generic remove routine
  o [AGPGART] Announce Intel 460GX when found
  o [AGPGART] Fix masking (causes crash on 460GX)
  o [AGPGART] Fix up two stupid bugs in the posting fixes
  o driver core: Fix up vesafb failure probing
  o [AGPGART] ULI M1689 support
  o [AGPGART] Fix agp=off

Dave Kleikamp:
  o JFS: fix race in jfs_commit_inode
  o JFS: add security and trusted xattrs
  o JFS: speed up nointegrity mount
  o JFS: flush new iag from bd_inode's mapping

David Brownell:
  o USB: update drivers/usb/README
  o USB: usb_dev->ep[] not usb_dev->epmaxpacket (1/15)
  o USB: usbcore changes for usb_dev->ep[](2/15)
  o USB: usbfs changes for usb_dev->ep[] (3/15)
  o USB: ALSA and usb_dev->ep[] (4/15)
  o USB: auerswald and usb_dev->ep[] (5/15)
  o USB: CRIS HCD and usb_dev->epmaxpacket (6/15)
  o USB: EHCI HCD and usb_dev->epmaxpacket (7/15)
  o USB: usbtest and usb_dev->epmaxpacket (8/15)
  o USB: HCD/usb_bus interface cleanup (9/15)
  o USB: remove some now-unused HCD infrastructure (10/15)
  o USB: maintain usb_host_endpoint.urb_list (11/15)
  o USB: EHCI and HCD API updates (12/15)
  o USB: OHCI and HCD API changes (13/15)
  o USB: UHCI and HCD API change (14/15)
  o USB: better messages for "no-IRQ" cases (15/15)
  o USB: HCDs and per-device state (16/15)
  o USB: EHCI "park" mode disabled
  o USB: EHCI periodic schedule tree
  o USB: gadget kconfig doc updates
  o USB: Hub driver: improve error checking and retries [10/13]
  o USB: ohci build tweaks
  o USB: fix Scheduling while atomic warning when resuming
  o I2C: minor isp1301_omap tweaks
  o USB: fix serial gadget oops during enumeration
  o Driver Core: handle bridged platform bus segments
  o USB: minor usb doc/comment fixes
  o USB: definitions for USB2 debug device, debug port
  o USB: usb makefile tweaks
  o USB: ohci diagnostic tweak
  o USB: ehci "hc died" on startup (chip bug workaround)
  o fbdev: rivafb should recognize NF2/IGP

David Dillow:
  o net/typhoon.c: use previously-unused function

David Gibson:
  o ppc64: tweaks to ppc64 cpu sysfs information
  o ppc64: add performance monitor register information to processor.h
  o ppc64: hugepage bugfix
  o ppc64: rename perf counter register #defines

David Howells:
  o PCI: Make pci_set_power_state() check register version
  o Termio userspace access error handling
  o IDE_ARCH_OBSOLETE_INIT fix
  o out-of-line implementation of find_next_bit()
  o GP-REL data support
  o frv: add initdata variable spec in a header file
  o VM routine fixes
  o FRV: Fujitsu FR-V CPU arch maintainer record
  o FRV: Fujitsu FR-V arch documentation
  o FRV: Fujitsu FR-V CPU arch implementation part 1
  o FRV: Fujitsu FR-V CPU arch implementation part 2
  o FRV: Fujitsu FR-V CPU arch implementation part 3
  o FRV: Fujitsu FR-V CPU arch implementation part 4
  o FRV: Fujitsu FR-V CPU arch implementation part 5
  o FRV: Fujitsu FR-V CPU arch implementation part 6
  o FRV: Fujitsu FR-V CPU arch implementation part 7
  o FRV: Fujitsu FR-V CPU arch implementation part 8
  o FRV: Fujitsu FR-V CPU arch implementation part 9
  o Put memory in DMA zone not Normal zone in FRV arch
  o FRV: First batch of Fujitsu FR-V arch include files
  o frv: emove obsolete hardirq stuff from includes
  o frv: PCI DMA fixes
  o frv: Fix PCI config space write
  o FRV: More Fujitsu FR-V arch include files
  o FRV: Yet more Fujitsu FR-V arch include files
  o FRV: Remaining Fujitsu FR-V arch include files
  o FRV: Make calibrate_delay() optional
  o FRV: procfs changes for nommu changes
  o FRV: change setup_arg_pages() to take stack pointer
  o Fix usage of setup_arg_pages() in IA64, MIPS, S390 and Sparc64
  o FRV: Add FDPIC ELF binary format driver
  o Fix some ELF-FDPIC binfmt problems
  o Further nommu changes
  o Further nommu /proc changes
  o frv: nommu changes
  o Make more syscalls available for the FR-V arch
  o FRV: debugging fixes
  o frv: Minix & ext2 bitops fixes
  o frv: perfctr_info syscall
  o frv: update the trap tables comment
  o frv: accidental TLB entry write-protect fix
  o FRV: pagetable handling fixes
  o FRV: FR55x CPU support fixes
  o FRV: Change PML4 -> PUD
  o Implement nommu find_vma()
  o Fix nommu MAP_SHARED handling
  o Permit nommu MAP_SHARED of memory backed files
  o Cross-reference nommu VMAs with mappings
  o FRV: vperfctr syscalls don't exist in -bk8
  o FRV: remove excess argument passed to expand_stack()
  o FRV: provide stub asm/a.out.h
  o Make pud_alloc() and pmd_alloc() non-existant on !MMU
  o FRV: Update banner comments at the top of frv arch files

David Marlin:
  o JFFS2: Fix freeing of block table on mount failure

David McCullough:
  o FRV: Better mmap support in uClinux

David Mosberger:
  o [IA64] contig.c: fix bug in DMA-zone initialization
  o [IA64] Fix swiotlb some more

David S. Miller:
  o eepro100.c iomap conversion
  o [IPV4]: FIB cleanup, rtmsg_fib()
  o [IRDA]: More staticization becomes possible in ircomm_ttp.c
  o [SPARC64]: Fix typo in previous change, s/IS_SOCK/S_ISSOCK/
  o [LLC]: llc_sap_list_lock really does need to be exported
  o [SPARC64]: Include infiniband driver config and update defconfig
  o [SPARC64]: We really do need to mask the start/end args to
    flush_tlb_pgtables()
  o [TG3]: Return 0 when PHY read times out, not all-ones
  o [TG3]: Fix signedness issues in PHY read/write loops
  o [TG3]: Update driver version and reldate

David Vrabel:
  o MTD: Fix chip ident definition for AMD 29F002T devices
  o MTD: AMD/Fujitsu flash driver cleanup
  o [ARM PATCH] 2323/1: Expand IXP4XX_WATCHDOG config help text

David Woodhouse:
  o JFFS2: Add support for bizarre NOR flash with ECC
  o MTD: Provide XIP support for Intel flash chips
  o MTD: NAND driver updates
  o JFFS2: Move very noisy debugging messages from level 1 to level 2
  o JFFS2: Add notes on inocache_lock spinlock to README.Locking
  o Email address update
  o JFFS2: Remove definition of obsolete struct jffs2_scan_info
  o MTD: Fix JEDEC probe of chips which don't require unlock sequence
  o JFFS2: Remove obsolete structure definitions and update comments
  o JFFS2: Discard dirents which point to non-existent inodes
  o JFFS2: Fix memory leak if jffs2_scan_medium() fails
  o JFFS2: Fix race on read access to NAND write-buffer
  o MTD NOR chip drivers: use msleep()
  o MTD: Use msleep() in cfi_udelay() helper function
  o MTD: Fix RedBoot FIS table detection
  o MTD: mtdpart_setup() is used from platform code. Remove 'static'
  o MTD: Make phram work again
  o MTD: Fix oops on erase in NFTL/INFTL (again)
  o MTD: Fix timing setup for NAND flash on Samsung S3C2410
  o MTD: Support NOR and NAND flash on Sharp SL Series PDAs
  o MTD: NAND flash simulator
  o JFFS2: Fix oops in read_inode
  o JFFS2: Various fixes for recent RAM use reduction
  o JFFS2: Initialise bad_count for each eraseblock correctly
  o JFFS2: Split eraseblock refiling into separate function
  o JFFS2: Allow NAND driver to disable virtual eraseblocks
  o rslib: Spelling fixes
  o NULL noise removal, missing __iomem in a couple of declarations,
    removal of bogus cast to void * in iounmap() calls.
  o JFFS2 locking fix: Don't hold references to obsolete nodes without
    lock
  o [MTD] Bug in 2.6.10 mtd driver for physmem mapped flash chips
  o MTD: include moduleparam.h in DiskOnChip driver
  o MTD: Fix config option name in Makefile for IBM 750FX/750GX boards
  o [MTD] add missing dependencies on MTD_PARTITIONS
  o MTD: Cosmetic ident catchup
  o MTD: Remove long-obsolete DiskOnChip 1000 driver

Dean Nelson:
  o export sched_setscheduler() for kernel module use

Deepak Saxena:
  o [ARM PATCH] 2264/1: Move platform-specific code out of entry-armv.S
  o [ARM PATCH] 2325/1: Cleanup IXP2000 reset handling
  o [ARM PATCH] 2326/1: Fix IXP2000 timer implementation
  o [ARM PATCH] 2339/1: Don't mask IRQ_STATUS with
    IXP2000_VALID_IRQ_MASK
  o [ARM PATCH] 2307/1: Add IXP46x and IXDPG465 implementation
  o [ARM PATCH] 2338/1: IXP465 and IXDPG465 header file updates
  o [ARM PATCH] 2346/1: Update IXP4xx documentation
  o [ARM PATCH] 2348/1: Fix IXDP2800 PCI irq mapping
  o Update IOP3xx I2C bus driver
  o [ARM PATCH] 2358/1: Add IXP46x I2C platform device

Dmitry Torokhov:
  o Input: pull common code from psmouse and atkbd into libps2 module
  o Input: add serio_[un]pin_driver() functions so attribute handlers
    can safely access driver bound to a serio port.
  o Input: atkbd - export extra, scroll, set, softrepeat and softraw as
    individual keyboard attributes (sysfs) and allow them to be
    set/changed independently for each keyboard:
  o Input: clean up ALPS DualPoint logic
  o Input: add a new signature for ALPS DualPoint found in Dell
    Inspiron 8500
  o Input: psmouse - add set_rate and set_resolution handlers to make
    adding new protocols easier and remove special knowledge from
    psmouse-base.c
  o Input: synaptics - not only switch to 4-byte client protocol but
    also revert to 3-byte mode if client selected lower protocol.
  o Input: psmouse - reset mouse before doing intellimouse/explorer
    probes in case it got confused by earlier probes; switch to
    streaming mode before setting scale and resolution,
  o Input: psmouse - export rate, resolution, resetafter and
    smartscroll (Logitech only) as individual mouse attributes (sysfs)
    and allow them to be set/changed independently for each mouse:
  o Input: psmouse - drop PS2TPP protocol (it is handled exactly like
    PS2PP) to free spot for THINKPS protocol and keep old protocol
    numbers for binary compatibility with Synaptics/ALPS touchpad
    driver for X.
  o Input: psmouse - make logips2pp fully decode its protocol packets
    and not rely on generic handler to finish job.
  o Input: psmouse - explicitely specify packet size instead of relying
  o Input: couple of whitespace fixes
  o Input: evdev, joydev, mousedev, tsdev - remove class device and
    devfs entry when hardware driver disconnects instead of waiting for
    the last user to drop off. This way hardware drivers can be
    unloaded at any time.
  o Input: when creating input devices for hardware attached to a serio
    port properly set input_device->dev pointer so when corresponding
    class device is created it will show proper links to parent device
    and driver in sysfs hierarchy.
  o Input: i8042 - allow turning debugging on and off "on-fly" so
    people do not have to recompile their kernels to provide debug
    info.
  o Input: i8042 - get rid of old style power management handler since
    APM calls both pm_send and device_suspend.
  o Input: i8042 - get rid of reboot notifier as suspend method should
    do the job.
  o Input: get rid of pm_dev in input core as it is deprecated and
    nothing uses it anyway.
  o Input: gscps2 - remove unused statically allocated
    gscps2_serio_port variable as the port is allocated dynamically.
  o Input: parkbd - switch to using module_param. Parameter names are
    parkbd.port and parkbd.mode
  o Input: i8042 - fix "debug" parameter sysfs permissions

Domen Puncer:
  o it87: /proc/ioports fix
  o JFS: delete unused file
  o MTD: Remove gratuitous (void *) casts
  o arm26: Remove unreferenced file
  o hotplug/acpiphp_ibm: module_param fix
  o fs/proc/base.c: array size
  o fs/proc/proc_tty.c: avoid array
  o remove unused drivers/char/rio/cdproto.h
  o remove unused drivers/char/rsf16fmi.h
  o ppc64: semicolon in rtasd.c

Dominik Brodowski:
  o cpufreq 2.4 interface removal schedule
  o pcmcia: new ds - cs interface
  o pcmcia: call device drivers from ds, not from cs
  o pcmcia: unify bind_mtd and pcmcia_bind_mtd
  o pcmcia: unfiy bind_device and pcmcia_bind_device
  o pcmcia: device model integration can only be submitted under GPL
  o pcmcia: add pcmcia_device(s)
  o pcmcia: remove socket_bind_t, use pcmcia_devices instead
  o pcmcia: remove internal module use count, use module_refcount
    instead
  o pcmcia: set driver's .owner field
  o pcmcia: move pcmcia_(un,)register_client to ds
  o pcmcia: device model integration can only be submitted under GPL,
    part 2
  o pcmcia: use kref instead of native atomic counter
  o pcmcia: add pcmcia_(put,get)_socket
  o pcmcia: grab a reference to the cs-socket in ds
  o pcmcia: get a reference to ds-socket for each pcmcia_device
  o pcmcia: add a pointer to client in struct pcmcia_device
  o pcmcia: use pcmcia_device in send_event
  o pcmcia: use pcmcia_device to mark clients as stale
  o pcmcia: code moving in ds
  o pcmcia: use pcmcia_device in register_client
  o pcmcia: direct-ordered unbind of devices
  o pcmcia: BUG on dev_list != NULL
  o pcmcia: BUG() if clients are kept too long
  o pcmcia: move struct client_t inside struct pcmcia_device
  o pcmcia: use driver_find in ds
  o pcmcia: SET_NETDEV for network devices
  o pcmcia: SET_NETDEV for wireless network devices
  o pcmcia: reduce stack usage in ds_ioctl (Randy Dunlap)
  o pcmcia: rename PCMCIA devices
  o pcmcia: remove obsolete code
  o pcmcia: remove pending_events
  o pcmcia: remove client_attributes
  o pcmcia: remove unneeded parameter from rsrc_mgr
  o pcmcia: remove dev_info from client
  o pcmcia: remove mtd and bulkmem (replaced by pcmciamtd)
  o pcmcia: per-socket resource database
  o pcmcia: validate_mem only for non-statically mapped sockets
  o pcmcia: adjust_io_region only for non-statically mapped sockets
  o pcmcia: find_io_region only for non-statically mapped sockets
  o pcmcia: find_mem_region only for non-statically mapped sockets
  o pcmcia: adjust_ and release_resources only for non-statically
    mapped sockets
  o pcmcia: move resource handling code only for non-statically mapped
    sockets to other file
  o pcmcia: make rsrc_nonstatic an independend module
  o pcmcia: allocate resource database per-socket
  o pcmcia: remove typedef
  o pcmcia: grab lock in resource_release
  o pcmcia: yenta override to re-allocate resources

Douglas Gilbert:
  o scsi_debug v 1.75
  o SCSI: updates to constants.c
  o SCSI: descriptor sense format, mid-level

Duncan Sands:
  o usb atm: macro consolidation, fixes debugging problem

Ed L. Cashin:
  o add ATA over Ethernet driver
  o rename ETH_P_AOE

Edwin Olson:
  o usb-serial: add tty_hangup on disconnect
  o ftdi_sio: Add sysfs attributes for event character and latency

Eric Moore:
  o LSI Logic - SAS and FC PCI ID's

Esben Nielsen:
  o [ARCNET]: Fixes

Evgeniy Polyakov:
  o w1: Documentation bits for generic w1 behaviour

Felix Kuehling:
  o drm: make reclaim_buffers take dev argument

Franz Pletz:
  o loop device resursion avoidance

François Romieu:
  o r8169: add ethtool_ops.{get_regs_len/get_regs}
  o r8169: per device receive buffer size
  o r8169: code cleanup
  o r8169: enable MWI
  o r8169: bump version number
  o r8169: sync the names of a few bits with the 8139cp driver
  o r8169: comment a gcc 2.95.x bug
  o r8169: Tx checksum offload
  o r8169: advertise DMA to high memory
  o r8169: Rx checksum support
  o r8169: vlan support
  o r8169: miscalculation of available Tx descriptors
  o r8169: hint for Tx flow control
  o r8169: TSO support
  o r8169: Mac identifier extracted from Realtek's driver v2.2
  o r8169: default on disabling PCIDAC
  o r8169: Tx timeout rework
  o r8169: wrong advertisement of VLAN features
  o r8169: automatic pci dac step down
  o r8169: rtl8169_close() races
  o r8169: cleanup
  o r8169: always clean Tx desc
  o r8169: unneeded synchronize_irq()
  o r8169: netconsole support
  o r8169: missing netif_poll_enable and irq ack
  o r8169: C 101
  o r8169: Large Send enablement
  o r8169: reduce max MTU for large frames
  o r8169: oversized driver field for ethtool
  o 3c59x: missing pci_disable_device

Ganesh Venkatesan:
  o e100: Replace locally implemented delay routines
  o e100: Sort Device IDs
  o e100: Update driver version number
  o e1000: ITR does not default correctly on 2.6.x kernels
  o e1000: Fix kernel panic when the interface is brought down while
    the NAPI enabled driver is under stress
  o e1000: Fix ethtool diagnostics -- specifically for blade server
    implementations
  o e1000: Enabling NETIF_F_SG without checksum offload is illegal
  o e1000: Avoid filling tx_ring completely - shemminger@osdl.org
  o e1000: remove a redundant assignment to a local nr_frags in
    e1000_xmit_frame
  o e1000:  Replace schedule_timeout() with
    msleep()/msleep_interruptible() nacc@us.ibm.com
  o e1000: Fix tx resource cleanup logic
  o e1000: {set, get}_wol is now symmetric for 82545EM adapters
  o e1000: Kernel API change for Module_param_array_named
  o e1000:  Added workaround to prevent inadvertent gigabit waveform to
    be sent out on the wire due to init-time operations on the IGP phy.
  o e1000: Applied eeprom fix where it was possible to read/write
  o e1000: Applied smart speed fix where the code was forcing smart
    speed on all the time.  Now it will honor the setting defined in
    the eeprom.
  o e1000: Driver version number, white spaces, comments, device id &
    other changes
  o e1000: Documentation/networking/e1000.txt update
  o e100: Documentation/networking/e100.txt update

Geert Uytterhoeven:
  o M68k: Update defconfigs for 2.6.10
  o MMC_WBSD depends on ISA
  o M68k: Remove nowhere referenced files
  o Update Geert's address in CREDITS

George G. Davis:
  o [ARM PATCH] 2324/1: Convert ARM proc files to use domain and
    pgtable manifest constants
  o [ARM PATCH] 2327/1: Thumb ld/st alignment fault fixups

George T. Joseph:
  o [ARM PATCH] 2334/1: Corrects ixp4xx USB base addr and adds
    QMGRr/EthA/EthB in ixp4xx-regs.h

Gerd Knorr:
  o uml: terminal cleanup
  o uml: symbol export
  o uml: fix umldir init order
  o uml: raise tty limit
  o uml: sysfs support for uml network driver
  o uml: sysfs support for the uml block devices
  o fbdev: sysfs fix
  o bttv-i2c.c: make two functions static
  o bttv-risc.c: make some functions static
  o zoran_driver.c: make zoran_num_formats static
  o media/video/msp3400.c: remove unused struct d1
  o zoran_device.c: make zr36057_init_vfe static
  o drivers/media/video: the easy cleanups

Greg Banks:
  o oprofile: add check_user_page_readable()
  o oprofile: arch-independent code for stack trace sampling
  o oprofile: backtrace operation does not initialized
  o oprofile: i386 support for stack trace sampling
  o oprofile: ia64 support for oprofile stack trace sampling
  o oprofile: update alpha for api changes
  o oprofile: update arm for api changes
  o oprofile: update ppc for api changes
  o oprofile: update parisc for api changes
  o oprofile: update s390 for api changes
  o oprofile: update sh for api changes
  o oprofile: update sparc64 for api changes
  o oprofile: fix ia64 callgraph bug with old gcc

Greg Kroah-Hartman:
  o misc: remove device.h #include from miscdevice.h
  o Documentation: fix some grammer in the stable_api_nonsense.txt file
  o misc: remove miscdevice.h from pci hotplug drivers as they do not
    need it
  o USB: fix sparse and compiler warnings in ti_usb_3410_5052.c
  o USB: delete the tiglusb driver as it's not needed
  o debugfs: add debugfs
  o USB: convert uhci-hcd driver to use debugfs
  o PCI: fix up function calls for CONFIG_PCI=N
  o AOE: fix up sparse warnings and get rid of a kmalloc in the aoe
    driver
  o USB: fix up some sparse warnings in the new garmin_gps driver
  o USB: change warning level in ftdi_sio driver of a debug message
  o USB: convert the idVendor, idProduct, bcdDevice and bcdUSB fields
    to __le16
  o USB: change wTotalLength field in struct usb_config_descriptor to
    be __le16
  o USB: change wMaxPacketSize field in struct usb_config_descriptor to
    be __le16
  o USB Gadget: fix up simple sparse warnings (NULL stuff) in
    dummy_hcd.c driver
  o USB: explicitly mark the endianness of some visor data fields
  o sysfs: export the /sys/kernel subsystem for people to use
  o debugfs: add /sys/kernel/debug mount point for people to mount
    debugfs on
  o PCI: fix typo on previous pci_set_power_state() patch for hte
    sis900 driver
  o PCI: fix bttv-driver "cleanup" that called an incorrect function
  o Fix up udev url in Documentation/Changes file
  o add feature-removal-schedule.txt documentation
  o Cset exclude: jmunsin@iki.fi|ChangeSet|20041221190949|45117
  o PCI Hotplug: remove my old email address

Greg Ungerer:
  o m68knommu: remove use of obsolete MAP_NR macro
  o m68knommu: remove unneccessary SUN conditionals from
    m68knommu/elf.h
  o m68knommu: remove unused keyboard.h
  o m68knommu: remove duplicate and unused entries in Kconfig
  o m68knommu: export lib udelay symbol for modules
  o m68knommu: comment formating change to linker script
  o m68knommu: convert KTHRAD_SIZE to THREAD_SIZE and remove unused
    macros
  o m68knommu: optimized bitops operations for m68knommu
  o m68knommu: convert use of KTHRAD_SIZE to THREAD_SIZE in process.c
  o m68knommu: remove unused include/asm-m68knommu/nap.h
  o m68knommu: remove use of obsolete MAP_NR macro processor.h
  o m68knommu: include module.h to cleanup warnings in checksum.c
  o m68knommu: common head code for all ColdFire platforms
  o m68knommu: cache init code for ColdFire CPU's
  o m68knommu: change ColdFire 5206 SDRAM register names
  o m68knommu: move ColdFire 5249 platform specific startup code
  o m68knommu: define differences in ColdFire 5270/1 and 5274/5 SDRAM
    registers
  o m68knommu: definitions for the SDRAM registers on the ColdFire 528x
    CPU's
  o m68knommu: remove duplicate THREAD_SIZE define
  o m68knommu: new hardware support and optimizations for the ColdFire
    serial driver
  o m68knommu: optimize atomic macros

H. Peter Anvin:
  o Trivial cleanup in arch/i386/kernel/head.S
  o i386 boot loader IDs
  o /proc/sys/kernel/bootloader_type
  o raid6: altivec support

Heikki Lindholm:
  o MTD: Use JEDEC probe for flash chips on Ebony board
  o MTD: New mapping driver for IBM 405GP 'Walnut' board

Heiko Carstens:
  o s390: core patches
  o s390: fix pgd_index() compile warnings
  o s390: add missing pte_read function

Herbert Pötzl:
  o improved wait_8254_wraparound()

Hermann Kneissel:
  o Re: garmin gps driver patch 0.23

Hirofumi Ogawa:
  o NLS: Fix overflow of nls_ascii
  o pcmcia: Add disable_clkrun option

Hirokazu Takata:
  o m32r: Add new relocation types to elf.h
  o m32r: Support pgprot_noncached()
  o m32r: Update ptrace.c for multithread  debugging
  o m32r: Cause SIGSEGV for nonexec page execution
  o m32r: Don't encode ACE_INSTRUCTION in address
  o m32r: Clean up arch/m32r/mm/fault.c
  o m32r: Clean up include/asm-m32r/pgtable.h
  o m32r: Support PAGE_NONE
  o m32r: Remove PAGE_USER
  o m32r: Clean up include/asm-m32r/pgtable-2level.h
  o m32r: include/asm-m32r/thread_info.h minor  updates
  o m32r: Use kmalloc for m32r stacks
  o m32r: Make kernel headers for mutual  exclusion
  o m32r: Use generic hardirq framework
  o m32r: Update include/asm-m32r/system.h
  o m32r: Update include/asm-m32r/mmu_context.h
  o oprofile: update m32r for api changes
  o m32r: build fix
  o m32r: employ new kernel API/ABI
  o m32r: include nodemask.h for build fix

Hisashi Hifumi:
  o BUG on error handlings in Ext3 under I/O failure condition

Hugh Dickins:
  o improve preemption on SMP
  o vmtrunc: truncate_count not atomic
  o vmtrunc: restore unmap_vmas zap_bytes
  o vmtrunc: unmap_mapping_range_tree
  o vmtrunc: unmap_mapping dropping i_mmap_lock
  o vmtrunc: vm_truncate_count race caution
  o vmtrunc: bug if page_mapped
  o vmtrunc: restart_addr in truncate_count
  o 3c59x: VORTEX select MII
  o cputime: introduce cputime
  o 4level swapoff hang fix

Ian Campbell:
  o I2C: i2c-algo-bit should support I2C_FUNC_I2C

Ian Molton:
  o arm26: remove arm32 cruft
  o arm26: update the atomic ops
  o arm26 build system updates
  o arm26: update comments, headers, notes
  o arm26: necessary compilation fixes for 2.6.10
  o arm26:cleanup trap handling assembly
  o arm26: new execve code
  o arm26: move some files to better locations
  o arm26: remove shark (arm32) from arm26
  o arm26: softirq update
  o arm26: update system.h to some semblance of recentness
  o arm26: replace arm32 time handling code with smaller version
  o arm26: TLB update
  o arm26: better put_user macros
  o arm26: better unistd.h (reimplemented based on arm32)

Ian Pratt:
  o [NET]: Add alloc_skb_from_cache

Ingo Molnar:
  o preempt cleanup
  o add lock_need_resched()
  o sched: add cond_resched_softirq()
  o sched: ext3: fix scheduling latencies in ext3
  o break latency in invalidate_list()
  o sched: vfs: fix scheduling latencies in prune_dcache() and
    select_parent()
  o sched: net: fix scheduling latencies in netstat
  o sched: net: fix scheduling latencies in __release_sock
  o sched: mm: fix scheduling latencies in unmap_vmas()
  o sched: mm: fix scheduling latencies in get_user_pages()
  o sched: mm: fix scheduling latencies in filemap_sync()
  o fix keventd execution dependency
  o sched: fix scheduling latencies in vgacon.c
  o sched: fix scheduling latencies for !PREEMPT kernels
  o idle thread preemption fix
  o oprofile smp_processor_id() fixes
  o Fix smp_processor_id() warning in numa_node_id()
  o remove the BKL by turning it into a semaphore
  o sched: Make PREEMPT_BKL depend on PREEMPT alone

J. A. Magallon:
  o make gconfig work with gtk-2.4

James Bottomley:
  o update the fc_transport_class to use a workqueue instead of a
    timeout
  o SCSI: Add transport destructors
  o SCSI: Add missing state transition BLOCK->OFFLINE
  o scsi:   LLDD dynamic scan aids
  o fixup dynamic scan aids EXPORT_SYMBOL mismerge
  o Rename SCSI ChangeLog to reflect its venarability
  o SCSI: Quieten the incorrect state change message
  o SCSI: Add basic infrastructure for transport host statistics
  o SCSI: Add FC transport host statistics
  o SCSI:add change_queue_depth API to scsi host template
  o SCSI: convert 53c700 driver to use change_queue_depth API
  o SCSI: add queue_type entry in sysfs
  o SCSI: update 53c700 to use the change_queue_type API
  o SCSI: Add FC transport host attributes
  o SCSI: fix compile warning in fc transport class

James Lamanna:
  o USB: ov511.c - vfree() checking cleanups

James Morris:
  o SELinux scalability: add spin_trylock_irq and  spin_trylock_irqsave
  o SELinux scalability: convert AVC to RCU
  o SELinux: atomic_dec_and_test() bug
  o SELinux scalability: AVC statistics and tuning

James Nelson:
  o hw_random: Minor cleanup to hw_random.c
  o lcd: fix memory leak, code cleanup
  o moxa: Remove ancient changelog README.moxa
  o moxa: Remove README.moxa from Documentation/00-INDEX
  o specialix: remove bouncing e-mail address
  o stallion: Update to Documentation/stallion.txt
  o riscom8: Update staus and documentation of driver
  o cciss: Documentation update
  o cciss: Correct mailing list address in source code
  o cpqarray: Correct mailing list address in source code
  o sh: Remove x86-specific help in Kconfig
  o cyclades: Put README.cycladeZ in Documentation/serial
  o tipar: Document driver options
  o tipar: Code cleanup

Jan Dittmer:
  o eth1394 MODULE_PARM conversion
  o isapnp module_param conversion
  o sr module_param conversion
  o media/video module_param conversion
  o btaudio module_param conversion

Jan Harkes:
  o coda: bounds checking
  o code: ulist_for_each_entry_safe()
  o coda: make global code static
  o coda: remove unused coda_mknod
  o coda: rename coda_psdev to coda

Jan Kara:
  o Expose reiserfs_sync_fs()
  o Fix reiserfs quota debug messages
  o Fix of quota deadlock on pagelock: quota core
  o quota umount race fix
  o Fix of quota deadlock on pagelock: ext2
  o Fix of quota deadlock on pagelock: ext3
  o Allow disabling quota messages to console
  o Fix maintainers entry

Jan Kasprzak:
  o cosa.c intialization crash
  o cosa.h ioctl numbers

Jan-Benedict Glaw:
  o Input: correct the the wrong use of "DB9" to the correct name,
    "DE9"
  o input: More comment fixes in lkkbd.c

Jarkko Lavinen:
  o MTD: Increase nand_write_page() ECC buffer size to cope with
    12-byte ECC
  o MTD: Make nand_write_page() ECC buffer size consistent with
    nand_read_ecc()

Jaroslav Kysela:
  o [ALSA] use blacklist/whitelist for (non-)audio Bt878 cards
  o [ALSA] fix sequencer sleeping in interrupt context
  o [ALSA] rearrange OSS SPARC dependencies
  o [ALSA] snd-usb-usx2y - crash fix for OHCI USB-HCDs
  o [ALSA] au88x0: add resetup dma
  o [ALSA] au88x0: fix is-quad oops
  o [ALSA] au88x0: set-levels cleanup
  o [ALSA] au88x0: sign_invert cleanup
  o [ALSA] au88x0: name typo
  o [ALSA] au88x0: comment and whitespace cleanup
  o [ALSA] fix data type mismatch in sign_invert
  o [ALSA] remove old compatibility code
  o [ALSA] remove dead exports
  o [ALSA] Limit parity error messages
  o [ALSA] remove kernel version info from proc file
  o [ALSA] fixed emu10k1_fx8010_code_t structure to be less than 8192
    bytes
  o [ALSA] emu10k1 - fixes against the last emufx changes
  o [ALSA] replace schedule_timeout() with msleep()
  o [ALSA] replace schedule_timeout() with msleep()
  o [ALSA] emu10k1 - another attempt to correct the new emufx DSP code
  o [ALSA] Added SNDRV_HWDEP_IFACE_BLUETOOTH
  o [ALSA] remove snd_seq_simple_id
  o [ALSA] Fixed the description of module_parm_array()
  o [ALSA] removes unneeded spin_lock_irqsave()s from snd-es1968
  o [ALSA] Add subvendor ID to the pci id table of vx222 driver
  o [ALSA] Fixed issues with Abit AV8
  o [ALSA] [emu10k1] add interval timer support
  o [ALSA] emu10k1 - fixed remaining problems with new DSP code loading
  o [ALSA] handle missing control bitmap when parsing MUDs
  o [ALSA] read bmControls array in correct order
  o [ALSA] fix parsing of mixer unit descriptors
  o [ALSA] nonblock_open=1 by default for OSS PCM API emulation
  o ALSA 1.0.7
  o [ALSA] Fix the missing line in the patch for hdsp accurate_ptr
  o [ALSA] Fix WM8770 Init
  o [ALSA] AC97 quirks for Dell
  o [ALSA] fix sleep in atomic during prepare callback
  o [ALSA] Add pci_save_state() in suspend
  o [ALSA] add Line/Headphone jack detection for AD1981A/B
  o [ALSA] fix iomem mmap
  o [ALSA] fix MIDI GS chorus/reverb mode
  o [ALSA] fix chorus/reverb FX loader
  o [ALSA] minor send routing cleanup
  o [ALSA] whitespace cleanup
  o [ALSA] Add pci_disable_device() to removal and error paths
  o [ALSA] Addition of pci_disable_device() and cleanup
  o [ALSA] via82xx: Enable DXS on ABIT KV8 Pro
  o [ALSA] sort DXS whitelist
  o [ALSA] AD18xx/19xx resume fix
  o [ALSA] fix display of send routing in /proc
  o [ALSA] ALSA PCI drivers: misc cleanups
  o [ALSA] Fixes the 'It disables the right channel' bug
  o [ALSA] Support for Audigy2 Value SB0400
  o [ALSA] make some code static
  o [ALSA] check CONFIG_COMPAT for snd-ioctl32
  o [ALSA] add register dump to proc
  o [ALSA] Fixed problem with changing size of etram
  o [ALSA] [trivial] Fix compile warnings
  o [ALSA] Fix the detection of Audigy2 ZS
  o [ALSA] fix weird placement of static keyword in
    sound/core/pcm_memory.c
  o [ALSA] misc clean up
  o [ALSA] ALSA ISA drivers: misc cleanups
  o [ALSA] Disable 'IEC958 Input Monitor' switch for ALC codecs
  o [ALSA] alternate ALS0200 ident string
  o [ALSA] alternate CS4235 ident string
  o [ALSA] Fix compilation without CONFIG_PM
  o [ALSA] Export functions for ioctl32 wrapper
  o [ALSA] Fix ioctl32 wrapper (for SPARC)
  o [ALSA] Clean up of kfree()/vfree() NULL checks
  o [ALSA] Fix targets for GUS and OPL4
  o [ALSA] [trivial] Fix compilation warnings on 64bit
  o [ALSA] Fix the interface type of mixer controls
  o [ALSA] Fix interface type for some mixer controls
  o [ALSA] ifdef typos: sound_isa_cs423x_cs4231_lib.c
  o [ALSA] ifdef typos: sound_isa_es18xx.c
  o [ALSA] check __copy_to_user in sscape_upload_bootblock()
  o [ALSA] ALSA core: misc cleanups
  o [ALSA] Added VIA82xx-modem driver
  o [ALSA] Remove the NULL pointer check in kfree/vfree wrappers
  o [ALSA] Use macro usb_maxpacket() for portability
  o [ALSA] Fix sleep in h/w volume control
  o [ALSA] IEC958 Capture mixer controls and Universe support
  o [ALSA] disable legacy IRQs before request_irq() to avoid unhandled
    interrupts
  o [ALSA] Update user-space access from sscape driver
  o [ALSA] opl4 depends on opl3
  o [ALSA] Add 'Duplicate Front' control
  o [ALSA] misc cleanups
  o ALSA CVS update ENS1370/1+ driver Trivial patch to enable rear out
    selection for ens1373 on the Gigabyte GA-8IEXP motherboard.
  o [ALSA] Fix detection of Xbox
  o [ALSA] hwdep interface for pcm data
  o [ALSA] Add missing source codes in the last hwdep-pcm patch
  o [ALSA] Add missing USX2Y_PCM hwdep entry
  o [ALSA] Fix non-symmetrical page_attr changes
  o [ALSA] [trivial] Fix compile warning
  o [ALSA] Midiman Delta DIO2496 has two stereo analog outs
  o [ALSA] Clean up power-management
  o [ALSA] Export snd_ctl_elem_read/write() functions
  o [ALSA] buffersize and constraints on pmac
  o [ALSA] Add volatile to IO pinters
  o [ALSA] Return -EBADFD when the device is disconnected
  o [ALSA] Fix memory corruption
  o [ALSA] Hotplug firmware loader support
  o [ALSA] Add description about hotplug fw loader
  o [ALSA] Fix interrupt generation on MIDI input for es1938 sound
    cards
  o [ALSA] Fix CMI9739A silent problem
  o [ALSA] Fix compilation errors
  o [ALSA] Fix the invalid DMA pointer value
  o [ALSA] Add PCXHR hwdep iface type
  o [ALSA] Fix invalid 'AutoSync Reference' value
  o [ALSA] Fix the wrong sign of format data entries
  o [ALSA] Fix compile warning
  o [ALSA] Add mute LED quirk
  o [ALSA] Fix creation of control devices over udev
  o [ALSA] Replace long delays with msleep()
  o [ALSA] Unify ac97 control callbacks
  o [ALSA] Remove spinlock in callbacks
  o [ALSA] Remove unnecessary ac97 spinlocks
  o [ALSA] Fix spinlocks
  o [ALSA] Spinlock removal and loop fix
  o [ALSA] Use msleep() in ac97 callbacks
  o [ALSA] Don't probe rates when bus->no_vra is set
  o [ALSA] Fix handling of user-defined controls
  o [ALSA] Allow strings for ac97_quirk options
  o [ALSA] Add emu10k1x driver
  o [ALSA] Add snd-ca0106 driver
  o [ALSA] Avoid VRA on codec chips
  o [ALSA] Code clean up
  o [ALSA CVS]  delete unused file
  o [ALSA] Fix open handling
  o [ALSA] Fix compile warning (make inline)
  o [ALSA] Fix compile warning
  o [ALSA] Add hotplug firmware loader support
  o [ALSA] Update documentation for hotplug fw loader
  o [ALSA] Fix the release of resources at error path
  o [ALSA] Description about snd_card_set_dev()
  o [ALSA] Clean up codes
  o [ALSA] Fix the order of creation of instances
  o [ALSA] Remove superfluous code
  o [ALSA] Add CODEC and BUS device types
  o [ALSA] Fix spinlock
  o [ALSA] Clean up handling of user-defined controls
  o [ALSA] Clean up and fix stereo mutes
  o [ALSA] Add a new ID
  o [ALSA] Fix NULL pointer access
  o [ALSA] Add a DXS entry for ABIT VA-20
  o [ALSA] Fix C-Media codecs
  o [ALSA] Add codec id in component names
  o [ALSA] Don't probe sample rates on non-VRA chips
  o [ALSA] Print values at errors
  o [ALSA] 1.0.8rc2

Jason Gaston:
  o [patch] Intel ICH7 DID's, PIRQ and PATA support
  o SATA support for Intel ICH7

Jay Lan:
  o enhanced I/O accounting data patch
  o enhanced Memory accounting data collection
  o acct_update_integrals speedup

Jean Delvare:
  o I2C: use chip driver name to request regions
  o I2C: i2c-algo-bit should support I2C_FUNC_I2C
  o I2C: i2c-nforce2 supports the nForce3 250Gb
  o I2C: Discard old driver porting documentation
  o I2C: Use PCI_DEVICE in bus drivers
  o I2C: Remove checksum code in eeprom driver
  o I2C: Add secondary Super-I/O address support to
  o I2C: Improve VID code for the W83627THF
  o I2C: Fix MAX6657/8/9 detection in lm90
  o I2C: Add byte commands to i2c-stub
  o I2C: Update fscher pwm functionality

Jeff Dike:
  o uml: fix some ptrace functions returns values
  o uml: redo the signal delivery mechanism
  o uml: make restorer match i386
  o uml: unistd.h cleanup
  o uml: remove a quilt-induced duplicity
  o uml: fix sigreturn to not copy_user under a spinlock
  o uml: close host file descriptors properly
  o uml: free host resources associated with freed IRQs
  o uml: add elf vsyscall support
  o uml: make vsyscall page into process page tables
  o uml: include vsyscall page in core dumps
  o uml: Add TRACESYSGOOD support
  o uml: kill host processes properly
  o uml: defconfig update
  o uml: system call restart fixes
  o uml: use SYSEMU_SINGLESTEP
  o uml: declare ptrace_setfpregs
  o uml: Remove bogus __NR_sigreturn check
  o uml: Fix highmem compilation
  o UML: add some pudding
  o UML: Use va_end wherever va_args are used
  o UML: split out arch-specific syscalls from generic ones
  o UML: Three-level page table support
  o UML: x86-64 core support
  o UML: x86-64 config support
  o UML: Factor out register saving and restoring
  o UML: x86_64 ptrace support
  o UML: Separate out signal reception
  o UML: Make a common misconfiguration impossible
  o UML: Separate out the time code
  o UML: x86-64 headers
  o UML: Split out arch link address definitions
  o UML: code tidying
  o UML: use for_each_cpu
  o UML: 2.6.10 ptrace updates
  o UML: add the new syscalls
  o UML: 64-bit cleanups
  o UML: Silence some message from the console driver
  o UML: Allow arches to opt out of !SA_INFO signals
  o UML: Add a missing include
  o UML: sparse annotations
  o UML: Fix sys_call_table syntax
  o UML: Fix make clean
  o UML: define CONFIG_INPUT better
  o UML: Fix a compile warning

Jeff Garzik:
  o [netdrvr eepro100] fix pci_iomap() args and info msg that follows
  o [sound/oss i810_audio] use module_param()
  o [sound/oss] use module_param() in soundcard.c and uart401.c
  o [libata sata_uli] add 5281 support, fix SATA phy setup for others
  o drivers/block/floppy:  kill #include linux/version.h
  o x86-64: kernel/sys.c build fix
  o [netdrvr s2io] make debug_level variable static
  o fix sx8 blk driver device naming

Jens Axboe:
  o kill locking around scsi_done()

Jeremy Katz:
  o Fix sx8 device naming in sysfs

Jesper Juhl:
  o [IRDA]: Kill useless parens from return statements in irnet.h
  o [MTD] remove unnecessary casts from drivers/mtd/maps/nettel.c and
    kill two warnings
  o add printing of udev version to scripts/ver_linux

Jesse Barnes:
  o sysfs: add mmap support to struct bin_attribute files
  o PCI: export PCI resources in sysfs
  o driver core: allow struct bin_attributes in class devices
  o PCI: add legacy resources to sysfs for pci busses
  o fix ROM enable/disable in r128 and radeon fb drivers
  o [IA64] swiotlb.c: long line, whitespace, and other cleanup
  o fix oops when reading resourceN files in sysfs
  o Replace 'numnodes' with 'node_online_map' - ia64

Jim Hague:
  o pm2fb: module parameters and module-conditional code
  o pm2fb: save/restore memory config
  o pm2fb: use modedb in modules
  o pm2fb: fix big-endian (Sparc) support
  o pm2fb: fix fbi image display on 24 bit depth big endian

Jim Paris:
  o [ide] PCI quirk for ICH3-M IDE

John Lenz:
  o input: Add LED definitions for PDAs

John W. Linville:
  o r8169: endian-swap return of rtl8169_tx_vlan_tag()
  o r8169: fix RxVlan bit manipulation
  o r8169: simplify trick if() expression
  o 3c59x: Add MODULE_VERSION
  o 8139too: Add MODULE_VERSION
  o r8169: Add MODULE_VERSION
  o e100: Add MODULE_VERSION
  o tulip: Add MODULE_VERSION
  o 3c59x: reload EEPROM values at rmmod for needy cards
  o 3c59x: remove EEPROM_RESET for 3c905B
  o 3c59x: Add EEPROM_RESET for 3c900 Boomerang

Jon Smirl:
  o drm: memory allocation patch
  o drm: move fops into drivers
  o drm: rearrange some functions for new split
  o drm: move ati_pcigart into drm core
  o drm: use spin_lock_init instead of SPIN_LOCK_UNLOCKED

Jorn Engel:
  o MTD: phram device cleanup
  o [MTD] New blockdev-backed 'fake' MTD device

Josh Aas:
  o sched: remove outdated/misleading comments

Jürgen Quade:
  o signedness fix in deadline-iosched.c

Kamezawa Hiroyuki:
  o no buddy bitmap patch revist: intro and includes
  o no buddy bitmap patch revisit: for mm/page_alloc.c
  o no buddy bitmap patch revist: for ia64

Keith Owens:
  o kallsyms: Clean up x86-64 special casing of in_gate_area()
  o kallsyms: Add in_gate_area_no_task()
  o kallsyms: gate page is part of the kernel, honour
    CONFIG_KALLSYMS_ALL
  o kallsyms: Avoid kallsyms corner case on _etext and _einittext

Keith Withwell:
  o drm: correct historic mis-attribution of copyright

Kenji Kaneshige:
  o IRQ resource deallocation: ACPI
  o IRQ resource deallocation: ia64

Kirill Korotaev:
  o 4/4GB: Incorrect bound check in do_getname()

Komuro:
  o pcmcia: pd6729: e-mail update
  o pcmcia: pd6729: cleanups
  o pcmcia: pd6729: isa_irq handling

Krzysztof Halasa:
  o net/wan/n2.c: remove an unused function

Kumar Gala:
  o Driver Core: Add platform_get_resource_byname &
    platform_get_resource_byirq
  o ppc32: freescale Book-E MMU cleanup
  o ppc32: refactor common book-e exception code
  o ppc32: performance Monitor/Oprofile support for e500
  o Fix prototypes & externs in e500 oprofile support

Ladislav Michl:
  o I2C: let I2C_ALGO_SGI depend on MIPS

Leendert van Doorn:
  o arch/i386/kernel/cpu/mtrr: too many bits are masked off from CR4

Len Brown:
  o [ACPI] Provide core hotplug support in ACPI
  o [ACPI] create ACPI hotplug eject interface
  o [ACPI] IA64-specific support for mapping lsapic to cpu array
  o IA64 CPU hotplug topology
  o [ACPI] Extend processor driver to support ACPI-based Physical CPU
    hotplug
  o [ACPI] Initial container driver to support hotplug notifications
  o [ACPI] fix mis-merge in processor.c
  o [ACPI] CPU hotplug, use kobject_hotplug(), kobject_register()
  o [ACPI] fix VIA IRQ issue by enabling VIA quirk
    http://bugzilla.kernel.org/show_bug.cgi?id=3319
  o [ACPI] S3 resume using RTC
    http://bugzilla.kernel.org/show_bug.cgi?id=1320
  o [ACPI] fix "Error getting context for object" warning
    http://bugzilla.kernel.org/show_bug.cgi?id=3805
  o [ACPI] add "acpi_fake_ecdt" workaround for Gateway
  o [ACPI] handle GPE sharing between button and lid
  o [ACPI] fixes from stack consumption audit
  o build fix
  o [ACPI] 32-bit EC access
  o build fix
  o [ACPI] ACPICA 20041119 from Bob Moore
  o [ACPI] ACPICA 20041203 from Bob Moore and Alexey Starikovskiy
  o [ACPI] remove duplicate _PDC #defines resulting from mis-merge
  o [ACPI] fix polarity of CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI message
  o [ACPI] fix return syntax
  o [ACPI] ACPICA 20041210 from Bob Moore
  o [ACPI] Split the ACPI Processor P-States library into a different
    file
  o [ACPI] Split the ACPI Processor T-States handling into a different
    file
  o [ACPI] Split the ACPI Processor C-States handling into a different
    file
  o [ACPI] Split the ACPI Processor passive cooling code into a
    different file
  o [ACPI] Finalize the splitting of processor.c by moving the rest to
    processor_core.c
  o [ACPI] Shorten the times IRQs are disabled in throttling
  o [ACPI] Differentiate between C-States and C-state type
  o [ACPI] Split up the extraction of information from the FADT and the
    pblk_address (acpi_processor_get_power_info_fadt()) and the
    validation whether the state is indeed available
    (acpi_processor_power_verify()).
  o [ACPI] deleted unused default c-state
  o [ACPI] make power.state a pointer
  o [ACPI] make the c-state policy decisions of demotion and promotion
    independent of the assumption "one state per type." make the state
    a pointer inside struct acpi_processor_cx_policy.
  o [ACPI] Add _CST parsing
  o [ACPI] Handle _CST change notifications
  o [ACPI] Notify the BIOS that Linux can handle _CST
  o [ACPI] Consolidate code in processor_idle()
  o [ACPI] Export /sys/module/processor/parameters/max_cstate
  o [ACPI] max_cstate shall limit C-states not C-state-types
  o  [ACPI] tweak /proc/acpi/processor/CPU0/power format Current policy
    is to name both C-state-types and the actual C-States "C[0-n]".
    Follow this rule...
  o [ACPI] Let C4 demote to C3, not directly to C2
  o [ACPI] add "processor.nocst" parameter which blocks _CST parsing
    and always uses FADT info instead.
  o [ACPI] fix to the stack-audit patch
    http://bugzilla.kernel.org/show_bug.cgi?id=2901
  o [ACPI] two fixups where promotion and demotion were mixed up
  o [ACPI] another fix to the stack-audit patch
    http://bugzilla.kernel.org/show_bug.cgi?id=2901
  o [ACPI] apply via_interrupt_line_quirk in ACPI mode the same way it
    is applied in legacy mode.
  o [ACPI] Fix suspend/resume lockup issue by leaving Bus Master
    Arbitration enabled.

Lennart Poettering:
  o [SERIAL] support for another Rockwell PNP modem

Lennert Buytenhek:
  o [ARM PATCH] 2351/1: fix compilation for ixp2000 enp2611 and
    ixdp2400 platforms

Li Shaohua:
  o time runx too fast after S3

Liam Girdwood:
  o [ARM PATCH] 2340/1: Added PXA27x SSP port 3 to kernel io address
    range
  o [ARM PATCH] 2342/1: Support PXA SSP configuration changes when port
    is open
  o [ARM PATCH] 2347/1: PXA SSP PSP bit definition

Linus Torvalds:
  o Fix the fix
  o Revert duplicate AC97 id's
  o Now that sparse looks into asms, fix the fake anti-optimizer cast
    macro to use the right address space.
  o x86: common send_sigtrap helper for debug event SIGTRAP's, and use
    that for system call single-step events.
  o x86: be a lot more careful about TF handling
  o x86: single-step over "popf" without corrupting state
  o acpi video device enumeration: fix incorrect device list allocation
  o x86 ptrace: remove long stale (and bitrotted) test for PT_DTRACE
    without PT_PTRACED.
  o x86 single-step: fix up comments and cleanup
  o Hide question about SERIO_LIBPS2 unless there is some remote reason
    the user migth want to see it.
  o Mark HPUSBSCSI scanner broken. You're supposed to use libusb
  o fbmem: don't mix code/declarations. That messes up gcc-2.95
  o Use 'free_pipe_info()' helper function for pipe closedown
  o Make pipe data structure be a circular list of pages, rather than a
    circular list of one page.
  o Fix do_brk() locking in library loader
  o Fix TASK_SIZE range check that got lost in recent
    clear_page_range()/4-level page table updates.
  o Merge small pipe writes into the write buffers
  o Re-use the buffer page for pipe data
  o Map new page allocations as part of "prep_new_page"
  o Don't use __GFP_CLEAR for user pages
  o Make it clear that GFP_ZERO does not work with atomic highmem
    allocations
  o Clean up stack growth checks and move them into a common function
  o Revert moxa status update
  o Linux 2.6.11-rc1

Luca Risolia:
  o USB: SN9C10x driver updates

Luiz Capitulino:
  o [NET]: __sock_create() cleanup

Maciej W. Rozycki:
  o PCI: Don't touch BARs of host bridges
  o PCI: PCI early fixup missing bits

Manfred Spraul:
  o slab: Add more arch overrides to control object alignment
  o rcu: make two internal structs static
  o rcu: simplify quiescent state detection
  o fix missing wakeup in ipc/sem
  o forcedeth: add ethtool get/set_settings support

Marcelo Tosatti:
  o mm: higher order watermarks
  o binfmt_elf fix return error codes and early corrupt binary
    detection

Margit Schubert-While:
  o prism54 fix resume processing
  o prism54 sparse fixes

Mark A. Greer:
  o ppc32: Marvell host bridge support (mv64x60)
  o ppc32-marvell-host-bridge-support-mv64x60 review fixes
  o ppc32: support for Marvell EV-64260[ab]-BP eval platform
  o ppc32: support for Force CPCI-690 board
  o ppc32: support for Artesyn Katana cPCI boards

Mark Haverkamp:
  o aacraid 2.6: Support for new cards

Mark M. Hoffman:
  o I2C: probe fewer addresses for asb100 (sensors) driver
  o I2C: add new sensors driver: SMSC LPC47B397-NC

Martin J. Bligh:
  o Assign PKMAP_BASE dynamically

Martin Josefsson:
  o Fix broken RST handling in ip_conntrack

Martin Schwidefsky:
  o s390: remove compat setup_arg_pages32
  o sys_stime needs a compat function
  o Fix index calculations in clear_page_range
  o cputime: microsecond based cputime for s390

Matt Domsch:
  o EDD: add edd=off and edd=skipmbr options

Matt Mackall:
  o kbuild: make kernelrelease
  o random: whitespace cleanups
  o random: remove pool resizing sysctl

Matt Porter:
  o ppc32: PPC4xx PIC rewrite/cleanup
  o ppc32: fix ebony.c warnings
  o ppc32: remove bogus SPRN_CPC0_GPIO define
  o ppc32: add uImage to default targets
  o ppc32: fix io_remap_page_range for 36-bit phys platforms

Matthew Dharm:
  o USB Storage: support 'bulk32' devices
  o USB Storage: Increase Genesys delay

Matthew Dobson:
  o cpumask_t initializers
  o sched: active_load_balance() fixlet
  o Replace 'numnodes' with 'node_online_map' - alpha
  o Replace 'numnodes' with 'node_online_map' - arm
  o Replace 'numnodes' with 'node_online_map' - i386
  o Replace 'numnodes' with 'node_online_map' - m32r
  o Replace 'numnodes' with 'node_online_map' - mips
  o Replace 'numnodes' with 'node_online_map' - parisc
  o Replace 'numnodes' with 'node_online_map' - ppc64
  o Replace 'numnodes' with 'node_online_map' - x86_64

Matthew Wilcox:
  o Move MCA_bus to linux/mca.h
  o PCI: cope with duplicate bus numbers better
  o PCI: Software visible configuration request retry status
  o [SPARC64]: Stop referencing i_sock directly
  o [IA64] Perfmon over-initialises its inodes
  o [IA64] Fix memcpy_fromio prototype
  o [IA64] Enable ForteMedia in zx1 defconfig

Maximilian Attems:
  o ifdef typos: arch_ppc_platforms_prep_setup.c
  o ifdef typos: arch_ppc_platforms_prep_setup.c -another one
  o ifdef typos: arch_ppc_syslib_ppc4xx_dma.c
  o ifdef typos: arch_sh_boards_renesas_hs7751rvoip_io.c
  o ifdef typos: drivers_char_ipmi_ipmi_si_intf.c
  o ifdef typos: drivers_net_wireless_wavelan_cs.c
  o ifdef typos: drivers_usb_net_usbnet.c
  o ifdef typos mips: AU1[0X]00_USB_DEVICE

Michal Ludvig:
  o [CRYPTO]: Standalone VIA PadLock driver
  o VIA PadLock compilation fixes
  o Add Michal Ludvig to CREDITS

Michal Schmidt:
  o sk98: add netpoll console support

Mike Christie:
  o iSCSI transport class

Mike Miller:
  o cciss update to version 2.6.4

Milton D. Miller II:
  o INITRAMFS: allow no trailer

Miquel van Smoorenburg:
  o mark_page_accessed() for read()s on non-page boundaries

Nathan Bryant:
  o 3c59x: enable power management unconditionally

Nathan Lynch:
  o prohibit slash in proc directory entry names
  o introduce idle_task_exit
  o ppc64: call idle_task_exit from cpu_die
  o cpu_down() warning fix
  o ppc64: Make NUMA code handle unexpected layouts

Neil Brown:
  o knfsd: nfsd_translate_wouldblocks
  o knfsd: svcrpc: auth_null fixes
  o knfsd: svcrpc: share code duplicated between auth_unix and
    auth_null
  o knfsd: nfsd4: fix open_downgrade decode error
  o knfsd: rpcsec_gss: comparing pointer to 0 instead of NULL
  o knfsd: nfsd4: fix fileid in readdir responses
  o knfsd: nfsd4: use the fsid export option when returning the fsid
    attribute
  o knfsd: nfsd4 encode_dirent cleanup
  o knfsd: nfsd4: encode_dirent: superfluous assignment
  o knfsd: nfsd4: encode_dirent: superfluous local variables
  o knfsd: nfsd4: encode_dirent: more readdir attribute encoding to new
    function
  o knfsd: nfsd4: encode_dirent: simplify nfs4_encode_dirent_fattr
  o knfsd: nfsd4: encode_dirent: move rdattr_error code to new function
  o knfsd: nfsd4: encode_dirent: simplify error handling
  o knfsd: nfsd4: encode_dirent: simplify control flow
  o knfsd: nfsd4: encode_dirent: fix dropit return
  o knfsd: nfsd4: encode_dirent: trivial cleanup
  o knfsd: move nfserr_openmode checking from nfsd_read/write into
    nfs4_preprocess_stateid_op() in preparation for delegation state
  o knfsd: check the callback netid in gen_callback
  o knfsd: count the nfs4_client structure usage
  o knfsd: preparation for delegation: client callback probe
  o knfsd: probe the callback path upon a successful
    setclientid_confirm
  o knfsd: check for existence of file_lock parameter inside of the
    kernel lock
  o knfsd: get rid of the special delegation_stateid_t, use the
    existing stateid_t
  o knfsd: add structures for delegation support
  o knfsd: allocate and initialize the delegation structure
  o knfsd: find a delegation for a file given a stateid
  o knfsd: add the delegation release and free functions
  o knfsd: changes to expire_client
  o knfsd: delay nfsd_colse for delegations until reaping
  o knfsd: delegation recall callback rpc
  o knfsd: kernel thread for delegation callback
  o knfsd: helper functions for deciding to grant a delegation
  o knfsd: attempt to hand out a delegation
  o knfsd: remove unnecessary stateowner existence check
  o knfsd: check for openmode violations given a delegation stateid
  o knfsd: add checking of delegation stateids to
    nfs4_preprocess_stateid_op
  o knfsd: add the DELEGRETURN operation
  o knfsd: add to the laundromat service for delegations
  o knfsd: clear the recall_lru of delegations at shutdown
  o nfsd4_setclientid_confirm locking fix
  o md: improve 'hash' code in linear.c

Nick Piggin:
  o parentheses to x86-64 macro
  o generic 3-level nopmd folding header
  o convert i386 to generic nopmd header
  o replace clear_page_tables with clear_page_range
  o introduce 4-level nopud folding header
  o introduce fallback header
  o convert ia64 to generic nopud header
  o ia64 4-level pgtable fix
  o mm: keep count of free areas
  o mm: teach kswapd about higher order areas
  o compound pages optimisation
  o debug sched domains before attach

Nicolas Pitre:
  o MTD XIP support: allyesconfig compile fix
  o MTD: Fix optimisation which breaks with newer Intel L18 flash chips
  o [ARM PATCH] 2369/1: remove some cruft

Nishanth Aravamudan:
  o net/gt96100eth: replace gt96100_delay() with msleep_interruptible()

Olaf Hering:
  o input: Joydump depends on gameport
  o request_irq: avoid slash in proc directory entries
  o fix typo and email in SAK.txt

Oleg Drokin:
  o reiserfs vs-8115 test adjustment

Oleg Nesterov:
  o [NET]: Use prefetching in skb_queue_walk()
  o fix double sync_page_range() in generic_file_aio_write()
  o rcu: eliminate rcu_ctrlblk.lock
  o fix conflicting cpu_idle() declarations
  o uninline/kill __exit_mm()
  o sched: use cached current value
  o don't hide thread_group_leader() from grep
  o optimize prefetch() usage in list_for_each_xxx

Oliver Neukum:
  o USB: additional device id for kaweth driver
  o USB: another workaround for cdc-acm

Olof Johansson:
  o ppc64: IOMMU cleanups: rename pci_dma_direct.c
  o ppc64: IOMMU cleanups: Main cleanup patch
  o ppc64: fix iommu cleanup regression

Olsimar:
  o bttv help fix

Paolo 'Blaisorblade' Giarrusso:
  o uml: remove most devfs_mk_symlink calls
  o uml: fix __wrap_free comment
  o hostfs: uml: set .sendfile to generic_file_sendfile
  o hostfs: uml: add some other pagecache methods
  o Uml: first part rework of run_helper() and users
  o uml: finish fixing run_helper failure path
  o ext3: use generic_open_file to fix possible preemption bugs

Patrick McHardy:
  o [PKT_SCHED]: Clean up tcf_action_init memory handling
  o [NETFILTER]: Release dst_entry in PRE_ROUTING after NAT
  o [NETFILTER]: Remove CONFIG_IP_NF_NAT_LOCAL config option
  o [NETFILTER]: Save a level of indentation in icmp_reply_translation
  o [NETFILTER]: Apply PRE_ROUTING manips in LOCAL_OUT for locally
    generated icmp errors
  o [NETFILTER]: Verify NAT manips have been applied before reversing
    them in icmp_reply_translation
  o [IPV4]: Let people know where to obtain the ss tool from

Patrick Mochel:
  o input: Remove calls to pm_access() and pm_dev_idle() from input.c,
    as they're empty functions anyway.

Paul Gortmaker:
  o scsi/advansys.c fix !CONFIG_PCI
  o 2.6.9 Use skb_padto() in drivers/net/8390.c

Paul Mackerras:
  o ppc64: simplify timer_interrupt
  o ppc64: use newer RTAS call when available
  o ppc64: clean up trap handling
  o ppc64: clean up trap handling in head.S
  o ppc64: Log machine check errors to error log and NVRAM

Pavel Machek:
  o PCI: Cleanup PCI power states
  o PCI: add pci_choose_state()
  o PCI: add prototype for pci_choose_state()
  o PCI: clean up state usage in pci core
  o PCI: fix sparse warnings in drivers/net/* and bttv
  o fix naming in swsusp
  o swsusp: kill unused variable
  o swsusp: kill one-line helpers, handle read errors
  o swsusp: Small cleanups
  o swsusp: Kill O(n^2) algorithm in swsusp
  o swsusp: try_to_freeze to make freezing hooks nicer
  o pm: remove outdated docs
  o docs: add sparse howto
  o pm: introduce pm_message_t
  o mark older power managment as deprecated
  o signal.c: convert assertion to BUG_ON()
  o Right severity level for fatal message

Pekka Enberg:
  o noop iosched: make code static
  o noop iosched: remove unused includes
  o oprofile: minor cleanups

Per Hedblom:
  o JFFS2: Fix list corruption and memory leak on write retry

Pete Zaitcev:
  o Clean mct_u232 in 2.6.10-rc2

Peter Martuccelli:
  o audit return code and log format fix

Peter Maydell:
  o input: Add support for Kensington ThinkingMouse PS/2 protocol

Peter Nelson:
  o input: Fix oops in gamecon

Peter Oberparleiter:
  o s390: DASD driver
  o s390: Character device drivers
  o s390: SCLP device driver cleanup

Peter Osterlund:
  o input: Add ALPS touchpad driver, driver by Neil Brown, Peter
    Osterlund and Dmitry Torokhov, some fixes by Vojtech Pavlik.
  o pktcdvd: make two functions static
  o pktcdvd: grep-friendly function prototypes
  o pktcdvd: Small documentation update
  o isofs: Remove useless include
  o synaptics: Remove unused struct member variable

Peter Zijlstra:
  o oprofile preempt warning fixes

Phil Dibowitz:
  o USB Storage: Remove MODE_XLATE flag from unusual_devs.h
  o USB Storage: Remove old XLATE-only entries from unusual_devs.h
  o USB Storage: unusual_devs: prolific atapi controler
  o USB Storage: unusual_devs: prolific atapi controler

Philipp Gortan:
  o 8139cp: support for TTTech MC322

Pierre Ossman:
  o [MMC] Fix warning in wbsd

Prakash Cheemplavam:
  o APIC/LAPIC hanging problems on nForce2 system

Prarit Bhargava:
  o [ide] fix erroneous rq->buffer = NULL in
    ide-io.c:ide_dma_timeout_retry()

Prasanna Meda:
  o fork: total_forks not counted under tasklist_lock
  o Add PR_GET_NAME
  o readdir: return value missed in getdents64
  o proc_kcore: Correct double accounting of elf_buflen
  o easily tweakable comm length

Prasanna S. Panchamukhi:
  o x86_64: do_general_protection() retval check
  o kprobes: dont steal interrupts from vm86

Raghavendra Koushik:
  o S2io: cosmetic changes
  o S2io: sw bug fixes
  o S2io: optimizations
  o S2io: hardware fixes
  o S2io: module loadable parameters
  o S2io: new txd allocation
  o S2io: NAPI fix
  o S2io: two buffer mode
  o S2io: new functions for card restart
  o S2io: 2 buffer mode with copy
  o S2io: modified loadable parameters
  o S2io: styling

Ralf Bächle:
  o Another big 6pack patch

Ram Pai:
  o Simplified readahead congestion control

Randy Dunlap:
  o cpqphp: reduce stack usage
  o parport_pc: don't mix module parameter styles
  o handle quoted module parameters
  o panic_timeout: move to kernel.h
  o cpumask: range check before using value
  o i2c-ali1563: fix init & exit section usage
  o add cpufreq info to Documentation/feature-removal-schedule.txt
  o ibmasm: fix init/exit sections
  o IPMI: use C99 struct inits
  o i2o: fix init/exit section usage

Randy Vinson:
  o ppc32: add Support for IBM 750FX and 750GX Eval Boards

Richard Purdie:
  o MTD SharpSL NAND driver: Calculate partitions sizes at runtime
  o [ARM PATCH] 2370/1: Add common Sharp SCOOP driver code
  o [ARM PATCH] 2371/1: PXA: Add machine support for the Sharp SL-C7xx
    series of PDAs
  o [ARM PATCH] 2366/1: PXA: Add machine type detection for the Sharp
    SL-C7xx series

Rik van Riel:
  o vmscan: count writeback pages in nr_scanned

Robert Love:
  o add class_device to miscdevice
  o sched: no need to recalculate rq

Robert Olsson:
  o [IPV4]: FIB cleanup, fib_find_alias()
  o [IPV4]: FIB cleanup, fib_detect_death()

Robin Holt:
  o Hold BKL for shorter period in generic_shutdown_super()

Roger Luethi:
  o via-rhine: WOL band-aid

Roland Dreier:
  o [INFINIBAND]: Add core InfiniBand support (public headers)
  o [INFINIBAND]: Add core InfiniBand support
  o [INFINIBAND]: Hook up drivers/infiniband
  o [INFINIBAND]: Add InfiniBand MAD (management datagram) support
    (public headers)
  o [INFINIBAND]: Add InfiniBand MAD (management datagram) support
  o [INFINIBAND]: Add InfiniBand MAD (management datagram) support
    (private headers)
  o [INFINIBAND]: Add InfiniBand MAD SMI support
  o [INFINIBAND]: Add InfiniBand SA (Subnet Administration) query
    support
  o [INFINIBAND]: Add Mellanox HCA low-level driver
  o [INFINIBAND]: Add Mellanox HCA low-level driver (midlayer
    interface)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (FW commands)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (EQ)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (initialization)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (QP/CQ)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (last bits)
  o [INFINIBAND]: Add Mellanox HCA low-level driver (MAD)
  o [INFINIBAND]: IPoIB IPv4 multicast
  o [INFINIBAND]: IPoIB IPv6 support
  o [INFINIBAND]: Add IPoIB (IP-over-InfiniBand) driver
  o [INFINIBAND]: Add IPoIB multicast and partition code
  o [INFINIBAND]: Add IPoIB userspace MAD support
  o [INFINIBAND]: Document InfiniBand ioctl use
  o [INFINIBAND]: Add InfiniBand Documentation files
  o [INFINIBAND]: InfiniBand MAINTAINERS entry
  o Export get_sb_pseudo()

Roland McGrath:
  o fix stop signal race
  o move group_exit flag into signal_struct.flags word
  o fix ptracer death race yielding bogus BUG_ON
  o move waitchld_exit from task_struct to signal_struct
  o task_struct.exit_state usage
  o fix __ptrace_unlink TASK_TRACED recovery for real parent
  o let SIGKILL wake TASK_TRACED
  o don't let PTRACE_EVENT_EXIT stop hold up SIGKILL

Rolf Eike Beer:
  o PCI Hotplug: ibmphp_core.c: coding style
  o PCI Hotplug: ibmphp_core.c: useless casts
  o PCI Hotplug: Remove unneeded kmalloc casts from ibmphp_pci.c
  o PCI Hotplug: use PCI_DEVFN in ibmphp_pci.c
  o PCI Hotplug: don't check pointer before kalling kfree in
    ibmphp_pci.c

Roman Zippel:
  o drm: fix Kconfig dependency

Ron Murray:
  o CS461x gameport code isn't being included in build

Ronald Bultje:
  o zr36067 driver - correct jpeg app/com markers
  o zr36067 driver - ppc/be port
  o zr36067 driver - reduce stack size usage

Rudolf Marek:
  o I2C: vid version detection fix

Russell King:
  o [ARM] Add DMA mmap() support
  o [ARM] Add CLCD driver mmap method and callbacks
  o [ARM] Add missing end of comment
  o [ARM] Update Integrator RTC driver
  o [ARM] Remove static mapping for RTC on Integrator/AP
  o [ARM] Add DMA mmap support for SA1100/PXA framebuffer drivers
  o [MMC] Fix UNSTUFF_BITS
  o [ARM] Swap DOMAIN_USER and DOMAIN_KERNEL indicies
  o [ARm] Silence a couple of compiler warnings
  o [ARM] Fix some pointer/integer conversion warnings for RiscPC
  o [MMC] Remove deprecated data->req
  o typeof(dev->power.saved_state)
  o [ARM] Fix slab corruption issues triggered with pud_t integration
  o [ARM] Quieten compiler warnings, etc with ARM set_pmd()
  o [ARM] Update mach-types file
  o [ARM] Add basic SMP support
  o [MMC] Remove linux/blkdev.h include
  o [ARM] Ensure we do not remap pages outside the allocated range
  o [ARM] Minor white space cleanup
  o [ARM] Rehash initial kernel setup code
  o [ARM] Move common CPU initialisation into head.S
  o [ARM] Add missing nodemask.h includes

Rusty Russell:
  o ipt_ECN corrupt checksum fix
  o Fix proc removal in ip_conntrack_standalone
  o Fix cleanup path when sysctl registration fails
  o netfilter: fix return values of ipt_recent checkentry
  o netfilter: Fix ip_conntrack_proto_sctp exit on sysctl fail
  o netfilter: Fix ip_ct_selective_cleanup(), and rename
    ip_ct_iterate_cleanup()
  o netfilter: Add comment above remove_expectations in
    destroy_conntrack()
  o netfilter: Remove IPCHAINS and IPFWADM compatibility
  o netfilter: Remove copy_to_user Warnings in Netfilter
  o netfilter: Fix cleanup in ipt_recent should ipt_registrater_match
    error
  o ipt_REJECT Target nonlinear fixes
  o When ipt_ECN needs TCP, check it is not inverted
  o Remove NAT to multiple ranges
  o ip_conntrack_alter_reply doesn't need to loop
  o Don't try too hard to NAT to unique tuple
  o Remove do_extra_mangle: double NAT on LOCAL_OUT
  o Warn when old code would have done extra mangling
  o Remove Randomness in Selecting NAT IP Address
  o Clean up the kmod handling code in iptables.c
  o Steal a Character To Create a Revision Number
  o iptables revision getsockopt
  o Add bitops to ipt_MARK without breaking compatbility
  o Multiport revision with port ranges (replaces "mport")
  o Conntrack Hash Allocation using __get_free_pages
  o Fix for UDP and TCP NAT on nonlinear skbs
  o Fix for NAT core on nonlinear skbs
  o ftp nonlinear packet fix
  o More ECN Fixes: make writable before writing
  o sys_sched_setaffinity() on UP should fail for non-zero CPUs
  o Remove EXPORT_SYMBOL_NOVERS
  o Catch module parameter parsing failures

Sam Ravnborg:
  o kbuild: drop use of /usr/bin/env in top-level Makefile
  o kbuild: skip localversion files with '~' anywhere in their name
  o kbuild: Use -isystem `gcc --print-file-name=include`

Serge Hallyn:
  o properly split capset_check+capset_set
  o capset returns -EPERM when pid==current->pid
  o split bprm_apply_creds into two functions
  o merge *_vm_enough_memory()s into a common helper

Shaun Jackman:
  o Multicast filtering for tun.c

Stas Sergeev:
  o fix cdrom autoclose

Stefan Dirsch:
  o drm: in-correct locking in intel drms
  o drm: Use wbinvd macro instead of assembly for it,

Stefan Knoblich:
  o [libata] add #include (fixes 2.4 alpha build)

Steffen Klassert:
  o 3c59x: use netdev_priv
  o 3c59x: Make use of generic_mii_ioctl
  o 3c59x: support more ethtool_ops

Stephen C. Tweedie:
  o ext3: cleanup handling of aborted transactions
  o ext3: handle attempted delete of bitmap blocks
  o ext3: handle attempted double-delete of metadata

Stephen D. Smalley:
  o SELinux: regenerate SELinux module headers
  o SELinux: update selinux_task_setscheduler
  o SELinux: audit task comm if exe cannot be determined
  o SELinux: add dynamic context transition support to SELinux
  o SELinux: enhance SELinux control of executable mappings
  o SELinux: add member node to selinuxfs
  o SELinux: eliminate unaligned accesses by policy loading code

Stephen Hemminger:
  o r8169: use module_param
  o r8169: use netdev_priv
  o via-rhine: use module_param
  o via-rhine: free_ring should be static
  o via-velocity: get rid of unused global
  o hp100: use netdev_priv (rev 2)
  o hp100: use inline for comple usage of dev->priv
  o tlan: use netdev_priv (rev 2)
  o tlan: get rid of unneeded global vars (rev 2)
  o tlan: make inline's static (rev2)
  o tlan: enable faster hash function
  o xircom_tulip_cb: convert to using module_param
  o sk98: no explicit module ref counting needed
  o sk98: local variable can be constant
  o sk98: /proc interface related changes
  o sk98: use netdev_priv
  o sk98: use module_param
  o sk98: basic ethtool support
  o sk98: ethtool phy support
  o sk98: ethtool pause param support
  o [TCP]: Efficient port randomization (rev 3)
  o via-velocity: convert to module_param

Stephen Rothwell:
  o ppc64: consolidate cache sizing variables
  o ppc64: remove the page table size from the naca
  o ppc64: remove interrupt_controller from naca
  o ppc64: remove /proc/ppc64/{naca,paca/xx}
  o ppc64: remove the paca pointer form the naca
  o ppc64: remove serialPortAddr from the naca
  o ppc64: remove debug_switch from the naca
  o ppc64: remove the naca from all but iSeries
  o ppc64: use xPMCRegsInUse
  o ppc64: move the lppaca defining header file
  o ppc64: remove StudlyCaps from lppaca structure
  o ppc64: use c99 initializers
  o ppc64: tidy up the htab_data structure
  o noone uses HAVE_ARCH_SI_CODES or HAVE_ARCH_SIGEVENT_T

Steven J. Hill:
  o I2C patch from MIPS tree

Steven Pratt:
  o Simplified readahead

Tejun Heo:
  o module sysfs: make module.mkobj inline
  o module sysfs: expand module_attribute methods
  o module sysfs: sections attr reimplemented using attr group
  o module sysfs: module parameters reimplemented using attr group

Thayne Harbaugh:
  o initramfs: unprivileged image creation

Theodore Y. Ts'o:
  o ext3 htree telldir() fix

Thomas Gleixner:
  o PCI: Fix debug statement
  o Lock initializer unifying: ALPHA
  o Lock initializer unifying: IA64
  o Lock initializer unifying: M32R
  o Lock initializer unifying: MIPS
  o Lock initializer unifying: Misc drivers
  o Lock initializer unifying: Block devices
  o Lock initializer unifying: DRM
  o Lock initializer unifying: character devices
  o Lock initializer unifying: RIO
  o Lock initializer unifying: Firewire
  o Lock initializer unifying: ISDN
  o Lock initializer unifying: Raid
  o Lock initializer unifying: media drivers
  o Lock initializer unifying: drivers/serial
  o Lock initializer unifying: Filesystems
  o Lock initializer unifying: Video
  o Lock initializer unifying: sound
  o Lock initializer cleanup (common headers)
  o Lock initializer cleanup (character devices)
  o Lock initializer cleanup (Core)
  o ppc: fix idle with interrupts disabled
  o ppc: remove duplicate define
  o ppc; include missing header

Thomas Graf:
  o [RTNETLINK]: Link attribute modification by interface name
  o [PKT_SCHED]: Validate policer configuration TLVs
  o [PKT_SCHED]: dsmark should ignore ECN bits

Thomas Winischhofer:
  o fbdev: SiS framebuffer driver update 1.7.17

Tom Rini:
  o IBM EMAC Kconfig changes
  o IBM EMAC Kconfig changes: Add 'select CRC32'
  o ppc32: Switch to KBUILD_DEFCONFIG

Tony Lindgren:
  o [ARM PATCH] 2332/1: OMAP update 1/2: Include files
  o [ARM PATCH] 2328/1: ARM Kconfig updates for OMAP leds
  o [ARM PATCH] 2329/1: Update Kconfig for OMAP processor options
  o [ARM PATCH] 2336/1: OMAP update 1/2: Arch files, take 2

Tony Luck:
  o [IA64] irq_ia64.c typo s/_IA64_REG_AR_SP/_IA64_REG_SP/
  o Document "new" ia64 maintainer

Trond Myklebust:
  o RPC: Convert rpciod into a work queue for greater flexibility
  o RPC: Remove the rpc_queue_lock global spinlock. Replace it with
    per-rpc_queue spinlocks.
  o RPC: Fix a bug in rpc_killall_tasks()
  o RPC: More aggressive RPC debugging code
  o RPC: Add missing calls to flush_dcache_page() in net/sunrpc/xdr.c
  o NFS: Make readdirplus create dentries on the fly when we're running
    through the directory.
  o NFS: The fact that readdirplus calls now create dentries from
    within readdir calls renders nfs_cached_lookup() obsolete.
  o NFS: Change rpc_ops->create() to take a dentry argument rather than
    a qstr.
  o NFSv4: Make nfs4_do_open() take a dentry argument
  o NFSv4: setattr, close and open_downgrade should use the
    state_owner's credentials when they are available.
  o NFSv4: Convert the NFSv4 close and open_downgrade operations to use
    asynchronous RPC calls.
  o RPCSEC_GSS: When the gss code notices that a cred has expired, mark
    the cred containing the context non-uptodate, triggering creation
    of a new context.
  o RPC: Instead of setting a flag (RPCAUTH_CRED_DEAD) in the cred to
    indicate failure of an upcall to get a gss context for that cred,
    set the status of waiting tasks to indicate failure.
  o RPC: The RPCAUTH_CRED_DEAD flag had been unused for some time
    before I unwisely revived it for use with the gss code.  Having
    removed that use from the gss code, it's time to remove all
    references to it.
  o RPCSEC_GSS: Miscellaneous cleanup of auth_gss.c: we're passing
    something as a void * when we know perfectly well what it is.  And
    we're passing some arguments that we don't actually use.
  o Subject: [PATCH] NFS: Sync NFS writes still use kmalloc
  o NFSv2/v3/v4: ESTALE should not be a permanent condition on
    directories
  o VFS: Avoid dentry aliasing problems in filesystems like NFS, where
    inodes may be marked as stale in one instance (causing the dentry
    to be dropped) then re-enabled in the next instance.
  o RPC: Optimize away unnecessary del_timer_sync() operations, when we
    know there are no pending timers.
  o VFS: Remove LOCK_USE_CLNT. It should no longer be necessary
  o NFS: when we mount with the "nolock" flag we need to use local
    locking
  o NFS: Fix dentry refcount accounting error which causes unnecessary
    sillyrenames when renaming to an existing file.
  o Subject: [PATCH] NFS: short write warning
  o Subject: [PATCH] NFS: report return code on GETATTR and SETATTR
  o Subject: [PATCH] RPC: display XIDs in host order
  o Subject: [PATCH] NFS: Use sizeof() instead of C macro
  o Subject: [PATCH] NFS: better handling of short writes in direct
    write path
  o Subject: [PATCH] NFS: Direct write path allocates nfs_write_data on
    the stack
  o Subject: [PATCH] NFS: Direct read path allocates nfs_read_data on
    the stack
  o Subject: [PATCH] NFS: Use parallel read operations to do direct
    read requests
  o Subject: [PATCH] NFS: Direct reads and writes need to flush dirty
    cache pages
  o Subject: [PATCH] NFS: use attribute timeout instead of "noac" mount
    option
  o NFS: Ensure ACCESS caches are invalidated together with the
    attribute cache.
  o Subject: [PATCH] NFS: incorrect "df" results
  o RPC: call_verify Don't label all retries as "server seeing
    garbage".

Tvrtko A. Ursulin:
  o smb_file_open() retval fix

Ursula Braun-Krahl:
  o s390: Network device driver patches

Vasia Pupkin:
  o Fix kernel/timer.c comment typo

Venkatesh Pallipadi:
  o x86: remove data-header and code overlap in boot/setup.S

Vincent Hanquez:
  o kill one "if (X) vfree(X)" usage

Vivek Goyal:
  o Secondary cpus boot-up for non default location built kernels

Vladimir Saveliev:
  o Fix of quota deadlock on pagelock: reiserfs

Vojtech Pavlik:
  o input: Some HID devices have problems returning the HID class
    descriptor
  o input: Add AT-compatible rawmode generation for ARM
  o input: More IOWarrior blacklist entries in hid.c, rearranging the
    blacklist back to alphabetic order.
  o input: Tidy up & fix the hid-input.c driver. Dual-wheel A4 mice
    don't report the phantom button anymore, D-Pads are mapped to
    Hat-switches, debug can print HID->Input mappings, more mappings
    added, devices with reports larger than MaxPacketSize work again.
  o input: Fix ssize_t prototype mismatch in psmouse and atkbd
  o Input: i8042 ACPI enumeration - add PNP IDs found in AMD64 laptops
  o input: Increase ACK timeouts in libps2 in case the RESET_BAT
    command is used

Werner Almesberger:
  o prio_tree: roll call to prio_tree_first into prio_tree_next
  o prio_tree: generalization
  o prio_tree: move general code from mm/ to lib/

William Lee Irwin III:
  o sparc32: fix hypersparc dvma
  o sparc32: sun4d update
  o sparc32: fix initrd memcpy problem
  o sparc32: fix missing return value for svr4_setcontext()
  o sparc32: arch/sparc/kernel/pcic.c iomem annotations
  o sparc32: unused variable in sunsu.c
  o sparc32: fix sbus rtc warnings
  o sparc32: fix missing handling for VM fault codes
  o sparc32: fix incomplete irqreturn_t sweep in
    include/asm-sparc/floppy.h
  o sparc32: remove conflicting definition of _exit()
  o sparc32: fix blank screen problem in cg6.c
  o fix arch/x86_64/ia32/syscall32.c misdeclared pud variable
  o convert FRV to use remap_pfn_range
  o invalidate_inodes speedup
  o hugetlbfs MAINTAINERS update
  o gen_init_cpio symlink, pipe and socket support
  o Replace 'numnodes' with 'node_online_map' - arch-independent
  o vm: remove remap_page_range() completely
  o oss: AC97 quirk facility
  o remove CT_TO_SECS()/CT_TO_USECS()
  o kill quota_v2.c printk() of size_t warning
  o silence numerous size_t warnings in drivers/acpi/processor_idle.c
  o make IRDA string tables conditional on CONFIG_IRDA_DEBUG
  o fix unresolved MTD symbols in scx200_docflash.c
  o fix module_param() type mismatch in drivers/char/n_hdlc.c

Xose Vazquez Perez:
  o x86_64: Fix EM64T config description

Yoichi Yuasa:
  o mips: remove duplicate _end entry
  o mtd: added NEC uPD29F064115 support
  o mips: fixed build error about NEC VR4100 series

Yoshinori Sato:
  o H8/300 new systemcall support

Zou Nanhai:
  o compat: sigtimedwait

Zwane Mwaikambo:
  o Cyrix MII cpuid returns stale %ecx
  o NX: Triple fault with 4k kernel mappings and PAE
  o Intel thermal monitor for x86_64
  o NX: Fix noexec kernel parameter
  o fix alt-sysrq deadlock
  o Remove RCU abuse in cpu_idle()
  o ppc64: Move hotplug cpu functions to smp_ops
  o x86_64: Notify user of MCE events

