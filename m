Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUJKDXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUJKDXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUJKDXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:23:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:34469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268658AbUJKDW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:22:58 -0400
Date: Sun, 10 Oct 2004 20:22:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9-rc4 - pls test (and no more patches)
Message-ID: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 trying to make ready for the real 2.6.9 in a week or so, so please give
this a beating, and if you have pending patches, please hold on to them
for a bit longer, until after the 2.6.9 release. It would be good to have
a 2.6.9 that doesn't need a dot-release immediately ;)

The appended shortlog gives a pretty good idea of what has been going on. 
Mostly small stuff, with some architecture updates and an ACPI update 
thrown in for good measure.

(The ACPI update fixes broken AML with implied returns, and in particular
the Compaq Evo notebook fan control. Yay! Guess who has one..)

		Linus

---

Summary of changes from v2.6.9-rc3 to v2.6.9-rc4
============================================

Adrian Bunk:
  o TMS380TR must select FW_LOADER
  o Fix Neomagic configuration dependency

Alan Cox:
  o fix typo in capi driver
  o Fix typo in final changes to old i4l tty code
  o 3c59x: add invalid MAC address check
  o Update termios to use per tty semaphore
  o scsi docs fix
  o Fix Kconfig for EDD
  o Fix up tty patch problem with pc300 and clean up braces
  o usb: hcd locking fix

Alexander Stohr:
  o [SPARC64]: Fix solaris emul __set_utsfield offset calculation

Alexander Viro:
  o Race with iput and umount
  o DAC960 iomem annotations
  o sx8 iomem and endianness annotations + endianness bugfix
  o more new struct initializers
  o more NULL noise removal in drivers/scsi
  o arcnet iomem annotations
  o romfs endianness annotations
  o hton* and ntoh* endianness annotations
  o udf endianness annotation fix
  o fs/partitions endianness annotations
  o quota endianness annotations
  o ncpfs (1/7): constants sanitized
  o ncpfs (2/7): date handling cleanup
  o ncpfs (3/7): be32 handling in marshalling
  o ncpfs (4/7): be16 handling in marshalling
  o ncpfs (5/7): le16 handling in marshalling
  o ncpfs (6/7): trivial endianness annotations
  o ncpfs (7/7): misc fixes and cleanups
  o isofs endianness annotations
  o ufs endianness annotations
  o ufs endianness bugfixes
  o i2o_config __user annotations
  o cciss endianness and iomem annotations
  o cpqarray iomem annotations
  o umem iomem and (partial) endianness annotations
  o hfs endianness annotations
  o hfsplus endianness annotations
  o hfsplus endianness bugfix
  o ohci bugfix for big-endian 64bit boxen
  o isd200 bugfix for 64bit boxen
  o trivial usb endianness annotations
  o amd64 iomem initial annotations
  o i2o.h fix

Ali Saidi:
  o alpha: cpu mask fix-ups broke SMP DP264 machines in 2.6.8

Andi Kleen:
  o x86_64: Lindenhurst MSI build fix
  o x86_64: fix oops with multiple MCEs
  o x86_64: fix profile_pc
  o x86_64: remove CONFIG_FRAME_POINTER
  o x86_64: fix circular dependency with UNORDERED_IO
  o x86_64: avoid a deadlock during panic
  o x86_64: don't corrupt interrupt flag on timer resume
  o x86_64: make in_gate_vma() safer
  o x86_64: add newline before MCE

Andreas Schwab:
  o Properly recognize PowerMac7,3

Andrew Morton:
  o sparc64: time interpolator build fix
  o remove get_cpu_ptr()
  o vmscan: handle empty zones

Andries E. Brouwer:
  o overcommit symbolic constants

Anton Altaparmakov:
  o NTFS: Fix stupid bug in
    fs/ntfs/attrib.c::ntfs_attr_reinit_search_ctx() where we did not
    clear ctx->al_entry but it was still set due to changes in
    ntfs_attr_lookup() and ntfs_external_attr_find() in particular.
  o NTFS: Fix another stupid bug in
    fs/ntfs/attrib.c::ntfs_external_attr_find() where we forgot to
    unmap the extent mft record when we had finished enumerating an
    attribute which caused a bug check to trigger when the VFS calls
    ->clear_inode.

Arkadiusz Miskiewicz:
  o [AGPGART] via-agp.c resume/suspend support

