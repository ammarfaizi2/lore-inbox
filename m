Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSHaWPe>; Sat, 31 Aug 2002 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHaWPe>; Sat, 31 Aug 2002 18:15:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318032AbSHaWP3>; Sat, 31 Aug 2002 18:15:29 -0400
Date: Sat, 31 Aug 2002 15:22:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.33
Message-ID: <Pine.LNX.4.33.0208311514430.6221-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a fair amount of stuff in here again, but I'd personally like to 
have people who actually use that d*ng floppy driver please test it out. I 
finally broke down and tried to fix it, since it's been broken in 2.5.x 
for longer than most people care to remember.

I don't even have floppies to test with, I just verified that I could read
two old backup disks, and one seemed fine, and the other read 90% of the
thing, which was a lot more than I expected since they are both at least
five years old. I've never had good luck with those unreliable 3.5"  
things, I'd rather have as little to do with them as possible.

Anyway, apart from floppies, this has the IDE organizational cleanups by
Al, another merge with Andrew, and some new networking stuff (TCP
segmentation offload onto network cards, and initial cut of SCTP support).

And NTFS, JFS, and of course USB updates. Oh, and some of the keyboard 
input stuff should fix some random breakage in the input switchover.

		Linus

----

Summary of changes from v2.5.32 to v2.5.33
============================================

<ahaas@neosoft.com>:
  o designated initializer patches for include_asm-i386,
    fs_nls and kernel_dma.c

<alan@redhat.com>:
  o Re: Make CONFIG_VIDEO_RPOC_FS depend on CONFIG_PROC_FS

<bart.de.schuymer@pandora.be>:
  o update comments in ip_tables.c

<cel@citi.umich.edu>:
  o prevent oops in xprt_lock_write, against 2.5.32
  o sock_writeable not appropriate for TCP sockets, for 2.5.32

<colpatch@us.ibm.com>:
  o i386 ksyms cleanup
  o PCI Cleanup
  o Fixed NUMA-Q PCI patch

<dan@debian.org>:
  o ptrace exit fix

<davids@youknow.youwant.to>:
  o Trivial Patch to SonyCD535 documentation

<devel@brodo.de>:
  o include/asm-i386/msr.h

<gerg@snapgear.com>:
  o trivial mtdblock.c fix

<hch@lst.de>:
  o Add ETHTOOL_GDRVINFO ioctl support to several pcmcia net drivers,
    and one USB net driver:  3c574_cs, ibmtr_cs, pcnet_cs, ray_cs,
    xirc2ps_cs, xircom_cb, and usb/net/kaweth

<james@cobaltmountain.com>:
  o typo fixes: the the, resourses, wierd, becaus(e), whish,
    capitalization

<jgrimm@touki.austin.ibm.com>:
  o Support MSG_ABORT (the abort primitive) to do a non-graceful
    shutdown of an association
  o Update statetable for prm ABORT and prm SHUTDOWN in the closed
    state (this should turn into an error just like we do in prm SEND)

<jgrimm@touki.qip.austin.ibm.com>:
  o lksctp-2_5_31-0_5_1.patch

<johnpol@2ka.mipt.ru>:
  o drivers_scsi_NCR53C9x_c synchronize_irq() fix
  o drivers_net_sb1250-mac_c synchronize_irq() fix

<manik@cisco.com>:
  o [TRIVIAL PATCH] { 2.5.30 } : removing redundant variable
    frominit_main.c

<pwaechtler@mac.com>:
  o OSS convert cli to spinlocks

<sam@ravnborg.org>:
  o kerneldoc: In kernel-hacking describe designated initialisers

<t-kouchi@mvf.biglobe.ne.jp>:
  o ia64: IRQ cleanup patch for 2.5.30

<thockin@freakshow.cobalt.com>:
  o Add Cobalt Networks support to nvram driver export nvram interfaces
    general cleanup of nvram driver protect nvram state with a lock fix
    nvram O_EXCL hack to actually work

<willy@debian.org>:
  o More support for upward growing stacks
  o reintroduce close() optimisation
  o push the BKL down in setfl

Alexander Viro <viro@math.psu.edu>:
  o move stuff from ide_register_subdriver() to ide-probe.c
  o finish introduction of ->reinit()
  o put IDE drives on lists
  o move media_type checks from ide_scan_devices() to ->reinit
  o Remove duplicate calls to ide_cdrom_init(), idedisk_init(), etc
  o per-drive IDE deregistration
  o Add ->owner to ide_driver_t
  o turn ide_reinit_drive() into ata_attach()
  o Remove unused high-level IDE ->init method
  o put ide_driver_t on lists
  o move add_gendisk()/del_gendisk() into ->reinit() and ->cleanup()

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [NET]: Add TCP segmentation offload core infrastructure
  o [NET]: Add TCP segmentation offload support to e1000
  o [NET]: Add segmentation offload support to TCP

