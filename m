Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSHKB7m>; Sat, 10 Aug 2002 21:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSHKB7m>; Sat, 10 Aug 2002 21:59:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54034 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317415AbSHKB7i>; Sat, 10 Aug 2002 21:59:38 -0400
Date: Sat, 10 Aug 2002 19:04:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.31
Message-ID: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm. I've switched home machines this week, and people have been
reasonably busy, so there is most likely a lot of dropped stuff.

There's a lot of merged stuff too, including various architectures getting
up to speed with all the big changes (tlb and irq etc, and rmk is
apparently trying to shrink his arm patch).  Sparc64, alpha, ppc32, ARM..

The series of patches from Al Viro should fix a semaphore deadlock when
partition reading was triggered while a new device was opened, and lay the 
groundwork for more disk description cleanups.

NTFS, JFS, driverfs and networking updates. USB, ISDN and network driver
updates, partial merge with akpm (you've seen the discussions about some
of the stuff dropped) etc. And let's see how much fallout there is from
the 30-bit pids etc.

		Linus

-----

Summary of changes from v2.5.30 to v2.5.31
============================================

<aaron.baranoff@tsc.tdk.com>:
  o Add pci id to tulip net driver

<ahaas@neosoft.com>:
  o designated initializer patch for usr_input_aiptek.c
  o designated initializer patch for usb_media_se401.c

<alan@irongate.swansea.linux.org.uk>:
  o VLAN: Fix gcc-3.1 warnings

<antoine@ausone.whoknows>:
  o Add pci id to tulip net driver

<dsaxena@mvista.com>:
  o [ARM PATCH] 1215/1: Vector relocation not being disabled at reset
    This patch solves the problem of soft reboots on Iq80310, IQ80321,
    and BRH platforms.  The problem was that during the RedBoot PCI
    scan, we were getting data aborts due to non-existent PCI devices.
     It looks like redboot doesn't cleanup after us and turn of vector
    relocation, so we were jumping off into nowhere.

<ebrower@resilience.com>:
  o SK98LIN: Fix oops in procfs handling if no cards probed

<ecd@skynet.be>:
  o SPARC64: Fix bugs in ioctl32 registration

<felipewd@terra.com.br>:
  o Update 8139cp net driver to move legacy Rx/Tx command register
    enable to after C+ command register Rx/Tx enable.
  o Add suspend/resume support to 8139cp net driver

<gphat@cafes.net>:
  o Add KERN_xxx prefixes to printk's in kernel/ subdir

<green@angband.namesys.com>:
  o super.c, item_ops.c, file.c
  o reiserfs_fs.h, namei.c, bitmap.c

<hch@lst.de>:
  o misc pagecache cleanups / tweaks

<irohlfs@irohlfs.de>:
  o Add pci id to orinoco wireless net driver

<jamey.hicks@hp.com>:
  o [ARM PATCH] 1219/1: export sa1100_register_pcmcia and
    sa1100_unregister_pcmcia These routines need to be exported if any
    SA1100 low-level pcmcia drivers are going to be loaded as modules. 
  o [ARM PATCH] 1224/1: add fb support for h3800, remove
    sa1100fb_blank_helper, remove broken bits This adds support for the
    H3800 screen, and removes sa1100fb_blank_helper which has been
    superseded by sa1100fb_backlight_power. 
  o [ARM PATCH] 1221/1: add irq definitions for H3800, which has
    interrupt controller in asic This adds the definitions for the IRQs
    coming from the H3800 asic. 

<jdike@karaya.com>:
  o UML preparation - linkage.h
  o UML preparation - infrastructure

<khc@pm.waw.pl>:
  o Fix epic100 net driver

<maalanen@ra.abo.fi>:
  o Correctly free resources in old-OSS es1371 sound driver
  o Correctly free resources in old-OSS esssolo1 sound driver

<martin@bruli.net>:
  o Fix unaligned accesses in ewrk3 net driver

<mw@microdata-pos.de>:
  o Update old eepro net driver

<otaylor@redhat.com>:
  o Yet another new tulip pci id

<t-kouchi@mvf.biglobe.ne.jp>:
  o [PATCH] PCI Hotplug patch to drivers/pci/names.c

<willy@debian.org>:
  o Fix inappropriate use of set_bit in dl2k gige net driver
  o fix expand_stack for upward-growing stacks

<wilsonc@abocom.com.tw>:
  o Add two pci ids to 8139too net driver

<wolfgang@iksw-muees.de>:
  o I have a new email address

Adrian Bunk <bunk@fs.tum.de>:
  o Add __devexit_p marker to orinoco_{pci,plx} wireless drivers

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Fix endiannes problems in ISA net drivers

