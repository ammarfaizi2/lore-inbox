Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSJLEze>; Sat, 12 Oct 2002 00:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSJLEze>; Sat, 12 Oct 2002 00:55:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52233 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262803AbSJLEz1>; Sat, 12 Oct 2002 00:55:27 -0400
Date: Fri, 11 Oct 2002 21:59:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Jens Axboe <axboe@suse.de>
Subject: Linux v2.5.42
Message-ID: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Augh.. People have been mailbombing me apparently because a lot of people 
finally decided that they really want to sync with me due to the upcoming 
feature freeze, so there's a _lot_ of stuff here, all over the map.

Both the NFS client and the server are getting facelifts to support NFSv4.
And both Dave Jones and Alan Cox decided to try to merge more stuff with
me - along with the usual stream from Andrew Morton.

In addition, we have build updates, ISDN, ACPI, input layer, network
drivers and driverfs.. Along with a random collection of other stuff: USB,
s390, ppc etc.

End result: 1MB worth of compressed patches - in four days. 

			Linus


PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
stand.  I'm not using any kind of volume management personally, so I just
don't have the background or inclination to walk through the patches and
make that kind of decision. My non-scientific opinion is that it looks 
like the EVMS code is going to be merged, but ..

Alan, Jens, Christoph, others - this is going to be an area where I need
input from people I know, and preferably also help merging. I've been 
happy to see the EVMS patches being discussed on linux-kernel, and I just 
wanted to let people know that this needs outside help.

----

Summary of changes from v2.5.41 to v2.5.42
============================================

<aderesch@fs.tum.de>:
  o Increase the resync timeout for serial mice, and fix MZ wheel
    direction

<akropel1@rochester.rr.com>:
  o cpqarray compile fixes
  o cpqarray SMP deadlock fix

Dave Jones <davej@codemonkey.org.uk>:
  o document extra option in isapnp
  o updated comments
  o bad userspace dereferencing
  o handle bogus zero IO-APIC addresses
  o JBD documentation
  o oss compile fix (missing spinlock)
  o kernel parameters update
  o increase PCI namespace buffer
  o move apic_timer_irqs to irqstat
  o Missing/Unneeded includes
  o mountable futexfs
  o missing files in mrproper
  o P4 SPIV FOCUS bit
  o APM SMP fixes
  o fix leak in pcf8583
  o missing sanity check in ppdev
  o parport docs typo
  o Updated proc docs from 2.4
  o Updated submitting drivers docs
  o Document randconfig
  o various typo fixes
  o major showstopper diff
  o Updated DMA-mapping docs
  o fix broken syntax in video config.in
  o Document VIA C3
  o vmalloc corner case
  o only allow IGMP to multicast addresses
  o KT266x latency fix
  o intel cache parsing update
  o DMI updates
  o vm86 updates
  o IRQ router updates
  o Misc reboot.c bits
  o numerous __FUNCTION__ pasting fixes
  o unify slab namespace
  o Don't prefetch io space
  o use cpu_has macros
  o tlbflush cleanups
  o indentation fixes
  o death of v86mode
  o named initialisers for dcache
  o ifdef noise cleanup
  o io.h unobfuscation
  o ISAPNP updates
  o bluesmoke fixes
  o arch fixes for make rpm
  o jiffy wrap fixes
  o x86 math-emu update
  o Add ALI 1671 support to AGPGART
  o CONFIG_NR_CPUS
  o avoid trigraphs in generated pci ids
  o Escape quotes in menuconfig
  o increase list_del_init usage
  o named struct initialisers
  o cpqarray reads ->irq before pci_enable_device()
  o pci_enable_device before accessing ->irq for wdt_pci
  o i845 AGPGART power management
  o Remove code duplication in power.c
  o missing checks in acorn drivers
  o sun3 ncr scsi driver update
  o more devexit fixes
  o More list_del_init usage increases
  o Make work throttling actually work,
  o Remove useless mdelay wrapper in pcxx.c
  o CONFIG_ISA optional on x86
  o zoran named initialisers
  o TTY_DO_WRITE_WAKEUP
  o Missing kmalloc check in iphase driver
  o random fixes for random.c
  o module fixes for qtronix.c
  o sanitise proc usage in zoran driver
  o radio-zoltrix typo
  o Various drivers using longs instead of ulongs for flags

