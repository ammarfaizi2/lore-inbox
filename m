Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTBJTCF>; Mon, 10 Feb 2003 14:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTBJTCF>; Mon, 10 Feb 2003 14:02:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262602AbTBJTBs> convert rfc822-to-8bit; Mon, 10 Feb 2003 14:01:48 -0500
Date: Mon, 10 Feb 2003 11:08:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.60
Message-ID: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h1AJBPF03490
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this contains a lot of patches all over the map, since there were two 
weeks of merging to be done (and the merging took almost a week).

Networking, USB, SCSI, ALSA, ACPI, and various architecture updates (UML,
Sparc, ia64, ppc64 and ARM).

And obviously part of the merge from Andrew Morton.

And Roland McGrath has been fixing POSIX thread signal handling, and that
in turn ended up causing a lot of downstream fixes in affected areas.

		Linus

----

Summary of changes from v2.5.59 to v2.5.60
============================================

<kochi@hpc.bs1.fc.nec.co.jp>:
  o ia64: skip _PRT entry for non-existent IOSAPICs

Adam J. Richter <adam@yggdrasil.com>:
  o The following changes to ide-scsi.c are a recovery of the
    changes that I had in ide-scsi.c in the stock kernel's before
    Martin Dalecki's IDE tree was reverted and a few other changes.

Alex Williamson <alex_williamson@hp.com>:
  o ia64: fix typo in ia32_support.c

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Do not forget data copy while collapsing retransmission
    queue

Andi Kleen <ak@muc.de>:
  o [IPV4]: Better behavior for NETDEV_CHANGENAME requests

Andrew Morton <akpm@digeo.com>:
  o [SPARC64]: Handle unchanging _TIF_32BIT properly in SET_PERSONALITY
  o [IPV4]: Kill bogus semicolon in fib_get_next
  o Fix data loss problem due to sys_sync
  o direct-IO: fix i_size handling on ENOSPC
  o Fix inode size accounting race
  o vmlinux fix
  o Compile fix in sound/oss/maestro.c
  o remove lock_kernel() from exec of setuid apps
  o properly handle too long pathnames in d_path
  o fix handling of ext2 allocation failures
  o ext2_new_block cleanups and fixes
  o ext3: fix scheduling storm and lockups
  o slab poison checking fix
  o quota locking fix
  o quota semaphore fix
  o preempt spinlock efficiency fix
  o Make fix sync_filesystems() actually do something
  o stack overflow checking fix
  o slab IRQ fix
  o blkdev.h fixes
  o symbol_get linkage fix
  o i386 pgd_index() doesn't parenthesize its arg
  o kernel param and KBUILD_MODNAME name-munging mess
  o i386 pgd_index() doesn't parenthesize its arg
  o pcmcia timer initialisation fixes
  o correct wait accounting in wait_on_buffer()
  o atyfb compilation fix
  o floppy locking fix
  o soundcore.c referenced non-existent errno variable
  o Fix generic_file_readonly_mmap()
  o exit_mmap fix for 64bit->32bit execs
  o fix show_task oops
  o qlogic fix
  o implement posix_fadvise64()
  o fix agp compile warning
  o add stats for page reclaim via inode freeing
  o file-backed vma merging
  o mm/mmap.c whitespace cleanups
  o cleanup in read_cache_pages()
  o remove __GFP_HIGHIO
  o Use a slab cache for pgd and pmd pages
  o pgd_ctor update
  o Avoid losing timer ticks when slab debug is enabled
  o remove unneeded locking in do_syslog()
  o hangcheck-timer
  o Restore LSM hook calls to sendfile
  o asm-i386/mmzone.h macro paren/eval fixes
  o remove spaces from slab names
  o remove will_become_orphaned_pgrp()
  o MAX_IO_APICS #ifdef'd wrongly
  o patch to DAC960 driver for error retry
  o Remove __ from topology macros
  o put_user() warning fix
  o fix #warnings
  o ia32 Lost tick compensation
  o Include <asm/page.h> in fs/seq_file.c, as it uses
  o scsi_eh_* needs to run even during suspend
  o misc fixes
  o Remove unneeded code in fs/fs-writeback.c
  o Fix latencies during writeback
  o fix i_sem contention in sys_unlink()
  o seqlock fix: read_seqretry_irqrestore()
  o BTTV build fix
  o reiserfs v3 readpages support
  o self-unplugging request queues
  o Remove most of the blk_run_queues() calls
  o Updated Documentation/kernel-parameters.txt
  o JBD Documentation
  o Restore LSM hook calls to sendfile
  o Fix SMP race betwen __sync_single_inode and
  o ia32 IRQ distribution rework
  o Fix futexes in huge pages
  o Optimise follow_page() for page-table-based hugepages
  o default_idle micro-optimisation
  o loop inefficiency fix
  o pte_chain_alloc fixes
  o give hugetlbfs a set_page_dirty a_op
  o Infrastructure for correct hugepage refcounting
  o convert hugetlb code to use compound pages
  o get_unmapped_area for hugetlbfs
  o hugetlbfs: fix truncate
  o hugetlbfs i_size fixes
  o hugetlbfs cleanups
  o Give all architectures a hugetlb_nopage()
  o Fix hugetlbfs faults
  o ia32 hugetlb cleanup
  o Fix hugetlb_vmtruncate_list()
  o hugetlb mremap fix
  o mm/mremap.c whitespace cleanup
  o spinlock debugging on uniprocessors
  o CPU Hotplug mm/slab.c CPU_UP_CANCELED fix
  o Fix signed use of i_blocks in ext3 truncate
  o revert extra sendfile security hook patch
  o Fix possible uninitialised variable in vma merging code
  o Fix compile warning for 'sys_exit_group'

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o Remove dead code
  o Doc fix

