Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268148AbTAMShT>; Mon, 13 Jan 2003 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTAMShT>; Mon, 13 Jan 2003 13:37:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4103 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268148AbTAMShG>; Mon, 13 Jan 2003 13:37:06 -0500
Date: Mon, 13 Jan 2003 10:44:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.57
Message-ID: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, Alan worked on fixing the network packet padding thing (small changes
to a _lot_ of network drivers), and merged some more of his IDE work.  
And latency fixes and some VM updates from Andrew Morton.

Ppc, ppc64, ISDN and sparc updates. NFSd and sysfs updates.

And special mention for Brian Gerst, who figured out and fixed a x86 page
table initialization fix that would leave old machines unable to boot
2.5.x. That might explain a number of the "I can't run 2.5.x" that weren't
seen by developers (most developers tend to have hardware studly enough
that they'd never see the problem).

			Linus

Summary of changes from v2.5.56 to v2.5.57
============================================

Dale Farnsworth <dale.farnsworth@mvista.com>:
  o PPC32: Fix copy_from_user to copy as much as possible

Matt Porter <mporter@cox.net>:
  o PPC32: Use timing workaround for DS1743 RTC chip

<rol@as2917.net>:
  o [IPV4]: Allow route.c to build without procfs enabled

Rolan McGrath <roland@redhat.com>:
  o PTRACE_GET_THREAD_AREA

<rvinson@mvista.com>:
  o PPC32: Fix host bridge programming on Adirondack "K2" boards
  o PPC32: Explicitly control store-gathering on MPC10x host bridges

<sds@epoch.ncsc.mil>:
  o 2.5.52-lsm-{dummy,ipc}.patch
  o CREDITS patch

M.H.VanLeeuwen <vanl@megsinet.net>:
  o 2.5.56, isapnp_init level
  o 2.5.56, isapnp cards not found
  o 2.5.56, ne2k compiles and works

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 3c501 - fix end of small packet clearing
  o fix padding for 3c505
  o fix padding for 3c507
  o fix padding for 3c523
  o fix padding for 7990 lance
  o fix padding for 8139too
  o fix padding on 8390 based devices
  o fix padding on at1700
  o fix padding on atp
  o fix padding on de600
  o fix padding on de620
  o fix padding on ni5010
  o fix ethernet padding on ni52
  o fix ethernet padding on ni65
  o fix ethernet padding on axnet_cs
  o fix ethernet padding on sgiseeq
  o fix ethernet padding on sk_g16
  o fix ethernet padding on sun3lance
  o fix ips compile failure
  o add missing Nvidia PCI idents
  o add skb_pad/skb_padto functionality
  o padto - fix 3c527 using skb_padto
  o padto - fix 82596 using skb_padto
  o padto - fix a2065 using padto
  o padto -f ix am79c961 using padto
  o padto - fix ariadne using skb_padto
  o padto - fix atarilance using padto
  o padto - fix bagetlance using padto
  o padto - fix declance using skb_padto
  o padto - fix depca using skb_padto
  o padto - fix eepro using skb_padto
  o padto - fix epic100 using skb_padto
  o padto - fix eexpress using skb_padto
  o padto - fix fmv18xusing skb_padto
  o padto  fix eth16i using skb_padto
  o padto - fix hp100.c using skb_padto, fix warning
  o fix lance using skb_padto
  o fix lp486e using skb_padto
  o fix lasi_82596 using skb_padto
  o fix ray_cs using skb_padto
  o fix fmvj18x_cs using skb_padto
  o fix xirc2ps using skb_padto
  o fix seeq8005 using skb_padto
  o fix r8169 using skb_padto
  o fix smc9194 using skb_padto
  o fix sun3_82586 using skb_padto
  o fix wavelan.c using skb_padto
  o fix znet using skb_padto
  o fix yellowfin with skb_padto
  o fix typo in esp driver
  o turn off fdomain debug
  o fix typo in NCR53C9x
  o fix ixj typos
  o add SF16FRM2 ident as per 2.4
  o fix ali1541 typo
  o fix m68k typo
  o fix rpc-cache typo
  o fix rio typo
  o fix 64bit cleanness on adma100
  o fix 64bit cleanness on aec62xx
  o update the AMD IDE driver and teach it the Nvidia variant
  o fix 32/64bit cleanness on cyrix chipsets
  o fix 64bit cleanness on hpt34x chipset
  o fix 64bit cleanness on hpt366, report overclocking error
  o fix 64bit cleanness in promise ide
  o remove nvidia driver (obsoleted by amd driver)
  o fix 64bit cleanness in intel Piix driver
  o fix 64bit cleanness in pdca
  o fix 64bit cleanness in Natsemi SCx200 IDE
  o fix 64bit cleanness on slc90e66 IDE
  o fix 64bit cleanness on serverworks ide
  o fix pci ide cleanness problem, make printk clearer
  o remove dead config choices from AMD update
  o Add compaq triflex IDE from 2.4.21pre into 2.5
  o Update 2.5 PIIX driver to match 2.4 PIIX

Anders Gustafsson <andersg@0x63.nu>:
  o [TCP]: Dont tcp_listen_unlock unless it was locked

Andrew Morton <akpm@digeo.com>:
  o turn i_shared_lock into a semaphore
  o simplify and generalise cond_resched_lock
  o replace `typedef mmu_gather_t' with `struct mmu_gather'
  o Don't reverse the VMA list in touched_by_munmap()
  o low-latency pagetable teardown
  o Fix an SMP+preempt latency problem
  o misc fixes
  o fix set_page_dirty vs truncate&free races
  o inline 1,2 and 4-byte copy_*_user operations

Anton Blanchard <anton@samba.org>:
  o ppc64: remove flush_icache_page, based on same work in ppc32
  o ppc64: exception handler update
  o ppc64: add get/put_compat_timespec from Stephen Rothwell
  o ppc64: remove mmu_gather_t
  o ppc64: zero extend all 6 parameters in 32 bit syscall path
  o ppc64: compat_sys_[f]statfs, from Stephen Rothwell

Bart De Schuymer <bdschuym@pandora.be>:
  o [ebtables] use Rustys new module scheme in ebtables.c, vs 2.5.56

Brian Gerst <bgerst@didntduck.org>:
  o x86 page table initialization fix
  o Fix PnP BIOS fault handling

David S. Miller <davem@nuts.ninka.net>:
  o [SUNZILOG]: Fix spinlock access in previous changes
  o [COMPAT]: fs/compat.c needs linux/vfs.h for asm/statfs.h

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: new p4-m stepping 7
  o cpufreq: #defines update
  o cpufreq: frequency table helpers

Ingo Molnar <mingo@elte.hu>:
  o ptrace-fix-2.5.56-A0

Jaroslav Kysela <perex@suse.cz>:
  o Linux PnP Support 0.94
  o PnP update - drivers

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN/HiSax: Separate out some common code from B-Channel receive
  o ISDN/HiSax: Further simplify *_empty_fifo() for B-Channel
  o ISDN: Share RME/RPF B-channel IRQ handling
  o ISDN/HiSax: Move the now shared fields
  o ISDN/HiSax: Remove duplicated HSCX handling
  o ISDN/HiSax: Shared bc_open/close()
  o ISDN/HiSax: Move BC_SetStack/BC_Close
  o ISDN/HiSax: Share D-channel receive code
  o ISDN/HiSax: Introduce per-card init function
  o ISDN/HiSax: Move interrupt function to per-card struct
  o ISDN/HiSax: Introduce methods for reset/test/release/
  o ISDN/HiSax: Move open/close of D-channel stack -> dc_l1_ops
  o ISDN/HiSax: Share some common D-channel init code
  o ISDN/HiSax: Share interrupt handler for ISAC/HSCX cards
  o ISDN/HiSax: Clean up the various IPAC IRQ handlers
  o ISDN/HiSax: Generate D/B channel access functions for IPAC
  o ISDN/HiSax: Share IPAC IRQ handler
  o ISDN/HiSax: Clean up the gazel subdriver
  o ISDN/HiSax: Add missing __devexit_p()
  o ISDN: isdn-tty driver not HZ aware
  o ISDN: remove kernel 2.0 code
  o ISDN/HiSax: Simplified request_region() etc
  o ISDN/HiSax: Convert remaining ioremap() to request_mmio()
  o ISDN/HiSax: Remove superfluous #ifdef CONFIG_PCI
  o ISDN/HiSax: Remove empty ->cardmsg
  o ISDN/HiSax: Unify LED handling
  o ISDN/HiSax: Remove superfluous card type checks
  o ISDN/HiSax: Move chipset init code into *_setup() functions
  o ISDN/HiSax: Fix some of the new PnP stuff

Linus Torvalds <torvalds@home.transmeta.com>:
  o Re-instate the SA_RESTORER functionality, since it seems that some
    programs still depend on it and in fact do install a different
    signal restorer than the standard kernel version.
  o Make MOD_[INC|DEC]_USE_COUNT a true no-op for built-in modules
  o Modern gcc's don't like labels without a statement
  o Fix typo in the network driver pad fixes for a2065 driver
  o Always assign bus numbers for cardbus. Firmware often doesn't do it
    right
  o Get rid of endless loop in PnP-enabled ne.c

Miles Bader <miles@lsi.nec.co.jp>:
  o Include <asm/posix_types.h> in the v850's asm/stat.h
  o Define `read_barrier_depends' on v850
  o Small update to arch/v850/README
  o Update v850 module support for 2.5.55
  o Add __gpl_ksymtab section to v850 linker script
  o Add support for ROM kernel on v850 AS85EP1 target

Neil Brown <neilb@cse.unsw.edu.au>:
  o Reorganise sock init in rpcsvc to avoid races
  o Tidy up closing of RPC server tcp connections to avoid races
  o Some tidyup of svc_authenticate
  o Fix nfsd checking for read-only filesystem
  o Avoid hang when multiple raids on shared drives are trying to sync
  o UMEM: disable irq when calling plugging functions
  o Change hash_mem to an inline function

Patrick Mochel <mochel@osdl.org>:
  o Add documentation for porting bus drivers to new driver model
  o sysfs: hardcode file size of regular files to PAGE_SIZE
  o network devices: move kobject registration earilier to better
    handle error
  o network devices: make sure kobjects always get unregistered
  o sysfs: Improve read/write buffer filling/flushing semantics
  o sysfs: remove count and off parameters from sysfs_ops methods
  o sysfs: fix up block and partition sysfs callbacks
  o sysfs: fixup bus, class, and driver attribute methods
  o sysfs: fix up device attribute read/write methods
  o sysfs: fixup PCI sysfs files
  o sysfs: fix up SCSI sysfs files
  o sysfs: fixup USB sysfs files
  o sysfs: fixup PCI pool sysfs file
  o sysfs: Fix up SCSI sg sysfs files
  o sysfs: Fix up PNP sysfs files
  o sysfs: Fix up EDD sysfs files
  o sysfs: fixup subsystem attributes
  o kobject.c fix compile when DEBUG is defined
  o PCI: make PCI_LEGACY_PROC depend on PCI
  o driver model: add some more error checking
  o driver model: make sure all debugging defaults to off
  o driver model: remove extra error check during driver binding
  o kobject: make sure we remove kobject from list if kobject_add()
    failes
  o sysfs: make sure we drop all the references on dentrys we acquire
  o sysfs: return correct error when opening RO file for writing
  o driver model: fix typo in drivers/base/sys.c
  o driver model docs: convert driverfs references to sysfs references
  o sysfs: update documentation

Paul Mackerras <paulus@samba.org>:
  o PPC32: Change struct free_pte_ctx to struct mmu_gather

Pete Zaitcev <zaitcev@redhat.com>:
  o [SUNZILOG]: Get serial console et al. working once more

Robert Love <rml@tech9.net>:
  o add explicit Pentium II support
  o P4-based Celeron comments

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Remove CPU manufacturer string
  o [ARM] Update sa1100fb to new fbcon API and device model
  o [ARM] Fix consistent_alloc()
  o [ARM] __put_user, __get_user cleanups and fixups
  o [ARM] CPUFREQ updates from Dominik
  o [ARM] Add __gpl_ksymtab section to linker script
  o [ARM] Invalidate TLB before and after setting up page tables
  o [ARM] Update ARM documentation
  o [ARM] Update DMA usage in Acorn SCSI drivers
  o [ARM] Ensure that dev->dma_mask is initialised for Acorn cards
  o [ARM] Add support for the StrongARM-11x0 watchdog
  o [ARM] Update extable.c for 2.5.55 exception table / module changes
  o [ARM] Make CONFIG_SERIO_RPCKBD default to y for Acorn platforms
  o [ARM] Remove set_irq_type, sa1111 driver names are lower case
  o [ARM] Fix Jornada720 sa1100-flash.c support, update to C99
    initialisers
  o [ARm] Fix ARM exception table fixups for 2.5.55 updates
  o [ARM] Bring sa1100_ir.c up to date wrt new DMA and device
    subsystems

Rusty Russell <rusty@rustcorp.com.au>:
  o Place __gpl_ksymtab section in all linker scripts
  o Remove dup __gpl_ksymtab in arm file
  o Fix strlen_user usage in module.c
  o v850 obsolete params fix

Stephen Rothwell <sfr@canb.auug.org.au>:
  o compat_sys_[f]statfs - generic part
  o compat_sys_[f]statfs - s390x part
  o [COMPAT] compat_sys_[f]statfs - sparc64 part

Zwane Mwaikambo <zwane@holomorphy.com>:
  o fix compile warning in mm/slab.c __slab_error
  o setup default dma_mask for cardbus devices


