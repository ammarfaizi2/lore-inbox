Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSLXFjw>; Tue, 24 Dec 2002 00:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSLXFjw>; Tue, 24 Dec 2002 00:39:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266774AbSLXFjp> convert rfc822-to-8bit; Tue, 24 Dec 2002 00:39:45 -0500
Date: Mon, 23 Dec 2002 21:45:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.53
Message-ID: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id gBO5lf317197
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A happy christmas to you all, and in case I'm too busy putting batteries
in the kids presents the rest of the year, here's a 2.5.53 for you.

It's got stuff all over - SCSI updates, ACPI, ia64, sparc, USB, net,
device mapper, AGP, ALSA, you name it. Meanwhile I worked mostly on the
sysenter support, we'll have to wait for glibc releases to test that out
more.

Oh, and merges with Andrew and Dave.

		Linus

---

Summary of changes from v2.5.52 to v2.5.53
============================================

<arnd@bergmann-dalldorf.de>:
  o namespace pollution in STV0680 camera driver
  o namespace pollution in ibmcam driver
  o [PKTGEN]: Mark some functions static

Arun Sharma <arun.sharma@intel.com>:
  o ia64: ia32 emulation fixes for 2.5.45
  o ia64: ia32 emulation layer bug fix

<bzzz@gerasimov.net>:
  o remove 2TB limit in sd

Doug Ledford <dledford@flossy.devel.redhat.com>:
  o aic7xxx_old: improve usage of pci_request_regions due to device
    contention
  o Change all uses of device->request_queue (was struct, now pointer)
    Update scsi_scan so that we don't pass around a scsi_device struct
    for scanning.  Instead, we pass around a request_queue during
    scanning and create and destroy device structs as needed.  This
    allows us to have a 1:1 correlation between scsi_alloc_sdev() and
    scsi_free_sdev() calls, which we didn't have before.
  o aic7xxx_old/aic7xxx.h: Run time warning fix

<ganadist@nakyup.mizi.com>:
  o [AGP] kconfig tweaks & missing exports

<henning@meier-geinitz.de>:
  o scanner.h: add/fix vendor/product ids
  o scanner.c: Support for devices with only one bulk-in endpoint

<jbarnes@sgi.com>:
  o ia64: SN update

<jkenisto@us.ibm.com>:
  o dev_printk macro

<joe@fib011235813.fsnet.co.uk>:
  o dm: move ioctl numbers to a sane place
  o dm: proper error checking
  o dm: fix error number
  o dm: REMOVE_ALL parameter checking
  o dm: fix check_device_area compare
  o dm: check chunksize before allocation
  o dm: stripe constructor validity check
  o dm: per-device mempools
  o dm: check correct flag in queue_io()
  o dm: dm_suspend locking fix
  o dm: flush pending IO before dm_suspend
  o dm: avoid unnecessary locking
  o dm: fix md->pending count
  o dm: fix bio duplication
  o dm: remove highmem paranoia
  o dm: remove verbose debug message
  o dm: fix/simplify endio
  o dm: bio split fix
  o dm: fix sector calculation

<krkumar@us.ibm.com>:
  o [IPV6]: Missing in6_dev_put in router discovery

<mikal@stillhq.com>:
  o ia64: [Trivial Patch] scsi_register-001-002

<milli@acmeps.com>:
  o [AGP] Make i845g use correct initialisation routine

<oliver@oenone.homelinux.org>:
  o USB: speedtouch driver memory allocation deadlock fix

<sridhar@dyn9-47-18-86.beaverton.ibm.com>:
  o [SCTP] SCTP_INITMSG socket option
  o [SCTP] Fix for memcpy() in sctp_sendmsg() that can copy too much
  o [SCTP] sctp_v6_xmit() cleanup
  o [SCTP] Stale cookie support. (ardelle.fan)
  o [SCTP] Register a notifier for v6 address additions/deletions
  o [SCTP] Window update SACK support

<sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com>:
  o [SCTP] Fix for bad dereference in sctp_cmd_assoc_failed()

<wrlk@riede.org>:
  o OSST tape driver fix for 2.5.51
  o ide-scsi changes for new mid level api and error handling in 2.5.52