Andy Grover <agrover@groveronline.com>:
  o ACPI: Boot functions don't use cmdline, so don't pass it around
  o ACPI: Move drivers/acpi/include directory to include/acpi
  o ACPI: Move more headers to include/acpi, and delete an unused
    header
  o CPUFREQ: Break out ACPI Perf code into its own module, under
    cpufreq (Dominik Brodowski)
  o ACPI: acpiphp.h includes both linux/acpi.h and acpi_bus.h. Since
    the former now also includes the latter, acpiphp.h only needs the
    one, now.
  o ACPI: Remove include of unused header (Adrian Bunk)
  o ACPI: Properly init/clean up in cpufreq/acpi (Dominik Brodowski)
  o ACPI: Make proc write interfaces work (Pavel Machek)
  o ACPI: This makes it possible to select method of bios restoring
    after S3 resume. [=> no more ugly ifdefs] (Pavel Machek)
  o ACPI: Handle P_BLK lengths shorter than 6 more gracefully
  o ACPI: update to 20030122
  o ACPI: It is OK to not have a _PPC, so don't error out if it's not
    found
  o ACPI: Optimize for space
  o ACPI: Enable compilation w/o cpufreq

Anton Blanchard <anton@samba.org>:
  o ppc64: defconfig update
  o ppc64: SO_TIMESTAMP fix from sparc64
  o ppc64: compat layer updates from Stephen Rothwell
  o ppc64: defer change of 32/64bit mode, from Andrew Morton
  o ppc64: now make it compile
  o ppc64: some small optimisations
  o ppc64: restore non rt signals, we need to verify that older 64bit
    glibcs dont use them
  o ppc64: Preparation work for minimal register save/restore exception
    paths
  o ppc64: Fix compile with CONFIG_DEBUG_KERNEL disabled, from David
    Altobelli
  o ppc64: rtas proc fixes from David Altobelli
  o ppc64: defconfig update
  o ppc64: Fix my overoptimisation of zeroing RESULT. Yes Linus, it was
    all my fault.
  o ppc64: fix UP compile
  o ppc64: module updates from Rusty
  o ppc64: Add ppc64 relocations to asm/elf.h. I am the example of good
    taste
  o missing include in pci-sysfs.c
  o ppc64: update for signal changes
  o ppc64: Fix nasty bug in cmpxchg where we would sign extend the old
    value

Arun Sharma <arun.sharma@intel.com>:
  o ia64: make hugetlb support work again

Bart De Schuymer <bdschuym@pandora.be>:
  o [BRIDGE]: update to new module scheme

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o irq cleanups

Bob Miller <rem@osdl.org>:
  o [NETFILTER]: Delete un-used stack variable in ip_nat_helper.c

Chris Wedgwood <cw@f00f.org>:
  o [IPV6]: Fix tcp_v6_xmit prototype
  o signal locking update
  o missing sound include file

Chris Wright <chris@wirex.com>:
  o 2.5-bk trivial LSM cleanup

Christoph Hellwig <hch@lst.de>:
  o remove __scsi_add_host
  o fixes and cleanups for the new command allocation code
  o [SCSI] Remove host_active
  o coding style updates for scsi_lib.c
  o [XFS] remove a dead codepath in xfs_syncsub
  o fix leaks in vxfs_read_fshead()

