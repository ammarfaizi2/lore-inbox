Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTEEAhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEEAhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:37:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261864AbTEEAhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:37:21 -0400
Date: Sun, 4 May 2003 17:48:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.69 
Message-ID: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h450n7a04780
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 I finally found the reason for why some of my machines had trouble with
restarting the X server, and it turns out that it's been around since very
early February. I bet others must have seen it too, with random crashes on
X server restart when the server used AGP (which means that it mainly hit
either hw-accelerated 3D setups or the intel integrated graphics which use
a UMA model with AGP as the backing store).

That's a big relief for me, as it was the major thing I personally worried 
about for 2.6.x. 

Anyway, that's fixed here, along with a lot of other updates. Much of 
2.5.69 is small one-liners to drivers to handle the new IRQ semantics, but 
there's a lot of other cleanups in there too (Christoph Hellwig continued 
on his devfs rampage, for example).

NOTE! As of this release I think I'll want to have patches either be 
_really_ obvious, or they should go through one of more people for 
approval. In particular, I'm hoping that the paperwork stuff with Andrew 
should be getting closer to finalized, and that we could start moving over 
towards a 2.6.x release schedule.. 

		Linus

---
Summary of changes from v2.5.68 to v2.5.69
============================================

<atulm:lsil.com>:
  o Update megaraid to version 2.03

<ccheney:cheney.cx>:
  o USB: vicam.c copyright patches

<dmo:osdl.org>:
  o 2.5.68 scsi/gdth compile warnings and stack usage

<gj:pointblue.com.pl>:
  o USB: fix usbkbd.c compilation error

<james:superbug.demon.co.uk>:
  o USB: Add support for Pentax Still Camera to linux kernel

<l.s.r:web.de>:
  o Remove unused function from fs/isofs/rock.c

<linux-usb:gemeinhardt.info>:
  o USB: add support for Mello MP3 Player

<mikenc:us.ibm.com>:
  o fixes compile errors in psi240i.c

<nstraz:sgi.com>:
  o [XFS] Use "%p" to print out addresses from xfs_error_report(). 
    This is so addresses don't get truncated on 64-bit archs.

<pixi:burble.org>:
  o [quota] provide no-op sync_dquots_dev, one .config case wants it

<ralphs:org.rmk.(none)>:
  o [NWFPE] Performance improvements [Parts 1-6]

Richard Henderson:
  o Fix unwind info for sysenter entry point

<scole:zianet.com>:
  o [NET]: Spelling fixes for net/

