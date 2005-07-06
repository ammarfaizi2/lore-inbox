Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVGFGAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVGFGAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGFGAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:00:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261593AbVGFEck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:32:40 -0400
Date: Tue, 5 Jul 2005 21:32:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.13-rc2
Message-ID: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 -rc3 is pretty small, with the bulk of the diff being some defconfig
updates, and cleanup of xtensa (notably removal of another copy of zlib).

But there are ia64/arm/ppc64 updates and the TSO update from Davem is
probably worth pointing out to people. And various smaller things which
are more easily just seen from the shortlog.

Among the one-liners of note is the silly block level spinlock bugfix that 
obviously hit -rc1 and made itself felt on SMP and preempt under moderate 
IO loads.

		Linus


----
Adrian Bunk:
  drivers/ide/Makefile: kill dead CONFIG_BLK_DEV_IDE_TCQ entry
  MMC: wbsd cleanups

Alexey Dobriyan:
  [NET]: Remove __ARGS from include/net/slhc_vj.h

Andrei Konovalov:
  ppc32: add Freescale MPC885ADS board support

Andrew Morton:
  fatfs sectioning fix
  reiserfs: handle_attrs() fix

Andy Whitcroft:
  gregkh-pci-pci-assign-unassigned-resources fix

Arnd Bergmann:
  ppc64: simplify nvram partition scanning code

Ben Dooks:
  ARM: 2785/1: S3C24XX - serial calls request_irq() with IRQs disabled
  ARM: 2783/1: Remove omnimeter_defconfig as there is no kernel support
  ARM: 2765/1: S3C24XX - small cleanups in arch/arm/mach-s3c2410
  ARM: 2764/1: S3C24XX - Common PM functions for Simtec boards

Bjorn Helgaas:
  [IA64] Recognize HP sx2000 chipset

Bruce Losure:
  [IA64-SGI] Altix patch to tiocx, add subsys_initcall

Catalin Marinas:
  ARM: 2784/1: Fix the block cache flush operation range
  ARM: 2780/1: AFS partition length calculation fix
  ARM: 2779/1: Fix the V bit setting for the ARM1020x CPUs
  ARM: 2778/1: Add -mno-thumb-interwork to CFLAGS_ABI
  ARM: 2777/1: Fix broken comment arch/arm/mm/proc-arm1020.S
  ARM: 2769/1: cpu_init() stack setup fix

Chris Zankel:
  xtensa: Fix asm macro
  xtensa: Removed local copy of zlib and fixed O= support
  xtensa: Added mm/Kconfig to get a flat memory layout
  xtensa: cleanups for errno and ipc.

Christoph Hellwig:
  [SHAPER]: Switch to spinlocks.
  [SPARC]: bpp: remove sleep_on usage
  udf_find_entry() cleanup

Colin Ngam:
  [IA64-SGI] Fix TIO IOSPACE MMR Addres

Cornelia Huck:
  driver core: add bus_find_device & driver_find_device functions

David Chau:
  [NET]: improve readability of dev_set_promiscuity() in net/core/dev.c

David Mosberger-Tang:
  [IA64] Replace stale KDB-code with useful MAGIC_SYSRQ code in simserial.c
  [IA64] Speed up lfetch.fault [NULL]
  [IA64] Fix convert_to_non_syscall() so gdb inferior calls work again
  [IA64] Merge audit fix for fsyscalls with syscall-optimizations
  [IA64] need r29=psr *after* rsm psr.i
  [IA64] use srlz.d instead of srlz.i in ia64_leave_kernel()
  [IA64] Annotate fsys_bubble_down() with McKinley dispatch info.
  [IA64] Reschedule fsys_bubble_down().
  [IA64] Annotate __kernel_syscall_via_epc() with McKinley dispatch info.
  [IA64] Reschedule __kernel_syscall_via_epc().
  [IA64] Reschedule break_fault() for better performance.
  [IA64] In ia64_leave_syscall(), fix comments and whitespace only.
  [IA64] Schedule ia64_leave_syscall() to read ar.bsp earlier
  [IA64] In syscall-entry, use st8 instead of stf8 to clear pt_regs.r8
  [IA64] On return from syscall, hint b7 with __kernel_syscall_via_epc().
  [IA64] Schedule fp-clearing insns at least 6 cycles after reading ar.bsp.
  [IA64] Use dynamic prediction for RSE-clearing branches.
  [IA64] __ia64_syscall() is no longer used anywhere in the kernel.  Remove it.