<dsteklof@us.ibm.com>:
  o driver core: add generic logging macros for devices

<fubar@us.ibm.com>:
  o Prevent EFAULT errors when checking link status, in bonding net
    driver

Jeff Dike <jdike@jdike.wstearns.org>:
  o xor.h was created as asm-um/xor.h rather than include/asm-um/xor.h
  o A number of bug fixes from UML 2.4.19-6 -
  o Removed from user_util.h the declarations that are now in
    time_user.h
  o Small changes to bring UML up to date with 2.5.40
  o A set of small bug fixes brought over from 2.4.19-8
  o A bunch of network updates from 2.4.19
  o A small network bug fix from 2.4.19-7
  o Updated defconfig with CONFIG_UML_NET_PCAP
  o Back out a piece of the last merge which didn't apply in 2.5
  o Fixed a bit of the last merge which I messed up
  o Fixed a build bug with CONFIG_UML_NET_PCAP
  o Changed my mind about having CONFIG_UML_NET_PCAP enabled by default
    in defconfig.  This would cause the default config to break on any
    system without libpcap, so disabling it by default is better.
  o I forgot to add include/asm-um/topology to the repo
  o Updated initializers in the block driver
  o Updates to make UML build as 2.5.41
  o Added a missing directory to the arch/um/kernel Makefile

<jeb.j.cramer@intel.com>:
  o e1000 net driver minor fixes/cleanups

<khaho@koti.soon.fi>:
  o Make Logitech Desktop Pro (wireless keyboard & mouse) work with all
    buttons and wheel

<kronos@kronoz.cjb.net>:
  o C99 designated initializers

<mac@melware.de>:
  o ISDN: Add new Eicon driver

<markh@osdl.org>:
  o aacraid Makefile error in 2.5.41

Martin Bligh <mbligh@aracnet.com>:
  o NUMA-Q fixes

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>:
  o 2.5.40: fix chmod/chown on procfs

<plars@linuxtestproject.org>:
  o ips.c remove tqueue.h

Richard Henderson <rth@are.twiddle.net>:
  o Move syscall table out to new file.  Prevent entSys constants from
    being out of sync with it.
  o Merge minor changes from entry_rewrite tree
  o Make sysrq-b halt on SRM
  o Fix missed variable rename in stxncpy glibc conversion
  o Avoid oops on systems that set atkbd_reset

<stevef@smfhome1.austin.rr.com>:
  o Initial check in of cifs filesystem version 0.54 for Linux 2.5 (to
    clean tree as one changeset)

Thomas Molina <tmolina@cox.net>:
  o remove double "lock" in v_midi.h
  o missing exports

<zw@superlucidity.net>:
  o Several fixes in the uinput.c userspace input driver. Size of fifo,
    handling of flag bits, etc.

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix cut and paste error in amd768rng help
  o fix all the isdn compile mess
  o cadet needless globals
  o mpt fusion - remove donothing code
  o un-tqueue aironet
  o bring I2O roughly back into line
  o 2.5 clean up of DE600
  o fix ibmtr mapping bug
  o 2.5 cleanup + 2.4 merge of depca
  o (forwarded) Olympic fixes
  o fix orinoco build
  o Suppose we unload with the timer function live ?
  o fix aha152x
  o make dmx1391 work with new 5380
  o make tcic work again
  o update fdomain scsi
  o fix imm compile
  o make pas16 work with new NCR5380
  o fix ppa
  o fix t128 for new NCR5380
  o first pass at seagate st-02 for 2.5
  o wd7000 lock error Willy noticed
  o fix telephony for tqueue
  o fix gcc 3.1/2 warnings in USB
  o Fix 2.5 signal handling in jffs/jffs2
  o tidy for the max_thread stuff from the kernel list
  o trivial sound static/cast fixes
  o fix warnings in fpu code
  o first pass over the in2000
  o 3c501 for 2.5

Alexander Viro <viro@math.psu.edu>:
  o compile fixes

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o net/ipv4/igmp.c: Revert PACKET_MULTICAST check

Andi Kleen <ak@muc.de>:
  o Efficient bswab64 for i386

