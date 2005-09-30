Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVI3WJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVI3WJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVI3WJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:09:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030467AbVI3WJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:09:47 -0400
Date: Fri, 30 Sep 2005 15:09:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.14-rc3
Message-ID: <Pine.LNX.4.64.0509301501150.3378@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this may or may not be the last -rc before 2.6.14, but the point is 
that we're getting closer. 

The diffstat (not included here) tells the story: most of the changes are 
just a couple of lines, with a few outliers: a new "cassini" network 
driver, the mpt sas driver, some ip-conntrac work, and net/llc cleanups. 
Oh, and sparc updates and some ppc tlb and smu work.

I think the shortlog is actually pretty descriptive, so without further 
ado, here it is.

		Linus

---

Al Viro:
  missing asm/irq.h (cs89x0)
  useless includes of linux/irq.h in arch/i386
  m32r: missing __iomem in ioremap() declaration
  m32r: set CHECKFLAGS properly
  m32r: more basic __user annotations
  missing dependency on arm O= builds
  uml makefiles sanitized
  proc_mkdir() should be used to create procfs directories
  cyblafb: portability fixes, sanitized work with pointers
  arm/versatile iomem annotations
  arm/rpc iomem annotations
  ia64 basic __user annotations
  s390 signal annotations
  ppc64 get_user annotations
  ppc32 ld.script fix for building on ppc64
  mv64x60 iomem annotations
  i810-i2c iomem annotations
  saa6588 __user annotations
  mv64x60_wdt __user annotations and cleanups
  [CASSINI]: sparse annotations and fixes
  missing ERR_PTR in 9fs
  useless linux/irq.h includes (arch/um)
  cassini annotations and fixes
  cpuset crapectomy
  uml get_user() NULL noise removal
  bogus BUILD_BUG_ON() in bpa_iommu
  volatile unsigned short f(...) doesn't make sense
  missing qualifiers in readb() et.al. on ppc
  useless includes of linux/irq.h (arch/ppc)

Alan Cox:
  PATCH: silly in piix driver
  PATCH: remove function for non-PCI as requested

Alan Stern:
  [SCSI] fix use after potential free in scsi_remove_device
  [SCSI] fix oops in scsi_release_buffers()
  [SCSI] SCSI scanning and removal fixes
  USB: Update Documentation/usb/URB.txt

Alasdair G Kergon:
  device-mapper: Fix queue_if_no_path initialisation

Alex Williamson:
  [NET]: Make sure ctl buffer is aligned properly in sys_sendmsg().

Alexey Dobriyan:
  [NETFILTER] Fix sparse endian warnings in pptp helper
  [IRDA]: Fix memory leak in irttp_init()
  [IRDA]: *irttp cleanup
  [ROSE]: do proto_unregister() on exit paths
  [ROSE]: return sane -E* from rose_proto_init()
  [ROSE]: check rose_ndevs earlier
  [ROSE]: fix typo (regeistration)
  n_r3964: drop bogus fmt casts

Alexey Kuznetsov:
  [TCP]: Don't over-clamp window in tcp_clamp_window()

Alok N Kataria:
  kmalloc_node IRQ safety fix

Amos Waterland:
  fix drivers/pci/probe.c warning
  [NET]: Protect neigh_stat_seq_fops by CONFIG_PROC_FS

Andi Kleen:
  Fix up TLB flush filter disabling

Andreas Herrmann:
  [SCSI] change port speed definitions for scsi_transport_fc
  [SCSI] zfcp: fix race conditions when accessing erp_action lists
  [SCSI] zfcp: remove union zfcp_req_data, use unit refcount for FCP commands
  [SCSI] zfcp: remove function zfcp_fsf_req_wait_and_cleanup
  [SCSI] zfcp: shorten eh_bus_reset and eh_host_reset handlers
  [SCSI] zfcp: add additional fc_host attributes