David S. Miller:
  [SPARC64]: Fix UltraSPARC-III fallout from membar changes.
  [TCP]: Never TSO defer under periods of congestion.
  [TCP]: Move to new TSO segmenting scheme.
  [TCP]: Break out send buffer expansion test.
  [TCP]: Do not call tcp_tso_acked() if no work to do.
  [TCP]: Kill bogus comment above tcp_tso_acked().
  [TCP]: Fix send-side cpu utiliziation regression.
  [TCP]: Eliminate redundant computations in tcp_write_xmit().
  [TCP]: Break out tcp_snd_test() into it's constituent parts.
  [TCP]: Fix __tcp_push_pending_frames() 'nonagle' handling.
  [TCP]: Fix redundant calculations of tcp_current_mss()
  [TCP]: tcp_write_xmit() tabbing cleanup
  [TCP]: Kill extra cwnd validate in __tcp_push_pending_frames().
  [TCP]: Add missing skb_header_release() call to tcp_fragment().
  [TCP]: Move __tcp_data_snd_check into tcp_output.c
  [TCP]: Move send test logic out of net/tcp.h
  [TCP]: Fix quick-ack decrementing with TSO.
  [TCP]: Simplify SKB data portion allocation with NETIF_F_SG.
  [TG3]: Update driver version and reldate.
  [SKGE]: Fix build on big-endian
  [SPARC64]: Fix IRQ retry interval timer value on sparc64 PCI controllers.
  [SPARC64]: Small Schizo PCI controller programming tweaks.
  [SPARC64]: Do proper DMA IRQ syncing on Tomatillo
  [SPARC64]: Add support for IRQ pre-handlers.

Denis Vlasenko:
  ide: fix line break in ide messages

Dominik Brodowski:
  pcmcia: update Documentation
  pcmcia: fix modalias attribute in sysfs

Eric Dumazet:
  [IPV4]: Bug fix in rt_check_expire()
  [IPV4]: Use the fancy alloc_large_system_hash() function for route hash table
  [NET]: Hashed spinlocks in net/ipv4/route.c

Eric Paris:
  selinux_sb_copy_data() should not require a whole page

Eugene Surovegin:
  ppc32: explicitly disable 440GP IRQ compatibility mode in 440GX setup

Greg KH:
  Merge rsync://rsync.kernel.org/.../torvalds/linux-2.6

Greg Kroah-Hartman:
  PCI: clean up dynamic pci id logic
  PCI: Fix up PCI routing in parent bridge
  driver core: change bus_rescan_devices to return void
  driver core: Add the ability to bind drivers to devices from userspace
  driver core: Add the ability to unbind drivers to devices from userspace

Hannes Reinecke:
  PCI: Remove newline from pci MODALIAS variable

Heiko Carstens:
  s390: fix finish_arch_switch

Herbert Xu:
  [IPV6]: Makes IPv6 rcv registration happen last during initialisation.
  [IPV4]: Fix crash in ip_rcv while booting related to netconsole
  ide: hotplug mark __devinit via82cxxx.c
  ide: hotplug mark __devinit triflex.c
  ide: hotplug mark __devinit slc90e66.c
  ide: hotplug mark __devinit sl82c105.c
  ide: hotplug mark __devinit sc1200.c
  ide: hotplug mark __devinit opti621.c
  ide: hotplug mark __devinit ns87415.c
  ide: hotplug mark __devinit it8172.c
  ide: hotplug mark __devinit cy82c693.c
  ide: hotplug mark __devinit cs5530.c
  ide: hotplug mark __devinit amd74xx.c
  ide: hotplug mark __devinit alim15x3.c

Hugh Dickins:
  Fix get_request nastiness

Ingo Molnar:
  x86: i8253/i8259A lock cleanup