Andrew Morton <akpm@zip.com.au>:
  o minor page_alloc.c things
  o reduced TLB invalidation rate
  o better buffer_head slab packing
  o rename zone_struct and zonelist_struct, kill zone_t and
  o per-zone-LRU
  o per-zone LRU locking
  o add L1_CACHE_SHIFT_MAX
  o ensure that the per-zone locks fall in separate cachelines
  o debug check in put_page_testzero()
  o remove pagevec_lru_del()
  o put_page() consolidation
  o batched freeing of anon pages
  o writeback correctness and efficiency changes
  o fix an ext3 deadlock
  o O_DIRECT for ext3
  o ext3 __FUNCTION__ pasting fix

Andy Grover <agrover@groveronline.com>:
  o Add arch-neutral support for parsing SLIT and SRAT tables (Kochi
    Takayoshi)
  o There are a few problems with ACPI init. One of these is that
    acpi=off will disable the ACPI interpreter init, but not stop the
    OS from using ACPI tables for finding CPUs and IOAPICs. Another
    problem is that if we use the tables, but then the interpreter
    fails to init, we are in deep trouble, because it is too late to
    revert to using MPS, but we cannot get _PRT info without the
    interpreter.
  o local_irq_disable is extraneous (Matthew Wilcox)
  o Ensure that the ACPI interrupt has the proper trigger and polarity
  o ACPI Remove unused file
  o ACPI interpreter update

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: Add configuration option for developmental write support
  o NTFS: Initial implementation of mmap(2) based overwriting
  o NTFS: Fix silly bug in ntfs_write_block(). iblock and dblock have
    different semantics so the check was bogus. Compare the byte sizes
    instead.
  o NTFS: Cleanups, mostly whitespace. Found during resync with 2.4
    backport
  o NTFS: Initial implementation of write(2) based overwriting of
    existing files on ntfs. (Note: Resident files are not supported
    yet, so avoid writing to files smaller than 1kiB.)
  o NTFS: 2.1.0 - First steps towards write support: implement file
    overwrite
  o NTFS: Add ifdef NTFS_RW arround ntfs_truncate and ntfs_setattr

Anton Blanchard <anton@samba.org>:
  o compile fix for st.c

Brad Hards <bhards@bigpond.net.au>:
  o header cleanup - drivers_mtd_devices_blkmtd.c
  o header cleanup - drivers_bluetooth_hci_ldisc.c
  o Re: header cleanup - drivers_macintosh_via-pmu.c
  o header cleanup - drivers_char_drm_mga_state.c

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: rework extent invalidation
  o JFS extended attributes
  o JFS: Add write_super_lockfs() and unlock_fs() for snapshot
  o Proper implementation of jfs_get_blocks

David Brownell <david-b@pacbell.net>:
  o Documentation/usb/{o,u}hci.txt
  o usb/core/hcd-pci, pci cleanup
  o USB dma and scatterlists
  o ehci, registers to driverfs (for debug)
  o ohci on sparc64
  o show pci_pool stats in driverfs]

David Gibson <david@gibson.dropbear.id.au>:
  o Fix for magic sysrq when CONFIG_VT=n

