Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDSD1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDSD1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 23:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWDSD1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 23:27:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWDSD1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 23:27:45 -0400
Date: Tue, 18 Apr 2006 20:27:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.17-rc2
Message-ID: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-700635566-1145417257=:3701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-700635566-1145417257=:3701
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Instead of the normal one-week release schedule, there was now two weeks 
between 2.6.17-rc1 and -rc2, partly because I was travelling for one of 
those weeks, but partly because it was really quiet for a while. Likely a 
lot of people are concentrating on 2.6.16 and vendor releases.

It picked up a bit in the last few days (it's also possible that the US 
people were all just stressed out over tax season ;), and I cut a 
2.6.17-rc2. I expect to be back to the weekly schedule now, even if it is 
quiet (which I hope it will be).

Not a lot of hugely interesting stuff, with a large portion of the diff 
being a late MIPS update (tssk tssk), and the huge diff from the 
long over-due removal of the Sangoma wan drivers that have been marked 
BROKEN for a long time. Same goes for the qlogicfc driver (which has been 
supplanted by the qla2xxx driver).

As a result, the diff has just tons of deletions, even if most of the rest 
of the changes aren't all that big. But there are netfilter fixes, some 
more splice work, and just tons of random stuff: usb, scsi, knfsd, fuse, 
infiniband..

Shortlog follows, for more details on it all..

		Linus

---
adam radford:
      [SCSI] 3ware 9000 disable local irqs during kmap_atomic

Adrian Bunk:
      [NET]: Fix an off-by-21-or-49 error.
      [TG3]: Fix a memory leak.
      [IPV6]: Unexport secure_ipv6_port_ephemeral
      CONFIGFS_FS must depend on SYSFS
      arch/i386/mach-voyager/voyager_cat.c: named initializers
      mm/migrate.c: don't export a static function
      i386: move SMP option above subarch selection
      arch/s390/Makefile: remove -finline-limit=10000
      the scheduled unexport of panic_timeout
      drivers/isdn/gigaset/common.c: small cleanups
      isdn/gigaset/common.c: fix a memory leak
      ISDN_DRV_GIGASET should select, not depend on CRC_CCITT
      fs/nfsd/nfs4state.c: make a struct static
      video/aty/atyfb_base.c: fix an off-by-one error
      [WAN]: Remove broken and unmaintained Sangoma drivers.
      [ALSA] sound/core/pcm.c: make snd_pcm_format_name() static
      drivers/net/via-rhine.c: make a function static
      remove drivers/net/hydra.h
      USB: pci-quirks.c: proper prototypes
      USB: input/: proper prototypes
      USB: drivers/usb/core/: remove unused exports
      remove kernel/power/pm.c:pm_unregister()
      [IPV4]: Possible cleanups.
      drivers/char/drm/drm_memory.c: possible cleanups
      [CPUFREQ] drivers/cpufreq/cpufreq.c: static functions mustn't be exported
      [CPUFREQ] powernow-k8.c: fix a check-after-use

Alan Stern:
      USB: g_file_storage: Set short_not_ok for bulk-out transfers
      USB: g_file_storage: add comment about buffer allocation
      USB: g_file_storage: use module_param_array_named macro
      USB: UHCI: don't track suspended ports
      driver core: safely unbind drivers for devices not on a bus

Alessandro Zummo:
      RTC subsystem: DS1672 cleanup
      RTC subsystem: X1205 sysfs cleanup
      RTC subsystem: whitespaces and error messages cleanup
      RTC subsystem: fix proc output
      RTC subsystem: RS5C372 sysfs fix
      RTC subsystem: compact error messages
      RTC subsystem: SA1100 cleanup
      RTC subsystem: VR41XX cleanup

Alexey Dobriyan:
      ver_linux: don't print reiser4progs version if none found

Alexey Kuznetsov:
      IPC: access to unmapped vmalloc area in grow_ary()

Ananiev, Leonid I:
      ext3: Fix missed mutex unlock
      ext3: Fix missed mutex unlock

Andi Kleen:
      x86_64: Update defconfig
      x86_64: Clean up execve path
      x86_64: Support memory hotadd without sparsemem
      x86_64: Reserve SRAT hotadd memory on x86-64
      x86_64: Handle empty PXMs that only contain hotplug memory
      x86_64: Fix compilation with CONFIG_PCI=n / allnoconfig
      x86_64: Don't sanity check Type 1 PCI bus access on newer systems
      x86-64/i386: Don't process APICs/IO-APICs in ACPI when APIC is disabled.
      x86_64: Clear APIC feature bit when local APIC is disabled
      i386: Consolidate modern APIC handling
      x86_64: Revert earlier powernow-k8 change
      x86_64: Don't run NMI watchdog during machine checks
      x86_64: When user could have changed RIP always force IRET
      x86_64: Don't export strlen twice
      x86_64: Don't return error for HPET initialization in initcall
      i386/x86_64: Check if MCFG works for the first 16 busses
      i386/x86-64: Return defined error value for bad PCI config space accesses
      i386: Remove printk about reboot fixups at reboot
      x86_64: Eliminate IA32_NR_syscalls define
      x86_64: Update 32-bit system call table
      [CPUFREQ] x86_64: Revert earlier powernow-k8 change
      x86-64/i386: Don't process APICs/IO-APICs in ACPI when APIC is disabled.
      x86_64: Remove check for canonical RIP
      i386: Remove bogus special case code from AMD core parsing
      i386/x86-64: Remove checks for value == NULL in PCI config space access
      x86_64: Fix embarassing typo in mmconfig bus check
      x86_64: Update defconfig
      i386/x86-64: Fix ACPI disabled LAPIC handling mismerge
      x86_64: Increase NUMA hash function nodemap
      x86_64: Add tee and sync_file_range
      i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.