Adrian Bunk <bunk@fs.tum.de>:
  o fix the compilation of eata_pio_proc.c
  o MSNDCLAS_HAVE_BOOT and MSNDPIN_HAVE_BOOT shouldn't ask questions

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb-storage bugfix

Anders Gustafsson <andersg@0x63.nu>:
  o [TCP]: Fix infinite loop when reading /proc/net/tcp with
    ipv6-sockets

Andi Kleen <ak@muc.de>:
  o Some i386 cleanups - MTRR, bootflag
  o x86-64 merge
  o x86-64 relocations for elf.h
  o Add workaround for AMD8131 bug
  o Make mem=nopentium clear cpu_has_pse
  o Fix pageattr with mem=nopentium

Andrew Morton <akpm@digeo.com>:
  o Fix filesystems that cannot do mmap writeback
  o fix the build for old gcc's
  o sync_fs deadlock fix
  o fix a page dirtying race in vmscan.c
  o fix use-after-free bug in move_vma()
  o more informative slab poisoning
  o Add generic_file_readonly_mmap() for nommu
  o misc fixes
  o Remove PF_NOWARN
  o Give kswapd writeback higher priority than pdflush
  o ext2/3 commentary and cleanup
  o ext2/3: better starting group for S_ISREG files
  o ext3: smarter block allocation startup
  o ext2: smarter block allocation startup
  o rename locals in ext2_new_block()
  o ext3 use-after-free bugfix
  o ext3: fix buffer dirtying
  o hugetlb bugfixes
  o hugetlb: report shared memory attachment counts
  o hugetlbfs: set inode->i_size
  o don't cacheline-align radix_tree_nodes
  o remove memclass()
  o remove unused macro MAP_ALIGN()

Andy Grover <agrover@groveronline.com>:
  o ACPI: Fix oops on module insert/remove (Matthew Tippett)
  o ACPI: remove non-Linux revision on files, and make types more
    Linux-like
  o ACPI: More cosmetic changes to make the code more Linux-like

Art Haas <ahaas@airmail.net>:
  o ia64: C99 designated initializer for arch/ia64/sn/

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: Fix typo in unaligned memory access handler (no functional
    change)

Chad N. Tindel <ctindel@cup.hp.com>:
  o [BONDING]: Update to version 2.4.20-20021210

Christoph Hellwig <hch@infradead.org>:
  o Re: scsi_scan.c complaints

Christoph Hellwig <hch@lst.de>:
  o [AF_KEY]: Fix comment typo

Christoph Hellwig <hch@sgi.com>:
  o [XFS] remove xfs_dm_send_create_event
  o [XFS] remove unused debugging code
  o [XFS] more dead code removal
  o [XFS] remove references to i_dev, it's gone in recent kernels
  o [XFS] fix an out-of-date comment

Chuck Lever <cel@citi.umich.edu>:
  o use kmap_atomic instaed of kmap in NFS client
  o give NFS client a "set_page_dirty" address space op
  o cleanup: simplify req_offset function in NFS client

Dave Jones <davej@codemonkey.org.uk>:
  o Fix XFree86 brain damage
  o don't allow to be opened twice
  o oops. missed a part of the double init patch
  o don't allow backend to unload if in use by a chipset driver
  o [AGP] small c99/inlining cleanups
  o [AGP] Remove unused prototypes
  o [AGP] Add AGP 3.0 support and I7505 chipset driver
  o [AGP] fix bogus casts
  o [AGP] Hopefully get the KT400 working in AGP3.0 mode
  o indentation fixes
  o [AGP] Use compatability mode of KT400 if detected
  o [AGP] Clean up capability pointer detection
  o [AGP] __init audit after Rusty found a bug
  o [AGP] Missing bits of David Mosberger's cleanups
  o [AGP] Export agp3 routines and link to module if needed
  o [AGP] agp_frontend_initialize() now gets called when a chipset
    driver registers, so it can't be __init any more
  o [AGP] Readd module_exit function so that agpgart.ko can be unloaded
  o [AGP] misplaced setting of bridge device
  o Cyrix 3 gcc options changed
  o swap.h doesn't use prefetching
  o i2c size_t fix
  o make cpu serial number disable generic
  o [AGP] Make things compile again if AGP3=n

