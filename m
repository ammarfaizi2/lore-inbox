Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTIHUdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIHUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:33:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:11497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263617AbTIHUc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:32:28 -0400
Date: Mon, 8 Sep 2003 13:32:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test5
Message-ID: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of small stuff, as usual. I think the biggest "core" change is the 
Futex changes by Jamie and Hugh, and the dev_t preparations by Al Viro. 

But there are ARM and ppc updates here too, and a few drivers have bigger
fixes (tg3 driver and the USB gadget interface stand out on diffstat).  
Watchdog driver updates etc. And Russell King fixed more PCMCIA issues.

		Linus

---


Summary of changes from v2.6.0-test4 to v2.6.0-test5
============================================

Adrian Bunk:
  o [netdrvr sis190] fix build with older gcc
  o [NET]: Fix bpqether build with procfs disabled
  o Mark more drivers BROKEN{,ON_SMP}
  o [wireless airo] fix build with gcc 2.95
  o COSA is no longer BROKEN

Alan Stern:
  o USB: root hub polling stops after suspend
  o USB: Another unusual_devs.h entry update
  o USB: storage: Revised update to isd200 I/O buffer patch

Alex Williamson:
  o ia64: no discontig w/o NUMA

Alexander Viro:
  o dev_t handling cleanups (1-12)
  o large dev_t - second series (1-15)

Andi Kleen:
  o IOMMU overflow handling fix for MPT fusion
  o Make ACPI_SLEEP select SOFTWARE_SUSPEND
  o Do 32bit addresses in /proc/self/maps if possible
  o x86-64 update
  o x86-64 update

Andrew Morton:
  o .config checks updated
  o random: SMP locking
  o random: accounting and sleeping fixes
  o disable prefetch on athlons
  o fix /proc/pid/fd ownership across setuid()
  o Call security hook from pid*_revalidate
  o move DAC960 GAM IOCTLs into a new device
  o Add the kernel janitors to MAINTAINERS
  o Update ide.txt documentation to current ide.c
  o v4l use-after-free fix
  o ikconfig - Makefile update
  o Fix ftape warning
  o jffs aops return type fix
  o Add 3GB personality
  o zeromap_pmd_range bugfix
  o don't report async write errors on close() after all
  o remove add_wait_queue_cond()
  o spin_lock_irqrestore() typo fixes
  o zoran: memleak fixes
  o zoran: debug->zr_debug
  o zoran: add release callback
  o zoran: add pci_disable_device() call
  o zoran: cleanups
  o zoran: more cleanups
  o zoran: correct name field breakage
  o airo CONFIG_PCI=n build fix
  o drivers/char/pcxx.c warning fix
  o pcnet32 needs unregister_pci
  o c99 struct initialiser conversions
  o Fix 'pci=noacpi' with buggy ACPI BIOSes
  o /proc/kallsym caching fix
  o Fix permissions on /proc/kallsyms
  o Kobject doc addition
  o vm_enough_memory microoptimisation
  o abi doc update
  o ni5010.c: remove cli/sti
  o do_no_page() fix
  o parport_pc rmmod oops fix
  o reiserfs writepage-versus-truncate fix
  o visws: fix 2.6.0-test4 breakage
  o Fix ext3 htree corruption on big-endian platforms
  o Fix selinux_file_fcntl
  o Fix SELinux avtab
  o Fix SELinux format specifiers
  o Rework SELinux binprm hooks
  o Fix typo in #ifdef for ext2 xattr support
  o Add more bad_inode operations
  o Fix build with CONFIG_KCORE_AOUT
  o kill CONFIG_KCORE_AOUT
  o knfsd nfs4 warning fixes
  o Fix bluetooth compile warnings
  o do_no_page() rss accounting fix
  o jbd: remove uninformative printk
  o acpi pci_link fix
  o add context switch counters
  o remove size_t-based printk warnings
  o large dev_t 12/12 oops fix
  o evdev_ioctl does not report EV_MSC capabilities
  o AS: don't anticipate against a task's initial I/O
  o hch has moved
  o Cyclades ISA serial driver fix
  o kbuild: warn if the user has old modutils
  o fix arcnet printk parameter types
  o floppy driver cleanup
  o Use tgid rather than pid in dnotify
  o Fix a few declarations
  o make voyager work again after the cpumask_t changes
  o mtrr cleanups
  o compat ioctl_table fix
  o raw driver oops fix
  o ipc_init() uses vmalloc too early
  o vmscan: zone pressure calculation fix
  o vmscan: zone pressure simplification and fix
  o Remove SSE2 bugs.h check
  o HPET 1/6: Support for HPET based timer
  o HPET 3/6: makefile and config changes
  o HPET 4/6: Core
  o HPET 5/6: timer services
  o HPET 6/6: rtc emulation
  o HPET 2/6: boot parsing
  o fix advansys.c if !CONFIG_PROC_FS
  o handle setup_swap_extents() error in swapon
  o scsi_unregister() oops fix
  o tty oops fix
  o ext3_setxattr() oops fix
  o Add documentation for /proc/stat
  o [NET]: Fix 64-bit warnings in af_netlink.c
  o misc fixes
  o Fix odd code in bio_add_page
  o convert /proc/stat to seq_file
  o Fix rtc symbol clash and HPET config problems
  o add config option for qla1280 SCSI MMIO/ioport
  o elevator insertion fixes
  o 8250_acpi taints kernel
  o proc_misc.c needs irq.h
  o more slab page checking
  o might_sleep() improvements
  o MODULE_ALIAS() in block devices
  o MODULE_ALIAS() in char devices
  o Remove percpufication of in_flight counter in
  o Enable SELinux via boot parameter
  o devfs pty fix
  o i8042 free_irq() aliasing fix
  o Remove Documentation/kmod.txt
  o drivers/scsi/imm.c build fix
  o hermes.h fails with outw_p() in :?
  o cciss error handling cleanup
  o MODULE_ALIAS for tty ldisc
  o fix /proc/stat handler for ARM, SPARC64, others
  o Fix /proc/stat off-by-one