Andreas Gruenbacher:
      kbuild: modules_install for external modules must not remove existing modules

Andreas Schwab:
      Use pci_set_consistent_dma_mask in ixgb driver

Andrew Morton:
      [NET]: More kzalloc conversions.
      splice: warning fix
      select() warning fixes
      sync_file_range(): use unsigned for flags
      timer initialisation fix
      make tty_insert_flip_string_flags() a non gpl export
      sys_kexec_load() naming fixups
      hdaps: use ENODEV
      3ware: kmap_atomic() fix
      atyfb is bust on sparc32
      sparc32 vga support
      pm: print name of failed suspend function

Andy Whitcroft:
      page flags: add commentry regarding field reservation

Anton Blanchard:
      powerpc: Ensure runlatch is off in the idle loop
      powerpc: Avoid __initcall warnings

Antonino A. Daplas:
      vesafb: Fix incorrect logo colors in x86_64
      fbdev: Use logo with depth of 4 or less for static pseudocolor

Arjan van de Ven:
      x86_64: Rename e820_mapped to e820_any_mapped
      x86_64: Introduce e820_all_mapped
      i386/x86-64: Check that MCFG points to an e820 reserved area

Arnd Bergmann:
      inotify: check for NULL inode in inotify_d_instantiate

Ashley Clark:
      [ALSA] hda-codec - Adds HDA support for Intel D945Pvs board with subdevice id 0x0707

Ashok Raj:
      swsusp: don't require bigsmp

Atsushi Nemoto:
      kbuild: mips: fix sed regexp to generate asm-offset.h
      [MIPS] Enable SCHED_NO_NO_OMIT_FRAME_POINTER for MIPS.
      [MIPS] Fix tx49_blast_icache32_page_indexed.
      [MIPS] Use __ffs() instead of ffs() for waybit calculation.

Ben Dooks:
      [ARM] 3468/1: S3C2410: SMDK common include fix
      [ARM] 3469/1: S3C24XX: clkout missing hclk selector
      S3C24XX GPIO LED support
      leds: fix IDE disk trigger name
      leds: reorganise Kconfig
      leds: re-layout include/linux/leds.h
      [ARM] 3474/1: S3C2440: USB rate writes wrong var to CLKDIVN
      [ARM] 3475/1: S3C2410: fix spelling mistake in SMDK partition table
      USB: cleanups for ohci-s3c2410.c
      USB: S3C2410: use clk_enable() to ensure 48MHz to OHCI core

Bjorn Helgaas:
      [IA64] update HP CSR space discovery via ACPI
      [IA64] always map VGA framebuffer UC, even if it supports WB
      DMI: move dmi_scan.c from arch/i386 to drivers/firmware/

Brent Cook:
      mv643xx_eth: Always free completed tx descs on tx interrupt

Brian Gerst:
      kbuild: fix garbled text in modules.txt

Brian Haley:
      [NETFILTER]: Fix build with CONFIG_NETFILTER=y/m on IA64

Brian King:
      [SCSI] ipr: Disk remove path cleanup
      [SCSI] ipr: Fixup device type check
      [SCSI] ipr: Simplify status area dumping
      [SCSI] ipr: printk macro cleanup/removal
      [SCSI] ipr: Reset device cleanup
      [SCSI] ipr: Bump version

Brian Uhrain says:
      alpha: SMP boot fixes

Carl-Daniel Hailfinger:
      kbuild: fix unneeded rebuilds in drivers/media/video after moving source tree
      kbuild: fix unneeded rebuilds in drivers/net/chelsio after moving source tree

Catalin Marinas:
      [ARM] 3470/1: Clear the HWCAP bits for the disabled kernel features
      [ARM] 3471/1: FTOSI functions should return 0 for NaN
      [ARM] 3472/1: Use the D variants of FLDMIA/FSTMIA on ARMv6
      [ARM] 3473/1: Use numbers 0-15 for the VFP double registers

Chen, Kenneth W:
      [IA64] fix bug in ia64 __mutex_fastpath_trylock

Christoph Hellwig:
      move ->eh_strategy_handler to the transport class
      build kernel/irq/migration.c only if CONFIG_GENERIC_PENDING_IRQ is set
      [SCSI] unify SCSI_IOCTL_SEND_COMMAND implementations

Christoph Lameter:
      [IA64] Prefetch mmap_sem in ia64_do_page_fault()
      Fix NULL pointer dereference in node_read_numastat()
      Some page migration fixups

Corey Minyard:
      ipmi: fix event queue limit

Cornelia Huck:
      s390: wrong return codes in cio_ignore_proc_init()