David Brownell <david-b@pacbell.net>:
  o ehci-hcd (1/2):  portability (2.4), tasklet,
  o ehci-hcd (2/2): rest of tasklet remove
  o usbnet:  zaurus, oops, etc
  o ehci misc patches
  o hub driver uses dev_info(), less log clutter
  o ehci, more small fixes
  o ehci, qtd submit and completions
  o usbcore: rm hub oops, message cleanups, unlink
  o ehci, qtd submit and completions

David Mosberger <davidm@tiger.hpl.hp.com>:
  o AGPGART fixes for HP ZX1 and Intel I460
  o ia64: Make mremap() work properly when returning "negative"
    addresses
  o ia64: Define new "arch_switch" macros so that the tasklist_lock can
    be released during the (low-level) context-switch.  Patch by Erich
    Focht.
  o ia64: Fix efi_memmap_walk() to work with more complicated memory
    maps
  o ia64: Rename __flush_tlb_all() to local_flush_tlb_all()
  o ia64: Make flush_tlb_mm() work for multi-threaded address-spaces on
    SMP machines
  o ia64: Make it easier to set a breakpoint in the Ski simulator right
    before starting the kernel (based on patch by Peter Chubb).
  o ia64: Patch by Venkatesh Pallipadi to fix IA-32 signal handling to
    restore instruction and data pointers.
  o ia64: Delete arch/ia64/sn/configs/ files on request by John
    Hesterberg
  o ia64: For ia32 emulation, do not turn on O_LARGEFILE automatically
  o ia64: Decode feature bits added by SDM2.1 (spontaneous deferral &
    16-byte atomic ops).
  o ia64: Sync up with 2.5.50 (Ski simulator has been tested only so
    far)
  o ia64: Manual merge of Erich's NUMA node-size changes
  o ia64: Fix unaligned memory access handler
  o ia64: Manual Makefile cleanup merge
  o ia64: Merge with 2.5.50
  o ia64: Avoid holding tasklist_lock across routines that do IPIs
    (such as flush_tlb_all())
  o First part of 2.5.51 syncup
  o New file asm-ia64/intrinsics.h
  o ia64: efivars fix by Matt Domsch and Peter Chubb
  o ia64: More 2.5.51/2.5.52 sync up
  o Add VIRTUAL_MEM_MAP config option
  o ia64: consolidate sys32_new[lf]stat.  Patch by Stephen Rothwell
  o ia64: More merge fixes
  o ia64: Finish 2.5.52+ merge
  o ia64: Fix printing of memory attributes

David S. Miller <davem@nuts.ninka.net>:
  o [SCTP]: Add MAINTAINERS entry
  o [PROMCON]: Fix type in vc_resize call
  o [SPARC64]: Update ioctl32 for fb changes
  o [SPARC64]: Add sbus_{read,write}q
  o [SPARC]: Update asm/fbio.h for fb changes
  o [ATYFB]: Fix build error in sparc specific sections
  o [FB]: Add readq/writeq for sparc
  o [SPARC64]: Convert for stat/utime compat syscall changes
  o [SPARC64]; Convert over to compat_clock_t and compat_sys_times
  o [SPARC64]: Un-static cp_compat_stat
  o [SPARC64]: Fix some circular include deps
  o [SPARC64]: Some more compat stat syscall entry conversions
  o [SOUND]: ioctl32/{ioctl32,rawmidi32,seq32,timer32}.c needs
    linux/fs.h

Dipankar Sarma <dipankar@in.ibm.com>:
  o [IPV4]: lockfree ipv4 route cache

Douglas Gilbert <dougg@torque.net>:
  o scsi_debug version 1.67 for lk 2.5.52

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Change some %x formats to %p for pointers