Daniel Jacobowitz <drow@nevyn.them.org>:
  o Tweak has_stopped_jobs for use with debugging
  o Add PTRACE_GETSIGINFO and PTRACE_SETSIGINFO
  o Use force_sig_specific to send SIGSTOP to newly-created
    CLONE_PTRACE processes
  o Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities
  o Signal handling bugs for thread exit + ptrace

Daniel Stekloff <stekloff@w-stekloff.beaverton.ibm.com>:
  o pci patch for sysfs files

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Switch over to using akpm's no-buffer-head operations
  o JFS: replace ugly JFS debug macros with simpler ones
  o JFS: Minor update in Documentation/filesystems/jfs.txt
  o JFS: Implement get_index_page to replace some uses of
    read_index_page

David Brownell <david-b@pacbell.net>:
  o usb root hub strings
  o USB ohci-hcd, don't force SLAB_ATOMIC allocations
  o USB: usbcore misc cleanup (notably for non-dma hcds)
  o USB: ehci-hcd updates

David Jeffery <david_jeffery@adaptec.com>:
  o ips driver 1/4: fix struct length and remove dead code
  o ips driver 2/4: initialization reordering
  o ips driver 3/4: 64bit dma addressing
  o ips driver 4/4: error messages

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Add missing include of kernel/config.h
  o ia64: Various updates: ia32 subsystem fix, tracing-support for
    mmu-context switching, etc.
  o ia64: Light-weight system call support (aka, "fsyscalls").  This
    does not (yet) accelerate normal system calls, but it puts the
    infrastructure in place and lets you write fsyscall-handlers to
    your hearts content.  A null system- call (such as getpid()) can
    now run in as little as 35 cycles!
  o ia64: Make asynchronous signal delivery work properly during
    fsys-mode execution
  o ia64: Fix some typos
  o ia64: Add unwcheck.sh script contributed by Harish Patil.  It
    checks the unwind info for consistency (well, just the obvious
    stuff, but it's a start).
  o ia64: Fix Makefiles so that "make clean" removes the files
    generated in the tools directory.  Patch by Yu, Fenghua.
  o Remove last vestiges of hugepage system calls (they have been
    replaced by hugetlbfs)
  o ia64: Don't risk running past the end of the unwind-table.  Based
    on a patch by Suresh Siddha.
  o ia64: asm-ia64/system.h: Remove include of <linux/percpu.h>
  o ia64: Sync up with 2.5.59
  o ia64: More vmlinux.lds.S cleanups
  o ia64: Switch over to using place-relative ("ip"-relative) entries
    in the exception table.
  o ia64: Check for acceptable version of gas before trying to build
    the kernel.  Old gas versions will result in buggy kernels that
    will bugcheck all over the place (usually mount() is the first one
    to fail).
  o ia64: Fix typo
  o ia64: Fix ARCH_DLINFO
  o ia64: Add light-weight version of getppid().  Detect at boottime
    whether the McKinley Erratum 9 workaround is needed and, if not,
    patch the workaround bundles with NOPs.
  o ia64: Fix potential perfmon deadlock.  Patch by Stephane Eranian
  o ia64: Correct erratum number (caught by Asit Mallick)
  o ia64: Fix ia64_fls() so it works for all possible 64-bit values
  o ia64: Use printk severity-levels where appropriate

David S. Miller <davem@nuts.ninka.net>:
  o [TCP]: Named struct initializers and tabbing fixes
  o [IPSEC]: Clear SKB checksum state when mangling
  o [TCP]: Add tcp_low_latency sysctl
  o [SPARC64]: Kill references to hugepage syscalls
  o [TCP]: In tcp_check_req, handle ACKless packets properly
  o [TG3]: Let chip do pseudo-header csum on rx
  o [TG3]: Add device IDs for 5704S/5702a3/5703a3
  o [TG3]: Prevent dropped frames when flow-control is enabled
  o [TG3]: Correct MIN_DMA and ONE_DMA settings in dma_rwctrl
  o [TG3]: Workaround 5701 back-to-back register write bug
  o [TG3]: Add workaround for third-party phy issues
  o [TG3]: Remove anal grc_misc_cfg board IDs check
  o [TG3]: Fix typos in previous changes
  o [IPSEC]: Revert previous change to ip_route_connect
  o [SPARC]: Add ndelay
  o [FC4]: Update for scsi_cmnd changes
  o [SCSI ESP]: Update for scsi_cmnd changes
  o [SCSI QLOGICPTI]: Update for scsi_cmnd changes
  o [SCSI PLUTO/FCAL]: Update for scsi_cmnd changes

Derek Atkins <warlord@mit.edu>:
  o [IPSEC]: Block on connect for IPSEC keying

Douglas Gilbert <dougg@torque.net>:
  o SAM-3 status codes
  o [SCSI] Add length checking to sprintf in sg

Duncan Sands <baldrick@wanadoo.fr>:
  o export speedtouch usb info
  o USB: trivial speedtouch changes
  o USB: move udsl_atm_set_mac into speedtouch probe function
  o USB: eliminate pointless dynamic allocation in speedtouch
  o USB: move udsl_atm_startdevice into speedtouch probe function
  o USB: rework error handling in speedtouch probe function
  o USB: turn speedtouch micro race into a nano race
  o USB: simplify speedtouch receive urb lifecycle
  o USB speedtouch: add a new speedtouch encoding function
  o USB speedtouch: let the tasklet do all processing of speedtouch
    receive urbs
  o USB speedtouch: re-recycle speedtouch receive buffers
  o USB speedtouch: re-recycle failed speedtouch receive urbs
  o USB speedtouch: re-wait for speedtouch completion handlers after
    usb_unlink_urb
  o USB speedtouch: re-cosmetic speedtouch changes
  o USB speedtouch: tweak speedtouch status logic
  o USB speedtouch: allocate speedtouch send urbs in the USB probe
    routine
  o USB speedtouch: earlier rejection of outgoing speedtouch packets

Frank Davis <fdavis@si.rr.com>:
  o 2.5.59 : drivers/media/video/bt856.c
  o 2.5.59 : drivers/media/video/saa7185.c
  o 2.5.59 : drivers/media/video/bt819.c

Ganesh Varadarajan <ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq driver ids

Greg Kroah-Hartman <greg@kroah.com>:
  o USB acm: patch from dan carpenter <error27@email.com> to fix typo
  o USB: add a blank line between each device in usbfs/devices
  o USB: fix to get usb-storage code to work again
  o USB: added tripp device id's to pl2303 driver
  o USB: fix up drivers the scsi people missed
  o PCI Hotplug: dereference null variable cleanup patches
  o IBM PCI Hotplug driver: Clean up the slot filename generation logic
    a lot
  o PCI Hotplug: change pci_hp_change_slot_info() to take a
    hotplug_slot and not a string
  o sysfs: add sysfs_update_file() function
  o PCI Hotplug: Make pci_hp_change_slot_info() work again
  o PCI Hotplug: moved the some stuff into the pci core
  o PCI:  put proper field sizes on sysfs files, and add class file
  o Compaq PCI Hotplug: fix checker memory leak bugs
  o IBM PCI Hotplug: fix memory leak found by checker project
  o IBM PCI Hotplug: fix a load of memory leak errors found by the
    checker project
  o sysfs: remember to add EXPORT_SYMBOL() for sysfs_update_file

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB scanner.h, scanner.c: New vendor/product ids
  o USB scanner.h, scanner.c: maintainer change
  o USB scanner.c: Adjust syslog output

Ingo Molnar <mingo@elte.hu>:
  o signal-fixes-2.5.59-A4
  o Lock session and group ID setting
  o lock group_send_sig_info() properly

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha_agpgart_size
  o nautilus update

James Bottomley <james.bottomley@steeleye.com>:
  o 3c509 fixes: correct MCA probing, add back ISA probe to Space.c
  o [SCSI] make echo scsi add-single-device x x x x > /proc/scsi/scsi
    work again
  o [SCSI] Correct command leaks in the prep_fn
  o [SCSI] Add missing list head init of cmd_list
  o Fix 53c700 for scsi_cmnd field migration
  o Correct compiler warnings with use of likely() on pointers
  o Fix sr_ioctl.c bounce buffer usage
  o move queue_depth check from scsi_prep_fn to scsi_request_fn
  o Restore device command queue functionality
  o [SCSI] Migrate sim710 to 53c700 chip driver
  o [SCSI] Remove 53c7,8xx since we have plenty of alternatives

James Morris <jmorris@intercode.com.au>:
  o [IPSEC]: remove trailer_len from esp and xfrm properties
  o [IPSEC]: Update ah documentation
  o [IPSEC] Convert esp auth to use proper crypto api calls
  o [IPSEC] Generic ICV handling for ESP
  o [CRYPTO]: in/out scatterlist support for ciphers
  o [IPV4]: Fix skb leak in inet_rtm_getroute
  o [IPV6]: Fix skb leak in inet6_rtm_getroute
  o [LSM]: networking hooks, kconfig bits
  o [LSM]: Networking top-level socket operation hooks
  o [LSM]: Networking socket SKB receive hook
  o [LSM]: Networking AF_UNIX hooks
  o [LSM]: Networking netlink socket capability hooks

Jamie Lokier <jamie@shareable.org>:
  o [SPARC64]: Fix MAP_GROWSDOWN value, cannot be the same as
    MAP_LOCKED
  o CONFIG_PREEMPT fix of do_debug()

Jaroslav Kysela <perex@suse.cz>:
  o ALSA updates

Jeff Dike <jdike@uml.karaya.com>:
  o Converted all initializers over to C99 syntax
  o Converted a few more initializers I missed on the first pass
  o Merged the configurable kernel stack size changes from 2.4.  This
    paramerizes the kernel stack size and adds a config option to set
    the order.
  o Fixed a couple of problems with the configurable stack size changes
  o Converted a bunch of inititializers in the drivers that I missed
  o Missed an initializer in the ethertap backend
  o Merged the 2.4 build changes which split the mode-specific stuff
    into separate Makefiles and add the ability to build a dynamically
    loaded binary.
  o Moved skas_ptrace.h
  o Moved the segment remapping code under arch/um/kernel/tt
  o task_protections needed adjusting for configurable stack sizes
  o Pulled in a number of other fixes which were needed to bring the
    build up to date.
  o Fixed handling of the linker script
  o Fixed the archmrproper rule to not delete linker script sources
  o Forward ported a bunch of cleanups from 2.4.  Improved error
    messages, slightly different formatting, removal of dead code, and
    some stray C99 initializer conversions.
  o Forwarded ported a number of skas-related fixes from 2.4
  o Forward ported a number of bug fixes from 2.4, including SA_SIGINFO
    signal delivery, protecting skas mode against tmpfs running out of
    space, protecting the UML main thread against accidentally running
    kernel code, and a couple of data corruption bugs.
  o Fixed a few problems in the last merge
  o Updates to bring UML up to 2.5.58
  o Added gpl_ksymtab and kallsyms sections to the linker scripts
  o Fixed a merge typo in Kconfig
  o Fixed asm/modules.h to update UML to 2.5.59
  o Some build changes for 2.5.59 and SMP.  Also cleanup of the linker
    scripts and Kconfig.
  o Correctly check the mmap return value
  o Some SMP fixes from Oleg
  o Some SMP fixes
  o Fixed dyn.lds.S to include common.lds.S
  o Ported a cleanup from 2.4
  o Ported a uml-config.h change from 2.4
  o Ported a cleanup from 2.4
  o Changed some CONFIG_* names to UML_CONFIG_* names
  o A bunch of minor changes ported up from 2.4
  o Fixed the time locking bug
  o Changed CONFIG_KERNEL_STACK_ORDER to UML_CONFIG_KERNEL_STACK_ORDER
  o Replaced some CONFIG_* with UML_CONFIG_*
  o Replaced a CONFIG_* name with a UML_CONFIG_* name
  o Changed some CONFIG_* symbols to UML_CONFIG_*
  o Added vmlinux.lds.S which is now necessary for linking the vmlinux

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] s/spin_lock/spin_lock_irqsave/ in tg3_poll and
    tg3_timer
  o [netdrvr tg3] Better interrupt masking
  o [netdrvr tg3] flush irq-mask reg write before checking hw status
    block, in tg3_enable_ints.
  o [netdrvr tg3] manage jumbo flag on MTU change when interface is
    down
  o [netdrvr e100] remove e100_proc.c. should have been in prior cset
  o [netdrvr tg3] more verbose failures, during initialization
  o [netdrvr tg3] bump version, tidy comments

