Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSLJDLI>; Mon, 9 Dec 2002 22:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266548AbSLJDLI>; Mon, 9 Dec 2002 22:11:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266540AbSLJDKp>; Mon, 9 Dec 2002 22:10:45 -0500
Date: Mon, 9 Dec 2002 19:17:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.51
Message-ID: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, big patch, but this is mostly all over the place with a lot of fairly 
random small fixes (a lot of compile fixes for the build breakage from the 
header file cleanups, for example).

The AGP reorg, fbdev merge, and the s390 updates also help make the patch 
quite large. 

Architecture merges, more merges with Andrew, and Al started cleaning up 
some of his favourite code - devfs. See details in the changelog.

		Linus

PS. I'm going to be traveling for three days, so..



Summary of changes from v2.5.50 to v2.5.51
============================================

<baldrick@wanadoo.fr>:
  o usbfs: more list cleanups

<bdschuym@pandora.be>:
  o [BRIDGE]: new_nbp runs under rwlock so needs to use GFP_ATOMIC
  o [BRIDGE]: Fix __fake_rtable metrics and some comments

<dana.lacoste@peregrine.com>:
  o RATOC USB-60 patch

<fnm@fusion.ukrsat.com>:
  o [BRIDGE]: ebtables vlan match fixes and cleanups

<gronkin@nerdvana.com>:
  o [netdrvr tulip] new pci id

<henrique2.gobbi@cyclades.com>:
  o cyclades.c compile fix

<jochen@jochen.org>:
  o vfat umas doc update

<jsimmons@kozmo.(none)>:
  o Grabbed the PPC drivers and in the process of porting to the latest
    api. Can now use driver specific read and write functions
  o fbgen is gone and now we have cfbcursor.c
  o Major fixes for the software accel functions. We have the penguin
    back
  o Start of hardware rotation. PDA devices have often rotated screens
    with respect to the keyboard.'
  o Cleaned up the cursor api. Now it uses fb_imaeg which makes sense
    since a cursor is a image.More code cleanup for fbcon.c. Removal of
    excess elements passed into functions
  o Moving over to console_font_op to get ride of struct display
  o Massive cleanup of struct display. It will be going away
  o Start of intergartion of fbcon-accel into the core fbcon code
  o Creation of default mode. We create and set the hardware once then
    clone the data each VC. This is much sanier
  o Nuked font related info in struct display. Almost gone now
  o The software cursor works for any pixel arrangement
  o Moved over fbcon to use the accel api only. This will shrink the
    code considerably
  o C99 fixes. Framebuffer console fix
  o Accel wrapper is now intergarted into fbcon.c. VESA fb fixes
  o Made it modular
  o Made fbcon modular
  o Ported riva and vga16fb over to new api. Thanks Antonia Daplas!!!
    More optimizations in fbcon.c
  o VGA text mode handling cleanup. Rusty's janitoral cleanups
  o Fits the other accel protocols. Fix for blanking

<oliver@oenone.homelinux.org>:
  o module unload race with usb serial drivers
  o cleanup for new module primitives
  o USB core: cleanup BKL
  o USB usbfs: fix race between disconnect and usbdev_open

<osst@riede.org>:
  o osst update

<phillim2@comcast.net>:
  o tr.c lockup when accessing /proc/net/tr_rif

<srompf@isg.de>:
  o [netdrvr starfire] add netif_carrier_{on,off} calls
  o [NET]: Add device linkwatch functionality

<stelian@popies.net>:
  o sonypi driver update
  o CREDITS update

<steve@kbuxd.necst.nec.co.jp>:
  o fs/namei.c fix

<wahrenbruch@kobil.de>:
  o USB: kobil_sct driver for 2.5.50

<whitney@math.berkeley.edu>:
  o uhci-hcd.c shouldn't halt control endpoints

<wstinson@wanadoo.fr>:
  o [netdrvr de620] remove unneeded, and ifdef'd out, check_region call

Adam Belay <ambx1@neo.rr.com>:
  o Linux PnP Support V0.93 - 2.5.50
  o PnP bugfix
  o PnP gameport driver update

Adam J. Richter <adam@yggdrasil.com>:
  o [netdrvr] de600 has module_init, so remove its listing from Space.c
  o Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data
  o [CRYPTO]: Simplify crypto memory allocation