Andries E. Brouwer:
  o more keyboard stuff

Andy Molloy:
  o USB: Aten 4 Port USB 2.0 KVM C (ACS-1724)

Anton Blanchard:
  o sym2 hotplug fix

Arjan van de Ven:
  o incomplete asm constraints in arch/i386/pci/pcbios.c

Arnaldo Carvalho de Melo:
  o cyc2x: sanitize ioremap usage & more
  o scsi: remove include procfs_h from hosts.h
  o scsi cleanups

Arnd Bergmann:
  o Verify proper usage of ioctl macros

Arun Sharma:
  o ia64: fix ia32 execve memory leak

Bart De Schuymer:
  o [BRIDGE]: Add arpreply EBTABLES target
  o [BRIDGING]: Update Kconfig files for bridging firewall
  o [BRIDGE]: Add 802.3 filtering support
  o [BRIDGE]: Create CONFIG_BRIDGE_NETFILTER and use it instead of
    messy tests
  o [NETFILTER]: Use CONFIG_BRIDGE_NETFILTER in ipt_REJECT.c

Bartlomiej Zolnierkiewicz:
  o cable detection fixes for HPT37x controllers
  o fix PowerMac driver breakage caused by recent dynamic queue change
  o fix ide.c warning when compiling IDE for non-PCI systems
  o fix ide-lib.c warning when compiling IDE without DMA support
  o allow drivers (ie. mediabay) to set hwif->gendev.parent
  o kill ide_modes.h
  o do not set drive->dn twice in probe_hwif()
  o kill ide_init_drive() in ide-probe.c
  o remove unused exports from ide-probe.c
  o remove unused ide_chipsets and IDE_CHIPSET_MODULE
  o kill ide_module_t
  o kill ide_register()
  o ide: fix ide_unregister() vs. driver model
  o ide: forward-port siimage driver changes from 2.4.22
  o ide: allow LBA48 on Promise 20265
  o ide: add very basic support for VIA 8237 SATA controller
  o ide: enable LED support for PowerMac
  o ide: fix PM with ide-default driver
  o ide: remove supports_dma field from ide_driver_t
  o ide: fix ide_cs oops with TCQ
  o ide: fix imbalance preempt count with taskfile PIO

Ben Collins:
  o Update IEEE1394 (r1047)
  o Fix compile for raw1394

Benjamin Herrenschmidt:
  o cputable.c
  o Add new OF tree walking APIs
  o Update OF platform & macio driver cores to adapt to device model
    changes. Fix refcounting
  o Update openpic to expose a sys_dev for power management, make it
    more robust vs. concurrent calls by the PM system and cpufreq
  o Update pmac PIC driver to register a sysdev for Power Management
  o Major update via-pmu driver, hopefully last before we split it & do
    major cleanup
  o Update PowerMac IDE driver. Adapt to new driver model, add proper
    support for Kauai ATA/100 and add activity led code.
  o Adapt PowerMac i2c-keywest driver to new driver model
  o Fix PowerMac ALSA build with device model "name" field change
  o Update PowerMac mediabay driver to new model, fix an old bug that
    could prevent one of the timeouts from working, fix access to MMIO
    based interface
  o Adapt PowerMac "airport" driver to new driver model
  o Fix build of controlfb driver
  o Adapt PowerMac "platinum" video driver to new driver model
  o fixup xmon ADB polling so that it works before ADB core is loaded
  o Add back missing fb_set_var to PowerMac platinum driver
  o Update PowerMac cpufreq driver to adapt it to some core changes and
    fix a race with the PMU driver
  o For keeping interface ordering consistent between previous kernels
    and the new driver model probing mecanism, drivers/macintosh has to
    be linked before ide and scsi
  o Don't care about driver registration results for i2c-keywest so
    failing one don't break the other
  o Fix drivers/video Makefile so control & platinum drivers gets
    proper depedencies on the cfb* files
  o Add new pmac_zilog serial driver, obsolete old macserial
  o Update "coff" zImage wrapper so it works with larger kernel images
  o Fix missing bit in the new .coff wrapper
  o some whitespace & tab fixes
  o Fix a bug where an ide-pmac hwif returned to the system because
    it's empty would still be probed thus causing a crash on some
    machines. Also fix some whitespace/tabs.
  o Add & export some routines to access the i2c busses that hang off
    the PMU, not yet linked to the linux i2c subsystem though. Fix some
    whitespace/tabs too.
  o C99 initializer fixes
  o Remove useless junk at beginning of MachineCheck exception handler,
    this actually is causing problems on some CPUs
  o PowerMac: Fix build of via-pmu driver with some .config's

CaT:
  o USB: C99: 2.6.0-t3-bk7/Documentation

Chas Williams:
  o [ATM]: Clean up the code making use of sti/cli (from
    vinay-rc@naturesoft.net)
  o [ATM]: In ambassador driver, use del_timer_sync instead
  o [ATM]: In atm_getaddr() do not copy_to_user() with locks held
  o [ATM]: Convert the /proc/net/atm/br2684 to seq_file interface (from
    shemminger@osdl.org)
  o [ATM]: pvc/svc missing .owner for proto_ops/family (from
    levon@movementarian.org)
  o [ATM]: fix atm_dev module refcount bug (from
    levon@movementarian.org)
  o [ATM]: reduce CONFIG_PROC_FS #ifdef clutter in .c code (from
    levon@movementarian.org)

Christoph Hellwig:
  o make scsi_priv.h includable standalone
  o make scsi logging level a sysctl
  o make /proc/scsi/scsi/ support optional
  o don't export proc_scsi
  o add a missing extern to scsi_priv.h
  o serialize bus scanning
  o fixup some tagged queuing mess
  o give scsi_allocate_request a gfp_mask
  o kill an unused variable in sym2
  o kill some dead code in sym2
  o check whether a disk got writeable in sd_open
  o [IPV6]: Use per-cpu data for icmp sockets
  o [NET]: Convert netdev_rx_stat to per-cpu data
  o [NET]: Remove reference to CONFIG_IA64_SGI_SN1, it is gone
  o fix the scsi_logging_level fix