Erich Focht <efocht@ess.nec.de>:
  o ia64: Configurable NUMA node memory size

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: usbserial: Add a short_name field to work better with sysfs
  o USB: keyspan_pda: fix up the short names, as they were too big
  o USB: whiteheat: fix some gcc 3.2 warning messages
  o USB: warn users that they should not be using the usbdevfs name
  o LSM: changed the dummy code to use the default operations logic
  o LSM: Fix up the description of the root_plug code to try to make it
    clearer
  o LSM: update the copyright dates for my entry
  o USB: fix the spelling of "deprecated"

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o typos in asm-alpha/dma.h
  o PCI: setup-xx fixes

James Bottomley <jejb@mulgrave.(none)>:
  o Fix the max_sectors warning afflicting some host adapter drivers
  o correct compile warnings without Large Block Device support
  o [SCSI 53c700] remove no_module_init again, sigh
  o [SCSI 53c700] update to new generic device dma_ API
  o [SCSI] update lasi700 for new parisc device model
  o generic device DMA API
  o allow pci primary busses to have parents in the device model
  o remove PCI_NEW_DMA_COMPAT_API

James Morris <jmorris@intercode.com.au>:
  o [SPARC64]: Define COMPAT_USER_HZ and compat_clock_t
  o [SPARC]: Update for new do_coredump args

Jaroslav Kysela <perex@suse.cz>:
  o ALSA update
  o HP100 network driver - Pavel Machek <pavel@suse.cz>

John Levon <levon@movementarian.org>:
  o oprofile update

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o [SCTP] Last of the v4/v6 partioning (for now)

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Update aic7xxx driver to 6.2.10.  Add aic79xx U320 SCSI driver
    version 1.1.1
  o Final 1.1.1 aic79xx driver updates
  o Bring in some deltas that were missed in the aic79xx 1.1.1 and
    aic7xxx 6.2.10 updates.  The aic79xx driver now also supports
    mid-layer induced
  o Update to aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2
  o Remove generated file
  o Complete aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2 update
  o Enable highmem_io
  o o Kill host template files
  o Complete the upgrade to aic7xxx 6.2.23 and aic79xx 1.3.0_ALPHA3
  o Update to aic7xxx version 6.2.24 and aic79xx version 1.3.0_ALPHA5

Kai Makisara <kai.makisara@kolumbus.fi>:
  o SCSI tape driver fix for 2.5.51

Linus Torvalds <torvalds@home.transmeta.com>:
  o Add "sysenter" support on x86, and a "vsyscall" page
  o Allow KALLSYMS even without kernel debugging
  o Export the 'vsyscall' address to user space with the AT_SYSINFO elf
    AUX-table entry.
  o Make six-argument system calls work with the fast system call
    trampoline.
  o Merge with DRI CVS tree
  o Make NFS compile even without NFS_V4 support
  o Ignore ".ko" files - kernel module objects
  o Get rid of silly printk's in recent mtrr driver changes
  o Sysenter cleanups (originals by Brian Gerst, updated and expanded
    by me)
  o More mtrr/if.c fixes
  o Remove old pci_dma_supported(), this is done by the generic device
    DMA now (see <linux/pci.h> for the compat wrapper).
  o Handle single-stepping over fast system calls without polluting the
    fast case with a pushf/popf, by having the kernel debug trap set
    the TIF_SINGLESTEP flag and causing the return path to dtrt.
  o Fix sysenter restart backwards jump, add offset comments, and make
    the alignment of the return point  be saner.
  o Remove bogus duplicated (and wrong) function declaration
  o Fix the remaining known problems (NMI and debugging) with fast
    system calls. They should now be fully comparable to traditional
    system calls.

Manfred Spraul <manfred@colorfullife.com>:
  o new attempt at sys_poll allocation (was: Re: Poll patches..)
  o reorder 'rep;nop;' in the spinlock macro
  o Avoid overwriting boot_cpu_data from trampoline code

Martin J. Bligh <mbligh@aracnet.com>:
  o x86 subarch header files
  o NUMA-Q subarch directory
  o abstract out clustered APIC code
  o abstract out mpparse code
  o mpparse cleanups
  o cleanup IPI code
  o clustered IPI cleanups
  o more clustered-apic-mode work

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: fixup interpret_urb_result()

Michal Ostrowski <mostrows@speakeasy.net>:
  o [PPPOE]: Fix connect handling