Andrew Morton:
  Add printk_clock()
  proc_task_root_link c99 fix
  atyfb c99 fix
  revert oversized kmalloc check
  x86: hw_irq.h warning fix

Andy Currid:
  Add NVIDIA device ID in sata_nv

Anton Altaparmakov:
  NTFS: More runlist handling fixes from Richard Russon and myself.
  NTFS: Fix sparse warnings that have crept in over time.
  NTFS: Change ntfs_cluster_free() to require a write locked runlist on entry
  NTFS: Fix the definition of the CHKD ntfs record magic.  It had an off by
  NTFS: More $LogFile handling fixes: when chkdsk has been run, it can leave the
  NTFS: Re-fix sparse warnings in a more correct way, i.e. don't use an enum with

Anton Blanchard:
  ppc64: Fix issue with non zero boot cpu
  ppc64: Fix LPAR regression
  ppc64: Fix build with iommu debug enabled
  ppc64: Fix 64bit ptrace DABR support
  ppc64: Add missing barrier() in kexec code

Antonino A. Daplas:
  nvidiafb: Fix absence of cursor in nvidiafb
  fbdev: Fix reversed back and front porches
  intelfb: Fix regression (blank display) from ioremap patch

Arnaldo Carvalho de Melo:
  [LLC]: Make llc_frame_alloc take a net_device as an argument
  [LLC]: Simplify llc_c_ac code, removing unneeded assignments to variables
  [LLC]: Remove unneeded f_bit variables
  [LLC]: introduce llc_conn_tmr_common_cb, to avoid code duplication
  [LLC]: Remove unneeded temp net_device variables
  [LLC]: Update comments for llc_ui_bind and llc_ui_autobind to match new behaviour
  [LLC]: Mark llc_find_next_offset as __init, saving some more bytes
  [LLC]: Help the compiler with likely/unlikely, saving some more bytes
  [LLC]: Use const in llc_c_ev.c
  [LLC]: Remove unused functions from llc_c_ev.c
  [LLC]: Convert llc_ui_wait_for_ functions to use prepare_to_wait/finish_wait
  [LLC]: Use the sk_wait_event primitive
  [LLC]: Add sysctl support for the LLC timeouts
  [LLC]: Use some more likely/unlikely
  [LLC]: Use sk_wait_data
  [LLC]: Do better struct sock accounting on skbs
  [LLC]: Use refcounting with struct llc_sap
  [LLC]: Fix sparse warnings
  [LLC]: Fix the accept path
  [LLC]: fix llc_ui_recvmsg, making it behave like tcp_recvmsg

Ben Dooks:
  [ARM] 2924/3: taglist - postfix section with .init for `make buildcheck`
  [ARM] 2925/3: earlyparam - postfix section with .init for `make buildcheck`
  [ARM] 2926/1: .proc.info - postfix section with .init for `make buildcheck`
  [ARM] 2927/1: .arch.info - postfix section with .init for `make buildcheck`
  [ARM] 2928/1: S3C2410 - make machine init code static
  [ARM] 2933/1: S3C2410 - fix serial port warnings
  [ARM] 2934/1: Anubis - fix VA offsets for CPLD registers
  [NET]: Fix GCC4 compile error: sysctl in linux/if_ether.h
  s3c2410fb: Minor warning fix

Benjamin Herrenschmidt:
  ppc64: Build zImage.vmode for G5
  ppc32: fix build with oprofile
  ppc64: SMU driver update & i2c support
  mesh scsi: fix error handling
  ppc64: Fix huge pages MMU mapping bug
  ppc: fix stupid thinko in oprofile fix
  orinoco: Fix flood of kernel log with stupid WE warnings
  ppc64: More hugepage fixes
  Fix ppc64 smu driver locking

Bernd Petrovitsch:
  Rename vprintk define in bttpvp.h

Bill Nottingham:
  fix class symlinks in sysfs

Bjorn Helgaas:
  PCI: remove unused "scratch"