Adam Kropelin <akropel1@rochester.rr.com>:
  o [netdrvr ewrk3] fix and enable ethtool phys-id ioctl
  o [netdrvr ewrk3] allow user to change MAC address via SIOCSIFHWADDR

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Final bit of soundmodem to die
  o bitops leaves ADDR defined
  o CREDITS
  o add new ac97 codec fields as per 2.4
  o update ac97 to 2.4 current
  o update i810 audio to match 2.4
  o allow address change on fec ethernet
  o clean up sis PCI quirk
  o aacraid minor fixups
  o update fdomain_stub to match newer fdomain driver
  o update qlogic stub to match qlogic updates
  o Add config entry for mmuless 68328 fb
  o mmuless no longer needs this ifdef
  o add NEC PC9800  bus idents to mpspec
  o maintainer wants ifdefs left
  o report unzip errors on initrd
  o split the mm files compiled according to SWAP & MMU
  o add the core mm/nommu file

Alexander Viro <viro@math.psu.edu>:
  o MOD_INC_USE_COUNT removals
  o compile warnings
  o devfs usage cleanups
  o devfs major/minor removal
  o removal of devfs_register_series

Andi Kleen <ak@suse.de>:
  o x86-64 fixes from Andi

Andrew Morton <akpm@digeo.com>:
  o timer fixes
  o hugetlbpage.c build fix
  o add the `oldalloc' and `orlov' mount options to ext3
  o Remove the final per-page throttling site in the VM
  o Move reclaimable pages to the tail ofthe inactive list on
  o Special-case fail_writepage() in page reclaim
  o Move unreleasable pages onto the active list
  o memory barrier work in ipc/util.c
  o speed up signals
  o Fix PF_MEMDIE
  o suppress some buffer-layer warnings on write IO errors
  o truncate speedup
  o Fix interaction between batched lru addition and hot/cold
  o readdir speedup and fixes

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o fix wrong permissions for vfat directories
  o kill probe_cmos_for_drives

Andy Grover <agrover@groveronline.com>:
  o ACPI: Alter comment to reduce unwarranted hyperbole
  o ACPI: Interpreter update to 20021205 Prefix more contants with
    ACPI_ Fixed a problem causing DSDT image corruption Fixed a problem
    if a method was called in an object declaration Fixed a problem in
    the string copy routine Broke out some code into new files
  o ACPI: changed code for new ACPI_ prefixes on constants
  o ACPI: Remove unneeded file
  o ACPI: eliminate spurious unused variables warning w.r.t.
    ACPI_MODULE_NAME
  o ACPI: Never return a value from the PCI device's Interrupt Line
    field if it might be bogus -- return 0 instead.
  o ACPI: Fix check of schedule_work()'s return value (Ducrot Bruno)