Jeff Wiedemeier <jeff.wiedemeier@hp.com>:
  o NODE_BALANCE_RATE (numa)
  o mark boot_cpu online in smp_prepare_boot_cpu
  o remove srmcons_allowed implementation from marvel
  o use CONFIG_EARLY_PRINTK to turn off "srmcons" prints
  o fix /proc/interrupts on smp alpha kernels

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Aic7xxx and Aic79xx DV Fix
  o Aic79xx Driver Update Enable abort and bus device reset handlers
    for both legacy and packetized connections.
  o Aic7xxx Driver Update
  o Bump aic7xxx driver version to 6.2.27
  o Aic7xxx and Aic79xx Driver Update Force an SDTR after a rejected
    WDTR if the syncrate is unkonwn.
  o Aic7xxx Driver Update 6.2.28
  o Update Aic7xxx and Aic79xx driver documentation
  o Bump aic79xx driver version number to 1.3.0, now that it has passed
    functional test.

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix __start_SECTION, __stop_SECTION
  o kbuild: Remove -DEXPORT_SYMTAB switch
  o kbuild: Remove obsolete CONFIG_MODVERSIONS cruft
  o kbuild: Add CONFIG_MODVERSIONING and __kcrctab
  o kbuild: Generate versions for exported symbols
  o kbuild/modules: Check __vermagic for validity
  o kbuild/modules: Don't save the license string
  o kbuild/modules: Track versions of exported symbols
  o kbuild: Always link module (.ko) from associated (.o)
  o kbuild: Don't build final .ko yet when descending with
    CONFIG_MODVERSIONING
  o kbuild/modules: Record versions for unresolved symbols
  o kbuild/modules: Return the index of the symbol from __find_symbol()
  o kbuild/modules: Check module symbol versions on insmod
  o kbuild: Add cscope support to Makefile
  o kbuild: gcc-3.3 warns about 2.5.59 EXPORT_SYMBOL
  o kbuild: Move the definition of MODVERDIR
  o kbuild: Rename CONFIG_MODVERSIONING -> CONFIG_MODVERSIONS
  o kbuild: Generate module versions in the normal object directories
  o kbuild: Assorted fixlets
  o kbuild: Remove export-objs := ... statements
  o kbuild: Don't default to building modules when not selected
  o kbuild: Handle external SUBDIRS with modversions
  o kbuild: Warn on obsolete export-objs use
  o kbuild: Modversions fix
  o kbuild: Add a bug trap for people playing with SUBDIRS too much

