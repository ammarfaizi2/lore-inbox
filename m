Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUHXHut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUHXHut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUHXHut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:50:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:9655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266689AbUHXHt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:49:27 -0400
Date: Tue, 24 Aug 2004 00:49:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9-rc1
Message-ID: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 tons of patches merged, with me being away for a week, and also the
normal pent-up patch demand after any stable kernel. Special thanks as
always to Andrew, who synced up 200+ patches (he's attributed in the
sign-off lines, but not in the appended shortlog, so I just wanted to
point that out).

Changes all over: arm, ppc, sparc, acpi, i2c, usb, fbcon, ntfs, xfs, nfs,
cpufreq, agp, sata, network drivers - you name it. Most of the changes are
fairly small, but there's a lot of them.

Administrative trivia, and one thing I agonized over: should I make the
patches relative to 2.6.8 or 2.6.8.1? I decided that since there is
nothing that says that a "basic bug-fix" releases for a previous release
might not happen _after_ we've done a -rc release for the next version, I
can't sanely do patches against a bugfix release.

Thus the 2.6.9-rc1 patch is against plain 2.6.8. If you have 2.6.8.1, you
need to undo the .1 patch, and apply the big one. BK users and tar-balls 
don't see that particular confusion, of course ;)

		Linus

-----

Summary of changes from v2.6.8 to v2.6.9-rc1
============================================

<felixb:sgi.com>:
  o [XFS] Removed xfs_iflush_all and all usages of vn_purge, except one
    in clear_inode path.
  o [XFS] Restored xfs_iflush_all, which is still used to finish
    reclaims

<herry:sgi.com>:
  o [XFS] Add support for unsetting realtime flag on realtime file
    which has no extents allocated.

Adrian Bunk:
  o 2.6.8-rc1-mm1: 8139too: uninline rtl8139_start_thread
  o #define inline as __attribute__((always_inline)) also for gcc >=
    3.4
  o istallion: gcc-3.5 fixes
  o mxser.c: gcc-3.5 fixes
  o radio-maestro.c: gcc-3.5 fixes
  o cciss /proc dependency fix

Adrian Cox:
  o I2C: bus driver for multiple PowerPCs

Alan Cox:
  o [libata] improve translation of ATA errors to SCSI sense codes
  o Fix HPT374 merge problem
  o missing CPU descriptors

Alan Stern:
  o USB: Fix NULL-pointer bug in dummy_hcd
  o USB: Make removable-LUN support a non-test option in the
    g_file_storage driver
  o USB: Remove unneeded unusual_devs.h entry
  o USB: unusual_devs.h update
  o USB: unusual_devs.h update
  o USB: Don't track endpoint halts in usbcore
  o USB: Disallow probing etc. for suspended devices

Alexander Malysh:
  o I2C: new device for sis630

Andi Kleen:
  o gcc-3.5 fixes

Andrea Arcangeli:
  o do_general_protection doesn't disable irq

Andrew Chew:
  o [libata sata_nv] fix leak on error

Andrew Morton:
  o fix via-velocity oopses
  o via-velocity warning fixes
  o I2C: scx200_i2c build fix
  o libata build fix
  o make sync_dirty_buffer() return something useful
  o memory-backed inodes fix
  o err2-6: hashbin_remove_this() locking fix
  o send_IPI_mask_bitmask() build fix
  o Writeback page range hint
  o Concurrent O_SYNC write support
  o mark IS_ERR as unlikely()
  o IS_ERR() unlikeliness cleanup
  o net/Kconfig crc16 warning fix

Andrey Panin:
  o fix visws kernel build
  o CRC16 renaming in VIA Velocity ethernet driver

Andries E. Brouwer:
  o minix block usage counting fix

Andy Fleming:
  o update gianfar ethernet driver

Aneesh Kumar:
  o alpha: print the symbol of pc and ra during Oops

Anton Altaparmakov:
  o NTFS: Add support for readv/writev and aio_read/aio_write
  o NTFS: Change ntfs_write_inode to return 0 on success and -errno on
    error and create a wrapper ntfs_write_inode_vfs that does not have
    a return value and use the wrapper for the VFS super_operations
    write_inode function.
  o NTFS: Implement fsync, fdatasync, and msync both for files
    (fs/ntfs/file.c) and directories (fs/ntfs/dir.c).
  o NTFS: 2.1.16 - Implement access time updates in
    fs/ntfs/inode.c::ntfs_write_inode
  o NTFS: Implement bitmap modification code (fs/ntfs/bitmap.[hc]). 
    This includes functions to set/clear a single bit or a run of bits.
  o NTFS: Wrap the new bitmap.[hc] code in #ifdef NTFS_RW / #endif
  o NTFS: Rename run_list to runlist everywhere to bring in line with
    libntfs
  o NTFS: Rename map_runlist() to ntfs_map_runlist()
  o NTFS: Rename vcn_to_lcn() to ntfs_vcn_to_lcn()
  o NTFS: Complete "run list" to "runlist" renaming
  o NTFS: Move a NULL check to before the first use of the pointer
  o NTFS: Add fs/ntfs/attrib.[hc]::ntfs_find_vcn()
  o NTFS: Fix compilation with gcc-2.95 in attrib.c::ntfs_find_vcn(). 
    (Adrian Bunk)
  o NTFS: Implement cluster (de-)allocation code
    (fs/ntfs/lcnalloc.[hc])
  o NTFS: Minor update to fs/ntfs/bitmap.c to only perform rollback if
    at least one bit has actually been changed.
  o NTFS: Fix fs/ntfs/lcnalloc.c::ntfs_cluster_alloc() to use
    LCN_RL_NOT_MAPPED rather than LCN_ENOENT as runlist terminator. 
    Also, make it not create a LCN_RL_NOT_MAPPED element at the
    beginning.
  o NTFS: Fix fs/ntfs/debug.c::ntfs_debug_dump_runlist() for the
    previous removal of LCN_EINVAL which was not used in the kernel
    NTFS driver.
  o NTFS: Only need two spare runlist elements when reallocating memory
    in fs/ntfs/lcnalloc.c::ntfs_cluster_alloc(), not three since we no
    longer add a starting element.
  o NTFS: - Load attribute definition table from $AttrDef at mount time
  o NTFS: 2.1.17 - Fix bugs in mount time error code paths

Anton Blanchard:
  o ppc64: reduce stack overflow warning threshold
  o ppc64: remove old asm offsets
  o ppc64: POWER4 oprofile update
  o ppc64: disable oprofile debug messages
  o ppc64: allow oprofile module to be safely unloaded
  o ppc64: add missing EXPORT_SYMBOLS for oprofile
  o ppc64: Fix oprofile error messages
  o Fix gcc 3.5 compile issue in mm/mempolicy.c

Antonino Daplas:
  o fbcon: EDD-based blacklisting
  o fbcon: ifferentiate bits_per_pixel from color depth
  o fbdev: set color fields correctly
  o fbdev: ATTN: Maintainers - Set correct hardware capabilities
  o rivafb: Do not tap VGA ports if not X86
  o i810fb fixes
  o fbdev: find correct logo for directcolor < 24bpp
  o rivafb: kill riva_chip_info and riva_chips
  o Video Mode Handling - Linked list of video modes
  o Video Mode Handling - Save per-display graphics/display settings
  o Video Mode Handling - Delete entries from mode list
  o Video Mode Handling - Reduce memory footprint of fbdev
  o fbdev: do the deletion of mode entries at fbdev level
  o fbdev: support for bold attribute for monochrome framebuffers
  o fbdev: use 8-bit DAC for capable hardware
  o rivafb: directcolor mode and miscellaneous fixes
  o epson1355fb: salvage epson1355 code from James' tree
  o neofb: salvage neofb from James' tree
  o sgivwfb: salvage sgivwfb from James' tree
  o tdfxfb: salvage tdfxfb from James' tree