Andrew Morton <akpm@digeo.com>:
  o fix READA in ll_rw_block()
  o discontigmem compilation fix
  o discontigmem fixes and cleanups
  o node-local mem_map for ia32 discontigmem
  o remove get_free_page()
  o numa: alloc_pages_node cleanup
  o free_area_init cleanup
  o move library functions from ramfs into libfs
  o ext3 indexed directory support
  o 64-bit sector_t - various driver changes
  o 64-bit sector_t - printk changes and sector_t cleanup
  o 64-bit sector_t - driver changes
  o 64-bit sector_t - filesystems
  o 64-bit sector_t - md fixes
  o 64-bit sector_t - remove udivdi3, use sector_div()
  o Fix xxx_get_biosgeometry --- avoid useless 64-bit division
  o Hardwire CONFIG_LBD to "on" for testing
  o mremap use-after-free bugfix
  o move_one_page atomicity fix
  o fix the raw driver
  o remove radix_tree_reserve()
  o remove the sched_yield from the ext3 fsync path
  o make readv/writev return 0 for 0 segments
  o x86 uniproc compile fix
  o various fixes

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o isofs fix
  o keyboard repeat code fix

Andy Grover <agrover@groveronline.com>:
  o ACPI: Replace ACPI_DEBUG define with ACPI_DEBUG_OUTPUT (Dominik
    Brodowski)
  o ACPI: Fix reversed logic in blacklist code (Sergio Monteiro Basto)
  o ACPI: IA64 fixes (David Mosberger)
  o ACPI: Fix /proc/acpi/sleep (P. Christeas)
  o ACPI: Fix thermal management and make trip points R/W (Pavel
    Machek)
  o ACPI: Allow handling negative celsius values (Kochi Takayoshi)
  o ACPI: Add another cast to Bjoern's MADT walking fix to silence
    warning
  o ACPI: Initialize thermal driver's timer before it is used (Knut
    Neumann)
  o ACPI: Interpreter update to 200201002

Anton Altaparmakov <aia21@cantab.net>:
  o Add functions for searching for an inode in icache and getting a
    reference to it if present - fs/inode.c::ilookup() and ilookup5(),
    mirroring the iget_locked() and iget5_locked() function pair. Also
    add two internal helpers ifind_fast() and ifind() respectively
    which will later be used by iget_locked() and iget5_locked() to do
    the search, too.
  o Cleanup: Convert fs/inode.c::iget_locked() and iget5_locked() to
    use the new ifind_fast() and ifind() helpers, respectively.

Anton Blanchard <anton@samba.org>:
  o one of these things is not like the others
  o fix NLS config.in

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o hid-input: fix find_next_zero_bit usage
  o Appletalk: convert some spinlocks to rwlocks
  o IPX: fix permission bogosity in create_proc_entry usage
  o LLC: fix permission bogosity in create_proc_entry usage
  o Appletalk: convert aarp_lock from spinlock to rwlock

Art Haas <ahaas@neosoft.com>:
  o named initializers all over the place

Benjamin LaHaise <bcrl@redhat.com>:
  o [AIO]: First stage of AIO infrastructure for networking
  o fix symbol export in fs/read_write.c
  o v2.5.31-aio-nohighmem.diff
  o correct return value from aio_complete on sync iocbs
  o update ns83820.c to v0.19
  o sync iocbs need to actually wake_up_process the waiter (as spotted
    by Suparna)
  o several updates for testing aio_{read,write} support for file
    descriptors with only async ops in vfs_{read,write}
  o several minor bugfixes for the aio core
  o create support for iocb kicking, where a retry operation gets
    triggered in the mm context of the submitter to allow the use of
    copy_*_user.
  o queue descriptor io errors instead of returning them from io_submit
  o adapt aio kick changes to ingo's work queues
  o buildbug.diff
  o fix missing list initialization in aio context creation
  o fix a bug in kick_iocb that caused it to fail for async iocbs
  o update ns83820 to 0.20
  o fix typo in aio.c merge
  o export do_sync_{read,write} for modules
  o fix compile glitch introduced by the addition of symbol exports

Brad Hards <bhards@bigpond.net.au>:
  o Better naming for USB input devices that omit the manufacturer name

