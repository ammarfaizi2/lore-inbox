Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUEJC6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUEJC6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUEJC6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:58:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:45254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264484AbUEJC6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:58:15 -0400
Date: Sun, 9 May 2004 19:58:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.6
Message-ID: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there it is (well, the tar-file and patches are still being up-loaded, 
but should be there soon).

NTFS, XFS, FAT and CIFS updates. IDE cache-flush at shutdown fixes. ppc, 
sparc, s390 and ARM updates (and a few x86-64 fixes).

Holler if I missed anything,

		Linus

----

Summary of changes from v2.6.6-rc3 to v2.6.6
============================================

Adam Belay:
  o parport pnp detection fix

Alex Williamson:
  o [SERIAL] 8250_hcdp needs irq sharing

Alexander Viro:
  o Fix might_sleep in /proc/swaps code
  o mcdx.c insanity removal

Andi Kleen:
  o Fix machine check handler on x86-64
  o Fix x86-64 compilation without iommu for 2.6.6rc3

Andrew Morton:
  o acpi build fix setup.c:608: `acpi_skip_timer_override' undeclared
  o cifssmb.c warning fix
  o writeback livelock fix
  o fadvise length handling fix
  o task_struct alignment fix
  o usb linkage fix
  o cancel_delayed_work() fix
  o b44 driver needs mii
  o run populate_rootfs() before initcalls

Andries E. Brouwer:
  o report size of printk buffer

Anton Altaparmakov:
  o NTFS: Use get_bh() instead of manual atomic_inc() in
    fs/ntfs/compress.c
  o NTFS: - Modify fs/ntfs/time.c::ntfs2utc(), get_current_ntfs_time(),
    and utc2ntfs() to work with struct timespec instead of time_t on
    the Linux UTC time side thus preserving the full precision of the
    NTFS time and only loosing up to 99 nano-seconds in the Linux UTC
    time.
  o NTFS: - Remove unused ntfs_dirty_inode()
  o NTFS: Wrap flush_dcache_mft_record_page() in #ifdef NTFS_RW
  o NTFS: Add NInoTestSetFoo() and NInoTestClearFoo() macro magic to
    fs/ntfs/inode.h and use it to declare NInoTest{Set,Clear}Dirty.
  o NTFS: Move typedefs for ntfs_attr and test_t from fs/ntfs/inode.c
    to fs/ntfs/inode.h so they can be used elsewhere.
  o NTFS: Determine the mft mirror size as the number of mirrored mft
    records and store it in ntfs_volume->mftmirr_size
    (fs/ntfs/super.c).
  o NTFS: Load the mft mirror at mount time and compare the mft records
    stored in it to the ones in the mft (fs/ntfs/super.c).
  o NTFS: - Fix compiler warnings related to type casting
  o NTFS: Read the journal ($LogFile) and determine if the volume has
    been shutdown cleanly and force a read-only mount if not
    (fs/ntfs/super.c and fs/ntfs/logfile.c).  This is a little bit of a
    crude check in that we only look at the restart areas and not at
    the actual log records so that there will be a very small number of
    cases where we think that a volume is dirty when in fact it is
    clean.  This should only affect volumes that have not been shutdown
    cleanly and did not have any pending, non-check-pointed i/o.
  o NTFS:  Eeek.  Forgot to revert the Makefile before checking it in
    last time
  o NTFS: 2.1.8 release - If the $LogFile indicates a clean shutdown
    and a read-write (re)mount is requested, empty $LogFile by
    overwriting it with 0xff bytes to ensure that Windows cannot cause
    data corruption by replaying a stale journal after Linux has
    written to the volume.

Arjan van de Ven:
  o ide-disk.c: write cache handling fixes
  o IDE disk cache flush at unopportune momemnts
  o ide: don't send cacheflush to drives that don't understand it

Armin Schindler:
  o ISDN CAPI: fix ncci list semaphore
  o ISDN Eicon driver: accept capidrv parameters
  o ISDN Eicon driver: fix empty queue check
  o ISDN Eicon driver: fix idi cleanup deadlock

Arnd Bergmann:
  o s390: oprofile Kconfig fixes

Bartlomiej Zolnierkiewicz:
  o fix default IDE interfaces initialization for PPC32
  o fixup for C1 Halt Disconnect problem on nForce2 chipsets
  o Suspend IDE disks on shutdown

Ben Collins:
  o [IEEE1394]: Fix deadlock in killing kernel thread

Benjamin Herrenschmidt:
  o ppc/ppc64: Cleanup PPC970 CPU initialization
  o Fix my address in CREDITS
  o ppc32: Add missing [pci_]dma_mapping_error()
  o ppc32: pmac support update
  o ppc64: Fix nasty typo in PTE freeing code
  o [SUNZILOG]: Fix DCD/CTS change tests, just like in pmac_zilog

Bjorn Helgaas:
  o [SERIAL] default to serial console when possible

Chris Wright:
  o fix memleak in sys_mq_timedsend
  o fix queues_count accounting in mqueue_delete_inode()

Christoph Hellwig:
  o [XFS] use kmem_alloc for noaddr buffers
  o [XFS] kill the pagebuf vs xfs_buf confusion
  o [XFS] really kill the pagebuf vs xfs_buf confusion
  o [XFS] clarify pagebuf page lookup logic
  o [XFS] Don't reset buffer offset before using it
  o [XFS] close external blockdevice after final flush
  o fix warning in arch/ppc/boot/simple/misc.c
  o fix WARN_ON on XFS module unload

Clay Haapala:
  o [LIB]: Add CRC32c (Castagnoli, et al Cyclic Redundancy-Check)
  o [LIB]: Use compiler.h's pure attribute macros in crc32.c
  o [CRYPTO]: Provide crc32c as a type of digest
  o [CRYPTO]: Fix typing in crc32c's chksum_update

Coywolf Qi Hunt:
  o Update kerneltraffic link in SubmittingDrivers and kernel-docs.txt

Daniel Ritz:
  o [PCMCIA] add EnE specific initialization to fix HDSP

Dave Kleikamp:
  o JFS: [CHECKER] Fix a possible null-pointer dereference
  o JFS: [CHECKER] Memory leak in jfs_link
  o JFS: [CHECKER] get rid of txAbortCommit

David Gibson:
  o Fix overeager stack-expansion on ppc64
  o POWER5 erratum workaround
  o ppc64: shmget() translation bugfix
  o ppc64: Use slbie, not slbia in hugepage code

David Mosberger:
  o ia64: Fix Exec-Only stack patch so X can work again
  o Cset exclude:
    davidm@tiger.hpl.hp.com|ChangeSet|20040427053149|28511

David S. Miller:
  o [SPARC64]: Fix MAP_FIXED+shared address check, noticed by rmk
  o [SPARC64]: Update defconfig
  o [NET]: Undo marking sock_alloc() as static, still exported to
    modules
  o [SPARC64]: hugetlbpage.c needs linux/module.h

David Stevens:
  o [IPV4]: Use time_after() in override ARP calculation

David Vrabel:
  o [ARM PATCH] 1832/1: Typo in dma_unregister_dev printk

Dean Roehrich:
  o [XFS] Fix dmapi/mprotect interaction
  o [XFS] Remove <linux/mman.h> now that linvfs_mprotect doesn't need
    it

Denis Vlasenko:
  o add missing #include

Dirk Behme:
  o [ARM PATCH] 1835/1: Make ALTERA Excalibur work again in 2.6.5

Eric Sandeen:
  o [XFS] Use pgoff_t for page indices, and remove other type confusion

Eric Wong:
  o logips2pp driver update (MX510/310 support), cleanup

Gerd Knorr:
  o Fix oops in video_register_device

Herbert Xu:
  o [IPV4/IPV6]: Fix listing of listening sockets

Hirofumi Ogawa:
  o FAT: Fix nfsv2 support
  o FAT: small cleanup
  o FAT: remove symbols exports from msdosfs/vfat

Hugh Dickins:
  o mremap offset type
  o mremap pte_unmap NULL
  o add_to_page_cache comments
  o page_mapping race fix

Ingo Molnar:
  o [NET]: Update netpoll credits

Ivan Kokshaysky:
  o Fix rwsem contention case on alpha/s390x

James Morris:
  o [NET]: Add sock_create_kern()
  o [NET]: Add sock_create_lite()

Jeff Garzik:
  o [libata sata_sis] support SATA SCRs in PCI cfg space

Jeremy Higdon:
  o sata_vsc initialization fix

Jon Krueger:
  o [XFS] Correct the (file size >= stripe unit) check inside
    xfs_iomap_write_delay.  It was comparing the file size, in bytes,
    against the stripe unit size, in FSBs. (PV 911469)

Joshua Kwan:
  o [SPARC64]: Use $(CC) in NEW_GCC checks

Karol Kozimor:
  o acpi4asus 0.28 (Karol 'sziwan' Kozimor)

Keith M. Wesolowski:
  o [SPARC32]: Ensure swap entries do not overlap the PRESENT or FILE
    bits
  o [SPARC32]: Correct calculation of num_physpages
  o [SPARC32]: Trivial reformatting patch for arch/sparc/mm/init.c
  o [SPARC32]: Reduce fragmentation in the bitmap allocator

Keith Owens:
  o ia64: SN_SAL_PRINT_ERROR is reentrant

Len Brown:
  o [ACPI] fix x86_64 mis-merge
  o [ACPI] enable 440GX PIRQ router workaround
  o [ACPI] enhance intr-src-override parsing to handle ES7000
    http://bugme.osdl.org/show_bug.cgi?id=2520
  o ACPI] Delete IRQ2 "cascade" in ACPI IOAPIC mode no such concept
    exists in ACPI, frees IRQ2 for use.
  o [ACPI] if acpi_os_name= is used, print what it finds
  o [ACPI] allow IRQ2 to be used in ACPI/IOAPIC mode
    http://bugzilla.kernel.org/show_bug.cgi?id=2564
  o [ACPI] Workaround "_BBN 0" BIOS bug enhance "pci=noacpi" to skip
    ACPI PCI configuration and interrupt config add "acpi=noirq" to
    skip just ACPI interrupt config (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=1662
  o [ACPI] workaround for nForce2 BIOS bug: XT-PIC timer in IOAPIC mode
    "acpi_skip_timer_override" boot parameter dmi_scan for common
    platforms, may be replaced with PCI-ID in future.
  o [ACPI] No IRQ known... - using IRQ 255 (Bjarni Rúnar Einarsson)
    http://bugzilla.kernel.org/show_bug.cgi?id=2148
  o ACPI irq->gsi naming (Bjorn Helgaas)
  o [ACPI] battery "charged" instead of "unknown" (Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=1863
  o [ACPI] pci-link may not always be SHARED (SuSE via Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=2404
  o [ACPI] rmmod ACPI modules vs /proc from Anil S Keshavamurthy and
    David Shaohua Li http://bugzilla.kernel.org/show_bug.cgi?id=2457
  o [ACPI] toshiba_acpi driver if acpi_disabled (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=2465
  o [ACPI] support button driver unload (Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=2281
  o [ACPI] fix build warning in dmi_scan
  o [ACPI] button build fix
  o [ACPI] PCI Interrupt Link fixes Handle BIOS that reference disabled
    PCI Interrupt Link Devices
    http://bugme.osdl.org/show_bug.cgi?id=1581
  o [ACPI] export symbols to button module

Linus Torvalds:
  o Add __user annotations to ppc64 user access functions
  o Tell the sparse checker to use 64-bit mode when checking a ppc64
    tree.
  o Fix fixed fadvice length handling
  o Make types of big integers in bitops.h explicit
  o Be more careful about semaphore contention memory ordering
  o Be more careful about waking up rwsem waiters
  o x86-64: fix preempt race in exit_thread
  o All the Intel LPC bridges have the same PCI quirks
  o Waste less memory in dentries
  o Mark the ACPI CPU throttle and timer IO regions busy
  o Linux 2.6.6

Luiz Capitulino:
  o fix warning in fs/dquot.c

Marc Singer:
  o [ARM PATCH] 1816/1: lh7a40x #2 (1/7) core
  o [ARM PATCH] 1817/1: lh7a40x #2 (2/7) core-include
  o [ARM PATCH] 1818/1: lh7a40x #2 (3/7) doc

Martin Schwidefsky:
  o s390: core s390
  o s390: common i/o layer
  o s390: network driver
  o s390: 3270 console driver
  o s390: zfcp host adapter
  o s390: oprofile for s390

Matt Tolentino:
  o efivars sysfs fix

Meelis Roos:
  o ppc32: compile error in signal.c

Michael Hunold:
  o DVB:Fix adapter module removal bug

Mikael Pettersson:
  o gcc-3.4.0 fixes
  o allow drivers to claim the lapic NMI watchdog HW

Mike Miller:
  o cciss build fix
  o cciss MAINTAINERS update
  o cciss update

Nathan Scott:
  o [XFS] Fix a very hard-to-hit, small-block-size only corruption
  o [XFS] Fix delayed write buffer handling to use the correct list
    interfaces, add validity checks, remove unused code, fix comments.
  o [XFS] Make buffer error checking consistent, add a value range
    check
  o [XFS] Return the right error code on an ACL xattr version mismatch
  o [XFS] Only use page->private to track page state for page cache
    pages
  o [XFS] Fix some cases where we returned fill_super success, instead
  o [XFS] Allow xfsbufd flush intervals to take immediate effect after
    changing the flush sysctl value.  Fix from Bart Samwel
  o [XFS] Use USER_HZ in XFS sysctl interfaces.  Fix from Bart Samwel
  o [XFS] Bump up age_buffer and sync_interval maxima for laptop mode. 
    From Bart Samwel
  o [XFS] Fix vmtruncate abuse in the XFS setattr ATTR_SIZE operation
  o [XFS] cleanup pagebuf flag usage and simplify pagebuf_free
  o [XFS] Fix up a trivial merge botch
  o [XFS] Revive an accidentally dropped pagesize > blocksize assert

Nicolas Pitre:
  o [ARM PATCH] 1836/1: don't hardcode virtual addresses
  o [ARM PATCH] 1837/1: small Lubbock cleanup
  o [ARM PATCH] 1838/1: Lubbock leds and macro namespace cleanup
  o [ARM PATCH] 1839/1: fix lubbock_flash.c which used a bogus reg name
  o [ARM PATCH] 1840/1: recognize more XScale CPU variants
  o [ARM PATCH] 1841/1: Lubbock defconfig update

Nitin A. Kamble:
  o mxcsr patch for i386 & x86-64

Olof Johansson:
  o ppc64: Set memory-only nodes online

Pat Gefre:
  o ia64: SN2 fix

Patrick Wildi:
  o serverworks.c: fix DMA for OSB4

Paul Mackerras:
  o ppc64: fix incorrect signal handler argument
  o ppc32: Updated boot fix
  o Fix CTS handling in pmac-zilog.c

Paul Wagland:
  o bug fix for megaraid memory leak

Pavel Machek:
  o make ikconfig quiet

Petr Vandrovec:
  o ncpfs data corruption when using large TCP transfers

René Scharfe:
  o FAT: simple error handling cleanup

Richard Henderson:
  o [ALPHA] Add message queue syscalls

Roman Zippel:
  o fix value toggle in gconf

Russell Cattelan:
  o [XFS] Fix for the xfs dir2 rebalance bug

Russell King:
  o [ARM] Add read_cpuid() to aid reading CPU ID registers
  o [ARM] Fix BE find_*_bit operations
  o [ARM] Update assabet_defconfig
  o [ARM] Update ioremap implementation
  o [ARM] Fix dependencies of SERIO_AMBAKMI and SERIO_RPCKBD
  o [ARM] Oprofile should use asm/irq.h not asm/arch/irqs.h
  o [ARM] Fix monspecs in ARM-related framebuffer drivers
  o [ARM] Remove Anakin default configuration file
  o [ARM] Fix shared mmap()ings for ARM VIPT caches
  o [ARM] Fix read_cpuid()
  o [ARM] Fix atomic bitops earlyclobber
  o [ARM] Move all page fault handling code to fault.c
  o [ARM] Add Versatile default configuration
  o Update MTD concatenating driver
  o [SERIAL] Fix the calculation of the number of UARTs
  o [ARM] Fix potential oops and kill unused variable warning in
    sa1111.c
  o [ARM] Update mach-types file again
  o [SERIAL] Remove unused variable
  o [ARM] Remove DMA support in Versatile
  o [ARM] Enclose MMC-related code in #ifdef CONFIG_MMC .. #endif
  o [SERIAL] Remove unmerged 'clk' subsystem from PL011 driver

Rusty Russell:
  o [NET]: Fix MODULE_PARM_DESC typo in dummy driver

Slawomir Kolodynski:
  o [SERIAL] Add support for SBS Tech. Inc. PMC-OCTPRO and P-OCTAL
    cards

Sridhar Samudrala:
  o [SCTP] Fix bugs in handling overlapping INIT and peer restart over
    a multihomed association.
  o [SCTP] Rename SCTP_ADDR_REACHABLE as SCTP_ADDR_AVAILABLE to be
    consistent with the SCTP sockets API draft.
  o [SCTP] Fix memset() parameter ordering
  o [SCTP] Fix accessing Gap Ack blocks array with a -ve index in
    sctp_outq_sack()
  o [SCTP]: Fix multihomed connection failures on 64-bit systems

Stas Sergeev:
  o Fix IO bitmap invalidate

Stephen Hemminger:
  o [NET]: Eliminate large inlines in skbuff.h
  o [TCP]: tcp_send_skb code pruning
  o [IPV4]: Use static in several places
  o [NETLINK]: Mark some functions/data static
  o static functions in as-iosched.c
  o [NET]: More network layer static funcs and data
  o SCTP crc table can be static const
  o [TCP]: BIC TCP for Linux 2.6.6

Stephen Rothwell:
  o PPC64 iSeries: replace semaphores with completions

Steve French:
  o Fix port 139 connections to Windows 2K adding missing RFC1002
    session_init
  o Remove unneeded debug statement
  o Flush writebehind before invalidate in file open path
  o fix memory allocation of rfc1002 sess init struct
  o update rfc1001 handling
  o do not block (writing back to the filesystem potentially) while
    allocating smb buffers
  o rfc1001 session init name parsing fix
  o fixes for socket retry and error handling of misc. error paths
  o fix double entry typo
  o fix ppc64 build problem due to missing header
  o even if O_CREAT specified do not reset mode when file not actually
    created
  o reduce excessive stack space usage in smb password hashing
  o do not refresh mode (e.g. in revalidate) to windows servers

Tom Rini:
  o Fix thinkos in #if -> #ifdef conversions
  o Fix thinkos in #if -> #ifdef conversions #2
  o ppc32: Update SBS K2 support
  o ppc32: Add openpic_hookup_cascade()
  o ppc32: Update Motorola PrPMC750 support
  o Fix support for the Motorola PrPMC800

Tony Lindgren:
  o [ARM PATCH] 1844/1: Allow OMAP-730 and OMAP-5910 to use ARM926 in
    mm/Kconfig
  o [ARM PATCH] 1846/1: OMAP update 1/2: arch files
  o [ARM PATCH] 1847/1: OMAP update 2/2: include files

Trond Myklebust:
  o NFSv3: Fix SETATTR call after O_EXCL create
  o nfs printk warning fix

Venkatesh Pallipadi:
  o bug in bigsmp CPU bringup