Anton Blanchard <anton@samba.org>:
  o ppc64: sched_getaffinity returns bitmask size on success
  o ppc64: add new syscalls and fix 32/64bit conversion of
    getsockopt/setsockopt
  o ppc6: add icmpv6_filter translation, from sparc64
  o ppc64: merge in sparc64 32/64 bit readv/writev wrappers
  o ppc64: merge NCP syscalls and fix a bug in smb mount code, from
    sparc64
  o ppc64: make 32bit readv/writev look like generic one, fixes some
    LTP failures
  o ppc64: updates for 2.5.48
  o ppc64: more pci_dev name fixes
  o ppc64: clean up show_regs and remove print_backtrace
  o ppc64: update for Ingo's threading changes and clean up show_regs
    etc
  o ppc64: defconfig update
  o ppc64: defconfig update - enable raid
  o ppc64: fix sys_clone bug (paulus) and fix fork arguments (Milton
    Miller)
  o ppc64: initial oprofile support
  o fixes for oprofile on ppc64
  o ppc64: fix dnotify bug in do_readv_writev32
  o ppc64: update defconfig and add missing include
  o initial ppc64 compat support from Stephen Rothwell
  o ppc64: A few fixes from davem
  o ppc64: EEH cleanup from Todd Inglett
  o ppc64: get rid of -fomit-frame-pointer and implement xics
    ibm,int-on
  o ppc64: remove fake pci config read code, its currently broken
  o ppc64: Add sys_restart_syscall, from ppc32
  o ppc64: PCI rework 1
  o ppc64: extend ppc_find_proc_name to work on __init functions
  o ppc64: merge some updates from 2.4
  o ppc64: Renmove Pci_Large_Bus_System, nothing uses it

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o uaccess.h: remove include sched.h, it only needs thread_info.h
  o sb_ess: fix up header cleanup: add include <linux/interrupt.h>
  o ambassador: set_bit & friends require a long
  o drivers/atm/horizon.c: test_bit & friends require long
  o drivers/char/sx.c: test_bit and friends require a long
  o hdlcdrv.c: set_bit and friends require a long
  o fealnx: fix up some printk paramenters
  o drivers/net/setup.c: fix special_device_init struct
    initialization
  o lance.c: set_bit and friends require a long
  o drivers/net/ni65.c: test_bit and friends require long
  o net/ipv4/raw.c: add missing include <linux/mroute.h>
  o tcpv4: convert /proc/net/tcp to seq_file
  o net/core/dev.c: convert /proc/net/dev to seq_file
  o wireless: convert /proc/net/wireless to seq_file
  o mxser: add module_exit/module_init
  o net/core/dev.c: convert /proc/net/softnet_stat to seq_file
  o net/ipv4/af_inet.c: remove include seq_file.h and proc_fs.h, not
    needed anymore
  o arp: fix seq_file handling bug
  o nbd: fix up headers changes, include blk.h and blkdev.h
  o atmtcp: fix struct initialization
  o opl3sa2: remove spurious comma
  o gus_wave: remove unused variable 'flags'
  o ip2main: remove unused variable rc in ip2_init_board
  o zftape: zft_init cannot be static it is used also in
    lowlevel/ftape-init
  o scx200_gpio: fix up header cleanups: add include <linux/fs.h>
  o watchdog/sbc60xxwdt: comment out goto label not being used
  o atm/mpc: fix up struct initialization
  o sch_atm: sockfd_put is already defined similarly in linux/net.h
  o dvb/saa7146_core: use pci_[gs]et_drvdata instead of
    pdev->driver_data
  o epca: use module_{init,exit}, {cleanup,init}_module now are
    macros
  o istallion: use module_{init,exit}, {cleanup,init}_module now are
    macros
  o stallion: use module_{init,exit}, {cleanup,init}_module now are
    macros
  o ipv4/route: convert /proc/net/rt_cache to seq_file
  o cdrom/gscd: fixup printk format specifier
  o appletalk/cops: add missing linux/spinlock include
  o sound/mpu401: attach_mpu returns int
  o net/dl2k: test_bit expects pointer to long
  o appletalk/cops: s/spinlock_init/spin_lock_init/g
  o net/dl2k: set_bit requires a long pointer
  o oss/wf_midi: fix up header cleanups, add include
    <linux/interrupt.h>
  o scsi/ini9100u: fix up header cleanups: add include
    <linux/interrupt.h>
  o scsi/pci2220i: fix up header cleanups: add include
    <linux/interrupt.h>
  o scsi/pci2000: fix up header includes: add include
    <linux/interrupt.h>
  o oss/maui: fix up header cleanups: add include <linux/interrupt.h>
  o net/wan/hostess_sv11: remove unused variable flags
  o net/wan/sdla_fr: test_bit and friends require a long pointer
  o if_wanpipe_common: test_bit and friends requires a long pointer
  o wanpipe: test_bit and friends requires a long pointer
  o net/wan/sealevel: remove unused flags variable
  o parport/probe: fix up header cleanups: add include
    <linux/string.h>

Art Haas <ahaas@airmail.net>:
  o C99 initializers all over the place

Brad Hards <bhards@bigpond.net.au>:
  o [SCTP]: Remove dup types.h include

Christoph Hellwig <hch@lst.de>:
  o more sdev freeing rationalization
  o remove implicit scsi_register()
  o remove that anoying in_atomic()
  o remove superflous scsi_delete_timer()
  o remove outdated comment from scsi.c
  o abstract out more scsi_device acess out of the low-level drivers
  o clean up sd bdev methods
  o fix sd device number handling
  o fix sr device number handling
  o complain about missing host template initializations
  o remove remaining MAJOR_NR/DEVICE_NR junk
  o move all sgtable handling in one place
  o get rid of MAJOR_NR

Christoph Hellwig <hch@sgi.com>:
  o [XFS] Fix unchecked kmalloc() in pagebuf
  o [XFS] Remove rootfs special-casing in the quota code
  o [XFS] Change AT_* to XFS_AT_* to prevent namespace collisions; move
    some type declarations into more appropriate places.
  o [XFS] Add sendfile support
  o [XFS] readahead fixes
  o [XFS] remove bogus struct dirent forward declarations
  o [XFS] fix some broken off_t use
  o [XFS] remove unused variable in pagebuf
  o [XFS] use find_trylock_page in the I/O code
  o [XFS] remove dead pbr_flags field from struct xfs_buftarg
  o [XFS] fix direct I/O size calculation
  o [XFS] get rid of some more dev_t abuse
  o [XFS] move remaining buftarg manpiluation from pagebuf to xfs
  o remove bad inodes from hash table
  o [XFS] Implement xfs_panic_mask
  o [XFS] No need to set task state back to TASK_RUNNING after
    returning from schedule()
  o [XFS] cleanup user path walking code
  o [XFS] make pagebuf_workqueue private to page_buf.c
  o [XFS] rename pagebuf_run_task_queue to pagebuf_run_queues
  o [XFS] misc tidyups
  o [XFS] remove two dead members from pagebuf_daemon
  o [XFS] update version string

