Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUIMQqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUIMQqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUIMQqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:46:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:30124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268092AbUIMQk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:40:58 -0400
Date: Mon, 13 Sep 2004 09:40:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9-rc2
Message-ID: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various things all over the map, most of them not necessarily very visible 
to most people. ALSA update, and tons of small fixes pretty much 
everywhere.

The one thing that people may actually _notice_ is that you get a lot more 
warnings for some drivers due to the stricter type-checks for PCI memory 
mapping. They are harmless (code generation should be the same), and we'll 
work on trying to fix up the drivers as we go along, but they can be a bit 
daunting if you happen to enable some of the less type-friendly drivers 
right now..

		Linus


Summary of changes from v2.6.9-rc1 to v2.6.9-rc2
============================================

Aaron Grothe:
  o [CRYPTO]: Add Whirlpool digest algorithm

Adam Kropelin:
  o preset loops_per_jiffy for faster booting
  o input: Fix hiddev disconnect-while-in-use oops
  o input: Eliminate hiddev.h dependency on hid.h

Adrian Bunk:
  o update contact address for SCSI megaraid.c
  o SCSI ips: remove inlines
  o another small advansys cleanup
  o drivers/scsi/sg.c kill local jiffies functions
  o SCSI dc395x.c: fix inline compile errors
  o SCSI nsp32.c: remove inlines
  o let AIC7{9,X}XX_BUILD_FIRMWARE depend on
  o SCSI nsp32.c: missing parts of inline removal patch
  o SCSI gdth: kill #define __devinitdata
  o Alex DeVries has moved
  o R8169_NAPI help text
  o net/smc9194.c: fix gcc-3.5 inline compile errors
  o net/hamachi.c: gcc-3.5 build fixes
  o net/rrunner.c: gcc-3.5 fixes
  o net/tulip/dmfe.c: gcc-3.5 fixes
  o ixgb_main.c: fix inline compile errors
  o sk98lin/skge.c doesn't compile with PROC_FS=n
  o fix net/hamradio/dmascc with gcc 3.4
  o really uninline lmc_trace
  o pcxx.c build fix
  o riscom8 build fix
  o cdu31a.c build fix

Akinobu Mita:
  o show Active/Inactive on per-node meminfo
  o [IA64] discontig.c: reset counters every iteration each node in
    show_mem()

Al Borchers:
  o USB: update Edgeport io_usbvend.h
  o USB: update Edgeport io_fw_down.h
  o USB: update Edgeport io_fw_down3.h

Alan Cox:
  o ipr: Fix assorted dma_addr_t typing errors
  o ide: do hwif spin up for all platforms
  o ide: quiten hwif spin up
  o ide: fix bad disk geometry hang
  o ide: identify non decoded master/slave by serial and model
  o VLAN support for 3c59x/3c90x
  o Root reservations for strict overcommit
  o fix the barrier IDE detection logic
  o ide: update comments in ide.c and ide-probe.c
  o ide: remove never changing FANCY_STATUS_DUMPS define

Alan Stern:
  o USB: Set QH bit in UHCI framelist entries
  o USB: Fix submission-error bug in the USB scatter-gather
  o USB: unusual_devs.h entry
  o USB: Update unlink testing code in the usbtest driver
  o USB: Use 8-byte hub status URB buffer
  o USB: Add missing cleanup to usb_register_root_hub()

Alex Sanks:
  o USB: net2280 patch

Alexander Shatohin:
  o Typo in drivers/net/dl2k.h

Alexander Viro:
  o /dev/ptmx open() fixes
  o removed bogus casts of SPIN_LOCK_UNLOCKED
  o annotation of ki_buf
  o annotation of xfs sendfile
  o killed check_region() in ixj
  o signed char bugs in ixj
  o warning fix in usb/gadget/inode.c
  o usb alignment fixes
  o mda dependency
  o mpoa warning fix
  o NULL noise removal
  o missing export of memchr on arm
  o missing include of config.h in asm-alpha/page.h
  o bad names of local-in-macros in arm io.h
  o check_region() removal in tc/zs.c
  o check_region() removal in fdomain.c
  o any2_scsi() cleaned up
  o signed char fixes in qd65xx
  o more size_t portability fixes
  o check_region() removal in waveartist
  o preprocessor mess in msnd
  o casts are not lvalues
  o soundblaster check_region() removal
  o sscape cleanup, fixes and check_region() removal
  o trix cleanup and check_region() removal
  o mad16 cleanup, fixes and check_region() removal
  o pss cleanup, fixes and check_region() removal
  o sgalaxy cleanup and check_region() removal
  o opl3 cleanup and check_region() removal
  o ad1848 check_region() removal
  o maui cleanup, fixes and check_region() removal
  o cmpci cleanup
  o mpu401 check_region() removal
  o wf_midi check_region() removal
  o 64bit cleanup in bt878 and btaudio
  o 64bit portability fixes (pointer-to-int stuff)
  o arm Kconfig fixes
  o misc sound/oss bits
  o checksum.h annotations
  o misc alpha bits
  o ifdef fixes
  o NULL noise removal in usb/gadget
  o missing includes from irq changes
  o mmc annotation
  o missing include compiler.h in arm memory.h
  o alpha warning fixes
  o usx2y cleanups and fixes
  o missing include in pcm_native.c
  o acpi/processor.c 64bit portability
  o acpiphp_ibm.c 64bit portability
  o alpha csum_partial_copy.c annotations
  o netfilter warning (alpha)
  o mixart cleanups
  o sparc64 vga.h fix
  o __setup fixes
  o more NULL noise removal
  o eicon annotation
  o megaraid annotation
  o afs ->follow_link() fixes
  o sysfs ->follow_link() switched to new scheme
  o ncpfs ->follow_link() switched to new scheme
  o cifs ->follow_link() switched to new scheme, cleaned up
  o reduce stack use in altroot handling
  o misc cleanup in symlink-handling part of namei.c
  o nfs ->follow_link() switched to new scheme
  o adfs endianness fixes
  o ext2 endianness fixes
  o msdos and vfat endianness fixes
  o acorn partitions endianness fixes
  o UDF endianness fixes
  o quota minor endianness fixes
  o beginning of endianness annotations
  o ext2 endianness annotations
  o adfs endianness annotations
  o affs endianness annotations
  o udf endianness annotations
  o CIFSSMBLock() endianness fix
  o more endianness breakage (CIFSSMBLock(), again)
  o CIFSSMBNegotiate endianness fix
  o CIFSSMBQueryReparseLinkInfo() endianness fix

Andi Kleen:
  o gcc-3.5 fixes to advansys
  o [IA64] various issues in the IA64 swiotlb code
  o New x86-64 merge
  o md: make MD no device warning KERN_WARNING
  o Fix warnings in es7000
  o x86_64: emulate NUMA on non-NUMA hardware
  o [CPUFREQ] Fix cosmetic issue in powernow-k8 error handling
  o Add support for NUMA discovery on AMD dual core to x86-64
  o Fix boot_cpu_data on x86-64
  o Increase bus/apic limits on x86-64
  o Fix argument checking in sched_setaffinity
  o [NET]: Fix CONFIG_COMPAT build with networking disabled
  o [NET]: Do less atomic count changes in dev_queue_xmit
  o Cleanup & fix lost ticks handling on x86-64
  o Work around gcc 3.5 offsetof bug
  o [NET]: NETIF_F_LLTX for devices
  o [TG3]: Add LLTX support
  o [E1000]: Add LLTX support
  o [NET]: Improve netdev->hard_start_xmit() documentation

Andrea Arcangeli:
  o Correctly handle d_path error returns

Andreas Schwab:
  o [IA64] <asm-ia64/acpi.h> still declares deleted acpi_register_irq
  o [IA64] acpi.c: export pm_power_off for use by ipmi_poweroff module

Andrew Chew:
  o  This patch updates include/linux/pci_ids.h with the CK804 audio
    controller ID, and adds the CK804 audio controller to the
    sound/pci/intel8x0.c audio driver.
  o sata_nv: fix CK804 support

Andrew Morton:
  o Fix sparc compile error in dma-mapping.h
  o mptbase.c warning fix
  o sg.c: remove unused sg_jif_to_ms()
  o megaraid build fix
  o schedstat: UP fix
  o uml: CPU scheduler update
  o first/next_cpu returns values > NR_CPUS
  o alloc_pages priority tuning
  o USB: legousbtower.c module_param fix
  o file_ra_state_init speedup
  o eata_pio.c warning fix
  o e1000 build fix
  o sym_requeue_awaiting_cmds() warning fix
  o ipr.c build fix
  o [un]register_ioctl32_conversion() stubs
  o copy_mount_options size fix
  o sane mlock_limit
  o Fix x86_64 vs select.c namespace clash
  o must_check copy_to_user()
  o copy_to_user checking in select.c
  o megaraid warning fix
  o truncate_inode_pages latency fix
  o remove ext2_panic() prototype
  o isdn debug build fix
  o NFS: older gcc's don't like unsized arrays
  o x86_64 waitid syscall number fix
  o Fix shmem.c stubs
  o add_to_swap(): suppress oom message
  o ipr.c build fix
  o airo build fix
  o remove ext2_panic()
  o Fix mark_buffer_dirty_inode locking breakage
  o [NET]: Fix pkt_act.h warning with gcc-2.95

Andrew Vasquez:
  o qla2xxx: EH host-reset fixes
  o qla2xxx: Set firmware options fixes
  o qla2xxx: TCQ fixes
  o qla2xxx: Update version
  o Re: 2.6.8-rc3-mm2:  Debug: sleeping function called from invalid

Andrey Panin:
  o fix qla1280 build on visws

Andries E. Brouwer:
  o fat: add static
  o adfs: add static
  o isofs: add static
  o add static in affs
  o add static in afs
  o add static in befs
  o add static in autofs4
  o add static in efs
  o add static in udf
  o add static in ufs

Andy Polyakov:
  o cdrom signedness range fixes

Andy Whitcroft:
  o i386 bootmem restrictions
  o use page_to_nid
  o ppc64: topdown support
  o ppc64 topdown support: arch-specific get_unmapped_area()

Anton Blanchard:
  o reduce size of struct buffer_head on 64bit
  o reduce size of struct dentry on 64bit
  o remove cacheline alignment from inode slabs
  o ppc64: remove iseries profiling
  o reduce size of struct inode on 64bit
  o prio-tree: remove function prototype inside function
  o ppc64: enable DEBUG_SPINLOCK_SLEEP
  o ppc64: print backtrace in EEH code
  o ppc64: dynamically allocate emergency stacks
  o ppc64: update pSeries_defconfig
  o ppc64: update iSeries_defconfig
  o ppc64: quieten NUMA boot messages
  o ppc64: allocate NUMA node data node locally
  o ppc64: cleanup asm/processor.h
  o ppc64: Fix POWER5/JS20 SMP init
  o ppc64: allow SD_NODES_PER_DOMAIN to be overridden
  o ppc64: fix hang on oprofile shutdown
  o ppc64: be resilient against sysfs PCI config accesses
  o ppc64: cut down paca footprint
  o ppc64: fix boot memory reporting
  o ppc64: fix compat cpu affinity on big endian 64bit
  o ppc64: compat_get_bitmap/compat_put_bitmap
  o ppc64: fix compat NUMA API on big endian 64bit
  o use for_each_cpu in oprofile code
  o fix oprofile vfree warning on error
  o Speed up oprofile buffer drain code
  o Move __preempt_*lock into kernel_spinlock, clean up

Antonino Daplas:
  o fbdev: fix kernel panic from FBIO_CURSOR ioctl
  o fbdev: fix copy_to/from_user in fbmem.c:fb_read/write
  o fbdev: Speed up scrolling of tdfxfb
  o fbdev: PPC crash and other fixes for rivafb
  o fbcon: take over console on driver registration
  o fbdev: Clean up framebuffer initialization
  o fbdev: Add module_init() and fb_get_options() per driver

Antti P Miettinen:
  o [NETFILTER]: Consistent IP address access in arp_tables.c
  o [NETFILTER]: One missed case in arp_tables.c unaligned fixes

