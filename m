Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJAHZO>; Tue, 1 Oct 2002 03:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSJAHZO>; Tue, 1 Oct 2002 03:25:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4623 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261397AbSJAHZI> convert rfc822-to-8bit; Tue, 1 Oct 2002 03:25:08 -0400
Date: Tue, 1 Oct 2002 00:32:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g917UPA03149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Merges with all the regular suspects - Al's partitioning, Andrew on VM, 
USB, networking, sparc, net drivers. And Ingo has been working on fixing 
up the inevitable details in the thread signal stuff, as well as updating 
the smp-scalable timer code.

And ISDN, kbuild, ARM, uml...

And a small reminder that we're now officially in the last month of
features, and since I'm going to be away basically the last week of
October, so I actually personally consider Oct 20th to be the drop-date,
unless you've got a really good and scary costume.. So don't try to leave 
it to the last day.

[ And if that didn't worry you, the following should: I'm perfectly happy 
  with the kernel, and as such whatever features _you_ think are missing 
  might just not weigh too much with me if you then also make the mistake
  of trying to leave them for the last crunch. I might just take the last
  day off too ;]

And if it wasn't clear to the non-2.5-development people out there, yes
you _should_ also test this code out even before the freeze. The IDE layer
shouldn't be all that scary any more, and while there are still silly
things like trivially non-compiling setups etc, it's generally a good idea
to try things out as widely as possible before it's getting too late to
complain about things..

		Linus

----

Summary of changes from v2.5.39 to v2.5.40
============================================

Art Haas <ahaas@neosoft.com>:
  o C99 designated initializers for bfs, minix, efs, openpromfs,
    ramfs, exportfs, devpts, romfs, proc, isofs, ufs, cramfs

Alex Williamson <alex_williamson@attbi.com>:
  o fs/partitions/sun.c: raid autodetect for sun disk labels

<andmike@us.ibm.com>:
  o Error handler general clean up

Bart Schuymer <bart.de.schuymer@pandora.be>:
  o net/bridge/br_input.c: Missing read_unlock

<bzeeb-lists@lists.zabbadoz.net>:
  o fix endless loop walking the MADT

Dave Jones <davej@codemonkey.org.uk>:
  o trivial bits
  o Various trivial module related fixes
  o include fix

Rolf Fokkens <fokkensr@fokkensr.vertis.nl>:
  o sg.c and USER_HZ, kernel 2.5.37

Jeff Dike <jdike@uml.karaya.com>:
  o UML updates to allow it to build and run as 2.5.38
  o Cleaned up arch/um/Makefile and updated the ubd driver
  o Trivial fix to the ubd driver
  o One last fix to the ubd driver, allowing UML to boot
  o Bumped EXTRAVERSION for the 2.4 fixes and highmem support
  o Added highmem support to uml
  o Fixed highmem support for 2.5
  o Missed a change to fixmap.h in the highmem update
  o Updated to build with the 2.5.39 kbuild
  o One last fix to make the non-highmem build work
  o Added CONFIG_HIGHMEM to defconfig
  o Moved the linker script from vmlinux.lds.S, which will be empty, to
    uml.ld.S.
  o main.o needed to be added to the vmlinux dependencies so it would
    build

<jeffs@accelent.com>:
  o [ARM PATCH] 1238/1: Accelent PXA IDP config cleanups This patch
    brings support for the PXA-IDP up to 2.5.30, plus adds support in
    head.S for low level serial debugging support.

James Bottomley <jejb@mulgrave.(none)>:
  o [SCSI 53c700] flag as able to do I/O from highmem

Jes Sorensen <jes@trained-monkey.org>:
  o acenic net drvr bug fix: remove '=' typo in intr mask argument to
    writel()

Dominik Brodowski <linux@brodo.de>:
  o (1/5) CPUfreq core
  o (2/5) CPUfreq i386 core
  o (3/5) CPUfreq i386 drivers
  o (4/5) CPUfreq Documentation
  o (5/5) CPUfreq /proc/sys/cpu/ add-on patch
  o CPUfreq i386 drivers update
  o cpufreq bugfixes
  o cpufreq crashes on P4

Peter Wächtler <pwaechtler@mac.com>:
  o oss sound cli cleanup

