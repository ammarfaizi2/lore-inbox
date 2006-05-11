Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWEKXoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWEKXoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWEKXoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:44:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750831AbWEKXoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:44:07 -0400
Date: Thu, 11 May 2006 16:44:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.17-rc4
Message-ID: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've let the release time between -rc's slide a bit too much again, 
but -rc4 is out there, and this is the time to hunker down for 2.6.17.

If you know of any regressions, please holler now, so that we don't miss 
them. 

-rc4 itself is mainly random driver fixes (sound, infiniband, scsi, 
network drivers), but some splice fixes too and some arch (arm, powerpc, 
mips) updates. Shortlog follows,

		Linus

---
Adrian Bunk:
      [SCSI] megaraid/megaraid_mm.c: fix a NULL pointer dereference
      [ALSA] sound/pci/: remove duplicate #include's
      Kobject: possible cleanups
      re-add the OSS SOUND_CS4232 option
      [IRDA]: Removing unused EXPORT_SYMBOLs

Akinobu Mita:
      [NET]: use hlist_unhashed()

Al Viro:
      deal with deadlocks in audit_free()
      move call of audit_free() into do_exit()
      drop gfp_mask in audit_log_exit()
      drop task argument of audit_syscall_{entry,exit}
      no need to wank with task_lock() and pinning task down in audit_syscall_exit()

Alan Modra:
      powerpc64: Fix loading of modules without a .toc section

Alan Stern:
      USB: net2280: Handle STALLs for 0-length control-IN requests
      USB: net2280: send 0-length packets for ep0
      USB: net2280: check for shared IRQs
      USB: net2280: set driver data before it is used
      [NET]: Make netdev_chain a raw notifier.

Alexey Kuznetsov:
      [IPV6]: skb leakage in inet6_csk_xmit

Ananth N Mavinakayanahalli:
      powerpc/kprobes: fix singlestep out-of-line

Andi Kleen:
      Mark VMSPLIT EMBEDDED
      x86_64: Add compat_sys_vmsplice and use it in x86-64
      i386/x86-64: Fix ACPI disabled LAPIC handling mismerge
      i386: Fix overflow in e820_all_mapped
      i386: Remove apic= warning
      Remove wrong cpu_has_apic checks that came from mismerging
      x86_64: Check for too many northbridges in IOMMU code
      x86_64: Avoid EBDA area in early boot allocator
      x86_64: Move ondemand timer into own work queue

Andreas Herrmann:
      s390: qdio memory allocations

Andreas Schwab:
      sound/ppc: snd_pmac_toonie_init should be __init
      powerpc: Wire up *at syscalls

Andrew Morton:
      [SCSI] megaraid: unused variable
      request_irq(): remove warnings from irq probing
      silence initcall warnings

Anton Blanchard:
      powerpc: Add cputable entry for POWER6

Antonino A. Daplas:
      suspend: Documentation update for IBM Thinkpad X30
      asiliantfb: Add help text in Kconfig

Arnd Bergmann:
      spufs: Disable local interrupts for SPE hash_page calls.
      powerpc: update cell_defconfig

Ashok Raj:
      enable X86_PC for HOTPLUG_CPU

Atsushi Nemoto:
      [MIPS] Fix ip27 build.
      [MIPS] Fix bitops for MIPS32/MIPS64 CPUs.
      [MIPS] Use __ffs() instead of ffs() in ip32_irq0().
      [MIPS] Sparse: fix sparse for 64-bit kernels.
      kbuild: fix modpost segfault for 64bit mipsel kernel
      RTC: rtc-dev tweak for 64-bit kernel
      genrtc: fix read on 64-bit platforms

Ayaz Abdulla:
      forcedeth: fix multi irq issues