Arnaldo Carvalho de Melo:
  o [TCP] don't use sk_zapped
  o [SKBUFF] introduce eth_hdr(skb)
  o [BRIDGE] convert __constant_htons(constant) to htons
  o [SKBUFF] use eth_hdr(skb), skb->mac.raw cases
  o [SKBUFF] introduce tr_hdr(skb)
  o [LLC] set mac.raw if tr_source_route is called

Arun Sharma:
  o [IA64] sparse annotations and cleanups for ia32 subsystem
  o [IA64] Added support for the new syscall sys_waitid()

Bartlomiej Zolnierkiewicz:
  o [ide] triflex: kill /proc/ide/triflex
  o [ide] remove dead CMD640 debugging from ide-probe.c
  o [ide] remove dead debugging code from ide-taskfile.c
  o [ide] remove stale comment from ide-proc.c
  o [ide] aec62xx: remove dead DEBUG_AEC_REGS code
  o [ide] Simtec BAST (EB2410ITX) / Thorcom VR1000 driver
  o [ide] cmd64x: kill dead DEBUG_CMD_REGS code
  o [ide] kill dead TASKFILE_IN_OUT code
  o [ide] pdc202xx_old: kill PDC202XX_DECODE_REGISTER_INFO

Bastian Blank:
  o s390: sclp compile fix

Ben Dooks:
  o [ARM PATCH] 2107/1: BAST - additional serial port fixes
  o [ARM PATCH] 2102/1: BAST - incorrect IRQ for USB overcurrent
  o [ARM PATCH] 2116/1: S3C2410 - s3c2410_gpio_cfgpin() mask bug
  o [ARM PATCH] 2101/1: S3C2410 - usb port management
  o [ARM PATCH] 2103/1: BAST - USB power control
  o [ARM PATCH] 2118/1: S3C2410 - gpio updates and header file fix
  o [ARM PATCH] 2119/1: S3C2410 -
    include/asm-arm/arch-s3c2410/regs-mem.h
  o [ARM PATCH] 2120/1: S3C2410 -
    include/asm-arm/arch-s3c2410/regs-iic.h
  o [ARM PATCH] 2121/1: S3C2410 - add S3C2410_MISCCR definitions for
    power down config
  o [ARM PATCH] 2122/1: S3C2410 - Documentation updates
  o [ARM PATCH] 2124/1: S3C2410 -
    include/asm-arm/arch-s3c2410/regs-spi.h
  o [ARM PATCH] 2123/4: S3C2410 - GPIO IRQ IRQ Filtering and pin number
    patch
  o [ARM PATCH] 2127/1: S3C2410 - fix compile error in serial driver
  o [ARM PATCH] 2129/1: S3C2410 - fix set_irq_type() for EINT0..EINT3
  o [ARM PATCH] 2130/1: PXA255 Errata #31 fix for sleep.S

Benjamin Herrenschmidt:
  o ppc64: Fix incorrect initialization of hash table on some pSeries
  o Fix booting on some recent G5s
  o ppc64: Fix find_udbg_vterm()
  o ppc64: update g5_defconfig
  o ppc64: Fix module exports for G5

Carsten Haustein:
  o [ide] piix: fix wrong DMA mode selected

Catalin Marinas:
  o [ARM PATCH] 2106/1: Remove the "write" assumption for Jazelle in
    the early_abort handler

Chris Wright:
  o mlockall(MCL_FUTURE) unlocks currently locked mappings
  o mlockall() check rlimit only when MCL_CURRENT is set
  o make can_do_mlock useful for mlock/mlockall
  o mlockall() take mmap_sem a bit later

Christian Bornträger:
  o s390: core changes

Christoph Hellwig:
  o m32r: remove arch/m32r/drivers/m5.[ch]
  o m32r: remove arch/m32r/drivers/cs_internal.h

Christoph Lameter:
  o ppc: time interpolator build fix

Clemens Buchacher:
  o sparc32: fix warning for changed section attributes

Colin Leroy:
  o therm_adt746x: don't change loadavg
  o use kthread_stop in therm_adt746x
  o fix ans-lcd compilation
  o fix warning in arch/ppc/pmac/simple/misc.c
  o therm_adt746x: various fixes

Cornelia Huck:
  o s390: common i/o layer

Dave Airlie:
  o drm: Stop i830 and i915 both being build at same time
  o drm: remove unused dma support remnants