Kunihiro Ishiguro <kunihiro@ipinfusion.com>:
  o [XFRM]: Add family member to xfrm_usersa_id

Lennert Buytenhek <buytenh@gnu.org>:
  o [BRIDGE]: Update maintainership status
  o [BRIDGE]: handle out-of-ports corner case

Linus Torvalds <torvalds@home.transmeta.com>:
  o Make threaded core-dump names use the tgid instead of the pid.
    Makes sense now that we can dump all threads in one core-dump.
  o Atyfb_base compile fix from Andres Salomon <dilinger@voxel.net>
  o Fix up manual merge error in usb/storage/scsiglue.c
  o Fix Makefile syntax error for (deprecated) "make dep"
  o Don't special-case SIGKILL/SIGSTOP - the blocking masks should
    already take care of it.
  o Split up "struct signal_struct" into "signal" and "sighand" parts
  o More signal handling fixups for the threaded signal fix upheavals
  o Make sigprocmask() available to kernel threads too, since a lot of
    them do want to temporarily block signals.
  o Fix missing break, causing sigprocmask(SIG_SETMASK ...) to always
    return an error.
  o Create "wake_up_state()" macro that selectively wakes up processes
    only from certain states.
  o Wake up a stopped task _after_ having marked the SIGCONT pending,
    so that there isn't any window for running before the signal
    handler has been invoced.