Miles Bader <miles@lsi.nec.co.jp>:
  o Update v850 includes for slimmed-down sched.h
  o Make some symbol exports conditional on CONFIG_MMU
  o Add v850 support for `sys_restart_syscall'
  o Add some v850 elf constants
  o Pass extra signal handler args correctly on the v850
  o Reduce redundancy in v850 linker scripts

Nathan Scott <nathans@sgi.com>:
  o [XFS] Fix size check for realtime devices
  o [XFS] Some cleanup, some more unwritten extent related changes
  o [XFS] Fix up setting up of sector size for the superblock buffer
    after the very first read on mount.  Make some of the surrounding
    code dealing with buffers consistent.
  o [XFS] Fix some setxattr compiler warnings (const)

Nemosoft Unv. <nemosoft@smcc.demon.nl>:
  o USB: PWC 8.10 for 2.5.51

Oliver Neukum <oliver@neukum.name>:
  o USB: clean kernel thread exit for speedtouch
  o USB: speedtouch: eliminate sleep_on
  o USB: fix an unlinking race in speedtouch driver
  o USB: proper error return for usblcd
  o USB: simplify spinlocks in send path for speedtouch
  o USB: more spinlock work for speedtouch
  o USB: speedtouch remove error handling with usb_clear_halt
  o USB: speedtouch reentrancy race through usbfs
  o USB: remove obviously broken code from the speedtouch disconnect
    handler
  o USB: speedtouch possible deadlock in atm_close path
  o USB cdc-acm: missed a GFP_KERNEL in interrupt
  o USB cdc-ether: GFP_KERNEL in interrupt

Patrick McHardy <kaber@trash.net>:
  o [Netfilter]: Forgotten dev_put for bridge-devices in nf_reinject

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: missing free_irq in sunsu driver

Randy Dunlap <rddunlap@osdl.org>:
  o fix intermezzo build
  o Patch for affs: pr_debug() usage

Richard Henderson <rth@are.twiddle.net>:
  o [ALPHA] Change EH mechanism to be pc-relative instead of
    gp-relative
  o [ALPHA] Add __param support to link script

Robert Love <rml@tech9.net>:
  o missing typecast

Russell Cattelan <cattelan@sgi.com>:
  o [XFS] "merge" the 2.4 fsx fix for block size < page size to 2.5. 
    This needed major changes to actually fit.

Rusty Russell <rusty@rustcorp.com.au>:
  o honour init= bootparm

Sam Ravnborg <sam@ravnborg.org>:
  o ia64: arch makefiles update

Simon Evans <spse@secret.org.uk>:
  o 2.5.51 More typedef removal from usbvideo

Sridhar Samudrala <sridhar@dyn9-47-18-140.beaverton.ibm.com>:
  o [SCTP] MSG_PEEK support for recvmsg()
  o [SCTP] Fixes for gcc 3.2 compiler issues and warnings
  o [SCTP] Move the registration of v6 address event notifier to ipv6.c

Stephen Lord <lord@sgi.com>:
  o [XFS] rework iocore infrastructure, remove some code and make it
    more

Stephen Rothwell <sfr@canb.auug.org.au>:
  o ia64: arch-specific part of 1st compat clean up
  o ia64: consolidate sys32_times
  o Fix bad interaction with APM and the new sysenter segment layout

Stéphane Eranian <eranian@hpl.hp.com>:
  o Please apply this cleanup patch to your 2.5.50. The patch is made
    using 2.4.45 but the file has not changed since. It cleans up the
    initialization and some text alignment problems. Initial patch by
    Chris Wilson.

Tony Luck <tony.luck@intel.com>:
  o ia64: mca logging bug fixes

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Clean up NFSv4 READ xdr path
  o Clean up NFSv4 WRITE xdr path
  o Support for NFSv4 READ + WRITE attribute cache consistency

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>:
  o ia64: IA32 ptrace bug-fixes

William Lee Irwin III <wli@holomorphy.com>:
  o vm86 IRQ bugfix
  o converting cap_set_pg() to for_each_task_pid()
  o Fix CPU bitmask truncation