Dave Craig:
  o [IPV6]: Set skb->dev in ip6_pkt_discard_out

Dave Jiang:
  o [ARM PATCH] 2117/1: Fix ATU config on IQ80331 to prevent master
    aborts, replace 2099/1

Dave Jones:
  o [AGPGART] Fix up sparse iomem warnings for amd-k7 driver
  o [AGPGART] Fix up sparse iomem warnings of amd64 driver
  o [AGPGART] Fix up sparse iomem warnings in ati driver
  o [AGPGART] Fix up sparse iomem warnings in generic agp code
  o [AGPGART] Fix up sparse iomem warning in Intel driver
  o [AGPGART] Fix sparse iomem warnings in Intel MCH driver
  o [AGPGART] Fix up sparse iomem warnings in NVidia driver
  o [AGPGART] Fix up sparse iomem warnings in Serverworks driver
  o [AGPGART] Fix sign extension bug in amd64 gart driver
  o [AGPGART] Really add Intel i915 AGPGART Support
  o PCI Hotplug: Use before NULL check in shpchp_ctrl
  o find_isa_irq_pin can't be __init

David Gibson:
  o ppc64: change bad choice of VSID_MULTIPLIER
  o ppc64: squash childregs warnings
  o ppc64: EEH checks mistakenly became no-ops
  o ppc64: squash EEH warnings
  o ppc64: remove redundant #ifdef CONFIG_ALTIVEC
  o ppc64: Kconfig cleanups

David Mosberger:
  o [IA64] signal.c: fix wrong argument order in __copy_to_user() call
  o [IA64] ptrace.c: Fix unchecked user-memory accesses due to
    ptrace_{get,set}regs()
  o [IA64] fix argument-order in access_ok() call from
    csum_partial_copy_from_user
  o [IA64] Don't directly deref user pointers
  o [IA64] sparse 0 vs. NULL cleanup patch
  o [IA64] sparse "long" constant cleanup patch
  o [IA64] minimal sparse-enablement; add __user annotations
  o [IA64] sparse __iomem annotations
  o [IA64] minor sparse cleanups
  o [IA64] fix UP build

David S. Miller:
  o [TCP]: Smooth out TSO ack clocking
  o [SUNGEM]: Do not need two implementations of poll_controller, hehe
  o [TCP]: Check correct sequence number for URG in tcp_tso_acked()
  o [SUNGEM]: Fix build
  o [TCP]: Add tcp_tso_win_divisor sysctl
  o [TCP]: Kill tso_{factor,mss}
  o [ATM]: Use neigh_table_{init,clear}() in clip.c
  o [SPARC64]: Fix SI_TIMER conversion as ppc64 has
  o [SPARC64]: Update defconfig
  o [TCP]: Rename tcp_skb_psize() to tcp_skb_mss()
  o [PKT_ACT]: Fixup tcf_result updating wrt. tcf_action_exec() calls
  o [NET]: Kill typo in neighbour.c
  o [NET]: Generic network statistics/estimator
  o [SPARC64]: Make kprobe implementation more robust
  o [SPARC64]: Kill sparse warning in power.c
  o [SPARC64]: Use __iomem in chmc.c
  o [SPARC64]: Add missing __user annotation to sys_sparc32.c
  o [SPARC64]: Add __user annontation to ELF_CORE_COPY_REGS()
  o [SPARC64]: Missing __user annotations for asm/checksum.h
  o [SUNGEM]: Use NETDEV_TX_foo instead of magic constants

David Woodhouse:
  o JFFS2 mount options discarded
  o PPC64 Replace cmp instructions with cmpw/cmpd

Davide Libenzi:
  o Avoid unnecessary copy for EPOLL_CTL_DEL

Deepak Saxena:
  o Updated IXP4xx MTD driver from CVS (v1.6)

Ed L. Cashin:
  o fix block layer ioctl bug

Eugene Surovegin:
  o ppc32: export "indirect" DCR helpers

François Romieu:
  o via-velocity: properly manage the count of adapters
  o via-velocity: removal of unused velocity_info.xmit_lock
  o via-velocity: velocity_give_rx_desc() removal
  o via-velocity: received ring wrong index and missing barriers
  o via-velocity: early invocation of init_cam_filter()
  o via-velocity: removal of incomplete endianness handling
  o via-velocity: wrong buffer offset in velocity_init_td_ring()
  o via-velocity: comment fixes