Arjan van de Ven:
  o mark LOOP_CHANGE_FD as an ULONG compat ioctl

Arnd Bergmann:
  o [WATCHDOG] v2.6.8.1 compat_ioctl-patch
  o fix reading string module parameters in sysfs
  o clean up __always_inline__ usage

Arthur Othieno:
  o s390: Use include/asm-generic/dma-mapping-broken.h

Badari Pulavarty:
  o direct-io: size the BIOs more accurately
  o DIO pages-in-io accounting fix

Ben Dooks:
  o [ARM PATCH] 1995/1: S3C2410 - Clock controls
  o [ARM PATCH] 1991/1: S3C2410 - irq updates
  o [ARM PATCH] 1993/3:  S3C2410 DMA Support
  o [ARM PATCH] 2025/1: S3C2410 - default platform devices
  o [ARM PATCH] 2026/1: S3C2410 - header text for
    arch/arm/mach-s3c2410/s3c2410.h
  o [ARM PATCH] 2027/1: S3C2410 - initial documentation

Benjamin Herrenschmidt:
  o ppc32: Fix booting on some OldWolrd Macs
  o ppc32: remove hardcoded offsets from ppc asm

Benno:
  o kbuild: Use POSIX headers for ntoh functions

Bjorn Helgaas:
  o PCI: Document pci_disable_device()

Brian King:
  o blk_queue_free_tags() fix
  o blk_resize_tags() fix
  o handle blk_queue_tags_resize() allocation failures

Bruce Allan:
  o kNFSd: fix brokenness with fsid= export option

Bálint Márton:
  o get_random_bytes() returns the same on every boot

Cal Peake:
  o [IPV4]: Delete bogus newline in first TcpExt procsfs line
  o fix /proc/net/netstat output

Carl Spalletta:
  o remove dead prototypes

Chris Mason:
  o add BH_Eopnotsupp for testing async barrier failures
  o reiserfs v3 barrier support

Chris Wright:
  o rlimit-based mlocks for unprivileged users

Christian Borntraeger:
  o remove sync() from panic

Christoph Hellwig:
  o convert skge to pci_driver API (2nd try)
  o allow modular mv64340_eth
  o fix compiler warnings in mv64340_eth
  o remove dead code from mv64340_eth
  o [ATM]: Missing static in atm
  o [NET]: Add missing struct net_device forward decl to skbuff.h
  o [NET]: Missing header includes and forward declarations
  o [XFS] avoid using pid_t in ioctl ABI
  o idr.c: remove stale comment
  o split generic_file_aio_write into buffered and direct I/O parts

Christoph Lameter:
  o gettimeofday nanoseconds patch

Corey Minyard:
  o IPMI Watchdog handling updates
  o IPMI driver updates

Coywolf Qi Hunt:
  o kbuild: Remove wildcard on KBUILD_OUTPUT
  o kbuild: remove obsolete HEAD in kbuild

Dan Aloni:
  o d_unhash consolidation

Dave Boutcher:
  o ppc64: mf_proc file position fix

Dave Hansen:
  o ppc64: include profile.c in kernel/irq.c
  o ibmveth: race fixes
  o break out zone free list initialization

Dave Jiang:
  o [ARM PATCH] 1963/1: Intel XScale IOP310 removal
  o [ARM PATCH] 2018/1: Fixed Patch 2017

Dave Jones:
  o [CPUFREQ] new Dothan variant for speedstep-centrino
  o [CPUFREQ] Stop powernow-k7 printk'ing tab characters
  o [CPUFREQ] Fix sparse NULL ptr warning
  o [CPUFREQ] Trailing whitespace removal in longrun driver
  o [CPUFREQ] Fix FSB calculation in powernow-k7
  o [CPUFREQ] fix double "out-of-sync" warning on resume
  o [CPUFREQ] fix userspace resume support
  o [CPUFREQ] Make powernow-k7 debug printk a runtime option
  o [CPUFREQ] REmove more trailing whitespace
  o [CPUFREQ] Remove out of date comment from powernow-k7 This has had
    significant amount of testing since it got merged, and nothing
    nasty has actually ever happened.
  o [CPUFREQ] fix whitespace after merge
  o [CPUFREQ] reorder cpufreq.c for inlining
  o [CPUFREQ] fix CONFIG_ACPI_PROCESSOR="m",
    CONFIG_X86_POWERNOW_K{7,8}="y" build issue Fix the build dependency
    between powernow-k{7,8} and acpi/processor.o by adding a
    CONFIG_X86_POWERNOW_K{7,8}_ACPI bool, just like SPEEDSTEP_CENTRINO
    does it. See http://forums.gentoo.org/viewtopic.php?t=186887 for a
    bugreport.
  o [CPUFREQ] powernowk8_cpu_exit may not be __exit but can be
    __devexit
  o [CPUFREQ] Fix up some comments in longhaul
  o [CPUFREQ] abstract out powersaver code in longhaul driver
  o [CPUFREQ] disable interrupts around transitions in longhaul
  o [CPUFREQ] Longhaul compile fixes
  o [CPUFREQ] speedstep-smi: GET_SPEEDSTEP_FREQS may return bogus
    values
  o [CPUFREQ] speedstep-centrino: ignore 0xffff'ed P-States
  o [CPUFREQ] speedstep-ich SMT support
  o [CPUFREQ] A reduce-Jeremy's-mail patch
  o [CPUFREQ] speedstep-centrino: Remove unnecessary vendor checks
  o [CPUFREQ] fix HT oops on speedstep-ich system
  o [AGPGART] License updates
  o [CPUFREQ] compile fix
  o [CPUFREQ] Whitespace cleanup for centrino speedstep
  o [CPUFREQ] Better fix for previous speedstep-ich breakage
  o [CPUFREQ] Whitespace/CodingStyle fixes for speedstep-ich
  o [AGPGART] Delete confusing message when not using onboard i815 gfx
  o [AGPGART] Trailing whitespace cleanup
  o [AGPGART] Sparse trivial warning fixes
  o [AGPGART] SiS 635 support
  o [AGPGART] Fix MVP3 typo
  o Cset exclude: davej@redhat.com|ChangeSet|20040809142517|56351
  o [CPUFREQ] fix powernow-k8 compilation [bug 3180]
  o [CPUFREQ] avoid re-enabling of interrupts too early during resume
  o [CPUFREQ] deprecate proc_intf, and inform of removal ~2005-01-01
  o [CPUFREQ] deprecate proc_sys_intf, and inform users of removal
    ~2005-01-01
  o [CPUFREQ] Support VIA C3 Nehemiah's with 200MHz FSB
  o [CPUFREQ] fix typo on gx-suspmod.c

David Brownell:
  o USB: add CONFIG_USB_SUSPEND
  o USB: usb hub docs and locktree()
  o USB: usb_get_descriptor, more error checks
  o USB: hid intervals
  o USB: ehci and buggy BIOS handoff
  o USB: autoconf for gadget serial
  o USB: add <linux/usb_otg.h>