Alexander Viro <viro@math.psu.edu>:
  o seq_read() fix
  o fix /proc/partitions braino
  o make check_disk_change() use struct block_device
  o clean up major_name
  o ide subdrivers attach() cleanup
  o partition table flush/read cleanup
  o cpqarray.c per-disk gendisks
  o ps2esdi.c per-disk gendisks
  o fix check_disk_change() deadlocks

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o PKT SCHED: Add HTB scheduler by Martin Devera

Andrew Morton <akpm@zip.com.au>:
  o 3c905B fix
  o copy_strings speedup
  o tunable ext3 commit interval
  o sync get_user_pages with 2.4
  o direct IO fixes
  o fix a race between set_page_dirty and truncate
  o Infrastructure for atomic user accesses

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: 2.0.22 - Cleanups, mainly to ntfs_readdir(), and use C99
    initializers
  o NTFS: oops... remove leaked one liner from ntfs write tree
  o NTFS: 2.0.23 - Major bug fixes (races, deadlocks, non-i386
    architectures)
  o NTFS: 2.0.24 - Cleanups

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o Fix tcpv6 shared ports bug introduced by struct sock splitup
  o Appletalk Cleanups, mark some places that need work for shared skb
    support
  o Add MODULE_LICENSE to p8022.c and psnap.c + CodingStyle cleanups
  o Remove SPX and the last typedefs in IPX, create ipx_hdr
  o Fix bug in LLC state tables, remove old LLC stack, etc
  o Appletalk: more cleanups and code reorganization

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: interrupt fixes along the lines of Ingo's changes to x86

Brad Hards <bhards@bigpond.net.au>:
  o possible keyspan debug bug

Brian Gerst <bgerst@didntduck.org>:
  o Dead code in i386/kernel/process.c

Christoph Hellwig <hch@infradead.org>:
  o Clean up eepro100 update from David M-T

Christopher Hoover <ch@hpl.hp.com>:
  o [ARM PATCH] 1227/1: Fix declaration of cputfreq_get so that
    CONFIG_CPU_FREQ=n builds work
  o [ARM PATCH] 1228/1: Fix improper printf spec in DEBUG message
    (drivers/pcmcia/sa1100_generic.)
  o [ARM PATCH] 1230/1: Squelch warnings about undeclare
    search_exception_table()

Dave Jones <davej@suse.de>:
  o Missing CPU idents

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: One more C99 initilizer
  o JFS: Dynamically allocate metapage structures
  o Rework JFS's inode locking
  o Add resize function to JFS

David Brownell <david-b@pacbell.net>:
  o USB: driverfs paths

David Howells <dhowells@redhat.com>:
  o Re: downgrade_write

David Mosberger <davidm@hpl.hp.com>:
  o Update eepro100 net drvr to enable rx DMA without causing unaligned
    accesses.

