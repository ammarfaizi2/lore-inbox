Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSLPD1j>; Sun, 15 Dec 2002 22:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSLPD1j>; Sun, 15 Dec 2002 22:27:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264907AbSLPD1g>; Sun, 15 Dec 2002 22:27:36 -0500
Date: Sun, 15 Dec 2002 19:34:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.52
Message-ID: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various things here. Most noticeably more merges with Andrew, with a 
lot of various small fixes.

XFS, JFS, ACPI and USB updates. KConfig update, and Rusty's module
parameter implementation. And fix the stupid nanosleep() thing that broke 
some programs.

I'm pushing this out, as I've tried to sync up the stuff I got while I was 
away this week (hint hint: if it ain't here, it's not in my in-queue, and 
you should re-send).

		Linus

---

Summary of changes from v2.5.51 to v2.5.52
============================================

Dario Ballabio <ballabio_dario@emc.com>:
  o eata driver update

Peter Braam <braam@clusterfs.com>:
  o intermezzo update

James Simmons <jsimmons@infradead.org>:
  o VT scrolling fix

<khaho@koti.soon.fi>:
  o USB: start to remove static minor based arrays in drivers

<marekm@amelek.gda.pl>:
  o Datafab KECF-USB / Sagatek DCS-CF / Simpletech UCF-100

<nobita@t-online.de>:
  o support for Sony Cybershot F717 digital camera / usb-storage

<romieu@fr.zoreil.com>:
  o missing piece of Iphase atm driver update

Stelian Pop <stelian@popies.net>:
  o sonypi driver update

Andrew Morton <akpm@digeo.com>:
  o Avoid recursion in the page allocator
  o deprecate use of bdflush()
  o create /proc/kmsg, remove sys_syslog()-based
  o speed up read_zero() for !CONFIG_MMU
  o Fix rmap locking for CONFIG_SWAP=n
  o semtimedop - semop() with a timeout
  o skip memory-backed filesystems in writeback
  o Remove fail_writepage, redux
  o show_free_areas extensions
  o make sure all PMDs are allocated under PAE mode
  o handle overflows in radix_tree_gang_lookup()
  o Add a sync_fs super_block operation
  o implement ext3_sync_fs
  o copy_user checks in filldir()
  o vm accounting fixes and addition
  o hugetlb fixes
  o fs-writeback rework
  o Add /proc/sys/vm/lower_zone_protection
  o Set a minimum hash table size for wait_on_page()
  o Reserve an additional transaction block in
  o remove PF_SYNC
  o Don't inherit mm->def_flags across forks
  o bootmem allocator merging fix
  o ext2/ext3_free_blocks() extra check
  o don't apply file size rlimits to blockdevs
  o limit pinned memory due to readahead
  o remove a vm debug check
  o madvise_willneed() maximum readahead checking
  o provide a default super_block_operations
  o tidier atomic check in mempool_alloc()
  o Fix off-by-one in the page allocator
  o pad pte_chains out to a cacheline
  o ext2 synchronous mount fix
  o Add prefetching to get_page_state()
  o ext3: fix error-path bh leak
  o remove vm_area_struct.vm_raend

Andy Grover <agrover@groveronline.com>:
  o ACPI: Get rid of progress dots if not in debug mode
  o ACPI: update to 20021212
  o ACPI: Fix write-related /proc entry functionality

Anton Blanchard <anton@samba.org>:
  o 2.5 fix for > 25 disks

Art Haas <ahaas@airmail.net>:
  o C99 initializers

Ben Collins <bcollins@debian.org>:
  o IEEE-1394/Firewire update

Brian Gerst <bgerst@didntduck.org>:
  o Remove Rules.make from Makefiles

Christoph Hellwig <hch@sgi.com>:
  o [XFS] final sendfile bits
  o [XFS] fix small typo in rtdev mount code
  o [XFS] don't include root_dev.h
  o [XFS] remove linvfs_put_inode
  o [XFS] rationalize pagebuf_iomove
  o [XFS] add a new xfs_mount parameter to xfs_blkdev_get
  o [XFS] get rid of pb_daemon/pagebuf_daemon_t
  o [XFS] merge page_buf_private_t into page_buf_t
  o [XFS] remove some dead code from pagebuf
  o share some code between get_sb_bdev and xfs log/rtdev handling
  o CREDITS update

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Fix off-by one error when symlink size == 256 bytes
  o Add more statistics to /prod/fs/jfs/ to help performance tuning
  o JFS: Move index table out of directory inode's address space
  o JFS: Avoid writing partial log pages for lazy transactions
  o jfs_truncate needs to call block_truncate_page
  o JFS: Fix accounting of active allocation groups
  o JFS: Remove COMMIT_Holdlock

