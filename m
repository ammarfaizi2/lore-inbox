Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUB0XGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUB0XGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:06:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:37803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263191AbUB0W5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:57:54 -0500
Date: Fri, 27 Feb 2004 15:03:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.4-rc1
Message-ID: <Pine.LNX.4.58.0402271458480.1078@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, as usual, there was a lot of stuff for the -rc1, but as seems to be
more and more true it is mainly in the "periphery".

This is a big patch, but the bulk of it is a long-overdue MIPS update, and
the (working) HFS/HFS+ filesystem update (total rewrite), and ISDN
updates. And some large s390 driver updates too, for that matter.

So please keep bigger updates to yourself, and let's calm this down.

		Linus

----

Summary of changes from v2.6.3 to v2.6.4-rc1
============================================

<ken:miriam.com>:
  o [TIGON3]: Add Apple tigon3 PCI device id

Adam Belay:
  o PCI: remove unused defines in pci.h

Alan Stern:
  o USB: Remove unneeded and error-provoking variable in UHCI
  o USB: Even out distribution of UHCI interrupt transfers
  o USB: ERRBUF_LEN compiling error when PAGE_SIZE=64KB on IA64
  o USB: Simplify locking in UHCI
  o USB: Mask "HC Halted" bit in the UHCI status register
  o USB Storage: Handle excess 0-length data packets
  o USB Storage: Treat STALL as failure for CB[I]
  o USB Storage: Reduce auto-sensing for CB transport
  o USB Storage: unusual_devs.h fixup
  o USB: Improve UHCI root hub code: descriptor, OC bits, etc
  o USB: More UHCI root hub code improvements
  o USB: Another unusual_devs.h update
  o USB: Repair unusual_devs.h entry
  o USB: Use driver-model logging in the UHCI driver

Alexander Viro:
  o [wan lapb] beginning of cleanups
  o [wan lapb] switch to use net_device instead of custom token
  o [wan lapb] Printks switched from %p lapb->token to %p lapb->dev
  o [wan lapb] kill now-unused custom token container
  o [wan hdlc] hdlc_open() switched to net_device
  o [wan hdlc] hdlc_close() switched to net_device
  o [wan hdlc] new port_to_dev() helper
  o [wan hdlc] switch sca_xxx() to use net_device
  o [wan hdlc] hdlc_set_carrier() switched to net_device
  o [wan hdlc] hdlc->attach() switched to net_device
  o [wan farsync] Eliminated a bunch of port->hdlc and hdlc_to_dev()
    uses
  o [wan hdlc] hdlc->proto.*() switched to net_device
  o [wan hdlc] hdlc_cisco: killed ->netdev, hdlc_to_name() and
    hdlc_to_dev() uses
  o [wan hdlc] hdlc_fr: eliminated ->netdev, hdlc_to_dev() and
    hdlc_to_name() uses
  o [wan hdlc_x25] eliminated hdlc_to_dev() and hdlc_to_name() uses
  o [wan wanxl] eliminated hdlc_to_name() uses and a bunch of
    port->hdlc ones
  o [wan hdlc] switch internal ioctl dispatch to net_device
  o [wan pc300] more direct use of net_device
  o [wan hdlc] new hdlc_stats() helper
  o [wan dscc4] Uses of ->hdlc and hdlc_to_dev() encapsulated into
    dscc4_to_dev()
  o [wan hdlc] switch register_hdlc_device() to take net_device arg
  o [wan hdlc] new private struct pointer in hdlc_device, and helpers
    for it
  o [wan hdlc] kill embedded struct in various drivers
  o [wan pc300]  use alloc_hdlcdev()/free_hdlcdev().  Leak fixed
  o [wan farsync] embedded struct hdlc_device removal
  o [wan dscc4] embedded struct removal
  o [wan hdlc] removal hdlc_to_dev()
  o [wan hdlc] kill embedding of struct net_device
  o [wan hdlc_fr] Switched allocation of net_device to alloc_netdev()
  o [wan hostess_sv11] sane net_device allocation
  o [wan sbni] sane net_device allocation; plug a bunch of leaks
  o [wan sealevel] Plugged a leak
  o [netdrvr tun] Killed bogus ->init()
  o [wireless airo] switched to sane allocation
  o [netdrvr s390/netiucv] partially sanitized wrt allocation
  o [netdrvr fec] switched to sane allocation.  It still leaks on
    failure exits, though
  o [wan sdla] Fixed leaks and double-free
  o [netdrvr isa-skeleton] cleanups and fixes
  o [all over] more kfree -> free_netdev
  o [netdrvr acenic] Race and leak fixes
  o [netdrvr 3c509] Leak fixed
  o [netdrvr apne] resource leak fix
  o [wireless orinoco] check alloc_etherdev for failure
  o [netdrvr s390/lcs] Leak fix
  o [wan] leak fixes in hostess_sv11, lapbether
  o [netdrvr arm/am79c961] Fix for IO-before-request_region race
  o [netdrvr saa9730] fix double-free
  o [netdrvr arch/uml] leak fix
  o [netdrvr dvb/dvb_net] fixes
  o [netdrvr shaper] fix double-free
  o [netdrvr s390/qeth] Alloc fixes
  o Remove unused and invalid 'struct ppp' definition from if_pppvar.h
  o [wan] apply hdlc cleanups to new driver pci200syn
  o [PKT_SCHED]: Convert to {subsys,module}_initcall(), fix init
    failure bugs in sch_teql.c
  o [IPV6]: Kill MODULE ifdeffing, common init for sysctls
  o [IPV4/IPV6]: Convert tunnel drivers to unconditional module_init
  o [DECNET]: Zap MODULE ifdefs
  o removal of bogus CONFIG_BINFMT_ELF uses
  o intermezzo ->permission() idiocy
  o typo fix in intermezzo patch
  o au1k leaks, allocation and free_netdev() fixes
  o vlsi_ir leak, allocation and freeing fixes
  o [WANROUTER]: Kill MODULE ifdefs
  o remove init_{etherdev,netdev} and dev_alloc
  o removal of ifdef MODULE from fs/openpromfs
  o Clean up __cacheline_aligned

Alexandre Oliva:
  o Improve code generation for x86 raid XOR functions

Amir Noam:
  o [netdrvr bonding] Cannot remove and re-enslave the original active
    slave
  o [netdrvr bonding] Releasing the original active slave causes mac
    address duplication
  o [netdrvr bonding] Add support for slaves that use ethtool_ops
  o [netdrvr bonding] fix build breakage
  o [bonding 2.6] Fix compilation warning in bond_alb.c
  o [bonding 2.6] Save parameters in a per-bond data structure
  o [bonding 2.6] Use the per-bond value of the bond_mode parameter
  o [bonding 2.6] Use the per-bond values of all remaining parameters