Coywolf Qi Hunt:
      page-writeback comment fixes
      [ALSA] hda-codec - support HP Compaq Presario B2800 laptop with AD1986A codec

Dale Farnsworth:
      mv643xx_eth: Fix tx_timeout to only conditionally wake tx queue

Dale Sedivec:
      [ALSA] au88x0 - clean up __devinit/__devexit

Dan Aloni:
      sata_mv: properly print HC registers

Daniel Ritz:
      USB: usbtouchscreen: unified USB touchscreen driver
      usb/input: remove Kconfig entries of old touchscreen drivers in favour of usbtouchscreen

Dave Airlie:
      drm: Fix issue reported by Coverity in drivers/char/drm/via_irq.c
      drm: drm_pci needs dma-mapping.h
      drm: remove master setting from add/remove context
      drm: deline a few large inlines in DRM code

Dave C Boutcher:
      [SCSI] ibmvscsi: prevent scsi commands being sent in invalid state

Dave Hansen:
      x86_64: extra NODES_SHIFT definition

Dave Jones:
      [CPUFREQ] extra debugging in cpufreq_add_dev()
      [CPUFREQ] trailing whitespace removal de-jour.
      [CPUFREQ] Remove pointless check in conservative governor.
      [SELINUX] Fix build after ipsec decap state changes.
      splice: potential !page dereference
      S390: fix implicit declaration of (un)likely.
      Remove extraneous \n in doubletalk init printk.

David Brownell:
      USB: otg hub support is optional
      USB: fix gadget_is_musbhdrc()
      USB: net2280 short rx status fix
      USB: rndis_host whitespace/comment updates
      USB: gadgetfs highspeed bugfix
      USB: gadget zero poisons OUT buffers
      USB: at91 usb driver supend/resume fixes
      USB: usbtest: scatterlist OUT data pattern testing
      USB: g_ether, highspeed conformance fix
      dma doc updates
      Fix AT91RM9200 build breakage

David Chinner:
      [XFS] Fix inode reclaim scalability regression. When a filesystem has
      [XFS] Fix an inode use-after-free durin an unpin. When reclaiming inodes

David Hollis:
      USB: Rename ax8817x_func() to asix_func() and add utility functions to reduce bloat

David Howells:
      [Security] Keys: Fix oops when adding key to non-keyring
      Fix memory barrier docs wrt atomic ops
      Improve data-dependency memory barrier example in documentation
      Keys: Improve usage of memory barriers and remove IRQ disablement

David S. Miller:
      [X25]: Restore skb->dev setting in x25_type_trans().
      [IPV4] ip_fragment: Always compute hash with ipfrag_lock held.
      [SPARC64]: Add dummy PTRACE_PEEKUSR for gdb.
      [SPARC64]: Print out return PC in cheetah_log_errors().
      [SPARC64]: Update defconfig.
      [SPARC64]: Translate PTRACE_GETEVENTMSG for 32-bit tasks.
      [SPARC64]: smp_call_function() fixups...
      [SPARC64]: Set ARCH_SELECT_MEMORY_MODEL
      [SPARC]: Hook up sys_tee() into syscall tables.
      [SPARC64]: Export pcibios_resource_to_bus().

Davide Libenzi:
      uniform POLLRDHUP handling between epoll and poll/select

Denis Vlasenko:
      [IPV6]: Deinline few large functions in inet6 code

Dmitry Mishin:
      unaligned access in sk_run_filter()

Douglas Gilbert:
      [SCSI] sg: fix leak when dio setup fails

Eli Cohen:
      IPoIB: Wait for join to finish before freeing mcast struct
      IPoIB: Close race in ipoib_flush_paths()

Eric Sesterhenn:
      [BLUETOOTH] sco: Possible double free.
      Bogus NULL pointer check in fs/configfs/dir.c
      kbuild: fix NULL dereference in scripts/mod/modpost.c
      Wrong out of range check in drivers/char/applicom.c
      Overrun in cdrom/aztcd.c
      [DCCP]: Fix leak in net/dccp/ipv4.c
      [ISDN]: Static overruns in drivers/isdn/i4l/isdn_ppp.c
      [ALSA] Overrun in sound/pci/au88x0/au88x0_pcm.c

Eric Van Hensbergen:
      9p: handle sget() failure

Eric W. Biederman:
      de_thread: Don't confuse users do_each_thread.
      do_SAK: Don't recursively take the tasklist_lock
      de_thread: Don't change our parents and ptrace flags.
      kill unushed __put_task_struct_cb

Erik Mouw:
      [CPUFREQ] Update LART site URL

Folkert van Heusden:
      USB: add support for Papouch TMU (USB thermometer)

Frank Gevaerts:
      hdaps: add support for Thinkpad R52

FUJITA Tomonori:
      [SCSI] ibmvscsi: convert the ibmvscsi driver to use include/scsi/srp.h
      [SCSI] ibmvscsi: remove drivers/scsi/ibmvscsi/srp.h

Gary Zambrano:
      b44: disable default tx pause
      b44: increase version to 1.00

Geert Uytterhoeven:
      Update contact info for Geert Uytterhoeven

Greg Kroah-Hartman:
      USB: add driver for funsoft usb serial device

Grzegorz Janoszka:
      arch/i386/pci/irq.c - new VIA chipsets (fwd)

