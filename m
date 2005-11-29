Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVK2EMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVK2EMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVK2EMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:12:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750714AbVK2EML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:12:11 -0500
Date: Mon, 28 Nov 2005 20:11:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.15-rc3
Message-ID: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-894810794-1133237495=:3177"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-894810794-1133237495=:3177
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
diffstats appended.

Most notable are some VM fixes from Hugh Dickins (with me then redoing 
some of it, but the bulk of the work goes to Hugh).  That should finally 
hopefully fix some of the issues some people hit with the PageReserved 
removal and cleanup by Nick Piggin that was in -rc1.

There's also some input updates, cifs fixes, USB EHCI host controller 
updates, and a number of random stuff. Details in the shortlog below,

		Linus

--- shortlog ---

Adam Brooks:
      [ARM] 3173/1: Fix to allow 2.6.15-rc2 to compile for IOP3xx boards

Adrian Bunk:
      [SPARC]: drivers/sbus/char/aurora.c:  "extern inline" -> "static inline"
      drivers/message/i2o/pci.c: fix a NULL pointer dereference
      drivers/infiniband/core/mad.c: fix use-after-release case
      drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference

Alan Stern:
      Small fixes to driver core
      Workaround for gcc 2.96 (undefined references)

Alasdair G Kergon:
      device-mapper: list_versions fix
      device-mapper: mirror log bitset fix

Alexandra Kossovsky:
      [COMPAT] net: SIOCGIFCONF data corruption

Andi Kleen:
      i386: Use bigsmp for > 8 core Opteron systems
      Remove compat ioctl semaphore

Andrea Arcangeli:
      shrinker->nr = LONG_MAX means deadlock for icache

Andrea Bittau:
      [PKT_SCHED]: sch_netem: correctly order packets to be sent simultaneously

Andrew Morton:
      Input: wistron - disable for x86_64
      revert floppy-fix-read-only-handling
      jffs2 debug gcc-2.9x fix
      memory_sysdev_class is static
      fork.c: proc_fork_connector() called under write_lock()

Antonino A. Daplas:
      fbcon: Console Rotation - Fix wrong shift calculation
      vgacon: Fix usage of stale height value on vc initialization

Arjan van de Ven:
      [SERIAL] mark several serial tables const

Ashok Raj:
      Register disabled CPUs
      clean up lock_cpu_hotplug() in cpufreq

Ben Collins:
      Fix hardcoded cpu=0 in workqueue for per_cpu_ptr() calls

Benjamin Herrenschmidt:
      Fix crash in unregister_console()
      Console rotation fixes

Benoit Boissinot:
      [NETFILTER]: ip_conntrack_netlink.c needs linux/interrupt.h

Bernhard Rosenkraenzer:
      Input: wistron - add support for Acer Aspire 1500 notebooks

Chris Humbert:
      fix broken lib/genalloc.c

Christoph Hellwig:
      [XFS] handle error returns from freeze_bdev

Damian Wrobel:
      USB: SN9C10x driver - bad page state fix

Daniel Marjamäki:
      PCI: direct.c: DBG

Daniel Marjamäkia:
      PCI: trivial printk updates in common.c

Dave Airlie:
      I think that if a PCI bus is a root bus, attached to a host bridge not a
      drm: add __GFP_COMP to the drm_alloc_pages
      drm: move is_pci to the end of the structure
      drm: fix quiescent locking

Dave Jones:
      [AGPGART] Mark maxes_table as const
      [AGPGART] Mark AMD64 aperture size structs as const
      [AGPGART] Support VIA P4M800CE bridge.
      dell_rbu driver depends on x86[64]

David Brownell:
      USB: EHCI updates
      USB: EHCI updates mostly whitespace cleanups
      USB: EHCI updates split init/reinit logic for resume
      USB: ohci, move ppc asic tweaks nearer pci

David Gibson:
      Fix error handling with put_compat_statfs()
      Fix hugetlbfs_statfs() reporting of block limits
      powerpc: fix for hugepage areas straddling 4GB boundary
      powerpc: More hugepage boundary case fixes

David Howells:
      FRV: Make the FRV arch work again

David Härdeman:
      USB: fix USB key generates ioctl_internal_command errors issue

David S. Miller:
      sparc: convert IO remapping to VM_PFNMAP

Dirk Opfer:
      [ARM] 3170/1: Sharp SL-6000x: platform device conversion fixup