Andi Kleen:
  o Intel x86-64 support merge
  o Update i386 microcode driver for x86-64
  o Enable Intel AGP on x86-64
  o Allow P4 oprofile code for x86-64
  o x86-64 merge for 2.6.3
  o New machine check handler for x86-64
  o Run 32bit compat ioctl handlers in BKL
  o Support AGP bridge on Nvidia Nforce3 + cleanup

Andre:
  o [ARM] Optimise ARM720T Thumb abort unwinding

Andreas Gruenbacher:
  o CONFIG_REGPARM breaks non-asmlinkage syscalls

Andrew Morton:
  o tulip printk warning fix
  o ISDN udpate
  o i4l: hisax deadlock fix
  o Fix for PPP activ/passiv filter
  o ia32 early printk
  o early printk tweaks
  o Remove BDEV_RAW and friends
  o msg.h needs list.h
  o ppc64: Fix prom.c warnings
  o ppc64: fix saved_command_line/cmd_line lengths
  o ppc64: fix debugger() warnings
  o ppc64: iseries IRQ fix
  o loop: remove the bio remapping capability
  o remove useless highmem bounce from loop/cryptoloop
  o loop: BIO handling fix
  o loop.c doesn't fail init gracefully
  o loop: remove redundant initialisation
  o ACPI PM timer
  o kthread primitive
  o Remove kstat cpu notifiers
  o Minor workqueue.c cleanup
  o Remove More Unneccessary CPU Notifiers
  o Use CPU_UP_PREPARE properly
  o Limit hashtable sizes
  o add Pentium M and Pentium-4 M options
  o gcc 2.95 supports -march=k6 (no need for check_gcc)
  o AMD Elan is a different subarch
  o Documentation: remove /etc/modules.conf refs
  o add some more MODULE_ALIASes
  o bonding alias revert and documentation fix
  o NGROUPS 2.6.2rc2 + fixups
  o Mark intermezzo as broken
  o bd_set_size i_size handling
  o snprintf fixes
  o devfs: race fixes and cleanup
  o Enable coredumps > 2GB
  o MIPS: New 2.6 serial drivers
  o #if versus #ifdef cleanup
  o kNFSd: Fix possible scheduling_while_atomic in cache.c
  o kNFSd: Allow sunrpc/svc cache init function to modify the "key"
  o kNFSd: ip_map_init does a kmalloc which isn't checked
  o kNFSd: convert NFS /proc interfaces to seq_file
  o kNFSd:fix build problems in nfs w/o proc_fs on 2.6.0-test5
  o md: Print "deprecated" warning when START_ARRAY is used
  o md: Split read and write end_request handlers
  o md: Discard the cmd field from r1_bio structure
  o md: Remove some un-needed fields from r1bio_s
  o md: Avoid unnecessary bio allocation during raid1 resync
  o md: Dynamically limit size of bio requests used for raid1 resync
  o md: Allow partitioning of MD devices
  o dm: Export dm_vcalloc()
  o dm: Move to_bytes() and to_sectors() into dm.h
  o dm: Get rid of struct dm_deferred_io in dm.c
  o dm: Maintain ordering when deferring bios
  o dm: Tidy up the error path for alloc_dev()
  o dm: Correct GFP flag in dm_table_create()
  o dm: Zero size target sanity check
  o dm: Remove redundant spin lock in dec_pending()
  o dm: drop BIO_SEG_VALID bit
  o 8259 timer ack fix
  o Fix printk level on non fatal MCEs
  o MCE fixes and cleanups
  o Rename bitmap_snprintf() and cpumask_snprintf() to *_scnprintf()
  o OSS: remove #ifdef's for kernel 2.0
  o remove kernel 2.2 #ifdef's from {i,}stallion.h
  o kbuild documentation fix
  o adfs: remove a kernel 2.2 #ifdef
  o defer panic for too many items in boot parameter line
  o cpufreq_scale() fixes
  o Minor cross-compile issues
  o /proc thread visibility fixes
  o drivers/char/vt possible race
  o off_t in nfsd_commit needs to be loff_t
  o skip offline CPUs in show_free_areas
  o fix display of NBD in /proc/partitions
  o cleanup patch that prepares for 4Kb stacks
  o 3c59x: bring back the `enable_wol' option
  o Oprofile: fix nmi_timer_int detection
  o oprofile: ARM infrastructure
  o oprofile: add Pentium Mobile support
  o remove max_anon limit
  o Fix __release_region() race
  o Documentation on how to debug modules
  o Module headers cleanup
  o add clock_was_set() to all architectures
  o Fix race in epoll_ctl(EPOLL_CTL_MOD)
  o slab: remove extraneous printk
  o do_swap_page() return value fix
  o ide-tape: remove obsolete onstream support
  o Disable bootmem warning
  o dm-crypt
  o Fix make rpm when using RH9 or Fedora
  o menuconfig: fix the check for ncurses-devel
  o Inefficient TLB flush fix
  o sf16fmr2 radio card driver
  o Remove overenthusiastic BUG in smp_boot_cpus
  o Codingstyle update
  o smbfs: support the loop driver
  o Fix sprintf modifiers in usr/gen_init_cpio.c for cygwin
  o wireless/Kconfig enable/select complete replacement
  o tuner driver fixes
  o crc32.c copyright fix
  o Add C99 initializers to arch/i386/pci/fixup.c
  o mark ftape un-removable
  o aio sysctl parms
  o ramdisk cleanup
  o slab: print slab name in kmem_cache_init()
  o prevent ptrace from altering page permissions
  o slab: hexdump for check_poison
  o page_add_rmap(): remove meaningless test
  o Add CONFIG for -mregparm=3
  o Use -funit-at-a-time on ia32
  o Add noinline attribute
  o use noinline for rest_init()
  o gcc-3.5: bonding
  o fix access() POSIX compliance
  o fix pfn_valid on ia32 discontigmem
  o ia32: pfn_to_nid fix
  o ia32: disallow NUMA on PC subarch
  o config option for irqbalance
  o print some x86 build options during oopses
  o show_task() fix and cleanup
  o show_task() is not SMP safe
  o ppc64 compile fix
  o v850 ptrace.c task_struct leak
  o Fix the display of max-ever-used-stack in sysrq-T output
  o smbfs: remove debug code
  o x86_64 uniproc build fix
  o ia64: fix sched.c compile warning
  o MIPS mega-patch
  o serial fixups
  o more serial driver fixups
  o Intel i830 AGP fix
  o fix shmat
  o dynamic pty allocation
  o NBD rmmod oops fix
  o m68k: offsets.h generation
  o m68k: mm init warning
  o m68k: Sun-3 console fix
  o m68k: Sun-3 missing sbus_readl()
  o m68k: Atari name clashes
  o m68k: M68k MCA cleanup
  o m68k: M68k uses drivers/Kconfig
  o m68k: Amifb modedb bug
  o m68k: M68k configuration
  o m68k: arch/m68k/mm/Makefile cleanup
  o m68k: M68k module loader
  o m68k: M68k call trace output
  o m68k: M68k cmpxchg
  o m68k: M68k FPU emu broken link
  o m68k: Mac IOP spelling
  o m68k: Dummy dma mapping
  o m68k: M68k core spelling
  o add range checking to sys_sysctl()
  o Kconfig help: dm-crypto && cryptoloop
  o nbd: fix set_capacity call
  o nbd: remove PARANOIA and other cleanups
  o cleanup condsyscall for sysv ipc
  o IPMI warning fixes
  o mtrr: init section usage
  o Fixes to CodingStyle
  o Another x86-64 fix for problems from the recent merge
  o ext3: fix scheduling-in-spinlock bug
  o security oops fix
  o From: "Randy.Dunlap" <rddunlap@osdl.org>
  o janitor: media: use kernel min/max
  o telephony: use kernel min/max
  o Fix ISDN v.110
  o Fix fs/partitions/efi.c printk warnings
  o powernow-k8 frequency handling fix
  o Require GNU Make version 3.79.1 or later
  o runtime PM deadlock fix
  o Fix do_shmat() for CONFIG_SYSVIPC=n
  o ppc64: remove dump_regs
  o ppc64: cleanup lmb code
  o ppc64: Potentially avoid an atomic operation in switch_mm
  o ppc64: Remove duplicate pcibios_scan_all_fns definition
  o ppc64: Fix for ppc64 SMT enablement bug provided by Jimi Xenidis
    and Michael Day
  o ppc64: add rtas slot-error-detail information
  o ppc64: add log_rtas_error()
  o Allow CROSS32_COMPILE to be set via environment variable
  o ppc64: Add a ppc64 archhelp
  o ppc64: print useful flags in oops, like x86
  o ppc64: Add DEBUG_STACK_USAGE
  o ppc64: Add -funit-at-a-time
  o Add 970FX entry into the cputable
  o ppc64: Fix for valid nvram rtas tokens
  o fix naming collision with asm-ppc64/vio.h
  o ppc64: fix warning and compile error without CONFIG_SMP
  o ppc64 cpu spinup fixes
  o ppc64: remove useless smp_message_pass args
  o ppc64: This cleans up the rtasd logic, and also makes it hotplug
    CPU safe
  o ppc64: Add stack overflow debugging
  o ppc64: remove get_users in backtrace code
  o Add cpus and NUMA memory nodes to sysfs. Also add cpu physical id
  o ppc64: Make a number of segment table functions static
  o ppc64: Clean up per cpu usage in segment table code
  o ppc64: PER_CPU irq optimisations
  o ppc64: don't link some non iSeries stuff
  o ppc64: Fix __get_SP()
  o ppc64: set err to -ENODEV when a new node doesn't have "interrupt"
    property
  o fix for NUMA kernel on non NUMA machine
  o trivial oops formatting cleanups
  o ppc64: restore cpu names
  o ppc64: uniprocessor compile fixes
  o ppc64: fix cmd_line bugs
  o m68k: Sun-3 LANCE Ethernet
  o m68k: Atari Pamsnet warning
  o m68k: Amiga A2065 Ethernet new driver model
  o m68k: Amiga Ariadne Ethernet new driver model
  o m68k: Amiga Hydra Ethernet new driver model
  o ppc64: archhelp fix
  o Fix make xconfig on /lib64 systems
  o Report NGROUPS_MAX via a sysctl (read-only)
  o Make insert_resource work for alder IOAPIC resources
  o add the Intel Alder IO-APIC PCI device to quirks
  o x86: remove THREAD_SIZE assumption cleanups
  o cosmetic printk fix
  o remove unneeded check from sys_sysctl()
  o clarify MSI requirements in Kconfig
  o pty changes require procps 3.2
  o jffs2: Don't jump between contexts
  o fix the build with CONFIG_UNIX98_PTYS=n
  o Eicon isdn driver compile __devexit compile fix
  o Change ENOTSUPP to EOPNOTSUPP
  o swsusp/s3: Assembly interactions need asmlinkage
  o acpi/utils.c warning fix
  o drivers/acpi/sleep/proc.c warnings
  o add syscalls.h
  o asmlinkage fixes
  o ppc64: fix de4x5 build
  o m68k: Amiga Zorro8390 Ethernet new driver model
  o HFS rewrite
  o HFS+ support
  o superblock fixes
  o fix module reference counting in zoran driver
  o s390: general update
  o s390: common i/o layer
  o s390: console driver
  o s390: compat_timer_settime
  o s390: CTC network driver
  o s390: LCS network driver
  o s390: IUCV network driver
  o s390: DASD device driver
  o s390: virtual timer interface
  o s390: z/VM monitor stream
  o s390: collaborative memory management
  o s390: channel measurement block interface
  o s390: zfcp host adapter
  o s390 syscalls.h update
  o s390: DCSS block device driver
  o dvb: Update subsystem docs
  o dvb: Update saa7146 driver core
  o dvb: Minor Skystar2 updates
  o dvb: core update
  o dvb: Misc frontend updates
  o dvb: stv0299 DVB frontend update
  o dvb: tda1004x DVB frontend update
  o dvb: av7110 DVB driver update
  o dvb: TTUSB-Budget DVB driver update
  o n_tty.c cleanup
  o M68k Macintosh driver config
  o request_firmware(): misc fixes
  o request_firmware(): more misc fixes
  o request_firmware(): add status bitmap
  o request_firmware(): fix firmware_priv leak
  o request_firmware():  race fixes
  o request_firmware(): refactor fw_setup_class_device()
  o request_firmware(): fix attribute removal
  o early printk documentation fix
  o radeon config fix
  o Remove unused tty CALLOUT defines
  o don't use floating point in tdfxfb
  o mtd locking fix
  o C99 patch for fs/afs/inode.c
  o Kill bogus __KERNEL_SYSCALLS usage
  o C99 initiailzers for drivers/isdn/i4l/isdn_common.c
  o C99 initializers for drivers/net/wireless/airo.c
  o C99 initializers for drivers/net/wan/wanxl.c
  o C99 initializers for drivers/net/wan/pci200syn.c
  o C99 initializers for drivers/net/irda/irda-usb.c
  o C99 initializers for drivers/media/common/saa7146_video.c
  o C99 initializer for drivers/media/dv/frontend/stv0229.c
  o C99 initializers for drivers/media/dvb/frontends/alps_tdlb7.c
  o C99 initializers for drivers/media/dvb/frontends/sp887x.c
  o C99 initializer for driver/media/dvb/ttpci/budget-av.c
  o V4L: Add new driver for Teletext decoder SAA5246A from Philips
  o kbuild: add defconfig targets to make help
  o wanmain.c build fix
  o swsusp locking fix
  o PPC64 iSeries virtual disk driver
  o Add kallsyms_lookupname()
  o ppc64: use kallsyms_lookup_name() in xmon
  o ppc64: move sg_dma_{len,address} macros
  o ppc64: Fix a sleeping with spinlock bug in ioremap
  o knfsd: NGROUPS fixes
  o nfsd: don't modify group_info structures
  o kNFSd: Add minimal server-side support for rpcsec_gss
  o kNFSd: gss api changes for integrity checking
  o kNFSd: IDmap support for the NFSv4 server
  o kNFSd: Nfsdv4 pointer cleanup
  o kNFSd: NFSv4 locking state fix
  o kNFSd: v4 exclusive open fix
  o kNFSd: Use higher-resolution time for the changeinfo, instead of
    using time and filesize
  o kNFSd: When looking for a shareowner in the nfsd open, make sure we
    don't get a lockowner instead
  o kNFSd: NFSdV4 fixes for replaying open requests
  o kNFSd: Use only the uid when deciding whether a setclientid is
    being done with the "same principal"
  o kNFSd: When looking for a shareowner in the nfsd open, make sure we
    don't get a lockowner instead
  o kNFSd: readdir error code fix
  o kNFSd: correctly tests and sets nfserr_nofilehandle for current and
    save fh
  o kNFSd: Fix for lookup-parent at pseudo root
  o kNFSd: Correct error returns
  o kNFSd: fixes an xdr error by removing the verifier from error
    return
  o kNFSd: correct symlink related error returns
  o kNFSd: check lock length, return appropriate error
  o kNFSd: correct rename error returns
  o kNFSd: unlock-on-close fix
  o kNFSd: Remove a comment that is no longer accurate
  o kNFSd: move fh_dup2 and fix it
  o kNFSd: Implement the nfsv4 RELEASE_LOCKOWNER operation
  o kNFSd: add OP_ILLEGAL, and fix processing of compounds with out of
    bounds op numbers
  o kNFSd: fix an error return for OP_CREATE
  o kNFSd: Add a check in OP_LOCK for new lockowners to ensure that the
    open stateid is
  o kNFSd: Corrects an error return for OP_OPEN_CONFIRM
  o kNFSd: Enforce open_downgrade requirement
  o kNFSd: Fix an out-of-spec readlink error return
  o kNFSd: Fix an out-of-spec error in nfsd4_remove
  o kNFSd: Miscellaneous fixes to stateid-based replay
  o kNFSd: Fix out-of-spec error return in attribute decoding
  o kNFSd: Make the calculation in the first READ_BUF easier to
    understand
  o kNFSd: make sure sunrpc init routines called before gss init
    routines
  o kNFSd: return more than one page of directory entries
  o Add a MODULE_VERSION macro
  o rename other MODULE_VERSION users
  o fbdev cursor fix

Andrew Vasquez:
  o qla2xxx -- Properly schedule mailbox command timeouts
  o qla2xxx -- FCP_RSP IU check during command completion

Andries E. Brouwer:
  o USB: add comments to sddr09.c
  o tty utf8 mode

Anton Blanchard:
  o ppc64: fix kernel access of user pages
  o ppc64: TLB flush rework
  o ppc64: fix pci hotplug compile error
  o ppc64: remove CONFIG_VETH
  o ppc64: defconfig update

Art Haas:
  o [NETFILTER]: C99 initializers in ip_conntrack_standalone.c
  o [RXRPC]: C99 initialiers for net/rxrpc/connection.c

Bartlomiej Zolnierkiewicz:
  o move CONFIG_HOTPLUG to init/Kconfig
  o remove dead kernel parameters
  o keep documentation of kernel parameters in one place only
  o kill useless IDE_SUBDRIVER_VERSION
  o kill default_shutdown() and ide_drive_t->shutdown
  o kill default_flushcache() and ide_drive_t->flushcache
  o remove bogus comment and code from ide_unregister_driver()
  o remove dead/unfinished taskfile version of ide_cmd_ioctl()
  o remove unused ide_end_taskfile()
  o fix /proc/ide/<chipset> for IDE PCI modules
  o fix /proc/ide/<hwif> for IDE PCI modules
  o siimage.c: limit requests to 15kB only for Seagate SATA drives
  o add UDMA6 support to ALi PCI IDE driver
  o fix ide_system_bus_speed() causing "Badness in pci_find_subsys..."
  o ide-io.c: CONFIG_LBD fix
  o explicitly define PRD_ENTRIES to 256
  o remove redundant ide_setup_pci_device{s}() declarations
  o ide-proc.c: remove unused MIN() macro
  o ide-taskfile.c: remove debugging placeholders

Ben Collins:
  o IEEE1394(r1118): Addition of new config-rom processing code
  o IEEE1394(r1126): Small cleanup based on patch from Isaac Claymore
  o IEEE1394(r1128): Implement bus reset handling for hosts (based on
    patch from Oracle)
  o IEEE1394(r1129): Initial support for reusing node entries over
    plug/unplug cycles
  o IEEE1394(r1130): Conversion of some list_for_each() usages to
    list_for_each_entry()
  o IEEE1394/OHCI(r1131): Suspend/resume isn't dependent on CONFIG_PM
  o IEEE1394: Sync revisions
  o IEEE1394(r1134): Fix some typos introduced over the last few
    changes
  o IEEE1394(r1135): Initial ieee1394_host_class implementation
  o IEEE1394(r1136): Implement node class
  o IEEE1394(r1137): Check to make sure we have a hostinfo in
    sbp2_host_reset
  o IEEE1394(r1138): Cleanup nodemgr probe, and fix a bug with the
    driver update
  o IEEE1394/SBP2(r1139): Some cleanups, and a better, more unique id
    for ieee1394_id attribute
  o IEEE1394(r1140): Add a bus rescan bus_attr file, and an
    ignore_driver attr for ud's
  o IEEE1394(r1141): Add an "ignore_drivers" global default
  o IEEE1394(r1142): Use a kernel thread to rescan devices so we don't
    block the writer
  o IEEE1394(r1143): Fix FCP requests, broken by my change for
    list_for_each_entry()
  o IEEE1394/SBP2(r1144): Convert sbp2 to do one scsi_host per
    unit-directory
  o IEEE1394: Revision sync
  o IEEE1394 is no longer experimental, but eth1394 is
  o IEEE1394(r1146): Make the probe callback return an error if
    problems, and unbind drivers on failure
  o IEEE1394/ETH1394(r1147): Make sure to set update_config_rom on add
    host
  o IEEE1394/SBP2(r1148): Fix a few bugs, and add set
    blk_queue_dma_alignment to 512
  o IEEE1394(r1149): Convert some hardcoded values to constants. Add
    pbook suspend/resume handlers
  o IEEE1394/Video1394(r1150): Initialize d->link list so that failures
    cleanup properly
  o IEEE1394/Video1394(r1151): Fix typo in last commit
  o IEEE1394(r1154): Cleanup dma routines, and use vmalloc for sglist
    allocation
  o IEEE1394(r1155): Get rid of another user of round_up_to_page()
  o eth1394(r1156): Fix oddities when MacOSX is IRM. Also MacOSX sets
    an invalid sspd in the ARP reply
  o IEEE1394(r1157): Create a kernel thread to handle all
    run_packet_complete() calls
  o SBP2(r1158): We don't need a remove_host callback in sbp2
  o IEEE1394(r1159): Merge run_packet_complete into kernel thread
  o ohci1394(r1160): Disable cross_bound() check, and add code to try
    to enable connected ports
  o IEEE1394(r1161): Major cleanup and addition of a ud-class, to make
    things even cleaner
  o SPARC64: Fix debug spinlocks to not trash random memory with > 4
    cpus's (or sparse cpu's)
  o SPARC64: Use hard_smp_processor_id() for init_irqwork_curcpu()
  o IEEE1394(r1162): Check return value for errors from
    hpsb_register_protocol
  o IEEE1394(r1163): Fixup nodemgr_{suspend,resume}_ne to use the ud
    class list
  o [SPARC64]: Use prom_printf in sun_do_break() instead of printk.
    Avoids lockup
  o [SPARC64]: Fix compile warning from RW_LOCK_UNLOCKED with spinlock
    debug enabled

Benjamin Herrenschmidt:
  o Be careful about memory ordering in sungem driver
  o Fix a DMA underrun problem with pmac IDE
  o ppc32: rework l2 cache code
  o ppc32: Export cpu_possible_map
  o Fix use of sector_t in swim3 driver
  o Remove use of "current" identifier in via-pmu
  o Disable debugging verbosity in macio_asic.c
  o ppc64 oops on /proc/cpuinfo
  o ppc64: Fix warning on pmac build
  o radeonfb: small cleanup of common register init
  o ppc64: physical RAM accounting fix
  o ppc64: Fix /dev/mem idea of what is memory
  o ppc64: iommu rewrite
  o ppc64: Fix drivers/ide when using an IOMMU
  o ppc64:Implement support for Apple DART IOMMU (PowerMac G5)

Bjorn Helgaas:
  o [SERIAL] Discover ACPI serial ports before plug-in ports
  o [SERIAL] Fix /proc serial info for MMIO ports

Brian Childs:
  o multicast broken on x86_64

Brian King:
  o SCSI: Make retries obey host_self_blocked flag

Carlos Puchol:
  o initial support for transmeta's efficeon processors

Chas Williams:
  o [ATM]: horizon: make reset function not __init (from Randy Dunlap
    <rddunlap@osdl.org>)
  o [ATM]: use clip_tbl instead of clp_tbl_hook (from Francois Romieu
    <romieu@fr.zoreil.com>)
  o [ATM]: [lec] put back pressure on network stack

Christoph Hellwig:
  o [SUNGEM]: Kill unused variable on ppc
  o remove flush_cache_all() from qla1280
  o Remove CONFIG_SCSI_DC390T_NOGENSUPP
  o fix up ini9100 interrupt handling
  o fix up NCR5380 private data
  o move remaining definitions from drivers/scsi/scsi.h to include/scsi
  o remove useless MOD_{INC,DEC}_USE_COUNT in lasi_82596.c
  o remove useless MOD_{INC,DEC}_USE_COUNT in sun3lance
  o remove useless MOD_{INC,DEC}_USE_COUNT in sb1250-mac
  o remove useless MOD_{INC,DEC}_USE_COUNT in meth
  o remove useless MOD_{INC,DEC}_USE_COUNT in wanpipe

Dave Jones:
  o [CPUFREQ] Update URL
  o [CPUFREQ] bump copyrights
  o [CPUFREQ] Add extra __init markers to longhaul driver
  o [CPUFREQ] Add extra __init markers to longrun driver
  o [CPUFREQ] Don't set up longhaul voltage scaling too early
  o [CPUFREQ] Extra sanity checks in longhaul
  o [CPUFREQ] Don't guess FSB on Nehemiah
  o [CPUFREQ] Export powernow-k7 scaling frequencies
  o [CPUFREQ] scaling_available_frequencies work for remaining x86
    drivers
  o [CPUFREQ] Fix ARM cpufreq governor selection From: Russell King
    <rmk@arm.linux.org.uk>
  o Fix for a really stupid off by 1 bug

Dave Kleikamp:
  o JFS: get_UCSname does not need nls_tab argument
  o JFS: Don't do filename translation by default

David Brownell:
  o USB: EHCI updates (mostly periodic schedule scanning)
  o USB: usbcore, scatterlist cleanups
  o USB: usbcore, hub driver enables TT-per-port mode
  o USB: usbcore, avoid RNDIS configs
  o USB: usbtest, two more protocol cases
  o USB: ehci-hcd, fullspeed iso data structures (1/3)
  o USB: ehci-hcd, fullspeed iso data structures (2/3)
  o USB: ehci-hcd, scheduler handles TT collisions (3/3)

David Milburn:
  o [libata sata_promise] Fix DIMM initialization on PCI-X bus

David Mosberger:
  o ia64: Back-port from libunwind: fix off-by-one error in
    kernel-unwinder
  o ia64: Fix bug in
    ia64_get_scratch_nat_bits()/ia64_put_scratch_nat_bits()
  o ia64: Update defconfig
  o ia64: Update defconfig

David S. Miller:
  o [IPV6]: Kill 64-bit warnings in ndisc.c
  o [IRDA]: Forgot to add stir4200.c in previous commit
  o [TG3]: Two more PHY bug workaround, plus fix DMA test on big-endian
  o [TG3]: Fix early chip programming in tg3_setup_copper_phy()
  o [TG3]: Bump driver version and reldate
  o [APPLETALK]: Use '%Z' for size_t
  o [BLUETOOTH]: Use min_t to avoid warning in rfcomm sock.c
  o [DECNET]: Make second arg to dn_alloc_send_skb a size_t pointer
  o [SELINUX]: Forgot to add these in previous commit
  o qla2xxx: remove flush_cache_all
  o [SPARC64]: Update defconfig
  o [I2C]: Fix resource address typing
  o [I2C]: Use correct port address types in i2c-velleman.c
  o [I2C]: Fix resource address typing in i2c-voodoo3.c
  o [FREEVXFS]: Fix u64 printk warnings on some 64-bit platforms
  o [I2C]: If comparing against ULONG_MAX, use ulong type, in lm85.c
  o [NFSD]: Fix u64 printk warnings on some 64-bit platforms
  o [SMBFS]: Use '%z' printf format for size_t types
  o [MEDIA]: Print out pointers correctly in dst.c
  o [MEDIA]: Use '%z' printf format for size_t
  o [SKFDDI]: Use unsigned long for resource base/size
  o [SUNDANCE]: Fix casting so u64 printk does not warn on some 64-bit
    platforms
  o [MEDIA]: Use '%z' printf format for size_t/ptrdiff_t types in
    w9968cf.c
  o [I2C]: Use correct port address typing in i2c-elv.c
  o [SPARC64]: Do similar macro casting for {in,out}{b,w,l}() as we do
    for {read,write}{b,w,l,q}()
  o [SPARC64]: Update defconfig
  o [NETFILTER]: Include net/ipv6.h in ip6_tables.c
  o [IPV6]: Make ipv6_skip_exthdrs take const skb arg
  o [PKT_SCHED]: Missing linux/init.h includes in sch_{arm,dsmark}.c
  o Synchronize sungem RX complation path
  o [IPV4]: Do not return -EAGAIN on blocking UDP socket, noticed by
    Olaf Kirch
  o [IPV6]: Kill unloadable noise in af_inet6.c
  o [IPV6]: Fix typo in Al's module_init changes
  o [TIGON3]: Comment out card RAM validation in tg3_test_dma() for now
  o [TIGON3]: Bump version and reldate
  o [NET]: Set default socket rmem/wmem values more sanely and
    consistently
  o [IPV6]: UDPv6 needs recvmsg csum error path fix too, thanks Olaf
  o [SPARC64]: Update defconfig
  o [SPARC]: Move ptrace_signal_deliver() implementation out of header
    file
  o [SUNRPC]: Use '%z' for size_t printk in svcauth_gss.c

David Stevens:
  o [IPV6]: Except MLD packets from source filtering
  o [IPV6]: Add sysctl to force MLD version
  o [IGMP/MLD]: Validate filter size against optlen
  o [IGMP/MLD]: Check for numsrc overflow, plus temp buffer tweaks

David Woodhouse:
  o [IPV4]: Make ip_auto_config a late initcall

Deepak Saxena:
  o USB: Fix USB host code to use generic DMA API
  o [ARM PATCH] 1761/1: Remove SA1111_PCI_FAKEDEV (take 2)

Dely Sy:
  o PCI Hotplug: Add SHPC and PCI Express hot-plug drivers

Domen Puncer:
  o USB: some stv680 fixes

Don Fry:
  o [NET]: Fix ethtool oops if device support get but not set ringparam
  o 2.6.3 pcnet32.c bus master arbitration failure fix
  o 2.6.3 pcnet32.c SLAB_DEBUG length error fix
  o 2.6.3 pcnet32.c transmit hang fix
  o 2.6.3 pcnet32.c wrong vendor ID fix
  o 2.6.3 pcnet32.c convert to use netif_msg_*
  o 2.6.3 pcnet32.c change to use ethtool_ops
  o pcnet32.c handle failures in open
  o pcnet32.c non-mii errors with ethtool
  o pcnet32.c add PCI hot remove support
  o pcnet32.c adds loopback test
  o whitespace only change to pcnet32.c
  o pcnet32.c fix compile error
  o pcnet32 non-mii link state fix

François Romieu:
  o [IRDA]: Fix error return status in stir4200 driver
  o [IRDA]: In stir4200 driver, defer netif_start_queue() until device
    opening succeeds
  o 2.6.3 - drivers/net/sis190.c - Tx desc overflow

Geert Uytterhoeven:
  o NCR53C9x slave_{alloc,destroy}()
  o Sun-3x ESP SCSI clean up

Grant Grundler:
  o [TG3]: Reset GRC, if necessary, before DMA test
  o [PKTGEN]: Fix unintentional unaligned access
  o [TG3]: Abstract out mailbox workarounds into tw32_{rx,tw}_mbox()
  o [TG3]: Define MBOX_WRITE_REORDER flag to zero on non-x86

Greg Kroah-Hartman:
  o PCI: fix pci quirk for P4B533-V, fixes bug 1720
  o USB: fix up compile errors in uhci driver
  o USB storage: sync up with some missing unusual_devs entries that
    were in my tree
  o PCI Hotplug: fix build warnings on 64 bit processors

Greg Ungerer:
  o fix memory leaks in binfmt_flat loader
  o allow configuration for shared flat binary support
  o add m68k elf relocation types to elf.h
  o fixes to ColdFire/5407 startup code
  o m68knommu: remove non-existant option from defconfig
  o m68knommu: fix interrupt handler return types to be irqretur_t
  o m68knommu: use KERN_DEBUG in debug printk()'s

Harald Welte:
  o [NETFILTER]: Resync with 2.4.x
  o [NETFILTER]: Remove unused structure member in NAT, from Patrick
    McHardy

Herbert Xu:
  o [IPSEC]: Move hardware headers for decaped packets

Hideaki Yoshifuji:
  o [NET]: Kill bogus kmem cache alignment in neigh_table_init()
  o [IPV6]: Clean up ndisc printks
  o [IPV6]: Spelling corrections, and remove some XXX's
  o [IPV6]: Kill remaining in6_u.u6_addrX uses
  o [IPV6]: Use udpv6_queue_rcv_skb for multicast delivery

Holger Schurig:
  o [ARM PATCH] 1670/1: PXA serial driver

Hollis Blanchard:
  o ppc64: virtual IO bus updates

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Jakub Bogusz:
  o 2.6.3 - fix for undefined mdelay in 3c505
  o switch alpha to use drivers/Kconfig

James Bottomley:
  o MPT Fusion driver 3.00.03 update
  o SCSI: 53c700: reduce default tag depth to 4
  o fix IRQBALANCE Kconfig dependencies
  o Undo SCSI 8-byte alignment relaxation

James Morris:
  o [SELINUX]: Event notifications via netlink

Jan Kasprzak:
  o [NET]: Do not send negative 2nd arg to skb_put()

Jean Tourrilhes:
  o [IRDA]: Add stir4200 driver
  o [IRDA]: Rename dongle entry points for consistency

Jeff Garzik:
  o [netdrvr e100] include linux/moduleparam.h
  o Eliminate ancient and unused include/linux/{if_pppvar,ppp}.h
  o [libata] catch, and ack, spurious DMA interrupts
  o Add Documentation/networking/netif-msg.txt, describing the
    per-network-interface message logging standards for net drivers.
  o Delete tms380tr firmware, no longer needed now that driver uses
    request_firmware()
  o Improvements to the bk-make-sum BitKeeper summary/submission script
  o default 8139too to PIO
  o [libata] Guarantee that S/G entries do not straddle IDE DMA 64k
    boundary
  o [libata sata_sil] fix 4-port support on SII 3114
  o [libata] Explicitly set max_phys_segments to 128 (current blk
    default), in case MAX_PHYS_SEGMENTS ever changes.
  o [libata] bump versions
  o Fix PCI MSI build when kirqd is disabled
  o [libata] Much better s/g table fill routine
  o [libata] limit S/G table size to 128 entries
  o [libata ata_piix] add support for ICH6
  o [libata ata_piix] Update PCI quirk with new Intel SATA devices
  o Add Intel ICH6 PCI ids to pci_ids.h
  o Add Intel ICH6 irq router
  o Add Intel PCI ids to old-OSS driver i810_audio
  o Add Intel PCI ids to IDE (PATA) driver
  o Fix broken PIIX build
  o [IDE] Create DECLARE_PIIX_DEV declarator, to eliminate a large
    amount

Jens Axboe:
  o fix SCSI non-sector bio backed IO

Jeremy Higdon:
  o ia64: Fix 64 bit DMA mapping problem with PCI cards on SN2

Jeroen Vreeken:
  o 6pack reinit bug

Jochen Friedrich:
  o tms380tr patch 1/3 (bug fix)
  o tms380tr patch 2/3 (queue fix)
  o tms380tr patch 3/3 (get firmware out of kernel)

John Rose:
  o PCI Hotplug : add DLPAR driver for PPC64 PCI Hotplug slots

John Stultz:
  o ia64: add support for time-interpolation via IBM EXA Cyclone timer

Joseph Fannin:
  o [netdrvr sis900] fix multicast bug

Julian Anastasov:
  o [IPV4]: Add configurable restriction of local IP announcements in
    ARP requests
  o [IPV4]: Add sophisticated ARP reply control via arp_ignore sysctl

Kai Mäkisara:
  o Sysfs class support for SCSI tapes

Kazunori Miyazawa:
  o [IPV6]: Unify ipv6 output routine

Keith M. Wesolowski:
  o [SPARC32] Uninline atomic_t functions to save space
  o [SPARC32]: Do similar macro casting for {in,out}{b,w,l}() as we do
    for {read ,write}{b,w,l,q}().
  o [SPARC32]: Nuke a.out build cruft
  o [SPARC32]: Remove stale SMP irq implementation
  o [SPARC32]: Remove use of PF_USEDFPU
  o [SPARC32]: Remove cli/sti from all arch code

Len Brown:
  o [ACPI] revert previous AML param patch for ACPICA update
  o [ACPI] ACPICA 20040211 udpate from Bob Moore

Linda Xie:
  o PCI Hotplug: Add PPC64 PCI Hotplug Driver for RPA

Linus Torvalds:
  o Fix up the microcode update on regular 32-bit x86. Our wrmsr() is a
    bit unforgiving and really doesn't like 64-bit values.
  o Include the <linux/dma-mapping.h> header file for DMA mapping
  o Fix silly thinko in sungem network driver
  o Don't allow memory "lines" argument in "xor_p5_mmx_5()"
  o ppc64: fix non-iSeries build
  o Add d_type information to legacy readdir system call
  o Linux 2.6.4-rc1

long (tlnguyen):
  o PCI: add copyright for files msi.c and msi.h

Luiz Capitulino:
  o [PPPOE]: Handle disabled PROC_FS properly
  o [PPPOE]: Kill unneeded ifdef/endif

MAEDA Naoaki:
  o ia64: fix possible memory leak in PCI alloc_resource()

Manfred Spraul:
  o rename shmat to make it clear it isn't a system call entrypoint

Marcel Holtmann:
  o [Bluetooth] Cleanup drivers Kconfig file
  o [Bluetooth] Copy all L2CAP signal frames to the raw sockets
  o [Bluetooth] Initial sysfs and device class support
  o [Bluetooth] Dynamic allocation of HCI device
  o [Bluetooth] Use C99 initializer for HCI USB driver
  o [Bluetooth] Initialize interval of ISOC URB's

Marcelo Tosatti:
  o cyclades async driver update

Mark A. Greer:
  o PCI: Changing 'GALILEO' to 'MARVELL'

Mark Haverkamp:
  o add card types to aacraid driver
  o aacraid reset handler

Mark Hindley:
  o [SERIAL] fix 8250_pnp resource allocation

Martin Hicks:
  o ia64: SN2 header file cleanups
  o ia64: clean up SN2 setup.c

Martin J. Bligh:
  o [NET]: Ditch TSO in loopback driver, it's had enough testing

Martine Silbermann:
  o PCI: update MSI Documentation

Matthew Dharm:
  o USB Storage: Save the SCSI residue value when auto-sensing
  o USB Storage: Reduce unsolicited auto-sense
  o USB Storage: Fix small endian-ness bug

Matthew Wilcox:
  o [TG32]: Use pci_get_slot() to find 5704 peers, to handle domains
    properly
  o PCI: Fix pci_bus_find_capability()
  o ia64: SAL version is not zero-padded
  o ia64: improve gate generation
  o ia64: Add "install" make target

Matthias Andree:
  o [NET]: Export sysctl_optmem_max to modules

Michal Ludvig:
  o [XFRM_USER]: Fix SKB sizing in xfrm_send_policy_notify()
  o [XFRM_USER]: In xfrm_send_{acquire,policy_notify}(), use
    {RTA,NLMSG}_SPACE()

Miguel Freitas:
  o [NET_SCHED]: Fix slot leakage in SFQ scheduler

Mike Phillips:
  o 3c359_microcode.h clean up - 2.6.3

Mirko Lindner:
  o sk98lin: Added Support for Belkin adapter
  o [kernel 2.6] sk98lin: Insert revision version and date

Nathan Scott:
  o blkdev_open/bd_claim vs BLKBSZSET

Pat Gefre:
  o ia64: add "platform_data" to struct pci_controller, update SN2
    accordingly
  o ia64: on SN2, use the pda to count interrupts
  o ia64: on SN2, skip init_platform_hubinfo() if on the simulator
  o ia64: cleanup SN2 pci_bus_cvlink.c
  o ia64: add Altix hotplug support

Patrick Mansfield:
  o have CONFIG_SCSI_PROC_FS depend on CONFIG_PROC_FS

Patrick McHardy:
  o [PKTSCHED]: Use queue limit of 1 when tx_queue_len is zero
  o [NETFILTER]: Fix amanda helpers, forward port from 2.4.x version

Paul Mackerras:
  o Clean up IRQ mapping code

Paulo Marques:
  o USB: fix usblp.c

Peter Teichmann:
  o [ARM PATCH 1719/1] Acornfb update

Petri Koistinen:
  o [IRDA]: Fix URLs in Kconfig
  o [HAMRADIO]: Fix URLs in Kconfig
  o [WAN]: Kconfig clean-up and update URL links

Randy Dunlap:
  o depca: remove double semi-colon
  o tr/3c359: handle kmalloc failures during init
  o ne: eliminate unused var. warning
  o ibmtr: use kernel min/max
  o strip: remove warnings when !PROC_FS
  o strip: use kernel min/max

Robert Picco:
  o ia64: add support for NUMA machines with CPU-only (memory-less)
    nodes

Russell King:
  o [ARM] Make Acorn I2C build again
  o [ARM] Fix ambakmi to use amba_request_regions() and the correct IRQ
  o ICS IDE is not a PCI IDE interface
  o [ARM] Fix Acorn VIDC sound driver
  o [ARM] Add safe sa1111 IO handling
  o [ARM] Update SA1111 Neponset code to use safe GPIO functionality
  o [ARM] Dynamically allocate SA1100 PCMCIA sockets
  o [ARM] Fix late abort handler for Thumb code
  o [ARM] Remove non-existent Kconfig source statement
  o [ARM] Add ARM architecture version 6 support
  o [ARM] Cleanup MODULE_* macros
  o [ARM] Update sa1111-pcibuf for dmapool changes
  o [ARM] Add SA11x0 sched_clock() implementation
  o [ARM] Remove obsolete sysctl PM interface
  o [ARM] Update mach-types definitions file
  o [ARM] Improve bad IRQ reporting
  o [ARM] Optimise readsl
  o [ARM] Allow decompressor to use "cache type" register
  o [ARM] Add resources and platform devices for SA11x0 serial ports
  o [ARM] amba_{request,release}_regions
  o [ARM] Make free_memmap() use PFNs instead of physical addresses

Rusty Russell:
  o Always put cache aligned code in own section, even for modules

Santiago Leon:
  o Add IBM PowerPC Virtual Ethernet Driver

Scott Feldman:
  o [netdrvr] e100 version 3 (complete rewrite)
  o [e100] ICH6 IDs + ia64 memcpy fix + module_param
  o [netdrvr e100] netpoll + fixes to speed/duplex forced settings
  o [netdrvr e100] fix slab corruption
  o [netdrvr e100] copyright + trailing blanks + misc
  o e1000: flow control
  o e1000: disable TSO for now
  o e1000: disable CSA fix for 82547
  o e1000: delay may be too small
  o e1000: collision retry count too high
  o e1000: handle register_netdev failure
  o [netdrvr e100] Response to Jeff's review plus some minor fixes

Sebastian Henschel:
  o [NET]: Mention tuxmobil.org in drivers/net/Kconfig
  o [ARM] URL change for linux-on-laptops

Shmulik Hen:
  o [netdrvr bonding] trivial - Update comment blocks and version field
  o Add support for HW accel. slaves
  o Add VLAN support in TLB mode
  o Add VLAN support in ALB mode

Simon Barber:
  o [NET]: Capture skb->protocol after invoking bridge

Simon Horman:
  o [JHASH]: Make key arg const in jhash()

Sridhar Samudrala:
  o [SCTP] Revert back to use kmalloc() for ssnmap allocs of sizes <
    128K
  o [SCTP] Force enable Crypto options that are needed by SCTP config
  o [SCTP] Fix incorrect INIT process termination with
    sinit_max_init_timeo

Stefan Rompf:
  o Re: Patch: netif_carrier_on()/off() for xircom_tulip_cb
  o netif_carrier_on()/off() for xircom_tulip_cb

Stephen Hemminger:
  o bugfixes for dgrs.c
  o hp100 pci probe problem
  o [WAN]: Fix single_open confusion in wandev_show
  o Re: IA32 (2.6.3 - 2004-02-18.22.30) - 4 New warnings (gcc 3.2.2)
  o Allow pcnet_cs to work with shared irq
  o [IRDA]: Fix handling of shared IRQs in smsc-ircc2 driver
  o [IRDA]: COnver irda-usb to dynamic device allocation
  o [IRDA]: Rename setup_dma to irda_setup_dma
  o [IRDA]: Make more symbols static, to avoid namespace pollution
  o [IRDA]: Make more symbols static, to avoid namespace pollution
  o [IRDA]: Make more symbols static, to avoid namespace pollution
  o [IRDA]: Make more symbols static, to avoid namespace pollution
  o [IRDA]: No need for volatile type when using set/test_bit
  o [IRDA]: Kill infrared_mode, unused
  o [IRDA]: Kill dev_flags, unused
  o [IRDA]: Hashbin cleanups, remove unused code and add const where
    needed
  o [IRDA]: Zap bogus wireless.h include
  o [IRDA]: Make irda_device_txqueue_empty inline
  o [IRDA]: Mark irport driver as having locking issues

Steve Kinneberg:
  o IEEE1394(r1125): Set host field of hpsb_address_serve struct when
    registering address spaces
  o IEEE1394(r1132): Update Kconfig description of the eth1394 driver

Tomasz Torcz:
  o Update via-rhine Kconfig entry

Tony Lindgren:
  o [ARM PATCH] 1759/1: Add ARM925 support, updated

Walter Harms:
  o [NET]: Handle kmem_cache_create() failure in neighbour.c
  o [IPV4]: Handle kmem_cache_create() failure in inetpeer.c
  o [IPV4]: Handle kmem_cache_create() failure in ipmr.c
  o [IPV6]: Handle kmem_cache_create() failure in ip6_fib.c
  o [IPV6]: Handle kmem_cache_create() failure in route.c

Wensong Zhang:
  o [IPVS] remove the superfluous call of waitpid in sync code
  o [IPVS] retry to run kernel_thread when memory is temporarily
    exhausted
  o [IPVS] update the version number of code to 1.2.0
  o [IPVS] tidy up the header files to include

Yasuyuki Kozakai:
  o [IPV6]: In ipv6_skip_exthdr(), access frag header correctly
  o [NETFILTER]: Fix ipv6 TCP/UDP matching wrt. extension headers

Yoshinori Sato:
  o H8/300 start_thread problem fix
  o H8/300 include cleanup
  o H8/300 warning fix
  o H8/300 io.h bussizing problem fix
  o H8/300 Kconfig / defconfig update

