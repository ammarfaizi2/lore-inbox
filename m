Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVAVCPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVAVCPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAVCPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:15:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:5017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262448AbVAVCOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:14:00 -0500
Date: Fri, 21 Jan 2005 18:13:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.11-rc2
Message-ID: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, trying to calm things down again for a 2.6.11 release.

Tons of small cleanups, annotations and fixes here. Driver updates, 
cpufreq, ppc, parisc, arm.. Pls check that I got it all.

		Linus

---
Summary of changes from v2.6.11-rc1 to v2.6.11-rc2
============================================

Adam Kropelin:
  o contort getdents64 to pacify gcc-2.96

Adrian Bunk:
  o [NET]: misc cleanups
  o SCSI aic7xxx: kill kernel 2.2 #ifdef's
  o [DECNET]: Misc cleanups
  o [IPV6]: Misc cleanups
  o [NET]: net/802/: some cleanups
  o [XFRM]: Unexport xfrm_policy_delete

Alan Cox:
  o [AX25]: Revert to 2.6.9 behavior
  o smbfs fixes

Alan Stern:
  o USB UHCI: protect DMA-able fields with barriers
  o USB: correct and clarify error-code documentation

Alexander Viro:
  o miri_sbus iomem annotations
  o hamachi iomem annotations
  o bmac iomem annotations
  o s2io iomem annotations and cleanups