David Mosberger <davidm@napali.hpl.hp.com>:
  o efi.h move
  o ia64: Delete include/asm-ia64/efi.h (it got moved to include/linux)
  o ia64: Make v2.5.32 compile
  o ia64: Remove unnecessary <linux/config.h> include
  o ia64: Fix I/O macros in asm-ia64/io.h.  Based on patch by Andreas
    Schwab
  o ia64: Initial sync with 2.5.32
  o ia64: Add asm-ia64/kmap_types.h (dummy file, but needed to get
    aio.c compiled)
  o ia64: Sync with 2.5.32 to get a working kernel
  o Create dummy file include/asm-ia64/mc146818rtc.h since
    ide-geometry.c continues to insist on it.

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Ultra-III+ updates and better error trap logging
  o arch/sparc64/kernel/traps.c: Add spitfire_ prefix to
    clean_and_reenable_l1_caches, BUG on non-spitfire cpus
  o arch/sparc64/kernel/irq.c: Kill reference to dead linux/kbd_ll.h
  o [INPUT]: Add EBUS/ISA speaker input driver for Sparc
  o include/asm-sparc64/pgalloc.h: Include linux/mm.h
  o drivers/char/keyboard.c: Add sparc{32,64} emulate_raw support
  o drivers/serial/Config.in: It is CONFIG_SPARC32 not CONFIG_SPARC
  o drivers/input/misc/Config.in: It is CONFIG_SPARC32 not CONFIG_SPARC
  o drivers/char/keyboard.c: Merge in Vojtech fixes plus add Sparc raw
    support
  o arch/sparc64/kernel/setup.c: Kill duplicate kbd_sysrq_xlate
  o [SPARC]: Define CONFIG_HW_CONSOLE
  o [SPARC64]: Add dummy kmap_types.h for sake of fs/aio.c
  o [SPARC]: Finish conversion of sbusfb drivers to new fbcon API
  o include/linux/sctp.h: Use __u{8,16,32} instead of uint{8,16,32}_t
  o [SCTP]: Whitespace/codingstyle fixups, plus a bug fix or two
  o net/sctp/sctp_sm_statefuns.c: Remove bogus use of unused attribute
    with a label
  o net/sctp/sctp_protocol.c: Fix typo from cleanups
  o net/sctp/sctp_sm_sideeffect.c: Kill unusued variable in
    sctp_side_effects
  o net/sctp/sctp_tsnmap.c: Fix typo from cleanups
  o net/sctp/sctp_sm_make_chunk.c: Kill unused variable in
    sctp_make_data_empty
  o net/sctp/sctp_socket.c: Fix printf string for size_t
  o net/sctp/sctp_socket.c: Fix sctp_get_port types, static private
    funcs
  o net/sctp/sctp_socket.c: Mark sctp_skb_recv_datagram static
  o I8042: Add SPARC support
  o drivers/input/serio/i8042-sparcio.h: Add missing endef
  o drivers/input/serio/i8042-sparcio.h: Fix ioremap args
  o drivers/input/serio/i8042.c: Allow IRQs to be determined at runtime
  o drivers/scsi/sg.c: Include linux/vmalloc.h
  o fs/binfmt_elf.c: Kill warnings introduced by stack-grows-up changes
  o fs/romfs/inode.c: Kill warning on 64-bit systems
  o drivers/input/serio/i8042-sparcio.h: Define
    I8042_{COMMAND,DATA}_REG
  o arch/sparc64/defconfig: Update
  o [SCTP]: Rename sctp_foo.[ch] to foo.[ch] and kill CVS tags on
    authors request
  o [OpenPROM]: Fix signedness/user-access checking bugs in openprom
    char driver and openpromfs
  o fs/openpromfs/inode.c: Prevent overflow of sprintf buffer
  o fs/openpromfs/inode.c: Prevent unsigned roll-over in size of
    kmalloc
  o fs/openpromfs/inode.c: Better fixes for overflow
  o This converts all of the input USB drivers to manage DMA buffers
    via usb_buffer_alloc in 2.5.x  This helps platforms where doing a
    pci_{map,unmap}_single() on every input event is very inefficient.

Eric Sandeen <sandeen@sgi.com>:
  o warning cleanup for drivers_scsi_dpt_i2o.c
  o warning cleanup for drivers_scsi_fdomain.c
  o warning cleanup for drivers_char_mxser.c

Frank Davis <fdavis@si.rr.com>:
  o drivers/media/video/bt856.c
  o drivers/media/video/saa7110.c
  o drivers/media/video/bt819.c

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added new pl2303 device, thanks to Tasos Chronis
    <tasosc@otenet.gr>
  o USB: ipaq driver: fixed __FUNCTION__ usages
  o USB: usbserial core: fixed __FUNCTION__ usages
  o USB: visor driver: fixed __FUNCTION__ usages
  o USB: whiteheat driver: fixed __FUNCTION__ use
  o USB: ftdi_sio driver: fixed __FUNCTION__ usages
  o USB: keyspan_pda driver: fixed __FUNCTION__ usages
  o USB: belkin serial driver: fixed __FUNCTION__ usages
  o USB: cyberjack driver: fixed __FUNCTION__ usages
  o USB: pl2303 driver: fixed __FUNCTION__ usages
  o USB: omninet driver: fixed __FUNCTION__ usages
  o USB: mct_u232 driver: fixed __FUNCTION__ usages
  o USB: kl5usb105 driver: fixed __FUNCTION__ usages
  o USB: digi_acceleport driver: fixed __FUNCTION__ usages
  o USB: empeg driver: fixed __FUNCTION__ usages
  o USB: io_edgeport driver: fixed __FUNCTION__ usages
  o USB: ir-usb driver: gcc3 warning fix
  o USB: keyspan driver: minor formatting fixes
  o USB: added break support for 2 port keyspan devices
  o USB: fix debugging code to allow USB_NO_DMA_MAP
  o USB: io_ti driver: fixed __FUNCTION__ usages
  o USB: safe_serial driver: fixed __FUNCTION__ usages
  o USB: serial drivers: fixed __FUNCTION__ usages that I missed before
  o USB: bluetty driver: fixed __FUNCTION__ usages
  o USB: brlvger driver: fixed __FUNCTION__ usage
  o PCI:  add pci_bus_* functions to replace the pci_read_* and
    pci_write_* functions
  o PCI Hotplug: removed the pci_*_nodev functions
  o PCI: x86-64 pci_ops changes
  o PCI: alpha pci_ops changes
  o PCI: compile time fix for the pci pool patch
  o ACPI: fix needed due to previous pci_ops change