Dmitry Torokhov:
      Input: atkbd - speed up setting leds/repeat state
      Input: add Wistron driver
      Input: wistron - convert to dynamic input_dev allocation
      Input: wistron - add PM support
      Input: uinput - convert to dynalloc allocation
      Input: uinput - add UI_SET_SWBIT ioctl
      Input: uinput - don't use "interruptible" in FF code
      Input: handle failures in input_register_device()
      Input: make serio and gameport more swsusp friendly
      Fix an OOPS when initializing IR remote on saa7134
      Fix missing initialization in ir-kbd-gpio.c
      Fix an OOPS is CinergyT2

Eric Paris:
      hugetlb: fix race in set_max_huge_pages for multiple updaters of nr_huge_pages

Eric Sandeen:
      [XFS] Fix potential overflow in xfs_iomap_t delta for very large extents

Eugeniy Meshcheryakov:
      hwmon: hdaps missing an axis

Felix Blyakher:
      [XFS] Tight loop in xfs_finish_reclaim_all prevented the xfslogd to run

Glauber de Oliveira Costa:
      ext3: Wrong return value for EXT3_IOC_GROUP_ADD

Grant Coady:
      cpufreq: silence cpufreq for UP

hawkes@sgi.com:
      [IA64] fix bug in sn/ia64 for sparse CPU numbering

Herbert Xu:
      [NETLINK]: Use tgid instead of pid for nlmsg_pid

Hirokazu Takata:
      m32r: Fix sys_tas() syscall
      m32r: Introduce atomic_cmpxchg and atomic_inc_not_zero operations
      m32r: M3A-2170(Mappi-III) IDE support

Hugh Dickins:
      unpaged: get_user_pages VM_RESERVED
      unpaged: private write VM_RESERVED
      unpaged: sound nopage get_page
      unpaged: unifdefed PageCompound
      unpaged: VM_UNPAGED
      unpaged: VM_NONLINEAR VM_RESERVED
      unpaged: COW on VM_UNPAGED
      unpaged: anon in VM_UNPAGED
      unpaged: ZERO_PAGE in VM_UNPAGED
      unpaged: PG_reserved bad_page
      unpaged: copy_page_range vma
      unpaged: fix sound Bad page states
      mm: update split ptlock Kconfig
      mm: unbloat get_futex_key
      mm: powerpc ptlock comments
      mm: powerpc init_mm without ptlock
      mm: fill arch atomic64 gaps

Ian Abbott:
      USB: ftdi_sio: new IDs for KOBIL devices

Jack Steiner:
      [IA64-SGI] support for older versions of PROM

Jacob.Shin@amd.com:
      Fix x86_64/msr.h interface to agree with i386/msr.h

Jamal Hadi Salim:
      [IPV4]: Fix secondary IP addresses after promotion

Jan Kara:
      Fix oops in vfs_quotaon_mount()

Jasper Spaans:
      fbcon: fix obvious bug in fbcon logo rotation code

jblunck@suse.de:
      device-mapper snapshot: bio_list fix

Jean Delvare:
      hwmon: Fix lm78 VID conversion
      hwmon: Fix missing it87 fan div init

Jeff Dike:
      uml: eliminate use of local in clone stub
      uml: eliminate anonymous union and clean up symlink lossage
      uml: properly invoke x86_64 system calls
      uml: eliminate use of libc PAGE_SIZE

Jens Axboe:
      as-iosched: remove state assertion in as_add_request()

Jim Keniston:
      kprobes: Fix return probes on sys_execve

Jody McIntyre:
      sbp2_command_orb_lock must be held when accessing the _orb_inuse list.
      Clarify T: field in MAINTAINERS

Jonathan E Brassow:
      device-mapper raid1: drop mark_region spinlock fix

Josh Boyer:
      MTD git tree location added to MAINTAINERS
      Add more SCM trees to MAINTAINERS

Kenneth Tan:
      [ARM] 3171/1: To add missing QMGR region size for IXP4XX

Kiyoshi Ueda:
      device-mapper dm-ioctl: missing put in table load error case

Kris Katterjohn:
      [NET]: Reject socket filter if division by constant zero is attempted.

Latchesar Ionkov:
      v9fs: fix memory leak in v9fs dentry code

Linus Torvalds:
      Fix up GFP_ZONEMASK for GFP_DMA32 usage
      compat-ioctl.c: fix compile with no CONFIG_JBD
      Revert "[NET]: Shut up warnings in net/core/flow.c"
      mm: re-architect the VM_UNPAGED logic
      Linux v2.6.15-rc3