Arjan van de Ven:
  o flexmmap patchkit: fix for 32 bit emu for 64 bit arches
  o flex mmap for s390(x)
  o flexible-mmap for ppc64
  o Automatically enable bigsmp on big HP machines
  o fix permissions on the `tainted' sysctl
  o Fix fs/locks.c init order
  o drm: optimise i8x0 accesses
  o ide: check the return value of pci_set_dma_mask() in cs5520.c
  o make hugetlb expansion allocation nowarn

Armin Schindler:
  o 2.6 ISDN CAPI: low-level drivers skb free fix
  o ISDN Eicon driver: maint/trace fix and update

Arnaldo Carvalho de Melo:
  o [NET]: Move SOCK_foo types into linux/net.h

Arnd Bergmann:
  o Using get_cycles for add_timer_randomness

Arun Sharma:
  o Fix copying of unaligned data across user/kernel boundary

Atul Mukker:
  o Add new Megaraid driver version 2.20.0.1
  o Update to megaraid version 2.20.3.0
  o Update megaraid to version 2.20.3.1

Badari Pulavarty:
  o Fix mpage_readpage() for big requests
  o AIO/DIO oops fix

Bart De Schuymer:
  o [BRIDGE]: Add ipv6 packet filtering
  o [BRIDGE]: Fix length checking in ipv6 bridge filtering

Bartlomiej Zolnierkiewicz:
  o ide: remove /proc/ide/hd?/settings:ide-scsi & HDIO_SET_IDE_SCSI
    ioctl
  o ide: small drivers/ide/legacy/Makefile cleanup
  o ide: remove CONFIG_IDE_TASKFILE_IO code from pdc4030.c
  o ide: remove unused IDETAPE_DEBUG_LOG_VERBOSE code from ide-tape.c
  o libata: ata_piix.c PIO fix
  o ide: sgiioc4 driver needs /proc/ide entries
  o ide: fix bogus write cache comment
  o ide: remove kmalloc() from ide_unregister()
  o ide: fix LBA48 support for ALi chipsets (rev < 0xC5)
  o ide: remove unused ide_[dma,pio]_ops_t
  o ide: add ide_hwif_t->data_phase
  o ide: unify taskfile single/multiple PIO code

Baruch Even:
  o [TCP]: Fix some typos

Bastian Blank:
  o s390: export copy_in_user

Ben Dooks:
  o [ARM PATCH] 2042/1: S3C2410 - Clock fixes, added watchdog clock
  o [ARM PATCH] 2043/1: S3C2410 update to registered devices
  o [ARM PATCH] 2044/1: S3C2410 - missing IRQ_TICK from RTC resources
  o [ARM PATCH] 2055/1: S3C2410 - add timer0 deadzone definition
  o [ARM PATCH] 2056/1: S3C2410 - check for IRQ pending in
    gettimeoffset()
  o [ARM PATCH] 2061/1: S3C2410 - Drive strength control for s3c2440
  o [ARM PATCH] 2062/2:  Initial support for s3c2440 cpus
  o [ARM PATCH] 2063/1: BAST - CPLD register updates
  o [ARM PATCH] 2074/1: S3C2410 - fix reboot by watchdog
  o [ARM PATCH] 2028/1: S3C2410 - SDIO/MMC register definitions
  o [ARM PATCH] 2029/1: S3C2410 - nand controller register definitions
  o [ARM PATCH] 2058/2: S3C2410 - Add PWM devices, update ID on
    existing devices
  o [ARM PATCH] 2076/1: S3C2410 - s3c2440 support and machine updates

Ben Leslie:
  o Use posix headers in sumversion.c

Benjamin Herrenschmidt:
  o ppc32: PowerMac trackpad problems
  o ppc32: properly export some pcibios_* functions
  o ppc32: Improve workaround for 74xx CPUs with broken BTIC
  o ppc[64]: increase max auxv entries
  o ppc/ppc64: fix offb
  o ppc32: Fix boot with ppc970fx CPU
  o ppc: fix sungem NAPI
  o ppc64:Fix missing register in altivec context switch
  o fbdev/radeonfb: Remove bugus radeonfb_read/write

Bjorn Helgaas:
  o idt77252.c: add missing pci_enable_device()
  o ip2main.c: add missing pci_enable_device()
  o tpam_main.c: add missing pci_enable_device()
  o ibmasm: add missing pci_enable_device()
  o hp100.c: add missing pci_enable_device()
  o ioc3-eth.c: add missing pci_enable_device()
  o de4x5.c: add missing pci_enable_device()
  o cpqfc: add missing pci_enable_device()
  o dvb pci_enable_device() fix
  o revert ioc3-eth.c pci_enable_device() changes
  o Fix hp100.c for pci_enable_device() changes
  o Make assign_irq_vector() non-__init
  o announce hpet devices claimed
  o silence sn_console driver on non-SGI boxes

Bo Henriksen:
  o [ARM PATCH] 2065/1: LH7A40X UDC ARCH changes

Brent Casavant:
  o Fix get_nodes() mask miscalculation

Brian Gerst:
  o Fix hardcoded value in vsyscall.lds
  o kbuild: use KERNELRELEASE
  o Remove in-kernel init_module/cleanup_module stubs

Brian J. Johnson:
  o [IA64-SGI] Add full PROM version banner to
    /proc/sgi_prominfo/nodeXX/version

Brian King:
  o fix scsi_remove_device locking
  o ipr: Use cancel all instead of abort task
  o ipr: Bump driver version
  o ipr: Properly retry aborted reponse
  o ipr: New adapter support
  o ipr: Use kref instead of a kobject
  o ipr: Add maintainers email address to comment block
  o ipr: New PCI IDs
  o ipr: Properly enable/disable TCQ
  o ipr: Dead adapter I/O hang fix
  o ipr: Set allow_restart for disk devices only
  o ipr: Don't log adapter shutdown error response code
  o Allow TCQ depth to be lowered properly

Bálint Márton:
  o urandom initialisation fix

Chris Mason:
  o fix bio_uncopy_user() mem leak

Chris Wedgwood:
  o i386 reduce spurious interrupt noise

Chris Wright:
  o small simplification for two SECURITY dependencies
  o configurable SELinux bootparam value
  o use simple_read_from_buffer in selinuxfs
  o use simple_read_from_buffer in proc_info_read and
    proc_pid_attr_read

Christian Borntraeger:
  o Add bus dependencies to two scsi drivers

Christoph Hellwig:
  o qla1280: add ISP1040 register definitions
  o qla1280: add IS_ISP* helpers
  o qla1280: cleanup firmware loading, add pio-based loading
  o qla1280: cleanup qla1280_nvram_config
  o qla1280: cleanup qla1280_initialize_adapter
  o qla1280: update changelog and version
  o switch sd numbering to idr
  o kill tmscsim ->proc_info
  o clean up some more tmscsim scan logic
  o reduce pty.c ifdef clutter
  o BUG() on inconsistant dcache tree in may_delete
  o ppc32: remove dead CONFIG_KERNEL_ELF Kconfig entry
  o fix some comments about epoch in arch/alpha/kernel/time.c
  o remove read-only/immutable checks from fat_truncate
  o inode time update funnies in ncpfs
  o fix NC5380 locking and delayed work handling
  o sk98lin procfs fix
  o update scsi_eh_get_sense commentary
  o BKL removal for EH thread startup
  o mesh is ppc32-only
  o [XFS] Fix warnings in xfs_bmap.c
  o [XFS] Export sync_page_range to fix O_SYNC in XFS
  o [XFS] Rework parts of the write path so that when a direct write
    needs to fallback to buffered in the generic code, we are able to
    relock the XFS inode correctly.
  o [XFS] Fix O_SYNC flushing in XFS which regressed with concurrent
    O_SYNC write improvements recently.
  o ftape support for x86_64
  o hfs/hfsplus is missing .sendfile
  o fix devfs name for microcode driver
  o fix compile warning in ppc64 pmac_feature.c
  o fix compile warnings in via-pmu.c for !CONFIG_PMAC_PBOOK
  o stop ->put_inode abuse in vxfs
  o some missing statics in mm/
  o remove ptrinfo
  o fix compile warning in rivafb on ppc
  o [XFS] Remove a readahead page allocation failure warning, this will
    happen under normal workloads and does not indicate a problem.
  o [XFS] Fix use of AIO wait_on_sync_kiocb and a deadlock in O_SYNC
    inode semaphore handling.
  o [IPV4]: Mark inet_family_ops static
  o [NET]: Unexport {alloc,free}_divert_blk()
  o factor out common <asm/hardirq.h> code
  o centralize some nls helpers
  o remove unused sysctls from kernel/personality.c
  o fix address_space.i_mmap comment
  o remove MOD_{INC,DEC}_USE_COUNT users that got back in
  o don't mention MOD_{INC,DEC}_USE_COUNT in Documentation/
  o remove drivers/char/busmouse.[ch]
  o Missing static in buffer.c
  o [IPV6]: Remove secure_ipv6_id, unused

Christoph Lameter:
  o Time interpolator: Scalability enhancements and high resolution
    time for IA64
  o Fix hpet time interpolator setup for CONFIG_TIME_INTERPOLATION

Con Kolivas:
  o sched: adjust p4 per-cpu gain

Corey Minyard:
  o signal handling race fix

Cornelia Huck:
  o Add pci dependencies to drivers/media/dvb/ttpci/Kconfig

Coywolf Qi Hunt:
  o uml: remove a group of unused bh functions

Daniel McNeil:
  o AIO: retry infrastructure fixes and enhancements

Dave Airlie:
  o remove __NO_VERSION__ relic from the past
  o drm: missing bus_address assignment
  o Add some missing NULL->0 and __user annotiations
  o Mark gamma as broken
  o Initial DRM function table removes some if the DRIVER_ macros
  o Remove DRIVER_CTX_[CD]TOR, HAVE_KERNEL_CTX_SWITCH,
    DRIVER_BUF_PRIV_T, DRIVER_AGP_BUFFERS_MAP
  o remove DRIVER_FOPS and related macros
  o Dump __HAVE_DMA_FREELIST is only used by gamma
  o remove __HAVE_DMA_SCHEDULE was only used by gamma
  o remove HAVE_DMA_WAITLIST as it was only used by gamma
  o remove DRM_IOREMAP* and DRM_FIND_MAP macros replace them with
    inline fns
  o Remove __HAVE_AGP and __HAVE_MTRR, add driver features bitmask,
    Cleaned up a lot of #ifdef in functions using suggestions from
    Arjan.
  o Drop __HAVE_CTX_BITMAP, __HAVE_SG, __HAVE_PCI_DMA, these are fairly
    straightforward removals..
  o remove DRIVER_FILE_FIELDS, replace with a private driver structure
    allocated in open helper and freed in free_filp_priv.
  o drm: remove __HAVE_DMA/IRQ and mapping offset macros
  o drm: Sparc64 ffb compile fixes
  o drm: remove virt_to_bus
  o We dereference dev->priv a few lines above, meaning we'd
  o drm: correct i915 packet length calculations
  o Missing ctx_count decrement when releasing driver
  o drm: update Kconfig for r128/radeon

Dave Boutcher:
  o ibmvscsi driver v1.5.1

Dave Hansen:
  o reduce casting in sysenter.c
  o cast PAGE_OFFSET math to void* in early printk
  o call virt_to_page() with void*, not UL
  o vmalloc_fault() cleanup
  o don't align virt_to_page() args
  o include asm/page.h for virt_to_page()
  o [AF_PACKET]: Use void * for virtual addresses
  o ppc64: add a pfn_to_kaddr() function

Dave Jiang:
  o [ARM PATCH] 2033/1: IOP3xx patch submission (1/6)
  o [ARM PATCH] 2034/1: 2033/2 - IOP3xx patch submission (2/6)
  o [ARM PATCH] 2035/1: 2033/3 - IOP3xx patch submission (3/6)
  o [ARM PATCH] 2048/1: Patch 2036/1 (2033/4) resubmission
  o [ARM PATCH] 2049/1: 2037/1 (2033/5) resubmission
  o [ARM PATCH] 2039/1: 2033/6 resubmission

Dave Jones:
  o [CPUFREQ] Introduce some defines for the longhaul version, and use
    them
  o [CPUFREQ] Powersaver also has voltage scaling abilities
  o [CPUFREQ] Remove extraneous comment
  o [CPUFREQ] Prettyprint longhaul speeds
  o [CPUFREQ] Further cleanups to longhaul driver using defines
  o [CPUFREQ] fix up random CodingStyle /whitespace regressions
  o [CPUFREQ] Samuel2 can use eblcr to determine FSB
  o [CPUFREQ] Fix reset-to-max-speed on unloading of longhaul driver
  o [CPUFREQ] Work around some broken userspace daemons
  o [CPUFREQ] Fix silly typo that broke the compile
  o fix inlining failures
  o x86: quieten the "ESR value" printks
  o describe Intel cache descriptors
  o [CPUFREQ] Remove fsb argument from longhauls calc_speed() It's
    being passed a global everywhere, so it may as well directly
    reference it.
  o Fix up Centaur CPU feature enabling
  o [CPUFREQ] Fix up ARM drivers 'out of sync' problem
  o Eicon ISDN: fix leak in eicon debug code
  o Fix NULL derefence in OSS MAUI driver
  o Fix leak in PNP interface code
  o Remove pointless code from ALSA emu10k1 midi driver
  o Clean up failure path in DAC960
  o Remove pointless check in zlib
  o Fix NULL dereference in OSS v_midi driver
  o Fix another PNP leak
  o Fix leaks in ISOFS
  o Fix potential leaks in pc300_tty driver
  o Fix leak in atmel wireless driver
  o Fix leak in ISAPNP core
  o More PNP leaks
  o Check find_vma return code in make_pages_present()
  o Fix warning in pc300_tty driver
  o 3c527 possible oops
  o wavelan uninitalised var
  o [AX25]: Fix digipeat leak
  o [PACKET]: Fix deref before NULL check in packet_release()
  o ext3 dreference of sb preceeds check
  o Remove bogus memset from cpqfc driver
  o hpt366 ptr use before NULL check

Dave Kleikamp:
  o JFS: disk quota support
  o JFS: Trivial: remove dead code
  o JFS: fix memory leak in __invalidate_metapages

David Brownell:
  o USB: gadget drivers learn about LH7A40x
  o USB OTG: add usb_bus_start_enum() (1/5)
  o USB OTG: ohci reset updates (2/5)
  o USB OTG: usbcore enumeration (3/5)
  o USB OTG:  gadget zero (4/5)
  o USB OTG: doc updates (5/5)
  o USB: ohci_omap updates
  o USB: isp1301_omap driver (OTG core)
  o USB: add lh7a40x_udc driver
  o USB: add omap_udc driver
  o USB: ethernet gadget, minor fixes
  o USB: gadgetfs minor updates
  o [ARM PATCH] 2060/1: make /proc/cpuinfo report missing EDSP and Java
    support

David Gibson:
  o ppc64: clean up unused macro
  o ppc64: pin the kernel stack's SLB entry
  o ppc64: fix declaration order in asm-ppc64/tlb.h
  o ppc64: handle SLB misses in realmode

David Howells:
  o Fix a NULL pointer bug in do_generic_file_read()

David Mosberger:
  o signal-race-fix: ia64
  o [IA64] irq.c: Kill warning about variables which are unused in UP
    kernels

David S. Miller:
  o [TIGON3]: Mention that firmware is copyrighted by Broadcom
  o [TG3]: Revamp fibre PHY handling
  o [TG3]: Remove autoneg handling from fibre_autoneg() unneeded
  o [TG3]: Always set MAC_EVENT_LNKSTATE_CHANGED even when serdes
    polling
  o Cset exclude:
    davem@nuts.davemloft.net|ChangeSet|20040817010613|52352
  o [TG3]: Do tg3_netif_start() under lock
  o [TG3]: Disable CIOBE split, as per Broadcom's driver
  o [SPARC64]: Save/restore %asi properly in signal handling
  o signal handling race fixes: sparc and sparc64
  o [SPARC64]: Update defconfig
  o [SPARC64]: Use force_{sig,sigsegv}() in sparc signal handling
  o [SPARC64]: Hack fix, force DTR/RTS on in sunsab console
  o [SPARC64]: Fix direct f_pos fiddling in openpromfs
  o [SPARC64]: Add .type and .size directives to some asm files
  o [SPARC64]: Fix some tabbing in xor.S
  o [SUNSAB]: Remove CRTSCTS handling in set_termios
  o [SPARC64]: Sign extend correct args of sys_syslog()
  o [SPARC64]: Fix copyarea bug and set default flags in ffb driver
  o [SPARC64]: Speed up ffb font rendering
  o [UACCESS]: Fix typo in generic __get_user_unaligned()
  o [SPARC64]: Fix delay with HZ==1000
  o [MAINTAINERS]: Update my email contact info
  o [AMD7930]: Fix kcalloc() args
  o [SPARC64]: Update defconfig
  o [CREDITS]: Update my entry
  o [TG3]: Add 5750 A3 workaround
  o [TG3]: Add capacitive coupling support
  o [TG3]: Fix clock control programming on 5705/5750
  o [TG3]: Update driver version and reldate
  o [IPV4]: Push ip_append_data() frag bug fix into ip_append_page()
  o [SPARC64]: SA_SAMPLE_RANDOMNESS fix
  o [SPARC]: Add sys_waitid support
  o [SPARC64]: Fix set_utsname returning with uts semaphore held
  o [SPARC64]: Zap pci_controller_lock
  o [SPARC64]: Kill unused 'flags' in pci_sabre.c
  o [SPARC64]: Add sparc64die_chain as on x86{,_64}
  o [KPROBES]: Pass integer addresses, not pointers, to
    flush_icache_range()
  o [SPARC64]: Initial KPROBES implementation
  o [SPARC64]: Update defconfig
  o [NET]: Free neigh_parms using RCU to fix
    neigh_create/inetdev_destroy race
  o [PKT_SCHED]: Kill bogus spaces in Kconfig strings
  o [SPARC64]: Update defconfig
  o [PKT_SCHED]: Fixed missed return in tcf_hash_init()
  o [SPARC64]: Fix spinlock macros
  o [TCP]: Make TSO play nice with congestion window
  o [TCP]: Calculate SKB tso factor more accurately
  o [TCP]: Make sure SKB tso factor is setup early enough
  o [NET]: Kill SCM_CONNECT, never used and unreferenced
  o [VLAN]: Fix thinko in RCU locking
  o [TCP]: Do not export tcp_transmit_skb()
  o [TCP]: Fix tcp_set_skb_tso_factor() calcs
  o [NET]: Calculate RTATTR_MAX at run time
  o [SUNGEM]: Use dev_kfree_skb_irq() for TX
  o [TCP]: Fix packet counting in tcp_fragment()
  o [TCP]: Fix packet counting when fragmenting already sent packets
  o [TCP]: Fix packet counting during retransmission
  o [SPARC64]: Use time interpolators
  o [SPARC64]: Kill insn scheduling comments from etrap.S
  o [TCP]: Fix {lost,left}_out accounting in tcp_fragment()
  o [NET]: Kill netdev->last_stats
  o [TG3]: Need tx_lock in tg3_set_rx_mode()
  o Merge conflicts with Linus's sparse ioremap() work
  o [SK98LIN]: Kill dangling netdev->last_stats reference
  o [TCP]: Fix fack_count handling in tcp_sacktag_write_queue()

David Woodhouse:
  o [NET]: Fix compat layer setsockopt overzealous conversions

Dean Nelson:
  o [IA64] allow OEM written modules to make calls to ia64 OEM SAL
    functions

Dean Roe:
  o [IA64-SGI] report coherence id in /proc/sgi_sn/coherence_id

Dean Roehrich:
  o [XFS] Change DMAPI dm_punch_hole to punch holes, rather than just
    truncate files.

Deepak Saxena:
  o [ADD] Add pci=firmware command line option
  o [ARM] Switch CPU to BE mode before uncompressing when running BE
  o [ARM] Add IXP2000 support to arch/arm/Makefile & Kconfig
  o [ARM] Add IXP2000 support to arch/arm/kernel
  o [ARM] Add IXP2000 CPU support to arch/arm/mm
  o [ARM]  Add IXP2000 support to arch/arm/boot
  o [ARM] Add IXP2000 platform implementation (arch/arm/mach-ixp2000)
  o [ARM] Add IXP2000 header files (include/asm-arm/arch-ixp2000)
  o [ARM] Add IXP2000 documentation
  o [ARM] IXP2000 cleanups to get code upstream
  o [ARM] Remove support for XScale BDI2000
  o Add IXDP2x01 board support to CS89x0 driver
  o [ARM] Some minor ixdp2x01 fixes
  o [ARM] More minor IXP2000 cleanups

Diego Calleja García:
  o ext3 documentation

Dimitri Sivanich:
  o sched: isolated sched domains

Dmitry Torokhov:
  o kobject: fix kobject_set_name comment

Dominik Brodowski:
  o [CPUFREQ] Remove duplicate information brought in with the new
    governor

Douglas Gilbert:
  o scsi_level constants in scsi.h
  o scsi_mid_low_api.txt update

Eric Dean Moore:
  o MPT Fusion driver 3.01.10 update
  o fix dma mapping leak in fusion

Eric Lemoine:
  o [NET]: Allow get/set of dev->weight via netlink
  o [SUNGEM]: Add NAPI support

Eric W. Biederman:
  o fix 4K ext2fs support in 2.6 initrd's

Felipe Alfaro Solana:
  o [NETFILTER]: Missing netfilter_ipv4.c include in conntrack proto
    code

Frank Pavlic:
  o s390: lcs network driver

François Romieu:
  o ipr: minor fixes and assorted nit
  o via-velocity: more inetaddr_notifier fix
  o via-velocity: wrong module name in Kconfig documentation
  o 8139too: Rx fifo/overflow recovery
  o 8139too: be sure to progress during rtl8139_rx()
  o pci-driver: function documentation fix

Geert Uytterhoeven:
  o Convert in-kernel users of EXPORT_SYMBOL_NOVERS() to 
    EXPORT_SYMBOL()

Gerd Knorr:
  o v4l/bttv: add sanity check (bug #3309)
  o v4l: i2c cleanups
  o v4l: i2c tuner modules update
  o v4l: bttv driver update
  o v4l: saa7134 driver update

Greg Edwards:
  o [IA64] ia32_support.c: Check whether page_alloc failed

Greg Kroah-Hartman:
  o KREF: shrink the size of struct kref down to just a single atomic_t
  o KREF: fix up the current kref users for the changed api
  o KREF: make kref_get() return void as it makes sense to do so
  o USB: fix bad value in kaweth.c driver
  o USB: Remove struct urb->timeout as it does not work
  o USB: rip the pwc decompressor hooks out of the kernel, as they are
    a GPL violation
  o kobject: convert struct kobject use kref
  o USB: rip out the whole pwc driver as the author wishes to have done

Guennadi Liakhovetski:
  o tmscsim: kernel bugzilla bug #2139
  o tmscsim: MAINTAINERS
  o SCSI tmscsim.c: fix inline compile errors
  o tmscsim: (CH) Fix error handling
  o tmscsim: remove unused / redundant bios_param

Guillaume Thouvenin:
  o watchdog: fix warning "defined but not used"

H. Peter Anvin:
  o Make i386 signal delivery work with -mregparm

Harald Welte:
  o [NETFILTER]: Fix ip_nat_find_helper() locking
  o [NETFILTER]: Add some missing help entries
  o [NETFILTER]: Sort Kconfig entries into reasonable order
  o [IPV4]: Use nf_reset() in parp_redo()
  o [CREDITS]: Update netfilter entries

Haren Myneni:
  o ppc64: implement page_is_ram

Heiko Carstens:
  o s390: zfcp host adapter

Herbert Xu:
  o [IPSEC]: Set TTL from route
  o [NET]: Use pskb_expand_head() instead of skb_copy() in
    skb_checksum_help()
  o [IPV4/IPV6]: Fixup checksums properly when fragmenting
  o [IPV4/IPV6]: Use csum_sub() instead of csum_block_sub() w/zero 3rd
    arg
  o [NET]: Add reference counting to neigh_parms
  o [NET]: Fully plug netigh_create/inetdev_destroy race
  o [IPV4/IPV6]: Update ECN handling
  o [IPV4]: Simplify IP_ECN_set_ce
  o [IPSEC]: Fix ECN encapsulation on ipv6
  o [IPV6]: Handle ECN correctly in ip6ip6 tunnels
  o [IPSEC]: Find larval SAs by sequence number
  o [IPCOMP]: Use per-cpu buffers for compression/decompression

Hideaki Yoshifuji:
  o [IPV6]: Fix device handling in ip6_route_add()
  o [IPSEC]: Add SCTP to xfrm_flowi_{sport,dport}()
  o [NETFILTER]: Remove unused file
  o [IPV4/IPV6]: Fix fragment creation
  o [IPV4/IPV6]: More fragment handling improvements
  o [NETFILTER]: Fix build with SYSCTL=n
  o [IPV6]: Fix oops in rt6_device_match()

Hidetoshi Seto:
  o [IA64] floating point regs are not 16-byte aligned inside SAL error
    record

Hirofumi Ogawa:
  o FAT: document fix/update
  o NLS: nls_cp932 fix

Hugh Dickins:
  o i386 virtual memory layout rework
  o rmaplock: PageAnon in mapping
  o rmaplock: kill page_map_lock
  o rmaplock: SLAB_DESTROY_BY_RCU
  o rmaplock: mm lock ordering
  o rmaplock: swapoff use anon_vma
  o clarify get_task_mm (mmgrab)
  o simple fs stop -ve dentries
  o tmpfs atomicity fix

Ian Campbell:
  o MTD: Additional JEDEC device types
  o [ARM PATCH] 2088/2:  set_irq_type takes the IRQ number not the GPIO

Ian Wienand:
  o [IA64] Remove extraneous MMU_TRACE debugging macros
  o [IA64] VIRTUAL_MEM_MAP can be set when DISCONTIGMEM isn't; handle
    it
  o kbuild: Support LOCALVERSION

Ingo Molnar:
  o sched: fix timeslice calculations for HZ=1000
  o sched: cleanup, improve sched <=> fork APIs
  o sched: misc cleanups #2
  o sched: make rt_task unlikely
  o sched: sched misc changes
  o sched: fork hotplug hanling cleanup
  o scheduler statistics
  o sched: whitespace cleanups
  o sched: nonlinear timeslices
  o sched: new task fix
  o permit sleeping in release_task()
  o sched: self-reaping atomicity fix
  o sched: smt fixes
  o Add a few might_sleep() checks
  o ia32: tsc synchronisation cleanup

Ivan Kokshaysky:
  o Alpha: generic dma mapping

J. A. Magallon:
  o fix aic driver build for db4

Jacek Poplawski:
  o stv0299 device naming fix

Jack Steiner:
  o [IA64-SGI] The SN2 fakeprom directories/files should be deleted

Jamal Hadi Salim:
  o [PPP]: Fix assertion trigger with NET_CLS_ACT
  o [ETH]: Zap NET_CLS_ACT ifdef
  o [PKT_SCHED]: Add gact generic actions
  o [PKT_SCHED]: Fix gact compile warnings
  o [NET]: Use NETDEV_TX_* macros instead of magic numbers

James Bottomley:
  o Add dma_declare_coherent_memory() API
  o Add memory region bitmap implementations
  o Add vmalloc alignment constraints
  o Add x86 implementation of dma_declare_coherent_memory
  o Convert NCR_Q720 to use dma_declare_coherent_memory
  o Fix incorrect prototype in the dma_declare_coherent_memory API
  o Fix bug in __get_vm_area() alignment code
  o Fix region sizing problem in dma_mark_declared_memory_occupied()
  o dma_alloc_coherent() still needs to support a NULL device
  o lib/bitmap.c: fix incorrect use of BITS_TO_LONGS()
  o MPT Fusion driver 3.01.15 update
  o Fix the new megaraid compat code to work on all 64 bit systems
  o get the kernel to warn about deprecated SCSI ioctls
  o fix for Domain Validation hang on some devices with sym_2
  o Add accessor functons for scsi_device 56 byte inquiry data
  o fix sym2 negotiation
  o Add internal API to remove reliance on deprecated
    SCSI_IOCTL_TEST_UNIT_READY

James Courtier-Dutton:
  o emu10k1 maintainer update

James Morris:
  o libfs: move transaction file ops into libfs
  o Reduce SELinux kernel memory use on 64-bit systems

Jan Glauber:
  o s390: core changes

Jan Harkes:
  o coda: fix ifdefs for CONFIG_CODA_FS_OLD_API
  o coda: add sendfile wrapper
  o Coda - fix sparse warnings

Jaroslav Kysela:
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA
    sequencer,ALSA<-OSS sequencer export snd_seq_set_queue_tempo() for
    OSS to prevent calling snd_seq_kernel_client_ctl() (using
    copy_from_user()) in interrupt context
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ATIIXP driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ICE1712 driver,ICE1724 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
    fixed sleep while atomic in the trigger callback.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PARISC Harmony
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
    fixed the compile warnings due to the last change.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
    added 'Clock Mode' control to choose the clock source.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1724 driver avoid
    to change the AC97 rate registers.  this seems conflicting with the
    rate conversion on VT172x.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> Wavefront
    drivers fix possible buffer overflow in
    wavefront_download_firmware()
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver added
    the DXS entry for Mitac/Vobis/Yakumo laptop.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    added ac97_can_spdif() for checking the SPDIF support.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    For Gateway M675 notebook - this will direct mixer
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PARISC Harmony
    driver fixed typos.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    Avoid warning message during codec probing in case SKIP_AUDIO flag
    is not set.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core Fixed
    warnings for pci PM callbacks when not CONFIG_PCI
  o ALSA 1.0.5
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    Fixed mutex deadlocks.
  o ALSA CVS update Documentation Added snd-fm801 tuner parameter
    description
  o ALSA CVS update ICE1724 driver SPDIF output fixes
  o ALSA CVS update ATIIXP driver,VIA82xx driver Added the missing
    RESUME info bits to pcm.
  o ALSA CVS update Intel8x0 driver Added the PCI ID for nVidia CK8.
  o ALSA CVS update PCM Midlevel,ALSA<-OSS emulation Clean up and
    optimization of PCM format-specific functions.
  o ALSA CVS update USB generic driver Quattro USB: handle the
    different endianness of playback and recording sample data
  o ALSA CVS update Opti9xx drivers Fixed spin deadlocks.
  o ALSA CVS update OPL4 add newline at end of file
  o ALSA CVS update OSS sequencer emulation
  o ALSA CVS update CS46xx driver,MIXART driver reduce stack usage
  o ALSA CVS update PCM Midlevel Removed the obsoleted init for boot
    parameters.
  o ALSA CVS update ES1968 driver Fix the crash at unloading the module
    due to the shared interrupt with other devices.
  o ALSA CVS update Generic drivers Do the buffer allocation in
    hw_params callback instead of open callback.
  o ALSA CVS update PCM Midlevel,ES1968 driver,EMU10K1/EMU10K2
    driver,KORG1212 driver Trident driver Clean up the buffer
    management in the PCM runtime record.
  o ALSA CVS update Intel8x0 driver Fixed the calculation of the
    current DMA position on some sloppy devices.
  o ALSA CVS update VIA82xx driver Fixed the calculation of the current
    DMA position at the period boundary.
  o ALSA CVS update USB generic driver handle devices that allow
    setting but not reading sample rate
  o ALSA CVS update PCM Midlevel,ALSA Core,RME32 driver,RME96
    driver,NM256 driver
  o ALSA CVS update EMU10K1/EMU10K2 driver Merge EFX playback and
    capture streams to the single device (hw:0,2).
  o ALSA CVS update au88x0 driver
  o ALSA CVS update PCM Midlevel,ALSA<-OSS emulation,CMIPCI driver
    reduce stack usage
  o ALSA CVS update CMIPCI driver don't sleep in prepare callback
  o ALSA CVS update PCM Midlevel Each of snd_pcm_hw_refine_old_user()
    and snd_pcm_hw_params_old_user() consume 856 bytes of stack and can
    invoke deep calls via the page allocator.
  o ALSA CVS update USB generic driver new functions
    snd_usbmidi_input_stop() and snd_usbmidi_input_start() needed by
    snd-usb-usx2y to be able to use usb_set_interface()
  o ALSA CVS update ALSA sequencer,Instrument layer,ISA,GUS drivers
    Clean up Makefiles for the sequencer stuff using reverse
    selections.
  o This patch introduces a kcalloc() in the kernel that is used to
    replace the ALSA subsystem-specific snd_kcalloc() and
    snd_magic_kcalloc().
  o ALSA CVS update AC97 Codec Core Fixed the detection of STAC9708/11
    surround control.
  o ALSA CVS update EMU10K1/EMU10K2 driver Fix Audigy + FX8010 capture
    (hw:x,2)
  o ALSA CVS update EMU10K1/EMU10K2 driver Audigy 2 ZS - side support
  o ALSA CVS update ICE1712 driver,ICE1724 driver Fixes for
    VT1720/VT1724
  o ALSA CVS update Control Midlevel,ALSA Core,PCM Midlevel,RawMidi
    Midlevel,Timer Midlevel IOCTL32 emulation,ALSA<-OSS emulation,ALSA
    sequencer,Instrument layer ALSA<-OSS sequencer,OPL3,EMU8000
    driver,AC97 Codec Core,au88x0 driver EMU10K1/EMU10K2 driver,ICE1712
    driver,ICE1724 driver,Trident driver Synth,Common EMU synth Removal
    of snd_kcalloc()
  o ALSA CVS update Control Midlevel,ALSA Core,HWDEP Midlevel,PCM
    Midlevel,RawMidi Midlevel Timer Midlevel,IOCTL32
    emulation,ALSA<-OSS emulation,ALSA sequencer Removal and
    replacement of magic memory allocators and casts (core part)
  o ALSA CVS update ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x
    driver,CMIPCI driver CS4281 driver,ENS1370/1+ driver,ES1938
    driver,ES1968 driver FM801 driver,Intel8x0 driver,Intel8x0-modem
    driver,Maestro3 driver RME32 driver,RME96 driver,SonicVibes
    driver,VIA82xx driver AC97 Codec Core,AK4531 codec,ALI5451
    driver,au88x0 driver,CS46xx driver EMU10K1/EMU10K2 driver,ICE1712
    driver,ICE1724 driver,KORG1212 driver MIXART driver,NM256
    driver,RME HDSP driver,RME9652 driver Trident driver,Digigram VX222
    driver,YMFPCI driver Removal and replacement of magic memory
    allocators and casts (pci part)
  o ALSA CVS update ES1688 driver,ALS100 driver,AZT2320 driver,CMI8330
    driver,DT019x driver ES18xx driver,OPL3SA2 driver,Sound Scape
    driver,AD1816A driver AD1848 driver,CS4231 driver,CS4236+
    driver,GUS Library,Opti9xx drivers EMU8000 driver,ES968
    driver,SB16/AWE driver,SB8 driver,SB drivers Wavefront drivers
    Removal and replacement of magic memory allocators and casts (isa
    part)
  o ALSA CVS update Documentation,SA11xx UDA1341 driver,Generic
    drivers,MPU401 UART,OPL3 OPL4,Digigram VX core,I2C cs8427,I2C lib
    core,I2C tea6330t,L3 drivers AK4117 receiver,Serial BUS
    drivers,PARISC Harmony driver Sound Core PDAudioCF driver,Digigram
    VX Pocket driver,PPC AWACS driver PPC Burgundy driver,PPC DACA
    driver,PPC PMAC driver,PPC Tumbler driver SPARC AMD7930
    driver,SPARC cs4231 driver,Common EMU synth USB generic driver
    Removal and replacement of magic memory allocators and casts (other
    parts)
  o ALSA CVS update AC97 Codec Core Fixed STAC9758 output jack
    selection control
  o ALSA CVS update CMIPCI driver Fix the i/o port range of gameport on
    cmipci
  o ALSA CVS update Documentation,PCM Midlevel,RawMidi Midlevel,ALSA
    Core,Timer Midlevel ALSA<-OSS emulation,ALSA sequencer,Instrument
    layer,ALSA<-OSS sequencer Clean up of obsolete MODULE_* stuff (core
    part)
  o ALSA CVS update ALS100 driver,AZT2320 driver,CMI8330 driver,DT019x
    driver,ES18xx driver OPL3SA2 driver,Sound Galaxy driver,Sound Scape
    driver,AD1816A driver AD1848 driver,CS4231 driver,CS4236+
    driver,ES1688 driver GUS Classic driver,GUS Extreme driver,GUS MAX
    driver AMD InterWave driver,Opti9xx drivers,EMU8000 driver,ES968
    driver SB16/AWE driver,SB8 driver,SB drivers,Wavefront drivers
    Clean up of obsolete MODULE_* stuff (isa part)
  o ALSA CVS update ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x
    driver,CMIPCI driver CS4281 driver,ENS1370/1+ driver,ES1938
    driver,ES1968 driver FM801 driver,Intel8x0 driver,Intel8x0-modem
    driver,Maestro3 driver RME32 driver,RME96 driver,SonicVibes
    driver,VIA82xx driver AC97 Codec Core,ALI5451 driver,au88x0
    driver,CS46xx driver EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724
    driver,KORG1212 driver MIXART driver,NM256 driver,RME HDSP
    driver,RME9652 driver Trident driver,Digigram VX222 driver,YMFPCI
    driver Clean up of obsolete MODULE_* stuff (pci part)
  o ALSA CVS update SA11xx UDA1341 driver,Generic drivers,MPU401
    UART,OPL3,OPL4,L3 drivers PARISC Harmony driver,Sound Core
    PDAudioCF driver Digigram VX Pocket driver,PPC PowerMac
    driver,SPARC AMD7930 driver SPARC cs4231 driver,USB generic driver
    Clean up of obsolete MODULE_* stuff (other part)
  o ALSA CVS update NM256 driver Added AC97 CD register to the list of
    allowed registeres.
  o ALSA CVS update ALSA<-OSS sequencer Suppress the error message when
    no device is found.
  o ALSA CVS update AC97 Codec Core Check the validity of registers
    before creating controls.
  o ALSA CVS update CS46xx driver,EMU10K1/EMU10K2 driver,PCM Midlevel
    Clean up of indirect PCM data transfer with helper functions.
  o ALSA CVS update RME32 driver Added the experimental fullduplex
    support.
  o ALSA CVS update PCM Midlevel
  o ALSA CVS update Instrument layer LD      .tmp_vmlinux1
    sound/built-in.o(.text+0xfb4ae): In function
    nd_gus_synth_new_device':
  o ALSA CVS update EMU10K1/EMU10K2 driver Clean up the invalid
    (commented out) lines for emu10k1x.
  o ALSA CVS update PCM Midlevel,RME32 driver
  o ALSA CVS update ES1938 driver
  o ALSA CVS update au88x0 driver
  o ALSA CVS update Intel8x0 driver set msbits for 20-bit sample format
  o ALSA CVS update OPL4 reorganize locking;
  o ALSA CVS update Generic drivers,AK4531 codec One space at the end
    of a line is evil.
  o ALSA CVS update USB generic driver remove whitespace at end of
    lines
  o ALSA CVS update PCM Midlevel fix memory leak
  o ALSA CVS update GUS Library,Wavefront drivers reduce stack usage;
    fix buffer overflow
  o ALSA CVS update AMD InterWave driver reduce stack usage; fix ROM
    checksum check
  o ALSA CVS update AC97 Codec Core fix odd comment :)
  o ALSA CVS update USB generic driver allow USB MIDI devices without
    audio control interface
  o ALSA CVS update Documentation,AC97 Codec Core,ATIIXP driver,CS4281
    driver ENS1370/1+ driver,ES1968 driver,FM801 driver,Intel8x0 driver
    Intel8x0-modem driver,Maestro3 driver,VIA82xx driver,ALI5451 driver
    au88x0 driver,CS46xx driver,EMU10K1/EMU10K2 driver,ICE1712 driver
    ICE1724 driver,NM256 driver,Trident driver,YMFPCI driver move AC'97
    bus callbacks into seperate ops record; remove ac97_bus_t template
    requirement from snd_ac97_bus()
  o ALSA CVS update Documentation Removed obsolete sndmagic.h.
  o ALSA CVS update ALSA Core Fixed compile warnings withoug CONFIG_PM.
  o ALSA CVS update Documentation Fixed missing </section>.
  o ALSA CVS update Memalloc module
  o ALSA CVS update CS46xx driver change codec index computation in
    snd_cs46xx_read/write; replace ac97_t template with ac97_template_t
  o ALSA CVS update Documentation,AC97 Codec Core,ATIIXP driver,CS4281
    driver ENS1370/1+ driver,ES1968 driver,FM801 driver,Intel8x0 driver
    Intel8x0-modem driver,Maestro3 driver,VIA82xx driver,ALI5451 driver
    au88x0 driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver
    NM256 driver,Trident driver,YMFPCI driver replace ac97_t template
    with ac97_template_t
  o ALSA CVS update ALSA<-OSS emulation fix missing semaphore release
    in snd_mixer_oss_build_input()
  o ALSA CVS update Documentation fix typo
  o ALSA CVS update RME HDSP driver ALSA rme9652/hdsp: remove inlines
  o ALSA CVS update ATIIXP driver Fixed a typo in the check of
    buffer/period size configuration.
  o ALSA CVS update Documentation,PCI drivers,ATIIXP-modem driver Added
    snd-atiixp driver for ATI IXP AC97 modem controllers.
  o ALSA CVS update Memalloc module Mark the allocated DMA pages as
    reserved for certain architectures.
  o ALSA CVS update Control Midlevel Fixed the unbalanced spinlock in
    the error path.
  o ALSA CVS update Intel8x0-modem driver Added -MODEM suffix to the
    driver name string to distinguish from the intel8x0 audio driver.
  o ALSA CVS update CS46xx driver Fixed a compile warning in the debug
    code.
  o ALSA CVS update Documentation,PCM Midlevel Changed the atomicity of
    PCM prepare callback.
  o ALSA CVS update ALS4000 driver,ATIIXP driver,ATIIXP-modem
    driver,AZT3328 driver BT87x driver,CMIPCI driver,CS4281
    driver,ENS1370/1+ driver ES1968 driver,FM801 driver,Intel8x0
    driver,Maestro3 driver,RME32 driver RME96 driver,SonicVibes
    driver,VIA82xx driver,ALI5451 driver CS46xx driver,EMU10K1/EMU10K2
    driver,ICE1712 driver,ICE1724 driver KORG1212 driver,MIXART
    driver,NM256 driver,RME HDSP driver RME9652 driver,Trident
    driver,YMFPCI driver,PPC PMAC driver USB generic driver Clean up
    spinlocks.
  o ALSA CVS update AC97 Codec Core,Intel8x0 driver,Intel8x0-modem
    driver Fixed the detection of sample rates with no VRA support.
  o ALSA CVS update EMU10K1/EMU10K2 driver Enable low latency EFX
    capture on emu10k1
  o ALSA CVS update VIA82xx driver Added the ac97_quirk entry for ECS
    K7VTA3 v8.0 mobo.
  o ALSA CVS update ALSA sequencer Fixed the bad check on
    copy_from_user() return value
  o ALSA CVS update EMU10K1/EMU10K2 driver Fixed the detection of
    Audigy 2 ZS.
  o ALSA CVS update ALI5451 driver Fixed the suspend/resume.
  o ALSA CVS update EMU10K1/EMU10K2 driver,Trident driver,ALS4000
    driver,ATIIXP driver ATIIXP-modem driver,AZT3328 driver,BT87x
    driver,CMIPCI driver CS4281 driver,ENS1370/1+ driver,ES1938
    driver,ES1968 driver FM801 driver,Intel8x0 driver,Intel8x0-modem
    driver,Maestro3 driver RME32 driver,RME96 driver,SonicVibes
    driver,VIA82xx driver ALI5451 driver,ICE1712 driver,ICE1724
    driver,KORG1212 driver MIXART driver,RME HDSP driver,RME9652
    driver,Digigram VX222 driver Clean up the PCI resource allocation.
  o ALSA CVS update Documentation Changed the description of PCI
    resource allocation to use pci_request_regions().
  o ALSA CVS update ALSA Core,ATIIXP driver,ATIIXP-modem
    driver,Intel8x0 driver VIA82xx driver Clean up the suspend/resume:
    save/restore of pci state
  o ALSA CVS update ALI5451 driver Added the missing
    snd_power_change_state() in the resume callback.
  o ALSA CVS update Documentation,SA11xx UDA1341 driver,PCM
    Midlevel,IOCTL32 emulation ALSA<-OSS emulation,Generic drivers,I2C
    cs8427,I2C tea6330t,L3 drivers OPL3SA2 driver,AD1816A driver,CS4231
    driver,CS4236+ driver ES1688 driver,GUS Library,AMD InterWave
    driver,Opti9xx drivers EMU8000 driver,PARISC Harmony driver,AZT3328
    driver,CMIPCI driver CS4281 driver,FM801 driver,Intel8x0
    driver,Maestro3 driver,RME32 driver RME96 driver,SonicVibes
    driver,AK4531 codec,CS46xx driver ICE1712 driver,KORG1212
    driver,NM256 driver,RME HDSP driver RME9652 driver,YMFPCI
    driver,PPC AWACS driver,PPC Burgundy driver PPC DACA driver,SPARC
    AMD7930 driver,SPARC cs4231 driver Common EMU synth use
    ARRAY_SIZE() instead of sizeof() computations
  o ALSA CVS update BT87x driver use exact values of analog clock rate
  o ALSA CVS update PPC The alsa driver for powermacs requires i2c
    support.
  o ALSA CVS update ALSA Core use list_for_each() in core/memory.c
  o ALSA CVS update PPC PMAC driver Fixed typo.
  o ALSA CVS update PPC PowerMac driver Fixed typo.
  o ALSA CVS update ALSA Core,MIXART driver Removed the obsolete
    NONATOMIC_OPS flag.
  o ALSA CVS update ICE1712 driver Added master volume control.
  o ALSA CVS update ALSA Core Added unlikely() to the debug check
    macros.
  o ALSA CVS update ALSA Core Clean up: removed ifdefs and obsolete
    codes.
  o ALSA CVS update Control Midlevel,HWDEP Midlevel,ALSA Core,PCM
    Midlevel,RawMidi Midlevel Timer Midlevel,ALSA<-OSS emulation,ALSA
    sequencer,ALSA<-OSS sequencer Unlock BKL in ioctl callback to avoid
    the long preempt-disabling.
  o ALSA CVS update PCM Midlevel Fixed/improved XRUN detection
  o ALSA CVS update PCM Midlevel Notify PCM buffer overrun of the
    intermidate buffer on capture.
  o ALSA CVS update RME32 driver Fixed the fullduplex mode.
  o ALSA CVS update RME32 driver Fixed the address mask to get the
    correct DMA pointer value.
  o ALSA CVS update ICE1712 driver Added the (experimental) support of
    Terratec Phase 88.
  o ALSA CVS update VIA82xx driver Fixed the check of invalid DMA
    position.
  o ALSA CVS update ALSA<-OSS emulation Fixed a typo in the last
    change, resulting in the infinite loop.
  o ALSA CVS update ICE1712 driver,ICE1724 driver Added the support of
    Pontis MS300 to snd-ice1724 driver.
  o ALSA CVS update VIA82xx driver Added the quirk entry for ECS L7VMM2
    uATX.
  o ALSA CVS update Intel8x0 driver Added the support of nVidia CK804.
  o ALSA CVS update Intel8x0 driver Added the support of MCP04.
  o ALSA CVS update AC97 Codec Core,ATIIXP driver,ATIIXP-modem
    driver,Intel8x0 driver Intel8x0-modem driver Fixed the reset
    problem of shared audio/modem drivers.
  o ALSA CVS update Memalloc module,PCM Midlevel,CS46xx
    driver,EMU10K1/EMU10K2 driver ALSA Core,YMFPCI driver,Sound Scape
    driver,ATIIXP driver ATIIXP-modem driver,BT87x driver,ENS1370/1+
    driver,ES1968 driver Intel8x0 driver,Intel8x0-modem driver,VIA82xx
    driver,KORG1212 driver MIXART driver,RME HDSP driver,RME9652
    driver,Trident driver Clean up DMA buffer allocation routines.
  o ALSA CVS update PARISC Harmony driver Clean up DMA buffer
    allocation routines.
  o ALSA CVS update PCI drivers,Intel8x0-modem driver Added the support
    of Nvidia modem.
  o ALSA CVS update Intel8x0 driver Fixed the handling of unknown irqs
    on ICH5.
  o ALSA CVS update Intel8x0 driver Added an ac97 quirk for ICH/AD1885
    mobo.
  o ALSA CVS update ICE1712 driver Added the support of ZNF3-250
    (supposed to be ZNF3-150 compatible).
  o ALSA CVS update IOCTL32 emulation Added the wrapper for sync_ptr
    and hwsync ioctls.
  o ALSA CVS update PPC,PPC AWACS driver,PPC Beep,PPC PMAC driver,PPC
    PowerMac driver Added the PCM beep support.
  o ALSA CVS update PPC PMAC driver pmac also apply the DMA stop work
    around to fix capture on iBook2
  o ALSA CVS update PPC PMAC driver Bailed a long delay out of the
    spin_lock_irq.
  o ALSA patch Removed duplicate CK804_AUDIO from intel8x0.c
  o ALSA CVS update VIA82xx driver Added the DXS whitelist entry for
    Acer Inspire 1353LM.
  o ALSA CVS update Documentation,USB,USB generic driver,USB USX2Y
    Added snd-usb-usx2y driver for Tascam US-122/224/428 support.
  o ALSA CVS update Documentation,Intel8x0 driver Added buggy_irq
    module parameter to intel8x0 driver.
  o ALSA CVS update USB generic driver fix email address and license
  o ALSA CVS update au88x0 driver Cleanup the private_data
    initialization
  o ALSA misc
  o ALSA CVS update PPC PMAC driver Removed non-functional 48kHz
    support from pmac driver.
  o ALSA CVS update SoundFont,Common EMU synth Fixed messy locks in
    soundfont support code.
  o ALSA CVS update PCI drivers,Intel8x0-modem driver Added the support
    of SIS7013 modem.
  o ALSA CVS update EMU10K1/EMU10K2 driver,KORG1212 driver Fixed the
    compile warnings on 64bit architectures.
  o ALSA CVS update USB USX2Y fix compilation on 2.2.x kernels
  o ALSA CVS update au88x0 driver Fixed asXtalkGainsAllChan problem for
    the solid kernel build.
  o ALSA CVS update au88x0 driver Cleans up the equalizer code by
    converting some loops to proper for loops and fixes the conditions
    for looping.
  o ALSA CVS update au88x0 driver some other misc eq cleanups
  o ALSA CVS update PCM Midlevel Serialize runtime->status->state
    access
  o ALSA CVS update Intel8x0-modem driver Added SiS, NVidia modem
    descriptions
  o ALSA CVS update AC97 Codec Core Don't use mute bit in REC_GAIN
    register during tests.
  o ALSA CVS update PCM Midlevel Fixed cut-n-paste typo
  o ALSA CVS update AC97 Codec Core Add more timeout to avoid not
    respond messages
  o ALSA CVS update USB generic driver add support for Yamaha CVP-301,
    CVP-303, CVP-305, CVP-307, CVP-309, CVP-309GP, PSR-1500, PSR-3000,
    ELS-01, ELS-01C, PSR-295, PSR-293, DGX-205, DGX-203, DGX-305,
    DGX-505, DGP-7, DGP-5, PM5D, DME64N, DME24N, DTX, UB99
  o version.h
  o ALSA CVS update ALSA sequencer don't fake the sender address in
    messages forwarded by snd-seq-dummy to prevent confusing other
    clients (e.g. snd-seq-oss)
  o ALSA CVS update ALSA<-OSS sequencer remove superfluous
    snd_seq_oss_readq_clear call
  o ALSA CVS update ALSA<-OSS sequencer don't copy uninitialized kernel
    stack data to userspace
  o ALSA CVS update ALSA<-OSS sequencer rewrote
    snd_seq_oss_read/snd_seq_oss_write to fix various buffer
    overflow/locking/nonstandard behaviour bugs
  o ALSA CVS update PPC PMAC driver,PPC Tumbler driver pmac mixer
    update from shadow register on resume and switching DRC on
    headphone plug
  o ALSA CVS update ES1938 driver Added (experimental) PM support.
  o ALSA CVS update EMU10K1/EMU10K2 driver Fix Audigy + AC97 Master
    Volume
  o ALSA CVS update Intel8x0 driver Add to snd-intel8x0 AC97 quirk list
  o ALSA CVS update ICE1712 driver Removed MPU401 detection from Aureon
    and Prodigy boards.
  o ALSA CVS update PPC AWACS driver awacs.c num_controls -> ARRAY_SIZE
    fix
  o ALSA CVS update VIA82xx driver Added the DXS entry for
    Uniwill/Targa Visionary XP-210.
  o ALSA CVS update ICE1712 driver Fixed the master volume control.
  o ALSA CVS update Maestro3 driver Call pci_set_master() in resume (to
    be sure)
  o ALSA CVS update Maestro3 driver Fixed the typo in the last change
    for pci_set_master() call...
  o ALSA CVS update AC97 Codec Core Added jack sense switches for
    AD1885
  o ALSA CVS update MPU401 UART use acpi_register_gsi
  o ALSA CVS update PPC beep support depends on INPUT
  o ALSA CVS update ATIIXP driver add IXP400 support
  o ALSA CVS update RawMidi Midlevel fix handling of EFAULT errors in
    snd_rawmidi_read/write; fix hang when writing to /dev/midi* with
    O_SYNC
  o ALSA CVS update ALSA sequencer remove (now obsolete) support for
    _KERNEL_QUOTE events
  o ALSA CVS update Intel8x0 driver intel8x0: Fixed a long mdelay()
  o ALSA CVS update Intel8x0 driver,Intel8x0-modem driver Fixed resume
    when interrupts are shared with another devices.
  o ALSA CVS update ICE1712 driver Misc fixes for Aureon boards.
  o ALSA CVS update VIA82xx driver Disable legacy FM and SB to prevent
    lock-ups.
  o ALSA CVS update ICE1712 driver Pontis board: Misc fixes
  o ALSA CVS update ICE1724 driver Fixed the internal clock control.
  o ALSA CVS update ATIIXP-modem driver Added workaround for buggy BIOS

Jason Davis:
  o platform update for ES7000
  o ES7000: increase MAX_MP_BUSSES

Jean Delvare:
  o I2C: rename in0_ref to cpu0_vid
  o I2C: update kernel credits/maintainers

Jeff Dike:
  o UML: remove the COW block driver
  o UML updates
  o UML updates
  o UML fixes
  o Make UML build and run

Jeff Garzik:
  o add ssleep(), kill scsi_sleep()
  o [TG3]: Kill all on-chip send BD support code
  o [netdrvr 8139cp,r8169] fix dma_addr_t sizeof test

Jeff Mahoney:
  o reiserfs: xattr/acl fixes
  o Fix access of files up to 4 GB support for ISO9660 filesystems
  o dnotify + autofs may create signal/restart syscall loop

Jeff Moyer:
  o netpoll: kill CONFIG_NETPOLL_RX
  o netpoll: increase NAPI budget
  o netpoll: fix up trapped logic

Jens Axboe:
  o GPCMD_SEND_CUE_SHEET missing in scsi_ioctl
  o reduce aacraid namespace polution
  o fix highmem bouncing leaking pages

Jeremy Higdon:
  o Fix DMA boundary overflow bug

Jesper Juhl:
  o drivers/net/wan/cycx_x25.c:189: warning: conflicting types for
    built-in function 'log2'
  o read_ldt() neglects to check clear_user() return value
  o x86_64: read_ldt() clear_user() return value checking
  o Sort the CREDITS file properly (and add Jesper)

Jesse Barnes:
  o [ACPI] ia64 build fix
  o [IA64-SGI] Assign parent to PCI devices
  o [IA64-SGI] bte.c: kill expression as lvalue warning
  o [IA64] time.c: Downgrade printk of cpu speed to KERN_DEBUG
  o [IA64] cyclone.c: Add includes for build on uni-processor
  o [ACPI] ia64 build fix
  o sched: limit cpuspan of node scheduler domains
  o don't pass mem_map into init functions
  o don't print per-cpu delay loop calibration
  o fix sn_console for CONFIG_SMP=n
  o [IA64] Add include pagemap.h to tlb.h to fix warnings when
    CONFIG_SWAP=n
  o [IA64] generic_defconfig: Enable codepage/iocharset for VFAT
    filesystems
  o fix show_mem on discontig machines
  o fix sysrq support in sn_console.c
  o [IA64-SGI] sn2_defconfig: Enable preempt, CPU hotplug, ext2 and IDE

Joanne Dow:
  o Amiga partition reading fix

Joe Korty:
  o Fix double reset in aic7xxx driver

John Levon:
  o [IA64] support for IA64 hardware performance counters via the
    perfmon interface
  o improve OProfile on many-way systems

John Rose:
  o PCI Hotplug: create pci_remove_bus()

John Stultz:
  o fix target_cpus() for summit subarch

Jonathan Corbet:
  o Remove struct bus_type->add()

Joseph Fannin:
  o ppc build fix

Josh Aas:
  o improve speed of freeing bootmem
  o Reduce bkl usage in do_coredump

Joshua Kwan:
  o export more symbols on sparc32

Julian Anastasov:
  o [IPVS]: Do not use skb_checksum_help(), create and use
    nf_reset_debug()

Kazunori Miyazawa:
  o [IPV6] XFRM: extract xfrm_lookup() from ip6_dst_lookup() to support
    source routing appropriately

Keith Owens:
  o kbuild: Add 'make namespacecheck'
  o kbuild: Updates to namespacecheck.pl

Keith Whitwell:
  o Add new i915 driver from Tungsten Graphics Inc. This driver covers
    the i830 chipsets also, a new X 2D + 3D driver are needed to use
    this but they have been integrated into at least the X.org tree at
    this point and I think the XFree86 tree. There are probably a few
    cleanups necessary for this driver.

Ken Preslan:
  o Allow cluster-wide flock

Kenn Humborg:
  o AUTOSENSE bug in NCR5380.c

Kenneth W. Chen:
  o [IA64] head.S: update comments to match code

Kirill Korotaev:
  o [IPV4]: Need to clear nf_debug parp_redo()
  o fixed pidhashing patch
  o Fix do_each_task_pid() loop with 'continue' inside

Koichi KUNITAKE:
  o [IPV6]: Deprecate all-on-link assumption

Krzysztof Halasa:
  o fix for integer overflow in hd6457[02] driver code

Kumar Gala:
  o netdrv gianfar: fix printk output
  o ppc32: refactor common Book-E exception handling macros

Laurent:
  o Problem with SiS900 - Unknown PHY

Lennert Buytenhek:
  o [ARM] Various IXP2000 fixes
  o [ARM] Add support for ENP-2611 platform
  o [ARM PATCH] 2046/1: fix nwfpe for double arithmetic on big-endian
    platforms
  o [ARM PATCH] 2047/1: disable NWFPE_XP on big endian

Linus Torvalds:
  o Use "insert_resource()" to add the PCI resources to the resource
    tree.
  o vt: don't bother doing UTF translation in control states
  o Merge common signal handling fault handling in generic code
  o Revert I2C keywest class fixup
  o Fix "insert_resource()" nesting bug
  o Remove QIC-02 tape from Kconfig
  o Undo UML mis-merge of jiffies initialization
  o Revert "mark pcxx as broken"
  o Annotate sys_wait4() user pointers
  o Allow the compiler to notice "constant" header file
  o Use "ifdef" rather than "if" to test for __KERNEL__
  o The coverity source checker is wrong. Revert some of the "leak
    fixes"
  o Remove extra tests from get_user_cpu_mask()
  o ppc64: move C declaration in ptrace.h into "ifndef __ASSEMBLY__"
  o x86-64: tell sparse we're a 64-bit platform
  o Fix up UDF merge error
  o Add sparse "__iomem" infrastructure to check PCI address usage
  o Fix up some of the basic x86 offenders on __iomem usage
  o acpi: annotate PCI memory accesses
  o agp: annotate intel agp PCI memory accesses
  o drm: annotate basic PCI memory access functions
  o ide: initial PCI memory access annotations
  o tg3: annotate PCI memory accesses
  o fbcon: initial PCI memory access annotations
  o misc: pci memory access annotations
  o ppc64: PCI memory annotation infrastructure
  o ide: avoid PCI iomem warning in pmac.c
  o sungem: PCI memory annotations
  o ohci1394: PCI memory annotation
  o olympic: tokenring driver PCI memory annotation
  o libata: initial PCI memory annotations
  o Fix off-by-one bug in page cache reading
  o cifs: fix missing semicolon
  o Stricter PCI IO space type checking uncovered a bug in sx8 driver
  o annotate HPET driver memory-mapped PCI usage
  o Annotate pc300 wan driver PCI memory accesses
  o memcpy_toio() shouldn't complain about a const source
  o Fix up and annotate MTD map usage of PCI memory access
  o ppc: make IDE memory-mapped PCI routines match new reality
  o Linux 2.6.9-rc2

Luca Risolia:
  o USB: SN9C10[12] driver update
  o Disable colour conversion in the CPiA Video Camera driver

Luiz Capitulino:
  o kernel/fork.c add missing unlikely()
  o fix drivers/net/cs89x0.c warning

Manfred Spraul:
  o remove magic +1 from shm segment count
  o fix media detection for nForce 2 nics
  o fix f_version optimization for get_tgid_list

Marc Singer:
  o [ARM PATCH] 2072/1: lh7a40x Timer device change

Marcelo Tosatti:
  o x86 bitops.h commentary on instruction reordering
  o small wait_on_page_writeback_range() optimization

Margit Schubert-While:
  o prism54 Bug - Fix frequency reporting

Mark Haverkamp:
  o aacraid reset handler
  o aacraid patch for new device support
  o aacraid driver update

Markus Lidel:
  o i20 rewrite
  o I2O: add functionality to scsi_add_device to preset
  o I2O: remove on-demand allocation of Scsi_Host's in
  o I2O: run linux/i2o.h and linux/i2o-dev.h through
  o I2O: fixes compiler warning on x86_64 in i2o_config
  o I2O: removes multiplexer notification and use
  o i2o maintainer

Martin Schwidefsky:
  o s390: force_sigsegv name clash
  o s390: core changes
  o s390: kernel stack options
  o s390: zfcp host adapater
  o s390: minmax-removal arch/s390/kernel/debug.c
  o s390: packed stack vs. cpu hotplug

Matt Domsch:
  o add MODULE_VERSION to drivers/scsi
  o add MODULE_VERSION to drivers/scsi

Matt Mackall:
  o tiny shmem/tmpfs replacement
  o netpoll: fix unaligned accesses
  o netpoll: revert queue stopped change

Matt Porter:
  o ibm_emac driver updates

Matthew Dharm:
  o USB Storage: help vendors count to 1

Matthew Dobson:
  o sched: consolidate sched domains
  o Create cpu_sibling_map for PPC64

Matthew Wilcox:
  o [IA64] pci.c: assign parent to the ROM resource

Maximilian Attems:
  o remove last suser() call from drivers/char/rocket.c
  o [SPARC64]: Use list_for_each in pci_common.c
  o [SPARC64]: Use list_for_each in pci_sabre.c
  o drivers/char/amiserial.c MIN/MAX removal
  o drivers/char/epca.c MIN/MAX removal
  o drivers/char/esp.c MIN/MAX removal
  o drivers/char/isicom.c MIN/MAX removal
  o drivers/char/mxser.c MIN/MAX removal
  o drivers/char/pcmcia/synclink_cs.c MIN/MAX removal
  o drivers/char/pcxx.c MIN/MAX removal
  o drivers/char/riscom8.c MIN/MAX removal
  o drivers/char/rocket.c MIN/MAX removal
  o drivers/char/rocket_int.h MIN/MAX removal
  o drivers/char/selection.c MIN/MAX removal
  o drivers/char/serial167.c MIN/MAX removal
  o drivers/char/specialix.c MIN/MAX removal
  o drivers/char/synclink.c MIN/MAX removal
  o drivers/char/synclinkmp.c MIN/MAX removal
  o include/linux/isicom.h MIN/MAX removal
  o drivers/tc/zs.c MIN/MAX removal
  o ds1620: replace schedule_timeout() with msleep()
  o dsp56k: replace schedule_timeout() with msleep()
  o ec3104: replace schedule_timeout() with msleep()
  o isicom: replace schedule_timeout() with msleep()
  o nwflash: replace schedule_timeout() with msleep()
  o pcwd: replace schedule_timeout() with msleep()
  o synclink: replace jiffies_from_ms() with msecs_to_jiffies()
  o Add msleep_interruptible() function to kernel/timer.c
  o cdu31a: replace schedule_timeout() with msleep()
  o mcd: replace schedule_timeout() with msleep()
  o radio/radio-maestro: replace schedule_timeout() with msleep()
  o radio/radio-cadet: replace schedule_timeout() with msleep()
  o radio/radio-aimslab: replace while/schedule() with msleep()
  o radio/miropcm20-rds: replace schedule_timeout() with msleep()
  o radio/radio-maxiradio: replace schedule_timeout() with msleep()
  o saa7146_i2c.c: use msleep()
  o radio/radio-sf16fmi: replace schedule_timeout() with msleep()
  o radio/radio-sf16fmr2: replace schedule_timeout() with msleep()
  o message/mptscsih: replace schedule_timeout() with msleep()
  o message/i2o_core: replace schedule_timeout() with msleep()
  o mtd/cfi_cmdset_0001: replace schedule_timeout() with msleep()
  o update parport MAINTAINERS entry
  o [IA64] minmax-removal in simserial.c, unwind.c

Michael Chan:
  o [TG3]: Check MAC_STATUS_SIGNAL_DET in serdes polling

Michal Ludvig:
  o New cpu_has_ flags

Mika Kukkonen:
  o warning fix to include/scsi/scsi_device.h
  o ipr: Sparse warnings fixes
  o Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP

Mikael Pettersson:
  o signal-race fixes for s390
  o ppc signal handling fixes
  o signal-race-fixes: x86-64 support

Mike Anderson:
  o reorder call in scsi_remove_host

Nathan Lynch:
  o move CONFIG_SCHEDSTATS to arch/ppc64/Kconfig.debug
  o ppc64: fix __rw_yield prototype

Nathan Scott:
  o [XFS] Support for default quota limits via the zero dquot (ala
    grace times)
  o [XFS] Ensure maxagi not updated early during growfs, conflicts with
    concurrent inode allocations.  Fix from ASANO Masahiro.
  o [XFS] Fix compiler warnings on IA64 builds in ioctl compat code

Neil Brown:
  o md: assorted fixes/improvemnet to generic md resync code
  o md: assorted minor md/raid1 fixes
  o md: remove most calls to __bdevname from md.c
  o md: RAID10 module
  o Use fixed size buffer instead of kmalloc for m_class in ip_map
  o md: fix problems with checksum handling in MD superblocks
  o md: correct "working_disk" counts for raid5 and raid6
  o knfsd: calls to break_lease in nfsd should be O_NONBLOCKing
  o knfsd: return EACCES instead of ESTALE for certain filehandle
    lookup failures
  o knfsd: fix incorrect indentation in fh_verify
  o knfsd: nfsd4: Support acl_support attribute
  o knfsd: trivial cleanup of nfs4state.c
  o knfsd: nfsd4 could leak a stateid in an error path
  o knfsd: nfsd4: postpone release of stateowner on CLOSE
  o knfsd: nfsd4: store current->tgid instead of lockowner hash in
    fl_pid
  o knfsd: remove redundant initialization in nfsd4_lockt

Nick Orlov:
  o e1000 inlining fix

Nick Piggin:
  o sched: cleanup init_idle()
  o kernel thread idle fix
  o sched: disable balance on clone
  o sched: remove balance on clone
  o vm: writeout watermark tuning
  o vm: alloc_pages watermark fixes
  o fix PID hash sizing
  o use hlist for pid hash
  o use hlist for pid hash: cache friendliness

Nicolas Kaiser:
  o Fix typos in security/security.c

Nicolas Pitre:
  o [ARM PATCH] 2052/2: extra IRQ handling for PXA27x
  o [ARM PATCH] 2053/2: more atomic ops factorization
  o [ARM PATCH] 2064/2: fix some gcc-3.4 warnings
  o [ARM PATCH] 2068/2: fix more gcc-3.4.1 warnings
  o [ARM PATCH] 2069/2: fix compile error with newer gcc
  o [ARM PATCH] 2079/1: make the IOP3xx Implementation Options menu
    conditional on CONFIG_ARCH_IOP3XX
  o [ARM PATCH] 2087/1: fix issues with PXA irq code

Nishanth Aravamudan:
  o scsi/eata_pio: replace schedule_timeout() with msleep()
  o ipr: replace schedule_timeout() with msleep()

Olaf Hering:
  o export legacy pty info via sysfs
  o compat_do_execve() fix
  o remove obsolete htab-reclaim in Documentation/sysctl/kernel.txt
  o remove obsolete zero-paged in Documentation/sysctl/kernel.txt
  o request_region for winbond and smsc parport drivers
  o ppc: remove tmpfile for ppc binutils check
  o fix typos in Documentation/sysctl and
    Documentation/filesystems/proc.txt

Olaf Kirch:
  o /proc/PID/cmdline truncates arguments early
  o [NETFILTER]: Fix pointer deref'ing in ip6t_LOG.c
  o Prevent memory leak in devpts

Oleg Nesterov:
  o /dev/zero vs hugetlb mappings
  o hugetlbfs private mappings

Oliver Neukum:
  o USB: cdc acm patch

Olof Johansson:
  o ppc64: Setup fw_features before init_early calls on pSeries
  o ppc64: Make use of batched IOMMU calls on pSeries LPARs

Pablo Neira:
  o [NETLINK]: Improve behavior

Paolo 'Blaisorblade' Giarrusso:
  o uml: Uml base patch
  o uml: rename console_device
  o uml: Readds (just for now) ghash.h for UML
  o uml: Avoid that gcc breaks UML with "unit at a time" compilation
    mode
  o uml: Fixes an host fd leak caused by hostfs
  o uml: Adds LEGACY_PTY config option
  o uml: Makes "make help ARCH=um" work
  o uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h
  o uml: Kill useless warnings
  o uml: Avoids compile failure when host misses tkill()
  o uml: Reduces code in *_user files, by moving it in _kern files if
    already possible
  o uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly
    panic (EINTR returned by call)
  o uml: Folds hostaudio_user.c into hostaudio_kern.c
  o uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost
  o uml: Adds the "nosysemu" command line parameter to disable SYSEMU
  o uml: Adds /proc/sysemu to toggle SYSEMU usage
  o uml: Fix for sysemu patches
  o uml: Handles correctly errno == EINTR in lots of places
  o uml: Adds some exports
  o uml: Avoids a panic for a legal situation
  o uml: Removes dead code in trap_kern.c
  o uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6
    host
  o uml: little-kmalloc
  o uml: Fix os_process_pc and os_process_parent for corner cases
  o kbuild: Remove last signs of LDFLAGS_BLOB
  o kbuild: Set cflags before including arch Makefile
  o uml: avoid using elv_queue_empty
  o uml: Avoid forcing use of the no-op scheduler
  o uml: Correct the failure path in start_io_thread

Paolo Ornati:
  o tdfx linkage fix
  o tdfxfb linkage fix v2.0 (the previous one is broken)

Patrick McHardy:
  o [NETLINK]: Remove duplicate declarations
  o [NETFILTER]: Flush fragment queue on conntrack unload
  o [NETFILTER]: Fix race when flushing fragment queue
  o [IPV4/IPV6]: Fix suboptimal fragment sizing for last fragment
  o [NETFILTER]: Fix confusing naming in NAT-helpers
  o [NETFILTER]: Fix deadlock condition in conntrack/nat-helpers

Paul E. McKenney:
  o RCU documentation

Paul Fulghum:
  o synclink.c: replace syncppp with genhdlc
  o synclinkmp.c: replace syncppp with genhdlc
  o synclink_cs.c: replace syncppp with genhdlc
  o synclinkmp transmit eom fix
  o synclink.c kernel janitor changes

Paul Jackson:
  o hige2lowuid warning fixes
  o SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM

Paul Mackerras:
  o ppc64: better handling of H_ENTER failures
  o ppc64: signal race fix
  o Update PPC MAINTAINERS & CREDITS
  o ppc64: rework PPC64 cpu map setup
  o ppc64: set platform cpuids later in boot
  o ppc64: allocate irqstacks only for possible cpus
  o ppc64: test for EEH error in PCI Config-Read path
  o ppc64 another log buffer length fix

Pavel Machek:
  o Fix ttyS0 vs. ttyS00 confusion
  o Coding style: do_this(a,b) vs. do_this(a, b)
  o typo in laptop_mode.txt

Pawel Sikora:
  o ipr: Use sector_t type in sector_div call
  o apm_info.disabled fix
  o ix86,x86_64 cpu features

Pete Zaitcev:
  o Make MAX_INIT_ARGS 32
  o USB: ub patch to use add_timer

Peter Buckingham:
  o [IPCONFIG]: Verify DHCPACK packets
  o [IPV4]: Fix DHCPACK checking in ipconfig.c

Peter Jones:
  o [SPARC64]: Support 64-bit initrd addresses

Peter Oberparleiter:
  o s390: sclp driver changes

Petr Vandrovec:
  o nsc-ircc driver crashes on shutdown

Philippe Elie:
  o Fix oops with nmi-watchdog=2

Pierre Ossman:
  o Split timer resources
  o x86-64: split timer resources

Pozsar Balazs:
  o [PKT_SCHED]: Add missing MODULE_LICENSE

Prasanna S. Panchamukhi:
  o i386 exceptions notifier for kprobes
  o kprobes base patch
  o Jumper Probes to provide function arguments

Ram Pai:
  o filemap read() fix

Ramón Rey Vicente:
  o Update ACI MIXER DRIVER webpage
  o Firmware Loader is orphan

Randy Dunlap:
  o fix JAZZ_ESP driver config depends
  o fix imm to build with IMM_DEBUG
  o fd_mcs: fix __setup function
  o NCR53c406a: fix __setup function

Richard Henderson:
  o [ALPHA] Fix raising of ieee exceptions from userland software

Robert Daniels:
  o [ARM] Fix VMALLOC range check in IXP4xx I/O routines

Robert Love:
  o KOBJECT: add kobject_get_path

Roger Luethi:
  o Fix /proc/pid/statm documentation
  o via-rhine: suspend/resume support
  o via-rhine: de-isolate PHY
  o via-rhine: small fixes

Roland Dreier:
  o x86: remove hard-coded numbers from ptr_ok()
  o fix proc_symlink() warning with CONFIG_PROC_FS=n
  o fs/compat.c: rwsem instead of BKL around ioctl32_hash_table

Roland McGrath:
  o fix MT reparenting when thread group leader dies
  o waitid system call
  o fix rusage semantics
  o cleanup ptrace stops and remove notify_parent
  o ptrace userspace API preservation
  o Remove RUSAGE_GROUP
  o i386 syscall tracing of bogus system calls
  o make single-step into signal delivery stop in handler
  o fix task_struct leak in posix-timers
  o Fix PTRACE_CONT after single-step into signal delivery

Ronald Bultje:
  o zr36067 driver - correct i2c-algo-bit dependency in Kconfig
  o zr36067 driver - use msleep() instead of schedule_timeout()
  o zr36067 driver - correct subfrequency carrier

Russell King:
  o [PCMCIA] Fix case of two "skt" variables
  o [PCMCIA] Use struct resource rather than sys_start/sys_stop
  o [PCMCIA] Convert PCI socket drivers to use struct resource
  o [PCMCIA] Don't use sys_start for static-mapped sockets
  o [PCMCIA] Remove pccard_mem_map's sys_start and sys_stop elements
  o [ARM] Correct dma_to_virt()/virt_to_dma() return types
  o [ARM] Move DMA mask-based bounce detection to dmabounce code
  o [ARM] Fix some sparse complaints
  o [ADFS] Fix sparse signed bitfield warning
  o [ARM] signal handling fixes
  o [SERIAL] Factor out "clear fifo" functionality
  o [SERIAL] Move XR16C850 Tx/Rx trigger level setup to startup code
  o [SERIAL] 8250: We can only use the FIFO if fifosize > 1
  o [SERIAL] 8250: Add serial8250_config structure definition
  o [SERIAL] 8250: tell transmit path the data transfer size
  o [SERIAL] 8250: combine UART_CLEAR_FIFO/UART_USE_FIFO into one flag
  o [SERIAL] 8250: serial8250_set_sleep
  o [SERIAL] 8250: add UART_CAP_SLEEP capability
  o [SERIAL] 8250: Rename UART_STARTECH to UART_CAP_EFR
  o [MMC] Use local card pointer rather than md->queue.card
  o [MMC] Remove unused host->priv
  o [MMC] Add host specific block queue parameters
  o [MMC] Give the MMC host the full-sized request
  o [MMC] MMCI: Remove hardcoded MCI_IRQMASK definition
  o [MMC] MMCI: data FSM handling updates
  o [MMC] MMCI: Manipulate IRQ masks according to the data FSM state
  o [MMC] MMCI: split the PIO data read and write paths
  o [MMC] MMCI: Maintain offset rather than buffer pointer for PIO
  o [MMC] MMCI: use bio_kmap_irq() rather than req->buffer
  o [MMC] MMCI: Add SG support to PIO data transfers
  o [MMC] MMCI: Ensure that we read all data from FIFO
  o [MMC] PXAMCI: Bracket power management calls with CONFIG_PM
  o [MMC] MMC_RSP_xxx combined response types
  o [ARM] Move flush_dcache_page
  o [ARM] Optimise __flush_dcache_page calls
  o [ARM] Add cache_is_xxxx() functions for cache type identification
  o [ARM] Fix copy/clear user page functions for VIPT aliasing caches
  o [ARM] Fix/Optimise flush_dcache_page() for VIPT aliasing caches
  o [ARM] Add flush_cache_user_page() for sys_cacheflush()
  o [ARM] Don't include asm/arch/param.h for non-kernel build uses
  o [ARM] Eliminate ARM private __KERNEL_HZ
  o [ARM] Make VIPT alias copypage functions override work

Rusty Russell:
  o Read cpumasks every time when exporting through sysfs
  o Centralize i386 Constants
  o Fix Permissions on module_param Usage
  o Move param section out of init area, for export of built-in module
    params
  o Fix CPU Hotplug: neaten migrate_all_tasks
  o Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug CPU vs TASK_DEAD
  o mostly remove module_parm()
  o Use Name cramfs in Kconfig Message
  o Don't OOPS on stripped modules
  o [NETFILTER]: Fix build error with CONFIG_SYSCTL disabled
  o [NETFILTER]: Fix conntrack seq_file handling

Ryan S. Arnold:
  o HVCS hotplug fixes
  o interrupt driven hvc_console as vio device

Sam Ravnborg:
  o kbuild: fix cc-version
  o kbuild: Fix make O=
  o kbuild: use *.lds infrastructure in arch/i386/kernel
  o kbuild: fix stage 2 of module build
  o bk: Ignore arch/i386/kernel/vsyscall.lds
  o kbuild: Add stactic analyser tools to make help
  o kbuild: Fix modules_install
  o kbuild: Simplify generating vmlinux
  o kbuild: Enable compile after localversion change
  o kbuild: Drop use of built-in.o in top level makefile
  o kbuild: fix make -j N build
  o kbuild: allow arch/$(ARCH)/Makefile to override cmd_vmlinux__
  o kbuild: Move localversion config option to top of menu
  o kbuild/ppc: Fix build of zlib in arch/ppc/boot/lib

Sean Young:
  o USB: USB PhidgetServo driver update

Steffen Thoss:
  o s390: common i/o layer
  o s390: qeth network driver

Stephen D. Smalley:
  o [SELINUX]: Fix bugs introduced by skb_header_pointer() changes
  o SELinux: add null device node to selinuxfs, remove open_devnull
  o SELinux: revalidate access to controlling tty
  o SElinux; defer inode security initialization
  o SELinux: fix name_bind audit

Stephen Hemminger:
  o [NET]: deliver_skb() cleanup
  o [NET]: Another cleanup in netif_receive_skb()
  o [BRIDGE]: Fix oops when mangling and brouting and tcpdumping
    packets
  o [TCP]: Automatically compute tcp_default_win_scale
  o [PKT_SCHED]: Update for netem scheduler
  o [NET]: net_random_init needs to get seed later in boot process
  o [PKT_SCHED]: Distribution table fixes for netem
  o [BRIDGE]: deadlock on device removal
  o [BRIDGE]: The vlan MII ioctl pass through was passing the wrong
    device

Steve French:
  o CIFS: fix 64 bit compiler warning in cifs debug code
  o CIFS: Workaround Samba bug in incorrectly setting extended security
    flag in negotiate response (which caused mounts to fail to Samba
    server which have short, one or two byte, domain names).
  o CIFS: xsymlink support part 1 of 2
  o CIFS: remove deprecated sleep_on_timeout
  o [CIFS] cifs ipv6 support part 2
  o [CIFS] cifs ipv6 part 3
  o [CIFS] misc kmalloc and kernel_thread failure checks
  o [CIFS] Various fixes to bugs pointed out by Stanford checker SWAT
    tool (mostly missing checks on small kmallocs and some
  o [CIFS] Update cifs change log
  o [CIFS] Fix incorrect byte count in unlock SMB
  o [CIFS] fix recent cifs symlink change so as not call kfree on null
    path
  o [CIFS] Fix CIFS symlink regression when long symlink paths

Steven Cole:
  o scripts: Update ver_linux for recent reiserfsprogs

Stéphane Eranian:
  o [IA64] perfmon.c: file descriptor fixes
  o [IA64] palinfo.c: typo s/BEER/BERR/
  o [IA64] perfmon.c: cleanup system-wide context when closed from
    another cpu

Suparna Bhattacharya:
  o AIO: Splice runlist for fairness across io contexts
  o AIO: workqueue context switch reduction

Takashi Iwai:
  o Fix the unnecessary entropy call in the irq handler
  o sparc ALSA fix

Thayne Harbaugh:
  o [netdrvr e1000] disable DITR, which apparently hurts performance

Theodore Y. T'so:
  o dev/random: Fix latency in rekeying sequence number
  o /dev/random: Add pool name to entropy store
  o /dev/random: Use separate entropy store for /dev/urandom
  o /dev/random: Remove RNDGETPOOL ioctl

Thomas Gleixner:
  o ide: sis5513 fix for SiS962 chipset

Thomas Graf:
  o [NET]: Device mtu/txqlen/ifmap via rtnetlink
  o [NET]: Device name changing via rtnetlink
  o [NET]: Fix notification on address change via rtnetlink

Thomas Koeller:
  o Driver Core: fix minor class reference counting issue on the error
    path

Thomas Richter:
  o parport: NetMOS 9805 interface

Thomas Spatzier:
  o s390: lcs multicast deadlock

Thor Kooda:
  o [CRYPTO]: xtea_encrypt() should use XTEA_DELTA instead of TEA_DELTA
  o crypto: tea.c xtea_encrypt should use XTEA_DELTA

Thorsten Knabe:
  o ad1816 sound driver web page and email address

Tim Schmielau:
  o Fix bad URL in BSD acct help entry
  o make oom killer points unsigned long

Timothy Shimmin:
  o [XFS] Fix up header length miscalculation affecting version 1 logs

Tom 'spot' Callaway:
  o Keep sparc32 config consistent
  o Fix typo in bw2.c

Tom Rini:
  o [PPC32] Add a weak version of embed_config()
  o [PPC32] Give PPC8xx a callback into board-specific code in
    m8xx_setup_arch().
  o [PPC32] Add a watchdog driver on PPC8xx
  o PPC32: Rename pq2ads_setup.c to pq2ads.c
  o PPC32: Merge mcpn765_serial.h into mcpn765.h
  o PPC32: Update the Motorola LoPEC support
  o PPC32: Finish cleanup of platforms that just needed _serial.h
    merged
  o PPC32: Update the Motorola MVME5100 support
  o ppc32: Re-work the cpuinfo hooks on MPC82xx
  o ppc32: Small cleanups to the CPM2 PIC code
  o ppc32: Redo the MPC82xx set of call-backs
  o [PPC32] Default to conswitchp=&dummy_con if DUMMY_CONSOLE
  o ppc32: Fix MPC8260 with an initrd and no root=/dev/ram0
  o ppc32: Introduce a have_residual_data macro and switch to it
  o  This allows use of the IBM status LED if it's found in the
    residual data, plus a couple of other bells and whistles.  It
    removes the 140-specific code.
  o ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it
  o ppc32: On PReP, allow for residual data to provide IRQ level/edge
    info
  o ppc32: Use residual data to determine the addr to pass i8259_init()
  o ppc32: Add support for PCIBridgeRS6K to prep_find_bridges()
  o ppc32: Fixup the OpenPIC code for older implementations
  o ppc32: The planar id is only 1 byte, so only display that much
  o ppc32: Correct the output of /proc/interrupts on PReP
  o ppc32: Add a 'noresidual' option, to ignore residual data
  o ppc32: Fix an LSB floating-point test failure
  o ppc32: Make use of cpufeatures in some flush rountines
  o ppc32: Move ppc32-specific sysctls to arch/ppc
  o We weren't including <syslib/m8260_pci.h> from <asm/mpc8260.h>, so
    _IO_BASE was defined to zero instead of isa_io_base.
  o ppc32: Fix a compile error when CONFIG_PREP &&
    !CONFIG_PREP_RESIDUAL
  o ppc32: Fix a typo in cputable.c
  o ppc32: Fix compiling of SBC82xx
  o ppc32: Rework the hooks for serial in the bootwrapper
  o kbuild: Use inttypes.h when stdint.h are not available
  o kbuild: Use getopt_long in genksyms only when available
  o kbuild: Solaris fixes in various kbuild Makfiles's
  o ppc32: fix the 'checkbin' target
  o zlib_inflate: Move zlib_inflateSync & friends
  o zlib_inflate: Make zlib_inflate_trees_fixed(...) generate the table
  o ppc32: Switch arch/ppc/boot to lib/zlib_inflate
  o ppc: switch boot/lib/Makefile to $(addprefix ...) for zlib_inflate

Tony Lindgren:
  o [ARM PATCH] 2040/1: Increase ARM HARDIRQ_BITS to 9, version 2

Tony Luck:
  o SN2 build fix, take two

Torben Mathiasen:
  o LANANA: maintainer update
  o LANANA: devices.txt update

Trond Myklebust:
  o Undo broken FH conversion that broke nfsroot compile
  o NFS: clean up the new symlink code
  o NFS: fix problem of ESTALE errors on NFSv2 symlinks
  o NFSv3: Fix up an unaligned access error in nfs3_proc_unlink_setup()
  o NFS: add an fsync() stub for directories as per 2.4.x

Valdis Kletnieks:
  o #ifdef fixes for drivers/isdn/hifax/*
  o #ifdef cleanup for sh64
  o #ifdef cleanup for cris port
  o #ifdef cleanup for PPC
  o #ifdef cleanups in drivers/net

Vegard Wærp:
  o BeFS: load default nls if none is specified in mount options

Venkatesh Pallipadi:
  o [CPUFREQ] Merge on-demand cpufreq policy governor

Wensong Zhang:
  o [IPVS] fixed to call nf_reset() to reset netfilter related fields
  o [IPVS] add the MAINTAINERS entry

William Lee Irwin III:
  o sched: consolidate init_idle() and fork_by_hand()
  o sched: sparc32 fixes
  o sysctl tunable for flexmmap
  o ia64: dma_mapping fix
  o sched: consolidate CLONE_IDLETASK masking
  o kill CLONE_IDLETASK
  o x86 PAE swapspace expansion
  o hugetlb: permit executable mappings
  o Missing free_area_init_node() conversions
  o alpha signal race fixes
  o schedule profileing
  o consolidate prof_cpu_mask
  o introduce profile_pc()
  o consolidate hit count increments in profile_tick()
  o move profile_operations
  o make private profile state static
  o make prof_buffer atomic_t
  o task_vsize() locking cleanup
  o O(1) proc_pid_statm()
  o fix text reporting in O(1) proc_pid_statm()
  o speed up /proc/pid/statm for !CONFIG_PROC_FS
  o /proc/pid/statm accounting fixes
  o Unaccount VM_DONTCOPY vmas properly
  o WAITQUEUE_DEBUG cleanup
  o fix PA-RISC fork_idle() sweep
  o make topology.h macros safer
  o make bad_page() print all of page->flags
  o fix sched_domains hotplug bootstrap ordering vs. cpu_online_map
    issue
  o scripts: pass %{_smp_mflags} to make(1) in scripts/package/mkspec

Yanmin Zhang:
  o [IA64] Fix boot problems when using "mem=" boot parameter
  o [IA64] contig.c: Function find_bootmap_location has 2 bugs
  o interrupt is enabled before it should be when kernel is booted

Zachary Amsden:
  o i386-unbusy-tss cleanup

Zwane Mwaikambo:
  o OProfile/XScale fixes for PXA270/XScale2
  o fix i386/x86_64 idle routine selection
  o out-of-line locks / generic
  o out-of-line locks / arm
  o out-of-line locks / i386
  o out-of-line locks / x86_64
  o out-of-line locks / ppc32
  o out-of-line locks / ppc64
  o out-of-line locks / sparc64
  o out-of-line locks / other
  o Correct ELF section used for out of line spinlocks
  o Fix i386 SPINLOCK_MAGIC debugging
  o Fix x86_64 SPINLOCK_MAGIC debugging