Randy Dunlap <randy.dunlap@verizon.net>:
  o hc_sl811 build and memory leak

<rscott@attbi.com>:
  o [ARM PATCH] 1243/1: Add support for Ceiva Photoframe, part2:
    machine specifics (fixed) Adds machine specific support for Ceiva
    Photoframe. Affects:

Sam Ravnborg <sam@mars.ravnborg.org>:
  o Remove unused clean: target in various makefiles Simple cleanup,
    kbuild does not use distributed clean target, so bettet get rid of
    them.

<schoenfr@gaaertner.de>:
  o net/ipv4/proc.c: Dont print dummy member of icmp_mib

<yoshfuji@linux-ipv6.org>:
  o net/ipv6/addrconf.c: Refine IPv6 Address Validation Timer
  o net/ipv6/ndisc.c: Add missing credits
  o net/ipv6/ip6_fib.c: Default route support on router

Alexander Viro <viro@math.psu.edu>:
  o gendisks list switched to list_head
  o get_gendisk() prototype change
  o floppy fixes
  o ubd fixes
  o register_disk() unexported
  o >major_name inlined
  o alloc_disk/put_disk

Andrew Morton <akpm@digeo.com>:
  o Fix uninitialized swapper_space lists
  o additional might_sleep checks
  o kmem_cache_destroy fix
  o Documentation/vm/hugetlbpage.txt
  o get_user_pages PageReserved fix
  o move_one_page kmap atomicity fix
  o fix uninitialised vma list_head
  o add /proc/buddyinfo
  o remove free_area_t typedef
  o per-node kswapd instances
  o in-kernel topology API
  o topology API updates
  o scsi_initialise_merge_fn() will only set highio if ->type ==
    TYPE_DISK

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o [X25] simplify facility negotiation
  o [X25] fix thinko in x25_facilities
  o LLC: remove unused list_head from llc_opt & use rw_lock_init for
    rwlocks
  o X25: Simplify ioctl code, CodingStyle cleanups
  o X25: use refcounts and protect x25_route list
  o LLC: rename llc_sock.c to af_llc.c
  o X25: use refcnts and protect x25_neigh structs and list
  o X25: protect x25 sockets and list with refcnt and rwlock
  o X25: x25_wait_for_{data,connection_establishemnt} and the death
    of the last cli/sti pair in X.25
  o LAPB: use refcounts and rwlock to protect lapb_cb and list
  o lapbether: get rid of cli/sti, use refcnts for devs, etc
  o LLC: CONFIG_LLC_UI is really a bool, not a tristate
  o LLC: make it clear that Appletalk and IPX needs LLC
  o LLC: make sure llc.o is linked before the datalink protos when
    !module
  o LLC: kill mac_send_pdu, use plain dev_queue_xmit

Christopher Hoover <ch@hpl.hp.com>:
  o [ARM PATCH] 1255/1: [PATCH] SA-1111 PCI support for USB Fixes
    several oopsen in the SA-1111 "fake" PCI support

David Brownell <david-b@pacbell.net>:
  o Sleeping function called from illegal context
  o usbcore misc cleanup
  o ehci-hcd, urb queuing
  o ohci-hcd, paranoia
  o usb_sg_{init,wait,cancel}()

David Gibson <david@gibson.dropbear.id.au>:
  o Fix: Orinoco driver update
  o Squash warning in fs/devfs/base.c

David Mosberger <davidm@napali.hpl.hp.com>:
  o avoid reference to struct page before it's declared