Brian Gerst <bgerst@didntduck.org>:
  o struct super_block cleanup - final

Chris Wright <chris@wirex.com>:
  o LSM: move the inode_alloc_security hook

Christoph Hellwig <hch@lst.de>:
  o initcalls for ATM

David Brownell <david-b@pacbell.net>:
  o usbtest: mo'betta devices, control tests

David S. Miller <davem@nuts.ninka.net>:
  o net/ipv6/addrconf.c: Need __constant_XXX for case statements
  o [ESP/QLOGICPTI]: Only set highmem_io on sparc64
  o [DECNET]: Kill warnings
  o [IPV4/IPV6]: Cleanup inet{,6}_protocol
  o include/net/sock.h: Kill __async_lock_sock extern for now
  o drivers/scsi/scsi.h: Add back sync/wide members for host drivers
  o [CRIS/SPARC/SPARC64]: Init mem_map after free_area_init_node
  o drivers/net/pppoe.c: Use sock_owned_by_user
  o [SCTP]: Use sock_owned_by_user
  o arch/sparc64/kernel/ioctl32.c: Block ioctl handling fix

david_jeffery@adaptec.com <David_Jeffery@adaptec.com>:
  o ips driver 1-6

Doug Ledford <dledford@redhat.com>:
  o make SCSI queue depth adjustable
  o Updated scsi patch
  o compile fix for cpqfc driver
  o atp870 driver
  o redo of scsi.h changes
  o Updates for the scsi.h removal of device specific data from struct
    scsi_device
  o tcq fixes for the issue on linux-kernel
  o aic7xxx_old update and a compile warning fix in scsi.c
  o Make the rest of the world happy with ips again

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Please apply this small clean up, too

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix ctsrts handling in pl2303 driver
  o LSM: added lsm documentation to the tree
  o driver core: rename DEVICE to DEVPATH for /sbin/hotplug call to
    prevent conflict with USB
  o USB: add device speed driverfs file
  o USB: removed unused DEVFS /sbin/hotplug attribute
  o minor i386 timer changes for 2.5.41

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o net/ipv6/addrconf.c: Use prefix of 64 for link-local addresses

Ingo Molnar <mingo@elte.hu>:
  o timer cleanups
  o sched-2.5.41-A0

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha build fixes

Jan Harkes <jaharkes@cs.cmu.edu>:
  o Coda FS update

Jean Tourrilhes <jt@hpl.hp.com>:
  o irda update 1-6, big vlsi_ir driver update

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Revert incorrect s/__exit/__devexit/ change to tmspci tokenring
    drvr
  o [netdrvr] Use ADVERTISE_FULL in mii lib, to clean up duplex check
  o Support multiple cards in ewrk3 net driver (contributed by Adam
    Kropelin)

Jens Axboe <axboe@suse.de>:
  o make bio->bi_max contain max vec entries
  o ide tagged command queueing support
  o Scsi sense buffer thinko
  o excessive stack usage in cdrom

Johannes Erdfelt <johannes@erdfelt.com>:
  o USB: Trivial MAINTAINERS update

John Stultz <johnstul@us.ibm.com>:
  o linux-2.5.41_timer-changes_A4 (1/3 - infrastructure)
  o linux-2.5.41_timer-changes_A4 (2/3 - bulk move)
  o linux-2.5.41_timer-changes_A4 (3/3 - integration)
  o linux-2.5.41_cyclone-timer_B2
  o linux-2.5.41_cyclone-fixes_A1

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Call scripts explicitly via sh
  o kbuild: Fix drivers/scsi/aacraid/Makefile
  o kbuild: Remove now unnecessary usages of $(TOPDIR)
  o kbuild: Buglet in Documentation/DocBook/Makefile
  o kbuild: typos
  o ISDN: race-free incoming call handling
  o ISDN: Accept incoming calls and do callback in the state machine
  o ISDN: Move generic bits from isdn_net_lib to isdn_common
  o ISDN: Move binding the interface into state machine
  o ISDN: ref counting for isdn_net_local / isdn_net_dev

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix missing printk end-of-line
  o Oops, removed one too many header includes
  o Don't declare pcibios_fixup_irqs, it's static inside irq.c
  o firestream compile fix
  o Get PageUp handling right
  o Declare set_change_info() only if CONFIG_NFSD_V3 is enabled. It
    uses fields that do not exist otherwise.
  o wd7000 indent pass, no code changes
  o Clean up after timers - move the "timers" Makefile info into the
    proper subdirectory (kernel) where it is used.

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Initialize Bluetooth core using subsys_initcall()
  o RFCOMM core API extensions. Improved /proc/bluetooth/rfcomm format