Lucas Correia Villa Real:
      [ARM] 3178/1: S3C2400 - adds GPIO registers definitions to regs-gpio.h

Mark Maule:
      [IA64] altix: fix copyright in tioce .h files

Matthew Dobson:
      Fix a bug in scsi_get_command

Matthew Wilcox:
      Check the irq number is within bounds

Michael Krufky:
      fix broken hybrid v4l-dvb frontend selection

Miklos Szeredi:
      fuse: check directory aliasing in mkdir
      fuse: check for invalid node ID in fuse_create_open()

Miloslav Trmac:
      Input: wistron - disable wifi/bluetooth on suspend

Nathan Scott:
      [XFS] Fix a 32 bit value wraparound when providing a mapping for a large
      [XFS] Fix a case where attr2 format was being used unconditionally.
      [XFS] Resolve the xlog_grant_log_space hang, revert inline to macro.

Neil Horman:
      [NET]: Fix ifenslave to not fail on lack of IP information

NeilBrown:
      md: improve read speed to raid10 arrays using 'far copies'
      md: fix locking problem in r5/r6
      md: fix problem with raid6 intent bitmap
      md: set default_bitmap_offset properly in set_array_info
      md: fix --re-add for raid1 and raid6

Nick Piggin:
      mm: __alloc_pages cleanup fix

Nicolas Kaiser:
      [NETFILTER]: Remove ARRAY_SIZE duplicate
      usb serial: remove redundant include

Olaf Rempel:
      [BRIDGE]: recompute features when adding a new device

Oleg Drokin:
      32bit integer overflow in invalidate_inode_pages2()
      reiserfs: fix 32-bit overflow in map_block_for_writepage()

Oleg Nesterov:
      fix do_wait() vs exec() race
      fix 32bit overflow in timespec_to_sample()

Olof Johansson:
      powerpc: update my email address

Pablo Neira Ayuso:
      [NETFILTER] ctnetlink: Fix refcount leak ip_conntrack/nat_proto

Patrick McHardy:
      [FIB_TRIE]: Don't show local table in /proc/net/route output
      [DCCP]: Add missing no_policy flag to struct net_protocol
      [NET]: Use unused bit for ipvs_property field in struct sk_buff

Paul Jackson:
      cpuset fork locking fix

Pierre Ossman:
      [MMC] Fix protocol errors

Prarit Bhargava:
      [IA64] Prevent sn2 ptc code from executing on all ia64 subarches

Rajesh Shah:
      PCI Express Hotplug: clear sticky power-fault bit
      PCI: remove bogus resource collision error

Randy Dunlap:
      [NET]: kernel-doc fixes
      kernel Doc/ URL corrections
      PCI: kernel-doc fix for pci-acpi.c
      USB: kernel-doc for linux/usb.h

Richard Knutsson:
      net: Fix compiler-error on dgrs.c when !CONFIG_PCI

Richard Purdie:
      [ARM] 3179/1: Update/correct Zaurus Kconfig entries
      [ARM] 3180/1: Update Zaurus defconfigs

Rik van Riel:
      temporarily disable swap token on memory pressure

Roman Zippel:
      prefer pkg-config for the QT check

Russ Anderson:
      [IA64-SGI] bte_copy nasid_index fix

Russell King:
      [ARM] Add asm/memory.h to asm/numnodes.h
      [ARM] ebsa110: __arch_ioremap should be 3 args
      [ARM] Shut up gcc warning in assabet.c
      [ARM] Shut up gcc warning in clps7500 core.c
      [SERIAL] imx: Fix missed platform_driver_unregister
      [NET]: Shut up warnings in net/core/flow.c
      [ARM] Remove asm/hardware.h include from SA1100 io.h
      [ARM] Remove mach-types.h from head.S
      [ARM] Do not call flush_tlb_kernel_range() with IRQs disabled.
      [ARM] Realview core.c does not need mach-types.h
      [ARM] Update mach-types

Sascha Hauer:
      [ARM] 3181/1: add PORT_ identifier for Hilscher netx uart

Stefan Bader:
      device-mapper dm-mpath: endio spinlock fix

Stephen Rothwell:
      powerpc: remove arch/powerpc/include hack for 64 bit