Bastiaan Jacques:
      [ALSA] via82xx: add support for VIA VT8251 (AC'97)
      [ALSA] via82xx: tweak VT8251 workaround

Bastian Blank:
      s390: make qeth buildable

Bellido Nicolas:
      [ARM] 3503/1: Fix map_desc structure for aaec2000
      [ARM] 3504/1: Fix clcd includes for aaec2000
      [ARM] 3505/1: aaec2000: entry-macro.S needs asm/arch/irqs.h
      [ARM] 3506/1: aaec2000: debug-macro.S needs hardware.h
      [ARM] 3507/1: Replace map_desc.physical with map_desc.pfn: aaed2000

Brent Casavant:
      [IA64] IOC4 config option ordering
      Altix: correct ioc4 port order

Brian King:
      [SCSI] scsi: Add IBM 2104-DU3 to blist

Bryan O'Sullivan:
      IB/ipath: fix race with exposing reset file
      IB/ipath: set up 32-bit DMA mask if 64-bit setup fails
      IB/ipath: iterate over correct number of ports during reset
      IB/ipath: change handling of PIO buffers
      IB/ipath: fix verbs registration
      IB/ipath: prevent hardware from being accessed during reset
      IB/ipath: simplify RC send posting
      IB/ipath: simplify IB timer usage
      IB/ipath: improve sparse annotation
      IB/ipath: fix label name in interrupt handler
      IB/ipath: tidy up white space in a few files

Charis Kouzinopoulos:
      [ALSA] Fix typos and add information about Jack support to Audiophile-Usb.txt

Chen, Kenneth W:
      [IA64] strcpy returns NULL pointer and not destination pointer

Chris Dearman:
      [MIPS] 24K LV: Add core card id.

Chris Wedgwood:
      PCI quirk: VIA IRQ fixup should only run for VIA southbridges

Christian Borntraeger:
      s390: fix slab debugging
      s390: add read_mostly optimization

Christoph Hellwig:
      [IRDA]: Switching to a workqueue for the SIR work

Christoph Lameter:
      [IA64] Setup an IA64 specific reclaim distance
      page migration: Fix fallback behavior for dirty pages

Chuck Ebbert:
      i386: fix broken FP exception handling

Clemens Ladisch:
      [ALSA] add another Phase 26 quirk

Cliff Wickman:
      [IA64] enable dumps to capture second page of kernel stack

Corey Minyard:
      x86_64: fix die_lock nesting
      x86_64: add nmi_exit to die_nmi

Craig Brind:
      via-rhine: zero pad short packets on Rhine I ethernet cards

Daniel Drake:
      tipar oops fix
      softmac: don't reassociate if user asked for deauthentication
      softmac: make non-operational after being stopped

Darrel Goeddel:
      support for context based audit filtering
      support for context based audit filtering, part 2

Dave Jones:
      Avoid printing pointless tsc skew msgs

David Brownell:
      [IRDA]: smsc-ircc: Minimal hotplug support.

David Gibson:
      powerpc: Fix pagetable bloat for hugepages

David S. Miller:
      [SPARC64]: Kill __flush_tlb_page() prototype.
      [SPARC64]: Disable preemption during flush_tlb_pending().
      [SPARC]: Hook up vmsplice into syscall tables.

David Woodhouse:
      powerpc: Use check_legacy_ioport() on ppc32 too.
      bcm43xx: Fix access to non-existent PHY registers

dean gaudet:
      off-by-1 in kernel/power/main.c

Deepak Saxena:
      [ARM] 3487/1: IXP4xx: Support non-PCI systems

Denis Vlasenko:
      [SCSI] aic7xxx: ahc_pci_write_config() fix

Dmitry Torokhov:
      Input: allow passing NULL to input_free_device()
      Input: move input_device_id to mod_devicetable.h
      Input: psmouse - fix new device detection logic
      Input: ressurect EVIOCGREP and EVIOCSREP
      Input: make EVIOCGSND return meaningful data

Eric Moore:
      [SCSI] fusion - bug fix stack overflow in mptbase
      [SCSI] mptspi: revalidate negotiation parameters after host reset and resume

Eric Sesterhenn:
      [SCSI] Overrun in drivers/scsi/sim710.c
      fix array overrun in drivers/char/mwave/mwavedd.c

Erik Mouw:
      [ALSA] PCMCIA sound devices shouldn't depend on ISA

Eugene Surovegin:
      ppc32: add 440GX erratum 440_43 workaround

Francois Romieu:
      dl2k: use DMA_48BIT_MASK constant

FUJITA Tomonori:
      [SCSI] ibmvscsi: fix leak when failing to send srp event

Gary Zambrano:
      [TG3]: Add reset_phy parameter to chip reset functions

George G. Davis:
      [ARM] 3499/1: Fix VFP FPSCR corruption for double exception case

Gerald Schaefer:
      s390: segment operation error codes

Greg Kroah-Hartman:
      PCI: fix via irq SATA patch

Harald Welte:
      [Cardman 40x0] Fix udev device creation

Heiko Carstens:
      s390: instruction processing damage handling
      [IPV4]: inet_init() -> fs_initcall
      s390: fix ipd handling
      s390: bug in setup_rt_frame

Henrik Kretzschmar:
      [ALSA] pcxhr - Fix a compiler warning on 64bit architectures
      [ALSA] add __devinitdata to all pci_device_id

Herbert Valerio Riedel:
      au1000_eth.c: use ether_crc() from <linux/crc32.h>
      phy: mdiobus_register(): initialize all phy_map entries

Herbert Xu:
      [IPSEC]: Fix IP ID selection
      [TCP]: Fix sock_orphan dead lock
      [DCCP]: Fix sock_orphan dead lock
      [NET] linkwatch: Handle jiffies wrap-around

Horst Hummel:
      s390: dasd ioctl never returns
      s390: dasd device identifiers

Hua Zhong:
      [TCP]: Fix unlikely usage in tcp_transmit_skb()
      [IPV4]: Remove likely in ip_rcv_finish()

Ian Abbott:
      USB: ftdi_sio: add support for ASK RDR 400 series card reader

Imre Deak:
      Input: ads7846 - add pen_down sysfs attribute
      Input: ads7846 - power down ADC a bit later
      Input: ads7846 - debouncing and rudimentary sample filtering
      Input: ads7846 - miscellaneous fixes
      Input: ads7846 - handle IRQs that were latched during disabled IRQs
      Input: ads7846 - report 0 pressure value along with pen up event
      Input: ads7846 - improve filtering for thumb press accuracy

Ingo Molnar:
      [XFRM]: fix softirq-unsafe xfrm typemap->lock use
      [XFRM]: fix incorrect xfrm_state_afinfo_lock use
      [XFRM]: fix incorrect xfrm_policy_afinfo_lock use

Ingo Oeser:
      PCI: Documentation: no more device ids

Jack Steiner:
      [IA64] - Fix MAX_PXM_DOMAINS for systems with > 256 nodes
      [IA64-SGI] - Fix discover of nearest cpu node to IO node
      [IA64-SGI] - Reduce overhead of reading sn_topology

James Bottomley:
      [SCSI] Fix DVD burning issues.

James Cameron:
      sis900: phy for FoxCon motherboard

James Smart:
      [SCSI] lpfc 8.1.5 : Fix Discovery processing for NPorts that hit nodev_tmo during discovery
      [SCSI] lpfc 8.1.5 : Use asynchronous ABTS completion to speed up abort completions
      [SCSI] lpfc 8.1.5 : Fixed FC protocol violation in handling of PRLO.
      [SCSI] lpfc 8.1.5 : Fix cleanup code in the lpfc_pci_probe_one() error code path
      [SCSI] lpfc 8.1.5 : Additional fixes to LOGO, PLOGI, and RSCN processing
      [SCSI] lpfc 8.1.5 : Misc small fixes
      [SCSI] lpfc 8.1.5 : Change version number to 8.1.5
      [SCSI] lpfc 8.1.6 : Fix Data Corruption in Bus Reset Path

Jan Beulich:
      kbuild: Do not overwrite makefile as anohter user

Jaroslav Kysela:
      [ALSA] PCM core - introduce CONFIG_SND_PCM_XRUN_DEBUG

Jean Delvare:
      USB: Use new PCI_CLASS_SERIAL_USB_* defines
      Fix OCFS2 warning when DEBUG_FS is not enabled
      ieee80211: Fix A band channel count (resent)

Jeff Dike:
      uml: clean up after MADVISE_REMOVE
      uml: update defconfig
      uml: error handling fixes
      uml: uml-makefile-nicer uses SYMLINK incorrectly
      uml: change timer initialization

Jens Axboe:
      splice: switch to using page_cache_readahead()
      Add find_get_pages_contig(): contiguous variant of find_get_pages()
      splice: make the read-side do batched page lookups
      splice: fix bugs with stealing regular pipe pages
      splice: fix bugs in pipe_to_file()
      pipe: introduce ->pin() buffer operation
      Add ->splice_read/splice_write to def_blk_fops
      splice: call handle_ra_miss() on failure to lookup page
      pipe: enable atomic copying of pipe data to/from user space
      vmsplice: allow user to pass in gift pages
      vmsplice: fix badly placed end paranthesis
      splice: fix page LRU accounting
      vmsplice: restrict stealing a little more
      splice: fix unlocking of page on error ->prepare_write()
      splice: LRU fixups
      splice: rename remaining info variables to pipe
      splice: redo page lookup if add_to_page_cache() returns -EEXIST
      compat_sys_vmsplice: one-off in UIO_MAXIOV check
      [BLOCK] limit request_fn recursion

Jens Osterkamp:
      spidernet: introduce new setting
      spidernet: enable support for bcm5461 ethernet phy

Jeremy Kerr:
      powerpc: Allow devices to register with numa topology
      powerpc: cell: Add numa id to struct spu

Jes Sorensen:
      [IA64] update sn2 defconfig

Jesper Juhl:
      [IA64] Remove redundant NULL checks before kfree
      [SCSI] SCSI: aic7xxx_osm_pci resource leak fix.
      USB: Resource leak fix for whiteheat driver
      PCI: fix potential resource leak in drivers/pci/msi.c
      uml: remove NULL checks and add some CodingStyle
      [TG3]: Fix possible NULL deref in tg3_run_loopback().

Jing Min Zhao:
      [NETFILTER]: H.323 helper: Change author's email address

Joel H Schopp:
      spufs: fix for CONFIG_NUMA

John Heffner:
      [TCP]: Fix snd_cwnd adjustments in tcp_highspeed.c

John Reed Riley:
      Input: wistron - add support for Fujitsu N3510

Jon Anders Haugum:
      [SERIAL] 8250: set divisor register correctly for AMD Alchemy SoC uart

Jon Mason:
      [IA64] remove asm-ia64/bitops.h self-inclusion

Jon Smirl:
      Frame buffer: remove cmap sysfs interface

Joris van Rantwijk:
      uml: skas0 support for 2G/2G hosts

Ju, Seokmann:
      [SCSI] megaraid_{mm,mbox}: fix a bug in reset handler

Juha Yrjola:
      Input: ads7846 - use msleep() instead of udelay() in suspend

Kay Sievers:
      Kobject: fix build error

Kenrik Kretzschmar:
      [ALSA] adding __devinitdata to pci_device_id

Kimball Murray:
      x86_64: avoid IRQ0 ioapic pin collision

Laurent Meyer:
      s390: alternate signal stack handling bug

Linas Vepstas:
      powerpc/pseries: avoid crash in PCI code if mem system not up

Linus Torvalds:
      [SCSI] advansys driver: limp along on x86
      CREDITS file update (Tristan Greaves)
      Fix ptrace_attach()/ptrace_traceme()/de_thread() race
      Revert "kbuild: fix modpost segfault for 64bit mipsel kernel"
      ptrace_attach: fix possible deadlock schenario with irqs
      Linux v2.6.17-rc4

Luiz Fernando N. Capitulino:
      USB: ftdi_sio: Adds support for iPlus device.

mao, bibo:
      kprobe cleanup for VM_MASK judgement

Marcelo Tosatti:
      ppc32/8xx: Fix r3 trashing due to 8MB TLB page instantiation

mark gross:
      EDAC Coexistence with BIOS

Markus Gutschke:
      [ARM] 3486/1: Mark memory as clobbered by the ARM _syscallX() macros

Martin Schwidefsky:
      s390: futex atomic operations
      s390: new system calls

Masami Hiramatsu:
      kprobe: fix resume execution on i386

Mattia Dongili:
      uml: search from uml_net in a more reasonable PATH

mdr@sgi.com:
      [SCSI] mptfc: race between mptfc_register_dev and mptfc_target_alloc

Michael Buesch:
      bcm43xx: fix iwmode crash when down
      bcm43xx: Fix array overrun in bcm43xx_geo_init

Michael Chan:
      [TG3]: Call netif_carrier_off() during phy reset
      [TG3]: Add phy workaround
      [TG3]: Reset chip when changing MAC address
      [TG3]: Fix bug in nvram write
      [TG3]: Update version and reldate

Michael Reed:
      [SCSI] qla2xxx: Correct eh_abort recovery logic.

Michael S. Tsirkin:
      IB/mthca: FMR ioremap fix

Mikael Pettersson:
      x86_64: make PC Speaker driver work

Mike Habeck:
      [IA64-SGI] fix SGI Altix tioce_reserve_m32() bug

Mike Kravetz:
      sparsemem interaction with memory add bug fixes

Mingming Cao:
      ext3: multile block allocate little endian fixes

Moore, Eric:
      [SCSI] mptfusion: bug fix's for raid components adding/deleting
      [SCSI] - fusion - mptfc bug fix's to prevent deadlock situations

Nathan Bronson:
      USB: ftdi_sio vendor code for RR-CirKits LocoBuffer USB

Nathan Scott:
      [XFS] Fix a possible forced shutdown due to mishandling write barriers
      [XFS] Fix a project quota space accounting leak on rename.
      [XFS] Fix a possible metadata buffer (AGFL) refcount leak when fixing an

Neil Horman:
      [SCTP]: Allow spillover of receive buffer to avoid deadlock.

NeilBrown:
      md: Avoid oops when attempting to fix read errors on raid10
      md: Fixed refcounting/locking when attempting read error correction in raid10
      md: Change ENOTSUPP to EOPNOTSUPP
      md: Improve detection of lack of barrier support in raid1
      md: Fix 'rdev->nr_pending' count when retrying barrier requests

Nicolas Pitre:
      [ARM] 3494/1: asm-arm/bug.h needs linux/stddef.h
      [ARM] 3500/1: fix PXA27x DMA allocation priority
      [ARM] 3495/1: EABI: undefine removed syscalls, but...

Olaf Hering:
      mv643xx_eth: provide sysfs class device symlink

Olivier Blondeau:
      USB: storage: atmel unusual dev update

Paolo 'Blaisorblade' Giarrusso:
      uml: fix patch mismerge
      uml: use Kbuild tracking for all files and fix compilation output
      uml: fix compilation and execution with hardened GCC
      uml: cleanup unprofile expression and build infrastructure
      uml: export symbols added by GCC hardened

Paolo Ciarrocchi:
      Added URI of "linux kernel development process"

Pat Gefre:
      Altix: correct ioc3 port order

Patrick Caulfield:
      [DECNET]: Fix level1 router hello

Patrick McHardy:
      [NETFILTER] x_tables: fix compat related crash on non-x86
      [NETFILTER] SCTP conntrack: fix infinite loop
      [NETFILTER]: H.323 helper: fix endless loop caused by invalid TPKT len
      [NETFILTER]: H.323 helper: fix use of uninitialized data
      [NETFILTER]: NAT: silence unused variable warnings with CONFIG_XFRM=n
      [NETFILTER]: x_tables: don't use __copy_{from,to}_user on unchecked memory in compat layer
      [NET_SCHED]: HFSC: fix thinko in hfsc_adjust_levels()

Paul Mackerras:
      powerpc/pseries: Tell firmware our capabilities on new machines
      powerpc: Fix incorrect might_sleep in __get_user/__put_user on kernel addresses
      powerpc: Use the ibm,pa-features property if available
      powerpc/32: Define an is_kernel_addr() to fix ARCH=ppc compilation

Pavel Machek:
      [ARM] 3508/1: Update collie defconfig

Pavel Pisa:
      [ARM] 3485/1: i.MX: MX1 SD/MMC fix of unintentional double start possibility

Pavel Roskin:
      kbuild: removing .tmp_versions considered harmful

Peter Oberparleiter:
      s390: fix I/O termination race in cio

Phil Dibowitz:
      USB: Storage: unusual devs update

Ralf Baechle:
      [MIPS] Fix oprofile module unloading
      [MIPS] Oprofile: fix sparse warning.
      [MIPS] Kconfig: Clarify description of CROSSCOMPILE.
      [MIPS] Get rid of CONFIG_ADVANCED.
      [MIPS] Update MIPS defconfigs.
      [MIPS] Cleanup inode->r_dev usage.
      [MIPS] Fix branch emulation for floating-point exceptions.
      au1200fb: Remove accidentally duplicated content of au1200fb.c
      [ROSE]: Remove useless prototype for rose_remove_neigh().
      [AX.25]: Spelling fix
      [AX25, ROSE]: Remove useless SET_MODULE_OWNER calls.
      [AX.25]: Move AX.25 symbol exports
      [ROSE]: Fix routing table locking in rose_remove_neigh.
      [AX.25]: Eleminate HZ from AX.25 kernel interfaces
      [NETROM]: Eleminate HZ from NET/ROM kernel interfaces
      [ROSE]: Eleminate HZ from ROSE kernel interfaces
      [NETROM/ROSE]: Kill module init version kernel log messages.

Ralf Baechle DL5RB:
      [HAMRADIO]: Remove remaining SET_MODULE_OWNER calls from hamradio drivers.

Ralph Campbell:
      IB: Fix display of 4-bit port counters in sysfs

Randy Dunlap:
      kbuild modpost - relax driver data name
      [IRDA] irda-usb: use NULL instead of 0

Rene Herman:
      [ALSA] continue on IS_ERR from platform device registration

Richard Purdie:
      Input: spitzkbd - fix the reversed Address and Calender keys

Roland Dreier:
      [SCSI] srp.h: avoid padding of structs
      IB/mthca: Fix offset in query_gid method
      IB/srp: Fix tracking of pending requests during error handling
      IB/mthca: Fix race in reference counting
      IPoIB: Free child interfaces properly

Russ Anderson:
      [IA64] Remove unused variable in sn_sal.h
      [IA64-SGI] SN SAL call to inject memory errors
      [IA64] Add mca recovery failure messages

Russell King:
      [SERIAL] Clean up serial locking when obtaining a reference to a port
      [SERIAL] Remove unconditional enable of TX irq for console
      [SERIAL] 8250: add locking to console write function
      [MMC] extend data timeout for writes
      [MMC] PXA and i.MX: don't avoid sending stop command on error
      [MMC] PXA: reduce the number of lines PXAMCI debug uses
      [MMC] Correct mmc_request_done comments
      [MMC] Move set_ios debugging into mmc.c
      [BLOCK] Fix oops on removal of SD/MMC card
      [ARM] Allow SA1100 RTC alarm to be configured for wakeup
      [ARM] rtc-sa1100: fix compiler warnings and error cleanup
      [ARM] Update versatile_defconfig
      [ARM] Update mach-types
      [ARM] Fix thread struct allocator for SMP case

Sam Ravnborg:
      kbuild: fix gen_initramfs_list.sh
      kbuild: drivers/video/logo/ - fix ident glitch

Samuel Ortiz:
      [IRDA]: New maintainer.

Samuel Thibault:
      Input: allow using several chords for braille

Sascha Hauer:
      [ARM] 3490/1: i.MX: move uart resources to board files
      [ARM] 3501/1: i.MX: fix lowlevel debug macros

Satoru Takeuchi:
      [IA64] eliminate compile time warnings
      [IA64] eliminate compile time warnings

Sergei Shtylyov:
      [SERIAL] AMD Alchemy UART: claim memory range
      Fix RTL8019AS init for Toshiba RBTX49xx boards

Shaohua Li:
      timer TSC check suspend notifier change

Shaun Pereira:
      [X25]: fix for spinlock recurse and spinlock lockup with timer handler

shin, jacob:
      slab: fix crash on __drain_alien_cahce() during CPU Hotplug

Soyoung Park:
      [NETLINK]: cleanup unused macro in net/netlink/af_netlink.c

Sridhar Samudrala:
      [SCTP]: Fix panic's when receiving fragmented SCTP control chunks.
      [SCTP]: Fix state table entries for chunks received in CLOSED state.

Stefan Bader:
      s390: enable interrupts on error path
      s390: tape 3590 changes

Stefan Rompf:
      Input: wistron - add signature for Amilo M7400
      [NET]: Add missing operstates documentation.

Stefano Brivio:
      bcm43xx: check for valid MAC address in SPROM

Stephen Hemminger:
      [PKT_SCHED] netem: fix loss
      [BRIDGE]: keep track of received multicast packets
      [CLASS DEVICE]: add attribute_group creation
      [NET]: Create netdev attribute_groups with class_device_add
      sky2: backout NAPI reschedule
      sky2: status irq hang fix
      sky2: tx ring index mask fix
      sky2: use mask instead of modulo operation
      sky2: edge triggered workaround enhancement
      sky2: dont write status ring
      sky2: synchronize irq on remove
      Add more support for the Yukon Ultra chip found in dual core centino laptops.
      sky2: version 1.3
      [NET]: Do sysfs registration as part of register_netdevice.
      [BRIDGE]: Do sysfs registration inside rtnl.
      sky2: ifdown kills irq mask

Stephen Smalley:
      selinux: Clear selinux_enabled flag upon runtime disable.

Steve Grubb:
      sockaddr patch
      audit inode patch
      change lspp ipc auditing
      Reworked patch for labels on user space messages
      More user space subject labels
      Rework of IPC auditing
      Audit Filter Performance

Steven Finney:
      [ALSA] Handle the error correctly in SNDCTL_DSP_SETFMT ioctl

Takashi Iwai:
      [ALSA] hda-codec - Use model 'hp' for all HP laptops with AD1981HD
      [ALSA] hda-codec - Add entry for Epox EP-5LDA+ GLi
      [ALSA] Fix double free in error path of miro driver
      [ALSA] intel8x0 - Disable ALI5455 SPDIF-input
      [ALSA] hda-codec - Add model entry for ASUS M9 laptop
      [ALSA] hda-codec - Add codec id for AD1988B codec chip
      [ALSA] Fix Oops at rmmod with CONFIG_SND_VERBOSE_PROCFS=n
      [ALSA] hda-codec - Fix capture from line-in on VAIO SZ/FE laptops
      [ALSA] hda-codec - Add model entry for ASUS Z62F
      [ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips

Tony Luck:
      [IA64] wire up compat_sys_adjtimex()

Trond Myklebust:
      fs/locks.c: Fix lease_init

Uwe Zeisberger:
      [ARM] 3488/1: make icedcc_putc do the right thing
      [ARM] 3496/1: more constants for asm-offsets.h

Victor V. Vengerov:
      uml: fix iomem list traversal

Vitaly Bordug:
      ppc32: odd fixes and improvements in ppc_sys
      ppc32 CPM_UART: Convert to use platform devices
      ppc32: Update board-specific code of the CPM UART users
      ppc32 CPM_UART: Fixed odd address translations
      ppc32 CPM_UART: Fixed break send on SCC
      ppc32 CPM_UART: fixes and improvements

Vladislav Yasevich:
      [SCTP]: Prevent possible infinite recursion with multiple bundled DATA.

Wang Jun:
      USB: add new iTegno usb CDMA 1x card support for pl2303

Wei Yongjun:
      [IPV4]: ip_options_fragment() has no effect on fragmentation

YOSHIFUJI Hideaki:
      [IPV6]: Fix race in route selection.

Zach Brown:
      [SCSI] qla2xxx: only free_irq() after request_irq() succeeds

Zachary Amsden:
      x86/PAE: Fix pte_clear for the >4GB RAM case