Brent Casavant:
  ioc4_serial: Remove bogus error message

Catalin Marinas:
  [ARM] 2932/1: Avoid the "noreturn" warning in arch/arm/kernel/traps.c
  [ARM] 2939/1: Fix compilation error in arch/arm/mm/flush.c
  [ARM] 2942/1: Fix the warning in arch/arm/common/gic.c

Chas Williams:
  [ATM]: track and close listen sockets when sigd exits

Chris Sykes:
  Fix ext2_new_inode() failure paths
  Fix ext3_new_inode() failure paths

Chris Zankel:
  xtensa: remove io_remap_page_range and minor clean-ups

Christoph Hellwig:
  [SCSI] fusion core changes for SAS support
  [SCSI] fusion SAS support (mptsas driver)
  remove blkdev_scsi_issue_flush_fn again
  fixup Documentation/DocBook/kernel-hacking.tmpl

Christoph Lameter:
  slab: fix handling of pages from foreign NUMA nodes
  __kmalloc: Generate BUG if size requested is too large.

Christopher Zimmermann:
  [SPARC] cs4231: Fix SBUS support in this driver.

Chuck Ebbert:
  atiixp_modem printk fixes

Clemens Buchacher:
  oss: don't concatenate __FUNCTION__ with strings

Corey Minyard:
  Add IPMI poweroff control to sysfs

Daniel Jacobowitz:
  [ARM] 2941/1: Fix running legacy binaries from a soft-float root filesystem with CONFIG_IWMMXT.

Daniel Phillips:
  [NET]: Use non-recursive algorithm in skb_copy_datagram_iovec()

Daniel Ritz:
  Driver Core: fis bus rescan devices race
  driver core: add helper device_is_registered()
  yenta: auto-tune EnE bridges for CardBus cards
  yenta: don't mess with bridge control register
  yenta: add support for more TI bridges
  yenta: more ENE bridges
  usb/core/hcd-pci.c: don't free_irq() on suspend

Dave C Boutcher:
  [SCSI] ibmvscsi compatibility fix

Dave Kleikamp:
  JFS: Fix sparse warnings, including endian error
  JFS: don't dereference tlck->ip from txUpdateMap

David Brownell:
  USB: sl811-hcd minor fixes

David Hollis:
  USB: Add Novatel CDMA Wireless PC card IDs to airprime