Davide Libenzi <davidel@xmailserver.org>:
  o epoll bits forgot a nasty printk()

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: clean up CPU information
  o cpufreq: move x86 configuration to "Power Management"

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: Added usb-serial driver core bus support
  o Driver core: Fix class leak in class_hotplug
  o USB: Moved usb-serial bus specific code to a separate file
  o usbaudio.c: fix for urb callback function change
  o USB: Fix compile errors with usb-skeleton driver
  o USB: usb-skeleton: removed static array of devices

Greg Ungerer <gerg@snapgear.com>:
  o m68knommu fix kstat_cpu usage int ints.c
  o m68knommu add missing do_fork arg
  o m68knommu spinlocks around signal api calls
  o m68knommu remove sys_security
  o m68knommu fix ELF_CORE_COPY_REGS macro
  o m68knommu current include thread_info.h
  o m68knommu hardirq.h include cache.h
  o m68knommu definition of TASK_UNMAPPED_BASE
  o m68knommu support restart_block

Ingo Molnar <mingo@elte.hu>:
  o threaded coredumps, tcore-fixes-2.5.51-A0
  o ptrace-sigfix-2.5.51-A1

Jeff Garzik <jgarzik@redhat.com>:
  o [NET] support IPv6 over token ring (from lkml)
  o [netdrvr tg3] a fix, a cleanup, and an optimization

Kai Makisara <kai.makisara@kolumbus.fi>:
  o SCSI tape driver fixes for 2.5.51

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix nanosleep() behaviour with NULL "remaining" argument
  o Move intermezzo header files to its own private directory
  o Remove bogus checkin file from xfs

Marcel Holtmann <marcel@holtmann.org>:
  o Disable bluetty.o if Bluetooth subsystem is used

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390: Makefiles
  o s390: nanosleep restarting
  o s390: io fixes
  o s390: uaccess bug
  o s390: old tape file
  o s390: staticification
  o s390: warnings
  o s390: export sys_wait4

Matthew Dobson <colpatch@us.ibm.com>:
  o NUMA topology sysfs panic fix

Matthew Wilcox <willy@debian.org>:
  o Remove test/set_bit from dl2k

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Take into account file information even when not doing
    preallocation. Fixes a bug with displacing_large_files option
  o reiserfs: Fix a problem with delayed unlinks and remounting RW
    filesystem RW
  o reiserfs: lock_kernel is replaced with its reiserfs variant
  o reiserfs: C99 designated initializers, by Art Haas
  o reiserfs: Fixed annoying warnings in fs/reiserfs/procfs.c

Pavel Machek <pavel@ucw.cz>:
  o ACPI/S3: fix gcc3.2 compatibility
  o ACPI/S3: simplify assembly code a bit

Pete Zaitcev <zaitcev@redhat.com>:
  o Patch for debounce in 2.5

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus kmalloc/kfree stuff

Randy Dunlap <rddunlap@osdl.org>:
  o move console_loglevel scalars to array (resend)

Richard Henderson <rth@are.twiddle.net>:
  o Revert bogus include workaround

Richard Henderson <rth@twiddle.net>:
  o sr_ioctl fix

Robert Love <rml@tech9.net>:
  o remove error message on illegal ioctl
  o printks in drivers/scsi/hosts.c missing return

Roman Zippel <zippel@linux-m68k.org>:
  o kconfig: qt installation workaround
  o kconfig: off-by-one error
  o kconfig: config file parse update
  o kconfig: dependencies for choices
  o kconfig: symbol change notification
  o kconfig: geometry defaults
  o kconfig: updates
  o kconfig: fix T_STRING usage

Rusty Russell <rusty@rustcorp.com.au>:
  o Revert depmod and hierarchy changes
  o Module init reentry fix
  o Module Parameter Core Patch
  o Parameter implementation for modules
  o MODULE_PARM support for older modules

Stephen Rothwell <sfr@canb.auug.org.au>:
  o nanosleep compatibility layer fix
  o consolidate sys32_times - architecture independent
  o mips64 compatibility syscall layer
  o consolidate sys32_new[lf]stat - architecture independent

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix buffer reservations in nfs4xdr.c
  o NFSv4 cleanups
  o Add helper routines for fixing up page alignment on xdr_buf

Zwane Mwaikambo <zwane@holomorphy.com>:
  o OSS ad1848 initialisation order