Geert Uytterhoeven:
  o fix up tty fall-out

Gerald Schaefer:
  o s390: z/VM monitor stream
  o s390: dcss changes

Gerhard Jaeger:
  o ppc32: fix PFC1_EPS and PFC1_EPS_SHIFT for IBM440GX

Greg Banks:
  o [NET]: Fix race between neigh-timer_handler and neigh_event_send

Greg Kroah-Hartman:
  o USB: fix error in bluetty.c driver caused by tty core changes
  o USB: remove FIXME created from tty core changes in empeg driver

Harald Welte:
  o [NETFILTER]: Fix NAT helper handling of TCP window tracking info

Herbert Xu:
  o [NET]: Remove neigh hash expansion into already locked section
  o [TCP]: Show all SYN_RECV sockets in /proc/net/tcp
  o [TCP]: Fix bug that hid sockets in tcp_diag

Hideaki Yoshifuji:
  o [IPV6]: NEIGHBOUR: hold refcnt of net_device from proxy neighbor
    entries
  o [IPV6]: Missing ip_rt_put() in SIT error path
  o [INET]: Fix ECN encapsulation

Hidetoshi Seto:
  o [IA64] Recovery from user-mode memory error

Hirokazu Takata:
  o m32r: update comments for Renesas
  o m32r: architecture upgrade on 20040928
  o m32r: change to use temporary register variables
  o m32r: update ioremap routine
  o m32r: remove unused arch/m32r/kernel/io_m32102.c
  o m32r: remove unused arch/m32r/m32700ut/m32r-flash.c
  o m32r: remove arch/m32r/drivers

Horst Hummel:
  o s390: dasd driver

Hugh Dickins:
  o overcommit documentation fix

Ian Campbell:
  o [ARM PATCH] 2113/1: include asm/arch/pxa-regs.h where necessary
  o [ARM PATCH] 2114/1: fix drivers/char/watchdog/sa1100-wdt.c on
    SA1100
  o [ARM PATCH] 2133/1: params_phys is not available on PXA and apears
    to be ARCH_RPM specific anyway
  o pm: console driver fixes

Ingo Molnar:
  o [IA64] Makefile: Fix to make ccache/distcc happy
  o random driver preempt robustness
  o Fix task_hot() balancing
  o NX: fix read_implies_exec() related noexec-fs breakage
  o Use cache_decay_ticks instead of a constant

James Morris:
  o [CRYPTO]: Add __init and __initdata to aes.c

Jens Axboe:
  o cdrom generic_packet oops fix
  o [ide] ide-dma blacklist behaviour broken

Jesse Barnes:
  o [IA64-SGI] sn2: serialize access to PROM chips
  o [IA64] defconfig for Intel bigsur

Jon Smirl:
  o document DRM ioctl use
  o drm: cleanup header includes into one drm_core.h include

Jonathan Corbet:
  o Remove get_cpu_ptr() comment reference

Josef 'Jeff' Sipek:
  o Use proper sysfs mount-point in documentation
  o Add DEVPATH env variable to hotplug helper call