David S. Miller <davem@nuts.ninka.net>:
  o [ALSA]: Add some missing includes
  o [ALSA]: Fix ioctl32 build on sparc64
  o [ALSA]: Add SBUS dma support
  o [ALSA]: Add AMD7930 and CS4231 Sparc drivers
  o [SPARC]: Blow away old sbus audio layer
  o sound/i2c/i2c.c: Include linux/errno.h
  o sound/core/seq/seq_midi_emul.c: Include linux/string.h
  o sound/i2c/i2c.c: Include linux/string.h
  o sound/synth/util_mem.c: Include asm/semaphore.h
  o sound/synth/util_mem.c: Revert previous change
  o include/sound/core.h: Always include linux/sched.h and
    asm/semaphore.h
  o sound/pci/emu10k1/emufx.c: Pass bitops pointer correctly
  o [SPARC]: Comment out DBRI option/rules until driver is converted
  o arch/sparc64/defconfig: Update
  o sound/sparc/cs4231.c: Fix probing bugs
  o [SPARC]: OOPS, ffs return value is off by one :-)
  o sound/sparc/cs4231.c: Fix register offsets
  o sound/core/oss/mixer_oss.c: Use SIOC_{IN,OUT}
  o [SPARC64]: Rework all EBUS DMA support
  o arch/sparc64/kernel/pci_schizo.c: Enable error interrupts in
    correct PBM
  o [SPARC]: sigmask_lock --> sig->siglock
  o [SPARC]: Rename private init_timers to sparc{,64}_init_timers
  o drivers/input/keyboard/sunkbd.c: queue_task --> schedule_task
  o drivers/net/ethertap.c: Use C99 initializers
  o sound/sparc/cs4231.c: Include sound/pcm_params.h
  o sound/pci/cs46xx/dsp_spos.c: Include linux/vmalloc.h

Dr. David Alan Gilbert <gilbertd@treblig.org>:
  o [ARM PATCH] 1257/1: Helpful comment in stat.h Hi, For reasons of
    great complexity I found out the hard way that the kernel must (and
    does) zero the pad sections in the stat structures.
  o [ARM PATCH] 1260/1: Fix comment in nwfpe Hi, I believe the comment
    in the nwfpe fpopcodes is slightly wrong - although a 2nd pair of
    eyes on this would be a good idea.

Edward Peng <edward_peng@dlink.com.tw>:
  o update sundance driver to support building on older kernel

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: queue_task() fixups
  o USB: added Palm Zire id to the visor driver, thanks to Martin
    Brachtl
  o driver core: added location of device in driverfs tree to
    /sbin/hotplug call
  o USB: add a lot more driverfs files for all usb devices
  o USB: Fix the name of usb hubs in driverfs
  o USB: allow /sbin/hotplug to be called for the main USB device
  o USB: fix typo from previous schedule_task() patch

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o use fff/ffff/fffffff instead of ff8/fff8/ffffff8 for EOF of FAT
  o remove fat_search_long() in vfat_add_entry()

Ingo Molnar <mingo@elte.hu>:
  o sigfix-2.5.39-A1
  o futex-fix-2.5.39-A1
  o signal delivery to thread groups bugfix
  o thread-group SIGSTOP handling
  o atomic-thread-signals
  o smptimers, old BH removal, tq-cleanup
  o tq-cleanup module compile
  o tq_struct removal fixups
  o sigfix-2.5.39-D0, BK-curr

Jaroslav Kysela <perex@suse.cz>:
  o ALSA updates [1-10: 2002/06/24 - 2002/08/05 ]

Javier Achirica <achirica@ttd.net>:
  o airo wireless net drvr: add Cisco MIC support Conditionally enabled
    when out-of-tree, but open source, crypto lib is present.

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o sundance net drvr: fix reset_tx logic (contributed by Edward Peng @
    D-Link, cleaned up by me)
  o sundance net drvr: fix DFE-580TX packet drop issue, further
    reset_tx fixes (contributed by Edward Peng @ D-Link)
  o sundance net drvr: bump version to LK1.05
  o [net drivers] fix MII lib force-media ethtool path (contributed by
    Edward Peng @ D-Link)
  o sis900 net driver update
  o [net drivers] MII lib update
  o [net drivers] Rename MII lib API member,
    s/duplex_lock/force_media/, and update all drivers that reference
    this struct member.
  o Add helper function generic_mii_ioctl to MII lib, use it in 8139cp
    net drvr
  o Use new MII lib helper generic_mii_ioctl in several net drivers
  o [net drivers] Remove 'dev' argument from generic_mii_ioctl helper
  o [net drivers] add optional duplex-changed arg to generic_mii_ioctl
    helper
  o [net drivers] update hamachi.c and starfire.c to use MII lib
  o Use schedule_task() in tlan net driver, fixing build
  o Include linux/tqueue.h in orinoco[_cs] net drvrs, fixing build
    (contributed by James Blackwell)
  o Use do_gettimeofday() in ATM drivers (contributed by Francois
    Romieu)
  o Replace local var in 8139cp net driver that was accidentally
    removed, due to synchronize_irq() becoming a no-op when
    !CONFIG_SMP.