Dave Jones <davej@codemonkey.org.uk>:
  o split up the device list into two
  o add SiS 651 support
  o add support for two new VIA GARTs
  o [netdrvr tulip] fix obvious typo in CSR6 register values
  o [netdrvr winbond-840] small cleanups
  o [netdrvr rcpci45] final vendor update
  o [netdrvr] Add missing WAN driver assignments to dev->last_rx for
    each RX packet
  o compile fix - typo
  o [netdrvr au1100] update from 2.4.x
  o [netdrvr sungem] kill PCI_DEVICE_IDxxx constant, it's now in
    pci_ids.h
  o rework as per Linus' suggestion. Chipset drivers are now seperate
    modules that use the pci driver interfaces, and register with the
    agpgart backend.
  o prevent acquire from working if we deregister a chipset driver
  o cast fixes from -ac
  o list me as maintainer
  o readd the lost configuration of the i460

David Brownell <david-b@pacbell.net>:
  o usb-storage doesn't say clear_halt WORKED
  o reduce debug message volume
  o ehci-hcd, handle async_next register correctly
  o ehci, more diagnostics use dev_*() macros
  o patch 2.5.50+, ehci-hcd loop termination

David S. Miller <davem@nuts.ninka.net>:
  o [CRYPTO]: Forgot to add twofish.c :)
  o [SPARC]: NR_IRQS is off by one
  o [SPARC64]: sys_sparc32.c wants linux/security.h
  o [SOUND]: ioctl32.c wants linux/fs.h
  o [XFS]: support/move.c wants linux/errno.h
  o [SOUND]: {rawmidi32,seq32,timer32}.c want linux/fs.h
  o [SPARC64]: Fix dnotify_parent call in do_readv_writev32
  o [SPARC64]: Kill some multiline string literals
  o [SPARC64]: Add some missing semicolons newer gcc warns about
  o [SPARC]: Move virt_to_phys/phy_to_virt into page.h
  o [SPARC]: sys_sunos.c wants net/sock.h
  o [SPARC]: tick14.c wants linux/interrupt.h
  o [SPARC64]: Add missing cc clobber to rwsem_atomic_update
  o [SPARC64]: Add -finline-limit=100000 to CFLAGS if gcc supports it
  o [SPARC64]: Clobber register l1 in switch_to if gcc >= 3.0
  o [SPARC32]: Kill redundant romvec definition from system.h
  o [SPARC32]: Move get_wchan into processor.c
  o [SPARC64]: Un-macroify get_wchan
  o [BUFFER]: Fix int to pointer cast
  o [GENHD]: printf format ll means long long not u64
  o [AFFS]: Kill unused label and code
  o [NBD]: Kill uninitialized use warning
  o [RAID0]: Use proper size_t printf format string
  o [SUNRPC]: Use proper size_t printf format string
  o [PARTITIONS]: Printf format ll means long long not u64
  o [NFSD]: Use correct format string for size_t
  o [OSST]: Use correct printf format string for size_t
  o [R8169]: Include linux/init.h and asm/io.h
  o [UHCI]: io_addr should be unsigned long
  o [VIDEODEV2]: Fix misnumbered ioctl
  o [SPARC64]: Update defconfig
  o [DO_MOUNT]: Use correct printf format for bytes_out
  o [SPINLOCK]: Fix non-SMP nopping spin/rwlock macros
  o [SPARC64]: Copy over readv/writev 32-bit compat fixes from ppc64
  o [SPARC64]: Translate 32-bit sys_lookup_dcookie properly, from PPC64
  o [SPARC]: Fix dependency on previous NR_IRQS value
  o [SPARC64]: Basic oprofile support
  o [SPARC64]: Update defconfig
  o [SPARC64]: Export __flush_dcache_range
  o [SPARC]: Add sys_restart_syscall entries
  o [SPARC]: Add restart_block to thread_info
  o [SPARC]: Always use linux/thread_info.h now for C code
  o [SPARC]: ADd ERESTART_RESTARTBLOCK signal return handling
  o [COMPAT]: Convert to new nanosleep implementation
  o [SPARC64]: Update defconfig
  o [NBD]: Kill extraneous endif
  o [NBD]: nbd.c wants blkdev.h and blk.h
  o [SHAPER]: Make shapers_registers actually visible to shaper_exit
  o [SPARC]: Update defconfig
  o [SPARC]: Header tidy to fix the build
  o [CRYPTO]: internal.h needs init.h