Guennadi Liakhovetski:
      USB: net2282 and net2280 software compatibility

H. Peter Anvin:
      [efficeon-agp] Add missing memory mask

Hannes Reinecke:
      [SCSI] aic79xx bus reset update
      [SCSI] aic79xx: target hotplug fixes

Herbert Poetzl:
      vfs: propagate mnt_flags into do_loopback/vfsmount

Herbert Xu:
      [IPSEC]: Check x->encap before dereferencing it
      [INET]: Move no-tunnel ICMP error to tunnel4/tunnel6
      [INET]: Use port unreachable instead of proto for tunnels
      [TCP]: Fix truesize underflow

Hideo AOKI:
      overcommit: add calculate_totalreserve_pages()
      overcommit: use totalreserve_pages
      overcommit: use totalreserve_pages for nommu

Hirokazu Takata:
      m32r: Fix cpu_possible_map and cpu_present_map initialization for SMP kernel
      m32r: security fix of {get,put}_user macros
      Remove unused prepare_to_switch macro
      m32r: Remove symbols exported twice

Horst Hummel:
      s390: dasd device offline messages
      s390: dasd proc entries

Hugh Dickins:
      shmat: stop mprotect from giving write permission to a readonly attachment (CVE-2006-1524)
      Fix MADV_REMOVE protection checking

Hyok S. Choi:
      frv: define MMU mode specific syscalls as 'cond_syscall' and clean up unneeded macros

Ian Abbott:
      USB: ftdi_sio: add support for Eclo COM to 1-Wire USB adapter

Ingo Molnar:
      introduce a "kernel-internal pipe object" abstraction
      splice: add optional input and output offsets
      get rid of the PIPE_*() macros
      pipe.c/fifo.c code cleanups
      splice: comment styles
      another round of fs/pipe.c cleanups

J. Bruce Fields:
      knfsd: svcrpc: WARN() instead of returning an error from svc_take_page

Jack Morgenstein:
      IB: simplify static rate encoding
      IB/mthca: Fix max_srq_sge returned by ib_query_device for Tavor devices

Jacob Shin:
      x86_64: Proper null pointer check in powernow_k8_get

jacob.shin@amd.com:
      [CPUFREQ] x86_64: Proper null pointer check in powernow_k8_get

Jamal Hadi Salim:
      [PKT_SCHED] act_police: Rename methods.
      [XFRM]: Fix aevent timer.
      [XFRM]: Add documentation for async events.

James Bottomley:
      [SCSI] remove qlogicfc
      [SCSI] expose sas internal class for the domain transport
      [SCSI] add SCSI_UNKNOWN and LUN transfer limit restrictions
      [SCSI] scsi_transport_sas: don't scan a non-existent end device

James Courtier-Dutton:
      [ALSA] emu10k1: Add some descriptive text.

James Smart:
      [SCSI] FC transport: fixes for workq deadlocks

Jan-Benedict Glaw:
      Silence a const vs non-const warning

Jayachandran C:
      [BRIDGE] ebtables: fix allocation in net/bridge/netfilter/ebtables.c
      driver core: fix unnecessary NULL check in drivers/base/class.c
      drm: Fix further issues in drivers/char/drm/via_irq.c

Jean Delvare:
      i2c: convert ds1374 to use a workqueue
      w83792d: Be quiet on misdetection
      PCI: Add PCI quirk for SMBus on the Asus A6VA notebook

Jean-Luc Léger:
      [SPARC64]: Fix dependencies of HUGETLB_PAGE_SIZE_64K

Jeff Dike:
      UML: TLS fixlets
      Add GFP_NOWAIT
      uml: memory hotplug cleanups
      fuse: add O_ASYNC support to FUSE device
      fuse: add O_NONBLOCK support to FUSE device

Jeff Garzik:
      [libata] sata_mv: fix can_queue line accidentally removed in scsi-eh patch
      [netdrvr b44] trim trailing whitespace

Jeffrey Vandenbroucke sign:
      hid-core.c: fix "input irq status -32 received" for Silvercrest USB Keyboard

Jens Axboe:
      splice: mark the io page as accessed
      splice: only call wake_up_interruptible() when we really have to
      splice: cleanup __generic_file_splice_read()
      splice: optimize the splice buffer mapping
      splice: be smarter about calling do_page_cache_readahead()
      splice: add direct fd <-> fd splicing support
      splice: speedup __generic_file_splice_read
      splice: speedups and optimizations
      splice: unlikely() optimizations
      splice: add Ingo as addition copyright holder
      splice: pass offset around for ->splice_read() and ->splice_write()
      splice: add support for sys_tee()

Jesper Juhl:
      [NET]: Remove redundant NULL checks before [kv]free

Jing Min Zhao:
      [NETFILTER]: H.323 helper: move some function prototypes to ip_conntrack_h323.h
      [NETFILTER]: H.323 helper: change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
      [NETFILTER]: H.323 helper: make get_h245_addr() static
      [NETFILTER]: H.323 helper: add parameter 'default_rrq_ttl'

Joe Korty:
      add cpu_relax to hrtimer_cancel

Joern Engel:
      Remove blkmtd

John Blackwood:
      x86_64: Plug GS leak in arch_prctl()