Jens Axboe <axboe@suse.de>:
  o request_irq() use GFP_ATOMIC
  o add function to set q->merge_bvec_fn
  o don't BUG() on too big a bio
  o make loop set right queue restrictions
  o raid5 BIO_UPTODATE set
  o loop clear q->queuedata on exit
  o set ide pci dma mask

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: cleanup ISDN net / ioctl code
  o ISDN: Move CISCO HDLCK protocol into separate file
  o ISDN: More cleanup to isdn_net.c (X.25 / PPP)
  o ISDN: Move net_device setup to a type-specific method
  o ISDN: 'ethernet over ISDN' cleanups
  o ISDN: net_device->header for CISCO HDLC
  o ISDN: net_device->header for syncPPP and UI HDLC
  o ISDN: net_device->header for IPTYP
  o ISDN: separate out 'ethernet over ISDN' receive function
  o ISDN: separate out IPTYP receive function
  o ISDN: separate out RAWIP receive function
  o ISDN: separate out CISCO HDLC receive function
  o ISDN: separate out IPTYP receive function
  o ISDN: finish separating out receive functions
  o ISDN: Use a function pointer for type-specific receive
  o ISDN: Use a function pointer for type-specific connected() callback
  o ISDN: Use a function pointer for type-specific disconnected()
    callback
  o ISDN: inline function for testing if interface is bound
  o ISDN: Put slot index of reserved channel into ->exclusive
  o ISDN: exclusive handling in isdn_net_force_dial_lp()
  o ISDN: Share code for initiating dial out
  o ISDN: Use net/ethernet/eth.c eth_rebuild_header()
  o ISDN: Remove ISDN_NET_CONNECTED flags
  o ISDN: unclutter isdn_net_find_icall()
  o ISDN: Introduce generic bind/unbind callbacks
  o kbuild: Make scripts/Configure follow the definition of 'int'
  o kbuild: Fix typo for 'tags' target
  o kbuild: Make KBUILD_VERBOSE=0 work better under emacs
  o ISDN: Use a struct to describe types of ISDN net interfaces
  o ISDN: Introduce generic init/cleanup callbacks
  o ISDN: Use ether_setup() for ethernet over ISDN only
  o ISDN: Add close()/open() callbacks to ISDN net interface
    implementation
  o ISDN: Move "name" member from isdn_net_local to isdn_net_dev
  o ISDN: Move dial/channel related members to isdn_net_dev
  o ISDN: Move ppp-specifics to isdn_net_dev
  o ISDN: Move dial/hangup related stuff to isdn_net_dev

kai.makisara@kolumbus.fi <Kai.Makisara@kolumbus.fi>:
  o SCSI tape driver locking fixes

Linus Torvalds <torvalds@home.transmeta.com>:
  o Remove more tmp-file on clean (introduced with kallsyms)
  o Fix "make mrproper" that broke when the files pattern matched a
    directory pattern. Clean directories _first_, then files.
  o Fix broken whitespacing in PPC Makefile
  o Make sure the "devices" list is initialized in isapnp_device_driver
  o All .tmp* files are auto-generated

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB-storage: problem clearing halts

Matthew Wilcox <willy@debian.org>:
  o remove GFP_NFS
  o Remove QDIO_BH

Nicolas Pitre <nico@cam.org>:
  o [ARM PATCH] 1302/1: ARMv5 optimized findbit Question: is there any
    reason to do all this with byte access rather than  word access
    besides alignment issues?  Word access would be much faster.
  o [ARM PATCH] 1293/1: fix to the ARM optimized strchr() Two bugs
    here:

Pete Zaitcev <zaitcev@redhat.com>:
  o [sparc]: defconfig update
  o [sparc] Stalingrad for kbuild army
  o [sparc] Suppress warnings in srmmu printks