Len Brown:
  o [ACPI] fix __initdata bug in acpi_irq_penalty[]
  o [ACPI] ACPICA 20040816 update from Bob Moore
  o [ACPI] Enable ACPICA workarounds for 'RELAXED_AML' and 'implicit
    return' These workarounds are disabled if "acpi=strict"
  o [ACPI] quiet ACPI NUMA boot messages
  o [ACPI] fix numa build warnings (Keith Owens)
  o [ACPI] Export acpi_strict for use in modular drivers
  o [ACPI] cleanup: use ioapic_register_intr()
  o [ACPI] allow config to specify custom DSDT (Ulf Dambacher)
  o [ACPI] debugging enhancements (Yi Zhu)
  o [ACPI] move acpi_bios_year() to blacklist.c from dmi_scan.c (Pavel
    Machek)
  o [ACPI] delete ACPI DMI/BIOS cutoff year by default
  o add GPL to mmconfig.c
  o [ACPI] fix allmodconfig build
  o [ACPI] x86_64 build fix
  o [ACPI] fix double quoted params such as acpi_os_string="a b c" by
    Christian Lupien http://bugzilla.kernel.org/show_bug.cgi?id=3242
  o [ACPI] thermal module race condition/memory leak (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=3231
  o [ACPI] acpi4asus update: support W1N, v0.29
  o [ACPI4ASUS] acpi_bus_register_driver() return code
  o [ACPI4ASUS] support M6700R laptops
  o [ACPI4ASUS] globalize hotk structure
  o Cset exclude: len.brown@intel.com|ChangeSet|20041010081245|01886
  o [ACPI] If BIOS disabled the LAPIC, believe it by default

Li Shaohua:
  o pc110pad.c request_region() fix
  o PCI resource allocation re-ordering

Linus Torvalds:
  o Fix up natsemi network driver IO accessor types
  o Wisdom passed down the ages on clay tablets
  o The hpet acpi driver is not __initdata
  o Fix cyclades driver types, and add __iomem annotations
  o Remove casts and add __iomem annotations to gdth driver
  o Fix up MMIO pointer types and add __iomem annotations to radeonfb.c
  o Do trivial __iomem annotations for tridentfb.c
  o Fix up and type-annotate sis fb driver
  o Partially undo Alan's recent tty locking fixes: the termios lock
    must not be held across the driver/ldisc downcalls.
  o Fix close() vs posix lock race
  o tty locking fixups: remove unused "flags" variable
  o ppc64: fix non-C99 named initializers
  o Remove test for __linux__ in auth_gss.h
  o Fix up CHECKFLAGS definitions
  o pcmcia: add iomem sparse annotations
  o prism54: iomem annotations
  o i386: mark do_test_wp_bit() noinline
  o Remove rest of legacy arch/m32r/drivers directory
  o Fix up signed one-bit bitfields in core sound code
  o Update ray_cs Raylink/WebGear wireless driver
  o Use "request_resource()" to properly fix up PCI resource clashes
  o Linux 2.6.9-rc4

Maciej W. Rozycki:
  o [NET]: Fix fddi_statistics for 64-bit
  o [IPV4]: Set ARP hw type correctly for BOOTP over FDDI
  o [IPV4]: Permit the official ARP hw type in SIOCSARP for FDDI
  o APIC physical broadcast for i82489DX

Manfred Spraul:
  o [NET]: Fix secure tcp sequence number generation

Matt Porter:
  o ppc32: sync ppcboot.h with U-Boot
  o ppc32: add U-Boot support to Ocotea/440GX port
  o ppc32: fix several warnings
  o ppc32: move some common PPC44x code to ibm44x_common.c

Maximilian Attems:
  o [PCMCIA] replace schedule_timeout() with msleep()
  o msleep_interruptible(): fix whitespace

Michael Hunold:
  o Fix error path in Video4Linux dpc7146 driver

Nathan Scott:
  o [XFS] Remove crufty old cap/mac code - never used, never compiled,
    gone
  o [XFS] Fix merge botch affecting xfs_setattr for realtime files
  o [XFS] Fix sync issues - use correct writepage page re-dirty
    interface, and do not clear dirty flag if page only partially
    written.

Neil Horman:
  o olympic driver: fix kernel oops on lobe fault

Nick Piggin:
  o document isolcpus= boot option
  o vm: prevent kswapd pageout priority windup

Paolo 'Blaisorblade' Giarrusso:
  o uml: makefile fix for .lds scripts
  o uml: makefile whitespace fix
  o uml: add generic ptrace requests
  o uml: fix get_user warning
  o uml: remove wrong declaration
  o uml: fix fd leak with HostFs
  o uml: fix major & minor handling in hostfs

Patrick Caulfield:
  o [DECNET]: Mark myself as maintainer

Patrick McHardy:
  o [NET_SCHED]: Fix module leak in tc_ctl_tfilter error path
  o [NET_SCHED]: Remove useless variable in tc_ctl_tfilter
  o [IPV4]: Fix free_netdev after failed alloc_netdev in ipgre_init
  o [IPV4]: Fix free_netdev after failed alloc_netdev in ipip_init
  o [IPV4]: Fix ipip_fb_tunnel_dev leak in ipip_fini
  o [IPV6]: Fix free_netdev after failed alloc_netdev in sit_init
  o [VLAN]: Missing rtnl_unlock in register_vlan_device error path

Paul Mackerras:
  o PPC64: Remove degree symbol from rtas-proc.c
  o PPC64 Replace cmp instructions with cmpw/cmpd

Pavel Machek:
  o swsusp: fix highmem
  o Fix random crashes in x86-64 swsusp

Prasanna S. Panchamukhi:
  o kprobes exception notifier fix
  o kprobes exception notifier fix 2

Randy Dunlap:
  o pc300: remove extra paren
  o doc: remove lingering PC-9800 param

Roger Blofeld:
  o [SERIAL] Pick nearest baud rate divider

Roland Dreier:
  o ppc64: fix cross-compilation

Russell King:
  o [ARM] ecard.c locking and wait_event_interruptible() fix
  o [ARM] Add "noirqdebug" option to match x86 option
  o [ARM] Fix consistent.c for DMA allocations
  o [ARM] Check access permissions for whole of signal stack frame
  o [ARM] Remove "%?" from within macros containing assembly
  o [ARM] mach-types update
  o [ARM] Add POSIX message queue and waitid syscalls
  o [ARM] clk_* functions take frequencies in Hz not kHz
  o [ARM] Fix params_phys with PIC decompressor builds
  o [SERIAL] Fix warning and remove mach-types.h include
  o [ARM] Add save_time_delta()/restore_time_delta()
  o [ARM] Fix missing definition for OVERCOMMIT_ALWAYS
  o Fix ide-cs resource management
  o [ARM] Add decompressor support for ARMv6 caches
  o [ARM] Remove cache type check before flushing ARMv6 cache
  o [ARM] Mark source for copy_page const
  o [ARM] Ecard initialisation tweaks
  o [ARM] ecard.c: Make the ecard task completion per request
  o [ARM] ecard.c: pass a function pointer for kecardd
  o [ARM] ecard.c: Remove unnecessary context checks
  o [PCMCIA] Improve locking for memory resource probing
  o [PCMCIA] Remove two unused variables

Sascha Hauer:
  o [ARM PATCH] 2095/1: i.MX time keeping
  o [ARM PATCH] 2073/3: Hynix h720x architecture support

Stephen Hemminger:
  o limit max jiffy of msecs_to_jiffies

Stéphane Eranian:
  o [IA64] perfmon2 fix for TASK_TRACED
  o [IA64] minor fix to perfmon
  o [IA64] perfmon2 fasync fix

Suresh B. Siddha:
  o Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 - change
    TARGET_CPUS on x86_64
  o x86_64: fix tss off by one

Sylvain Munaut:
  o ppc: Name update/coherency and white space corrections for
    Freescale MPC52xx
  o ppc: Freescale MPC52xx hardware definitions misc updates/fix
  o ppc: Fix missing include in Freescale MPC52xx syslib
  o ppc: Fix spurious iounmap in Freescale MPC52xx syslib
  o ppc: Use interactive console for Freescale MPC52xx when using
    boot/simple
  o ppc: Fix output of low-level serial debug on Freescale MPC52xx
  o ppc: Update Freescale MPC52xx documentation / maintainer
  o ppc: Add Freescale MPC52xx I2C Support using i2c-mpc.c
  o ppc: Freescale MPC52xx interrupt controller init code update
  o ppc: Disable the CAN_DOZE & CAN_NAP CPU features when a BDI is used
  o ppc: Allow the Freescale MPC52xx to NAP when idle on LITE5200
    platform

Thomas Graf:
  o [PKT_SCHED]: Remove useless line in cbq_dump_class
  o [PKT_SCHED]: Make rate estimator work on all platforms

Thomas Spatzier:
  o s390: qeth network driver

Tom Rini:
  o ppc32: Update the MVME5100 defconfig so it works out of the box

Tony Luck:
  o [IA64] SMP systems may not have SRAT, still need to mark node0
    online
  o [IA64] mca.h, mca_drv.c: cleanup extern declarations
  o [IA64] Don't hardcode offsets in thread_info

Venkatesh Pallipadi:
  o cpufreq: ondemand: prevent various divide underflows
  o cpufreq: ondemand: account iowait as idle time

Wensong Zhang:
  o [IPVS]: Fix endian problem on sync message size

William Lee Irwin III:
  o hugetlb: initialize sb->s_maxbytes

Yasuyuki Kozakai:
  o [IPV6]: Fix ntohs() --> htons() typo in reassembly.c

Yoichi Yuasa:
  o mips: added CPU type checking to interrupt control routines
  o mips: added interrupt control routines for vrc4173