John Rose:
      PCI: rpaphp: remove init error condition

John W. Linville:
      pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)

Jordan Crouse:
      Enable TSC for AMD Geode GX/LX

Jordan Hargrave:
      x86_64: Fix drift with HPET timer enabled

Jordi Caubet:
      spufs: fix context-switch decrementer code

KAMEZAWA Hiroyuki:
      [ARM] arm's arch_local_page_offset() fix against 2.6.17-rc1
      [IA64] for_each_possible_cpu: ia64
      for_each_possible_cpu: network codes
      for_each_possible_cpu: sparc
      for_each_possible_cpu: sparc64
      [SCSI] for_each_possible_cpu: scsi

Kay Sievers:
      BLOCK: delay all uevents until partition table is scanned

Keith Owens:
      [IA64] Pass more data to the MCA/INIT notify_die hooks
      [IA64] Failure to resume after INIT in user space
      Reinstate const in next_thread()
      [IA64] ia64_wait_for_slaves() incorrectly reports MCA

Komuro:
      network: axnet_cs.c: add missing 'PRIV' in ei_rx_overrun

Kumar Gala:
      RTC subsystem: DS1672 oscillator handling

Kyle McMartin:
      No arch-specific strpbrk implementations
      Clean up arch-overrides in linux/string.h

Lennert Buytenhek:
      [ARM] 3459/1: ixp23xx: fix debug serial macros for big-endian operation

Linas Vepstas:
      powerpc/pseries: bugfix: balance calls to pci_device_put

Linus Torvalds:
      Move request_standard_resources() back to before PCI probing
      x86: don't allow tail-calls in sys_ftruncate[64]()
      x86: be careful about tailcall breakage for sys_open[at] too
      Linux v2.6.17-rc2

Linus Walleij:
      [IRDA]: smcinit merged into smsc-ircc driver
      [IRDA]: smsc-ircc2, smcinit support for ALi ISA bridges

Luiz Fernando Capitulino:
      USB serial: Converts port semaphore to mutexes.

Luke Yang:
      nommu: use compound page in slab allocator

mao, bibo:
      x86_64: inline function prefix with __always_inline in vsyscall

Mark A. Greer:
      i2c: convert m41t00 to use a workqueue

Mark Bellon:
      MPBL0010 driver sysfs permissions wide open

Mark Fasheh:
      ocfs2: multi node truncate fix
      ocfs2: remove an overly aggressive BUG() in dlmfs
      ocfs2: catch an invalid ast case in dlmfs
      ocfs2: Handle the DLM_CANCELGRANT case in user_unlock_ast()
      ocfs2: test and set teardown flag early in user_dlm_destroy_lock()
      ocfs2: Better I/O error handling in heartbeat

Mark Haverkamp:
      [SCSI] aacraid: Use scmd_ functions
      [SCSI] aacraid: Track command ownership in driver
      [SCSI] aacraid: Add timeout for events
      [SCSI] aacraid: Error path cleanup
      [SCSI] aacraid: Fix error in max_channel field
      [SCSI] aacraid: Fix extra unregister_chrdev
      [SCSI] aacraid: General driver cleanup
      [SCSI] aacraid: Re-start helper thread if it dies
      [SCSI] aacraid: Show max channel and max id is sysfs
      [SCSI] aacraid: Fix parenthesis placement error
      [SCSI] aacraid: Driver version update

Mark M. Hoffman:
      i2c-sis96x: Remove an init-time log message
      i2c-parport: Make type parameter mandatory

Martin Michlmayr:
      parport: remove duplicate entry for NETMOS_9835

Martin Schwidefsky:
      s390: update default configuration

Matthew Wilcox:
      [SCSI] Change Kconfig option from IOMAPPED to MMIO
      [SCSI] Use pcibios_resource_to_bus()
      [SCSI] Simplify error handling a bit
      [SCSI] Mark div_10M array const
      [SCSI] Disable sym2 driver queueing
      [SCSI] Use SPI messages where possible
      [SCSI] Allow nvram settings to determine bus mode
      [SCSI] Simplify error handling
      [SCSI] Enable clustering and large transfers
      [SCSI] Version 2.2.3
      [SCSI] sym2: Fix build when spinlock debugging is enabled

Matthias Urlichs:
      Overrun in option-card USB driver

matthieu castet:
      USB: UEAGLE : cosmetic
      USB: UEAGLE : support geode
      USB: UEAGLE : null pointer dereference fix
      USB: UEAGLE : memory leack fix

Michael Chan:
      [TG3]: Kill some less useful flags
      [TG3]: Speed up SRAM access (2nd version)

Michael Downey:
      USB: keyspan-remote bugfix

Michael Ellerman:
      powerpc: Fix machine detection in prom_init.c

Michael S. Tsirkin:
      IB/mad: fix oops in cancel_mads
      IPoIB: Consolidate private neighbour data handling
      IB/mthca: Disable tuning PCI read burst size
      IB/cache: Use correct pointer to calculate size

Mike Anderson:
      [SCSI] sas transport: ref count update

Mike Christie:
      [SCSI] fix sg leak when scsi_execute_async fails

Mike Galbraith:
      sched: fix interactive task starvation
      sched: don't awaken RT tasks on expired array

