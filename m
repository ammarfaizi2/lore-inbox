Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbTGFAud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbTGFAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:50:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49578 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266582AbTGFAuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:50:02 -0400
Date: Sat, 5 Jul 2003 22:02:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre3
Message-ID: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre3. It contains a lot of updates and fixes all over.

We should have increased interactivity under heavy IO (users with
interactivity problems please test and report results).

Well, detailed changelog here.


Summary of changes from v2.4.22-pre2 to v2.4.22-pre3
============================================

<abbotti@mev.co.uk>:
  o USB: several ftdi_sio driver patches

<alex_williamson@hp.com[helgaas]>:
  o ia64: Poll for CPEs on all CPUs, improve check for # of CPEs logged
  o ia64: Switch to polling for CMCs if they happen too fast
  o ia64: add wmb in sba_iommu to guarantee IOPDIR updates are visible
  o ia64: fix timer interrupts getting lost

<arun.sharma@intel.com[helgaas]>:
  o ia64: fix IA-32 emulation of msgctl()
  o ia64: define rlim_cur/rlim_max as unsigned
  o ia64: fix IA-32 version of shmctl()
  o ia64: ia32 semctl check for bad command
  o ia64: Patch by Arun Sharma: In the absence of the patch, this system call fails:
  o ia64: Fix SMP FPH handling.  From 2.5 patch by Asit Mallick, David Mosberger, Arun Sharma.
  o ia64: work around race conditions in ia32 support code
  o ia64: IA-32 support patch: msgsnd/msgrcv return value off by 4
  o ia64: IA-32 support patch: munmap should return EINVAL if size == 0
  o ia64: IA-32 support patch: mmap should return ENOMEM

<baldrick@wanadoo.fr>:
  o USB speedtouch: use common CRC library