Marcel Holtmann <marcel@holtmann.org>:
  o Make it possible to compile in the Bluetooth subsystem

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 update: compile fixes
  o s390 update: work queues
  o s390 update: tasklets
  o s390 update: linker script typo
  o s390 update: superfluous memset
  o s390 update: syscall tracing
  o s390 update: 3270 console

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd: Remove the nfs-devel list from MAINTAINERS
  o kNFSd: Use correct value for max size for readlink response
  o kNFSd: A couple of possible incorrect calls to dput
  o kNFSd: pre-zero response for lockd _msg requests
  o kNFSd: header file for NFSv4 XDR
  o kNFSd: Expand nfsd filehandle to 128 bytes
  o kNFSd: new routine fh_dup2()
  o kNFSd: New routine exp_pseudoroot() to find 'root' filehandle for
    nfsv4
  o kNFSd: ensure XDR buffer is large enough for NFSv4
  o kNFSd: Stub support for name lookup
  o kNFSd: Giant patch importing NFSv4 server functionality
  o kNFSd: Enable selection of NFSv4 server in configurator and
    Makefile
  o kNFSd: Tidy up the rpc authentication interface
  o kNFSd: Initialial caching infrastructure for RPC authentication
    caches
  o kNFSd: Use new cache infrastructure for auth_unix specific lookups
  o kNFSd: Move auth domain lookup into svcauth
  o kNFSd: exp_getclient, now just a small wrapper, goes in favour of
    auth_unix_lookup
  o kNFSd: Open code exp_get and exp_get_fsid in the one place they are
    called
  o kNFSd: Convert export-table to use new cache code
  o kNFSd: Don't over-write rpc request with response
  o kNFSd: decode symlink inplace to avoid modifying request
  o kNFSd: Provide support for request deferral and revisit
  o kNFSd: Create files: /proc/net/rpc/$CACHENAME/channel for
    communicating cache updates with kernel
  o kNFSd: Provide generic code for making an upcall
  o kNFSd: Implement ip_map_request for upcalls
  o kNFSd: Implement get_word to help in parsing cache updates
  o kNFSd: get_int and get_expiry to help in parsing
  o kNFSd: Impletement ip_map_parse to allow filling auth.unix.ip cache
  o kNFSd: upcall/update for export tables

Patrick Mochel <mochel@osdl.org>:
  o driver model: and present field to struct device and implement
    device_unregister()
  o driver model: check return of get_device() when creating a driverfs
    file
  o IDE: call device_unregister() instead of put_device() in
    ide-disk->cleanup()
  o USB: call device_unregister() instead of put_device() when removing
    devices
  o IDE: only register devices that are present
  o IDE: add struct device to ide_drive_t and use that for IDE drives
  o IDE: register ide driver for all ide drives; not just for disk
    drives
  o IDE: Add generic remove() method for drives; remove reboot notifier
  o IDE: make ide_drive_remove() call driver's ->cleanup()

Paul Mackerras <paulus@samba.org>:
  o PPC32: Reorganize the files for the IBM 4xx embedded PPC processors
  o PPC32: Move a couple of 4xx-related files around
  o PPC32: Rename sigcontext_struct to sigcontext, and use sig->siglock
  o PPC32: Use prepare target to make the assembler offsets header file
  o PPC32: Add the kallsyms section to arch/ppc/vmlinux.lds.S
  o PPC32: fix in_atomic; PREEMPT_ACTIVE set doesn't mean atomic
  o PPC32: put the _right_ asm-offsets.c in
  o PPC32: fix the last sigcontext_struct, missed previously
  o PPC32: Add kallsyms support in stack tracing functions
  o PPC32: fix arch-level tid handling
  o PPC32: Add might_sleep() calls to down and down_interruptible
  o PPC32: change the pmd macros to allow us to support large TLB
    entries
  o add PCI device ID for Motorola MPC107
  o adjust PPC sysctls