Mike Miller:
      cciss: bug fix for crash when running hpacucli

Miklos Szeredi:
      fuse: fix oops in fuse_send_readpages()
      fuse: fix fuse_dev_poll() return value
      fuse: simplify locking
      fuse: use a per-mount spinlock
      fuse: consolidate device errors
      fuse: clean up request accounting
      fuse: account background requests
      [fuse] fix deadlock between fuse_put_super() and request_end()
      [fuse] Fix accounting the number of waiting requests
      [fuse] Don't init request twice
      [fuse] Direct I/O  should not use fuse_reset_request

Mitchell Blank Jr:
      select: don't overflow if (SELECT_STACK_ALLOC % sizeof(long) != 0)

Moore, Eric:
      [SCSI] mptfusion - fix panic in mptsas_slave_configure

Nathan Scott:
      [XFS] Fix superblock validation regression for the zero imaxpct case. 
      [XFS] Fix a writepage regression where we accidentally stopped honouring
      [XFS] Fix utime(2) in the case that no times parameter was passed in.
      [XFS] Fix a problem in aligning inode allocations to stripe unit

NeilBrown:
      md: make sure 64bit fields in version-1 metadata are 64-bit aligned
      knfsd: Correct reserved reply space for read requests.
      knfsd: locks: flag NFSv4-owned locks
      knfsd: nfsd4: Wrong error handling in nfs4acl
      knfsd: nfsd4: better nfs4acl errors
      knfsd: nfsd4: fix acl xattr length return
      knfsd: nfsd: oops exporting nonexistent directory
      knfsd: nfsd: nfsd_setuser doesn't really need to modify rqstp->rq_cred.
      knfsd: nfsd4: remove nfsd_setuser from putrootfh
      knfsd: nfsd4: fix corruption of returned data when using 64k pages
      knfsd: nfsd4: fix corruption on readdir encoding with 64k pages
      knfsd: svcrpc: gss: don't call svc_take_page unnecessarily
      knfsd: nfsd4: fix laundromat shutdown race
      knfsd: nfsd4: nfsd4_probe_callback cleanup
      knfsd: nfsd4: add missing rpciod_down()
      knfsd: nfsd4: limit number of delegations handed out.
      knfsd: nfsd4: grant delegations more frequently
      sysfs: Allow sysfs attribute files to be pollable

Nick Piggin:
      Fix buddy list race that could lead to page lru list corruptions

Nicolas Pitre:
      [ARM] 3477/1: ARM EABI: undefine removed syscalls

OGAWA Hirofumi:
      Remove sys_ prefix of new syscalls from __NR_sys_*
      [ALSA] pcm_oss: fix snd_pcm_oss_release() oops
      [PATCH 1/2] iosched: fix typo and barrier()
      [PATCH 2/2] cfq: fix cic's rbtree traversal
      cfq: Further rbtree traversal and cfq_exit_queue() race fix

Olaf Hering:
      powerpc32: Set cpu explicitly in kernel compiles

Oleg Nesterov:
      __group_complete_signal: remove bogus BUG_ON

Paolo 'Blaisorblade' Giarrusso:
      [NET] kzalloc: use in alloc_netdev
      kbuild: fix mode of checkstack.pl and other files.
      uml: make 64-bit COW files compatible with 32-bit ones
      uml: safe migration path to the correct V3 COW format
      uml: fix 2 harmless cast warnings for 64-bit
      uml: request format warnings to GCC for appropriate functions
      uml: fix format errors
      uml: fix some double export warnings
      uml: fix "extern-vs-static" proto conflict in TLS code
      uml: fix critical typo for TT mode
      uml: support sparse for userspace files
      uml: move outside spinlock call not needing it
      uml: fix hang on run_helper() failure on uml_net
      uml: fix failure path after conversion
      uml: fix big stack user
      uml: local_irq_save, not local_save_flags
      uml: fix parallel make early failure on clean tree
      uml: avoid warnings for diffent names for an unsigned quadword
      module support: record in vermagic ability to unload a module

Patrick McHardy:
      [NETFILTER]: Fix fragmentation issues with bridge netfilter
      [NETFILTER]: Add helper functions for mass hook registration/unregistration
      [NETFILTER]: Clean up hook registration
      [NETFILTER]: Fix section mismatch warnings
      [NETFILTER]: Fix IP_NF_CONNTRACK_NETLINK dependency
      [NETFILTER]: Introduce infrastructure for address family specific operations
      [NETFILTER]: Add address family specific checksum helpers
      [NETFILTER]: Convert conntrack/ipt_REJECT to new checksumming functions
      [NETFILTER]: H.323 helper: remove changelog
      [NETFILTER]: Fix DNAT in LOCAL_OUT

Paul Fulghum:
      ptmx: fix duplicate idr_remove
      tty release_dev(): remove dead code
      USB: remove __init from usb_console_setup

Paul Mackerras:
      powerpc: Fix CHRP booting - needs a define_machine call
      powerpc: Use correct sequence for putting CPU into nap mode

Pekka J Enberg:
      vfs: add splice_write and splice_read to documentation

Pete Zaitcev:
      USB: linux/usb/net2280.h common definitions