<bdschuym@pandora.be>:
  o [NETFILTER]: Missing return in arp_packet_match()
  o [NETFILTER]: Add arptables mangle module

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Export pm_idle
  o ia64: sys32_sysinfo: update to current struct sysinfo (add totalhigh, freehigh, mem_unit).
  o ia64: Make struct sysinfo32 internal padding explicit
  o ia64: Make CONFIG_SYSCTL control sys32_sysctl as well.  Based on a patch from Peter Chubb.
  o ia64: ia64_fetch_and_add(), xchg(), ia64_cmpxchg(), etc
  o ia64: Update default configs
  o ia64: iosapic: remove find_iosapic duplication
  o ia64: iosapic: simplify ISA IRQ init
  o ia64: iosapic: self-documenting polarity/trigger arguments
  o ia64: iosapic: Remove gratuitous differences with 2.5 (whitespace, C99 initializers, printk levels, etc).
  o ia64: Use printk severity-levels where appropriate
  o ia64: cleanup unwind.c warnings (from David's 2.5 change)
  o ia64: mca.c whitespace changes and dead code removal from 2.5
  o ia64: sba_iommu: whitespace and comment changes to align with 2.5
  o ia64: sba_iommu: prefetch_spill_page alignment with 2.5
  o ia64: sba_iommu: printk text and other trivial changes to align with 2.5
  o io4
  o ia64: sba_iommu: make sure devices are at least 32-bit capable (from 2.5)
  o ia64: sba_iommu: Combine HWP0001 and HWP0004 ACPI claim (from 2.5 changes by Alex Williamson).
  o ia64: sba_iommu: remove workarounds for broken, never released, firmware that didn't program IBASE/IMASK correctly.
  o ia64: remove cpu_is_online local defs, in favor of a 2.5-style cpu_online
  o ia64: Remove unused variable from acpi.c
  o ia64: sba_iommu: fix warning and use old-style ACPI typedef
  o ia64: whitespace and trivial changes in mca.c
  o ia64: palinfo whitespace changes to match 2.5
  o ia64: simplify syscalls with force_successful_syscall_return()
  o ia64: Remove unused acpi_get_addr_space() interface
  o ia64: Wrap pal.h with #ifdef __KERNEL__ to solve userland compilation issues (including <linux/modules.h>).
  o ia64: Don't blindly probe PCI buses (probe only those reported by ACPI)
  o ia64: pci warning for unavailable resources
  o ia64: TLB flushing fixes - don't use smp_call_function in context-switch path.
  o ia64: Disable interrupts during context switch
  o ia64: ptrace whitespace changes to follow 2.5
  o ia64: add hugetlb and cmd649 IDE to configs
  o ia64: Export SAL error records in /proc/sal/{mca,init,cmc,cpe}/{event,data}
  o ia64: Rename EFI systab tags (no spaces, etc, for easier parsing)
  o ia64: Ignore empty address ranges from _CRS to workaround buggy Big Sur firmware.

<chad_smith@hp.com[helgaas]>:
  o ia64: expose pointers from EFI system table in /proc

<chas@cmd.nrl.navy.mil>:
  o [ATM]: remove iovcnt member in struct atm_skb

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Backport HE driver fixes from 2.5.x
  o [ATM]: ixmicro puts esi in different location
  o [ATM]: lock neighbor entry during update in clip.c
  o [ATM]: make sub skb->cb is clear before upcall to network
  o [ATM]: eliminate ATM_PDU_OVHD, ops->free_rx_skb and ops->alloc_tx
  o [ATM]: make clip buildable as a module

<dave@thedillows.org>:
  o Use a non-zero rx_copybreak to avoid charging a full MTU to the socket on tiny packets.
  o Fix misreporting of card type and spurious "already scheduled" messages

<david@csse.uwa.edu.au>:
  o USB: usb-uhci fix for one-shot interrupt problem
  o USB: usb-ohci handling of one-shot interrupt transfers

<davidm@hpl.hp.com[helgaas]>:
  o ia64: For SIGSEGV triggered by NaT page, set si_addr to faulting data address, not the faulting IP.

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: Make ia64_fetch_and_add() simpler to optimize so lib/rwsem.c can be optimized properly.
  o ia64: Implement pcibios_set_mwi() and define HAVE_ARCH_PCI_MWI to ensure that PCI line-size gets programmed properly.  Based
  o ia64; Improve debug output from kernel unwinder.  Based on patch by Keith Owens.  (Ported to 2.4 by Bjorn Helgaas).
  o ia64: In kernel unwinder, replace dump_info_pt() with get_scratch_regs() and reformat to make it fit in 100 columns.
  o ia64: Add unwcheck.sh script contributed by Harish Patil.  It checks the unwind info for consistency (well, just the obvious stuff, but it's a start).
  o ia64: Minor cleanups.  (From 2.5 by Bjorn Helgaas)
  o ia64: Make signal deliver work when the current register frame is incomplete (as a result of a faulting mandatory RSE load).
  o ia64: Correct region_start calculation in kernel unwinder
  o ia64: clean up unneeded test in kernel unwinder
  o ia64: More vmlinux.lds.S cleanups (__start/__end inside sections)
  o ia64: Minor fixes
  o ia64: Two small MCA fixes
  o ia64: Sync itc after interrupts enabled
  o ia64: Sync sys32_ipc() with x86 counter-part
  o ia64: Patch by Arun Sharma: In brl_emu.c, a 64 bit value was being assigned to an int.
  o ia64: Minor whitespace & formatting fixups in asm-ia64/sal.h
  o ia64: Fix SAL processor-log info handling.  Based on patch by Keith Owens.
  o ia64: Manual merge of Keith Owen's patch to avoid deadlock on ia64_sal_mc_rendez().  Also prefix local-variables in SAL macros to avoid name collisions.
  o ia64: dump the min-state area in the MCA INIT platform handler
  o ia64: Update platform INIT handler to print a backtrace
  o ia64: Consolidate backtrace printing in a single routine (ia64_do_show_stack())
  o ia64: fix /proc/.../vm_info memory attributes
  o ia64: Fix printing of memory attributes
  o mca.c
  o ia64: Fix INIT copying of banked registers
  o ia64: ptrace: don't let reading NaT bits for R4-R7 overwrite the value we're intending to write; get_rnat & put_rnat cleanups.
  o ia64: Fix ptrace() RNaT accessors
  o ia64: Fix page-fault handler so it handles not-present translations for region 5 (patch by John Marvin).
  o ia64: Fix unwinder so core-dumps work again.  Without this patch, most scratch-regs came out wrong.
  o ia64: Fixups for GCC v3.3

<davidm@wailua.hpl.hp.com[helgaas]>:
  o ia64: Change struct ia64_fpreg so it will get 16-byte alignment with all ia64 compilers, not just GCC.
  o ia64: Don't output backspaces in palinfo output

<eranian@hpl.hp.com[helgaas]>:
  o ia64: perfmon update to v1.4
  o ia64: perfmon fixes for system-wide monitoring overflow, opcode matcher, and force PMC[89] bit 2 on.
  o ia64: perfmon update
  o ia64: perfmon TLB_* and ALAT event fix

<garyhade@us.ibm.com[helgaas]>:
  o ia64: fix sysinfo(2) memory value truncation for 32-bit apps

<grigouze@noos.fr>:
  o USB: zaurus SL-C700

<james@cobaltmountain.com[helgaas]>:
  o include_asm-ia64_sal.h, typo: the the

<jbarnes@sgi.com[helgaas]>:
  o ia64: ACPI fix for no PCI

<jes@wildopensource.com[helgaas]>:
  o ia64: don't try to synchronize ITCs on ITC_DRIFT platforms

<jgarzik@pobox.com>:
  o fix Via pci irq routing

<jh@sgi.com[helgaas]>:
  o ia64: SGI SN update
  o ia64: SN2 update 030528
  o ia64: SN2 update 030630

<jsm@udlkern.fc.hp.com[helgaas]>:
  o ia64: don't let PTRACE_POKEDATA write the NaT bits of syscall args

<judd@jpilot.org>:
  o USB: visor.h[c] USB device IDs

<kaos@ocs.com.au[helgaas]>:
  o ia64: fix unwinder to call get_scratch_regs() only when really needed

<kaos@sgi.com[helgaas]>:
  o ia64: fix scratch-regs handling in kernel unwinder
  o ia64: unwind.c - allow unw_access_gr(r0)
  o ia64: Trivial stack-size correction in mca.c
  o ia64: mca rendezvous fix
  o ia64: Hold modlist_lock while searching exception tables
  o ia64: Handle SAL rejection of MCA rendezvous timeout value

<kenneth.w.chen@intel.com[helgaas]>:
  o ia64: rwsem using atomic primitive

<kpc-usbdev@gelato.uiuc.edu>:
  o USB: Desknote/ECS UCR-61S2B card reader (2.4.21 patched)

<lethal@linux-sh.org>:
  o SH64 Merge
  o Add SH-5 support to SH-SCI
  o Add SH-5 support to tulip_core
  o Update MAINTAINERS for sh/sh64
  o SH-5 DMAC Support
  o sh64 PCI DMA coherency fixups
  o sh64: Fix SHMBLA compile error
  o sh64: Add an onchip_unmap() to clean up after
  o sh64: tlbmiss handler updates
  o sh64: Don't startup the irq in make_intc_irq()
  o sh64: Add workarounds for cache aliasing issues
  o sh64: Cleanup sleep usage
  o sh64: Fix PTRACE_POKEUSR to ignore changes of privileged
  o sh64: Make memcpy safe on SH5-101 cut2
  o sh64: export more needed symbols
  o sh64: Fixes for Cayman LEDs

<mk@linux-ipv6.org>:
  o [CRYPTO]: Update deflate dependencies

<mkp@mkp.net[helgaas]>:
  o ia64: declare ia64_sal_handler_init non-static

<mort@wildopensource.com[helgaas]>:
  o ia64: print ISR for FPSWA faults
  o ia64: runtime platform detection for 2.5

<richard.curnow@superh.com>:
  o Ensure that the 'unlink' XDR structures are correctly aligned on 64-bit architectures.

<romieu@fr.zoreil.com>:
  o [NETFILTER]: Fix leaks in error paths of ip_recent_ctrl

<rusty@rustcorp.com.au[helgaas]>:
  o Designated initializers for ia64

<schwab@suse.de[helgaas]>:
  o ia64: fix unwinder bug in unw_access_gr()
  o ia64: Fix request_module from ia32 process
  o ia64: make sys32_ptrace() use ptrace_check_attach()

<shemminger@osdl.org>:
  o [BRIDGE]: Ethernet bridge fixes

<shmulik.hen@intel.com>:
  o Fix load balance problem with high UDP Tx stress
  o Fix 802.3ad long fail over with high UDP Tx stress
  o [netdrvr bonding] Fix change active for ALB/TLB

<sv@sw.com.sg[helgaas]>:
  o ia64: improve show_trace_task() portability

<venkatesh.pallipadi@intel.com[helgaas]>:
  o ia64: IA-32 emulation patch: ptrace get_FPREGS bug fix

<will@sowerbutts.com>:
  o USB: Update for the powermate driver to work with newer devices

Adam J. Richter <adam@yggdrasil.com>:
  o [CRYPTO]: Simplify crypto memory allocation

Adrian Bunk <bunk@fs.tum.de>:
  o postfix a constant in efi.h with ULL

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o [NETFILTER]: Fix nat_helper warnings with gcc 3.3
  o [NET]: Add EDP2 ethernet protocol ID
  o [SPARC]: d_path() can return an error code, must handle it
  o Optimise FAT handling using the prev_free info as DOS does
  o PATH: add hfsplus file system (stands alone)
  o NLS config.in for hfsplus
  o config.in for HFSPLUS
  o makefile for HFSPLUS
  o fix leak in llc 802
  o fix decnet gcc 3.3 build
  o add xapic checking define
  o add the extra cpu bit test flags
  o remove io_apic_modify - this doesnt work on some APICs
  o add the MSR's for IA32 perf ctl
  o fix false sharing of mm info
  o we moved these so this copy can go
  o collated copy of Geerts patches for m68k headers
  o add a flag so we can forbid APM idling
  o add the ide_register_driver defines
  o add EDP2 protocol id
  o update fat docs - we now use the field
  o bring PCI_IDS back into sync
  o add new entry to sisfb types
  o support cramfs initrd
  o add timedop stub for IPC=n
  o assorted module race fixe
  o dont corrupt utsname on failed copy
  o fix make rpm
  o dont idle if forbid_idle set
  o large scale DMI table updates
  o merge long standing reboot fix form -ac
  o fix up semops and return, allow timedop
  o fix error in vm86 fixups
  o add semtimedop to ia64 emu too
  o fix up gcc 3.3 bits
  o copy the right data in mips emulation
  o collected m68k core diffs
  o typo fix
  o fix iphase leak
  o bump cciss to new vendor driver
  o Jens floppy locking fixes
  o add comtrol note in case we need to know in the future
  o & v && fixes in sysrq.c
  o update sonypi driver
  o parisc gsc driver sync
  o fix config.in bits for IDE
  o make IDE modularisable
  o fix ide dma timeout bugs
  o make pnpide module happy
  o Herbert's fix for ide proc oops
  o make pdc4030 module happy
  o add generic support for toshiba piccolo
  o fix hpt speed bits
  o fix promise sx6000 newer board problems
  o clean up older pdc
  o siimage updates, add aar-1210sa
  o SiS IDE updates
  o hptraid updates
  o small setup-pci cleanups
  o d_path can return an error code, must handle it
  o update motion eye drivers
  o fix leak in octagon
  o new 3c59x. plus handle power bits
  o typo fix in atari_pamsnet driver
  o fix ma600 gcc 3.3
  o minor m68k fixes
  o fix leak in aironet4500_cs
  o fix plip hang on ifdown/ifup
  o update sonic
  o update orinoco drivers
  o update pci.ids
  o add cirrus support to i82092
  o fix rsrc manager
  o pci routing for ti cardbus
  o update aacraid
  o aic7xxx allow db4
  o gdth register failure path
  o update scsi tape docs
  o megaraid broke config tools
  o send_diag wants long timeout default
  o let the ide layer fail commands
  o resync scsi blacklist
  o new segate bios string
  o update scsi tape driver
  o remove noise
  o fix copy from user bug in cmpci
  o update AC97 codec core
  o switch cards to new ac97_audio
  o switch i810 to generalised digital out, new ac97
  o ac97 updates
  o fix long standing doc typo
  o update trident, fix printks, new ac97
  o Update via audio - fix problems esd, mpg321
  o update to new ac97_codec
  o core fbcon fixes
  o update vesafb memory handling for big cards
  o update sis fb drivers
  o add semtimedop to x86 headers
  o update ac97 codec headers
  o declare semtimedop function
  o add scripts ready to merge kconfig
  o update cciss docs to match new driver
  o add vram to vesafb docs
  o CMD640 update
  o (new) Turn on the IDE modular stuff in the Makefile
  o (resend) collected semaphore fixes and semtimedop
  o make i810 audio compile

Alex Williamson <alex_williamson@hp.com>:
  o ia64: CMC deadlock fix

Andi Kleen <ak@muc.de>:
  o Personality fixes for x86-64
  o x86-64 merge
  o Support exception-trace sysctl for x86-64
  o non executable stack support for x86-64

Andrew Morton <akpm@digeo.com>:
  o [CRYPTO]: Fix memcpy/memset args

Ben Collins <bcollins@debian.org>:
  o Update IEEE1394 (r972)

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o ppc32: support for 750FX rev2 CPU
  o ppc32: Enable use of USB2 on recent G4s
  o ppc32: Update PowerMac motherboard support
  o ppc32: Update swim3 floppy driver
  o ppc32: Add TotalImpact briQ panel driver
  o ppc32: Add a "query" function to core ADB
  o ppc32: Update adbhid driver
  o ppc32: Update battery calculation code & via-pmu
  o ppc32: Minimal ethtool for bmac and mace
  o ppc32: Fix a problem with both gmac and sungem

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: chmod +x unwcheck.sh script
  o ia64: iosapic: make pcat_compat system property
  o ia64: iosapic: rationalize __init/__devinit
  o ia64: Export io_space so drivers using legacy I/O ports can insmod
  o ia64: brl_emu.c: use temporary variable to avoid gcc3.1 warning
  o ia64: remove incorrect and redundant "cpu not responding" message
  o ia64: Update configs
  o ia64: pci.c: Trivial changes to follow 2.5
  o ia64: sba_iommu: use seq_file
  o ia64: acpi: handle vendor resources more generically
  o Move UP cpu_online definition to <linux/smp.h>
  o Cset exclude: rohit.seth@intel.com[helgaas]|ChangeSet|20030623203306|58862

Chris Mason <mason@suse.com>:
  o Fix potential IO hangs and increase interactiveness during heavy IO

Christoph Hellwig <hch@lst.de>:
  o [CRYPTO-2.4]: Missing ULL postfixes and statics

David S. Miller <davem@nuts.ninka.net>:
  o [BK]: Add *~ to ignore regexps
  o [CRYPTO]: kunmap does not return a value
  o [CRYPTO]: Build/warning fixups
  o [CRYPTO]: Clean up header file usage
  o [CRYPTO]: Include kernel.h in crypto.h
  o [CRYPTO]: Allocate work buffers instead of using kstack
  o [CRYPTO]: Make sha256.c more palatable to GCCs optimizers
  o [CRYPTO]: internal.h needs init.h
  o [CRYPTO]: Use appropriate defaults if AH/ESP is enabled
  o [CRYPTO-2.4]: Add dummy kmap_types.h header for sparc64
  o [CRYPTO]: Include linux/errno.h as appropriate
  o [CRYPTO-2.4]: module_name does not exist in 2.4.x
  o [CRYPTO-2.4]: const static --> static const
  o [CRYPTO]: deflate.c needs slab.h
  o [CRYPTO-2.4]: Fix condition typos in crypto/Config.in
  o [CRYPTO-2.4]: Emulate module_name semantics correctly to avoid OOPS
  o [CRYPTO-2.4]: Make sure crypto config is before lib config on ia64
  o [NET]: net/bluetooth/cmtp/core.c needs linux/init.h
  o [NET]: Scale DST/ipv6 intervals like we did for ipv4
  o [SPARC64]: Fix build error from OBP parsing patch
  o [SPARC64]: Update defconfig

Erik Andersen <andersen@codepoet.org>:
  o fix 2.4.22-pre broken x86 math-emu

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: remove stupid conversions and use of floating point from aiptek.c
  o USB: 2.4 fix UHCI debug kmalloc() usage
  o USB: add support for 50 baud to io_edgeport.c
  o USB: pl2303: report CTS and DSR status changes to userspace
  o Cset exclude: cweidema@indiana.edu|ChangeSet|20030620002017|05386
  o USB: compiler fixes for previous vicam patches

Hugh Dickins <hugh@veritas.com>:
  o remove shmem info->sem
  o shmem_getpage absorb _locked
  o shmem_getpage read,cache,write
  o shmem truncation swizzled
  o shmem account metablocks
  o shmem_file_write and _read
  o init_tmpfs shm_mnt error
  o shmem whitespace only
  o shmem misc minor mods
  o swapoff loopable tmpfs
  o shmem mount percentile size
  o shmem_removepage replace recalc_inode
  o loop file use highmem
  o madvise_willneed check readpage
  o shmem_file_write precheck_file_write
  o mremap VM_LOCKED move_vma
  o shmem loopable tmpfs [again]

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: fix generic kernel build (Jay Estabrook)
  o alpha: finalize Sable/Lynx support (Jay Estabrook)

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Add initial crypto api subsystem
  o [CRYPTO]: Cleanups based upon feedback from Rusty and jgarzik
  o [CRYPTO]: Cleanups based upon feedback from Rusty and jgarzik
  o [CRYPTO]: Use try_inc_mod_count and semaphore for alg list
  o [CRYPTO]: Use kmod to try to autoload modules
  o [CRYPTO]: Bug fixes and cleanups
  o [CRYPTO]: More bug fixes and cleanups
  o [CRYPTO]: Add MD4
  o [CRYPTO]: Algorithm lookup API change plus bug fixes
  o [CRYPTO]: Run tcrypt through lindent, plus doc update
  o [CRYPTO]: Assert that interfaces are called on correct cipher type
  o [CRYPTO]: Cleanups and more consistency checks
  o [CRYPTO]: Update to IV get/set interface
  o [CRYPTO]: Add some documentation
  o [CRYPTO]: Fix some credits
  o [CRYPTO]: Cleanups based upon suggestions by Jeff Garzik
  o [CRYPTO]: Uninline some functions to save some bloat
  o [CRYPTO]: Cleanups based upon feedback from jgarzik
  o [CRYPTO]: Add crypto_alg_available interface
  o [CRYPTO]: Rework HMAC interface
  o [CRYPTO]: Add SHA256 plus bug fixes
  o [CRYPTO]: Add blowfish algorithm
  o [CRYPTO]: minor updates
  o [CRYPTO] kstack cleanup (v0.28)
  o [CRYPTO] Add maintainers entry
  o [CRYPTO] Minor doc update
  o [CRYPTO]: Add null algorithms and minor cleanups
  o [CRYPTO]: Kill stray CRYPTO_ALG_TYPE_COMP
  o [CRYPTO]: Add twofish algorithm
  o [CRYPTO]: Add serpent algorithm
  o [CRYPTO]: Documentation update
  o [CRYPTO]: Dont compile procfs stuff if procfs is not enabled
  o [CRYPTO]: Add AES algorithm
  o [CRYPTO]: More credits for AES
  o [CRYPTO]: Add support for SHA-386 and SHA-512
  o [CRYPTO] remove superfluous goto from des module init exception path
  o [CRYPTO] Add AES and MD4 to tcrypto crypto_alg_available() test
  o [CRYPTO]: in/out scatterlist support for ciphers
  o [CRYPTO]: Move km_types out of header
  o [CRYPTO]: Add encrypt_iv() and decrypt_iv() methods
  o [CRYPTO]: Eliminate crypto_tfm.crt_ctx, from Adam Richter
  o [CRYPTO]: Documentation updates
  o [CRYPTO]: Make use of crypto_exit_ops() during crypto_free_tfm()
  o [CRYPTO]: Add Deflate algorithm to crypto API
  o [CRYPTO]: deflate module: workaround zlib bug
  o [CRYPTO]: Fix config dependencies

Jeff Garzik <jgarzik@redhat.com>:
  o [CRYPTO]: Kill accidental double memset
  o [netdrvr 8139too] fix debug printk

Linus Torvalds <torvalds@transmeta.com>:
  o The crypto auto-load should be enabled if crypto is enabled

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030625201246|52045
  o Added missing BROKEN_PNP_BIOS declaration
  o Changed EXTRAVERSION to -pre3

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 base update
  o s390 common i/o layer fixes
  o s390 dasd driver update
  o s390 31 bit compat
  o s390 documentation update
  o Add Configure.help entries for s390 options
  o s390 3215 driver update
  o s390 ctc network driver update
  o s390 iucv network driver
  o s390 defconfigs update
  o console semaphore fix

Matt Domsch <matt_domsch@dell.com>:
  o ia64: efivars fix by Matt Domsch and Peter Chubb

Olaf Hering <olh@suse.de>:
  o missing asm-ppc64/kmap_types.h

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Relocated journal support by Edward Shushkin & Vladimir Saveliev
  o reiserfs: speed up large file holes creation
  o reiserfs: Make most of the reiserfs warning messages to print what device they relate to

Oliver Neukum <oliver@neukum.org>:
  o USB: disconnect of v4l devices in 2.4
  o USB: fix to previous vicam patch

Peter Chubb <peter@chubb.wattle.id.au>:
  o ia64: declare test_bit() arg as "const"

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr via-rhine] via-rhine 1.18-rc1: Fix Rhine-I regression

Russell King <rmk@arm.linux.org.uk>:
  o ARM merge part 1 - arch/arm
  o ARM merge part 2 - include/asm-arm
  o ARM merge part 3 - drivers/acorn

Rusty Russell <rusty@rustcorp.com.au>:
  o 2.5.43 export _end

Scott Feldman <scott.feldman@intel.com>:
  o Remove CAP_NET_ADMIN check for SIOCETHTOOL's

Tom Callaway <tcallawa@redhat.com>:
  o [SPARC64]: Fix OBP version parsing on newer systems

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o A patch by Chuck Lever that cleans up the RPC socket slot allocation code.
  o A patch by Chuck Lever with further cleanups of the RPC socket slot allocation code.
  o Another patch by Chuck Lever that ensures that the PG_uptodate bit gets set when the entire page gets written by nfs_writepage_sync()
  o A patch by Patrice Dumas to implement nlmsvc_proc_granted_res
  o A patch by Patrice Dumas to add a check in order to ensure that we really were requesting a blocking lock when we get a reply from the server asking us to block.
  o A patch to ensures that blocks which are not going to time out are placed last on the nlm_block list (problem reported by Olaf Kirch).
  o Add standard spinlocks to protect the socket from being released by one CPU while the other is in a soft interrupt.
  o Fix a race: Ensure that requests retry if the remote server disconnects us while we're inside xprt_transmit().
  o Don't use an RPC child process when reconnecting to a TCP server
  o Ensure that if we need to reconnect the socket, we also resend the entire message.
  o Fix a TCP client corruption problem affecting resent requests
  o Ensure that the lockd clients always use one of the reserved ports
  o Replace buggy version of xdr_shift_buf() with the version from 2.5.x