David S. Miller <davem@nuts.ninka.net>:
  o SunKBD.c: Update for new handle_sysrq args
  o arch/sparc64/defconfig: Update
  o PKT SCHED: Add HTB scheduler
  o arch/sparc64/kernel/irq.c: Fix preemption bug in __global_cli
  o arch/sparc64/kernel/irq.c: Fix preemption bug in __global_sti
  o TIGON3: Finish up NAPI implementation
  o SPARC64: Fix fallout from sparc32 updates
  o net/appletalk/ddp.c: Fix merge botch by yours truly
  o net/appletalk/ddp.c: More merge botches by yours truly
  o net/sched/sch_htb.c: Kill 64-bit platform build warnings
  o arch/sparc64/defconfig: Update
  o net/ipv4/route.c: Handle large offsets properly in procfs read
    operation
  o drivers/sbus/char/openprom.c: Verify user len in copyin_string
  o SPARC64: Fix cut at converting to new 2.5.x IRQ/BH scheme
  o SPARC64: Kill BR_GLOBALIRQ_LOCK and cpp warning about it. Kill
    include typo
  o include/asm-sparc64/smplock.h: Fix typo
  o include/asm-sparc64/softirq.h: Fix typo in local_bh_enable
  o drivers/ieee1394/Makefile: Add missing LDFLAGS
  o fs/openpromfs/inode.c: Remove bogus interrupt disabling
  o include/asm-sparc64/auxio.h: Use local_irq_{save,restore}
  o fs/openpromfs/inode.c: Kill unused local variable in
    property_release
  o include/asm-sparc64/hardirq.h: Fix synchronize_irq prototype
  o arch/sparc64/prom/misc.c: Remove reference to global IRQ lock
  o SPARC64: Remove some cli/sti usage
  o SPARC64: Kill more cli/sti use
  o SPARC64: Kill more cli/sti and local_irq_count/irqs_running
    references
  o ESP SCSI: Remove bogus cli/sti usage
  o SPARC64: Merge up with latest x86 IRQ changes from Ingo
  o SPARC: Beginning of converting Sparc serial drivers to UART layer
  o include/asm-sparc64/system.h: Define task_running
  o SERIAL: sun.[ch] --> suncore.[ch]
  o drivers/serial/Makefile: Add SUNCORE/SUNZILOG build
  o OpenPROM: Kill len check, it is pointless
  o SPARC: Kill CONFIG_SUN_CONSOLE checks, always on so check is
    pointless
  o OpenPROM: Sigh, put the length overflow check back it is needed
  o SPARC: First pass converting serial drivers to UART layer
  o UART: Update for Sparc drivers
  o SPARC: Move serial config over to use UART layer
  o SPARC: Kill old sunkbd/sunmouse drivers in favor of serio input
    layer
  o SPARC64: Implement semaphore trylock and downgrade
  o SPARC: Move of move to generic input layer for kbd/mouse
  o serial/Makefile: Mark suncore.o as export-objs instead of sunsu.o
  o serial/sun{core,zilog}.c: build fixes
  o SPARC UART: More build fixes
  o SPARC64: Update for new do_munmap argument
  o SPARC64: Kill rs_init calls from sbus/pci init
  o include/asm-sparc64/irq.h: Add irq_cannonicalize
  o SPARC: Move sun_do_break from serial layer into arch code
  o drivers/input/keybdev.c: batten_down_hatches --> sun_do_break
  o SPARC: More keyboard/mouse/serial layer cleanups and build fixes
  o SPARC64: Port to new cpu hotplug startup sequence
  o arch/sparc64/defconfig: Update
  o SPARC64: do_munmap acct arg disappears
  o SPARC64: Fixup build errors from pread64/pwrite64 rename
  o arch/sparc64/kernel/systbls.S: More stray sys_{pread,write}
    references
  o arch/sparc64/solaris/systbl.S: {pread,pwrite} --> {pread,pwrite}64
  o SPARC64: Make __cpu_up and friends work as specified by Rusty
  o IPv4: Fix MSG_DONTWAIT behavior on output fragmentation
  o SPARC: More Sun serial driver updates
  o VLAN dev: Fix hard_start_xmit return values
  o drivers/sbus/char/openprom.c: Remove useless cli/sti usage
  o MYRI_SBUS: Replace cli/sti with spinlocking
  o SPARC64 NS87303: Replace cli/sti with spinlocking
  o drivers/scsi/qlogicpti.c: Replace cli/sti with spinlocking
  o sysctl_net_802.c: Protect sysctl_tr_rif_timeout usage with
    CONFIG_TR

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added new kaweth device
  o USB: lots of usbfs updates
  o USB: usbfs and usbdevfs both work at the same time now
  o USB: remove some compiler warnings
  o USB: remove drivers/usb/core/drivers.c as it's no longer used
  o MAINTAINERS: removed duplicate USB EHCI DRIVER entry
  o PCI: move the EXPORT_SYMBOL(pcibios_*) declarations to the proper
    file

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o possible of memory leak of driverfs_mknod()

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: pte/pfn/page/tlb macros update [1/10]
  o alpha: IPI update [2/10]
  o alpha: CPU logical mapping [3/10]
  o alpha: regdef.h [4/10]
  o alpha: cia-1 fix [5/10]
  o alpha: interrupt/preempt update [6/10]
  o alpha: percpu update [7/10]
  o alpha: osf getrusage, readv, writev [8/10]
  o alpha: misc fixes [9/10]
  o alpha: rwsem update [10/10]

James Morris <jmorris@intercode.com.au>:
  o IPv4 ip_queue netfilter cleanups

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Macro __devexit_p in linux/init.h needs to be conditions on both
    MODULE and CONFIG_HOTPLUG cpp symbols.  Merge 2.4's definition to
    make it so.
  o Fix e100 net driver build when CONFIG_PM is defined
  o synchronize_irq updates for dl2k and ns83820 gige net drivers

Jens Axboe <axboe@suse.de>:
  o missing export of elv_queue_empty()

Joshua Uziel <uzi@uzix.org>:
  o SunHME: Make module license visible when not-PCI

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o Make net_dev_init a subsys_initcall
  o ISDN: Fix act2000 compile error
  o ISDN: Cleanup/fix isdn.o initialization
  o ISDN: Begin to make driver/channel mapping private to isdn_common.c
  o ISDN: Remove now superfluous .drv_index from struct modem_info
  o ISDN: remove unneeded functions
  o ISDN: Gather per-slot data
  o ISDN: Move more slot-specific data into the per-slot struct
  o ISDN: More I4L linklayer cleanup
  o ISDN: Introduce symbolic names for state machine in isdn_net.c
  o ISDN: Reorganize isdn_net_stat_callback
  o ISDN: Start a unified state machine in isdn_net.c
  o ISDN: Get rid of #ifdef ISDN_DEBUG_NET_*
  o ISDN: Unify isdn_net state machine
  o ISDN: combine isdn_net_dev and isdn_net_local
  o ISDN: Use a list.h list for the global list of ISDN net devices
  o ISDN: Clean up creating ISDN net devices
  o ISDN: isdn_net state machine cleanup
  o ISDN: Simplify isdn_net state machine
  o ISDN: More state machine cleanup and normal timer use
  o ISDN: Cleanup #ifdefs in isdn_common.c
  o ISDN: Fix isdnloop when simulating multiple controllers
  o ISDN: Fix the cleanups