Peter Oberparleiter:
      s390: ebdic to ascii conversion tables
      s390: invalid check after kzalloc()
      s390: increase cio_trace debug event size
      s390: fail-fast requests on quiesced devices
      s390: minor tape fixes

Petko Manolov:
      USB: pegasus driver bugfix

Ping Cheng:
      USB: wacom tablet driver update
      USB: add new wacom devices to usb hid-core list

Ralf Baechle:
      [MIPS] Cleanup free_initmem the same way as i386 did.
      [MIPS] Make set_vi_srs_handler static.
      [MIPS] Remove redundant initialization of sr_allocated.
      [MIPS] Fixup printk in mips_srs_init.
      [MIPS] Some formatting fixes.
      [MIPS] Provide access functions for c0_badvaddr.
      [MIPS] Fix vectored interrupt support in TLB exception handler generator.
      [MIPS] More SHT_* and SHF_* ELF definitions.
      [MIPS] Wire splice syscall.
      [MIPS] Wire up sync_file_range(2).
      [MIPS] Sort out duplicate exports.
      [MIPS] Fix breakage due to the grand makefile crapectomy.
      [MIPS] Rewrite spurious_interrupt from assembler to C.
      [MIPS] PNX8550 build fix.
      [MIPS] Fix CONFIG_LIMITED_DMA build.
      [MIPS] ITE8172: Fix build error due to missmatching prototypes.
      [MIPS] Jaguar: Fix build errors after the recent move of Marvell headers.
      [MIPS] MV6434x: The name of the CPP symbol is __mips__, not __MIPS__.
      [MIPS] ITE: Glue build.
      [MIPS] it8172: Fix build of serial driver.
      [MIPS] MV6434x: Add prototype of interrupt dispatch function.
      [MIPS] Ocelot 3: Fix build errors after the recent move of Marvell headers.
      [MIPS] EV96100: Fix over two year old typo in variable name.
      [MIPS] EV96100: ev96100_cpu_irq needs a struct pt_regs argument.
      [MIPS] JMR3927 build fixes for the RTC code.
      [MIPS] Replace redundant declarations of _end by <asm/sections.h>.
      [MIPS] Fixup damage done by 22a9835c350782a5c3257343713932af3ac92ee0.
      [MIPS] Fix the crime against humanity that mipsIRQ.S is.
      [MIPS] Rewrite all the assembler interrupt handlers to C.
      [MIPS] Use "R" constraint for cache_op.
      [MIPS] R2: Implement shadow register allocation without spinlock.
      [MIPS] Fix genrtc compilation.
      [MIPS] R2: Instruction hazard barrier.
      [MIPS] kpsd and other AP/SP improvements.
      [MIPS] MT: Improved multithreading support.
      [MIPS] FPU affinity for MT ASE.
      [MIPS] kgdb: Let gcc compute the array size itself.
      [MIPS] MIPS boards: Set HZ to 100.
      [MIPS] Make mips_srs_init static.
      [MIPS] Handle IDE PIO cache aliases on SMP.
      [MIPS] Fix Makefile bugs for MIPS32/MIPS64 R1 and R2.
      [MAINTAINERS] The ham radio code now has website at http://www.linux-ax25.org.

Ram Gupta:
      mm: fix bug in brk()

Randy Dunlap:
      [NET] netconsole: set .name in struct console
      hugetlbfs doc. update
      i386: print EIP/ESP last
      menu: relocate DOUBLEFAULT option
      mpparse: prevent table index out-of-bounds
      mptspec: remove duplicate #include
      docs: laptop-mode.txt source file build
      Doc: fix mtrr userspace programs to build cleanly
      kexec: update MAINTAINERS
      net drivers: fix section attributes for gcc
      isd200: limit to BLK_DEV_IDE

Ravikiran G Thirumalai:
      x86_64: Fixup read_mostly section on internode cache line size for vSMP
      slab: allocate node local memory for off-slab slabmanagement
      slab: add statistics for alien cache overflows

Rene Herman:
      [ALSA] continue on IS_ERR from platform device registration
      [ALSA] unregister platform device again if probe was unsuccessful

Richard Purdie:
      [ARM] 3478/1: SharpSL SCOOP: Fix potenial build failure
      [ARM] 3479/1: Corgi SSP: Fix potential concurrent access problem

Robert Love:
      hdaps: support new Lenovo machines

Robert Olsson:
      [FIB_TRIE]: Fix leaf freeing.

Robin Holt:
      [IA64] Make show_mem() skip holes in a pgdat

Roger Luethi:
      via-rhine: execute bounce buffers code on Rhine-I only

Roland Dreier:
      IPoIB: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/mthca: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/srp: Fix memory leak in options parsing
      IPoIB: Use spin_lock_irq() instead of spin_lock_irqsave()
      PCI: fix sparse warning about pci_bus_flags

Roland McGrath:
      process accounting: take original leader's start_time in non-leader exec
      fix non-leader exec under ptrace

Roman Zippel:
      kconfig: fix default value for choice input
      kconfig: revert conf behaviour change
      kconfig: recenter menuconfig
      kconfig: fix typo in change count initialization