Russell King <rmk@arm.linux.org.uk>:
  o free_irq docs
  o [ARM] Add Thumb syscall stubs and drop gcc asm workarounds
  o [ARM] Move PHYS_TO_NID() to asm/memory.h When
    CONFIG_DISCONTIGMEM=n, we define PHYS_TO_NID(x) to zero in each
    architecture specific file.  This cset moves it into the generic
    ARM code.  
  o [ARM] Put back the CPU MM context switch avoidence test
  o [ARM] Thumb fixes This cset fixes a set of problems discovered
    while developing KLIBC with Thumb support.  We now allow pure Thumb
    executables, and prevent such executables from being run on
    non-Thumb code aware CPUs.
  o [ARM] Always decend into compressed and bootp subdirectories
  o [ARM] Make "bootp" Image generation know that the zImage is now PIC
  o [ARM] Fix XScale "feature" XScale does not guarantee that CPU
    control register writes complete their side effects immediately. 
    In fact, Intel give sample code to demonstrate a way to ensure that
    the effect of the write has occurred.
  o Since irq_exit() now deals with softirqs, irq_enter and irq_exit
    must be located at the top level of the interrupt handler.
  o [ARM] Remove old AMBA KMI driver information
  o [ARM] Fix up initcall ordering ARM machine support gets initialised
    too late in the initialisation
  o [ARM] Provide hook for FP emulators to know when a new thread is
    created This allows FP emulators to take their FP initialisation
    out of the hot path.
  o [ARM] Move machine config questions into machine class subdirs This
    cset moves a fair amount of per-machine questions into their
    relevant machine class subdirectory, making arch/arm/config.in
    easier on the eyes.
  o [ARM] Update nwfpe to use new fp_init hook
  o [ARM] Don't continue to process pending interrupts after
    disable_irq() This solves a problem whereby the generic interrupt
    code repeatedly called an interrupt handler, even though the
    interrupt handler had called disable_irq().
  o [ARM] Parse initrd information early We need the initrd location
    before the normal command line parsing
  o [ARM] Add DC21285 decompressor debug support
  o [ARM] 2.5.34 update Update for changes in mainline 2.5.3[01234].
  o [ARM] Unify integer register usage passed into FP module
  o [ARM] NWFPE updates for new entry conditions
  o [ARM] Remove keyboard.h includes and some generic ARM keyboard bits
  o [ARM] Bring asm/setup.h and asm/unistd.h into line with main ARM
    tree This removes some minor differences between Linus' tree and
    the main ARM tree; comment clarification and some weird formatting.
  o [ARM] Correct the usage of __FUNCTION__ to make gcc happy
  o [ARM] Update PCI host bridge drivers for GregKH PCI cleanups
  o [ARM] Don't return a value from ptrace_set_bpt() The return value
    from ptrace_set_bit() is never used.  This cset makes it a void
    function.
  o [ARM] Fix up export-objs for clps711x, integrator and sa1100 (From
    Thunder)
  o [ARM] Cleanup Ceiva merge
  o [ARM] Add kmap_types.h and percpu.h
  o [ARM] Fix clps711x and ftvpci LEDs initialisation
  o [ARM] Fix assabet backlight and power supply settings
  o [ARM] Update SA1111 core and related drivers for LDM
  o [ARM] Add LDM suspend/resume support to SA1100 suspend code
  o [ARM] Remove "struct device" from sa1111_init() callers This didn't
    follow the LDM model correctly.  The SA1111 is always a device on
    the root bus.
  o [ARM] sa1100fb updates Update sa1100fb for recent fbcon changes,
    and move stork LCD power handling into machine specific file.
  o [ARM] Update cpufreq related sa1100 related drivers and CPU code
    This cset updates sa1100 code for the now merged cpufreq next-gen.
  o [ARM] Fix sa1111 IRQ handling We must clear down all currently
    pending IRQs before servicing any IRQ on the chip.  This prevents
    immediate recursion into the interrupt handling paths when we
    service the first IRQ.
  o [ARM] Prevent namespace clash with IRq numbering Add "IRQ_" prefix
    to these sa1111 irq numbers.
  o [ARM] General cleanups/missed bits in previous csets This corrects
    spelling mistakes, adds missed configuration for cpufreq, corrects
    free_irq comment, etc.
  o [ARM] iPAQ updates from Jamey Hicks

Urban Widmark <urban@teststation.com>:
  o wait_event_interruptible_timeout
  o SMB Unix Extensions
  o might_sleep fixes

Wim Van Sebroeck <wim@iguana.be>:
  o i8xx documentation
  o i8xx: new PCI ids
  o i810-tco update