Alexey Dobriyan:
  o USB: drivers/usb/*: s/0/NULL/ in pointer context

Alexey Kuznetsov:
  o [TCP]: Do not try to collapse multi-packet SKBs

Andi Kleen:
  o Fix gcc4 compilation in s2io net driver
  o x86_64: Fix ACPI SRAT NUMA parsing
  o x86_64: Fix K8 NUMA discovery
  o [3/4] x86_64: Fix NUMA hash setup
  o [4/4] Fix numa=off command line parsing
  o x86_64: Add brackets to bitops
  o x86_64: Move early CPU detection earlier
  o x86_64: Disable uselib when possible
  o x86_64: Optimize nodemask operations slightly
  o [NET]: Use unlocked_ioctl for sock_ioctl
  o x86_64: Fix CMP with interleaving
  o x86_64: fix flush race on context switch
  o i386/x86-64: Fix SMP NMI watchdog race
  o x86-64: Fix pud typo in ioremap
  o x86-64: Clean up cpuid level detection
  o Use -Wno-pointer-sign for gcc 4.0
  o Convert XFS to unlocked_ioctl and compat_ioctl
  o Some fixes for compat ioctl
  o Convert Infiniband MAD driver to compat/unlocked_ioctl
  o Support compat_ioctl for block devices
  o Convert cciss to compat_ioctl
  o Add compat_ioctl to frame buffer layer
  o Convert sis fb driver to compat_ioctl
  o Convert dv1394 driver to compat_ioctl
  o Convert video1394 driver to compat_ioctl
  o Convert amdtp driver to compat_ioctl

Andreas Gruenbacher:
  o ext3/ea: revert old ea-in-inode patch
  o ext3/EA: mbcache cleanup
  o ext3/EA: Race in ext[23] xattr sharing code
  o ext3/EA: Ext3: do not use journal_release_buffer
  o ext3/EA: Ext3: factor our common xattr code; unnecessary lock
  o ext3/EA: Ext[23]: no spare xattr handler slots needed
  o ext3/EA: Cleanup and prepare ext3 for in-inode xattrs
  o ext3/EA: Hide ext3_get_inode_loc in_mem option
  o ext3/EA: In-inode extended attributes for ext3

Andreas Schwab:
  o [IA64] Fix PTRACE_GETEVENTMSG ia32 emulation

Andrew Morton:
  o eepro build fix
  o ixgb whitespace fix
  o 3c515 warning fix
  o [SPARC64]: Make first arg to find_next_zero_bit() const
  o acpi build fix
  o convert-cciss-to-compat_ioctl fix

Anton Blanchard:
  o ppc64: lacks definition of MM_VM_SIZE()
  o ppc64: Remove CONFIG_IRQ_ALL_CPUS

Antonino Daplas:
  o fbdev: Cleanup broken edid fixup code
  o fbcon: Catch blank events on both device and console level
  o fbcon: Fix compile error
  o fbdev: Fbmon cleanup
  o i810fb: Module param fix
  o atyfb: Fix module parameter descriptions
  o radeonfb: Fix init/exit section usage
  o pxafb: Reorder add_wait_queue() and set_current_state()
  o sa1100fb: Reorder add_wait_queue() and set_current_state()
  o backlight: Add Backlight/LCD device basic support
  o fbdev: Add w100 framebuffer driver

Aristeu Sergio Rozanski Filho:
  o eepro: cache EEPROM values
  o eepro: use module_param macros
  o eepro: basic ethtool support
  o eepro: fix return value in init_module()
  o eepro: fix auto-detection option

Arjan van de Ven:
  o [NETLINK]: Kill netlink_post, no longer used
  o [IPVS]: Kill check_for_ip_vs_out, no longer used

Arkadiusz Miskiewicz:
  o USB: add Ever UPS vendor/product id to ftdi_sio driver

Arnaldo Carvalho de Melo:
  o [UDP] merge udp_sock with udp_opt
  o [RAW] merge raw_sock with raw_opt
  o [SCTP] merge sctp_sock with sctp_opt
  o [IPV6] merge raw6_sock with raw6_opt
  o [IPX] use a private slab cache for socks

Arthur Kepner:
  o [TG3]: Always copy receive packets when 5701 PCIX workaround
    enabled

Bart De Schuymer:
  o [BRIDGE-NF]: Check ipv4 vs ipv6 more reliably in ip_sabotage_out()

Bartlomiej Zolnierkiewicz:
  o [ide] ide-cd: use ssleep() instead of schedule_timeout()
  o [ide] make try_to_flush_leftover_data() static
  o [ide] kill ide_drive_t->suspend_reset
  o [ide] icside: use ide_dma_intr()
  o [ide] ide-v10: use ide_dma_intr()
  o [ide] kill default_{attach,cleanup}()

Ben Dooks:
  o [ARM PATCH] 2376/1: S3C2410 - cleanup 2410/2440 distinctions, fix
    build
  o [ARM PATCH] 2390/1: Simtec Electronics MAINTAINERS file entries
  o [ARM PATCH] 2403/1: S3C2410 - clock initialsation tidy
  o [ARM PATCH] 2407/1: S3C2410 - remove fixed base from IIS registers
  o [ARM PATCH] 2408/1: S3C2410 - dma get position call
  o [ARM PATCH] 2409/2: BAST - nand slot description
  o [ARM PATCH] 2413/1: VR1000 - add serial ports to vr1000-map.h
  o [ARM PATCH] 2414/1: VR1000 - add serial platform device
  o [ARM PATCH] 2415/1: VR1000 - add platform device for flash
  o [ARM PATCH] 2416/1: S3C2410 - default configuration update
  o [ARM PATCH] 2421/1: bitops.h missing `const` from find calls
  o [ARM PATCH] 2422/1: VR1000 - use UPF_IOREMAP for serial ports
  o [ARM PATCH] 2424/1: S3C2410 - Document add HP iPAQ rx3715 overview

Benjamin Herrenschmidt:
  o ppc32: Fix pmac kernel build with oprofile
  o ppc32: update cpu state save/restore
  o ppc32: Add missing prototype
  o ppc64/ppc: Cleanup PCI skipping

Bjorn Helgaas:
  o [IA64] reset console_loglevel so INIT output always goes to console
  o PCI: use modern format for PCI addresses

Bodo Stroesser:
  o uml: add stack addresses to dumps

Bruno Ducrot:
  o [CPUFREQ] ondemand: don't increase to full speed at startup (Bruno
    Ducrot)

Carsten Otte:
  o s390: vol1 partition recognition

Catalin Marinas:
  o [ARM PATCH] 2389/1: semaphore.c warning fixed
  o [ARM PATCH] 2399/1: asm/constants.h included in
    arch/arm/vfp/entry.S
  o [ARM PATCH] 2401/1: asm/thread_info.h removed from
    arch/arm/vfp/entry.S
  o [ARM PATCH] 2404/1: BTAC/BTB flushing added in cpu_v6_switch_mm

Chas Williams:
  o [ATM]: [drivers] pci_enable_device() before finding irq
  o [ATM]: [lec] rewrite to eliminate lec_arp_users in favor of
    lec_arp_lock
  o [ATM]: [he] remove dead code and unneeded zero initializers
  o [ATM]: change atm address functions to use list_add
  o [ATM]: avoid race between svc_disconnect and sigd exiting
  o [ATM]: [ambassador] use msleep() instead of schedule_timeout()
  o [ATM]: [idt77252] vfree() checking cleanups

Chris Wedgwood:
  o uml: fail xterm_open when we have no $DISPLAY

Chris Wright:
  o mips default mlock limit fix
  o consolidate arch specific resource.h headers

Christian Bornträger:
  o reintroduce task_nice export for binfmt_elf32

Christoph Hellwig:
  o gdth: cleanup compat clutter
  o [NET]: Add rtnl_lock_interruptible()
  o [8139TOO]: Use rtnl_lock_interruptible()
  o mark arcdev_setup static
  o [IPV6]: Fix EUI64 generation on S/390
  o move read-only and immutable checks into permission()
  o factor out common code around ->follow_link invocation
  o binfmt_elf: allow mips to overrid e_flags
  o remove bogus softirq_pending() usage in cris
  o switch FRV to use local_soft_irq_pending
  o fix INIT_SIGHAND warning on mips
  o add page_offset to mm.h
  o fat: merge msdos_fs_{i,sb}.h into msdos_fs.h

Corey Minyard:
  o Minor IPMI driver updates

Daniel McNeil:
  o generic_file_buffered_write: handle partial DIO writes with
    multiple iovecs

Dave Boutcher:
  o ibmvscsi: limit size of I/O requests, updated
  o ibmvscsi: fix loop exit condition
  o ibmvscsi: fix dangling pointer reference
  o ibmvscsi: fix abort and reset error path

Dave Jones:
  o [CPUFREQ] make ondemand governor aware of CPU domains
  o [CPUFREQ] powernow-k7: ACPI perflib unregistration cleanup
  o [CPUFREQ] powernow-k8: unregister from ACPI perflib in error path
  o [CPUFREQ] re-add call to cpufreq_driver->resume()
  o [CPUFREQ] acpi-cpufreq: force setting of P-State upon resume
  o [CPUFREQ] core: CPUFREQ_GOV_STOP needs to be last
  o [CPUFREQ] nforce2: use unified cpufreq debug infrastructure
  o [CPUFREQ] powernow-k8: handle invalid initial frequency/voltage
    pairs correctly
  o [CPUFREQ] speedstep-centrino: fix SMP memory leak
  o [CPUFREQ] Check in missing file for cpufreq stats
  o [CPUFREQ] speedstep-centrino: transient MSR values (Venkatesh
    Pallipadi)
  o [CPUFREQ] speedstep-centrino: quieten driver (Venkatesh Pallipadi)
  o [CPUFREQ] userspace: remove /proc/sys/cpu/ interface
  o [CPUFREQ] proc_cpufreq: remove /proc/cpufreq interface
  o matroxfb driver broken on non-x86
  o [CPUFREQ] cpufreq mailing list changed its DNS entry
  o [CPUFREQ] Fix up more instances of the old cpufreq list URLs
  o [CPUFREQ] p4-clockmod: Dothan is 13 not 0x13
  o [CPUFREQ] gx-suspmod: fix gx_suspmod_get
  o [CPUFREQ] Fix structure name usage in powernow-k8 With 2.6.10-mm2
    (or even with -mm1) some structures in struct psb_s have been
    renamed in powernow-k8.h, but the renaming has not been done
    properly for all
  o [CPUFREQ] Remove reference to obsolete cpufreq bits
  o [AGPGART] i915GM support
  o [AGPGART] remove leftovers of the inter_module_* drm <-> agp
    interface
  o [AGPGART] fix pci_get_device conversion in intel-agp
  o [AGPGART] Fix CONFIG_AGP dependancies
  o [CPUFREQ] Fix typo in powernow-k7 voltage table
  o [AGPGART] Fix silly typo in the i915GM support patch

David Brownell:
  o USB: usbnet:  Olympus R1000 PDA, and blacklisting if CDC && !ZAURUS

David Gibson:
  o Another trivial orinoco update

David Howells:
  o PCI: Downgrade printk that complains about unsupported PCI PM caps
  o FRV: Remove mandatory single-step debugging diversion
  o FRV: Excess whitespace cleanup

David Mosberger:
  o [IA64] add hpzx1_swiotlb machine-vector
  o [IA64] add hpzx1_swiotlb machine-vector (new files)
  o avoid sparse warning due to time-interpolator

David S. Miller:
  o [SPARC64]: Update defconfig
  o [AX25]: Put back ax25digicmp
  o [TCP]: Fix sk_forward_alloc assertion failures with TSO
  o [EBTABLES]: Use correct printf format for size_t
  o [NETLINK]: netlink_kernel[] no longer used
  o [TUN]: Make type explicit in min() usage
  o [SPARC64]: Need some more SPARC32 ifdeffing in here
  o [TCP]: Do not underflow sk_forward_alloc in sendpage()
  o [TG3]: Update driver version and reldate
  o [NETFILTER]: Fix build by putting back ip_nat_lock extern in
    ip_nat.h
  o [NETFILTER]: Remove no longer needed symbol exports
  o [NET]: Close NETIF_F_LLTX race conditions

David Woodhouse:
  o ppc: fix removed MMCR0_PMXE define

Deepak Saxena:
  o [ARM PATCH] 2378/1: Trivial: Update my info in CREDITS file
  o [ARM PATCH] 2381/1: Add <linux/kernel.h> to IXP4xx source files
  o [ARM PATCH] 2412/1: Fix IXP2000 gettimeofday() implementation
    (again)

Dmitry Torokhov:
  o Input: atkbd - fix keycode table size initialization that got
    broken by my changes that exported 'set' and other settings via
    sysfs.
  o Input: psmouse - set mouse name to "Mouse" when using PS2++ and
    don't have any other information about the mouse.

Domen Puncer:
  o [SPARC64]: Remove x86-specific help in arch/sparc64/Kconfig
  o [IA64] simeth.c: Remove unneeded casts of (void *) pointers
  o [IA64] sn_hwperf.c: vfree() checking cleanups
  o uml: delete unused header umn.h

Dominik Brodowski:
  o pcmcia: remove IRQ_TYPE_TIME
  o pcmcia: ignore driver IRQ mask
  o pcmcia: remove irq_mask and irq_list parameters from PCMCIA drivers
  o pcmcia: use irq_mask to mark IRQs as (un)usable
  o pcmcia: remove racy try_irq()
  o pcmcia: modify irq_mask via sysfs
  o pcmcia: remove #includes in rsrc_mgr which aren't necessary any
    longer

Ed L. Cashin:
  o aoe: don't sleep with interrupts on
  o aoe: fix __init calling __exit

Egbert Eich:
  o vgacon fixes to help font restauration in X11

Enrico Scholz:
  o [ide] atiixp: add IXP400 support

Eric Lammerts:
  o ext3: commit superblock before panicking

Evgeniy Polyakov:
  o w1: add ->search() method

Florian Echtler:
  o USB: add driver for the Siemens ID Mouse fingerprint sensor

Frank Sorenson:
  o uml: avoid NULL dereference in line.c

Frederick Li:
  o [libata sata_sil] support ATI IXP300/IXP400 SATA

Gabor Egry:
  o various Kconfig fixes

Ganesh Venkatesan:
  o ixgb: Limit number of Rx Descriptors to 512
  o ixgb: Enable Message Signalled Interrupts
  o ixgb: Add support for 10GbE LR device ID
  o ixgb: Fix VLAN filter setup errors (while running on PPC)
  o ixgb: Fix memory leak in NAPI mode
  o ixgb: Poll Routine cleanup
  o ixgb: Fix error in setting MFS register
  o ixgb: Fix infinite loop trying to re-establish link
  o ixgb: Limit Rx Address Filter Array entries to 3
  o ixgb: Remove support for RAIDC interrupt mitigation
  o ixgb: Replace kmalloc with vmalloc (one time alloc)
  o ixgb: ethtool_ops support
  o ixgb: Shrink size and fix ordering of elements in ixgb_buffer
  o ixgb: Fix Tx cleanup logic
  o ixgb: Support for 2.6.x style module parameters
  o ixgb: Driver version number update
  o ixgb: White space corrections

Giorgio Padrin:
  o [ARM PATCH] 2410/1: pxa-regs.h: Complete/fix I2S GPIO modes
    definitions

Grant Grundler:
  o [SPARC64]: Fix brainfart in pci_psycho.c

Greg Kroah-Hartman:
  o Block: Remove block_subsys.rwsem usage
  o Block: move struct disk_attribute to genhd.h
  o I2C: add MODULE_DEVICE_TABLE to via686a.c driver
  o USB: remove some unneeded exported symbols
  o USB: fix sparse warnings in the idmouse.c driver
  o USB: give the idmouse the 132 minor number
  o PCI: move pcie build into the drivers/pci/ subdirectory

Gunther Mayer:
  o [ide] ide_dump_atapi_status() printk readability fix

H. Peter Anvin:
  o Use official Unicodes for DEC VT characters

Hanna V. Linder:
  o [IA64] sba_iommu.c: pci_find_device is going away
  o [IA64] pci.c: pci_find_device is going away

Harald Welte:
  o [NETFILTER] re-introduce __initdata to {arp,ip,ip6}_tables

Heiko Carstens:
  o s390: Core changes
  o s390: cmm interface

Herbert Xu:
  o [IPV6]: Fix locking in ip6_dst_lookup()
  o [NETLINK]: Orphan SKBs in netlink_trim()
  o [TCP]: Remove tcp_pcount_t
  o [NETLINK]: Unshare SKB, as necessary, in netlink_trim()

Hideaki Yoshifuji:
  o [IPV6]: Fix tunnel list locking in sit.c
  o [IPV6] Don't use expired default routes
  o [IPV6] Don't update FAILED entries on receipt of NAs
  o [IPV6]: Ensure to learn link-layer address from RA
  o [IPV6]: kill needless initialization and comparison in icmp.c

Hirofumi Ogawa:
  o fat: kill fatfs_syms.c
  o fat: use vprintk instead of snprintf with static buffer
  o fat: kill unnecessary kmap()
  o fat: fs/fat/cache.c: make __fat_access static
  o fat: Lindent fs/msdos/namei.c
  o fat: Lindent fs/vfat/namei.c
  o FAT: Lindent fs/vfat/namei.c fix
  o fat: fs/fat/* cleanup
  o fat: reserved clusters cleanup
  o fat: show current nls config even if it's default

Hirokazu Takata:
  o net: netconsole support for smc91x
  o csum_and_copy_from_user gcc4 warning fixes

Horst Hummel:
  o s390: dasd driver debug log

Ingo Molnar:
  o minor spinlock cleanups
  o x86 rwlock *_can_lock() primitives
  o rename 'lock' to 'slock' in asm-i386/spinlock.h
  o nonintrusive spin-polling loop in kernel/spinlock.c
  o allow all architectures to set CONFIG_DEBUG_PREEMPT
  o completion API additions

Ivan Kokshaysky:
  o Alpha: typos in io_trivial.h

Jack Steiner:
  o [IA64-SGI] Add support for a future SGI chipset (shub2) 1of4
  o [IA64-SGI] Add support for a future SGI chipset (shub2) 2of4
  o [IA64-SGI] Add support for a future SGI chipset (shub2) 3of4
  o [IA64-SGI] Add support for a future SGI chipset (shub2) 4of4
  o [IA64] Cachealign jiffies_64 to prevent unexpected aliasing in the
    caches
  o [IA64] Stagger the addresses of the pernode data structures to
    minimize cache aliasing
  o [IA64-SGI] Update SN2 code for running on simulator
  o [IA64-SGI] Delete unneeded SN2 header file router.h

James Bottomley:
  o SCSI: update ipr to use the change_queue_depth API
  o fix SPI transport class to do DV for broken Western Digital drives
  o Fix exploitable hole in sg_scsi_ioctl
  o SCSI: add starget_for_each_device
  o FC Transport updates - additional fc host attributes
  o generic irq code missing export of probe_irq_mask()

James Morris:
  o SELinux: add Netlink message types for the TC action code

Jan Kara:
  o Minor ext3 speedup

Jaroslav Kysela:
  o [ALSA] Fix ioctl arguments
  o [ALSA] ac97 quirk entries for HP xw6200 & xw8000
  o [ALSA] Fix description of ALSA/OSS device mapping
  o [ALSA] Fix float format support
  o [ALSA] Add quirk for HP zv5000
  o [ALSA] remove compatibility code for 2.2.x kernels
  o [ALSA] Fix Oops at resume
  o [ALSA] Adapt SPDIF Input selection for Realtek ALC658
  o [ALSA] Fixed description about ac97_quirk
  o [ALSA] Remove & from function pointers
  o [ALSA] Add suspend callback
  o [ALSA] Fix DMA pointer read
  o [ALSA] Fix ctl_read/write ioctl wrappers
  o [ALSA] Add ac97_quirk option
  o ALSA 1.0.8

Jason Gaston:
  o I2C support for Intel ICH7 - 2.6.10 - resubmit
  o PCI: pci_ids.h correction for Intel ICH7 - 2.6.10-bk13

Jean Delvare:
  o I2C: Fix bogus bitmask in lm63 debug message
  o I2C: Cleanups to the eeprom driver
  o I2C: Improve it87 super-i/o detection

Jeff Dike:
  o uml: commentary about SIGWINCH handling for consoles
  o uml: provide an arch-specific define for register file size
  o uml: provide some initcall definitions for userspace code
  o uml: allow ubd devices to provide partial end blocks
  o uml: change for_each_cpu to for_each_online_cpu
  o uml: eliminate unhandled SIGPROF on halt
  o uml: fix __pud_alloc definition to match the declaration
  o uml: fix a stack corruption crash
  o uml: define __HAVE_ARCH_CMPXCHG on x86

Jeff Garzik:
  o e1000/ixgb net drivers: rename global symbol to fix 'make
    allyesconfig'

Jens Axboe:
  o gdth buggy page mapping
  o cfq-iosched: fix scsi requeue accounting
  o elevator: print default selection
  o Don't enable ata over eth by default
  o possible rq starvation on oom
  o bio clone memory corruption
  o noop-iosched: fix insertion point
  o Fix md using bio on stack with bio clones

Jesper Juhl:
  o clean out old cruft from FD MCS driver

Jesse Barnes:
  o [IA64] implements the features required for the HAVE_PCI_LEGACY
    code in sysfs
  o [IA64] update sn2_defconfig (fix initrd, add IB support) Don't know
    what happened to initrd support, but 'make sn2_defconfig' no longer
    enables it.  This patch should fix that, along with enabling
    modular IB support.
  o [IA64] defconfig update
  o [IA64] clear all region registers at boot
  o [IA64-SGI] fix bogus address dereference in sn/setup.c
  o [IA64] pci.c: fix warning
  o [IA64-SGI] io_init.c: gcc4 fixes for sn2
  o use mmiowb in qla1280.c
  o PCI: rom.c cleanups

John Lenz:
  o [ARM PATCH] 2417/1: update collie to use scoop driver

John Rose:
  o PCI: fix release_pcibus_dev() crash

Jonas Munsin:
  o I2C: it87 fan update
  o I2C: fix it87 sensor driver stops CPU fan

Justin Thiessen:
  o I2C: adm1026.c fixes

Jörn Engel:
  o fixups for block2mtd

Keith Owens:
  o [IA64] Add TIF_SIGDELAYED, delay a signal until it is safe
  o [IA64] Clear all corrected records as they occur
  o [IA64] Drop SALINFO_TIMER_DELAY from 5 minutes to 1 minute
  o ia64: export pcibios_resource_to_bus to match other architectures
  o scripts/reference*.pl - treat built-in.o as conglomerate

Krisztian KOVACS:
  o [NETFILTER]: Remove remaining multirange related code

Kumar Gala:
  o I2C-MPC: use wait_event_interruptible_timeout between transactions
  o I2C-MPC: Convert to platform_device driver
  o ppc32: System platform_device description, discovery and management
  o ppc32: Infrastructure changes to MPC85xx sub-arch from OCP to
    platform_device
  o ppc32: convert boards from using OCP to platform_device
  o ppc32: Convert gianfar ethernet driver from using an OCP to
    platform_device

Lennert Buytenhek:
  o [NET]: Tone down the verbosity of diverter messages

Linas Vepstas:
  o ppc64: PCI EEH documentation

Linus Torvalds:
  o Handle two threads both trying to expand their stack simultaneously
  o Make mm writelock testing less intrusive
  o Make pipe buffer handling more generic
  o scsi_ioctl: only warn about unknown opcodes if they are truly
    unknown
  o Revert "Don't busy-lock-loop in preemptable spinlocks" patch
  o Remove old debugging tests
  o Remove broken-as-designed "rwlock_is_locked()" macro
  o Revert "x86_64/i386: increase command line size" patch
  o ppc64: rwlock *_can_lock() primitives
  o ia64: rwlock *_can_lock() primitives
  o x86-64: rwlock *_can_lock() primitives
  o Linux 2.6.11-rc2

Lonnie Mendez:
  o USB cypress_m8: line setting bugfix, circular write buffer added,
    misc. fixes

Lothar Wassmann:
  o [ARM PATCH] 2395/1: __ioremap() miscalculates mapping size under
    certain conditions

Luca Risolia:
  o USB: SN9C10x driver updates

Maksim Krasnyanskiy:
  o TUN/TAP driver packet queuing fixes and improvements
  o Use random_ether_addr() to generate TAP MAC address
  o [TUN] Add a missing dependency on enabling the crc32 libraries

Marc Singer:
  o [ARM PATCH] 2394/1: Re: accepting responsibility for Sharp LH ports

Marcel Holtmann:
  o [Bluetooth] Make some code of the core static
  o [Bluetooth] Make another function static
  o [Bluetooth] Make more code static
  o [Bluetooth] Add module parameter for HCI_Reset
  o [Bluetooth] Update socket option handling
  o [Bluetooth] Add HIDP message parsing
  o [Bluetooth] Remove casts in BCSP driver
  o [Bluetooth] Add module parameter for ignoring a device
  o [Bluetooth] Lock initializer cleanup

Marcelo Tosatti:
  o do_brk() needs mmap_sem write-locked

Mark A. Greer:
  o serial: MPSC driver

Markus Lidel:
  o I2O: fix possible race condition and minor improvements
  o I2O: printk cleanup and unnecessary code removal

Martin Schwidefsky:
  o s390: 3270 console

Matt Mackall:
  o random: whitespace doh
  o random: entropy debugging improvements
  o random: run-time configurable debugging
  o random: periodicity detection fix
  o random: add_input_randomness

Matt Porter:
  o EMAC: fix ibm_emac autonegotiation result parsing
  o allow rx of the maximum sized VLAN tagged packets
  o Add netpoll support
  o ppc32: fix PPC44x build

Matthew Dobson:
  o Fix num_online_nodes() warning on NUMA-Q

Matthew Wilcox:
  o sym2 version 2.1.18n
  o Remove lasi700.h
  o Misc zalon fixes
  o Make compat_rt_sigtimedwait conform
  o Generic IRQ support for PA-RISC
  o PA-RISC: parisc_device diet
  o PA-RISC defconfig updates
  o PA-RISC: Misc Dino fixes
  o PA-RISC: Misc HPUX emulation cleanups
  o iomap for PA-RISC
  o PA-RISC: More PDC procedures
  o PA-RISC: Remove unused serial definitions
  o PA-RISC: ptrace fix
  o PA-RISC: Fix _syscallN wrappers
  o PA-RISC: Sort out io accessors
  o PA-RISC: Remove unused file

Michael Ellerman:
  o ppc64: make HvLpEvent_unregisterHandler() work
  o ppc64: make iseries_veth call flush_scheduled_work()

Michael S. Tsirkin:
  o ioctl rework #2
  o macros to detect existance of unlocked_ioctl and ioctl_compat

Mike Christie:
  o export print_sense_internal

Mike Miller:
  o cciss update to version 2.6.4

Milton D. Miller II:
  o ppc64: Minimum hashtable size

Miquel van Smoorenburg:
  o mark-page-accessed in filemap.c not quite right

Neil Horman:
  o [ATALK]: Add ioctls to allow ifx txqueuelen sets/gets

Nicolas Pitre:
  o [ARM PATCH] 2391/1: remove obsolete help text
  o [ARM PATCH] 2204/1: bring {read|write}sw up to date with current
    reality
  o [ARM PATCH] 2423/2: more PXA2xx AC97 defines

Nigel Cunningham:
  o swsusp: refrigerator cleanups

Olaf Kirch:
  o [NET]: Fix CMSG_COMPAT_OK length check
  o [NET]: Check for SOL_SOCKET in compat_sys_getsockopt

Oleg Nesterov:
  o uninline mod_page_state(offset, delta)

Oliver Neukum:
  o USB: CDC ACM module and Zoom 2985 modem

Olof Johansson:
  o ppc64: iommu: avoid ISA io space on POWER3

Pablo Neira:
  o [NETFILTER]: move ipt_error and ipt_standard to iptables.h

Paolo 'Blaisorblade' Giarrusso:
  o uml: readd CONFIG_MAGIC_SYSRQ for UML
  o uml: Commentary addition to recent SYSEMU fix
  o uml: drop unused buffer_head.h header from hostfs
  o uml: depend on !USERMODE in drivers/block/Kconfig and drop
    arch/um/Kconfig_block
  o uml: Makefile simplification and correction
  o uml: fix some UML own initcall macros
  o uml: refuse to run without skas if no tt mode in
  o uml: for ubd cmdline param use colon as delimiter
  o uml: allow free ubd flag ordering
  o uml: move code from ubd_user to ubd_kern
  o uml: fix and cleanup code in ubd_kern.c coming from ubd_user.c
  o uml: add stack content to dumps
  o uml: update ld scripts to newer binutils

Patrick McHardy:
  o [PKT_SCHED]: act_api.c: whitespace and coding style cleanup
  o [PKT_SCHED]: act_api.c: use consistent comparison style
  o [PKT_SCHED]: act_api.c: remove checks for impossible conditions
  o [PKT_SCHED]: act_api.c: remove unnecessary initializations
  o [PKT_SCHED]: Add rtattr_strlcpy, use it where appropriate
  o [RTNETLINK]: Use rtattr_strcmp where appropriate
  o [PKT_SCHED]: act_api.c: clean up init path, propagate errors
    properly
  o [PKT_SCHED]: tc actions: whitespace and coding style cleanup
  o [PKT_SCHED]: tc actions: remove checks for impossible conditions
  o [PKT_SCHED]: gact action: fix multiple bugs in init path
  o [PKT_SCHED]: ipt action: fix multiple bugs in init path
  o [PKT_SCHED]: mirred action: fix multiple bugs in init path
  o [PKT_SCHED]: pedit action: fix multiple bugs in init path
  o [PKT_SCHED]: police action: fix multiple bugs in init path
  o [PKT_SCHED]: ipt action: fix missing unlock on error path
  o [PKT_SCHED]: tc actions: remove unnecessary locking for refcnt
    changes
  o [PKT_SCHED]: ipt action: fix module refcount underflow/mem leaks in
    tcf_ipt_cleanup
  o [PKT_SCHED]: act_api.c: remove module loading from get/delete
    operations
  o [PKT_SCHED]: act_api.c: push memory allocation to tcf_action_get_1
  o [PKT_SCHED]: act_api.c: sync multi action order processing
  o [NETFILTER]: Fix stack leakage in ip6tables
  o [NETFILTER]: Remove skb_linearize in ip6tables
  o [NETFILTER]: Add --log-uid option to ipt_LOG/ip6t_LOG
  o [NETFILTER]: Fix ip6tables ESP matching with "-p all"
  o [PKT_SCHED]: Use rtattr_parse_nested where appropriate
  o [PKT_SCHED]: Fix memory leaks in cls_u32.c error path
  o [PKT_SCHED]: tc actions: disable bhs while lock is held in init
    path
  o [PKT_SCHED]: act_api.c: drop rtnl for loading modules
  o [PKT_SCHED]: tcf_exts: rate_tlv is optional
  o [PKT_SCHED]: act_api.c: kill some exports
  o [PKT_SCHED]: cls_api.c: drop rtnl for loading modules
  o [PKT_SCHED]: cls_rsvp: fix tcf_exts fallout
  o [PKT_SCHED]: cls_api.c: fix module reference leak on module load
  o [PKT_SCHED]: cls_route: fix tcf_exts fallout
  o [PKT_SCHED]: fix CONFIG_NET_CLS_ACT skb leaks in HFSC/CBQ

Paul Gortmaker:
  o smc-ultra.c too-verbose driver

Paul Mackerras:
  o PPC64 had _raw_read_trylock already
  o PPC64 Disable preemption in flush_tlb_pending
  o PPC64 Call preempt_schedule on exception exit
  o PPC64 can do preempt debug too
  o PPC64 Add PREEMPT_BKL option
  o PPC64 Move thread_info flags to its own cache line
  o ioctl compatibility for TIOCMIWAIT and TIOCGICOUNT

Pavel Machek:
  o [CPUFREQ] powernow-k8: small cleanups / documentation additions
    (Pavel Machek)
  o swsusp: more small fixes
  o swsusp/dm: Use right levels for device_suspend()
  o swsusp: update docs
  o acpi: comment/whitespace updates
  o make suspend work with ioapic
  o swsusp: remove O(n^2) algorithm in page relocation
  o driver model: pass pm_message_t down to pci drivers

Pawel Sikora:
  o final csum_and_copy_from_user gcc4 warning fixes

Pete Zaitcev:
  o USB: Patch to fix ub looping with a tag mismatch

Peter Osterlund:
  o ALPS touchpad detection fix

Petko Manolov:
  o pegasus 2.6.10 cset

Petr Vandrovec:
  o Fix x86-64 vsyscall32 mapping

Phil Dibowitz:
  o USB unusual_devs addition: Ignore residue for ours-tech disk

Pierre Ossman:
  o [MMC] wbsd update

Prarit Bhargava:
  o [ide] suppress output of error messages for non-existant interfaces

Prasanna Meda:
  o ptrace: unlocked access to last_siginfo (resending)
  o file_table:expand_files() code cleanup

Prasanna S. Panchamukhi:
  o x68: consolidate code segment base calculation
  o kprobes: x86_64 memory allocation changes

Rafael J. Wysocki:
  o Fix a bug in timer_suspend() on x86_64

Rafael Ávila de Espíndola:
  o I2C: add EMC6D100 support in lm85 driver

Raghavendra Koushik:
  o S2io: fixes in free_shared_mem function

Randolph Chung:
  o PA-RISC Cache flush optimisation

Randy Dunlap:
  o gdth: reduce large on-stack locals
  o wl3501: fix module_param types/warnings
  o [IA64/X86_64] swiotlb.c: fix gcc printk warning
  o swiotlb: fix gcc printk warning
  o i386: init_intel_cacheinfo() can be __init
  o radio-typhoon: use correct module_param data type

Rene Scharfe:
  o fat: IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup
  o fat: Return better error codes from vfat_valid_longname()

Richard Purdie:
  o [ARM PATCH] 2386/1: Tidy up Sharp SCOOP driver coding style
  o [ARM PATCH] 2388/1: Add SSP control code for Sharp SL-C7xx Series
    (Corgi)
  o [ARM PATCH] 2392/1: Add PCMCIA/CF support code for Sharp SL-C7xx
    Series
  o [ARM PATCH] 2405/1: PXA Corgi - Add w100fb device definition
  o [ARM PATCH] 2406/1: PXA Corgi - Add MMC Support
  o [ARM PATCH] 2425/1: PXA Corgi - Flush ssp before suspending
  o [ARM PATCH] 2426/1: PXA Corgi - Add USB Device Controller support

Rik van Riel:
  o fix xenU kernel crash in dmi_iterate

Robert Olsson:
  o [NET]: pktgen update

Roger Luethi:
  o mc_filter on big-endian arch

Roland Dreier:
  o [SPARC64]: Check copy_to_user() return value in
    sys_{sparc,sunos}32.c
  o PCI: Clean up printks in msi.c
  o InfiniBand/IPoIB: use correct static rate in IpoIB
  o InfiniBand/mthca: trivial formatting fix
  o InfiniBand/mthca: support RDMA/atomic attributes in QP modify
  o InfiniBand/mthca: clean up allocation mapping of HCA context memory
  o InfiniBand/mthca: add needed rmb() in event queue poll
  o InfiniBand/core: remove debug printk
  o InfiniBand: make more code static
  o InfiniBand/core: set byte_cnt correctly in MAD completion
  o InfiniBand/core: add QP number to work completion struct
  o InfiniBand/core: add node_type and phys_state sysfs attrs
  o InfiniBand/mthca: clean up computation of HCA memory map
  o InfiniBand/core: fix handling of 0-hop directed route MADs
  o InfiniBand/core: add more parameters to process_mad
  o InfiniBand/core: add qp_type to struct ib_qp
  o InfiniBand/core: add ib_find_cached_gid function
  o InfiniBand: update copyrights for new year
  o InfiniBand/ipoib: move structs from stack to device private struct
  o InfiniBand/core: rename handle_outgoing_smp
  o [IPV6]: IPoIB link addr option needs two byte pad

Roland McGrath:
  o fix coredump_wait deadlock with ptracer & tracee on shared mm
  o fix race between core dumping and exec with shared mm
  o fix exec deadlock when ptrace used inside the thread group
  o clear false pending signal indication in core dump
  o x86_64: fix crash on get_user_pages of ia32 vsyscall page before
    it's faulted in
  o Fix x87 fnsave Tag Word emulation when using FXSR (SSE)
  o cputime.h seems to assume HZ==1000
  o cputime_t patches broke RLIMIT_CPU

Roman Zippel:
  o kconfig: pass 0, 0 to show_file() to select max size window

Russ Anderson:
  o [IA64] per cpu MCA/INIT save areas
  o [IA64] Fix problems in per cpu MCA code
  o [IA64] correct PERCPU_MCA_SIZE and ia64_init_stack size
  o [IA64-SGI] Altix BTE error handling fix

Russell King:
  o [ARM] Add show_ipi_list() call
  o [ARM] Add synchronize_irq() support
  o [ARM] Add SMP IRQ affinity and routing support
  o [ARM] Relocate ipi_count into ipi data structures
  o [ARM] Fix smp.c includes
  o [ARM] Don't use __init for function prototypes
  o [ARM] Remove <asm/atomic.h> include
  o [ARM] Add missing tlb_migrate_finish()
  o [MMC] Add comment about GENHD_FL_REMOVABLE to mmc_block
  o [SERIAL] Fix serial console resume
  o [SERIAL] Clarify documentation for set_termios and pm methods
  o [ARM] Fix profile_pc() for SMP
  o [ARM] Add CPU number to cache information lines
  o [ARM] Clean up lookup of processor and machine types
  o [ARM] Remove "ipimask" from do_IPI()

Rusty Russell:
  o [PKT_SCHED]: Restore net/sched/ipt.c After iptables Kmod Cleanup
  o [NETFILTER]: Fix overlapping expectations in existing expectation
    code
  o [NETFILTER]: Call NAT helper modules directly from conntrack
    modules, fixup FTP
  o [NETFILTER]: Fix up IRC, AMANDA, TFTP and SNMP
  o [NETFILTER]: Simplify expect handling
  o [NETFILTER]: Make expectations timeouts compulsory
  o [NETFILTER]: Adrian Bunk's cleanup patches
  o [NETFILTER]: Remove manip array from conntrack entry
  o [NETFILTER]: Remove ip_conntrack_tuple_hash 'ctrack' pointer
  o [NETFILTER]: Use a bit in conntrack status to indicate sequence
    number adjustment
  o [NETFILTER]: Get rid of 'initialized' in nat structure: use
    conntrack status bits
  o [NETFILTER]: Don't cacheline align slab allocs
  o [NETFILTER]: Fix SNMP nat build

Sam Ravnborg:
  o kconfig: introduce util.c
  o kconfig: Redo and improve search support
  o kconfig: Include more info when selecting help for a symbol in
    menuconfig
  o kconfig: Fold README.Menuconfig into mconf.c

Serge Hallyn:
  o Fix audit control message checks

Sridhar Samudrala:
  o [SCTP] Fix potential null pointer dereference in sctp_err_lookup()
  o [SCTP] Code cleanup: remove unused code and make needlessly global
    code static
  o [SCTP] Treat ICMP protocol unreachable errors from non-SCTP capable
    hosts as ABORTs.
  o [SCTP] Validate and respond to invalid chunk/parameter lengths
  o [SCTP] Implementation of SCTP Implementer's Guide Section 2.35
  o [SCTP] Clean up the T3_rtx timer when deleting a transport
  o [SCTP] Fix bug in setting ephemeral port in the bind address
  o [SCTP] Fix misc. issues in SCTP_PEER_ADDR_PARAMS set socket option
  o [SCTP] Fix sctp_getladdrs() to return valid local addresses on an
    endpoint that is bound to INADDR_ANY or inaddr6_any.

Stefan Bader:
  o s390: use nonseekable_open in z/VM log reader

Steffen Thoss:
  o s390: Common I/O layer changes

Stephen D. Smalley:
  o SELinux: fix error handling code for policy load
  o SELinux: fix setting of loaded policy version

Stephen Rothwell:
  o ppc64: remove some unused iSeries functions

Steve Longerbeam:
  o shared_policy_replace() fix

Suresh B. Siddha:
  o x86_64: use cpumask_t instead of unsigned long
  o x86: use cpumask_t instead of unsigned long

Thomas Gleixner:
  o [NET]: Lock initializer cleanup
  o PCI: Lock initializer cleanup - batch 4
  o USB: Lock initializer cleanup - batch 4
  o Lock initializer cleanup: PPC
  o Lock initializer cleanup: M32R
  o Lock initializer cleanup: Video
  o Lock initializer cleanup: IDE
  o Lock initializer cleanup: sound
  o Lock initializer cleanup: SH
  o Lock initializer cleanup: PPC64
  o Lock initializer cleanup: Security
  o Lock initializer cleanup: Core
  o Lock initializer cleanup: media drivers
  o Lock initializer cleanup: Block devices
  o Lock initializer cleanup: S390
  o Lock initializer cleanup: UserMode
  o Lock initializer cleanup: SCSI
  o Lock initializer cleanup: SPARC
  o Lock initializer cleanup: V850
  o Lock initializer cleanup: I386
  o Lock initializer cleanup: DRM
  o Lock initializer cleanup: Firewire
  o Lock initializer cleanup - (ARM26)
  o Lock initializer cleanup: M68K
  o Lock initializer cleanup: Network drivers
  o Lock initializer cleanup: MTD
  o Lock initializer cleanup: X86_64
  o Lock initializer cleanup: Filesystems
  o Lock initializer cleanup: IA64
  o Lock initializer cleanup: Raid
  o Lock initializer cleanup: ISDN
  o Lock initializer cleanup: PARISC
  o Lock initializer cleanup: SPARC64
  o Lock initializer cleanup: ARM
  o Lock initializer cleanup: Misc drivers
  o Lock initializer cleanup - (ALPHA)
  o Lock initializer cleanup: character devices
  o Lock initializer cleanup: drivers/serial
  o Lock initializer cleanup: FRV

Thomas Graf:
  o [PKT_SCHED]: rtattr_parse shortcut for nested TLVs
  o [PKT_SCHED]: tc filter extension API
  o [PKT_SCHED]: u32: make use of tcf_exts API
  o [PKT_SCHED]: fw: make use of tcf_exts API
  o [PKT_SCHED]: route: allow changing parameters for existing filters
    and use tcf_exts API
  o [PKT_SCHED]: tcindex: allow changing parameters for existing
    filters and use tcf_exts API
  o [PKT_SCHED]: rsvp: use tcf_exts API
  o [PKT_SCHED]: Remove old action/police helpers
  o [PKT_SCHED]: Actions are now available for all classifiers & Fix
    police Kconfig dependencies
  o [PKT_SCHED]: Fix c99ism in cls_api.c

Tom Coughlan:
  o aacraid: remove aac_handle_aif

Tom L. Nguyen:
  o PCI: add PCI Express Port Bus Driver subsystem

Tom Rini:
  o ppc32: Fix mpc8272ads
  o ppc32: Add Freescale PQ2FADS support
  o ppc32: remove cli()/sti() in arch/ppc/4xx_io/serial_sicc.c
  o ppc32: remove cli()/sti() in arch/ppc/8xx_io/cs4218_tdm.c
  o ppc32: remove cli()/sti() in arch/ppc/8xx_io/fec.c
  o ppc32: remove cli()/sti() in arch/ppc/platforms/apus_setup.c
  o ppc32: remove cli()/sti() in arch/ppc/platforms/pal4_setup.c
  o ppc32: remove cli()/sti() in arch/ppc/syslib/m8xx_setup.c
  o ppc32: remove cli()/sti() in arch/ppc/syslib/qspan_pci.c
  o ppc32: MPC8xx TLB Miss vs TLB Error fix
  o ppc32: update_process_times simplification

Tony Battersby:
  o fix read capacity for large disks when CONFIG_LBD=n

Tony Luck:
  o [IA64] convert to use CONFIG_GENERIC_HARDIRQS
  o [IA64] hardirq.h: Add declaration for ack_bad_irq()
  o [IA64] Use alloc_bootmem() to get the space for mca_data
  o [IA64] reorder functions to define ia64_pci_get_legacy_mem() before
    using it

Trond Myklebust:
  o Fix a BKL imbalance in the NFS locking code
  o Fix an Oopsable condition in the NFS locking
  o RPCSEC_GSS: Fix a refcount leak
  o RPC: fix crrefresh() operations for AUTH_NULL and AUTH_SYS

Ulrich Weigand:
  o cputime: s/390: fix account_steal_time

Ursula Braun-Krahl:
  o s390: remove irq_exit from iucv

Vadim Lobanov:
  o Fix typo in arch/i386/Kconfig
  o Fix typo in drivers/char/Kconfig

Venkatesh Pallipadi:
  o [CPUFREQ] speedstep-centrino and acpi-cpufreq: P4 TSC rate is
    constant
  o [CPUFREQ] speedstep-centrino: don't loop on transient MSR
  o x86-64: Fix do_suspend_lowlevel

Vincent Hanquez:
  o arch/i386/kernel/signal.c: fix err test twice

Wang Zhongjun:
  o [ide] piix: add Intel 82801DBL IDE Controller support

Willem Riede:
  o osst: remove typedefs
  o osst: error handling updates
  o osst: add sysfs support

Yoshinori Sato:
  o H8/300 defconfig update
  o H8/300 mm update

Zou Nanhai:
  o [CPUFREQ] cpufreq stat output in sysfs