Russell King:
      [ARM] Remove unnecessary extra parens in include/asm-arm/memory.h
      [ARM] Move FLUSH_BASE macros to asm/arch/memory.h
      [ARM] Fix ebsa110 debug macros
      [ARM] ebsa110: Fix incorrect serial port address
      [ARM] Fix SA110/SA1100 cache flushing
      [ARM] Allow decompressor to be built with -ffunction-sections
      [SERIAL] Update serial driver documentation

Ryan Wilson:
      driver core: driver_bind attribute returns incorrect value

Sam Ravnborg:
      kbuild: use relative path to -I
      kbuild: fix building single targets with make O=.. single-target
      kbuild: fix make dir/
      kbuild: properly pass options to hostcc when doing make O=..
      x86_64: fix CONFIG_REORDER
      kbuild: rebuild initramfs if content of initramfs changes
      kbuild: fix false section mismatch warnings

Samuel Ortiz:
      [IRDA]: Support for Sigmatel STIR421x chip
      [IRDA]: irda-usb, unregister netdev when patch upload fails

Samuel Thibault:
      Enhancing accessibility of lxdialog

Sergey Vlasov:
      [NET]: Fix hotplug race during device registration.

Shaohua Li:
      PCI: MSI(X) save/restore for suspend/resume

Shirley Ma:
      IPoIB: Make send and receive queue sizes tunable

Siddha, Suresh B:
      x86_64: fix sync before RDTSC on Intel cpus

Stephen Hemminger:
      [BRIDGE]: receive link-local on disabled ports.
      dlink pci cards using wrong driver
      sky2: bad memory reference on dual port cards
      [ATM]: clip causes unregister hang
      [ATM]: Clip timer race.
      [ATM] clip: run through Lindent
      [ATM] clip: get rid of PROC_FS ifdef
      [ATM] clip: notifier related cleanups
      [ATM] clip: add module info
      [IPV4]: ip_route_input panic fix

Stephen Rothwell:
      powerpc: iSeries has only 256 IRQs
      Fix block device symlink name

Takashi Iwai:
      [ALSA] Fix Oops of PCM OSS emulation
      [ALSA] hda-codec - Add another HP laptop with AD1981HD
      [ALSA] via82xx - Add a dxs entry for ECS K8T890-A
      [ALSA] hda-codec - Add support of ASUS U5A with AD1986A codec
      [ALSA] ac97 - Add entry for VIA VT1618 codec

Tejun Heo:
      [SCSI] SCSI: fix scsi_kill_request() busy count handling

Thomas Renninger:
      [CPUFREQ] If max_freq got reduced (e.g. by _PPC) a write to sysfs scaling_governor let cpufreq core stuck at low max_freq for ever

Tilman Schmidt:
      isdn4linux: Siemens Gigaset drivers: code cleanup
      isdn4linux: Siemens Gigaset drivers: Kconfig correction
      isdn4linux: Siemens Gigaset drivers: timer usage
      isdn4linux: Siemens Gigaset drivers: logging usage
      isdn4linux: Siemens Gigaset drivers: sysfs usage
      isdn4linux: Siemens Gigaset drivers: remove IFNULL macros
      isdn4linux: Siemens Gigaset drivers: uninline
      isdn4linux: Siemens Gigaset drivers: eliminate from_user argument
      isdn4linux: Siemens Gigaset drivers: mutex conversion
      isdn4linux: Siemens Gigaset drivers: remove private version of __skb_put()
      isdn4linux: Siemens Gigaset drivers: remove forward references
      isdn4linux: Siemens Gigaset drivers: add README
      isdn4linux: Siemens Gigaset drivers: make some variables non-atomic

Tobias Klauser:
      Last DMA_xBIT_MASK cleanups
      [CPUFREQ] Remove duplicate check in powernow-k8

Tomasz Kazmierczak:
      USB: pl2303: added support for OTi's DKU-5 clone cable

Tony Lindgren:
      [ARM] 3460/1: ARM: OMAP: Remove unnecessary nop_release()
      [ARM] 3461/1: ARM: OMAP: Fix clk_get() when using id and name

Tony Luck:
      [IA64] Wire up new syscall sync_file_range()
      [IA64] 'msg' may be used uninitialized in xpc_initiate_allocate()
      [IA64] Wire up new syscalls {set,get}_robust_list

Vitaly Bordug:
      ppc32: Fix string comparing in platform_notify_map

Vivek Goyal:
      kdump proc vmcore size oveflow fix
      kdump: enable CONFIG_PROC_VMCORE by default
      x86_64: x86_64 add crashdump trigger points

Yasunori Goto:
      Configurable NODES_SHIFT

Yoichi Yuasa:
      RTC subsystem: VR41XX driver
      [MIPS] Added tb0287_defconfig back.
      [MIPS] Fix VR41xx build errors.

YOSHIFUJI Hideaki:
      [IPV6]: Ensure to have hop-by-hop options in our header of &sk_buff.
      [IPV6] XFRM: Don't use old copy of pointer after pskb_may_pull().
      [IPV6] XFRM: Fix decoding session with preceding extension header(s).
      [IPV6]: Clean up hop-by-hop options handler.

Zach Brown:
      [IPv6] reassembly: Always compute hash under the fragment lock.
      ip_output: account for fraggap when checking to add trailer_len

--21872808-700635566-1145417257=:3701--