Luben Tuikov <luben@splentec.com>:
  o [SCSI] Move cmd->{lun, target, channel} to cmd->device->{lun, id,
    channel}
  o [SCSI] Move cmd->host to cmd->device->host
  o cmd_alloc54-3.patch [3/3]
  o [SCSI] add commands at the tail of cmd_list

Manish Lachwani <manish@zambeel.com>:
  o [netdrvr tg3] add support for another 5704 board, fix up 5704 phy
    init

Mark Haverkamp <markh@osdl.org>:
  o fix megaraid driver compile error

Martin Devera <devik@cdi.cz>:
  o [NET_SCHED]: HTB scheduler updates from Devik

Matt Domsch <matt_domsch@dell.com>:
  o EDD: fix raw_data file and edd_has_edd30(), misc cleanups
  o EDD: Until scsi layer is fixed, don't make symlink to scsi disk
  o EDD: until SCSI layer sysfs is fixed, don't use it for raw_data
    either
  o EDD: don't over-allocate EDD data block

Matthew Dharm <mdharm-scsi@one-eyed-alien.net>:
  o usb-storage: fix typo
  o usb-storage: fix oops
  o usb-storage: move to SCSI hotplugging
  o usb-storage: comments, cleanup
  o usb-storage: remove US_FL_DEV_ATTACHED
  o usb-storage: convert spaces to tabs
  o Replace a line of code that shouldn't have been removed
  o USB usb-storage: host a host refcount a little bit longer
  o USB usb-storage: implement device-offline code
  o USB usb-storage: implement clearing of device queue

Matthew Dobson <colpatch@us.ibm.com>:
  o Broken CLEAR_BITMAP() macro

Matthew Wilcox <willy@debian.org>:
  o PA-RISC updates for 2.5.59

