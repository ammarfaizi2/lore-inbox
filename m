Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSITPhf>; Fri, 20 Sep 2002 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSITPhe>; Fri, 20 Sep 2002 11:37:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60169 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262783AbSITPh1>; Fri, 20 Sep 2002 11:37:27 -0400
Date: Fri, 20 Sep 2002 08:45:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.37
Message-ID: <Pine.LNX.4.33.0209200840320.2721-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of stuff all over the map.  Arch updates (ppc*, sparc*, x86 machine
reorg), VM merges from Andrew, ACPI updates, BIO layer updates,
networking, driverfs, build process, pid hash, you name it it's there.

And that probably still means I missed some stuff.

		Linus


---
Summary of changes from v2.5.36 to v2.5.37
============================================

<ahaas@neosoft.com>:
  o designated initializer patches fs_freevxfs
  o designated initializer patches for fs_

Andrew Morton <akpm@digeo.com>:
  o Fix "multiple definition of 'smc_init'" error in smc-ircc irda
    driver, by making 'smc_init' static.
  o move madvise implementation into madvise.c
  o consolidate the VMA splitting code
  o mmap cleanup and lock ranking fixes
  o export unmap_underlying__metadata()
  o move the buffer_head IO functions into buffer.c
  o Add /proc/meminfo:Slab
  o clean up argument passing in writeback paths
  o free_area_init cleanup
  o _alloc_pages cleanup
  o remove statm_pgd_range
  o remove /proc/sys/vm/dirty_sync_thresh
  o swapout fix
  o writev speedup
  o readv/writev bounds checking fixes
  o fix suppression of page allocation failure warnings
  o fix mmap(MAP_LOCKED)
  o remove smp_lock.h inclusions from mm/*
  o hugetlbpages cleanup
  o blk_init() cleanups
  o misc fixes
  o reduced locking in release_pages()
  o permit hugetlb pages to be allocated from highmem

<bart.de.schuymer@pandora.be>:
  o [BRIDGE]: Add Ethernet bridge tables support

<cel@citi.umich.edu>:
  o (1/2) clean up RPC over TCP transport socket connect
  o (2/2) clean up RPC over TCP transport socket connect
  o stricter type checking for rpc auth flavors
  o rename svc_get/putlong as svc_get/putu32

<drow@false.org>:
  o Fix for ptrace breakage

Christoph Hellwig <hch@lst.de>:
  o remove scsi_queue.c
  o Add basic ethtool support to axnet_cs, wavelan_cs net drivers
    (originally by Arjan, merged and re-merged by hch)

<james@cobaltmountain.com>:
  o Typos in drivers_s390_net_iucv.c

James Bottomley <jejb@mulgrave.(none)>:
  o Split x86 into a generic component and a visws component
  o Arch Abstraction small correction
  o X86 arch split
  o Add arch split to setup.h
  o add ARCH_SETUP hook
  o More x86 arch splits
  o More Separation
  o [arch-split]
  o [arch-split]
  o [arch-split]
  o move smp_thermal_interrupt from i8259.c to hook in smpboot.c
  o Remove visws from kernel/pci/Makefile
  o [ARCH SPLIT]
  o [ARCH SPLIT]
  o Simple fix: move load_cr3 to new reboot.c file
  o Kill compile warning and correct bitkeeper mismerge
  o [ARCH-SPLIT]
  o Add back specific CONFIG_X86_HT gate for Xeon/P4 hyperthreading
  o [x86 arch split]
  o [arch/i386 subarch split] rename directories, move mpparse back to
    kernel
  o Remove last CONFIG_VISWS remnants from arch/i386/kernel
  o Add comment change back to visws
  o [arch split] merge cli->local_irq_disable change
  o Merge by hand
  o add back acpi targets lost in arch-split merge

<kafai0928@yahoo.com>:
  o Use SET_MODULE_OWNER in eepro100 net driver instead of
    MOD_{INC,DEC}_USE_COUNT, eliminating a small race

<khc@pm.waw.pl>:
  o A bunch of HDLC (WAN driver) bug fixes, plus much improves device
    and protocol attach/detach support.

<lucasvr@terra.com.br>:
  o 2.5.31_drivers_i2c_i2c-philips-par.c

Paul Mackerras <paulus@au1.ibm.com>:
  o PPC32: Update config.in and Makefile in arch/ppc
  o PPC32: Simplify the code in arch/ppc/kernel/ppc_htab.c a bit (no
    change in function).
  o PPC32: remove the last couple of BK tag lines

<ralf@dea.linux-mips.net>:
  o Redo locking of ax25_list with spinlocks
  o Properly handle sleep race without cli
  o Brain is short, so
  o Properly protect ax25_uid_list with a spinlock
  o Protect ax25_route_list by a spinlock
  o Replace cli / sti with spinlock for protection of protocol_list
  o Protect ax25_dev_list with it's own spinlock replacing the previous
    cli / sti mess.
  o Protect linkfail_list with a spinlock instead of the previous cli /
    sti mess
  o Initialize spinlock
  o Protect the ax25 fragmentation code with it's own spinlock
  o Protect listen_list also with a spinlock instead of cli / sti
  o Eleminate SOCKOPS_WRAPPED by using the BKL directly
  o Convert ax25_route_list by a rw_lock, no longer an interrup-save
    spinlock.
  o Split ax25_rt_ioctl() into several functions
  o Eleminate race caused by static variable in ax25_rt_find_route
  o Use ISO style labeled initializers
  o Don't use deliver_to_old_ones anymore
  o Reformat
  o Delete dead code
  o Implement reference counting and delayed destruction of routes
  o Implement reference counting for routes
  o Redo race avoidance with cli with wait_event-like construction
  o Replace cli & co for synchronization with spinlocks
  o Kill remaining sti()
  o Move ax25_put_route to <net/ax25.h>
  o Add missing lock_kernel() to ax25_connect
  o Implement locking of internal data for NET/ROM and ROSE
  o More reformatting of switch statements
  o Implement socket locking for AX.25, NET/ROM and ROSE timers
  o Replace interrupt-safe spinlocks with their bh-safe equivalents
  o Update todo list
  o Kill trailing whitespace
  o Add XID and TEST frame definitions
  o Taking over maintenance for AX.25, ROSE and NET/ROM for 2.5

<scottm@somanetworks.com>:
  o Small pcihpfs dnotify fix

<silicon@falcon.sch.bme.hu>:
  o comx-hw-munich WAN driver "performance fix": remove hideous udelay

<taka@valinux.co.jp>:
  o arch/i386/lib/checksum.S:csum_partial Handle oddly addressed
    buffers correctly

<thockin@freakshow.cobalt.com>:
  o Change drivers/net/natsemi.c to use netif_msg_*() Clean up some
    output messages in natsemi enet driver
  o get rid of a couple extraneous natsemi enet error messages
  o Natsemi ethernet driver fixes
  o Natsemi ethernet fixes
  o Natsemi enet: catch wraparound in ETHTOOL_GEEPROM
  o natsemi enet double decl compile fix

Adrian Bunk <bunk@fs.tum.de>:
  o fix cyclades.c compile error

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Merge 2.4.x updates to hppa-specific net driver lasi_82596
  o hp100 net driver update (probably from HP originally)

Andy Grover <agrover@groveronline.com>:
  o ACPI: Blacklist improvements 1) Split blacklist code out into a
    separate file.
  o ACPI: New blacklist entries (Andi Kleen)
  o ACPI
  o ACPI: Include proper header for acpi_enter_sleep_state() in
    suspend.c
  o ACPI: Fix Config.in to allow CONFIG_ACPI_SLEEP to be set properly
  o ACPI: Print the DSDT stats on boot, just like the other ACPI tables
  o ACPI: Add missing include to sleep.c
  o ACPI: Interpreter update to 20020918
  o ACPI: Ensure that the SCI has the proper polarity and trigger, even
  o Use ACPI fix map region instead of IOAPIC region, since it is
    undefined in non-SMP.

Anton Blanchard <anton@samba.org>:
  o ppc64: remove old debug, crashme found it pretty fast
  o ppc64: ppc_md cleanup
  o ppc64: pci updates
  o ppc64: the the strikes again
  o ppc64: we use rtas for all config accesses, so remove the
    unecessary ioremaps
  o ppc64: Allocate hugepages and exit_group syscalls
  o ppc64: sanity check PC and SP before preloading them
  o ppc64: DISCONTIGMEM updates
  o ppc64: enable exit_group syscall
  o ppc64: Actually restore FP regs in rt_sigreturn
  o ppc64: fix handling of sigaltstack
  o ppc64: Use generic asm/offset.h creation rules
  o ppc64: fix some compiler warnings
  o ppc64: print cpus in hex since we ask for them in hex
  o ppc64: clean up some 2.4 - 2.5 differences
  o ppc64: remove some old syscalls from the 64bit syscall table
  o ppc64: implement dump_stack
  o ppc64: CLEARTID/SETTID fixes
  o ppc64: only calculate local when we need it, from paulus
  o ppc64: Add MAP_LOCKED
  o ppc64: wrap pidhash reference for the moment
  o ppc64: fix sys32_select race with max_fdset
  o ppc64: DISCONTIGMEM updates
  o ppc64: kill node_startnr, implement node_end_pfn

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o [LLC] change semantics of recvmsg and sendmsg
  o [LLC] timer cleanup: use mod_timer
  o [LLC] Don't call sock_alloc_send_skb with the socket lock held
  o [LLC] check if we have space in the socket to receive the packet

Brad Hards <bhards@bigpond.net.au>:
  o Re: header cleanup - drivers_char_eurotechwdt.c

David S. Miller <davem@nuts.ninka.net>:
  o [TIGON3]: Fiber WOL support, chip clock bug fix
  o arch/sparc64/kernel/sparc64_ksyms.c: Remove kbd_pt_regs export,
    kernel/ksyms.c does it
  o [SPARC]: Move over to for_each_process
  o [TIGON3]: Comment out tg3_enable_ints PCI write flush for now
  o [SPARC]: First cut of hugetlb on sparc64, 4MB currently
  o arch/sparc64/defconfig: Update
  o [TIGON3]: Fix link polarity setting on all non-5700 chips
  o [TIGON3]: Optimize NAPI irq masking a bit
  o [TIGON3]: Define NIC_SRAM_MBUF_POOL_SIZE64 properly
  o fs/filemap.c: Add back mistakedly removed flush_dcache_page
  o arch/sparc64/Makefile: Undef sparc too when building vmlinux.lds.s
  o drivers/char/rtc.c: For sparc, include linux/pci.h instead of
    asm/pci.h
  o kernel/signal.c: Handle SIGEMT
  o [SPARC]: Source net/ax25/Config.in
  o [AX25]: Make ax25_rt_destroy return void
  o [AX25]: Remove unused label from ax25_get_socket, add XXX comment
  o [NETROM]: Fix setting of nr in nr_transmit_buffer
  o [ROSE]: Kill 64-bit warning in rose_connect
  o [TIGON3]: TSO fixes, but still disabled because the performance is
    dreadful
  o fs/nfs/nfs{2,3}xdr.c: Use correct printf format for size_t
  o drivers/ide/ide-taskfile.c: u64 != long long
  o drivers/ide/ide.c: u64 != long long
  o drivers/ide/ide-proc.c: u64 != long long
  o drivers/net/ppp_generic.c:ppp_receive_frame Delete unused label err
  o fs/xfs/linux/xfs_aops.c:linvfs_get_block_core Use min_t
  o drivers/pci/pool.c:show_pools Use correct size_t printf format
  o drivers/usb/serial/visor.c: Kill 64-bit cast ptr to int warnings
  o kernel/pid.c:next_free_map Pass 3rd arg to cmpxchg as pointer
  o drivers/ieee1394/dv1394.c: Protect devfs stuff properly
  o drivers/ieee1394/dv1394.c: Fix typo in previous change
  o drivers/ieee1394/dv1394.c: Protect more devfs stuff
  o include/asm-sparc64/system.h: Remove CHECK_LOCKS debugging
  o [SPARC64]: Trap kernel bogus program counter at fault time
  o arch/sparc64/defconfig: Update

David S. Miller <davem@redhat.com>:
  o Fix compiler warnings in e100 net driver
  o block device oopses on shutdown in 2.5.x

Greg Kroah-Hartman <greg@kroah.com>:
  o export __inode_dir_notify so that dnotify can be called from
    filesystems in modules
  o PCI Hotplug: added max bus speed and current bus speed files to the
    pci hotplug core
  o PCI Hotplug: added speed status to the Compaq driver
  o PCI Hotplug: added speed status to the IBM driver
  o PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio
    Cesare
  o PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted
    on

Ingo Molnar <mingo@elte.hu>:
  o generic-pidhash-2.5.36-J2, BK-curr
  o session handling using pid lists
  o pidhash-fix-2.5.36-A0

Jean Tourrilhes <jt@hpl.hp.com>:
  o irda update 1-6
  o This is Wireless Extension v15. Mostly enhanced iwpriv support for
    the HostAP driver, with few cleanups and new unused definitions.
    The most contention change is that this version now requires user
    space to provide the buffer size when making a GET (to check buffer
    overrun), which will break very old version of Wireless Tools (v22
    and earlier).
  o A few cleanups for the old ISA wavelen wireless driver
  o Cleanups for the wavelan pcmcia wireless driver
  o This add spinlock protection to the Netwave wireless driver and
    gets rid of save_flags();cli();. I was pleasantly surprised that
    the driver was working fine on my SMP system with those obvious
    fixes. Tested on 2.5.32 SMP.

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o synchronize_irq fixups for old-OSS audio driver cs4281
  o Add netif_carrier_xxx support to 3c59x net driver (based on patch
    from Nelson Tan Gin Hwa, via Andrew Morton)
  o Merge up to version 1.04 of sundance net driver
  o Add support for Cirrus Logic GD7548 chip to clgenfb fbdev driver
    (contributed by gabucino@mplayerhq.hu)
  o Fix __FUNCTION__ breakage in several irda drivers
  o Add two NETIF_MSG_xxx constants to linux/netdevice.h, that are used
    in natsemi net driver
  o merge most of hppa support for tulip net driver
  o Fixes for little-used paths and obscure races, in 8139cp net driver
    (contributed by matthias@waechter.wiz.at)
  o Update list of airo wireless commands, and two RIDs, from
    linux-wlan-ng sources and online sources
  o sundance net driver fixes, and a few cleanups too
  o clean up previous sundance net driver fixes
  o sundance modernization
  o Update eepro100 hardware resume to latest Becker eepro100.c
  o more fixes for sundance net driver
  o Improve sundance net driver RX buf size calculation (suggested by
    Donald Becker)
  o Hey... where did those e100 warnings come from? (kill more e100
    compiler warnings)
  o Update eepro100 net driver's mdio_{read,write} functions to take
    'struct net_device *' not 'long' as their first argument.  This
    makes eepro100 compatible with the standard MII ethtool API,
    preparing it for that support.
  o update eepro100 net driver to use standard MII phy API/lib, when
    implementing ethtool media ioctls.

Jens Axboe <axboe@suse.de>:
  o impose sane queue restrictions
  o bio_add_page()
  o make mpage use bio_add_page()
  o partial bio completion notification
  o jfs and xfs update
  o scsi doesn't need locking around end_that_request_first()
  o xfs, use bio_add_page()
  o bio_endio() cleanups
  o umem and DAC960 bio_endio()
  o Update md to new i/o completions
  o nbd bio_endio()
  o cleanup + fix bounce end_io handling
  o fix ide highmem bounce enable
  o IDE maintainer updates

Jes Sorensen <jes@wildopensource.com>:
  o acenic net driver update

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Remove O_TARGETS which creeped back in
  o kbuild: Remove O_TARGET in arch/i386/*
  o kbuild: Remove O_TARGET from {kernel,mm,fs,...}/Makefile
  o kbuild: Use new $(libs-y) in arch/i386/Makefile
  o kbuild: Always make an L_TARGET "lib.a"
  o kbuild: Lost update to top-level Makefile
  o ISDN: Fix typo for hisax/st5481 driver
  o kbuild: Remove leftover debugging line
  o kbuild: Fix build number generation

Keith Owens <kaos@ocs.com.au>:
  o Remove Keith Owens from MAINTAINERS

Linus Torvalds <torvalds@home.transmeta.com>:
  o Missing EOL noticed by Chuck Lever
  o Make pid_max grow dynamically as needed
  o If slab debugging is enabled, don't batch slabs on the per-cpu
    lists by default. The batching avoids some debug tests.
  o Remove bogus timer optimization - even if the timer isn't pending,
    it might be actively running on another CPU, so we still need to do
    the synchronous wait.
  o Fix up some merge issues for the Makefle changes in the
    arch-splitup

Manfred Spraul <manfred@colorfullife.com>:
  o [RANDOM]: Fix bugs in ipv{4,6} ID/SEQ generation, mostly SMP
    issues.  Reviewed by Ted Tso

Patrick Mochel <mochel@osdl.org>:
  o Update driver model documentation
  o Add class_data field to struct device, for the class drivers to use
  o Add add() callback to struct bus_type
  o Add struct bus_type platform_bus and document its intentions
  o clean up driverfs removal of directories
  o driver model: Don't reset dev->driver until after we call
    dev->driver->remove
  o PCI: make sure the devices are named before they're registered
  o driver model: use list_for_each_safe in device_shutdown(), since
    devices can be removed from the global list in the process.
  o ACPI: move PREFIX to a common header
  o ACPI: Move sleep code from system.c to sleep.c
  o ACPI: Remove unnecessary objects and code from
    drivers/acpi/system.c
  o ACPI: break procfs handlers for acpi events and debug levels out of
    drivers/acpi/system.c and into their own files
  o ACPI: make CONFIG_ACPI_SLEEP _not_ dependent on
    CONFIG_SOFTWARE_SUSPEND and add help text.
  o ACPI: Remove dead code from drivers/acpi/bus.c
  o ACPI: Remove acpi_exit() and friends, since it's never called
  o ACPI: set acpi_disabled = 1 if acpi_bus_init() fails, and check
    this in the init functions for the other components.
  o ACPI: Move all namespace scanning functions from drivers/acpi/bus.c
    to drivers/acpi/scan.c
  o ACPI: remove the rest of the explicit init function calls and move
    them into the various files and make them initcalls.
  o ACPI: Remove call to acpi_ec_ecdt_probe() in acpi_bus_init() and
    make it a part
  o ACPI: Treat acpi_root_dir as acpi_root_dir when initializing (not
    acpi_device_dir(acpi_root)) (and fix OOPS on boot because acpi_root
    is NULL).
  o ACPI: Move per-componet defines into component files. Only share in
    headers what is needed by multiple users.
  o ACPI: Add call to acpi_ec_ecdt_probe() from acpi_bus_init() again
    and fix the comment to explicitly say that it must be called before
    acpi_initialize_objects().
  o ACPI: Don't use driver model for struct acpi_device; use driverfs
    directly
  o ACPI: move sleep file defines to drivers/acpi/sleep.c (where
    they're used)
  o ACPI: greatly simplify acpi device and acpi driver binding
  o ACPI: lots of minor cleanups in drivers/acpi/scan.c
  o ACPI: don't match every device to every driver

Paul Mackerras <paulus@samba.org>:
  o PPC32: Rip out the BK Id tags from arch/ppc and include/asm-ppc
  o PPC32: Don't count up the "zombie" MMU hashtable entries

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Fix noncache leaks
  o [SPARC32]: Fix console, sunsu, and IO macros
  o [SPARC]: RTC build fixes and allow as a module
  o [SPARC]: Export syms necessary for rtc as module
  o drivers/net/tun.c: Fix warning and missing overflow check

Roger Luethi <rl@hellgate.ch>:
  o Remove ancient ETHER_STATS statistics from various net drivers,
    that haven't been compile-enabled nor compileable in ages.

Russell King <rmk@arm.linux.org.uk>:
  o This patch fixes a bug in handling the timeout in pcnet_cs.c, where
    it uses the following test to determine whether the timeout has
    expired:

Rusty Russell <rusty@rustcorp.com.au>:
  o Re: per_cpu data question
  o Designated initializers for drivers_bluetooth

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Boot wrapper updates
  o PPC-specific 3c509 net driver update

Urban Widmark <urban@teststation.com>:
  o smbfs - C99 stuff