David S. Miller <davem@redhat.com>:
  o Update broadcom b44 net driver
  o kbd_pt_regs

Davide Libenzi <davidel@xmailserver.org>:
  o epoll bits 0.59

Douglas Gilbert <dougg@torque.net>:
  o scsi_debug version 1.66
  o [update] scsi_mid_low_api.txt for slave_configure()++

Edward Peng <edward_peng@dlink.com.tw>:
  o [netdrvr dl2k] only read 0x100 through 0x150 statistics registers
    if mem mapping

Gerd Knorr <kraxel@bytesex.org>:
  o dsb usb radio fix

Greg Kroah-Hartman <greg@kroah.com>:
  o PCI hotplug: moved cpci_hotplug.o to be built into pci_hotplug.o if
    enabled
  o LSM: fix conversions in hugetlbfs that I missed in the last merge
  o LSM: change if statements into something more readable for the fs/*
    files
  o LSM: change if statements into something more readable for the
    ipc/*, mm/*, and net/* files
  o LSM: change if statements into something more readable for the
    kernel.* files
  o LSM: change if statements into something more readable for the
    arch/* files
  o USB serial: cleaned up the rest of the __MOD_INC and __MOD_DEC
    calls to use the new module API
  o LSM: add #include <linux/security.h> to fs/hugetlbfs/inode.c
  o PCI: changed pci_?et_drvdata to use the generic driver model
    functions instead of accessing the data directly.
  o USB: get previous module patch to even build properly
  o USB: fix up urb callback functions due to argument change
  o LSM: Added security_fixup_ops()
  o LSM: remove "dummy" functions from the capability code, as they are
    no longer needed
  o LSM: add the example rootplug module
  o USB: fix compile time error in tiglusb.c caused by previous devfs
    changes
  o USB: make usb device lists EXPORT_SYMBOL_GPL
  o USB: initial attempt at Treo 300 support for the visor driver
  o USB: Fix compile error in usbmidi driver
  o USB: Add Treo 300 id to the visor driver supported devices list
  o USB: fixup kobil_sct driver to build properly with urb callback
    changes

Ingo Molnar <mingo@elte.hu>:
  o tcore-fixes-2.5.50-E6
  o getppid-2.5.50-A3

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o more typos in __stxncpy
  o alpha pci update

James Bottomley <jejb@mulgrave.(none)>:
  o move dma_mask into struct device
  o remove struct pci_dev from scsi
  o MCA sysfs changes
  o MCA sysfs Part II - abstract out the hw specific pieces
  o make mca-bus.c use generic device dma_mask
  o Move NCR_D700 to MCA sysfs
  o add mca-driver handling
  o update smc-mca to new MCA API
  o add mca-driver.c file
  o fix 53c700.c for new module loader
  o correct bug in smc-mca.c card counting
  o mca-sysfs-VI
  o make MCA_PROC_FS depend on PROC_FS
  o scsi-dma-mask modify for andmike's changes
  o fix missing scsi_exit_queue function
  o mca-sysfs update to new bus_for_each_dev syntax

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Add twofish algorithm
  o [CRYPTO]: Add serpent algorithm
  o [CRYPTO]: Documentation update
  o [CRYPTO]: Dont compile procfs stuff if procfs is not enabled

James Simmons <jsimmons@maxwell.earthlink.net>:
  o Petr fix to make old api driver to work
  o Ooops. Fix from Paul Mackerras
  o Further api porting. Almost done. Here we eliminate get[set]_cmap
    from struct fb_ops. Also set_disp has ben moved into fbcon.c
    instead of the drivers
  o More fbdev api cleanups. Removed modename from struct fb_info.
    Incorporated Paul's fixes. The cfb stuff is finally going away
  o Added support for logo displaying for new api. Now new code
    supports 24 bpp
  o Remove old fbcon-cfb files
  o Cleanup to match closely Linus tree
  o Removed currcon and other console related code. Very little is now
    left
  o Removed last console and old api related things. Removed
    experimental flags
  o Replace with Russell's driver
  o Cleaned up and moved all the graphics related code inf
    drivers/video and move the console display related stuff into lower
    directory called console
  o Oops. Forgot to include sis_accel.o
  o The last of the console code inside the frmaebuffer layer. I also
    moved all the graphics related code into the drivers/video
    directory
  o Synced up to Linus tree. Fixed the conflict
  o Added a cursor api
  o Cleaned up the console blank handling
  o Moved over fbcon related files to the video/console directory. I
    also updated a few more drivers to the new api
  o Updates to STI framebuffer and STI console. Cleanup of
    include/video and a few minor fixes
  o Moved AGP and DRM code back to drivers/char until a proper solution
    is done for handling AGP/DMA based framebuffer devices
  o Moved all console configuration out of arch directories into
    drivers/video/console. Allow resize of a single VC via the tty
    layer. Nuked GET_FB_IDX
  o Neomagic and HGA updates. MAde the software accel code modular. So
    code cleanup in fbcon. More to go
  o Bug fixes!!
  o Moved stuff into drivers/video/console
  o Several fixes relating to modules. Ported over the vga16fb driver
    to the new api
  o Fixed the anakin and noemagic framebuffer driver. Made font
    selection depeneded on framebuffer consoel instead of just
    framebuffer support. Fixed return to be int for tx3912 framebuffer
  o Simplification of the code
  o Ported Mach64 and NVIDIA driver to final api. A bunch of
    improvements and bug fixes
  o Use the new name of the software cursor function
  o Diver updates
  o Supprt for switching hardware from/to vga text mode
  o Synced to Linus BK tree
  o POrted iga fbdev driver to new api. Untested
  o New NVIDIA and Radeon cards pci ids. Soon I will add support for
    these :-) Also a needed fix for fbcon.c

Jeff Garzik <jgarzik@pobox.com>:
  o fix ppdev compile breakage
  o fix netlink compile breakage
  o Minor broadcom b44 net driver cleanups
  o [netdrvr tc35815] let init_etherdev allocate driver-private struct
    too
  o [netdrvr fealnx] remove bogus line due to patch error
  o [netdrvr] add "r8169", new driver for Realtek 8169 gigabit ethernet
  o [netdrvr r8169] pass dev->irq argument to synchronize_irq() call
  o [netdrvr r8169] large style cleanup
  o [netdrvr r8169] minor functional cleanups and bug fixes
  o Handle internal proc_register failure in proc_symlink, proc_mknod,
    proc_mkdir, and create_proc_entry.
  o [netdrvr] Make a special section in drivers/net/Makefile for
  o [netdrvr 8139too] skb_copy_and_csum_dev use allows us to enable the
    NETIF_F_HIGHDMA feature.
  o [netdrvr sunhme] remove memset in init (alloc_etherdev does it for
    us)
  o [netdrvr] fix minor buffer overruns found by Stanford checker, in
    3c523 and ni52 drivers.
  o [netdrvr 3c515] fix unlikely buffer overrun when >8 adapters
    present
  o [netdrvr fec] set-MAC-address clean up, add better comments, and
    add a FIXME
  o [i2c] add new hardware ids, update rcsid
  o [netdrvr] zap PCI_VPD_ADDR constants from skfp, sk98lin drivers
  o [netdrvr r8169] use pci_[gs]et_drvdata instead of pdev->driver_data
  o [netdrvr de2104x] remove duplicate and oops-able init_timer call
  o Clarify locking/context docs for network interfaces, in
    Documentation/networking/netdevices.txt.

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Always generate the module name automatically
  o kbuild: Fix CONFIG_FRAME_POINTER
  o kbuild: Speed up kallsyms generation
  o kbuild: Build modules as '.ko'
  o kbuild: Fix 'make -j' problem
  o kbuild: Fix the new kallsyms generation
  o kbuild: Fix spurious warning

Kent Yoder <key@austin.ibm.com>:
  o [netdrvr lanstreamer] a fix and a feature addition

Linus Torvalds <torvalds@home.transmeta.com>:
  o Undo stale comment from -ac merge
  o Include the proper header file instead of trying to declare things
    on your own!
  o Oops. LSM cleanups reversed the sense of a error return test
  o Fix initcall function type mismatch
  o More EDD fixes for merge errors
  o Add "restart" system call, allowing system calls to restart after
    signal handling.
  o Simplify the restart system call slightly
  o Implement system call restarting for the "nanosleep()" system call
    using the new system call restart infrastructure.
  o Fix up getdents64() user pointer checking from -mm merge
  o Fix getdents64() offset saving bug from -mm merge

Mark Haverkamp <markh@osdl.org>:
  o aacraid 2.5 update

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390: config
  o s390: gcc 3.3
  o s390: relocations
  o s390: printk noise
  o s390: do_fork parameters
  o s390: missing include
  o s390: debug docu
  o s390: chandev
  o s390: cio rework
  o s390: ccwgroups
  o s390: channel subsystem docu
  o s390: 3215 driver
  o s390: iucv driver
  o s390: dasd driver
  o s390: tape driver
  o s390: cu3088 metadriver
  o s390: ctc driver
  o s390: lcs driver
  o s390: sclp driver

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: make CBI interrupt URBs one-shot
  o usb-storage: make internal structs more consistent

Matthew Wilcox <willy@debian.org>:
  o Add to linux/pci.h PCI-X, CompactPCI, and PCI Vital Product Data
    register defines
  o Make dupfd() locking more clear
  o Neaten up mm/Makefile
  o PS/2 support for PARISC

Mike Anderson <andmike@us.ibm.com>:
  o scsi sysfs update 3
  o add scsi_sysfs.c
  o scsi sysfs update 3
  o more edd fixes

Nathan Scott <nathans@sgi.com>:
  o [XFS] Rethink some of those recent types changes slightly
  o [XFS] Remove assert claiming data and attribute extents cannot be
    logged at the same time - Steve thinks this is unlikely to be a
    real problem, and it was masking real problems further on (see test
    070).
  o [XFS] Use kmalloc/kfree for all xattr memory allocations
  o [XFS] pagebuf can now take a configurable sector size (512 -> 32K)
  o [XFS] Minor formatting and code consistency cleanups
  o [XFS] Find a more suitable home for the xfsstats statistics
    structure
  o [XFS] Cleanup after initially investigating unwritten extents
  o [XFS] Remove an unused function prototype from xfs_trans.h
  o [XFS] Sector size updates - macros for calculating address/size of
    sector-sized data structures (sb,agf,agi,agfl) are now sector size
    aware.  Cleaned up the early mount code dealing with log devices
    and logsectsize.
  o [XFS] Update the vn lock/unlock macros to keep code in sync, no
    functional change
  o [XFS] Fix the build - missing an argument after last change

Patrick Mansfield <patmans@us.ibm.com>:
  o add more scsi_device sysfs attributes
  o current scsi-misc-2.5 scsi_lib.c needs init.h

Patrick Mochel <mochel@osdl.org>:
  o sysfs: fix file deletion again
  o Allow subsystem to have attributes, too
  o fix up block device usage of kobjects
  o NUMA: make sure that the node device class is registered before the
    node driver
  o driver model: reinstate bus iterators
  o kobjects: don't do cleanup if kobject_add() fails
  o driver model: get rid of global device list; minor cleanups
  o driver model: clean up interface handling
  o EDD compile fixes

Paul Mackerras <paulus@samba.org>:
  o Update adbhid.c driver
  o PPC32: remove unused defns of EISA/MCA_bus__is_a_macro
  o PPC32: need to include <linux/smp_lock.h> in <asm-ppc/hardirq.h>
  o PPC32: in loading modules, make sure PLT start address is aligned
  o PPC32: add extra do_fork argument to call in __cpu_up
  o PPC32: Fix compile warning in arch/ppc/platforms/residual.c
  o PPC32: add support for restarting syscalls with
    ERESTART_RESTARTBLOCK
  o PPC32: don't use call descend in boot Makefiles
  o PPC32: cope with PPC750FX rev 2.0 errata where we can't enable DPM
    (dynamic power management)

Pavel Machek <pavel@ucw.cz>:
  o devicefs support for system timer
  o swsusp & acpi_sleep: configuration issues
  o swsusp: move variables where they belong
  o swsusp: 64-bit compatibility
  o swsusp: md support
  o s3 sleep: make it work when kernel is big
  o acpi_wakeup.S: simplify logic

Pete Zaitcev <zaitcev@redhat.com>:
  o [SUNZILOG]: Better serial TTY default settings
  o [SPARC]: Fix misplaced prom_printf
  o [SPARC]: kill NR_IRQS + 1 stuff

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o too few spaces in struct definition
  o undeclared variable in netlink device emulation

Randy Dunlap <randy.dunlap@verizon.net>:
  o raw driver as module (resend)
  o binfmt_* need ptrace_notify (resend)
  o (trivial/resend) fix mips Kconfig

Richard Henderson <rth@are.twiddle.net>:
  o [ALPHA] Clean up Ivan's patch (ChangeSet 1.456.18.11) for the Alcor
    buggy window.
  o [TRIVIAL] Use asm-generic/topology.h

Richard Henderson <rth@dorothy.sfbay.redhat.com>:
  o [ALPHA] Add restart_syscall support
  o [ALPHA] Include asm/io.h in asm/pci.h to match i386 and thence fix
    a scsi build error.

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: Fix sparc_ksyms __sparc_dot handling
  o [SPARC]: Fix ELF_CORE_COPY_TASK_REGS define
  o [SPARC]: asm/hardirq.h wants linux/cache.h
  o [SPARC]: Fix iommu_get_scsi_sgl_pflush
  o [SPARC]: Fix loop terminator in iommu_get_scsi_sgl_pflush
  o [SPARC32]: Update MAINTAINERS entry
  o [SPARC]: Backport of 2.4.x dynamic-nocache

Robert Love <rml@tech9.net>:
  o remove stale add_blkdev_randomness() uses

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr ns83820] fix oops, initialize dev->priv to prevent future
    slipups like this
  o [netdrvr via-rhine] merge bug fixes and new features from 2.4.x
    kernel

Romain Lievin <rlievin@free.fr>:
  o USB: tiglusb update

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix Acorn SCSI host device list scanning for 2.5.50
  o [SERIAL] Prevent PNPBIOS re-registering already detected ports
  o [SERIAL] Export pci_siig10x_fn() and pci_siig20x_fn()
  o [SERIAL] Pass "iomap" base from probe modules
  o [SERIAL] Fix failure checks
  o [SERIAL] Replace tty->alt_speed with uart_get_baud_rate()
  o [SERIAL] Move custom_divisor from uart_state to uart_port
  o [SERIAL] Move quot/divisor calculation to uart_get_divisor()
  o [SERIAL] Move the FIFO timeout calculations into
    uart_update_timeout()
  o [SERIAL] uart_get_divisor() and uart_get_baud_rate() takes termios

Rusty Russell <rusty@rustcorp.com.au>:
  o Don't sort kallsyms symbols twice
  o kallsyms in modules fix
  o Table fix for module-init-tools
  o v850 support
  o module names fix
  o kill unneeded declaration from drivers_scsi_sim710.h (fwd)
  o Fix confusing comment
  o backward ext3 endianness conversion
  o duplicate header in drivers_ieee1394_sbp2.c
  o duplicate header in net_sctp_output.c
  o tiny kmem_cache_destroy doc tweak
  o interface_register-001
  o remove check_region from isurf.c
  o duplicate header in drivers_bluetooth_hci_h4.c
  o net_shaper.c wrong variable on exit
  o spelling
  o trivial change to fix new module support for m68knommu
  o gemtek radio fix
  o setrlimit incorrectly allows hard limits to exceed soft limits
  o namei.c_path_lookup takes lock unnecessarily
  o Remove reference to timer_exit() from kernel-locking.tmpl, fix typo
  o region change for dmascc.c hamradio driver
  o remove check_region from cosa.c
  o dgrs doesn't free on error path
  o misc_register-017
  o misc_register-004
  o Fix for CONFIG_VIDEO_DEV=y
  o misc_register-012-002
  o c99 struct initialization for the saa7134 driver
  o saa7134 build fix
  o trivial additions to symbold offsets for m68knommu arch
  o setup_arg_pages. ARCH_STACK_GROWSUP
  o patch] duplicate header in net_ax25_ax25_route.c
  o duplicate header in fs_jffs_inode-v23.c
  o MINOR -> minor in debug message
  o misc_register-014
  o trivial fixups to m68knommu arch Makefile
  o sis900 doesn't free resources
  o trivial fix for missing bracket in 68328 Makefile
  o eepro.c has spurious kfree
  o duplicate header in mm_pdflush.c
  o trivial fixup of function prototype in m68k_syms.c
  o sigmask() was mutilply defined
  o duplicate header in fs_reiserfs_bitmap.c
  o NCR5380.c compile fix
  o misc_register-002-002
  o misc_register-021
  o removal of check_region from w83977af_ir.c

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: Move flags to Makefile.lib
  o kbuild: Introduced build-targets
  o kbuild: No longer use descend macro, added 'Kernel: xxx is ready'
    text

Stephen Lord <lord@sgi.com>:
  o [XFS] add a field to the iclog output
  o [XFS] clean up use of run_task_queue in xfs
  o [XFS] remove some unused code paths from the log flushing paths,
    and remove the callback processing from the log write path, we only
    do callbacks on I/O completion now.
  o [XFS] avoid need to remap pages when discarding attribute space
  o [XFS] for synchronous transactions, allow the in core log buffer to
    wait around in active state for as long as possible. This allows us
    to coalesce several transactions into one buffer and reduce the
    disk traffic.
  o [XFS] when logging attribute extents, use the correct size for the
    allocation!

Stephen Rothwell <sfr@canb.auug.org.au>:
  o dnotify fix for readv/writev
  o compatibility syscall layer
  o [SPARC64]: Add initial compat layer stuff

Tigran Aivazian <tigran@aivazian.name>:
  o arch_i386_kernel_microcode.c misc_register

Vitezslav Samel <samel@mail.cz>:
  o debug messages in ide-floppy.c

William Lee Irwin III <wli@holomorphy.com>:
  o Add __exit_p() to match existing __devexit_p()
  o fix duplicate decls in swsusp
  o remove unused cr0 in cyrix.c
  o fix unused function warning in drivers/block/floppy.c