Linus Torvalds <torvalds@home.transmeta.com>:
  o Missed partition update from Al Viro
  o Fix up problem with Alan's pnpbios fixes for per-cpu GDT's
  o Undo "stringify()" changes, since they don't work with various
    compilers
  o Make pid allocation use 30 of the 32 bits, instead of 15
  o Merge with dri CVS
  o Workaround for aic7xxx setup inconsistencies

Nicolas Pitre <nico@cam.org>:
  o [ARM PATCH] 1209/1: PXA250/210 register definition update
  o [ARM PATCH] 1210/1: PXA register mapping simplification This allows
    us to use io_p2v() and io_vp2() within assembly code.
  o [ARM PATCH] 1211/1: PXA sleep mode support
  o [ARM PATCH] 1212/1: add configurration options for PXA devices

Patrick Mochel <mochel@osdl.org>:
  o driverfs: Move driverfs calls from drivers/base/*.c to
    drivers/base/fs/*.c
  o driverfs: Add ability to create and remove files for bus drivers
  o driverfs: add glue layer for drivers to export attributes via
    driverfs
  o driverfs: update documentation
  o driverfs: decrement refcount on dentry being removed, not directory
  o Don't call device_remove_file() from cdrom layer, since they're not
    even the ones that create the file.

Paul Mackerras <paulus@samba.org>:
  o PPC32: add in the architecture-dependent security hooks
  o PPC32: only request the PReP-specific resources on PReP systems
  o PPC32: add __down_read_trylock and __down_write_trylock
    implementations
  o PPC32: remove the cpu argument to release_kernel_lock
  o PPC32: fix test_bit (take out bogus __const__)
  o PPC32: update the SMP startup code
  o PPC32: miscellanous small fixes
  o PPC32: convert some more save_flags/cli/restore_flags etc. calls

Paul Menage <pmenage@ensim.com>:
  o Fix misspelling of "sector" in ide.c

Pavel Machek <pavel@ucw.cz>:
  o Remove unnecessary prototypes in eepro100 net driver
  o S3 and swsusp: fixing device_resume order

Pete Zaitcev <zaitcev@redhat.com>:
  o SPARC32: First pass at getting this platform functional under 2.5.x
  o arch/sparc/boot/Makefile: Fixup BTLIBS

Rob Radez <rob@osinvestor.com>:
  o arch/sparc/config.in: Remove commented out LVM bits

Russell King <rmk@arm.linux.org.uk>:
  o if_ether.h: Use packed attribute where necessary
  o ip6_tables.c: Uncomment debugging printf
  o build warning fixes

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix iPAQ LCCR3 values iPAQ entries didn't specify pixel clock
    edge or output enable polarity, as suggested by the comments at the
    top of the file.
  o [ARM] Fix up patch 1219/1 so sa1100 pcmcia builds again Patch
    1219/1 caused sa1100_generic.o to export symbols, but didn't add it
    to the export-objs variable.  Make it so.
  o [ARM] Tidy patch 1221/1: merge H3800 ifdef with graphicsmaster
    ifdef
  o [TRIVIAL] designated initialize patches for fs_adfs From: (via
    Rusty) Art Haas <ahaas@neosoft.com> Here are patches for files in
    fs/adfs. Patches are against 2.5.26.
  o [TRIVIAL] acorn & arm designated initializer rework From Rusty.

Rusty Russell <rusty@rustcorp.com.au>:
  o SPARC: Use ISO C struct initializers
  o NET: Use ISO C struct initializers
  o [TRIVIAL] Typos in linux_arch_arm_kernel_entry-armo.S From: (via
    Rusty) James Mayer <james@cobaltmountain.com>
  o Convert ATM drivers to use C99 struct initializers
  o Convert drivers/net to C99 struct initializers

Scott Feldman <scott.feldman@intel.com>:
  o Update e100 net driver
  o Update e1000 gige net driver

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: use the memory size passed in from the bootloader in
    preference to probing at startup.
  o PPC32: update the defconfigs for a couple of embedded boards

V. Ganesh <ganesh@vxindia.veritas.com>:
  o bugfix for drivers/usb/serial/ipaq.c

vojta@math.berkeley.edu <vojta@Math.Berkeley.EDU>:
  o Mark dmfe net driver with __devexit, fixing hotplug support and