David Eger:
  o radeonfb: cleanup and little fixes

David Gibson:
  o orinoco merge preliminaries - squash backwards compatibility
  o orinoco merge preliminaries - rearrange code
  o orinoco merge preliminaries - use netdev_priv()
  o orinoco merge preliminaries - use ALIGN()
  o orinoco merge preliminaries - use ARRAY_SIZE()
  o orinoco merge preliminaries - spam stoppers
  o orinoco merge preliminaries - comment/whitespace/spelling updates
  o orinoco merge preliminaries - use BUG_ON()
  o orinoco merge preliminaries - make things static
  o orinoco merge preliminaries - miscelaneous
  o orinoco merge preliminaries - use name/version macros
  o orinoco merge preliminaries - remove unneeded #includes
  o orinoco merge preliminaries - don't typedef structs
  o orinoco merge preliminaries - more HW data
  o orinoco merge preliminaries - update authorship information
  o ppc64: C99 initializers in INIT_THREAD
  o ppc64: bolted SLB entry for iSeries

David S. Miller:
  o [IPV4]: Remove all references to IP_ROUTE_NAT support
  o [IPV4]: Move inetdev/ifa locking over to RCU
  o [IPV4]: Kill inetdev_lock, no longer needed
  o [IPV4]: Fix theoretical loop on SMP in ip_evictor()
  o [IPV6]: ip6_evictor() has same problem as ip_evictor()
  o [NETFILTER]: Convert SCTP conntrack over to ip_ct_refresh_acct()
  o [NETFILTER]: Export ip_conntrack_count for ip_conntrack_standalone
  o [NETFILTER]: Need to export ip_ct_log_invalid to modules
  o [NET]: Add skb_header_pointer, and use it where possible
  o [TCP]: When fetching srtt from metrics, do not forget to set
    rtt_seq
  o [IPV4/IPV6]: Fix direct user pointer deref in xfrm icmp changes
  o [NETFILTER]: Mark tcp_options skb arg as const
  o [VLAN]: __vlan_hwaccel_rx() needs to use dev_kfree_skb_any
  o [SUNGEM]: Fix locking in gem_interrupt()
  o [PKT_SCHED]: Fix unused label warning in ingress_init()
  o [SPARC64]: Fix PCI IOMMU invalid iopte handling
  o [SPARC64]: Revamped memcpy infrastructure
  o [SPARC64]: Fix bugs in new U1memcpy code
  o [SPARC64]: Kill bogus __strlen symbol and strncmp inline cruft
  o [SPARC64]: Implement little-endian bitops using normal ones
  o [SPARC64]: Durrrr, missed signal handling fix from 2.4.x
  o [SPARC64]: Update defconfig

David Vrabel:
  o [ARM PATCH] 2013/1: IXP4xx: Make clock monotonic

David Woodhouse:
  o [1/3] Split pci quirks array to allow separate declarations
  o [2/3] PCI quirks -- PPC
  o [3/3] PCI quirks -- i386
  o PCI quirks -- parisc
  o PCI quirks -- ppc64
  o PCI quirks -- other architectures

Davide Libenzi:
  o ptrace single-stepping fix
  o Don't use SYSGOOD for ptrace singlestep

Dean Roehrich:
  o [XFS] Fix lock leak in xfs_free_file_space

Deepak Saxena:
  o I2C: Add Intel IXP2000 GPIO-based I2C adapter
  o [5/3][ARM] PCI quirks update for ARM
  o Remove spaces from PCI IDE pci_driver.name field
  o Remove spaces from PCI I2C pci_driver.name fields
  o Remove spaces from PCI gameport pci_driver.name fields
  o Remove spaces from Skystar2 pci_driver.name field

Dimitri Sivanich:
  o Move cache_reap out of timer context
  o slab: locking optimization for cache_reap

Dipankar Sarma:
  o RCU - cpu-offline-cleanup
  o RCU - cpu offline fix
  o RCU: low latency rcu
  o rcu: clean up code
  o rcu: fix spaces in rcupdate.h
  o rcu: introduce call_rcu_bh()
  o rcu: use call_rcu_bh() in route cache
  o rcu: document RCU api
  o rcu: abstracted RCU dereferencing

Domen Puncer:
  o remove old ifdefs net/eepro100.c
  o USB: use list_for_each() in class/audio.c
  o USB: use list_for_each() in class/usb-midi.c
  o USB: use list_for_each() in core/devices.c
  o PCI: use list_for_each() i386/pci/pcbios.c
  o PCI: use list_for_each() i386/pci/common.c
  o PCI: use list_for_each() drivers/pci/setup-bus.c

Dominik Brodowski:
  o I2C: activate SMBus device on hp d300l

Douglas Gilbert:
  o [libata] fix INQUIRY handling

Duncan Sands:
  o USB: fix deadlock in hub_reset
  o USB: usbfs: drop the device semaphore in proc_bulk and proc_control
  o USB: usbfs: check the buffer size in proc_bulk

Eric Sandeen:
  o [XFS] Add filesystem size limit even when XFS_BIG_BLKNOS is in
    effect; limited by page cache index size (16T on ia32)
  o [XFS] Code checks to trap access to fsb zero

Eugene Surovegin:
  o ppc32: export __dma_sync & __dma_sync_page

Evgeniy Polyakov:
  o w1: attributes split, timeout unit changed
  o w1: Added w1_read_block() and w1_write_block() callbacks
  o w1: Added w1_check_family()
  o w1: Changed printing format for slave names
  o w1: Changed define for W1_FAMILY_SMEM
  o w1: Netlink update - changed event generating/processing
  o w1: Debug output cleanup. memcpy instead of direct structure
    copying
  o w1: Spelling fix
  o w1: Added  w1_smem.c - driver for simple 64bit ROM devices
  o w1: Added driver for Dallas' DS9490* USB <-> W1 master
  o w1: Added dynamic slave removal mechanism. Fixed bug when we have
    multiple slave with different families

François Romieu:
  o [netdrvr epic100] minor cleanups
  o [netdrvr epic100] napi 1/3 - just shuffle some code around
  o [netdrvr epic100] napi 2/3 - receive path
  o [netdrvr epic100] napi 3/3 - transmit path
  o [netdrvr epic100] napi fixes
  o epic100: spin_unlock_irqrestore avoidance
  o epic100: code removal in irq handler
  o r8169: napi support
  o r8169: cosmetic renaming of a register
  o r8169: janitoring
  o r8169: ethtool .set_settings
  o r8169: ethtool .get_{settings/link}
  o r8169: link handling and phy reset rework
  o r8169: initial link setup rework
  o r8169: gcc bug workaround
  o r8169: tx lock removal
  o via-velocity: PCI ID move
  o via-velocity: uniformize use of OWNED_BY_NIC
  o via-velocity: velocity_receive_frame diets
  o via-velocity: Rx buffers allocation rework
  o via-velocity: Rx copybreak
  o via-velocity: ordering of Rx descriptors operations
  o via-velocity: unneeded forward declarations
  o via-velocity: use common crc16 code for WOL
  o [VLAN]: Missing Kconfig help

Friedrich Lobenstock:
  o [WATCHDOG] pcwd-watchdog.txt-patch

Ganesh Varadarajan:
  o USB: fix for ipaq.c