Mike Anderson <andmike@us.ibm.com>:
  o [SCSI] fix scsi_find_device()

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>:
  o simple EXT2 patch

Nathan Laredo <nlaredo@transmeta.com>:
  o stradis.c "proper" port to 2.5.x

Oleg Drokin <green@namesys.com>:
  o fix HZ=100 case with 64 bit jiffies

Patrick Mansfield <patmans@us.ibm.com>:
  o add back single_lun support

Patrick McHardy <kaber@trash.net>:
  o [PPP]: Handle filtering drops correctly

Pete Zaitcev <zaitcev@redhat.com>:
  o [SUN PARTITION]: Advance slot properly while scanning
  o [SPARC]: Kill smp_found_cpus declaration

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus & mii cset

Philipp Gühring <p.guehring@futureware.at>:
  o USB: FTDI driver, new id added

Randy Dunlap <randy.dunlap@verizon.net>:
  o PCI Hotplug: memory leaks in acpiphp_glue
  o do_mounts memory leak
  o quota memleak

Randy Dunlap <rddunlap@osdl.org>:
  o fix references to discarded sections
  o PCI Hotplug: checker patches

Richard Henderson <rth@kanga.twiddle.net>:
  o [ALPHA] Add debugging access (core and ptrace) to the PAL unique
    value.  Support threaded core dumps.
  o [ALPHA] New SRM console driver

Rik van Riel <riel@conectiva.com.br>:
  o Re: [CHECKER] 112 potential memory leaks in 2.5.48

Robert Olsson <robert.olsson@data.slu.se>:
  o [netdrvr e1000] NAPI fixes

Rohit Seth <rohit.seth@intel.com>:
  o ia64: Update to hugetlb

Roland McGrath <roland@redhat.com>:
  o Make sys_wait4() more readable
  o exit_notify/do_exit cleanup
  o SA_NOCLDWAIT now supported - update comments
  o do_sigaction locking cleanup
  o TASK_STOPPED wakeup cleanup
  o zap_other_threads() needs tasklist_lock held

Russell King <rmk@arm.linux.org.uk>:
  o disassociate_ctty SMP fix
  o Fix Alt-SysRQ-T status, and comment

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix printk in rpcmouse.c
  o [ARM] Fix buffer overflow in fas216-based SCSI drivers
  o [ARM] Fix fas216-based data-phase lockups
  o [ARM] Add soft-cursor support to acornfb and sa1100fb
  o [ARM] Make oops dump reasonble again without kallsyms support
    enabled
  o [ARM] Drop "alloc" flag for the .stack segment
  o [ARM] Add one CPU device to the driver model
  o [ARM] Kill build warnings for Integrator PCI V3 driver
  o [ARM] Fix KSTK_EIP and KSTK_ESP macros
  o [ARM] Add extra IO functionality
  o [ARM] Convert ecard to allow use of ioremap + {read,write}[bwl]
  o [ARM] Update Acorn SCSI drivers
  o [ARM] Add linux/errno.h include to allow pcf8583.c to build
  o [ARM] Remove 200Hz -> 100Hz conversion for ebsa110 timer
  o [ARM] Include ARM architecture version in module "version" string
  o [ARM PATCH] 1361/1: EPXA10DB: Correct some typos in uart00.c
  o [ARM PATCH] 1348/1: Add support for the HackKit board
  o [ARM PATCH] 1097/3: trizeps IDE support
  o [ARM PATCH] 1096/4: trizeps PCMCIA support
  o [ARM PATCH] 1091/3: support for trizeps board (SA1110-based)
  o [ARM] Make trizeps_map_io static
  o [ARM] Ensure GCC uses frame pointers when we want them
  o [ARM] Add missing #endif
  o [ARM] Remove IRQ desc->enabled in favour of testing disable_depth
  o [ARM] Add arch/arm/common