Peter Chubb <peter@chubb.wattle.id.au>:
  o fix crash in yenta_bh() on card insertion/removal

Randy Dunlap <rddunlap@osdl.org>:
  o build cpia video driver

Richard Zidlicky <rz@linux-m68k.org>:
  o Move beeping and sysrq to input layer on m68k

Robert Love <rml@tech9.net>:
  o fix preempt_count overflow with brlocks
  o getpid() comment typo

Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>:
  o improve NCR53c710 SCSI driver

Russell King <rmk@flint.arm.linux.org.uk>:
  o [SERIAL] Remove old pci_board cruft from serialP.h
  o [SERIAL] Fix uart_type compilation error when CONFIG_PROC_FS=n
  o [SERIAL] Fix oops when removing some PCI serial boards Patch from
    William Lee Irwin II.
  o [SERIAL] Fix serial.h/serialP.h ordering nightmare

Sam Ravnborg <sam@ravnborg.org>:
  o drivers/scsi - Makefile fix

Stephen Rothwell <sfr@canb.auug.org.au>:
  o fix __SI_CODE

Stephen Smalley <sds@tislabs.com>:
  o Base set of LSM hooks for SysV IPC

Steven Whitehouse <steve@gw.chygwyn.com>:
  o [DECNET]: New autoconfiguration code for 2.5

Tom Callaway <tcallawa@redhat.com>:
  o arch/sparc64/solaris/misc.c: Add MODULE_LICENSE

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o NFSv4 client for 2.5.x
  o Fix NFS locking over TCP
  o Remove unbalanced kunmap() in NFS readdir code
  o Disable Nagle algorithm for RPC over TCP

Vojtech Pavlik <vojtech@suse.cz>:
  o Remove several files no longer used on m68k
  o Add support for PS/2 Active Multiplexing Spec, updates for PS/2
    mouse and keyboard handling - proper cleanup on reboot, allow
    USB-emulated AT keyboards, option to restrict PS/2 mouse to generic
    mode.
  o Update Wacom driver to 2.4 changes and changes from Ping Cheng of
    Wacom
  o Convert gameport.[ch] to use lists.h for its linked lists
  o Convert serio.[ch] to use list.h lists
  o Cleanups and fixes for the Wacom USB driver
  o Add #include <list.h> to input.h
  o Use list_for_each_entry() in input.c
  o Convert more of input to list.h usage
  o Fixes/cleanups after converting drivers to list.h lists
  o Accept 0xfa as an "OK" result code for AUX TEST cmd in i8042.c
  o Add japanese Set 3 scancodes to atkbd.c
  o Fix LAlt-RAlt combination on AT keyboards (generated "unknown
    scancode" message)
  o Make NR_KEYS be (KEY_MAX+1) so that keybindings can be set for keys
    over 128.
  o psmouse.c: ignore the sync bit to make slightly non-conforming
    devices work.
  o Change PC-keyboard mappings to follow MS Keyboards - a de facto
    standard for extended keys.
  o Initialize struct input_dev in input drivers before it's passed to
    input_event()
  o Add german keyboard \ to the default table of atkbd.c
  o Make i8042.c even less picky about detecting an AUX port because of
    broken chipsets that don't support the LOOP command or report
    failure
  o Add japanese bar key mapping to the default table in atkbd.c
  o Fix the Shift-PgUp problem again, and hopefully for good
  o Fix i8042 for Sun, recent updates broke it
  o Fix oops when 'cat /dev/uinput' is done. Used
    wait_event_interruptible()
  o Don't try to enable extra keys on IBM/Chicony keyboards as this
    upsets several notebook keyboards. Until we find a better solution
    how to detect who are we talking to, we rely on the kernel command
    line. Use atkbd_set=4 to gain access to the extra keys.
  o Fix a ; in atkbd.c that somehow got into the last cset
  o Fixes in i8042.c Active Multiplexing support

Zwane Mwaikambo <zwane@linuxpower.ca>:
  o Add ethtool media support to 3c509 net driver
  o Add ethtool media support to smc91c92_cs net driver