Ivan Kokshaysky:
  PCI: pci_assign_unassigned_resources() on x86
  PCI: handle subtractive decode pci-pci bridge better
  alpha smp fix (part #2)
  alpha smp fix

Jack Steiner:
  [IA64-SGI] - new macros for SGI SN simulator 

Jay Lan:
  Improper initrd failure message at boot time

Jean Delvare:
  PCI: Add PCI quirk for SMBus on the Asus P4B-LX

Jeff Mahoney:
  reiserfs: enable attrs by default if saf
  reiserfs: Check if attrs are enabled for attr ioctls

Jesper Juhl:
  xtensa: use valid_signal()

john stultz:
  ppc32: stop misusing NTP's time_offset value

John W. Linville:
  pci: cleanup argument comments for pci_{save,restore}_state

Kumar Gala:
  ppc32: Fix pointer check for MPC8540 ADS device

Kylene Jo Hall:
  tpm: fix bug introduced by the /proc/misc

Linus Torvalds:
  Linux v2.6.13-rc3
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge rsync://rsync.kernel.org/.../davem/sparc-2.6
  Merge master.kernel.org:/.../gregkh/pci-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Merge master.kernel.org:/home/rmk/linux-2.6-mmc
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Merge master.kernel.org:/.../gregkh/driver-2.6
  Merge rsync://rsync.kernel.org/.../paulus/ppc64-2.6
  Merge rsync://rsync.kernel.org/.../aegl/linux-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Remove duplicate mention of "edd" in Documentation/kernel-parameters.txt

long:
  PCI: acpi tg3 ethernet not coming back properly after S3 suspendon DellM70

Mark Maule:
  [IA64-SGI] altix: enable vgacon support
  [IA64-SGI] pcdp: add PCDP pci interface support

Michael Chan:
  [TG3]: support for ethtool -C

Michael Ellerman:
  ppc64: Replace custom locking code with a spinlock
  ppc64: Formatting cleanups in arch/ppc64/kernel/ItLpQueue.c
  ppc64: Cleanup whitespace in arch/ppc64/kernel/ItLpQueue.c
  ppc64: Cleanup proc printing of event types
  ppc64: Simplify counting of lpevents, remove lpevent_count from paca
  ppc64: Don't count number of events processed for caller
  ppc64: Rename ItLpQueue_* functions to hvlpevent_queue_*
  ppc64: Rename xItLpQueue to hvlpevent_queue
  ppc64: Move definition of xItLpQueue
  ppc64: Make two ItLpQueue related functions static
  ppc64: Move xItLpQueue proc code into ItLpQueue.c
  ppc64: Move initialisation of xItLpQueue into ItLpQueue.c
  ppc64: Don't pass the pointers to xItLpQueue around
  ppc64: Reorganise the paca initialisation macros
  ppc64: Move set_spread_lpevents() into ItLpQueue.c
  ppc64: Spread lpevents by default on iSeries
  ppc64: Remove lpqueue pointer from the paca on iSeries

Nathan Lynch:
  ppc64: don't create spurious symlinks under node0 sysdev

Nicolas Pitre:
  ARM: 2723/2: remove __udivdi3 and __umoddi3 from the kernel

Nishanth Aravamudan:
  ARM: replace schedule_timeout() with msleep()

Olaf Hering:
  ppc32: use correct register names in arch/ppc/kernel/relocate_kernel.S
  remove duplicate printf in arch/ppc64/boot/main.c
  remove printk usage in arch/ppc64/boot/prom.c
  remove unused arch/ppc64/boot/mknote.c
  remove unused arch/ppc64/boot/piggyback.c

Patrick McHardy:
  [IPV4]: Handle large allocations in fib_trie
  [NET]: net/core/filter.c: make len cover the entire packet
  [NET]: Consolidate common code in net/core/filter.c
  [NET]: Remove redundant code in net/core/filter.c
  [NET]: Fix signedness issues in net/core/filter.c

Patrick Mochel:
  Driver core: Use klist_del() instead of klist_remove().

Pekka Enberg:
  freevxfs: minor cleanups
  freevxfs: remove 2.4 compatability
  freevxfs: fix buffer_head leak

Pekka J Enberg:
  fat: fix slab cache leak

Peter Chubb:
  [IA64] Fix another IA64 preemption problem

Pierre Ossman:
  MMC: wbsd delayed insertion

Prakash Punnoor:
  Don't fill up log with atxp1 vcore messages change message

Prarit Bhargava:
  [IA64] sparse cleanup of TIOCA files
  [IA64] sparse cleanup of shub_mmr.h

rajesh.shah@intel.com:
  PCI: Increase the number of PCI bus resources

Raphael Assenat:
  [SPARC64/COMPAT]: Add some compat ioctl for ppdev

Richard Purdie:
  ARM: 2768/1: PXA: Add a required header file for LL_DEBUG

Rob Punkunus:
  amd74xx: support MCP55 device IDs

Robert Olsson:
  [IPV4]: Add LC-Trie implementation notes
  [IPV4]: More broken memory allocation fixes for fib_trie

Russell King:
  ARM: Fix new-ABI layout of struct stat64
  ARM: Fix non-standard PXA io_pg_offst initialisers
  ARM: Change 'param_offset' to 'boot_params'
  Serial: Fix console port spinlock initialisation
  ARM: Remove machine description macros
  MMC: Fix divdi3 reference in mmci.c
  ARM: Make the magic values in head.S more obvious
  Serial: Fix small CONFIG_SERIAL_8250_NR_UARTS
  ARM: Acornfb: Don't claim IRQ fbcon for cursor
  ARM: Don't try to send a signal to pid0
  ARM: Don't force SIGFPE
  ARM: Fix VFP to use do_div()
  Serial: Split 8250 port table (part 2)
  Serial: Disable OX950 transmitter for flow control
  Serial: Check status of CTS when using flow control
  ARM: Remove nmi_tick from integrator platforms
  ARM: Convert ARM timer implementations to use readl/writel
  Serial: Adjust serial locking
  Merge with ../linux-2.6-smp
  ARM SMP: __xchg support
  ARM SMP: Add IPI support code for SMP TLB flushing
  ARM SMP: Use local_flush_tlb* where we really want to be local
  ARM SMP: TLB implementations only affect local CPU

Rusty Lynch:
  kprobes: fix namespace problem and sparc64 build

Thomas Graf:
  [PKT_SCHED]: Blackhole queueing discipline
  [DECNET]: Fix memset overflow on 64bit archs while dumping decnet routing rules
  [PKT_SCHED]: Report rate estimator configuration errors during qdisc allocation
  [PKT_SCHED]: Cleanup qdisc creation and alignment macros
  [PKT_SCHED]: Move sch_generic.c prototypes to correct header file
  [NET]: Reduce size of sk_buff by 4 bytes
  [NET]: Remove unused security member in sk_buff

Todd Poynor:
  ARM: 2782/1: PXA27x MDREFR K0DB4 define
  ARM: 2781/2: PXA27x Standby mode take 2

Tony Lindgren:
  ARM: 2771/1: Dynamic Tick support for OMAP, take 4

Tony Luck:
  [IA64] Update zx1_defconfig
  [IA64] Update tiger_defconfig
  Auto merge with /home/aegl/GIT/linus
  Auto merge with /home/aegl/GIT/ia64-test
  Auto merge with /home/aegl/GIT/linus
  Merge with temp tree to get David's gdb inferior calls patch

---- diffstat ----
 Documentation/Changes                     |    2 
 Documentation/kernel-parameters.txt       |    4 
 Documentation/networking/fib_trie.txt     |  145 ++
 Documentation/pcmcia/devicetable.txt      |    5 
 Documentation/serial/driver               |    4 
 Makefile                                  |    2 
 arch/alpha/kernel/irq_alpha.c             |    2 
 arch/alpha/kernel/traps.c                 |    2 
 arch/arm/Makefile                         |    2 
 arch/arm/configs/omnimeter_defconfig      |  803 -----------
 arch/arm/kernel/armksyms.c                |    6 
 arch/arm/kernel/head.S                    |   20 
 arch/arm/kernel/setup.c                   |    7 
 arch/arm/kernel/smp.c                     |  123 ++
 arch/arm/kernel/traps.c                   |   12 
 arch/arm/lib/Makefile                     |    2 
 arch/arm/lib/longlong.h                   |  183 --
 arch/arm/lib/udivdi3.c                    |  222 ---
 arch/arm/mach-aaec2000/aaed2000.c         |   10 
 arch/arm/mach-clps711x/autcpu12.c         |   12 
 arch/arm/mach-clps711x/cdb89712.c         |   12 
 arch/arm/mach-clps711x/ceiva.c            |   12 
 arch/arm/mach-clps711x/clep7312.c         |   14 
 arch/arm/mach-clps711x/edb7211-arch.c     |   14 
 arch/arm/mach-clps711x/fortunet.c         |   14 
 arch/arm/mach-clps711x/p720t.c            |   14 
 arch/arm/mach-clps7500/core.c             |   14 
 arch/arm/mach-ebsa110/core.c              |   18 
 arch/arm/mach-epxa10db/arch.c             |   10 
 arch/arm/mach-footbridge/cats-hw.c        |   16 
 arch/arm/mach-footbridge/co285.c          |   12 
 arch/arm/mach-footbridge/ebsa285.c        |   15 
 arch/arm/mach-footbridge/netwinder-hw.c   |   21 
 arch/arm/mach-footbridge/personal.c       |   12 
 arch/arm/mach-h720x/h7201-eval.c          |   14 
 arch/arm/mach-h720x/h7202-eval.c          |   16 
 arch/arm/mach-imx/mx1ads.c                |   14 
 arch/arm/mach-integrator/core.c           |   43 -
 arch/arm/mach-integrator/integrator_ap.c  |   14 
 arch/arm/mach-integrator/integrator_cp.c  |   14 
 arch/arm/mach-iop3xx/iop321-setup.c       |   28 
 arch/arm/mach-iop3xx/iop331-setup.c       |   30 
 arch/arm/mach-ixp2000/enp2611.c           |   14 
 arch/arm/mach-ixp2000/ixdp2400.c          |   14 
 arch/arm/mach-ixp2000/ixdp2800.c          |   14 
 arch/arm/mach-ixp2000/ixdp2x01.c          |   28 
 arch/arm/mach-ixp4xx/coyote-setup.c       |   30 
 arch/arm/mach-ixp4xx/gtwx5715-setup.c     |   17 
 arch/arm/mach-ixp4xx/ixdp425-setup.c      |   60 -
 arch/arm/mach-l7200/core.c                |   10 
 arch/arm/mach-lh7a40x/arch-kev7a400.c     |   12 
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c     |   28 
 arch/arm/mach-omap/board-generic.c        |   14 
 arch/arm/mach-omap/board-h2.c             |   14 
 arch/arm/mach-omap/board-h3.c             |   14 
 arch/arm/mach-omap/board-innovator.c      |   14 
 arch/arm/mach-omap/board-netstar.c        |   16 
 arch/arm/mach-omap/board-osk.c            |   14 
 arch/arm/mach-omap/board-perseus2.c       |   14 
 arch/arm/mach-omap/board-voiceblue.c      |   16 
 arch/arm/mach-omap/pm.c                   |   16 
 arch/arm/mach-omap/time.c                 |   44 +
 arch/arm/mach-omap/usb.c                  |    1 
 arch/arm/mach-pxa/Makefile                |    4 
 arch/arm/mach-pxa/corgi.c                 |   42 -
 arch/arm/mach-pxa/idp.c                   |   12 
 arch/arm/mach-pxa/lubbock.c               |   12 
 arch/arm/mach-pxa/mainstone.c             |   12 
 arch/arm/mach-pxa/poodle.c                |   14 
 arch/arm/mach-pxa/pxa27x.c                |    9 
 arch/arm/mach-pxa/standby.S               |   32 
 arch/arm/mach-rpc/riscpc.c                |   16 
 arch/arm/mach-s3c2410/Kconfig             |    5 
 arch/arm/mach-s3c2410/Makefile            |    1 
 arch/arm/mach-s3c2410/devs.c              |    4 
 arch/arm/mach-s3c2410/mach-bast.c         |   46 -
 arch/arm/mach-s3c2410/mach-h1940.c        |   12 
 arch/arm/mach-s3c2410/mach-n30.c          |    9 
 arch/arm/mach-s3c2410/mach-nexcoder.c     |    8 
 arch/arm/mach-s3c2410/mach-otom.c         |    8 
 arch/arm/mach-s3c2410/mach-rx3715.c       |   14 
 arch/arm/mach-s3c2410/mach-smdk2410.c     |   12 
 arch/arm/mach-s3c2410/mach-smdk2440.c     |    8 
 arch/arm/mach-s3c2410/mach-vr1000.c       |   16 
 arch/arm/mach-s3c2410/pm-simtec.c         |   65 +
 arch/arm/mach-sa1100/assabet.c            |   12 
 arch/arm/mach-sa1100/badge4.c             |   10 
 arch/arm/mach-sa1100/cerf.c               |   10 
 arch/arm/mach-sa1100/collie.c             |    8 
 arch/arm/mach-sa1100/cpu-sa1110.c         |    3 
 arch/arm/mach-sa1100/h3600.c              |   30 
 arch/arm/mach-sa1100/hackkit.c            |   10 
 arch/arm/mach-sa1100/jornada720.c         |   10 
 arch/arm/mach-sa1100/lart.c               |   10 
 arch/arm/mach-sa1100/pleb.c               |    8 
 arch/arm/mach-sa1100/shannon.c            |   10 
 arch/arm/mach-sa1100/simpad.c             |   12 
 arch/arm/mach-shark/core.c                |   12 
 arch/arm/mach-versatile/core.c            |   61 -
 arch/arm/mach-versatile/versatile_ab.c    |   14 
 arch/arm/mach-versatile/versatile_pb.c    |   14 
 arch/arm/mm/blockops.c                    |    3 
 arch/arm/mm/fault.c                       |   75 +
 arch/arm/mm/init.c                        |    2 
 arch/arm/mm/mm-armv.c                     |    2 
 arch/arm/mm/proc-arm1020.S                |    4 
 arch/arm/mm/proc-arm1020e.S               |    4 
 arch/arm/vfp/vfp.h                        |   15 
 arch/arm/vfp/vfpdouble.c                  |    2 
 arch/arm/vfp/vfpmodule.c                  |    2 
 arch/arm/vfp/vfpsingle.c                  |   14 
 arch/i386/kernel/apic.c                   |    2 
 arch/i386/kernel/apm.c                    |    5 
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 
 arch/i386/kernel/io_apic.c                |    2 
 arch/i386/kernel/kprobes.c                |    2 
 arch/i386/kernel/time.c                   |    5 
 arch/i386/kernel/timers/timer_cyclone.c   |    4 
 arch/i386/kernel/timers/timer_pit.c       |    4 
 arch/i386/kernel/timers/timer_tsc.c       |    3 
 arch/i386/mach-voyager/voyager_basic.c    |    2 
 arch/i386/pci/common.c                    |    1 
 arch/i386/pci/i386.c                      |   11 
 arch/ia64/configs/sn2_defconfig           |    4 
 arch/ia64/configs/tiger_defconfig         |   39 -
 arch/ia64/configs/zx1_defconfig           |  166 ++
 arch/ia64/hp/common/sba_iommu.c           |    4 
 arch/ia64/hp/sim/simserial.c              |   16 
 arch/ia64/kernel/entry.S                  |  124 +-
 arch/ia64/kernel/fsys.S                   |  147 +-
 arch/ia64/kernel/gate.S                   |   62 -
 arch/ia64/kernel/ia64_ksyms.c             |    3 
 arch/ia64/kernel/ivt.S                    |  198 ++-
 arch/ia64/kernel/kprobes.c                |    2 
 arch/ia64/kernel/ptrace.c                 |   22 
 arch/ia64/kernel/setup.c                  |   12 
 arch/ia64/kernel/smp.c                    |    3 
 arch/ia64/sn/kernel/io_init.c             |    2 
 arch/ia64/sn/kernel/iomv.c                |    6 
 arch/ia64/sn/kernel/setup.c               |   43 -
 arch/ia64/sn/kernel/sn2/ptc_deadlock.S    |    1 
 arch/ia64/sn/kernel/tiocx.c               |   14 
 arch/ia64/sn/pci/tioca_provider.c         |    8 
 arch/parisc/configs/712_defconfig         |    2 
 arch/parisc/configs/a500_defconfig        |    2 
 arch/parisc/configs/b180_defconfig        |    2 
 arch/parisc/configs/c3000_defconfig       |    2 
 arch/parisc/defconfig                     |    2 
 arch/ppc/8xx_io/enet.c                    |   52 +
 arch/ppc/Kconfig                          |   22 
 arch/ppc/configs/mpc86x_ads_defconfig     |  633 +++++++++
 arch/ppc/configs/mpc885ads_defconfig      |  622 ++++++++
 arch/ppc/kernel/relocate_kernel.S         |    4 
 arch/ppc/kernel/time.c                    |   13 
 arch/ppc/platforms/85xx/mpc8540_ads.c     |    2 
 arch/ppc/platforms/fads.h                 |  109 +
 arch/ppc/platforms/mpc885ads.h            |   92 +
 arch/ppc/syslib/ppc4xx_pic.c              |    4 
 arch/ppc64/boot/Makefile                  |    5 
 arch/ppc64/boot/main.c                    |    8 
 arch/ppc64/boot/mknote.c                  |   43 -
 arch/ppc64/boot/piggyback.c               |   83 -
 arch/ppc64/boot/prom.c                    |   16 
 arch/ppc64/kernel/ItLpQueue.c             |  300 +++-
 arch/ppc64/kernel/LparData.c              |   11 
 arch/ppc64/kernel/iSeries_proc.c          |   48 -
 arch/ppc64/kernel/iSeries_setup.c         |   43 -
 arch/ppc64/kernel/idle.c                  |    4 
 arch/ppc64/kernel/irq.c                   |    7 
 arch/ppc64/kernel/kprobes.c               |    2 
 arch/ppc64/kernel/mf.c                    |    6 
 arch/ppc64/kernel/nvram.c                 |    8 
 arch/ppc64/kernel/pacaData.c              |  212 +--
 arch/ppc64/kernel/sysfs.c                 |    7 
 arch/ppc64/kernel/time.c                  |    8 
 arch/sparc64/Kconfig                      |   18 
 arch/sparc64/kernel/entry.S               |   21 
 arch/sparc64/kernel/irq.c                 |  577 +++-----
 arch/sparc64/kernel/kprobes.c             |    5 
 arch/sparc64/kernel/pci_psycho.c          |    3 
 arch/sparc64/kernel/pci_sabre.c           |   46 -
 arch/sparc64/kernel/pci_schizo.c          |   80 +
 arch/sparc64/kernel/time.c                |    2 
 arch/sparc64/mm/ultra.S                   |    5 
 arch/x86_64/kernel/io_apic.c              |    1 
 arch/x86_64/kernel/kprobes.c              |    2 
 arch/xtensa/Kconfig                       |    4 
 arch/xtensa/Makefile                      |   48 -
 arch/xtensa/boot/Makefile                 |   10 
 arch/xtensa/boot/boot-elf/Makefile        |    4 
 arch/xtensa/boot/boot-redboot/Makefile    |   10 
 arch/xtensa/boot/include/zlib.h           |  433 ------
 arch/xtensa/boot/lib/Makefile             |   13 
 arch/xtensa/boot/lib/memcpy.S             |   36 
 arch/xtensa/boot/lib/zlib.c               | 2150 -----------------------------
 arch/xtensa/boot/lib/zmem.c               |   20 
 arch/xtensa/kernel/pci.c                  |   95 -
 arch/xtensa/kernel/ptrace.c               |    5 
 drivers/acpi/pci_irq.c                    |    2 
 drivers/base/base.h                       |    1 
 drivers/base/bus.c                        |  117 +-
 drivers/base/core.c                       |    2 
 drivers/base/dd.c                         |    2 
 drivers/base/driver.c                     |   35 
 drivers/block/ll_rw_blk.c                 |    5 
 drivers/char/hw_random.c                  |    2 
 drivers/char/tpm/tpm.c                    |    2 
 drivers/char/watchdog/i8xx_tco.c          |    2 
 drivers/firmware/pcdp.c                   |   24 
 drivers/firmware/pcdp.h                   |   33 
 drivers/i2c/chips/atxp1.c                 |    2 
 drivers/ide/Makefile                      |    1 
 drivers/ide/ide-lib.c                     |   13 
 drivers/ide/legacy/hd.c                   |    4 
 drivers/ide/pci/alim15x3.c                |   10 
 drivers/ide/pci/amd74xx.c                 |    7 
 drivers/ide/pci/cs5530.c                  |    4 
 drivers/ide/pci/cy82c693.c                |    8 
 drivers/ide/pci/it8172.c                  |    4 
 drivers/ide/pci/ns87415.c                 |    2 
 drivers/ide/pci/opti621.c                 |    2 
 drivers/ide/pci/sc1200.c                  |    2 
 drivers/ide/pci/sl82c105.c                |    6 
 drivers/ide/pci/slc90e66.c                |    2 
 drivers/ide/pci/triflex.c                 |    2 
 drivers/ide/pci/via82cxxx.c               |    4 
 drivers/ide/setup-pci.c                   |    2 
 drivers/input/gameport/gameport.c         |    3 
 drivers/input/joystick/analog.c           |    4 
 drivers/mmc/mmci.c                        |    9 
 drivers/mmc/wbsd.c                        |   80 +
 drivers/mmc/wbsd.h                        |    9 
 drivers/mtd/afs.c                         |   16 
 drivers/net/arm/etherh.c                  |   16 
 drivers/net/shaper.c                      |   42 -
 drivers/net/skge.h                        |    1 
 drivers/net/tg3.c                         |   69 +
 drivers/net/tg3.h                         |   10 
 drivers/parport/parport_pc.c              |    2 
 drivers/pci/Makefile                      |    1 
 drivers/pci/hotplug.c                     |    2 
 drivers/pci/pci-driver.c                  |  196 +--
 drivers/pci/pci.c                         |    6 
 drivers/pci/pcie/portdrv.h                |    5 
 drivers/pci/pcie/portdrv_core.c           |    8 
 drivers/pci/pcie/portdrv_pci.c            |   79 +
 drivers/pci/probe.c                       |   24 
 drivers/pci/quirks.c                      |    1 
 drivers/pci/setup-bus.c                   |    2 
 drivers/pcmcia/ds.c                       |    2 
 drivers/sbus/char/bpp.c                   |   20 
 drivers/serial/8250.c                     |   36 
 drivers/serial/Kconfig                    |    2 
 drivers/serial/au1x00_uart.c              |    3 
 drivers/serial/cpm_uart/cpm_uart_cpm1.c   |   32 
 drivers/serial/ip22zilog.c                |   13 
 drivers/serial/mpsc.c                     |    3 
 drivers/serial/pmac_zilog.c               |    4 
 drivers/serial/pxa.c                      |    3 
 drivers/serial/s3c2410.c                  |    5 
 drivers/serial/serial_core.c              |   42 +
 drivers/serial/serial_txx9.c              |    3 
 drivers/serial/sunsab.c                   |    7 
 drivers/serial/sunsu.c                    |    3 
 drivers/serial/sunzilog.c                 |   13 
 drivers/video/console/fbcon.c             |    8 
 fs/fat/cache.c                            |    2 
 fs/fat/inode.c                            |   21 
 fs/freevxfs/vxfs.h                        |    1 
 fs/freevxfs/vxfs_bmap.c                   |    2 
 fs/freevxfs/vxfs_fshead.c                 |   11 
 fs/freevxfs/vxfs_kcompat.h                |   49 -
 fs/freevxfs/vxfs_lookup.c                 |    8 
 fs/freevxfs/vxfs_olt.c                    |   10 
 fs/freevxfs/vxfs_subr.c                   |    1 
 fs/freevxfs/vxfs_super.c                  |    7 
 fs/reiserfs/ioctl.c                       |    6 
 fs/reiserfs/super.c                       |    5 
 fs/udf/namei.c                            |    4 
 include/asm-alpha/serial.h                |   47 -
 include/asm-arm/arch-pxa/debug-macro.S    |    2 
 include/asm-arm/arch-pxa/pxa-regs.h       |    2 
 include/asm-arm/hardware/arm_timer.h      |   21 
 include/asm-arm/mach/arch.h               |   34 
 include/asm-arm/stat.h                    |    2 
 include/asm-arm/system.h                  |   16 
 include/asm-arm/tlbflush.h                |   28 
 include/asm-arm26/serial.h                |   22 
 include/asm-i386/i8253.h                  |    6 
 include/asm-i386/mach-default/do_timer.h  |    1 
 include/asm-i386/serial.h                 |  102 -
 include/asm-ia64/mmu_context.h            |    3 
 include/asm-ia64/sn/addrs.h               |   17 
 include/asm-ia64/sn/l1.h                  |    1 
 include/asm-ia64/sn/shub_mmr.h            |  348 ++---
 include/asm-ia64/sn/simulator.h           |   13 
 include/asm-ia64/sn/sn2/sn_hwperf.h       |    2 
 include/asm-ia64/sn/sn_sal.h              |   10 
 include/asm-ia64/sn/tioca_provider.h      |    1 
 include/asm-ia64/vga.h                    |    5 
 include/asm-m68k/serial.h                 |   47 -
 include/asm-mips/serial.h                 |   84 -
 include/asm-parisc/serial.h               |   16 
 include/asm-ppc/mpc8xx.h                  |    4 
 include/asm-ppc/pc_serial.h               |   86 -
 include/asm-ppc64/iSeries/ItLpQueue.h     |   15 
 include/asm-ppc64/paca.h                  |    3 
 include/asm-s390/system.h                 |    4 
 include/asm-sh/bigsur/serial.h            |    5 
 include/asm-sh/ec3104/serial.h            |    4 
 include/asm-sh/serial.h                   |    6 
 include/asm-sh64/serial.h                 |    4 
 include/asm-sparc64/irq.h                 |   47 -
 include/asm-sparc64/pbm.h                 |    3 
 include/asm-sparc64/signal.h              |   15 
 include/asm-x86_64/io_apic.h              |    2 
 include/asm-x86_64/serial.h               |  102 -
 include/asm-xtensa/delay.h                |    2 
 include/asm-xtensa/errno.h                |  128 --
 include/asm-xtensa/ipc.h                  |   20 
 include/linux/compat_ioctl.h              |   19 
 include/linux/device.h                    |    7 
 include/linux/if_shaper.h                 |    2 
 include/linux/kprobes.h                   |    2 
 include/linux/pci-dynids.h                |   18 
 include/linux/pci.h                       |    5 
 include/linux/pci_ids.h                   |    1 
 include/linux/skbuff.h                    |   19 
 include/linux/tc_ematch/tc_em_meta.h      |    2 
 include/linux/tcp.h                       |    2 
 include/net/pkt_sched.h                   |   17 
 include/net/sch_generic.h                 |   13 
 include/net/slhc_vj.h                     |   19 
 include/net/sock.h                        |    7 
 include/net/tcp.h                         |  156 --
 init/do_mounts_initrd.c                   |    5 
 kernel/kprobes.c                          |    2 
 net/core/dev.c                            |    5 
 net/core/filter.c                         |  104 -
 net/core/skbuff.c                         |    2 
 net/decnet/dn_fib.c                       |    3 
 net/ipv4/af_inet.c                        |   11 
 net/ipv4/fib_trie.c                       |  202 ++-
 net/ipv4/ip_output.c                      |   16 
 net/ipv4/route.c                          |  124 +-
 net/ipv4/tcp.c                            |   44 -
 net/ipv4/tcp_input.c                      |   76 -
 net/ipv4/tcp_ipv4.c                       |    2 
 net/ipv4/tcp_output.c                     |  546 ++++++-
 net/ipv6/af_inet6.c                       |    4 
 net/ipv6/ip6_output.c                     |    1 
 net/ipv6/tcp_ipv6.c                       |    2 
 net/sched/Makefile                        |    2 
 net/sched/em_meta.c                       |    6 
 net/sched/sch_api.c                       |   63 -
 net/sched/sch_blackhole.c                 |   54 +
 net/sched/sch_generic.c                   |   35 
 security/selinux/hooks.c                  |    3 
 sound/pci/bt87x.c                         |    2 
 359 files changed, 6033 insertions(+), 8005 deletions(-)
