Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTGJVAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269601AbTGJVAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:00:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269583AbTGJU7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:59:36 -0400
Date: Thu, 10 Jul 2003 14:14:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.75
Message-ID: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok. This is it. We (Andrew and me) are going to start a "pre-2.6" series,
where getting patches in is going to be a lot harder. This is the last
2.5.x kernel, so take note.

The probably most notable thing here is the anticipatory scheduler,
which has been in -mm for a long time, and was the major piece that
hadn't been merged. 

Some architecture updates: cris has been updated for 2.5, ia64 and arm26 
updates etc.  And various random (smallish) things.

		Linus

-----

Summary of changes from v2.5.74 to v2.5.75
============================================

Adam Belay:
  o [PNP] Handle Disabled Resources Properly
  o [PNP] Allow resource auto config to assign disabled resources
  o [PNP] Fix manual resource setting API

Alex Williamson:
  o ia64: turn off ALLOW_IOV_BYPASS

Alexey Kuznetsov:
  o [TCP]: Delete obsolete comment

Andrew Morton:
  o move_vma() make_pages_present() fix
  o page unmapping debug
  o NUMA memory reporting fix
  o ramfs: use rgeneric_file_llseek
  o inode_change_ok(): remove lock_kernel()
  o nommu vmtruncate: remove lock_kernel()
  o procfs: remove some unneeded lock_kernel()s
  o remove lock_kernel() from file_ops.flush()
  o block_llseek(): remove lock_kernel()
  o Make CONFIG_TC35815 depend on CONFIG_TOSHIBA_JMR3927
  o Report detached thread exit to the debugger
  o timer renaming and cleanups
  o fix lost_tick detector for speedstep
  o fix lost-tick compensation corner-case
  o cleanup and generalise lowmem_page_address
  o Security hook for vm_enough_memory
  o ext2: inode allocation race fix
  o fix double mmdrop() on exec path
  o ext3: fix journal_release_buffer() race
  o Set limits on CONFIG_LOG_BUF_SHIFT
  o Fix cciss hang
  o e100 use-after-free fix
  o PCI domain scanning fix
  o ipc semaphore optimization
  o bring back the batch_requests function
  o Create `kblockd' workqueue
  o elv_may_queue() API function
  o elevator completion API
  o anticipatory I/O scheduler
  o Use kblockd for running request queues
  o per queue nr_requests
  o blk_congestion_wait threshold cleanup
  o allow the IO scheduler to pass an allocation hint to
  o handle OOM in get_request_wait()
  o block batching fairness
  o generic io contexts
  o block request batching
  o get_io_context fixes
  o block allocation comments
  o after exec_mmap(), exec cannot fail
  o bootmem.c cleanups
  o epoll: microoptimisations
  o fix current->user->__count leak
  o MTD build fix for old gcc's
  o fix rfcomm oops
  o i2o_scsi build fix
  o Improve mmap readaround
  o use task_cpu() not ->thread_info->cpu in sched.c
  o misc fixes
  o breadahead() tweaks
  o proc_attr_lookup() fix
  o xattr: cleanups
  o xattr: blockdev inode selection fix
  o xattr: update-in-place optimisation
  o xattrr: preparation for fine-grained locking
  o xattr: fine-grained locking
  o Module autoloading for quota
  o display bootserver in /proc/net/pnp
  o BSD accounting speedup

Anton Blanchard:
  o enable device mapper in compat layer

Arun Sharma:
  o ia64: IA-32 support patch: msgsnd/msgrcv return value off by 4
  o ia64: IA-32 support patch: munmap should return EINVAL if size == 0
  o ia64: IA-32 support patch: mmap should return ENOMEM

Ben Collins:
  o [SPARC64]: Fix formatting and typos in boot Makefile
  o [SPARC64]: Enable KALLSYMS, use print_symbol()

Benjamin Herrenschmidt:
  o fix IDE init oops on PowerMac

Bernardo Innocenti:
  o Fix do_div() for all architectures
  o Fix problem introduced by do_div() patch

Bruno Ducrot:
  o powernow-k7 typo fix

Chad Talbott:
  o ia64: SN2 updates

Dagfinn Ilmari Mannsåker:
  o Allow modular DM

Dave Jones:
  o [AGPGART] SiS 755 support for AMD K8 GART
  o [CPUFREQ] Fix stupid inverted FID/VID bug
  o [CPUFREQ] update cpufreq docs to reflect newly merged architecture
    support From Dominik Brodowski
  o [AGPGART] Add AGP3 support for all VIA AGP3 chipsets
  o [AGPGART] Fill out bridge structure with pdev before querying agp
    version
  o [CPUFREQ] Misc cleanups
  o [CPUFREQ] kobj refcount fixes
  o [CPUFREQ] move cpufreq_restore(), and don't make it dependent on
    CONFIG_PM
  o [CPUFREQ] don't care about "rmmod -f". It's expected to break
    things
  o [CPUFREQ] More misc cleanups

Dave Kleikamp:
  o JFS: Possible trap/data loss when fixing directory index table
  o JFS: If unicode conversion fails, operation should fail
  o JFS: Make error return codes negative
  o JFS: add nointegrity mount option

David Mosberger:
  o ia64: A couple of additional fixes to sync with 2.5.73+
  o ia64: support arch_get_unmapped_area() cache
  o ia64: Remove UNW_DEBUG again.  Adding it was a mistake
  o ia64: Fix LOAD_OFFSET macro in kernel linker script.  Reported by
    Mika Penttil.
  o ia64: Sync up with 2.5.74+
  o Use ".incbin" for initramfs image build

David S. Miller:
  o [SPARC64]: Move raid xor into library assembler file
  o [SPARC64]: Kill all irq_cpustat_t except __softirq_pending
  o [SPARC64]: Use kstat_this_cpu where possible
  o [TCP]: Initialize socket route on move to established state
  o [TCP]: Eliminate spurious CWND restart on every new connection
  o [SUNHME]: Set RXMAX/TXMAX large enough to handle VLAN frames

Dmitry Torokhov:
  o [NET] Attach inner qdiscs to TBF

Eric Sandeen:
  o [XFS] add swsusp support to xfs daemons

Gary Hade:
  o ia64: fix for sys32_sysinfo bug

Greg Kroah-Hartman:
  o PCI: change WARN_ON(irqs_disabled()) to WARN_ON(in_interrupt()) to
    keep the fusion drivers happy
  o sysfs: change print() to pr_debug() to not annoy everyone
  o SYSFS: add module referencing to sysfs attribute files
  o sysfs: add sysfs_rename_dir() Based on a patch written by Dan Aloni
    <da-x@gmx.net>
  o kobject: add kobject_rename() Based on a patch written by Dan Aloni
    <da-x@gmx.net>
  o driver core: added class_device_rename() Based on a patch written
    by Dan Aloni <da-x@gmx.net>
  o driver core: add my copyright to class.c

Greg Ungerer:
  o selection of boot parameters at configure time for Motorola 5282
    targets
  o conditional ROMfs copy for Motorola M5307C3 board
  o force PAGE_SIZE to be an unsigned long
  o remove unused register from clobber list in down_trylock()
  o simplify access_ok() for all m68knommu targets
  o shared library support for MMUless binfmt_flat loader
  o flat loader H8/300 specific support abstracted
  o flat loader m68knommu specific support abstracted
  o flat loader v850 specific support abstracted
  o conditional ROMfs copy for Cleopatra/5307 board
  o .no .romvec section for DragonEngine/68328 target
  o define shared lib limits for flat loader
  o cleanup show_process_blocks() for non-mmu targets
  o define raw read/write for m68knommu io access
  o remove 68360 specific trap init call
  o 68328 DragenEngine configure updates
  o conditional ROMfs copy for SecureEdgeMP3/5307 board
  o DragenEngine interrupt handler to use irqreturn_t
  o conditional ROMfs copy for NETtel/5307 board
  o fix security_initcall in m68knommu linker script
  o clean module_exit in m68knommu serial drivers
  o fix return type of m68knommu timer handler to be irqreturn_t
  o fix interrupt handler passed as arg to return irqreturn_t
  o use irqreturn_t in ColdFire interrupt setup code

Herbert Xu:
  o [IPSEC] Add policy expiration
  o [IPSEC] Fix refcnt leak in xfrm_lookup

Hideaki Yoshifuji:
  o [IPV6] fix a mistake in ipv6_advmss() conversion
  o [NET] Fix oops with /proc/net/{raw,igmp,mfilter,
    raw6,igmp6,mfilter6,anycast,ip6_flowlabel}.
  o [NET] Send only unicast NSs in PROBE state
  o [IPV6] ignore on-link information without on-link flag set
  o [IPV6] remove unused variable
  o [IPV6] fix algorithm for updating lifetime
  o [ATM] Convert clip neigh table to C99 initializers
  o [IPV6] Fix BUG when appending destination options headers

Hirofumi Ogawa:
  o FAT maintainership

Ian Molton:
  o ARM26 architecture update

Ingo Molnar:
  o another timer overflow thing
  o Double unlock in BSD accounting speedup patch

James Morris:
  o [IPSEC]: Do not call request_module() under spinlock in
    xfrm_get_type()

Jason Lunz:
  o [NET] Fix refcounting of dev->promiscuity for af_packet

Jean-Luc Richier:
  o [IPV6] Fix ipv6_addr_prefix() for prefixlen != 0 (mod 8)

Jeff Garzik:
  o fix via irq routing Via irq routing has a funky PIRQD location.  I
    checked my datasheets and, yep, this is correct all the way back to
    via686a.
  o [netdrvr 8139too] fix debug printk

John Levon:
  o OProfile: __exit fixes
  o OProfile: needed fix to IO-APIC timer
  o OProfile: fix a comment

John Marvin:
  o ia64: don't let PTRACE_POKEDATA write the NaT bits of syscall args

John Stultz:
  o jiffies include fix This patch fixes a bad declaration of jiffies
    in timer_tsc.c and timer_cyclone.c, replacing it with the proper
    usage of jiffies.h.

Krzysztof Halasa:
  o C99 initializers in hdlc_generic.c

Linus Torvalds:
  o The sbp2 driver needs <linux/pci.h>, but didn't include it. It
    apparently used to work due to some random magic indirect include,
    but broke lately.
  o Add an asynchronous buffer read-ahead facility. Nobody uses it for
    now, but I needed it for some tuning tests, and it is potentially
    useful for others.
  o Re-organize "ext3_get_inode_loc()" and make it easier to follow by
    splitting it into two functions: one that calculates the position,
    and the other that actually reads the inode block off the disk.
  o Carl-Daniel Hailfinger suggest adding a paranoid incoming trigger
    as per the "bk help triggers" suggestion, so that we'll see any new
    triggers showing up in the tree.
  o Go back to defaulting to 6-byte commands for MODE SENSE, since some
    drivers seem to be unhappy about the 10-byte version. 
  o When forcing through a signal for some thread-synchronous event (ie
    SIGSEGV, SIGFPE etc that happens as a result of a trap as opposed
    to an external event), if the signal is blocked we will not invoce
    a signal handler, we will just kill the thread with the signal.
  o Simplify and speed up mmap read-around handling
  o Fix several broken macros to get the "private" field of a seq-file
    in the networking code.
  o Avoid deadlocking on thread shutdown after a vfork
  o Fix IDE initialization when we don't probe for interrupts
  o Make the gcc version checks use the preprocessor symbols
    consistently.
  o Update CREDITS file and other documentation about my new email
    address
  o Fix up the IDE irq disable to take into account some
  o Fix mailer-induced corruption in initramfs build rules

Lode Leroy:
  o [IPV4] display bootserver in /proc/net/pnp

Marc Zyngier:
  o EISA: core changes
  o EISA: Documentation update
  o EISA: More EISA ids
  o EISA: PA-RISC changes
  o EISA: PCI-EISA dma_mask
  o EISA: avoid unnecessary probing

Martin Diehl:
  o Missing IrDA stuff for 2.5.73-bk8: sir_dev

Martin Hicks:
  o ia64: fix register-backing store initialization for main thread

Matthew Wilcox:
  o PCI: Improve documentation Fix some grammar problems Add a note
    about Fast Back to Back support Change the slot_name recommendation
    to pci_name().
  o PCI: arch/i386/pci/direct.c can use __init, not __devinit
    pci_sanity_check() is only called from functions marked __init, so
    it can be __init too.
  o PCI: pci_find_bus needs a domain Give pci_find_bus a domain
    argument and move its declaration to <linux/pci.h>
  o PCI: Remove pci_bus_exists Convert all callers of pci_bus_exists()
    to call pci_find_bus() instead.
  o PCI: arch/i386/pci/irq.c should use pci_find_bus Use pci_find_bus
    rather than relying on the return value of pci_scan_bus.
  o PCI: arch/i386/pci/legacy.c: use raw_pci_ops Make
    pcibios_fixup_peer_bridges() use raw_pci_ops directly instead of
    faking pci_bus and pci_dev.
  o PCI config space in sysfs
  o Driver Core: fix firmware binary files Fixes the sysfs binary file
    bug.
  o ia64: Use generic pci_scan_bus()

Mikael Starvik:
  o CRIS architecture update for 2.5.74

Paul Fulghum:
  o synclink.c update
  o synclinkmp.c update
  o synclink_cs.c update

Paul Mackerras:
  o Compile fix and cleanup for macserial driver

Pavel Machek:
  o New maintainter for nbd
  o suspend SMP-kernel with one CPU
  o Fix thinko in acpi
  o Fix swsusp with PREEMPT

Randy Dunlap:
  o [IPV6] use correct mib struct
  o [NET] Add MODULE_LICENSE (GPL) to wanroutrer so that kernel is not
    tainted

Roger Luethi:
  o via-rhine 1.18-2.5: Fix Rhine-I regression

Russell King:
  o [SERIAL] Don't return -ERESTARTSYS if signals aren't pending

Rusty Russell:
  o Remove cpu arg from cpu_raise_irq
  o Per-cpu variable in mm/slab.c
  o Remove unused __syscall_count
  o Make ksoftirqd a normal per-cpu variable
  o Make kstat_this_cpu in terms of __get_cpu_var and use it
  o switch_mm and enter_lazy_tlb: remove cpu arg

Scott Feldman:
  o [e1000] request_irq() failure resulted in freeing twice
  o [e1000] fix VLAN support on PPC64
  o [e1000] missing Tx cleanup opportunities during intr handling
  o [e1000] alloc_etherdev failure didn't cleanup regions
  o [e1000] ethtool diag cleanup
  o [e1000] h/w workaround for mis-fused parts
  o [e1000] s/int/unsigned int/ for descriptor ring indexes
  o [e1000] misc cleanup

Stephen Hemminger:
  o Change OSDL address in CREDITS
  o [NET]: PPP handling fragmented skbuffs

Stephen Lord:
  o Remove unused xfs_syncd.c file
  o Cleanup xfs and pagebuf sysctl code, use posix initializers to
    avoid confusion in the future over which constants apply to which
    initializers.

Steve French:
  o Fix compiler warning
  o cifs xattr support part 1
  o Signing fixes (1-4)
  o Update cifs vfs information and readme
  o Fix statfs failure due to invalid value for ffree

Steven Cole:
  o update Documentation/Changes, scripts/ver_linux

Thomas Graf:
  o [NET]: Make {send,recv}msg return EMSGSIZE when msg_iovelen is too
    big, as per 1003.1

Tom Rini:
  o PPC32: Update the OpenPIC code
  o PPC32: Update the bootloader serial code to have stub functions
  o PPC32: Remove references to a removed file
  o PPC32: Minor KGDB updates
  o PPC32: Add a backend for standard (ns1655x) UARTs for debugers
  o PPC32: Update the Motorola Sandpoint support
  o PPC32: Fix CONFIG_NVRAM && !CONFIG_PPC_PMAC
  o Remove the Zynx 4500 platform code.  It was old and unmaintained
  o PPC32: Remove the MEN F1 platform code.  It was old and
    unmaintained

Trond Myklebust:
  o Add open intent information to the 'struct nameidata'
  o Pass 'nameidata' to ->create()
  o Pass 'nameidata' to ->permission()
  o Use the intents in 'nameidata' to improve NFS close-to-open
    consistency
  o make create() follow symlinks again

Ulrich Drepper:
  o wrong pid in siginfo_t
  o tgkill patch for safe inter-thread signals

Ville Nuorvala:
  o [IPV6] fix a dst leakage and clean-up in tcp_v6_connect()
  o [NET]: Fix tunnel device bugs added by alloc_netdev() changes
  o [IPV6]: Fix DST handling bug in ip6ip6_err()
  o [IPV6]: Convert ip6ip6 tunnel driver to alloc_netdev()