Steve French:
      [CIFS] Fix CIFS "nobrl" mount option so does not disable sending brl requests
      [CIFS] Cleanup sparse warnings for unicode little endian casts
      [CIFS] Recognize properly symlinks and char/blk devices (not just FIFOs)
      [CIFS] Fix endian errors (setfacl/getfacl failures) in handling ACLs
      [CIFS] Fix sparse warnings on smb bcc (byte count)
      [CIFS] Recognize properly symlinks and char/blk devices (not just
      [CIFS] Vectored and async i/o turned on and correct the
      [CIFS] Fix scheduling while atomic when pending writes at file close time
      [CIFS] Missing part of previous patch
      [CIFS] Fix mknod of block and chardev over SFU mounts
      [CIFS] Fix setattr of mode only (e.g. in some chmod cases) to Windows

Trond Myklebust:
      NFSv4: Fix buggy nfs_wait_on_sequence()
      NFSv4: Fix typo in lock caching
      NFS: Fix a spinlock recursion inside nfs_update_inode()
      SUNRPC: Funny looking code in __rpc_purge_upcall

Ville Nuorvala:
      [IPV6]: Fix calculation of AH length during filling ancillary data.

Yan Zheng:
      [IPV6]: Acquire addrconf_hash_lock for read in addrconf_verify(...)

Yasuyuki Kozakai:
      [NETFILTER]: fixed dependencies between modules related with ip_conntrack

YOSHIFUJI Hideaki:
      [IPV6]: Fix memory management error during setting up new advapi sockopts.
      [IPV6]: Fix sending extension headers before and including routing header.

Yuan Mu:
      hwmon: Fix missing boundary check when setting W83627THF in0 limits

--- diffstat ---
 Documentation/DocBook/kernel-api.tmpl       |    6 
 Documentation/arm/VFP/release-notes.txt     |    2 
 Documentation/dvb/faq.txt                   |    1 
 Documentation/filesystems/affs.txt          |    2 
 Documentation/filesystems/ext2.txt          |    3 
 Documentation/floppy.txt                    |   10 
 Documentation/ioctl-number.txt              |    2 
 Documentation/kernel-docs.txt               |   60 +-
 Documentation/mca.txt                       |    2 
 Documentation/networking/driver.txt         |    5 
 Documentation/networking/ifenslave.c        |    9 
 Documentation/networking/iphase.txt         |    2 
 Documentation/networking/irda.txt           |    8 
 Documentation/networking/ray_cs.txt         |    3 
 Documentation/networking/vortex.txt         |   28 -
 Documentation/power/pci.txt                 |    2 
 Documentation/scsi/ibmmca.txt               |    4 
 Documentation/usb/ibmcam.txt                |    4 
 Documentation/usb/ov511.txt                 |    4 
 Documentation/usb/rio.txt                   |    6 
 Documentation/video4linux/zr36120.txt       |    7 
 MAINTAINERS                                 |   25 +
 Makefile                                    |    2 
 arch/arm/configs/corgi_defconfig            |   83 ++
 arch/arm/configs/poodle_defconfig           | 1015 ---------------------------
 arch/arm/configs/spitz_defconfig            |   81 ++
 arch/arm/kernel/head.S                      |   11 
 arch/arm/mach-clps7500/core.c               |    2 
 arch/arm/mach-pxa/Kconfig                   |    4 
 arch/arm/mach-pxa/tosa.c                    |    2 
 arch/arm/mach-realview/core.c               |    1 
 arch/arm/mach-sa1100/assabet.c              |    3 
 arch/arm/mm/consistent.c                    |   13 
 arch/arm/tools/mach-types                   |   14 
 arch/frv/kernel/semaphore.c                 |    2 
 arch/frv/mb93090-mb00/pci-irq.c             |    2 
 arch/frv/mm/init.c                          |    2 
 arch/frv/mm/pgalloc.c                       |    6 
 arch/i386/kernel/acpi/boot.c                |    4 
 arch/i386/kernel/mpparse.c                  |    5 
 arch/i386/kernel/process.c                  |    7 
 arch/i386/pci/common.c                      |    4 
 arch/i386/pci/direct.c                      |    2 
 arch/i386/pci/i386.c                        |    7 
 arch/ia64/kernel/process.c                  |    7 
 arch/ia64/sn/kernel/bte.c                   |    1 
 arch/ia64/sn/kernel/sn2/sn2_smp.c           |    3 
 arch/ia64/sn/kernel/sn2/sn_hwperf.c         |    3 
 arch/m32r/kernel/io_mappi3.c                |   54 +
 arch/m32r/kernel/setup_mappi3.c             |   20 -
 arch/m32r/kernel/sys_m32r.c                 |    6 
 arch/powerpc/Makefile                       |   16 
 arch/powerpc/kernel/process.c               |    1 
 arch/powerpc/kernel/vdso.c                  |    9 
 arch/powerpc/mm/4xx_mmu.c                   |    4 
 arch/powerpc/mm/hugetlbpage.c               |   10 
 arch/powerpc/mm/mem.c                       |    2 
 arch/powerpc/mm/tlb_32.c                    |    6 
 arch/powerpc/mm/tlb_64.c                    |    4 
 arch/powerpc/platforms/iseries/iommu.c      |    2 
 arch/powerpc/platforms/pseries/iommu.c      |    2 
 arch/powerpc/sysdev/dart.h                  |    2 
 arch/powerpc/sysdev/u3_iommu.c              |    4 
 arch/sparc/kernel/ioport.c                  |    2 
 arch/sparc/mm/generic.c                     |   10 
 arch/sparc64/kernel/sbus.c                  |    2 
 arch/sparc64/mm/generic.c                   |   15 
 arch/um/Makefile                            |    2 
 arch/um/include/sysdep-i386/stub.h          |    9 
 arch/um/include/sysdep-x86_64/stub.h        |   12 
 arch/um/kernel/skas/clone.c                 |   21 -
 arch/um/sys-i386/Makefile                   |    2 
 arch/um/sys-i386/ldt.c                      |   35 +
 arch/um/sys-i386/stub_segv.c                |   11 
 arch/um/sys-x86_64/Makefile                 |    2 
 arch/um/sys-x86_64/stub_segv.c              |   20 -
 arch/x86_64/kernel/process.c                |    7 
 block/as-iosched.c                          |    4 
 drivers/base/bus.c                          |   21 -
 drivers/base/dd.c                           |    8 
 drivers/block/floppy.c                      |    6 
 drivers/char/agp/amd64-agp.c                |    4 
 drivers/char/agp/backend.c                  |    2 
 drivers/char/agp/via-agp.c                  |    6 
 drivers/char/drm/drm_lock.c                 |   16 
 drivers/char/drm/drm_memory.c               |    2 
 drivers/char/drm/drm_memory_debug.h         |    2 
 drivers/char/drm/mga_drv.c                  |    2 
 drivers/char/drm/radeon_drv.h               |    3 
 drivers/cpufreq/cpufreq.c                   |   14 
 drivers/firmware/Kconfig                    |    1 
 drivers/hwmon/hdaps.c                       |    2 
 drivers/hwmon/it87.c                        |    7 
 drivers/hwmon/lm78.c                        |    2 
 drivers/hwmon/w83627hf.c                    |    8 
 drivers/ieee1394/sbp2.c                     |    6 
 drivers/infiniband/core/mad.c               |    4 
 drivers/input/gameport/gameport.c           |   12 
 drivers/input/input.c                       |   63 +-
 drivers/input/keyboard/atkbd.c              |   99 ++-
 drivers/input/misc/Kconfig                  |   10 
 drivers/input/misc/Makefile                 |    1 
 drivers/input/misc/uinput.c                 |  323 ++++-----
 drivers/input/misc/wistron_btns.c           |  561 +++++++++++++++
 drivers/input/serio/serio.c                 |   12 
 drivers/md/dm-bio-list.h                    |    3 
 drivers/md/dm-ioctl.c                       |    3 
 drivers/md/dm-log.c                         |    4 
 drivers/md/dm-mpath.c                       |   13 
 drivers/md/dm-raid1.c                       |   20 -
 drivers/md/md.c                             |    4 
 drivers/md/raid1.c                          |    8 
 drivers/md/raid10.c                         |    6 
 drivers/md/raid5.c                          |    2 
 drivers/md/raid6main.c                      |   27 +
 drivers/media/dvb/cinergyT2/cinergyT2.c     |    2 
 drivers/media/video/Kconfig                 |    2 
 drivers/media/video/cx88/Kconfig            |   20 -
 drivers/media/video/cx88/Makefile           |   27 -
 drivers/media/video/ir-kbd-gpio.c           |    5 
 drivers/media/video/saa7134/Kconfig         |   12 
 drivers/media/video/saa7134/Makefile        |   19 -
 drivers/media/video/saa7134/saa7134-input.c |    2 
 drivers/message/i2o/pci.c                   |    2 
 drivers/mmc/mmc.c                           |    2 
 drivers/net/dgrs.c                          |    2 
 drivers/pci/hotplug/pciehp.h                |    1 
 drivers/pci/hotplug/pciehp_ctrl.c           |   15 
 drivers/pci/hotplug/pciehp_hpc.c            |   10 
 drivers/pci/pci-acpi.c                      |    1 
 drivers/pcmcia/m32r_cfc.c                   |    3 
 drivers/sbus/char/aurora.c                  |   12 
 drivers/scsi/dpt_i2o.c                      |    9 
 drivers/scsi/scsi.c                         |    2 
 drivers/serial/8250.c                       |    2 
 drivers/serial/8250_pci.c                   |    2 
 drivers/serial/imx.c                        |    2 
 drivers/serial/serial_core.c                |    2 
 drivers/serial/serial_cs.c                  |    6 
 drivers/usb/core/hcd-pci.c                  |   38 +
 drivers/usb/core/hub.c                      |    1 
 drivers/usb/host/ehci-hcd.c                 |  158 ++--
 drivers/usb/host/ehci-hub.c                 |    7 
 drivers/usb/host/ehci-pci.c                 |  355 ++++-----
 drivers/usb/host/ohci-pci.c                 |   36 -
 drivers/usb/media/sn9c102_core.c            |    2 
 drivers/usb/serial/ftdi_sio.c               |    2 
 drivers/usb/serial/ftdi_sio.h               |    7 
 drivers/usb/serial/ipw.c                    |    1 
 drivers/usb/storage/unusual_devs.h          |    9 
 drivers/video/console/fbcon_ccw.c           |    2 
 drivers/video/console/fbcon_rotate.h        |   17 
 drivers/video/console/vgacon.c              |    1 
 drivers/video/fbmem.c                       |    6 
 fs/9p/vfs_inode.c                           |    2 
 fs/cifs/CHANGES                             |    2 
 fs/cifs/cifs_unicode.c                      |   13 
 fs/cifs/cifs_unicode.h                      |    6 
 fs/cifs/cifsencrypt.c                       |    2 
 fs/cifs/cifsfs.c                            |  109 ++-
 fs/cifs/cifsfs.h                            |    2 
 fs/cifs/cifspdu.h                           |   10 
 fs/cifs/cifssmb.c                           |   43 +
 fs/cifs/connect.c                           |   91 +-
 fs/cifs/dir.c                               |   32 +
 fs/cifs/file.c                              |    2 
 fs/cifs/inode.c                             |  202 ++++-
 fs/cifs/misc.c                              |    2 
 fs/cifs/readdir.c                           |   43 +
 fs/cifs/transport.c                         |    4 
 fs/compat.c                                 |   23 -
 fs/compat_ioctl.c                           |    8 
 fs/dquot.c                                  |    6 
 fs/exec.c                                   |    8 
 fs/ext3/resize.c                            |    1 
 fs/fuse/dir.c                               |   37 +
 fs/hugetlbfs/inode.c                        |   12 
 fs/jffs2/debug.h                            |    8 
 fs/nfs/inode.c                              |   26 -
 fs/nfs/nfs4proc.c                           |    6 
 fs/nfs/nfs4state.c                          |   20 -
 fs/proc/task_mmu.c                          |    7 
 fs/reiserfs/inode.c                         |    2 
 fs/xfs/linux-2.6/xfs_aops.c                 |   13 
 fs/xfs/xfs_attr_leaf.c                      |   11 
 fs/xfs/xfs_fsops.c                          |    2 
 fs/xfs/xfs_iomap.h                          |    2 
 fs/xfs/xfs_log_priv.h                       |   36 -
 fs/xfs/xfs_vnodeops.c                       |    5 
 include/asm-alpha/atomic.h                  |    7 
 include/asm-arm/arch-ebsa110/io.h           |    2 
 include/asm-arm/arch-iop3xx/timex.h         |    2 
 include/asm-arm/arch-ixp4xx/ixp4xx-regs.h   |    1 
 include/asm-arm/arch-s3c2410/regs-gpio.h    |  239 ++++++
 include/asm-arm/arch-sa1100/io.h            |    2 
 include/asm-arm/numnodes.h                  |    2 
 include/asm-frv/hardirq.h                   |    1 
 include/asm-frv/ide.h                       |    8 
 include/asm-frv/page.h                      |    4 
 include/asm-frv/semaphore.h                 |    2 
 include/asm-frv/thread_info.h               |    2 
 include/asm-ia64/sn/sn_sal.h                |   34 +
 include/asm-ia64/sn/tioce.h                 |   26 -
 include/asm-ia64/sn/tioce_provider.h        |   17 
 include/asm-m32r/atomic.h                   |   21 +
 include/asm-m32r/ide.h                      |   13 
 include/asm-m32r/mappi3/mappi3_pld.h        |    2 
 include/asm-m32r/system.h                   |   64 ++
 include/asm-powerpc/iommu.h                 |    2 
 include/asm-powerpc/page_64.h               |   23 -
 include/asm-powerpc/tce.h                   |    2 
 include/asm-sparc64/atomic.h                |    1 
 include/asm-sparc64/pgtable.h               |   10 
 include/asm-um/ldt-i386.h                   |    2 
 include/asm-um/ldt-x86_64.h                 |   69 ++
 include/asm-um/ldt.h                        |   74 --
 include/asm-x86_64/atomic.h                 |   51 +
 include/asm-x86_64/msr.h                    |    2 
 include/linux/cpu.h                         |    7 
 include/linux/gfp.h                         |    9 
 include/linux/jbd.h                         |   17 
 include/linux/memory.h                      |    1 
 include/linux/mm.h                          |   27 -
 include/linux/mmc/protocol.h                |    4 
 include/linux/mmzone.h                      |   18 
 include/linux/netfilter_ipv4/ipt_sctp.h     |   12 
 include/linux/page-flags.h                  |    4 
 include/linux/pci_ids.h                     |    1 
 include/linux/rmap.h                        |    4 
 include/linux/sched.h                       |    1 
 include/linux/serial_core.h                 |    3 
 include/linux/skbuff.h                      |    7 
 include/linux/swap.h                        |    6 
 include/linux/uinput.h                      |   13 
 include/linux/usb.h                         |    1 
 include/net/ipv6.h                          |    2 
 include/net/route.h                         |    3 
 kernel/cpu.c                                |   83 +-
 kernel/fork.c                               |    7 
 kernel/futex.c                              |   15 
 kernel/irq/manage.c                         |   15 
 kernel/posix-cpu-timers.c                   |    2 
 kernel/printk.c                             |    2 
 kernel/workqueue.c                          |   12 
 lib/genalloc.c                              |   14 
 mm/Kconfig                                  |    6 
 mm/fremap.c                                 |   28 -
 mm/hugetlb.c                                |    6 
 mm/madvise.c                                |    2 
 mm/memory.c                                 |  213 ++++--
 mm/mempolicy.c                              |   12 
 mm/mmap.c                                   |   11 
 mm/mprotect.c                               |    8 
 mm/msync.c                                  |   12 
 mm/nommu.c                                  |    2 
 mm/page_alloc.c                             |   75 +-
 mm/rmap.c                                   |   58 +-
 mm/swap.c                                   |    3 
 mm/thrash.c                                 |   10 
 mm/truncate.c                               |    6 
 mm/vmscan.c                                 |   29 +
 net/bridge/br_if.c                          |    1 
 net/core/filter.c                           |    6 
 net/dccp/proto.c                            |    1 
 net/ipv4/devinet.c                          |   40 +
 net/ipv4/fib_frontend.c                     |    2 
 net/ipv4/fib_trie.c                         |    3 
 net/ipv4/netfilter/Kconfig                  |   10 
 net/ipv4/netfilter/ip_conntrack_netlink.c   |   25 -
 net/ipv6/addrconf.c                         |   10 
 net/ipv6/datagram.c                         |    2 
 net/ipv6/exthdrs.c                          |   22 +
 net/ipv6/ip6_flowlabel.c                    |   16 
 net/ipv6/raw.c                              |    4 
 net/ipv6/udp.c                              |    4 
 net/netlink/af_netlink.c                    |    2 
 net/sched/sch_netem.c                       |    2 
 net/sunrpc/rpc_pipe.c                       |   26 -
 scripts/kconfig/Makefile                    |   68 +-
 sound/core/memalloc.c                       |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c             |    1 
 281 files changed, 3435 insertions(+), 2934 deletions(-)
--21872808-894810794-1133237495=:3177--