Daniel Ritz:
  o [PCMCIA] Add ToPIC97 and ToPIC100 support

Daniele Bellucci:
  o USB: Audit usb_register/usb_serial_register under divers/usb/serial
  o USB: CREDITS file update
  o Audit and minor cleanups in drivers/usb/*
  o ...more usb audit
  o Another bad usb_register audit: dvb-ttusb-budget
  o Another bad audit in drivers/usb/*: usblp
  o Another bad audit in drivers/usb/*: cdc-acm
  o Another bad audit in drivers/usb/*: usbskeleton
  o Audit and minor cleanups in usbnet
  o Audit and minor cleanups in usbstorage

Dave Jones:
  o [AGPGART] Fix up ATI's identity crisis
  o [DRM] Update MAINTAINERS
  o [AGPGART] Update VIA PCI IDs
  o [AGPGART] Numerous AMD64 gart driver cleanups
  o [AGPGART] Fix indentation
  o [AGPGART] Use generic AGP_APBASE define instead of per vendor
    _APBASE
  o [AGPGART] move NVIDIA registers to agp.h
  o [AGPGART] Indentation fixes
  o [AGPGART] Fix missed AGP_APBASE conversion in VIA AGP driver
  o [AGPGART] Remove unneeded 8151 defines
  o [AGPGART] Make AMD64 GART driver marchitecture compliant
  o [AGPGART] Various renames for AMD64 GART driver
  o [CPUFREQ] Move kernel/cpufreq.c to drivers/cpufreq/cpufreq.c Also
    remove $Id$ tag.
  o [CPUFREQ] fix up two typos
  o [CPUFREQ] Move drivers/cpufreq/userspace.c to
    drivers/cpufreq/cpufreq_userspace.c Module names of 'userspace'
    aren't very informative.
  o [CPUFREQ] Fix various oddities in the userspace governer
  o [CPUFREQ] Completely separate governors from policies
  o [CPUFREQ] Add the "performance" and "powersave" governors as
    modules
  o [CPUFREQ][PPC] Small fixes necessary to separate the governors from
    policies
  o [CPUFREQ][SH] Small fixes necessary to separate the governors from
    policies
  o [CPUFREQ][SPARC64] Small fixes necessary to separate the governors
    from policies
  o [CPUFREQ][X86] Small fixes necessary to separate the governors from
    policies
  o [CPUFREQ][ARM] allow for easier Kconfig usage on ARM, and more
    features for SA11x0 users
  o [CPUFREQ] Fix incorrect entry in Kconfig
  o [CPUFREQ] new cpufreq_driver->resume callback, needed (at least)
    for speedstep-smi
  o [CPUFREQ] fix speedstep-ich's .name to reflect its real name
  o [CPUFREQ] Inform user about broken powernow-k7 PST tables
  o [AGPGART] Fix up compile for i460-agp Missed conversion when
    killing off the APBASE defines.
  o [CPUFREQ] Cache FSB in longhaul driver
  o [CPUFREQ] Fix use of fsb before initialisation in longhaul
  o [CPUFREQ] Fix longhaul's mult,fsb -> MHz conversions
  o [CPUFREQ] Clean up clock_ratio calculation
  o [CPUFREQ] Inform user of status of Ezra-T/Nehemiah longhaul support
  o [CPUFREQ] Remove the voltage scaling from longhaul driver
  o [CPUFREQ] Move longhaul scale/ratio tables to longhaul header file
  o [CPUFREQ] Print out FSB in longhaul debug info
  o [CPUFREQ] Print out CPU name in debug info
  o [AGPGART] Remove unneeded string from AMD64 GART driver
  o [AGPGART] Fix up missing brackets on defines

Dave Kleikamp:
  o New version of jfsutils needed

David Brownell:
  o USB: usb_sg_cancel() + disconnect, fewer messages
  o USB: Add Kconfig option for building ax8817x support in usbnet
  o USB: usb_new_device() shouldn't be exported
  o USB: <linux/usb_gadget.h> minor doc updates
  o USB: usbnet minor cleanup
  o USB: net2280 fixes: ep halt, sysfs
  o USB: usbnet, cdc ethernet descriptor parsing fixes
  o USB: ohci -- reset, fault recovery
  o USB: uhci-hcd, add uhci_reset()
  o USB: net2280, patch dma chains
  o USB: net2280 one-liner
  o USB: usb hcd states
  o USB: usb "gadgetfs" (1/2)
  o USB: usb "gadgetfs" (2/2)
  o USB: usb_epnum_to_ep_desc only look

David Jeffery:
  o ips: remove arch limitations

David Mosberger:
  o ia64: Manual merge with Alex's "UP cmc/cpe polling fix" patch
  o ia64: Use offset_in_page() instead of equivalent open code
  o ia64: Hook up fadvise64_64() system call
  o ia64: The second chunk of the "UP cmc/cpe polling fix" seems to
    have gotten lost.  Please apply the attached for the cpe side of
    the fix.
  o ia64: Fix usage ("corrected" machine checks and platform errors,
    not "correctable").

David S. Miller:
  o [TG3]: Initial implementation of 5705 support
  o [TG3]: Fix statistics on 5705
  o [TG3]: Do not reset the RX_MAC unless PHY is Serdes
  o [TG3]: More missing PCI IDs
  o [TG3]: Reset PHY more reliably on 570{3,4,5} chips
  o [TG3]: Fix 5788/5901, update TSO code
  o [TG3]: Differentiate between TSO capable and TSO enabled
  o [ETHTOOL]: Add {G,S}TSO support to ethtool_ops
  o [TG3]: Add {get,set}_tso ethtool_ops support
  o [TG3]: Bump version/reldate
  o [TG3]: Fix tg3_phy_reset_5703_4_5 chip rev test
  o [TG3]: Bump version/reldate
  o [ETHTOOL]: Add ethtool_op_{set,get}_tso helpers
  o [TG3]: More fixes and enhancements
  o [SPARC64]: Add some missing PCI error reporting
  o [SPARC]: Update ethtool support in Sun net drivers
  o [NETFILTER]: Use correct printf format for size_t in ipt_CLASSIFY.c
  o [NET]: net/core/ethtool.c needs asm/uaccess.h
  o [TG3]: Fix ethtool_ops/sun_5704 changes collision
  o [TG3]: Protect get/set TSO support with proper ifdefs
  o [SPARC]: Add missing timer_create syscall entries
  o [SPARC64]: Make sure init_irqwork_curcpu() is called with PSTATE_IE
    off
  o [IPV6]: Do not mistakedly use ndisc route for normal ipv6 output
  o [POSIX_TIMERS]: Do not assume timeval/timespec layout is identical
  o [SPARC64]: In sysv IPC translation, mask out IPC_64 as appropriate
  o [SPARC]: Mark get_rtc_time() static in SBUS rtc driver
  o [IPV6]: Do not BUG() on icmp6 socket contention, just drop
  o [IPV6]: Fix typo in icmp BUG() fix
  o [IPV6]: Fix types in fl6_renew()
  o [IPV6]: linger member of ip6_flowlabel needs to be a long
  o [IPV6]: Fix printf format in ip6fl_fl_seq_show
  o [BLUETOOTH]: Fix typo in module alias changes
  o [IPV4]: Do not BUG() on icmp_xmit_lock() contention, just drop
  o [NET]: Kill NET_PROFILE, has not built for years
  o [USB]: hiddev_exit() can no longer be __exit, called from init code
    now
  o [SPARC]: Add MODULE_ALIAS_LDISC() defines
  o [NET]: Do not ifdef declarations in Space.c
  o [NET]: Remove all the silly 'NET4.x' init messages
  o [NET]: Print a KERN_INFO msg when protocol families are
    {un,}registered
  o [NET]: Kill more verbose init msgs and unused RTNL_DEBUG define

David T. Hollis:
  o USB: Add ax8817x support to usbnet
  o USB: Fix building of ax8817x if CONFIG_USB_AX8817X_STANDALONE

Deepak Saxena:
  o [ARM PATCH] 1611/1: Add big-endian support to AFLAGS
  o [ARM PATCH] 1615/1: Fix IOP3xx timer interrupts
  o [ARM PATCH] 1613/1: arch/arm/boot/Makefile fixups for IOP3xx and
    ADIFCC
  o [ARM PATCH] 1616/1: Add PFN_TO_NID to IOP3xx
  o [ARM PATCH] 1621/1: IOP3xx CPU detection (cleaned up)
  o [ARM PATCH] 1623/1: Updated def-configs for IQ80310/321
  o [ARM PATCH] 1620/1: dma_map_single/unmap_single support for ARM
  o [ARM PATCH] 1559/1: updated include/asm-arm/checksum.h big-endian
    support

Douglas Gilbert:
  o GFDL issue in Documentation/DocBook/scsidrivers.tmpl

Duncan Sands:
  o USB: fix uhci "host controller process error"

Erik Andersen:
  o Fix cdrom error handling in 2.6

Ernst Persson:
  o [netdrvr] list CONFIG_BMAC in drivers/net/Makefile.lib, as it uses
    the crc32 library.

Felipe Damasio:
  o [NETFILTER]: Remove unneeded version.h inclusion
  o [SUNRPC]: Remove unneeded version.h inclusion
  o [RXRPC]: Remove unneeded version.h inclusion
  o [IPV6]: Remove unnecessary linux/version.h include

Frank Becker:
  o [ARM PATCH] 1563/1: Update pxa-regs.h with correct gpio number for
    48 MHz clock output

François Romieu:
  o [netdrvr sis190] pass irq argument to synchronize_irq()
  o [netdrvr sis190] remove unneeded alignment code, other small fixes
  o [netdrvr sis190] use PCI DMA API for RX buffers
  o sis190 driver fix
  o [NET]: Balance alloc_netdev() with free_netdev() in ethertap
  o [NET]: Use free_netdev() even in error paths

Gary Algier:
  o USB: new ids for io_ti driver

Geert Uytterhoeven:
  o vmlinux-*.lds (was: Re: Linux 2.6.0-test4)
  o macide (was: Re: Linux 2.6.0-test4)
  o m68k asm/sections.h
  o m68k asm/local.h
  o Amiga z2ram
  o Amiga floppy
  o M68k switch_to
  o Atari floppy
  o dmasound core fixes
  o dmasound kill MOD_{IN,DE}C_USE_COUNT

Greg Kroah-Hartman:
  o USB: remove #include <linux/miscdevice.h> from some usb drivers
  o USB: change pci host drivers to use PCI_DEVICE_CLASS() macro
  o USB: remove proc code from stv680 driver as it's no longer needed
  o USB: convert stv680 driver to handle the driver core changes in the
    v4l layer
  o USB: add sysfs files for stv680 driver, replacing the lost proc
    functionality
  o V4L: fix use after free bug in v4l core
  o V4L: add video_device_remove_file() to match
    video_device_create_file()
  o [netdrvr sis900] don't call pci_find_device from irq context
  o USB: fix compiler warning in mdc800 driver
  o USB: fix up a bunch of copyrights that were incorrectly declared
  o USB: hook up the USB driver core to the power management calls of
    the driver model
  o USB: rip out old proc code from the usbvideo driver
  o USB: removed the proc code from the se401.c driver
  o USB: add support for 2 new devices to the visor driver
  o USB: fix usbnet for older versions of gcc
  o USB: fix oops in keyspan and whiteheat devices when plugged in
  o USB: remove usage of DEVICE_ID_SIZE from usb core as it should not
    be used
  o USB: fix data toggle problem for pl2303 driver
  o USB: fix up B0 support in the pl2303 driver

Greg Ungerer:
  o use irqreturn_t in m68knommu/5206 config.c
  o use irqreturn_t in m68knommu/5206e config.c
  o use irqreturn_t in m68knommu/5249 config.c
  o use irqreturn_t in m68knommu/5272 config.c
  o irqreturn_t fixes for m68knommu irq.h
  o create an m68knommu local.h
  o create an m68knommu sections.h

Guillaume Morin:
  o fix cu3088 group write

Harald Welte:
  o [NETFILTER]: Fix ipt_REJECT if used on bridge
  o [NETFILTER]: Remove ipt_MIRROR target from 2.6.x
  o [NETFILTER]: Remove ipt_unclean match from 2.6.x
  o [NETFILTER]: Remove EXPERIMENTAL mark from some netfilter stuff
  o [NETFILTER]: Cosmetic netfilter patch
  o [NETFILTER]: NAT optimization
  o [NETFILTER]: Conntrack optimization (LIST_DELETE)
  o [NETFILTER]: New iptables modules (iprange, CLASSIFY, SAME, NETMAP)
  o [NETFILTER]: Fix ipt_helper build problem wrt. Kconfig
  o [NETFILTER]: Fix email address in MODULE_AUTHOR
  o [NETFILTER]: NAT range calculation fix

Herbert Xu:
  o free_netdev typo
  o [NET]: Add MODULE_LICENSE to xfrm_user.c

Hideaki Yoshifuji:
  o [NET]: Fix OOPS in multicast procfs usage
  o [IPV{4,6}]: Fixing a bug that reading /proc/net/{udp,udp6} may drop
    some data

Hirofumi Ogawa:
  o [netdrvr 8139too] lwake unlock fix
  o [netdrvr 8139too] remove unused RxConfigMask
  o [netdrvr 8139too] add more h/w revision ids
  o [netdrvr 8139too] remove driver-based poisoning of net_device
  o [netdrvr 8139too] don't start thread when it's not needed
  o vfat_valid_longname() cleanup

Holger Freyther:
  o [ARM PATCH] 1595/1: [PATCH] 1/10 Simpad changes
  o [ARM PATCH] 1598/1: [PATCH] 4/10 Simpad changes
  o [ARM PATCH] 1603/1: [PATCH] 9/10 Simpad changes

Hugh Dickins:
  o Fix futex hashing bugs

Ian Abbott:
  o USB: ftdi_sio - fix memory leak and tidy up write bulk callback

Ian Molton:
  o arm26 updates

Jakub Jelínek:
  o [COMPAT]: Add missing set_fs() calls to {clock,timer}_*() handlers
  o [SPARC64]: Fix struct sigevent32
  o [SPARC64]: sys_timer_create needs 32-bit translation
  o [SPARC]: Fix typos

James Bottomley:
  o Fix typo introduced into 53c700 by tag fixup patch
  o Add extern for scsi_logging_level so scsi_sysctl.c can compile
  o Fix up scsi_alloc_request in sr.c to take a GFP_ flag
  o fix remap of shared read only mappings

Jamie Lenehan:
  o dc395x [1/6] - make functions static
  o dc395x [2/6] - cleanup devices
  o dc395x [3/6] - cleanup adapter init
  o dc395x [4/6] - cleanup adapter uninit
  o dc395x [5/6] - check for device
  o dc395x [6/6] - use pci resource len

Jamie Lokier:
  o Unpinned futexes v2: indexing changes
  o Common PROT_xxx -> VM_xxx mapping

Javier Achirica:
  o [wireless airo] add support for MIC and latest firmwares
  o [wireless airo] build fix when MIC support is disabled

Jean Tourrilhes:
  o [irda] IrCOMM mod refcount
  o [irda] NSC 3839x probe fixes
  o [irda] irtty cleanup
  o [irda] LAP close race
  o [irda] connect watchdog fixes
  o [irda] init failure cleanups
  o [irda] Dongle module aliases

Jeff Garzik:
  o [TG3]: Bug fixes for 5705 support
  o [TG3]: More 5705 updates
  o [TG3]: More 5705 fixes
  o [TG3]: Another 5705 fix: enable eeprom write prot as needed
  o [TG3]: Only write the on-nic sram addr on non-5705
  o [TG3]: Add 5782 pci id
  o [netdrvr sis900] ethtool_ops support
  o [netdrvr 8139cp] ethtool_ops support
  o [netdrvr sis190] convert TX path to use PCI DMA API
  o [netdrvr sis190] make driver depend on CONFIG_BROKEN
  o [netdrvr 3c501] ethtool_ops support
  o [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507
  o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
  o [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, axnet
  o [netdrvr pcmcia] convert several drivers to ethtool_ops
  o [netdrvr xircom_cb] ethtool_ops support
  o [wireless ray_cs] ethtool_ops support
  o [netdrvr sis190] small bug fixes
  o [TG3]: Remove pci-set-dma-mask casts
  o [netdrvr 8139cp] build TX checksumming code, but default OFF
  o [netdrvr 8139cp] support NAPI on RX path; Ditch RX frag handling
  o [netdrvr 8139cp] update todo list in header
  o [netdrvr 8139cp] remove mentions of RTL8169 (now handled by
    "r8169")
  o [netdrvr 8139cp] small cleanups
  o [netdrvr 8139cp] fix NAPI bug; remove board_type distinction, not
    needed
  o [netdrvr 8139cp] bump version
  o [netdrvr 8139cp] stats improvements and fixes
  o [netdrvr 8139too] make features more persistent; fix PCI DAC mode
  o [netdrvr pcmcia] support SIOC[GS]MII{PHY,REG} ioctls
  o [netdrvr 8139too] remove useless board names
  o [netdrvr 3c509] dev->name removal build fix
  o [netdrvr 8139cp] must call NAPI-specific vlan hook
  o [netdrvr ixgb] must call NAPI-specific vlan hook
  o [netdrvr sk_mca] somebody typo'd in their cli()-to-spinlock
    conversion
  o [netdrvr sk_mca] remove ancient-kernel compat code; fix bugs
  o [netdrvr 8139cp] PCI MWI cleanup; remove unneeded workaround
  o [netdrvr de2104x] ethtool_ops support
  o [PCI] Remove cases where PCI_CACHE_LINE_SIZE is hardcoded
  o [tokenring lanstreamer] clean up MWI / PCI_CACHE_LINE_SIZE usage
  o [video planb] don't hardware pci command/cacheline/latency values,
    use the PCI layer instead to provide those for us.
  o [netdrvr 8390] new function alloc_ei_netdev()
  o [netdrvr ne2k-pci] allocate netdev+8390 struct using new
    alloc_ei_netdev()
  o [netdrvr ne2k-pci] ethtool_ops support
  o [NET] move netif_* helpers from tg3 driver to linux/netdevice.h
  o [netdrvr] ethtool_ops for epic100, fealnx, winbond-840, via-rhine
  o [netdrvr fealnx] merge typo build fix (non-x86) from 2.4
  o [NET] move ethtool_op_set_tx_csum from 8139cp drvr to
    net/core/ethtool.c, where it belongs.
  o [PCI, ia32] don't assume "c->x86 > 6" applies to non-Intel CPUs
    when programming PCI cache line size.
  o [SUNHME]: Fix non-sbus build
  o Fix non-modular compile of 3c515.c
  o [NET]: Fix ethtool_ops thinko in sungem.c

Jens Axboe:
  o cciss init problem
  o software hd led support
  o IO scheduler, not elevator
  o amiflop error handling
  o fix IO hangs
  o Fix noop elevator request merging

John Levon:
  o OProfile: correct CPU type for x86-64
  o [NET]: Kill net/README, obsolete and out-of-date
  o [ATM]: Remove bogus UNUSED macro usage in pppoatm.c

Joris Struyve:
  o unusual_devs.h entry

Jürgen Quade:
  o USB: writing usb driver documentation update
  o USB: usb-skeleton bugfix

Karsten Keil:
  o ISDN bugfixes part 1
  o next fixes

Krishna Kumar:
  o [IPV4]: Fix creat_proc_read_entry() args
  o Remaining task queue to work queue conversion

Linus Torvalds:
  o Input: typo in device matching
  o Don't claim exclusive ownership of the device when doing the SG_IO
    and SCSI_IOCTL_SEND_COMMAND ioctl's. That just screws things up
    when the drive is mounted.
  o Fix del_timer_sync() SMP memory ordering (from Tejun Huh
    <tejun@aratech.co.kr>)
  o Be a lot more careful about TS_USEDFPU and preemption
  o Fix keyboard double E0-sequence release case
  o Add the isicom serial driver to the list of drivers that are broken
    on SMP (due to expecting global irq locking).
  o Instead of asking for "broken drivers", ask for a "clean compile"
  o Avoid a negative in config questions: we don't want to have users
    forced into double negatives.
  o Fix mprotect() to do proper PROT_xxx -> VM_xxx translation
  o Fix PCMCIA typo (extra 'R') that broke the compile
  o Fix over-eager ioctl number fix. _IOC() does want the sizeof()
  o Undo static on ide_probe_for_pdc4030: it can (and will) be called
    from the IDE init code when compiled-in.
  o Mark drivers that can't be built stand-alone in the configuration
    files. 
  o Fix various scripts to be marked executable
  o Fix more ioctl _IOR/_IOW misusage
  o Arnd's new-and-improved _IOx() argument checking showed two sound
    drivers whose microcode load ioctl's used types with sizes that

Marc Zyngier:
  o [netdrvr de4x5] big modernization / cleanup

Marcelo Abreu:
  o [NET]: Remove dead comment from dummy.c driver

Martin Diehl:
  o [IRDA]: vlsi_ir v0.5 update, 1-7

Martin Hicks:
  o ia64: paddr_to_nid fixup

Matthew Dharm:
  o sr.c should issue TEST_UNIT_READY

Matthew Wilcox:
  o ia64: default to building compressed
  o ia64: ia64/lib/Makefile: use call-if-changed
  o [netdrvr 3c59x] ethtool_ops support
  o [ethtool] fix ethtool_get_strings counting bug
  o [netdrvr 8139too] ethtool_ops support
  o bio.c: reduce verbosity at boot
  o ncr & sym1 patches
  o sym2 patchset
  o use size_t for the broken ioctl numbers
  o CONFIG_64BIT

Matthias Bruestle:
  o USB: Cyberjack patch

Maximilian Attems:
  o [NET]: Use list_for_each() where applicable

Michel Dänzer:
  o USB: linuxppc-2.5 fixlets for usbtest.c

Mike Anderson:
  o fix Kernel Panic in scsi_host_dev_release

Miles Bader:
  o Give v850 its own version of the vmlinux.lds.h RODATA macro
  o Properly export symbols that depend on CONFIG_MMU

Mitchell Blank Jr.:
  o [ATM]: Lanai driver updates

Neil Brown:
  o Fix module ref counting for md
  o Honour the read-ahead for for reads in raid5
  o Set max_sectors for raid0 only, not for all raid levels
  o Fix md superblock incompatabilities with 2.4 kernels
  o Track nfsv4 open files by "struct inode" rather than
    dev/ino/generation
  o fix in NFSv4 server for bad sequence id errors
  o Fix compile errors in NFSv4 server

Nicolas Pitre:
  o [ARM PATCH] 1565/1: syscall macros clobbering returned error value

Olaf Hering:
  o USB: io_edgeport.o differences in 2.4 vs. 2.6

Pat LaVarre:
  o USB: storage: cbw/csw trace in order

Patrick Mochel:
  o [sysfs] Fix memory leak
  o [power] Turn off debugging
  o [kobject] Support unlimited name lengths
  o [sysfs] Use kobject_name() when creating directories for kobjects
  o [driver model] Use kobject_set_name() when registering objects
  o [kobject] Don't use kobject->k_name after it's been freed
  o [driver model] Add exports for sys devices
  o [sysfs/kobject] Update documentation

Paul Fulghum:
  o 2.6.0-test4 synclink.c
  o 2.6.0-test4 synclinkmp.c
  o 2.6.0-test4 synclink_cs.c

Paul Mackerras:
  o PPC32: Define MCA_bus__is_a_macro.  From Christoph Hellwig
  o PPC32: Add the fadvise64_64 system call
  o PPC32: Declare cpu_online_map and cpu_possible_map as cpumask_t
  o PPC32: Update some of the example configs
  o PPC32: Add support for the PPC 440 family of embedded processors
  o PPC32: Eliminate one use of struct device name field

Paul Mundt:
  o [netdrvr 8139too] fix and pci ids needed for SH platform

Paul Thompson:
  o [NET]: Fix probing messages in 3c509.c

Pete Zaitcev:
  o [SPARC]: Add pci_{map,unmap}_page()

Randy Dunlap:
  o imm driver needs scsi_unregister()
  o advansys build with ADVANSYS_DEBUG defined
  o ia64: fix printk type warning
  o [SCTP]: Fix printf format string
  o [IPVS]: Fix printf format strings
  o [HAMRADIO]: Missing return statement in yam.c driver
  o USB: fix printk parameter types
  o USB: fix functions to match prototypes
  o label needs statement following it
  o [NET]: remove duplicate #includes in net/
  o [CRYPTO]: remove duplicate #includes in crypto/
  o janitor: remove unneeded version.h #includes
  o janitor: add static to comx
  o janitor: sc520_wdt
  o janitor: oss/ali copy*user fixes
  o janitor: oss/ite8172 copy*user fixes
  o janitor: skfddi copy*user fixes
  o janitor: remove __SMP__
  o janitor: jffs2 add/delete version.h
  o janitor: adfs: add/remove version.h
  o janitor: fix oss/harmony copy*user
  o janitor: cdrom module owner
  o janitor: fix input serport register failure
  o janitor: fix blk_init_queue() comments
  o janitor: fix oss/swarm copy*user
  o janitor: saa7134 pci alloc/free consistent checking
  o janitor: coda delete version.h
  o janitor: oss/au1000 copy*user fixes
  o janitor: fix copy*user in tc/zs
  o janitor: more init/exit cleanups
  o janitor: oss/forte copy*user fixes
  o janitor: paride: better return codes
  o janitor: qla1280 pci alloc/free consistent checking
  o janitor: x86_64/sys_ia32
  o rename make check* targets, add versioncheck
  o jffs2: add linux/version.h as needed

Randy Hron:
  o USB: version.h cleanup 1-4

Rob Radez:
  o [SPARC]: Two build fixes

Russell King:
  o [ARM] Noddy indentation fix for arch/arm/boot/Makefile
  o [ARM] Fix vmlinux linker script
  o [ARM] Remove reference to struct device name element
  o [ARM] Fix device suspend/resume calls
  o [ARM] Fix ecard.c manufacturer and product files
  o [ARM] Tweak the bridge control register for PCI and cardbus bridges
  o [ARM] Remove pci_dev->dev.name in favour of pci_name()
  o [ARM] Remove old binutils compatibility
  o [ARM] Update AMBA suspend/resume model
  o [ARM] Update SA1111 suspend/resume model
  o [ARM] Fix EBSA285 CLOCK_TICK_RATE
  o [PCMCIA] Use #define'd constants in ZV code where possible
  o [PCMCIA] Clean up yenta overrides
  o [PCMCIA] Move socket initialisation to the quirk table
  o [PCMCIA] Add generic and per-controller power management handling
  o [PCMCIA] Move PM restore from socket initialisation
  o [PCMCIA] Put socket initialisation to where it should be
  o [PCMCIA] Move more controllers to the more advanced quirks
  o [PCMCIA] Don't add CIS cache entries on failure
  o [ARM] Remove more 26-bit ARM support
  o [ARM] Remove more reminants of 26-bit ARM support
  o Don't #ifdef prototypes
  o [ARM] arch/arm/kernel/setup.c needs to include asm/cacheflush.h
  o [ARM] Fix wrong cache flush call for ARM1020 CPUs
  o Move MODULE_ALIAS_LDISC to tty_ldisc.h
  o [ARM] Newer binutils want -mcpu=xscale not -mxscale
  o [ARM] Restore preempt count before reporting unbalanced preempt
    count
  o [ARM] Don't read the CPU control reg back - it may be write only
  o [ARM] Fix ARM suspend-to-RAM
  o [ARM] Fix PXA and SA1100 suspend/resume
  o [ARM] Don't sleep in cpufreq code if IRQs are disabled (during
    resume.)
  o [ARM] Kill snprintf formatting warning
  o [PCMCIA] Fix cs.c debugging
  o [PCMCIA] Use "yenta" instead of pci_name() when allocating irq
  o [PCMCIA] Fix race condition causing cards to be incorrectly
    recognised
  o Fixes to allow ARM to build in the standard tree
  o [SERIAL] Make SA11x0 serial driver build

Rusty Russell:
  o [NETFILTER]: Trivial 2.6 tftp conntrack fix
  o [NET]: Use MODULE_ALIAS() in network families
  o [CRYPTO]: Use try_then_request_module()
  o Futex-fd error return fix
  o Modules: Be stricter recognizing init&exit sesections
  o modprobe -q: quieter when modules missing

Sam Ravnborg:
  o kbuild: Do not duplicate A/CFLAGS
  o kbuild: arch/i386/boot*, use kbuild syntax when descending into
    compressed
  o kbuild/ieee1394: Makefile update
  o kbuild/isdn: Defer md5sum calculation until needed
  o kbuild/eisa: Makefile update
  o kbuild: genksyms, add explicit reference to include dir

Sridhar Samudrala:
  o [SCTP] Fix bugs in sysctl set/get of sctp rto parameters
  o [SCTP] draft07 API changes: sctp_getpaddrs(), sctp_getladdrs() now
    return a packed array of sockaddr_in/sockaddr_in6 structures
    instead
  o [SCTP] SCTP_SET_PEER_PRIMARY socket option support. (Kevin Gao)
  o [SCTP] draft07 API changes: sctp_bindx() now takes a packed array
    of sockaddr_in/sockaddr_in6 structures instead of an array of
    sockaddr_storage structures.
  o [SCTP] Convert sctp_param2sockaddr() and sockaddr2sctp_addr() to
    address family specific routines af->from_addr_parm() and
    af->to_addr_param() respectively. 
  o [SCTP] Fix a couple of issues with the call to sctp_ssnmap_new() in
    sctp_process_init().
  o [SCTP] draft 07 API changes: Disable listening when backlog is 0
  o [SCTP] draft 07 API changes: By default, all the event
    notifications are turned off even for one-to-many style sockets.
  o [SCTP] Move a local variable declaration ahead of the function code

Stefan Rompf:
  o [netdrvr 8139too] use mii_check_media lib function, instead of
    homebrew MII bitbanging.

Stelian Pop:
  o sonypi driver update
  o meye driver update
  o reenable CAPTURE button in sonypi
  o meye driver update

Stephen Hemminger:
  o [IPV4]: Route cache /proc interface cleanup
  o [AX25]: Make sure and hold ref to dev
  o [AX25]: Convert to seq_file
  o [LLC]: Need to pskb_may_pull() in fix_up_incoming_skb()
  o [LLC]: Missing sk_set_owner() in llc_sk_alloc
  o [LLC]: Set module owner on /proc/net/llc directory
  o [ECONET]: Missing sk_set_owner()
  o [IPX]: Missing sk_set_owner()
  o [ATM]: Missing sk_set_owner()
  o [AX25/NETROM/ROSE]: Missing sk_set_owner()
  o [IRDA]: Missing sk_set_owner()
  o [DDP]: Missing sk_set_owner()
  o [DDP]: Invert logic for clarity
  o [ATALK]: Fix whitespace in /proc/net/atalk/interfaces header
  o [ATALK]: AARP ->last_sent field never set
  o [ATALK]: Purge AARP table on module unload
  o [ATALK]: AARP needs to use del_timer_sync()
  o [ATALK]: Convert AARP over to seq_file
  o [ATALK]: Set owner on /proc/net/atalk directory
  o [DDP]: Fix obsolete comment about module handling
  o [DDP]: Fix oops in aecho socket handling
  o [ATALK]: Move aarp procfs file into atalk subdirectory
  o [DDP]: Missing netdev refcounting
  o [DDP]: Convert to new protocol interface
  o [BLUETOOTH]: Missing sk_set_owner()
  o [NET]: Convert af_netlink.c over to seq_file
  o [NET]: ethertap fixes
  o [NET]: DLCI driver cleanups for 2.6.x
  o [NET]: Add probe_old_netdevs() hook
  o [NET]: Convert SDLA to new initialization
  o [NET]: Convert cops over to new initialization
  o [NET]: Convert ether probes to probe_old_netdevs()
  o [NET]: Convert tr probes to probe_old_netdevs()
  o [NET]: Convert sbni initialization
  o [NET]: Loopback device simplification
  o [NET]: Convert ltpc to new initialization
  o ikconfig - cleanups
  o [NET]: Convert /proc/net/unix to seq_file
  o [NET]: COSA driver fixes
  o [NET]: More SDLS fixes
  o sdla non-module build fix

Steve French:
  o Fix scheduling while atomic problem in getting attributes of newly
    created file.  Fix truncate of existing file when O_CREAT but not
    O_TRUNC specified
  o Fix oops in reconnection logic when no dentry for file being
    reconnected
  o Match smb pid to current->tgid
  o update change log for 0.9.1 cifs vfs
  o Return error correctly on revalidate so dentry will be dropped
  o fix bad return code mapping when server lacks hard link support

Tom Rini:
  o PPC32: Update the Motorola MCP(n) 765 support code
  o PPC32: Cleanup arch/ppc/boot/simple/Makefile
  o PPC32: Fix a warning in the boot serial code
  o PPC32: Allow for hooks into the bootwrapper
  o PPC32: Fix udelay in the PPC boot code for non-16.6 MHz timebases
  o PPC32: Minor fixups to the Motorola Sandpoint platform
  o PPC32: Export flush_tlb_page
  o PPC32: Fix a warning in the 'mktree' boot util
  o PPC32: A number of minor KGDB fixes and tweaks
  o PPC32: Add Magic SysRq support to the MPC8260 platforms
  o PPC32: Change the default behavior of a kernel with KGDB
  o PPC32: Fix KGDB and userland GDB interactions

Ulrich Drepper:
  o [NET]: Check tgid not pid in scm_check_creds()
  o More ->pid to ->tgid changes

Ville Nuorvala:
  o [IPV6]: Fix two bugs in ip6_tunnel.c ICMP error handling
  o [IPV6]: Use free_netdev as ip6_tunnel device destructor
  o [IPV6]: Set dev->{dev_addr,broadcast} in ip6_tnls
  o [IPV6]: Remove sockets from ip6_tunnel.c

Vinay K. Nallamothu:
  o vx_entry.c: remove release timer
  o [NET]: Fix 'spin_lock_irqrestore' typos in sk_mca.c
  o [NET]: Fix MCA device name handling in 3c509.c
  o USB: digi_acceleport.c: typo fix
  o pcmciamtd.c: remove release timer
  o [IPV6]: Fix timer handling in ip6_flowlabel.c

Wim Van Sebroeck:
  o [WATCHDOG] advantechwdt.c - patch
  o [WATCHDOG] wafer5823wdt.c - patch
  o [WATCHDOG] wafer5823wdt.c - patch2
  o [WATCHDOG] wafer5823wdt.c - patch3
  o [WATCHDOG] acquirewdt.c - patch
  o [WATCHDOG] alim1535_wdt.c
  o [WATCHDOG] wafer5823wdt.c - patch4
  o [WATCHDOG] Documentation

Xose Vazquez Perez:
  o [TG3]: More missing PCI ids
  o [TG3]: ICH2 needs MBOX write reorder bug workaround too

Yoshinori Sato:
  o h8300 interrupt problem fix
  o h8300 include update

Yusuf Wilajati Purna:
  o [netdrvr] fix skb_padto bugs introduced when skb_padto was
    introduced