Ganesh Venkatesan:
  o e1000 - ethtool support (register dump, interrupt
  o e1000 - Enable TSO
  o e1000 - Use vmalloc for data structures not shared
  o e1000 - TSO fixes (in preparation for IPv6 TSO)
  o e1000 - Avoid infinite loop while trying to
  o e1000 - include work down in tx path to decide when
  o e1000 - Use pci_dma_sync_single_[for_device|for_cpu]
  o e1000 - Shutdown PHY while bringing the interface
  o e1000 - add compiler hints (likely/unlikely), check
  o e1000 - more DPRINTK messages to syslog
  o e1000 - suspend/resume fix from alex@zodiac.dasalias.org
  o e1000 - white space and related cleanup
  o e100 - restore speed/duplex/autoneg settings after the completion
    of the diagnostic tests
  o e100 - Support for Intel(R) PRO/100 VE Network Connection (82562)
    adapter
  o e100 - fix stat counters rx_length_error and rx_over_errors
  o e100 - Support to load device firmware
  o e100 - Auto MDI/MDI-X support
  o e100 - driver version update

Glen Overby:
  o [XFS] Permit buffered writes to the real-time subvolume

Greg Howard:
  o Altix system controller communication driver

Greg Kroah-Hartman:
  o USB: fix build error in the cyberjack driver
  o PCI: update pci.ids from sf.net site
  o PCI Hotplug: fix build warnings due to msleep() patches
  o USB: fix build error from previous patch
  o USB: replace old usb-skeleton driver with a rewritten and simpler
    version
  o USB: convert a lot of usb drivers from MODULE_PARM to module_param
  o PCI: fix compiler warning in quirks file, and other minor quirks
    cleanup
  o PCI: clean up code formatting of quirks.c
  o PCI: oops, forgot to check in the pci.h changes so that the quirk
    cleanups will work
  o USB: finish up the last of MODULE_PARM to module_param conversions
  o MODULE: add byte type of module paramater, like the comments say we
    support
  o I2C: convert all drivers from MODULE_PARM to module_param
  o I2C: fix up the order of bus drivers in the Kconfig and Makefile
  o I2C: rename i2c-sensor.c file to prepare for Rudolf's VRM patch
  o MODULE: delete local static copy of param_set_byte as we now have a
    real version of it
  o USB: fix up ub.c due to usb_endpoint_running() going away
  o USB: fix up gadget driver usage of MODULE_PARM
  o W1: fix some improper '{' style code
  o W1: removed some unneeded global symbols from the w1_smem module
  o PCI Hotplug: fix compiler warnings in pciehp driver
  o USB: hook the ub driver up to the sysfs tree so that tools like
    udev work better

Hannes Reinecke:
  o Enable all events for initramfs

Harald Welte:
  o [NETFILTER]: ip_nat_snmp call skb_make_writable()
  o [NETFILTER]: ipt_ULOG fix for last packet delay
  o [NETFILTER]: Use new module_param() api
  o [NETFILTER]: Fix mutex declaration
  o [NETFILTER]: Use slab cache for ip_conntrack_expect
  o [NETFILTER]: Connection based accounting
  o [NETFILTER]: Move /proc/net/ip_conntrack to seq_file
  o [NETFILTER]: New ip_sctp match
  o [NETFILTER]: Make 'helper' list of ip_nat_core static
  o [NETFILTER]: init_conntrack() optimization
  o [NETFILTER]: Move error tracking into conntrack protocol helper
  o [NETFILTER]: Add conntrack runtime statistics
  o [NETFILTER]: Add tcp window tracking
  o [NETFILTER]: Missing sysctl.h bits from tcp window tracking changes
  o USB: Hackish fix for cyberjack driver
  o [NETFILTER]: New ip_conntrack_sctp
  o [NETFILTER]: Fix broken debug assertion

Herbert Xu:
  o Fix successive calls to spin_lock_irqsave in sk98lin
  o [IPV4]: Fix race in inetdev RCU handling
  o [IPV6]: Add missing XFRM select in Kconfig
  o [XFRM_USER]: Fill in x->props algo fields
  o [IPV6]: Fix aalg check in esp
  o [IPSEC]: Move encap check back down to esp4.c
  o [IRDA]: Trivial optimization in inetdev handling
  o [IPV4]: inetdev ifa_list handling fixes outside of net/ipv4
  o [IPV4]: inetdev ifa_list handling fixes for s390 drivers
  o [IPV4]: Make inet_select_addr() logic clearer
  o [IPV4]: Simplify ifa free handling code
  o [XFRM]: Kill unused flow_hash
  o [IPSEC]: Call xfrm6_rcv in xfrm6_tunnel_rcv
  o [IPSEC]: Use xfrm4_rcv in xfrm4_tunnel
  o [IPSEC]: Modularise xfrm_tunnel
  o [IPSEC]: Revert pskb change for x->type->output

Hideaki Yoshifuji:
  o [IPV6] don't try to insert same local route multiple times
  o [IPV6] export rt6_ins() as ip6_ins_rt()
  o [IPV6] addrconf_dst_alloc() to allocate new route for local address
  o [IPV4,IPV6] set idev/rt6i_idev to loopback instead of NULL, to omit
    checking if it is non-NULL
  o [IPV6] ensure rt6i_idev is non-NULL when setting up new rt6_info{}
  o [IPV6] take rt6i_idev into account when looking up routes
  o [IPV6] refer inet6 device via corresponding local route from
    address structure
  o [XFRM] Fix selector comparison against icmp{,v6} flows
  o [IPV4] XFRM: don't probe icmp type/code for hdrincl sockets
  o [DECONET]: Fix build with SYSCTL=n
  o [IPV6]: Use offsetof()
  o [IPV6]: Improve readability in ip6_flowlabel.c

Hollis Blanchard:
  o ppc64: HVSI driver

Ian Abbott:
  o USB: ftdi_sio doesn't re-assert DTR modem control line
  o USB: Add support for FT2232C chip to ftdi_sio

Ian Campbell:
  o I2C: algorithm and bus driver for PCA9564

Ingo Molnar:
  o context-switching overhead in X, ioport()

Iñaky Pérez-González:
  o aio.c: rename 'struct timeout' to 'struct aio_timeout'

Jan Blunck:
  o ext2_readdir() filp->f_pos fix

Janice M. Girouard:
  o new device driver to enable the IBM Multiport Serial Adapter

Jean Delvare:
  o I2C: Fix debug in w83781d driver
  o I2C: update the lm83 driver
  o I2C: port smsc47m1 to 2.6
  o I2C: fix for previous lm83 driver update

Jeff Garzik:
  o [libata] transfer mode cleanup
  o [libata] fix completion bug, better debug output
  o [libata] convert set-xfer-mode operation to use ata_queued_cmd
  o [libata] transfer mode bug fixes and type cleanup
  o [libata sata_promise] convert to using packets for non-data
    taskfiles
  o [libata sata_sx4] deliver non-data taskfiles using Promise packet
    format
  o [libata] pio/dma flag bug fix, and cleanup
  o [libata] update IDENTIFY DEVICE path to use ata_queued_cmd
  o [libata] ATAPI work - PIO xfer, completion function
  o [PCI, libata] Fix "combined mode" PCI quirk for ICH6
  o [libata ata_piix] make sure AHCI is disabled, if h/w is used by
    this driver
  o [libata] flags cleanup
  o [libata] ATAPI work - cdb len, new taskfile protocol, cleanups
  o [libata] (cosmetic) minimize diff with 2.4.x libata
  o Fix NFS client screw-up in fcntl f_op removal
  o [libata] support commands SYNCHRONIZE CACHE, VERIFY, VERIFY(16)
  o [libata] fix PIO data xfer on big endian
  o [libata] ATAPI PIO data xfer
  o [libata] add ioctl infrastructure
  o [libata] fix error recovery reference count
  o [ata] remove 'packed' attributed from struct ata_prd

Jens Axboe:
  o disk barriers: core
  o disk barriers: IDE
  o disk barriers: scsi
  o disk barriers: devicemapper
  o disk barriers: MD
  o ext3 barrier support
  o cdrom event notification fixes
  o update SG_IO command table

Jeremy Fitzhardinge:
  o [CPUFREQ] Recognise another Dothan variant in speedstep driver

Jesper Juhl:
  o inlining errors in drivers/scsi/aic7xxx/aic79xx_osm.c
  o fix inline related gcc 3.4 build failures in
    drivers/net/wan/dscc4.c

Jesse Barnes:
  o ACPI for 2.6

Jindrich Makovicka:
  o More HPT374 driver merge woes

Johann Cardon:
  o USB: New unusual_devs.h entry

John Levon:
  o fix OProfile events with zero event values

John Rose:
  o PCI: rpaphp build break - remove eeh register

Jon Neal:
  o USB: net2280 minor fixes

Jon Oberheide:
  o [CRYPTO]: Email update in crypto/arc4.c

Jose R. Santos:
  o Make i/dhash_entries cmdline work as it use to

Juergen Stuber:
  o USB: LEGO USB Tower, move reset from probe to open

Kalev Lember:
  o natsemi netpoll support

Karol Kozimor:
  o PCI: ASUS L3C SMBus fixup

Keith Owens:
  o Make i386 die() more resilient against recursive errors
  o i386 oops output: dump preceding code

Kevin Corry:
  o devicemapper: use an IDR tree for tracking minors

Kronos:
  o fbdev Kconfig dependency fixes

Kumar Gala:
  o add new ethernet driver 'gianfar'

Len Brown:
  o Cset exclude: torvalds@evo.osdl.org|ChangeSet|20040401021818|60003
  o [ACPI] ACPICA 20040402 from Bob Moore
  o [ACPI] ACPICA 20040427 from Bob Moore
  o [ACPI] ACPICA 20040514 from Bob Moore
  o [ACPI] ACPICA 20040527 from Bob Moore
  o [ACPI] ACPICA 20040615 from Bob Moore
  o [ACPI] update EC GPE handler to new ACPICA handler type
  o [ACPI] fix return-from-sleep PM/ACPI state conversion bug (David
    Shaohua Li)
  o [ACPI] enable Embedded Controller (EC)'s General Purpose Event
    (GPE) from David Shaohua Li
  o [ACPI] enable GPE for ECDT (David Shaohua Li)
  o [ACPI] reserve IOPORTS for ACPI (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=2641
  o [ACPI] reserve EBDA for Dell BIOS that neglects to. (David Shaohua
    Li) http://bugme.osdl.org/show_bug.cgi?id=2990
  o [ACPI] fix ability to set thermal trip points (Hugo Haas, Stefan
    Seyfried) eg. # echo -n "100:90:80:70:60:50" >
    /proc/acpi/thermal_zone/THRM/trip_points
    http://bugzilla.kernel.org/show_bug.cgi?id=2588
  o [ACPI] /proc/acpi/thermal_zone/THRM/cooling_mode Add concept of
    (mandatory) "critical", when (optional) "passive" and "active" are
    not present.  (Zhenyu Z Wang)
    http://bugzilla.kernel.org/show_bug.cgi?id=1770
  o [ACPI] save/restore ELCR on suspend/resume (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=2643
  o [ACPI] add SMP suport to processor driver (Venkatesh Pallipadi)
    http://bugzilla.kernel.org/show_bug.cgi?id=2615
  o [ACPI] Tell the BIOS Linux can handle Enhanced Speed Step (EST).
    (Venkatesh Pallipadi)
    http://bugzilla.kernel.org/show_bug.cgi?id=2712
  o [ACPI] IOAPIC suspend/resume (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=3037
  o [ACPI] ACPI bus support for wakeup GPE (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=1415
  o [ACPI] Create /proc/acpi/wakeup to allow enabling the optional
    wakeup event sources. (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=1415
  o [ACPI] Enable run-time CM button/LID events (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=1415
  o [ACPI] ACPICA 20040715 from Bob Moore
  o [ACPI] S3 is independent of CONFIG_X86_PAE (David Shaohua Li)
  o [ACPI] synchronize_kernel for idle-loop unload (Zwane Mwaikambo)
    http://bugzilla.kernel.org/show_bug.cgi?id=1716
  o [ACPI] fix build warning (Andrew Morton)
  o [ACPI] BIOS workaround allowing devices to use reserved IO ports
    Author: David Shaohua Li
    http://bugzilla.kernel.org/show_bug.cgi?id=3049
  o [ACPI] acpi for asus update from Karol Kozimor
  o [ACPI] acpi_bus_register_driver() now return a count consistent
    with pnp_register_driver() and pci_register_driver()
  o [ACPI] init wakeup devcies only if ACPI enabled (David Shaohua Li)
  o [ACPI] clean out blacklist entries that do nothing
  o [ACPI] Enter ACPI mode earlier Fixes two common boot failures due
    to buggy SMM BIOS code
  o fix main.c build warning
  o [ACPI] ia64 build fix

Lennert Buytenhek:
  o PCI: more New PCI vendor/device ID for Radisys ENP-2611 board

Linas Vepstas:
  o ppc64: fix eeh_memcpy_toio() prototype

Linda Xie:
  o PCI Hotplug: rpaphp_add_slot.patch
  o PCI Hotplug: rpaphp_get_power_level bug fix

Linus Torvalds:
  o Make 'WRITE_BUFFER' require CAP_RAWIO capability
  o Fix stupid thinkos in the fcntl f_op removal code
  o Linux 2.6.8.1
  o Add another Intel cache descriptor entry
  o Make some single-bit bitfields unsigned
  o Run 'indent' on BusLogic driver to keep Alan sane
  o Fix i2c-keywest compile
  o Don't use signed one-bit bitfields
  o sparse: don't use signed single-bit bitfields
  o Fix up 0/NULL confusion
  o Remove pointless cast-as-lvalue usage from modedb.c
  o Use inline function instead of macro
  o Use F_SETLK instead of F_SETLK64 in nfs locking code
  o Linux 2.6.9-rc1

Luca Risolia:
  o USB: New entry in MAINTAINERS
  o USB: SN9C10[12] driver update
  o USB: SN9C10[12] driver minor update
  o USB: SN9C10[12] driver update
  o include "compiler.h" in videodev.h

Manfred Spraul:
  o ipc: Add refcount to ipc_rcu_alloc
  o ipc: remove sem_revalidate
  o ipc: enforce SEMVMX limit for undo
  o cleanup of ipc/msg.c

Marcel Holtmann:
  o USB: fix ub driver

Margit Schubert-While:
  o prism54 Clean up dev ids totally

Mark Broadbent:
  o IO-APIC debug message reduction

Martin J. Bligh:
  o warning on NUMA-Q

Masahide Nakamura:
  o [IPV6] XFRM: decode icmpv6 session
  o [IPV6] XFRM: probe icmpv6 type/code when sending packets via raw
    socket
  o [IPV4] XFRM: decode icmp session
  o [IPV4] XFRM: probe icmp type/code when sending packets via raw
    socket

Matt Mackall:
  o move duplicate BUG and WARN_ON bits to asm-generic
  o Fix CON_BUF_SIZE usage
  o vprintk support
  o vprintk for ext2 errors
  o vprintk for ext3 errors
  o Fix netpoll cleanup on abort without dev

Matt Porter:
  o ppc32: optimize/fix timer_interrupt loop
  o ppc32: make PPC40x large tlb mapping optional
  o ppc32: add docs for noltlbs and nobats parameters
  o ppc32: fix warnings on Ebony MTD build

Matthew Dharm:
  o USB Storage: fix Genesys Logic based on info from vendor
  o USB Storage: improve debugging output in usb-storage
  o USB Storage: cleanups, mostly

Matthew Wilcox:
  o PA-RISC sound updates
  o Kconfig updates for PA-RISC

Michael Opdenacker:
  o [ARM PATCH] 2023/1: platform_device definitions no longer needed in
    include/asm-arm/hardware.h

Mika Kukkonen:
  o Fix warnings drivers/net/sk98lin/skaddr.c

Mikael Pettersson:
  o arch/i386/kernel/smp.c gcc341 inlining fix

Mike Kravetz:
  o proc fs task name locking fix

Mike Miller:
  o cciss: fixes to 32/64-bit conversions
  o cciss: zero out buffer in passthru ioctls for HP utilities
  o cciss: /proc fixes
  o cciss: cylinder calculation fix
  o cciss: id change for V100 controller
  o cciss: V100 PCI ID fix again
  o cciss: pdev->intr fix
  o cciss: read_ahead bumped to 1024
  o cciss update 8 maintainers update for HP

Nabil Sayegh:
  o USB: ipaq module: product id for HTC Himalaya

Nathan Bryant:
  o [ACPI] restore PCI Interrupt Link Devices upon resume

Nathan Fontenot:
  o ppc64: fix enable_surveillance() for power5

Nathan Lynch:
  o ppc64: tweak schedule_timeout in __cpu_die

Nathan Scott:
  o [XFS] Sync up with the 2.4 fix for updating i_size under i_sem
  o [XFS] Update documentation
  o [XFS] Export blk_get_backing_dev_info for filesystems to use
  o [XFS] Revert to using a separate inode for metadata buffers once
    more
  o [XFS] Remove unneeded escape from printed string.  From Chris
    Wedgwood
  o [XFS] sparse: remove unneeded casts for user buffers.  From Chris
    Wedgwood
  o [XFS] sparse: annotate source for user pointers.  From Chris
    Wedgwood
  o [XFS] sparse: annotate quota source for user pointers.  From Chris
    Wedgwood
  o [XFS] sparse: annotate vfs interfaces for user pointers.  From
    Chris Wedgwood
  o [XFS] sparse: fix warnings in debug/tracing code.  From Chris
    Wedgwood
  o [XFS] Fix a possible data loss issue after an unaligned unwritten
    extent write.
  o [XFS] Fix xfs_off_t to be signed, not unsigned; valid warnings
    emitted after stricter compilation options used by some OSDL folks.
  o [XFS] xfs_Gqm_init cannot fail, dont check return value
  o [XFS] sparse: fix header include order to get cpp macros defined
    correctly.  From Chris Wedgwood.
  o [XFS] sparse: rework previous mods to fix warnings in DMAPI code
  o [XFS] sparse: fix warnings in IO path tracing code.  From Chris
    Wedgwood
  o [XFS] sparse: fix uses of NULL in place of zero and vice versa
  o [XFS] sparse: fix remaining NULL vs zero uses
  o [XFS] Fix signed/unsigned issues in xfs_reserve_blocks routine
  o [XFS] Fix accidental reverting of sync write preallocations
  o [XFS] Fix a blocksize-smaller-than-pagesize hang when writing
    buffers with a shared page.
  o [XFS] Remove several macros which are no longer used anywhere
  o [XFS] Use sparse whitespace approach that Al took to be more
    consistent.  Couple more sparse fixes
  o [XFS] Add a realtime inheritance bit for directory inodes so new
    files can be automatically created as realtime files.
  o [XFS] Add 32bit ioctl translation

Neil Brown:
  o multipath readahead fix fix
  o nfsd: force server-side TCP when NFSv4 enabled
  o nfsd: nfsd is missing a put_group_info in the auth_null
  o nfsd: make cache_init initialize reference count to 1
  o nfsd: simplify auth_domain_lookup
  o nfsd: fix ip_map cache reference count leak
  o nfsd: basic v4 ACL definitions
  o nfsd: POSIX<->NFSv4 acl translation for nfsd
  o nfsd: ACL support for the NFSv4 server
  o kNFSd: get rid of open_private_file
  o kNFSd: minor memory leak fix
  o kNFSd: fix two xdr-encode bugs for readdirplus reply
  o kNFSd: fix race with flushing nfsd cache
  o knfsd: fix server permission handling

Nick Piggin:
  o make shrinker_sem an rwsem

Nicolas Boichat:
  o Rivafb I2C fixes

Nicolas Kaiser:
  o [CRYPTO]: Typo in crypto/Kconfig
  o [CRYPTO]: Typo in crypto/twofish.c
  o [CRYPTO]: Typo in crypto/aes.c
  o [CRYPTO]: Typo in crypto/scatterwalk.c
  o [CRYPTO]: Typo in crypto/blowfish.c
  o [CRYPTO]: Typo in crypto/tcrypt.h

Nicolas Pitre:
  o [ARM PATCH] 1866/4: kernel support for iWMMXt present on some
    XScale cores
  o [ARM PATCH] 1909/1: add a cached definition of ioremap

Nishanth Aravamudan:
  o USB: pxa2xx_udc.c: replace schedule_timeout() with msleep()
  o USB: ov511: replace schedule_timeout() with msleep()
  o USB: auerswald: replace schedule_timeout() with msleep()
  o USB: usbnet: replace schedule_timeout() with msleep()
  o PCI Hotplug: cpci_hotplug_core: replace schedule_timeout() with
    msleep()
  o PCI Hotplug: ibmphp: remove long_delay
  o PCI Hotplug: ibmphp_core: replace long_delay() with msleep()
  o PCI Hotplug: ibmphp_hpc: replace long_delay() with msleep()
  o PCI Hotplug: shpchp_hpc: replace schedule_timeout() with msleep()
  o I2C: i2c-keywest: replace schedule_timeout() with msleep()
  o I2C: i2c-algo-pcf: replace schedule_timeout() with msleep()
  o I2C: i2c-ite: replace schedule_timeout() with msleep()
  o I2C: i2c-nforce2: replace schedule_timeout() with msleep()
  o I2C: scx200_acb: replace schedule_timeout() with msleep()
  o PCI: replace schedule_timeout() with msleep()

Nobuyuki AKIYAMA:
  o NMI trigger switch support for debugging(updated)

Oliver Neukum:
  o USB: ACM USB modem on Kernel 2.6.8-rc2

Olof Johansson:
  o ppc64: switch screen_info init to C99

Patrick McHardy:
  o [RBTREE]: Add rb_last()
  o [NET_SCHED]: Replace eligible list by rbtree in HFSC scheduler
  o [NET_SCHED]: Replace actlist by rbtrees in HFSC scheduler
  o [NET_SCHED]: O(1) children vtoff adjustment in HFSC scheduler
  o [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
  o [PKT_SCHED]: Resolve race condition with module unload in
    qdisc_create()
  o [PKT_SCHED]: Remove unnecessary memsets in packet schedulers
  o [XFRM]: Mark some functions/data static
  o [PKT_SCHED]: Fix class leak in CBQ scheduler
  o [PKT_SCHED]: Missing dev_put in error path

Paul Clements:
  o nbd: fix struct request race condition

Paul Gortmaker:
  o Remove obsolete code in 8390 driver

Paul Mackerras:
  o PPC64 Segment table code cleanup - move to arch/ppc64/mm
  o PPC64 Segment table code cleanup - kill bitfields
  o PPC64 Segment table code cleanup - assorted cleanups
  o PPC64 Segment table code cleanup - remove check duplication
  o PPC64 Segment table code cleanup - replace flush_stab() with
    switch_stab()
  o ppc32: handle misaligned string/multiple insns
  o ppc32: emulate obsolete instructions
  o ppc32: Fix bug in altivec emulation
  o ppc64: set time-related systemcfg fields
  o ppc64: use platform numbering of cpus for hypervisor calls
  o ppc64: use cpu_present_map in ppc64
  o ppc64: rework secondary SMT thread setup at boot
  o ppc64: remove unnecessary cpu maps
  o ppc64: set tbl->it_type in iommu code
  o ppc64: Don't call scheduler on offline cpu
  o ppc64: fix idle loop for offline cpu
  o ppc64: log firmware errors during boot
  o ppc64 Fix unbalanced pci_dev_put in EEH code
  o ppc64: Reduce verbosity of RTAS error logs
  o ppc64: rtas_call was calling kmalloc too early
  o ppc64: better little-endian bitops
  o ppc64: Extend ioremap/iounmap infrastructure
  o ppc64: Use correct buffer size in RTAS call
  o ppc64: use struct list_head for hose_list

Pavel Machek:
  o [CPUFREQ] Typo fixes
  o [CPUFREQ] Fix up deprecation notices

Pavel Roskin:
  o kbuild: Bogus "has no CRC" in external module builds

Pete Zaitcev:
  o USB: add ub driver

Phil Dibowitz:
  o USB: Debug fix in pl2303

Rajesh Venkatasubramanian:
  o prio_tree: kill vma_prio_tree_init()
  o prio_tree: iterator + vma_prio_tree_next cleanup

Ralf Bächle:
  o New driver for MV64340 GigE
  o [netdrvr mv643xx] rename from mv64340 to mv643xx
  o GT96100 update
  o [4/3] PCI quirks -- MIPS

Ram Pai:
  o readahead: simplify recent fixes
  o readahead fixes

Randy Dunlap:
  o kconfig: save kernel version in .config file
  o fix warnings in scripts/binoffset.c
  o scripts/patch-kernel: use EXTRAVERSION
  o tg3 section fix
  o awe_wave (OSS): too much __exit

Raphael Zimmerer:
  o PCI: fix PCI access mode dependences in arch/i386/Kconfig
  o PCI: fix PCI access mode dependences in arch/i386/Kconfig again
  o Support for Exar XR17C158 Octal UART

Rik van Riel:
  o token based thrashing control
  o increase per-user mlock limit default to 32k

Roger Luethi:
  o Restructure reset code
  o fix mc_filter on big-endian arch
  o Remove lingering PHY special casing
  o Rewrite PHY detection
  o Remove options, full_duplex parameters
  o Fix Tx engine race for good
  o Media mode rewrite
  o Small fixes and clean-up
  o Add WOL support
  o PCI: saved_config_space -> u32
  o proc_pid_cmdline() race fix

Roland McGrath:
  o Fix x86-64 singlestep through sigreturn system call

Rudolf Marek:
  o I2C: automatic VRM detection part1
  o I2C: automatic VRM detection part2

Russell King:
  o [MMC] Add MMC core support
  o [MMC] Add Kconfig/Makefile changes for MMC support
  o [MMC] Add ARM MMCI Primecell driver
  o [MMC] Add PXA MMC interface support
  o [MMC] Fix PXA MMC interface issues
  o [MMC] MMCI updates
  o [MMC] Fix some review points from Jens Axboe
  o [MMC] Fix PXA MCI driver name
  o [MMC] Use a consistent naming to refer to mmc_request,
    mmc_blk_request and request structures to avoid confusion.
  o [MMC] Fix end of request handling
  o [ARM] Move bootmem_init() call into paging_init()
  o [ARM] Add ARM AMBA CLCD framebuffer driver
  o [ARM] Add CLCD support for Versatile platform
  o [ARM] Add CLCD support for Integrator/CP platform
  o [ARM] Add CLCD support for IM-PD/1 board
  o [ARM] Fix Integrator CPUFREQ support
  o [ARM] Deprecate virt_to_bus/bus_to_virt
  o [ARM] Use bit 30 for PREEMPT_ACTIVE, delete unused TIF_USED_FPU
  o [ARM] Remove unnecessary get_user/put_user checks
  o [ARM] Update mach-types
  o [ARM] Add a structure name to pxa_dma_desc
  o [MMC] Update PXAMCI for later kernels
  o [MMC] Fix race condition in MMCI write-path data channel
  o [MMC] Avoid potential oops in MMCI
  o [MMC] Cleanup: Make MMCI debug macro take host, format and
    arguments
  o [MMC] MMCI optimisations

Ryan S. Arnold:
  o HVCS fixes

Sam Ravnborg:
  o kbuild: Check for undefined symbols in vmlinux
  o kbuild/sparc: Use new generic mksysmap script to generate
    System.map
  o kbuild: Selective compile of targets in scripts/
  o kbuild: Use LINUXINCLUDE to specify include/ directory
  o kbuild: Accept absolute paths in clean-files and introduce
    clean-dirs
  o kbuild: Separate out host-progs handling
  o kbuild: Introduce hostprogs-y, deprecate host-progs
  o kbuild: Replace host-progs with hostprogs-y
  o kbuild: Fix hostprogs-y
  o kbuild: __crc_* symbols in System.map
  o kbuild: Generate *.lds instead of *.lds.s
  o kbuild/all archs: Rename *.lds.s to *.lds
  o Cset exclude: adobriyan@mail.ru|ChangeSet|20040815084554|35832
  o bk: ignore arch/*/kernel/vmlinux.lds
  o kconfig/all archs: Introduce Kconfig.debug
  o kbuild: Allow external modules to use host-progs with no warning
  o kbuild/ia64: Fix breakage in arch/ia64/kernel/Makefile
  o kbuild: Fix parallel build in a distclean'ed tree
  o kbuild: make C=2 now force sparse to be run for all .c files
  o kbuild: Remove check for undefined symbols in vmlinux
  o kbuild: add comments to Makefile.clean
  o kbuild/all archs: added CHECKFLAGS
  o kbuild: Consolidated cc support function
  o kbuild/all archs: Utilise the cc-* functions

Samuel Thibault:
  o Subject: cdrom.c get_last_written fixup

Santiago Leon:
  o ibmveth: module tag fixes
  o ibmveth: hypervisor return value fix
  o ibmveth: add memory barrier for hypervisor synchronisation

Sascha Hauer:
  o [ARM PATCH] 1955/3: Motorola i.MX architecture support

Scott Feldman:
  o e100: use NAPI mode all the time

Sean Neakums:
  o kill UDF registration/unregistration messages

Shai Fultheim:
  o percpu: cpu_gdt_table
  o percpu: init_tss
  o percpu: cpu_tlbstate

Srivatsa Vaddagiri:
  o ppc64: Fix v_regs pointer setup

Stephen Hemminger:
  o [sparse] minor #if complaint
  o module_param for acenic
  o acenic - don't print eth%d in messages
  o [EBTABLES]: Remove deprecated use of MODULE_PARM
  o [NET]: Enhanced version of net_random()
  o [ATALK]: Fix build with SYSCTL=n

Stephen Rothwell:
  o ppc64 iSeries virtual DVD-RAM

Suparna Bhattacharya:
  o Fix writeback page range to use exact limits
  o mpage writepages range limit fix
  o filemap_fdatawrite range interface

Takashi Iwai:
  o i810_audio: Fix the error path of resource management

Thierry Vignaud:
  o fix compiling oldconfig with gcc-3.5

Timothy Shimmin:
  o [XFS] Fix up handling of SB versionnum when filesystem on disk has
    newer bit features than the kernel.

Tony Lindgren:
  o [ARM PATCH] 2005/1: OMAP update 1/6: Add McBSP support
  o [ARM PATCH] 2006/1: OMAP update 2/6: Board support files for OMAP
    H2 and H3
  o [ARM PATCH] 2007/1: OMAP update 3/6: Arch files
  o [ARM PATCH] 2008/1: OMAP update 4/6: Include files
  o [ARM PATCH] 2009/1: OMAP update 5/6: Remove old OMAP bus
  o [ARM PATCH] 2010/1: OMAP update 6/6: Add leds support for H2

Trond Myklebust:
  o Fix posix file locking (1-9)
  o NLM: Fix a bug which causes a newly granted lock to be immediately
    unlocked on the server side if blocking has occurred.
  o RPC: Reduce stack utilization for all synchronous NFS operations by
    using a dynamically allocated rpc_task structure instead of
    allocating one on the stack.  This reduces stack utilization by
  o NFSv4: ask the server to send us more readdir records per RPC call
  o RPC: Add missing variable initialization in rpc_clone_client()
  o NFSv3/v4: be more efficient when doing ACCESS RPC calls. Always ask
    for the full set of permissions.
  o NFSv4: Optimizing away the case of negative dentries in
    nfs_open_revalidate() avoids several atomicity problems.
  o NFSv4: Fix the symlink overflow bug
  o RPC: Improved buffer overrun checking in call_verify
  o RPCSEC_GSS: Remove an unused parameter
  o NFSv4: OK, so it's trivial and probably superfluous, but I don't
    see why we shouldn't be slightly stricter here, so I'm just going
    to keep sending this until I'm told to stop.... Make sure that
    unmapped errors are approximately in the range of defined NFS4
    errors.
  o RPCSEC_GSS: Missing newline in dprintk
  o RPCSEC_GSS: Add the spkm3 common and client-side code
  o NFS: Break the nfs_wreq_lock into per-mount locks. This helps
    prevent a heavy read and write workload on one mount point from
    interfering with workloads on other mount points.
  o NFS: Clean up the logic that handles recovery from a failed mount
    request. Get rid of nfs_put_super.
  o NFS: In 2.4, NFS O_DIRECT used the VFS's O_DIRECT logic to provide
    direct I/O support for NFS files.  The 2.4 VFS O_DIRECT logic was
    block based, thus the NFS client had to provide a minimum allowable
    blocksize for O_DIRECT reads and writes on NFS files. 
  o NFS: While the storage container for NFS file handles must be able
    to store 128 bytes, usually NFS servers don't use file handles that
    are more than 32 bytes in size.  This patch creates an efficient
    mechanism for comparing file handles that ignores the unused bytes
    in a file handle.
  o NFS: Now that file handle comparison ignores the unused parts of
    the file handle container, there is no longer any need to clear the
    file handle container before copying in a file handle.  This allows
    us to remove a 128 byte memset() from several hot paths.
  o KCONFIG: In the kernel help for NFSv3 & NFSv4 client support both
    are listed as "the newer version ... of the NFS protocol".
    Obviously both can't be the newer version at the same time, so
    here's a patch to correct the text in such a way that only v4 is
    listed as the newer version. Patch is against 2.6.7-rc3 - please
    consider including it.
  o NFSv2: In the NFSv3 RFC, the sattr3 structure passed in the SETATTR
    call allows for the client to request that the mtime and/or atime
  o NFSv4: Fix up the exception handling. Ensure we always handle
    NFS4ERR_DELAY properly.
  o NFSv4: Clean up the reboot recovery. Ensure that we exclude
    stateful
  o NFSv4: On server reboot we need to recover byte-range locks
  o NFSv4: Prime SETCLIENTID call for the delegation callback info
  o NFSv2/v3/v4: Place NFS nfs_page shared data into a single structure
    that hangs off filp->private_data. As a side effect, this also
    cleans up the NFSv4 private file state info.
  o NFSv4: More cleanups of the NFSv4 state
  o NFSv4: don't retry CREATE operations if the server returns
    NFS4ERR_DELAY on the GETATTR call.
  o NFSv2/v3/v4: Make the rpc_ops->getattr method take a filehandle
    rather than an inode argument. Fix up nfs_instantiate() and
    _nfs4_do_open to use this since doing a new lookup might be racy.
  o NFSv4: Basic code for managing delegation state
  o NFSv4: Add support for a delegation callback server
  o NFSv4: XDR cleanups in preparation for delegations
  o NFSv4: Further XDR cleanups in preparation for delegations
  o NFSv4: Service delegation recall requests from the server
  o NFSv4: More delegation recall code
  o NFSv4: Recover delegations on server reboot
  o NFSv4: Delegated open
  o NFSv4: More aggressive caching if we have a delegation
  o NFSv4: return all delegations we hold if the server issues a
    NFS4ERR_CB_PATH_DOWN error.
  o NFSv4: Enable delegations by actually telling the server about our
    recall ability.
  o RPC,NFSv4: NFSv4 operations that create or destroy state on the
    server are not allowed to be interrupted as that may result in the
    client and server disagreeing.

Venkatesh Pallipadi:
  o [CPUFREQ] Adding SMP capability to MSR based Enhanced Speedstep

Vernon Mauery:
  o PCI Hotplug: acpiphp extension for 2.6.7, part 1
  o PCI Hotplug: acpiphp extension for 2.6.7 part 2

William Lee Irwin III:
  o [ACPI] acpi_system_write_wakeup_device() has the wrong return type
    and is missing the __user attribution from its buffer argument.
  o [RXRPC]: Fix build with SYSCTL=n
  o sparc: remove undefined symbol

Wim Van Sebroeck:
  o [WATCHDOG] v2.6.8.1 cpu5wdt.c-nonseekable_open-patch
  o [WATCHDOG] v2.6.8.1 watchdog-llseek-patch

Zou Nanhai:
  o fix might-sleep-in-atomic while dumping elf

Zwane Mwaikambo:
  o x86: move PIT code to timer_pit