<valdis.kletnieks:vt.edu>:
  o cpp cleanups for ia32/io_apic.c, sound/oss/trident.c
  o cpp cleanups: use KERNEL_VERSION macro from linux/version.h
  o [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

<vinay-rc:naturesoft.net>:
  o [NET]: Use mod_timer in dst.c
  o [PKT_SCHED]: Use mod_timer in sch_cbq.c
  o [PKT_SCHED]: Use mod_timer in sch_csz.c
  o [PKT_SCHED]: Use mod_timer in sch_htb.c

Alan Stern:
  o Trivial patch for scsi logging text string
  o USB: Minor patch for uhci-hcd.c

Alex Williamson:
  o 8250_pci include offset in iomap_base

Alexander Schulz:
  o [ARM PATCH] 1517/1: Shark: new defconfig
  o [ARM PATCH] 1518/1: Shark: cyberpro broken by machine_is_netwinder

Alexander Viro:
  o tty cleanups (1-12)
  o console cleanups (1-2)
  o fbdev cleanup
  o capifs cleanup
  o invalidate_device()/check_disk_change() fixes
  o ppc boot device selection cleanup
  o simple_fill_super()
  o pin_fs/release_fs
  o open_by_devnum()
  o blkmtd init cleanup
  o bdget_disk()
  o ataflop.c cleanup
  o hd98 compile fixes

Andi Kleen:
  o Runtime memory barrier patching
  o Minor 32bit Opteron fixes
  o Update alt_instr to handle SSE2 prefetch and better nops
  o Fix prefetch patching in 2.5-bk
  o x86-64 update
  o discontigmem fix

Andrew Morton:
  o 3c574_cs fixes
  o Fix nc98 partition parser link error
  o dmfe: don't free skb with local interrupts disabled
  o dentry_stat accounting fix
  o Fix and clean up DCACHE_REFERENCED usage
  o Fix POSIX timers to give CLOCK_MONOTONIC full
  o Fix jiffies_to_time[spec | val] and converse to use
  o get_offset_pit and do_timer_overflow vs IRQ locking
  o detect_lost_tick locking fixes
  o Minor fix for driver/serial/core.c
  o keyboard.c Fix SAK in raw mode
  o Make PCI scanning order the same as 2.4
  o Turn on NUMA rebalancing
  o Move __set_page_dirty_buffers to fs/buffer.c
  o Clean up various buffer-head dependencies
  o follow_hugetlb_page fix
  o hugetlb math overflow fix
  o ATI Mach64 build fix
  o quotactl(): sync all quotas
  o AIO mmap fix
  o shmdt() speedup
  o implement __GFP_REPEAT, __GFP_NOFAIL, __GFP_NORETRY
  o make alloc_buffer_head take gfp_flags
  o use __GFP_REPEAT in pte_alloc_one()
  o use __GFP_REPEAT in pmd_alloc_one()
  o Disallow swapoff if there is insufficient memory
  o Permit interruption of swapoff
  o oom-kill: preferentially kill swapoff
  o DAC960: add call to blk_queue_bounce_limit
  o shm_get_stat-handle-hugetlb-pages.patch
  o Allocate hd_structs dynamically
  o fix CONFIG_NOMMU mismerges
  o Extend map_vm_area()/get_vm_area()
  o don't shrink slab for highmem allocations
  o prepare device mapper for larger dev_t
  o smbfs: larger dev_t preparation
  o Fix nfsctl for larger dev_t
  o Aggregated disk statistics
  o fbdev build fix
  o irqs: drivers/block
  o irqs: sym2
  o irqs: rtc
  o irqs in sound/
  o irqs: ipmi driver
  o irqs: watchdog drivers
  o irqs: various char drivers
  o irqs: multimedia drivers
  o irqs: video drivers
  o irqs: 1394
  o parport_serial fix
  o ax25 build fix
  o irqs: IRDA
  o irqs: ISDN
  o irqs: input drivers
  o irqs: hotplug drivers
  o More careful about VMA merging
  o usb: minor usb stuff
  o print IRQ handler addresses
  o warning fixes
  o fix typo in m68k mm code
  o irqs: scsi
  o Fix IRQ_NONE clash
  o irqs: ATM
  o irqs: drivers/block
  o irqs: char drivers
  o irqs: scsi
  o sound driver fixes
  o CPU flags fixes
  o various irqreturn_t fixes
  o parkbd.c jiffies fix
  o watchdog driver compile fixes
  o bttv warning fix
  o jiffy type warning fixes
  o net driver cleanup, volume 7
  o [NETFILTER]: Put back missing list_head iterator local var
  o irqs: i2c
  o irqs: IRDA
  o Fix slab-vs-gfp bitflag clash
  o irqs: bttv
  o APM locking fix
  o Fix warnings in xd.c
  o DAC960 patch to entry points with a new fix
  o allow modular JBD
  o generic HDLC module API update
  o proc_file_read fix
  o buffer.c unused vars
  o simple mwave code cleanup
  o fs/ext3/super.c fix for orphan recovery error path
  o update nr_threads commentary
  o lost_tick fixes
  o zone accounting race fix
  o aio support for block devices
  o percpu counters cause UML compilation errors in with SMP
  o config menu cleanups
  o oom-killer locking fix
  o cs46xx: fix incomplete search-and-replace

Andy Grover:
  o ACPI: interpreter update to 20030418
  o ACPI: Fix link devices on SMP systems (Dan Zink)
  o ACPI: Add missing include
  o ACPI: Indicate whether we handled the interrupt or not

Anton Altaparmakov:
  o NTFS: Add handling for initialized_size != data_size in compressed
    files
  o NTFS: Update version
  o NTFS: Minor updates
  o NTFS: Remove compile warning for newer gcc
  o unistr.c
  o NTFS: Reduce function local stack usage from 0x3d4 bytes to just
    noise in fs/ntfs/upcase.c. (Randy Dunlap <rddunlap@osdl.ord>)
  o NTFS: 2.1.2 release: Fix buggy free cluster and free inode
    determination logic
  o NTFS: Fix silly porting typo
  o NTFS: Typo fix
  o NTFS: Fix compiler warnings on big endian machines
  o super.c::parse_ntfs_boot_sector(): Correct the check for 64-bit
    clusters (Philipp Thomas)
  o NTFS: load_attribute_list() bug fix from Szaka
  o NTFS: Fix typo and release 2.1.3
  o NTFS: 2.1.4 release - Reduce compiler requirements

Anton Blanchard:
  o ppc64 needs setup-bus.c
  o [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually

Arnaldo Carvalho de Melo:
  o net: new module infrastructure for net_proto_family
  o rtnetlink: use C99 struct init style
  o atm/lec.c: use C99 struct init style
  o rtnetlink_dev: use C99 struct init style
  o net: module refcounting for sk_alloc/sk_free
  o net/socket: make sys_accept bump the net proto family module
    usage count
  o ipx: remove MOD_{INC,DEC}_USE_COUNT
  o llc: remove MOD_{INC,DEC}_USE_COUNT
  o af_llc: initialize ->owner in llc_ui_family_ops
  o appletalk: remove MOD_{INC,DEC}_USE_COUNT
  o af_llc: add missing include module.h
  o af_unix: remove MOD_{INC,DEC}_USE_COUNT
  o wireless: make the ioctl tables more resilient to errors using
    C99 style init
  o af_ax25: remove MOD_{INC,DEC}_USE_COUNT
  o af_econet: remove MOD_{INC,DEC}_USE_COUNT
  o af_irda: remove MOD_{INC,DEC}_USE_COUNT
  o af_key: remove MOD_{INC,DEC}_USE_COUNT
  o af_netrom: remove MOD_{INC,DEC}_USE_COUNT
  o af_packet: remove MOD_{INC,DEC}_USE_COUNT
  o af_rose: remove MOD_{INC,DEC}_USE_COUNT
  o af_wanpipe: remove MOD_{INC,DEC}_USE_COUNT
  o af_x25: remove MOD_{INC,DEC}_USE_COUNT
  o netrom/nr_dev: use SET_MODULE_OWNER, removing calls to
    MOD_{INC,DEC}_USE_COUNT
  o rose/rose_dev: use SET_MODULE_OWNER, removing calls to
    MOD_{INC,DEC}_USE_COUNT
  o net: several C99 struct init style conversions and cleanups
  o net: save some more bytes in the kernel image moving global zero
    inits to .bss
  o af_decnet: remove MOD_{INC,DEC}_USE_COUNT
  o ipx: several simple cleanups
  o pppox: simple code cleanups
  o af_pppox: create module infrastructure for protocol modules
  o af_pppox: return -EPROTONOSUPPORT if try_module_get fails at
    pppox_create
  o net/socket: return -EAFNOSUPPORT if net_family_get fails at
    sock_create and sys_accept
  o net/llc: simple cleanups
  o net/sched: some trivial code cleanups, making some code smaller
  o net/core/dev: fix obvious bug in dev_get_idx
  o net/core/dev: add missing ++*pos in dev_seq_next
  o net/core/dev: another fix for the seq_file handling of
    /proc/net/dev
  o net: improve the current module infrastructure
  o pppoe: use revised net module infrastructure
  o bluetooth: use revised net module infrastructure
  o appletalk: use revised net module infrastructure
  o ax25: use revised net module infrastructure
  o decnet: use revised net module infrastructure
  o econet: use revised net module infrastructure
  o ipx: use revised net module infrastructure
  o irda: use revised net module infrastructure
  o af_key: use revised net module infrastructure
  o llc: use revised net module infrastructure
  o netlink: use revised net module infrastructure
  o netrom: use revised net module infrastructure
  o packet: use revised net module infrastructure
  o rose: use revised net module infrastructure
  o unix: use revised net module infrastructure
  o wanpipe: use revised net module infrastructure
  o x25: use revised net module infrastructure
  o sctp: use revised net module infrastructure
  o ipv6: use revised net module infrastructure
  o ipv4: use revised net module infrastructure
  o vlan: fix comment about understanding shared skbs

Art Haas:
  o C99 initializers for drivers/scsi
  o C99 initializers for drivers/block/genhd.c
  o Fix C99 initializers in fs/nfs/nfs4proc.c
  o C99 initializers for fs/proc/proc_misc.c

Bart De Schuymer:
  o [NETFILTER]: Add ipt_physdev extension
  o [BRIDGE]: Always set BRNF_BRIDGED mask when bridging
  o [NETFILTER]: Possible use of freed skbuff in netfilter.c
  o [EBTABLES]: Add ebtables match for the pkt_type member of an skbuff
  o [EBTABLES]: Add ARP MAC address filtering

Bartlomiej Zolnierkiewicz:
  o fix init_irq
  o fix mismatched access_ok() checks in sg_io()
  o fix DMA for taskfile IO
  o fix compilation of taskfile IO
  o remove duplicated defines from ide.h
  o Remove duplication of generic ide funcs from ide-taskfile.c
  o Kill dups of read_24(), rename it to ide_read_24()
  o make floppy driver useable for 2.5

Ben Collins:
  o 1394 updates
  o IEEE1394/Firewire updates
  o Merge to current SVN repo (r915)
  o [SPARC64]: Fix ioctl32.c in latest BK
  o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
  o [VIDEO]: Revert atyfb back to known working clean base
  o Fix compat_ioctl
  o add ieee1394 module dev table
  o ieee1394 update (r925)

Benjamin Herrenschmidt:
  o PPC32: Handle CPUs that have extra BAT (block address translation)
    registers
  o PPC32: flush the cache more thoroughly on sleep
  o PPC32: Updates for newer PowerMac/PowerBook machines
  o PPC32: Fix for older SMP powermacs

Christoph Hellwig:
  o devfs: remove devfs_unregister
  o devfs: switch over ubd to ->devfs_name
  o devfs: remove dead devfs code in dasd
  o devfs: superflous devfs_remove in scsi
  o devfs: introduce devfs_mk_bdev
  o devfs: gendisk.devfs_name updates
  o devfs: kill devfs_register_partition
  o devfs: warn on block modes in devfs_register
  o devfs: convert input, dvb, usb, sound, videodev, miscdev, s390,
    ipmi, swim3, uml, loop, nbd, rd, swim3, aztcd, gscd, optcd, sjcd,
    sonycd, mtdblock, xpram, floppy, device-mapper, md
  o initrd.h
  o rename end_request in floppy() and raid1
  o replace __blk_run_queue with blk_run_queue
  o remove dasd_get_kdev
  o remove some junk from hd98.c's ioctl implementation
  o remove a tiny bit of kdev_t abuse from the floppy driver
  o scsi_scan.c coding style fixes
  o unexport scsi_host_get_next
  o kill ASSERT_LOCK
  o i2c: remove dead junk from i2c-sensors.h
  o i2c: remove dead code from adm1021
  o i2c: remove dead init code from i2c-sensors.c
  o i2c: bring i2c-viapro uptodate with the style guide
  o [PCMCIA] remove unused files
  o split initrd from ramdisk driver
  o kill LOCAL_END_REQUEST
  o don't use mem_map_reserve/mem_map_unreserve
  o don't include devfs_fs_kernel.h in global headers
  o fix devfs_mk_dir prototype
  o update s390 tape_block for 2.5 APIs
  o remove a wrong invalidate_bdev from ide-disk.c
  o fix dasd open/release
  o remove proc_print_scsidevice abuse from drivers
  o Fix devfs botch in IDE naming
  o kill <linux/wrapper.h>
  o use file->private_data in ide-tape
  o [PCMCIA] consolidate cs_error()
  o de-uglify scsi.c
  o [netdrvr pcmcia] switch drivers to using pcmcia_register_driver
  o fix devfs_register_tape stub
  o update dcache documentation
  o improved bdevname
  o use .devfs_name in struct miscdevice
  o remove devfs hack from misc_register
  o add an missing prototype to initrd.h
  o switch drivers/input/serio/serport.c to new-style module handling
  o remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
  o make __bdevname output more similar to bdevname
  o make <linux/blk.h> obsolete

Dave Kleikamp:
  o JFS: Avoid rare deadlock

David Brownell:
  o USB: fix for deadlock in v2.5.67
  o USB: hcd-pci.c catch up to dev_printk changes
  o usb: fix (rare?) disconnect
  o USB: usbnet, config changes for CDC Ether

David S. Miller:
  o [PKT_SCHED]: Proper module refcounting for packet classifiers
  o [PKT_SCHED]: Proper module refcounting for packet schedulers
  o [SPARC64]: A few missing pgtable __GFP_REPEAT
  o [SPARC]: Rename signal macros SV_foo --> _SV_foo
  o [NET]: In sock_alloc_send_pskb, add __GFP_REPEAT when __GFP_WAIT
  o [SPARC]: setup.c needs linux/initrd.h
  o [SOUND SPARC]: Update for irqreturn_t
  o [SPARC]: Fix dumb typo in sun4c mm code
  o [SPARC]: Platform code changes for irqreturn_t
  o [SERIAL SPARC]: Update for irqreturn_t
  o [SOUND]: mpu401.h needs linux/interrupt.h
  o [CHAR SPARC]: Update for irqreturn_t
  o [RTC]: Update for irqreturn_t
  o [FC4 SPARC]: Update for irqreturn_t
  o [MESSAGE FUSION]: Update for irqreturn_t
  o [SCSI ESP]: Update for irqreturn_t
  o [SCSI QLOGICFC]: Update for irqreturn_t
  o [SCSI QLOGICISP]: Update for irqreturn_t
  o [SCSI QLOGICPTI]: Update for irqreturn_t
  o [SCSI AIC7XXX_OLD]: Update for irqreturn_t
  o [SCSI SYM53C8XX_2]: Update for irqreturn_t
  o [TG3]: Update to irqreturn_t
  o [NET SUN]: Update for irqreturn_t
  o [MYRI_SBUS]: Update for irqreturn_t
  o [SOUND PCI]: Update several drivers for irqreturn_t
  o [SOUND TRIDENT]: Update for irqreturn_t
  o [SPARC64]: Update defconfig
  o [NETLINK]: Fix minor numbers in netlink_dev.c
  o [SPARC]: CLOCK_MONOTONIC fixes, from x86
  o [SPARC64]: Add LOOP_{GET,SET}_STATUS64 to ioctl32
  o [NET]: Do not let GCC reload pointers after NULL checks
  o [SPARC64]: Kill unnecessary MOD_{INC,DEC}_USE_COUNT in cpwatchdog
    and envctrl drivers
  o [NET]: SG without checksum support is illegal
  o [USB INPUT]: hiddev.c needs dev_fs_kernel.h
  o [SCTP]: ICMP6 per-device changes for sctp
  o [IPV6]: Export in6_dev_finish_destroy
  o [BRIDGE]: br_if.c needs linux/init.h
  o [EBTABLES]: Make ebt_vlan.c use correct printf format for size_t
  o [DECNET]: Kill warning with gcc-3.x in dn_route.c
  o [NETFILTER]: Make ip_conntrack_core.c use correct printf format for
    size_t
  o [SPARC64]: Update defconfig
  o [NETFILTER]: Kill unused var in nf_reinject
  o [NETFILTER]: Use proper size_t printf format in ip6t_LOG.c
  o [IPV6]: Kill unused vars in mcast procfs code
  o [IPV4]: Use dst_pmtu not dev->mtu to determine if fragmentation is
    needed
  o [IPV4]: Fix typos in ipip.c commented out code
  o [PKT SCHED]; Missing semicolon in acme cleanups
  o [SPARC64]: Update defconfig
  o [NET]: Fix hashing exploits in ipv4 routing, IP conntrack, and TCP
    synq
  o [IPV4]: Fix ip_rt_acct reading
  o [IPV4]: Fix typo in hashing changes
  o [IPV4]: Add missing init_timer for rt_secret_timer
  o [OPROFILE]: timer_int.c needs profile.h and init.h
  o [SPARC64]: Update defconfig
  o [SPARC64]: oprofile/init.c needs errno.h

David Stevens:
  o [IGMPv3/MPDv2]: Bug fixes and ipv4 multiprotocol API
  o [IGMP]: Fix bug in broadcast handling

Douglas Gilbert:
  o scsi_mid_low_api.txt update for 2.5.67

Duncan Sands:
  o USB speedtouch: bump the version number
  o USB speedtouch: crc optimization
  o USB speedtouch: compile fix

Edward Peng:
  o [netdrvr via-rhine] fix promisc mode
  o [netdrvr sundance] bug fixes, VLAN support

Eli Carter:
  o [ARM PATCH] 1508/1: use #define's for iq80321
  o [ARM PATCH] 1511/1: iop321 #define cleanup
  o [ARM PATCH] 1510/1: use a #define for asm jump address
  o [ARM PATCH] 1513/1: iq80310 fix missing header
  o [ARM PATCH] 1514/1: iq80321 MTD C99 fix

Eric Brower:
  o [SPARC]: Refactor AUXIO support

Eric Sandeen:
  o [XFS] Make MODULE_AUTHOR consistent with other SGI modules

Florin Iucha:
  o i2c: added it87 driver

François Romieu:
  o [wan dscc4] irqreturn_t update
  o [DECNET]: Fix build with CONFIG_DECNET_ROUTE_FWMARK enabled

Ganesh Venkatesan:
  o [netdrvr ixgb] add new driver for Intel's 10 gig ethernet

Greg Kroah-Hartman:
  o USB: add support for new tty tiocmget and tiocmset functions
  o i2c: fix up it87.c check_region mess
  o i2c: removed unused flags paramater in found_proc callback
  o i2c: fix up the media drivers due to removing flags paramater of
    callback function
  o i2c: removed unneeded typedef from i2c-sensor.h
  o i2c: remove a lot of dupliated macros from i2c-sensor.h and use the
    current values in i2c.h
  o USB: add error reporting functionality to the pl2303 driver
  o tty: let tiocmset pass TIOCM_LOOP changes to the tty drivers
  o kobject: kobj_lock needs to be grabed using spinlock_irq
  o driver core: rework driver class structures and logic
  o driver core: fix up cpu.c, memblk.c, and node.c due to the class
    changes
  o driver core: fix up the input_class logic due to the class changes
  o driver core: fix up cpufreq code to work with new class changes
  o driver core: fix up tty code to work with the new class changes
  o driver core: fix up scsi code to compile due to the class changes
  o driver core: fix up the pcmcia code to work with the new class
    changes
  o driver core: removed drivers/base/fs/*, drivers/base/intf.c and
    drivers/base/hotplug.c
  o USB: fix CHECKER found bug in the empeg.c driver
  o USB: fix CHECKER found bug in the io_edgeport.c driver
  o USB: fix CHECKER found bug in the ipaq.c driver
  o USB: fix CHECKER found bug in the keyspan.c driver
  o USB: create usb_init_urb() for those people who like to live
    dangerously (like the bluetooth stack.)
  o USB: added support for Sony DSC-P8
  o USB: add comment to storage/unusual_devs.h that specifies how to
    add new entries

Harald Welte:
  o [NETFILTER]: Makefile and build fixes
  o [NETFILTER]: Trivial but important state fix for ipt_conntrack

Hideaki Yoshifuji:
  o [IPSEC]: nexthdr in xfrm6_input needs to be int
  o [IPV6]: dst_alloc() clean-up
  o [IPV6]: SNMP6 clean-up
  o [IPV6]: Per-interface statistics infrastructure

James Bottomley:
  o Fix megaraid compile warnings
  o Fix megaraid module ownership
  o scsi_scan.c: cope with second inquiry failure
  o irqreturn_t fixup for 53c700
  o Add irqreturn_t to scsi/psi240i
  o Fix ncr53c8xx for PA-RISC Zalon SCSI driver
  o Compile fix for 53c700 on PA-RISC
  o convert Megaraid to irqreturn_t
  o Fix mismerge in megaraid.c

James Morris:
  o [IPSEC]: allow only tunnel mode in xfrm4_tunnels
  o [IPSEC]: pmtu discovery support at local tunnel gateway
  o [NET]: Cosmetic cleanups of jhash code
  o [IPV4]: Choose new rt_hash_rnd every rt_run_flush
  o [IPSEC]: Consolidate some output code into xfrm_check_output

Jeff Garzik:
  o Modernize rcpci45 I2O LAN driver (#204)
  o [rcpci45] typo fix: s/virual/virtual/
  o net driver cleanup, volumes 1-6
  o fix printk when an irq doesn't get responded to
  o [netdrvr tg3] detect shared (and screaming) interrupts
  o [netdrvr tg3] fix omission in board shutdown sequence
  o s/#if/#ifdef/ for a few CONFIG_SMP tests in public headers
  o [hw_random] fix bug, bump version
  o [netdrvr ixgb] Lindent, then fix up obvious indent uglies by hand
  o [netdrvr ixgb] use standard kernel u8/u16/u32 types
  o [netdrvr ixgb] more cleanups

Jeff Smith:
  o [NETFILTER IPV4]: Fix typo in Kconfig

Jens Axboe:
  o request structure stack corruption
  o cleanup bio_map_user and helper

Joe Perches:
  o USB: fix up usbnet's macros for older compilers
  o USB: fix up usb_serial.h's dbg macro to take up less space
  o USB: fix up usb.h's dbg macro to take up less space

John Levon:
  o OProfile updates

Keith M. Wesolowski:
  o [SPARC]: Replace "magic" values

Linus Torvalds:
  o Fix-ups for i830 from Arjan
  o Interrupt handlers should return whether the interrupt was for them
    or not, so that the irq subsystem can properly handle screaming
    shared interrupts.
  o Update ensoniq driver to return whether the interrupt was for it
  o Fix IO-APIC vector allocation boundary case - we never want to
    allocate FIRST_SYSTEM_VECTOR as an external interrupt. It's
    unlikely, but could happen if we have a _ton_ of interrupt sources.
  o Return IRQ_NONE for ieee1394 driver when the interrupt was for
    somebody else.
  o Allow gcc to generate better code for irq handling
  o Add the Xeon variations (Pentium-III and P4-based) to the list
  o Fix irq event debug print-out, and add stack dump which can give a
    clue about what the context was that might have caused the spurious
    interrupt.
  o Never merge vma's that have mapping-private data
  o Since "apply_alternatives()" also runs at module load time it must
    not be marked __init.
  o Merge with DRI CVS tree: remove stale old context switching code
    and DMA histogramming. Be more careful about DMA page-list
    allocations, and remove old and broken (not SMP-safe, and unused)
    DRM read(), write() and poll() support.
  o 'hw_status_page' looks like a pointer, quacks like a pointer and
    walks like a pointer. It _is_ a pointer. So make it one, and remove
    a lot of silly casts.
  o Fix up some mixing of ramdisk/initrd. They have nothing in common,
    but the build was confused by the fact that they did share some
    files.
  o Avoid warning: print out hw_status_page as the pointer it now is
  o scsi.c needs <linux/interrupt.h>. Somebody was a bit over-eager at
    cleanups.
  o DRI CVS merge: move more gamma-only functions away from generic dri
    files and into gamma driver files.
  o Previous DRI CVS merge improperly removed some sparc-only support.
    Add it back in now that DRI is synched up again.
  o Remove old (disabled) debugging code
  o DRI CVS merge: make sure to clean up irq and DMA on final close
  o DRI CVS merge: only free pages when we _have_ pages to free
  o DRI CVS merge: make sure the device is properly initialized before
    opening it.
  o DRI CVS merge: memory barrier updates
  o DRI texmem branch merge cleanups. Texture ages are unsigned, and
    radeon should use generic texture structure now.
  o PCI ID's for Quadrics from Daniel Blueman
  o Revert pmd/pgd slabification. wli will fix it properly

Maksim Krasnyanskiy:
  o [Bluetooth] Use very short disconnect timeout for SCO connections.
    They cannot be reused and therefor there is no need to keep them
    around.
  o [Bluetooth] Kill incoming SCO connection when SCO socket is closed
  o [Bluetooth] HCI USB driver update. Support for SCO over HCI USB
  o [Bluetooth] Don't forget to set HCI device owner in USB driver
  o [Bluetooth] Update BT PCMCIA drivers to use
    pcmcia_register_driver()
  o [Bluetooth] Improved RFCOMM TTY TX buffer management
  o [Bluetooth] Fix race condition in RFCOMM session and dcl scheduler
  o [Bluetooth] USB drivers cannot call usb_unlink_urb() under spin
    lock
  o [Bluetooth] Initialize net_proto_family->owner field. This covers
    only HCI sockets
  o [Bluetooth] Initialize ->owner field of the RFCOMM tty driver

Marc Zyngier:
  o Convert Alpha to the new 2.5 IRQ API
  o EISA/sysfs update

Marcel Holtmann:
  o [Bluetooth] Add support for the Ultraport Module from IBM
  o [Bluetooth] Use R1 for default value of pscan_rep_mode
  o [Bluetooth] Respond correctly to RLS packets
  o [Bluetooth] Fix L2CAP binding to local address
  o [Bluetooth] Correction of the HCI USB driver description

Matthew Wilcox:
  o fix iomem_resource

Michael Hunold:
  o Fix mxb.c stack usage

Mike Anderson:
  o 2.5.67+ scsi_release_request call queue next

Muli Ben-Yehuda:
  o [NETFILTER]: ip_queue memory leaks

Nathan Scott:
  o [XFS] UUID cleanup - remove unused functions, create a decent table
    abstraction and make the mount code simpler in the process.
  o [XFS] Fix build for big endian platforms; make
    xfs_xlate_dinode_core consistent
  o [XFS] Add a validity check for unwritten extents, trying to trap a
    problem
  o [XFS] Fix compile for Alpha architecture

Neil Brown:
  o Update umem to new request_irq interface
  o Update umem driver for newer cards

Nivedita Singhvi:
  o [AF_UNIX]: Fix max_dgram_qlen procfs permissions

Oliver Neukum:
  o add DC395 SCSI driver

Patrick Mansfield:
  o fix ppa locking and oops
  o scsi-misc-2.5 fix repeat_inquiry bflags setting
  o scsi-misc-2.5 remove scsi_scan.c EVPD code

Patrick McHardy:
  o [NETFILTER]: Multiple ipt_REJECT fixes

Paul Fulghum:
  o synclink update
  o synclinkmp update
  o synclink_cs update
  o n_hdlc update
  o Added new PCI ID
  o pci.ids update

Paul Mackerras:
  o PPC32: Change interrupt handlers to return irqreturn_t
  o PPC32: Reduce __MAX_NDELAY a little to avoid compiler warnings
  o drivers/macintosh irq handler type
  o PPC32: Move xmon declarations to their own header file
  o [PPP]: Module owners for ppp compressors

Pavel Machek:
  o Fix SWSUSP & !SWAP
  o ioctl32 cleanups
  o ioctl32: leftovers

Pavel Roskin:
  o [PCMCIA] Fix compilation of cardmgr
  o [PCMCIA] Fix oops in validate_mem when CONFIG_PCMCIA_PROBE=n

Pete Zaitcev:
  o [SPARC]: Colin Gibbs gcc-3.x support
  o [SPARC]: Openprom drivers needs linux/fs.h
  o [SPARC]: The iommu rewrite

Randy Dunlap:
  o replace URLs in Kconfig
  o [IPV6]: Per-interfave icmpv6 statistics support
  o sidewinder: reduce stack usage
  o uinput.c: reduce stack usage

Richard Henderson:
  o Fix unwind info for sysenter entry point

Rik van Riel:
  o [wireless airo] make end-of-array test more portable

Rob Radez:
  o [SPARC]: Kill initialize_secondary, unused

Robert Love:
  o trivial task_prio() fix

Robert Olsson:
  o [NET]: Remove skb_head_pool

Roland McGrath:
  o i386 vsyscall DSO implementation
  o Fix the DSO patch
  o allow ptrace and /proc/PID/mem to read fixmap pages

Russell Cattelan:
  o [XFS] Whitespace cleanup Merge whitespace cleanup to 2.5 tree
  o [XFS] Rework the way xfs includes xfs_<blah>.h headers

Russell King:
  o [ARM] NWFPE 1: Convert instruction decoding from switch() to table
  o [ARM] NWFPE 2: Take advantage of the CPDO functions behaviour
  o [ARM] NWFPE 3: Eliminate setting of fType in CPDO worker functions
  o [ARM] NWFPE 4: Eliminate getFd from CPDO worker functions
  o [ARM] NWFPE 5: Eliminate use of Fd
  o [NWFPE] Clean up indentation in assembly files
  o [PCMCIA] Don't cache CIS bytes found to be invalid
  o [PCMCIA] Make cb_release_cis_mem() local to cardbus.c
  o [ARM] Fix two makefile problems
  o [ARM] Bypass cache cleaning if cache/mmu was disabled
  o [ARM] Fix another case of looking at task_struct instead of
    thread_info
  o [ARM] Provide more early command line parsing
  o [ARM] lock up() functions should be memory barriers
  o [ARM] Ensure gcc does not assume asm() is conditional
  o [ARM] Fix integrator cpufreq build errors
  o [ARM] Fix includes
  o [ARM] Make tlb_start_vma() flush the cache
  o [ARM] Inline PMD entry cache handling
  o [ARM] Clean up ARM cache handling interfaces (part 1)
  o [ARM] Part 2 in the cache API changes
  o [ARM] Remove check_bugs()
  o [ARM] set_pgd is confusing; rename it switch_mm
  o [ARM] Clean up nwfpe makefile
  o [ARM] Don't allow FPE modules to be built as a module
  o [ARM] Remove unused msleep() function in h3600.c
  o [ARM] Switch to SVC mode using read/modify/write
  o [ARM] Fix a collection of missed changes from cache API changes
  o [ARM] Fix elf_fpregset_t
  o [ARM] Update mach-types to latest version

Rusty Russell:
  o [NETFILTER]: Add owner field to nf_hook_ops
  o complete modinfo section
  o __module_get

Scott Feldman:
  o [netdrvr e1000] mark e1000 NAPI feature not-experimental
  o [netdrvr e1000] add a bit of source cross-version compat

Shachar Shemesh:
  o Fix IRDA irq handler prototype

Stephen Hemminger:
  o [BRIDGE]: New maintainership
  o [BRIDGE]: Missing unlocks in ioctl error paths
  o [BRIDGE]: Bridge confuses kernel user HZ
  o [BRIDGE]: Get write lock in config PDU processing
  o [BRIDGE]: Possible race with timer on shutdown
  o [BRIDGE]: Use list macros for ports
  o [BRIDGE]: Use RCU for port table
  o [BRIDGE]: Use C99 initializers for netfilter bridge
  o [NETFILTER]: Use Read Copy Update
  o [BRIDGE]: Inline and _rcu change
  o [BRIDGE}: More user hz conversions
  o Replace br_lock() in snap with Read Copy Update
  o [BRIDGE}: Change bridge forwarding table to use hlist

Stephen Lord:
  o [XFS] Rework the remount path to better seperate the linux vfs
    portion and the xfs portion of it. Move the code to more
    appropriate places in the tree.
  o [XFS] Fix a use after free in the unwritten extent code. Also
    rework the interface to the allocator to have its own flag set, and
    always go through the same interface in all cases rather than
    having unwritten extent requests take a different path from all
    others.
  o [XFS] report extended attribute existence in the xattr flags field

Steve French:
  o Add resume key support for readdir to workaround Windows 2000 and
    XP server problem.  Update oplock handling code.  Reduce excessive
    stack usage in  link.c
  o fix readdir on empty directories to only issue one network search
  o Unload nls if mount fails
  o fix hang in truncate setting file size
  o Fix delete of files with readonly attribute. Reflect setting of
    readonly dos attribute in mode when server does not support CIFS
    Unix extensions.  Fix abbreviated readdir to servers that do
    support CIFS Unix extensions.

Steven Cole:
  o [ARM] spelling fixes for arm
  o [SPARC64]: Spelling fixes
  o Avast there ye swabs, prepare to fire a broadside!

Steven Whitehouse:
  o [IP_GRE]: Kill duplicate update_pmtu call

Tom Rini:
  o PPC32: Correct BASE_BAUD on IBM Redwood platforms