David Howells:
  Keys: Add possessor permissions to keys [try #3]

David S. Miller:
  [SPARC64]: Handle little-endian unaligned loads/stores correctly.
  [SPARC64]: Move DCACHE_ALIASING_POSSIBLE define to asm/page.h
  [SPARC64]: Verify vmalloc TLB misses more strictly.
  [SPARC64]: Move kernel TLB miss handling into a seperate file.
  [SPARC64]: Kill SZ_BITS define from dtlb_backend.S
  [SPARC64]: Remove ktlb.S instruction patching.
  [SPARC64]: Do not allocate prom translations using bootmem.
  [SPARC64]: Break up inherit_prom_mappings() into it's constituent parts.
  [SPARC64]: Do not allocate OBP page tables using bootmem
  [SPARC64]: Remove unnecessary paging_init() cruft.
  [SPARC64]: Kill readjust_prom_translations()
  [SPARC64]: Rewrite bootup sequence.
  [SPARC64]: Fix comment typo in head.S
  [SPARC64]: Kill unused variable in setup_arch()
  [SPARC64]: Mark functions called by paging_init() as __init.
  [SPARC64]: Fix mask formation in tomatillo_wsync_handler()
  [SPARC64]: Add CONFIG_DEBUG_PAGEALLOC support.
  [SPARC64]: Probe D/I/E-cache config and use.
  [AF_PACKET]: Remove bogus checks added to packet_sendmsg().
  [SPARC64]: Simplify Spitfire D-cache page flush.
  [SPARC64]: Do not do TLB pre-filling any more.
  [NEIGH]: Add debugging check when adding timers.
  [TG3]: Update driver version and release date.
  [NET]: Add Sun Cassini driver.
  [NET]: Slightly optimize ethernet address comparison.
  [SPARC64]: Add defines for 32MB/256MB PTE page size on Ultra-IV+.
  [SPARC64]: Add missing IDs for newer cpus.
  [TCP]: Fix init_cwnd calculations in tcp_select_initial_window()
  [SPARC64]: Fix bug in unaligned load endianness swapping
  [SPARC64]: Convert to use generic exception table support.
  [SPARC64]: Fix fault handling in unaligned trap handler.
  [SPARC64]: Simplify user fault fixup handling.
  [SPARC]: Declare paging_init() in asm/pgtable.h
  [SPARC64]: Move phys_base, kern_{base,size}, and sp_banks[] init to paging_init
  [SPARC64]: Kill all external references to sp_banks[]
  [SPARC64]: Solidify check in cheetah_check_main_memory().
  [NET]: Fix reversed logic in eth_type_trans().
  [TCP]: Revert 6b251858d377196b8cea20e65cae60f584a42735
  [SPARC64]: Rewrite convoluted physical memory probing.
  [SPARC64]: Kill arch/sparc64/prom/memory.c
  [SPARC64]: Fix several bugs in flush_ptrace_access().
  [RADEON]: Fix unaligned I/O port access during probe.

David Vrabel:
  [ARM] 2935/1: ixp4xx: fix warnings in ixp4xx_set_irq_type

Davide Libenzi:
  epoll: handle timeout overflow

Deepak Saxena:
  Fix I2O config-osm init to return proper error
  Fix ixp4xx MTD driver module build
  Fix thinko in previous ARM 2917/1 patch

Dmitry Torokhov:
  Input: check switch bitmap when matching handlers

Dominik Brodowski:
  yenta: tiny cleanup
  pcmcia: new IDs for serial_cs
  pcmcia: update ID for NinjaATA
  pcmcia: allow one port excludes
  pcmcia: only start up nonstatic sockets if both mem and io are available

Ed L Cashin:
  [BYTEORDER]: Document alignment and byteorder macros

Eric Dumazet:
  Adds sys_set_mempolicy() in include/linux/syscalls.h
  [NET]: Prefetch dev->qdisc_lock in dev_queue_xmit()
  [NET]: Reorder some hot fields of struct net_device

Eric W. Biederman:
  [AF_PACKET]: Allow for > 8 byte hardware addresses.
  reboot: comment and factor the main reboot functions
  suspend: cleanup calling of power off methods.

Evgeniy Polyakov:
  [CONNECTOR]: async connector mode.

Frank Filz:
  [NET]: Fix module reference counts for loadable protocol modules

Gen FUKATSU:
  [ARM] 2940/1: Fix BTB entry flush in arch/arm/mm/cache-v6.S

Glauber de Oliveira Costa:
  ext3: EXT3_DEBUG build fixes

goggin, edward:
  device-mapper: Trigger an event when a table is deleted

Grant Coady:
  DEBUG redefined in drivers/mtd/devices/docecc.c

Greg Kroah-Hartman:
  I2C: remove me from the MAINTAINERS file for i2c

Hal Rosenstock:
  IPoIB: Fix SA client retransmission strategy
  IB: Fix data length for RMPP SA sends
  [IB] Fix RMPP receive length calculation

Harald Welte:
  [NETFILTER] fix DEBUG statement in PPTP helper
  [NETFILTER] remove unneeded structure definition from conntrack helper
  [NETFILTER] Fix conntrack event cache deadlock/oops
  documentation: sparse no longer uses bk, but git
  [NETFILTER]: Fix ip[6]t_NFQUEUE Kconfig dependency
  [NETFILTER] ip_conntrack: Update event cache when status changes
  [NETFILTER]: Fix invalid module autoloading by splitting iptable_nat

Herbert Xu:
  [TCP]: Adjust Reno SACK estimate in tcp_fragment
  [IPV6]: Fix [Bug 5306] Oops on IPv6 route lookup

Hidetoshi Seto:
  [IA64] MCA recovery verify pfn_valid

Hironobu Ishii:
  ipmi_msghandler: inconsistent spin_lock usage

Horms:
  [IPVS]: Add netdev and me as maintainer contacts

Ivan Kokshaysky:
  alpha: fix kernel panic during SysRq-b
  slab: alpha inlining fix
  pci: fixup parent subordinate busnr

Jack Morgenstein:
  [IB] mthca: fix hw_ver value returned from mthca_query_device

James Bottomley:
  [SCSI] blacklist REPORT LUNS usage on transtec arrays
  [SCSI] aic7xxx: move to dma_get_required_mask() and correct 39 bit assumptions
  [SCSI] fix sym scsi boot hang
  [SCSI] atp870u: fix memory addressing bug
  [SCSI] fix oops on usb storage device disconnect
  [SCSI] Fix thread termination for the SCSI error handle

James Morris:
  SELinux - fix SCTP socket bug and general IP protocol handling

Jochen Friedrich:
  [LLC]: Fix for Bugzilla ticket #5156
  [LLC]: Fix for Bugzilla ticket #5157
  [LLC]: Fix llc_fixup_skb() bug
  [TR]: Set correct frame type for SNAP packets

Jody McIntyre:
  MAINTAINERS: sbp2 driver is not orphaned.
  sbp2: fix deadlocks and delays on device removal/rmmod
  sbp2: default to serialize_io=1
  ieee1394: reorder activities after bus reset (fixes device detection)
  ieee1394: skip unnecessary pause when scanning config ROMs
  ieee1394: fix for debug output
  ieee1394: use time_before()
  ieee1394: trivial edits of a few comments
  ieee1394: remove superfluous include in csr1212
  eth1394: workaround limitation in rawiso routines
  ieee1394: delete legacy module aliases
  ohci1394: less noise in dmesg

john stultz:
  x86-64: Fix bad assumption that dualcore cpus have synced TSCs

Jon Burgess:
  dvb: fix NULL pointer dereference when loading the budget-av module

Kars de Jong:
  pcmcia: fix cross-platform issues with pcmcia module aliases

Karsten Keil:
  hisax: remove URB_ASYNC_UNLINK

Keir Fraser:
  Fix mmap() of /dev/hpet

Keith Owens:
  [IA64] Wire in the MCA/INIT handler stacks

Kevin Vigor:
  USB: fix pegasus driver

Kirill Korotaev:
  x86_64: Add missing () around arguments of pte_index macro

Komuro:
  pcmcia: fix Kconfig dependency

Kostik Belousov:
  readv/writev syscalls are not checked by lsm

Krzysztof Benedyczak:
  Make POSIX message queue sys_mq_open() honor umask

Kumar Gala:
  ppc32: Fix configuration of PCI IO space on MPC85xx platform

Latchesar Ionkov:
  v9fs: make conv functions to check for conv buffer overflow
  v9fs: allocate the Rwalk qid array from the right conv buffer
  v9fs: make copy of the transport prototype instead of using it directly
  v9fs: replace strlen on newly allocated by __getname buffers to PATH_MAX
  v9fs: don't free root dentry & inode if error occurs in v9fs_get_sb
  v9fs: fix races in fid allocation

Linda Xie:
  PCI Hotplug: Fix buffer overrun in rpadlpar_sysfs.c

Linus Torvalds:
  Make sure SIGKILL gets proper respect
  Revert task flag re-ordering, add comments
  Revert "x86-64: Reverse order of bootmem lists"
  Linux v2.6.14-rc3

Martin Whitaker:
  [ATM]: fix bug in atm address list handling

Matthias Urlichs:
  USB: more device IDs for Option card driver
  usb/serial/option.c: Increase input buffer size

Maxim Shchetynin:
  [SCSI] zfcp: enhancement of zfcp debug features
  [SCSI] zfcp: provide support for NPIV

Michael Chan:
  [TG3]: 5780 PHY fixes
  [TG3]: misc. fixes

Michael Krufky:
  v4l: DViCO FusionHDTV5 Lite GPIO Fix

Michael S. Tsirkin:
  IPoIB: fix module removal race
  IB/mthca: Fix device removal memory leak
  [IB] mthca: fix off by one in clr_int calculation
  [IB] mthca: Fix off by one bug in mthca_map_cmd
  [IB] mthca: Round up number of slots in HCA context memory table

Mike Miller:
  cciss: busy_initializing bug fix

Mike Waychison:
  x86_64: Fix mce_log

Miklos Szeredi:
  fuse: add required version info
  fuse: check reserved node ID values
  fuse: check O_DIRECT

Moore, Eric Dean:
  [SCSI] fusion SAS support (mptsas driver) updates
  [SCSI] fusion SAS support (mptsas driver) minor fix

Nick Piggin:
  mm: move_pte to remap ZERO_PAGE
  i386: include linux/irq.h rather than asm/hw_irq.h

Nick Wilson:
  NFS: fix client oops when debugging is on

nsxfreddy@gmail.com:
  bonding: Fix link monitor capability check (was skge: set mac address oops with bonding)

OGAWA Hirofumi:
  ext3: ext3_show_options fix

Oleg Nesterov:
  fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction

Oliver Dawid:
  [APPLETALK]: Fix broadcast bug.

Olof Johansson:
  PPC64: Fix boot for some pre-POWER4 systems

Paolo 'Blaisorblade' Giarrusso:
  fix locking comment in unmap_region()
  README update from the stone age
  mm: update stale comment for removal of page->list
  mm: add a note about partially hardcoded VM_* flags
  uml: adapt asm/futex.h to our arch
  Remove unused var from asm/futex.h
  uml: remove verify_area_{tt,skas}
  uml: fix modify_ldt - missing break in switch
  uml: fix uname output on 32-bit binary on 64-bit host
  uml: Fix conflict between libc and ipv6
  uml: fix bogus HOST_ELF_CLASS symbol name
  uml: readd removed unistd.h inclusion
  uml: comment about cast build fix
  uml: fix compile warning after consolidation patch
  uml: don't remove umid files in conflict case
  strlcat: use for uml umid.c
  uml: don't redundantly mark pte as newpage in pte_modify
  uml: fix hang in TT mode on fault
  uml: fix condition in tlb flush
  uml: run mconsole "sysrq" in process context
  uml: avoid fixing faults while atomic
  uml: Fix GFP_ flags usage
  uml: use GFP_ATOMIC for allocations under spinlocks.
  uml: replace printk with "stack-friendly" printf - to report console failure
  Add dm-snapshot tutorial in Documentation
  uml: fix page faults in SKAS3 mode.
  uml: clear SKAS0/3 flags when running in TT mode
  uml: revert "run mconsole "sysrq" in process context"
  uml: remove empty hostfs_truncate method

Paul Gortmaker:
  8390 Tx fix for non i386 machines

Paul Jackson:
  cpuset maintainers
  cpuset read past eof memory leak fix

Paul Mackerras:
  ppc64: Fix PCI flags when using OF device tree

Pavel Machek:
  swsusp: fix comments

Pekka Enberg:
  PCI: convert kcalloc to kzalloc

Pete Zaitcev:
  ub: fix burning cds
  ub: Comment out unconditional stall clear

Peter Chubb:
  [IA64] Fix simscsi for new SCSI midlayer

Peter Favrholdt:
  USB: ftdi_sio: allow baud rate to be changed without raising RTS and DTR

Peter Osterlund:
  pktcdvd: MAINTAINERS record

Prasanna S Panchamukhi:
  Update maintainers list with the kprobes maintainers

Rafael J. Wysocki:
  swsusp: do not trigger BUG_ON() if there is not enough memory
  swsusp: remove wrong code from data_free
  swsusp: prevent possible memory leak
  swsusp: avoid problems if there are too many pages to save

Randy Dunlap:
  update URL for HPET spec.
  SOFTWARE_SUSPEND needs HOTPLUG_CPU on SMP
  corrections to top-level README

Randy.Dunlap:
  [SCSI] scsi: 2 drivers need MODULE_LICENSE()

Ravikiran G Thirumalai:
  x86_64: fix the BP node_to_cpumask
  x86_64 early numa init fix

Richard Purdie:
  USB: fix pxa2xx_udc compile warnings

Rob Landley:
  Fix bd_claim() error code.

Robert Love:
  hdaps: small update.

Roland Dreier:
  IB/mthca: assign ACK timeout field correctly
  IB/mthca: fix posting of first work request
  IB/mthca: Initialize eq->nent before we use it
  IB/mthca: Fix posting work requests to shared receive queues
  IB/mthca: Don't try to set srq->last for userspace SRQs
  IPoIB: Don't flush workqueue from within workqueue
  [IB] mthca: Fix doorbell record resource leak
  [IB] uverbs: Close some exploitable races

Roland McGrath:
  Fix task state testing properly in do_signal_stop()

Roman Kagan:
  [ATM]: net/atm/ioctl.c: autoload pppoatm and br2684

Russell King:
  [ARM] Prevent deadlock in page fault handler
  [ARM] Fix pcf8583 to build
  [ARM] Fix context switch with ARMv6 + TLS
  [SERIAL] Remove unused variable in clps711x.c
  [MFD] Fix "bious one-bit signed bitfield" errors
  [ARM] Fix compiler warnings for memcpy_toio/memcpy_fromio/memset_io
  [ARM] Remove SA_IRQNOMASK
  [ARM] pxafb: Remove #if DEBUG, convert DPRINTK to pr_debug
  [ARM] Fix warning in arch/arm/mach-pxa/generic.c
  [ARM] Don't include asm/arch/hardware.h directly
  [ARM] Don't include mach-types.h unnecessarily

Rusty Russell:
  Ignore trailing whitespace on kernel parameters correctly

Scott Talbert:
  [ATM]: [lec] attempt to support cisco failover
  [ATM]: [lec] reset retry counter when new arp issued

Sean Hefty:
  [IB] Add MAD data field size definitions

Sridhar Samudrala:
  [SCTP]: Fix SCTP_SHUTDOWN notifications.

Sripathi Kodi:
  Fix invisible threads problem

Stephane Kardas:
  fat: fix adate

Stephen Hemminger:
  [FIB_TRIE]: message cleanup
  [TCP]: Set default congestion control correctly for incoming connections.
  skge: add maintainer
  skge: expand ethtool debug register dump
  skge: check length from PHY
  skge: fix Yukon-Lite A0 workaround

Steve French:
  cifs: Add support for suspend

Timothy Thelin:
  [SCSI] scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd

Tom 'spot' Callaway:
  [ATYFB]: Fix build with CONFIG_FB_ATY_GENERIC_LCD disabled.

Tommy Christensen:
  r8169: call proper VLAN receive function

Vincent Sanders:
  [ARM] 2922/1: compile fix for shark
  [ARM] 2936/1: ixp4xx default config fixes

Vlad Drukker:
  [BRIDGE]: TSO fix in br_dev_queue_push_xmit

Zach Brown:
  aio: lock around kiocbTryKick()
  aio: remove unlocked task_list test and resulting race
  aio: avoid extra aio_{read,write} call when ki_left == 0

Zhang, Yanmin:
  utilization of kprobe_mutex is incorrect on x86_64