Rusty Russell <rusty@rustcorp.com.au>:
  o kbuild: Modversions fixes
  o kbuild: Ignore kernel version part of vermagic if
    CONFIG_MODVERSIONS
  o [patch, 2.5] scsi_qla1280.c free on error path
  o 2.5.59 add two help texts to drivers_scsi_Kconfig
  o Documentation_Changes
  o Remove superflous 'either'
  o fix comment in module.c
  o remove check_region from drivers_net_irda_irport.c
  o parport_pc and !CONFIG_PNP
  o Change "char _version" to "char in drivers_lcs.c
  o add one help text to drivers_atm_Kconfig
  o scripts_ver_linux
  o Change "char _version" to "char in drivers_net_mac8390.c
  o add two help texts to drivers_i2c_Kconfig
  o Remove compile warning from fs_xfs_support_move.c
  o make i2c-core driver_lock static
  o Memory leak in drivers_net_arlan.c (1)
  o RTC alarm and wildcards
  o fix typo of members name in drivers_mtd_ftl.c
  o Fix return code of init_module in drivers_net_arlan.c (2)
  o Kill unused code
  o remove LinuxVersionCode from de4x5.h
  o nfs_write.c warning
  o Squash unused function in fs_nfs_mount_clnt.c
  o fix spelling of kernel in arch_v850_kernel_mach.h
  o fix linewrap in Documentation_arm_SA1100_CERF
  o swsusp: do not panic on bad signature with noresume
  o add six help texts to drivers_ide_Kconfig
  o add four help texts to drivers_char_watchdog_Kconfig
  o Change "char version" to initdata in drivers_net_tulip_de4x5.c
  o add two help texts to drivers_media_video_Kconfig
  o Write with buffer>2GB returns broken errno (2)
  o Change all <module>.o to .ko in Kconfig files

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: arch{mrproper,clean} no longer mandatory
  o kbuild/all archs: Removed unused arch{clean,rproper} targets
  o kbuild: HEAD replaced with head-y
  o kbuild/all archs: Replace HEAD with head-y
  o kbuild: Update Documentation/kbuild/makefiles.txt
  o Documentation/modules.txt: How to compile modules outside the
    kernel tree
  o kbuild: Removed Documentation/kbuild/bug-list.txt
  o kbuild: Enable the syntax "make dir/"
  o kbuild: Made cmd_link_multi readable
  o kbuild: ld_flags used consistently in Makefile.build

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e100] udelay a better way
  o [netdrvr e100] fix TxDescriptor bit setting
  o [netdrvr e100] standardize nic-specific stats support
  o [netdrvr e1000] ethtool eeprom buffer dynamic allocation, rather
    than large static allocation on the stack
  o [netdrvr e1000] remove /proc support (superceded by ETHTOOL_GSTATS)
  o [netdrvr e1000] add ETHTOOL_GSTATS support
  o [netdrvr e1000] TSO fixes and cleanups
  o [netdrvr e100] math fixes and a cleanup

Sridhar Samudrala <sri@us.ibm.com>:
  o [IPV{4,6}]: Add ipfragok arg to ip_queue_xmit

Stanley Wang <stanley.wang@linux.co.intel.com>:
  o PCI Hotplug: Replace pcihpfs with sysfs
  o PCI Hotplug: Remove procfs stuff from pci_hotplug_core

Stephen Hemminger <shemminger@osdl.org>:
  o x86_64 gettimeofday bug
  o seqlock for xtime

Stephen Lord <lord@sgi.com>:
  o [XFS] Transaction A is in callback processing unpinning a buffer,
    Transaction B is in the process of marking the buffer stale.
  o [XFS] Do not release the last iclog of a transaction before we get
    our callbacks attached to it. Otherwise we can end up executing the
    callback out of order.
  o [XFS] fix initialization of bio in end case where we are dealing
    with sub page sized requests.

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [COMPAT]: compat_{old_}sigset_t sparc64
  o ia64: [COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
  o ia64: [COMPAT] {get,put}_compat_timspec 5/8
  o ia64: [COMPAT] compat_{old_}sigset_t
  o ia64: [COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
  o ia64: [COMPAT] compat_sys_[f]statfs

Steven Cole <elenstev@mesatop.com>:
  o [NETFILTER]: Update Kconfig help text to match 2.4.x
  o Spelling fixes
  o Spelling fixes for consistent, dependent, persistent
  o Finish job of trimming ".o" module extension in Kconfig files

Stéphane Eranian <eranian@hpl.hp.com>:
  o ia64: perfmon update
  o ia64: fix PSR bug in perfmon code and switch to C99 initializers
  o ia64: fix return type of sys_perfmonctl()

Thomas Walpuski <thomas@bender.thinknerd.de>:
  o [IPSEC]: Fix some buglets in xfrm_user.c

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o use 64 bit jiffies: infrastructure
  o use 64 bit jiffies: fix utime wrap
  o use 64 bit jiffies: 64-bit process start time

Vojtech Pavlik <vojtech@suse.cz>:
  o USB: Add an entry in cdc-acm.c for devices with ACM class (some
    Motorola phones)
  o USB: additions to hid-core.c blacklist
  o x86-64: Minor fixes to make the kernel compile and remove warnings

Willem Riede <wriede@riede.org>:
  o [osst] fix bugzilla 244 (SRpnt initialisation problem)