Hanna Linder <hannal@us.ibm.com>:
  o PCI: ia64 pci_ops changes
  o PCI: mips pci_ops changes
  o PCI: sh pci_ops changes

Ingo Molnar <mingo@elte.hu>:
  o ldt-fix-2.5.32-A3
  o MAINTAINERS patch
  o clone-cleanup 2.5.32-BK
  o scheduler fixes, 2.5.32-BK
  o TLS boot-initialization bugfix on SMP, 2.5.32-BK

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Update 8139too net driver to make new rx-reset method the default
  o Fix mistake in 8139too net driver Config.in entry
  o Proper support for RTL8139 rev K in 8139too net driver
  o Release 8139too net driver version 0.9.26
  o 8139cp net driver updates
  o Include linux/in.h and linux/ip.h in 8139cp net driver
  o Add 64-bit DMA support to 8139cp net driver
  o Fix 8139cp net driver 64-bit PCI DMA support (thanks for DaveM for
    advice and help)
  o e1000 net driver small cleanup

Linus Torvalds <torvalds@home.transmeta.com>:
  o Merge with dri CVS tree
  o The SCSI layer should _not_ try to decide about non-existent
    partitions. The higher layers do a better job of it.
  o Call con_init_devfs() to initialize VT subsystem for devfs
  o Make block device initialization initialize the request queue
    pointer before the device is opened.
  o Clean up insane floppy driver CURRENT handling, make the driver
    remove the ftont of the queue from the request list and cache it in
    'current_req'.
  o Fix defconfig (incomplete due to the syntax error in char
    Config.in)
  o Don't use __func__ - not all versions of gcc support it
  o Don't paste __FUNCTION__, that's deprecated
  o Make e100 driver compile (e100_force_speed_duplex() cannot be
    static, as it is needed by e100_test.c too)
  o Add some fascist code to trap __FUNCTION__ pasting, fix up some
    more pasters..
  o Avoid unused variable warning when kmap() ends up being a no-op

Luca Barbieri <ldb@ldb.ods.org>:
  o Fix panic if pnpbios is enabled and speed up its check in

matt_domsch@dell.com <Matt_Domsch@Dell.com>:
  o ia64: update files for efi.h move from include/asm-ia64 to
    include/linux

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd - More small fixes for TCP nfsd
  o md - Fix a typo in a recent patchset for raid5

Paul Mackerras <paulus@samba.org>:
  o Fix mesh config

Pete Zaitcev <zaitcev@redhat.com>:
  o Patch to irq compat stuff in 2.5.32

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Add a missing EXPORT_SYMBOL(input_devclass); into input.c

Randy Dunlap <rddunlap@osdl.org>:
  o I've been using gcml2 from Greg Banks to look at CONFIG_ variable
    dependencies in config.in files.

Richard Gooch <rgooch@atnf.csiro.au>:
  o devfs update 
  o Exported devfs_find_and_unregister() and devfs_only() to modules
    Updated README from master HTML file Fixed module unload race in
    devfs_open()

Robert Love <rml@tech9.net>:
  o have lockd and rpciod drop locks on exit
  o make raid5 checksums preempt-safe, take two
  o misc. kernel preemption bits

Rusty Russell <rusty@rustcorp.com.au>:
  o list_for_each_entry
  o Designated initializers for sound_ppc

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver update
  o e1000 net driver update

Simon Evans <spse@secret.org.uk>:
  o more typedef removal from usbvideo

Tom Rini <trini@kernel.crashing.org>:
  o Make CONFIG_VIDEO_RPOC_FS depend on CONFIG_PROC_FS

Vojtech Pavlik <vojtech@suse.cz>:
  o Remove uninformative coments in input.c
  o Don't allow CONFIG_INPUT_MOUSEDEV_PSAUX without
    CONFIG_INPUT_MOUSEDEV
  o Start keyboard_bh only after registering the keyboard handler
  o Support the 0xff ps/2 mouse reset command in mousedev.c, XFree
    needs it for mouse autodetection.
  o Remove user configurable I8042_BASE/I8042_IRQs
  o In mousedev.c, don't send a zero mouse movement after a command if
    requested, also fix a possible race with two processes using the
    same file descriptor.
  o Ignore error 0xff - 'general error' in AUX wire test in i8042.c,
    some mainboards (Andrew Morton's Dell) report that even everything
    is okay with AUX. Also remove a check for very old AMI i8042's,
    which could generate false positives on modern buggy mainboards.

