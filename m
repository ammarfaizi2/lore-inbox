Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSIIRrT>; Mon, 9 Sep 2002 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318807AbSIIRrT>; Mon, 9 Sep 2002 13:47:19 -0400
Received: from [63.209.4.196] ([63.209.4.196]:9740 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S318809AbSIIRrL>;
	Mon, 9 Sep 2002 13:47:11 -0400
Date: Mon, 9 Sep 2002 10:55:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.34
Message-ID: <Pine.LNX.4.33.0209091049180.11925-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this has a surprising number of fundamental fixes, with some seriously
broken details fixed. The "per-cpu" macros didn't do the right thing at
ALL, causing silent trouble for softirq's on SMP, for example.

The floppy bio fixes (and yes, the floppy driver really works now) were
rather fundamental and embarrassing too. And edge-triggered PCI interrupts
really did some rather bad things under the right circumstances.

Other than those fixes (usually one-liners), this includes merges with Al
and Andrew, sparc fixes, JFS and ReiserFS updates etc.

Oh, and more pthreads help from Ingo, along with an indecent number of
warring fixes for ptrace breakage..

		Linus

---
Summary of changes from v2.5.33 to v2.5.34
============================================

<ac9410@attbi.com>:
  o 2.5.33 dmi_scan blacklist ibm thinkpad for i2c/sensors
  o 2.5.33 i2c-proc.c remove inode_fill code

<c-d.hailfinger.kernel.2002-07@gmx.net>:
  o net/ipv4/netfilter/ipchains_core.c: Fix MODULE_LICENSE

<dan@debian.org>:
  o More ptrace fixes for 2.5.33

<green@angband.namesys.com>:
  o Add displaying of more reiserfs statistical info through /proc
    interface, by Nikita Danilov
  o Corrected calculation of amount of blocks that file occupies on
    reiserfs
  o Implemented new block allocator for reiserfs, new tail policy for
    smaller tails

<ica2_ts@csv.ica.uni-stuttgart.de>:
  o include/net/tcp.h: Use ____cacheline_aligned

<nmiell@attbi.com>:
  o net/sctp/sm_make_chunk.c: Fix typo

<paulus@au1.ibm.com>:
  o PPC32: remove unnecessary includes in ppc_ksyms.c
  o PPC32: add the extra argument for do_fork to the PPC calls
  o fix create_elf_tables on PPC

<ray-lk@madrabbit.org>:
  o Re: 2.5.33 PNPBIOS does not compile

<skip.ford@verizon.net>:
  o include/asm-sparc64/hardirq.h: Comment fix

<willy@debian.org>:
  o move AGP PCI defines to pci_ids.h

Alexander Viro <viro@math.psu.edu>:
  o IDE cleanups (2.5; similar to ones done for other drivers)
  o (1/25) Unexporting helper functions
  o (2/25) Removing ->nr_real
  o (3/25) Removing useless minor arguments
  o (4/25) Unexporting driverfs_remove_partitions()
  o (5/25) Removing bogus arrays - ->flags[]
  o (6/25) Removing bogus arrays - ->driverfs_dev_arr[]
  o (7/25) Removing bogus arrays - ->part[].number
  o (8/25) Removing bogus arrays - ->de_arr[]
  o (9/25) update_partition()
  o (10/25) sr.c device name handling
  o (11/25) sr.c naming cleanup
  o (12/25) sr.c passes pointers instead of minors now
  o (13/25) sbpcd.c - beginning of cleanup
  o (14/25) sbpcd.c - use *current_drive instead of D_S[d]
  o (15/25) sbpcd.c - killed useds of cdi->dev
  o (16/25) pcd.c - beginning of macroectomy
  o (17/25) Lindent pcd.c
  o (18/25) pcd.c - cleanup, killed used of cdi->dev
  o (19/25) mcdx.c cleanup
  o (20/25) cdu31a.c cleanup
  o (21/25) cdrom->reset() cleanup
  o (22/25) gendisks for SCSI cdroms
  o (23/25) move pointer to gendisk from hwif to drive
  o (24/25) disk capacity helpers
  o (25/25) more cleanups of struct gendisk
  o handle_initrd() and request_module()

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o net/ipv4/tcp_output.c: Fix crashes due to bugs in TSO

Andi Kleen <ak@muc.de>:
  o Fix RELOC_HIDE miscompilation

Andrea Arcangeli <andrea@suse.de>:
  o Missing acess_ok() check in aio

Andrew Morton <akpm@zip.com.au>:
  o place rmap locking in rmap-locking.h
  o convert node/zone_start_paddr to pfns
  o reorganise setup_arch() for ia32 discontigmem
  o restructure mem_init for ia32 discontigmem
  o discontigmem support for ia32 NUMA
  o use page_to_pfn() instead of mem_map[]
  o Fix the boot-time reporting of each zone's available pages
  o Fix the __block_write_full_page() error path
  o Back out the initial work for atomic copy_*_user()
  o refill the inactive list more quickly
  o atomic copy_*_user infrastructure
  o Use kmap_atomic() for generic_file_read()
  o Use kmap_atomic() for generic_file_write()

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o try more sd.c MODE SENSE modes
  o sddr09.c MODE SENSE fixes

Christoph Hellwig <hch@sb.bsdonline.org>:
  o JFS: use jfs_file_inode_operations for special files aswell
  o JFS: sanitize naming of ea read/write functions, add missing
    statics
  o JFS: Remove unused file jfs_extendfs.h
  o JFS: remove some cruft left over from the pre-mempool metapage code
  o JFS: use buffer_heads to access the superblock
  o JFS: use block device inode/mapping instead of
    direct_inode/direct_mapping
  o JFS: ifdef out unused functions related to partial blocks
  o JFS: remove superflous externs for generic_file_ functions
  o JFS: remove superflous return at the end of lbmIODone
  o JFS: Don't include <linux/smp_lock.h> in jfs_dtree.c
  o JFS: sync blockdevice at umount
  o JFS: fix up more merge issues
  o JFS: we still need extHint

David Mosberger <davidm@napali.hpl.hp.com>:
  o trivial Makefile fix

David S. Miller <davem@nuts.ninka.net>:
  o [IGMP]: Make ip_mc_dec_group return void
  o net/core/dst.c: asm/bitops.h --> linux/bitops.h
  o drivers/net/ppp_generic.c: Fix byte-aligned packets, nearly every
    arch csum_partial cannot handle this
  o arch/sparc64/kernel/ioctl32.c: Handle SIOCDEVPRIVATE transparently
  o drivers/net/ppp_generic.c: Fix skb_put len arg when copying
    unaligned skb
  o [SPARC]: Fix build breakage
  o net/ipv4/netfilter/ip_nat_helper.c: Fix __FUNCTION__ pasting
  o drivers/net/ppp_generic.c: Allocate right length in unaligned SKB
    fix
  o arch/sparc64/kernel/ioctl32.c: Translate PPPIOCS{PASS,ACTIVE}
  o arch/sparc64/lib/VIScsum.S: Do not use VIS on oddly aligned buffer
  o drivers/net/ppp_generic.c: Revert my idiotic unaligned SKB changes
  o arch/sparc64/lib/VIScsum.S: Fix endianness bugs in previous change
  o arch/sparc64/kernel/ioctl32.c: Frob cmd in PPPIOCS{PASS,ACTIVE}

Geert Uytterhoeven <geert@linux-m68k.org>:
  o duplicate declaration of pci_lock

Harald Welte <laforge@gnumonks.org>:
  o MAINTAINERS: Update NETFILTER entry
  o [NETFILTER]: Fix OOPS in ipt_ULOG

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o remove BUG_ON(p->ptrace) in release_task()

Hugh Dickins <hugh@veritas.com>:
  o M386 flush_one_tlb invlpg

Ingo Molnar <mingo@elte.hu>:
  o ptrace-fix-2.5.33-A1
  o pid-max-2.5.33-A0
  o more ptrace updates
  o shared thread signals
  o Re: pinpointed: PANIC caused by dequeue_signal() in current Linus
  o CLONE_DETACHED fix

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: pci_ops update
  o alpha: compile fixes
  o alpha: misc fixes
  o pci bus resources, transparent bridges

James Morris <jmorris@intercode.com.au>:
  o net/ipv6/af_inet6.c: Fix __FUNCTION__ pasting
  o net/ipv4/netfilter/ipfwadm_core.c: Fix build bustage when debugging
    is enabled
  o sigio/sigurg cleanup for 2.5.32

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Remove CONFIG_DEVFS_FS from arch/ia64/config.in
  o ISDN: Fix __FUNCTION__ usage
  o ISDN: cleanups / overflow check
  o ISDN: One last ISDN designated initializer
  o ISDN: Remove __NO_VERSION__
  o kbuild: Fix export-objs
  o kbuild: fix ACPI Config.in breakage
  o drivers/char/sonypi.h: Fix __FUNCTION__ usage
  o include/linux/ptrace.h: fix includes
  o kbuild: Preprocess vmlinux.lds on i386 as well

Linus Torvalds <torvalds@home.transmeta.com>:
  o De-queue the floppy request late, so that the higher levels know
    the floppy driver is busy.
  o Major partial request completion boo-boo in the bio layer
  o Fix floppy driver end_request() handling - it used to do insane
    contortions instead of just calling "end_that_request_first()" with
    the proper sector count.
  o Fix IO-APIC edge IRQ handling. IRQ_INPROGRESS was cleared
    spuriously if a new edge happened while we were still processing
    the previous
  o Finally get rid of that irritating disk change message
  o Fsck knows why the devil does st.c has to call something a
    partition, but it does...
  o Avoid unused variable if CONFIG_BLK_DEV_MD isn't defined
  o Make in-kernel inode 'nlink' field be "unsigned int" instead
  o Fix sonypi driver to not do __FUNCTION__ pasting

Paul Mackerras <paulus@samba.org>:
  o PPC32: Convert the various PCI config space accessors to the new
    API
  o PPC32: update some initializers to the standard format, from Rusty
  o PPC32: Put back an export-objs that someone incorrectly removed
  o PPC32: moved the compatibility padding entries in the aux vector to
    the bottom of the aux table.
  o PPC32: Correct a comment about soft/hardirq masks in
    asm-ppc/hardirq.h
  o PPC32: fix a comment in asm-ppc/semaphore.h (extraneous "the")
  o PPC32: use page_to_pfn instead of page - mem_map in a couple of
    places
  o PPC32: remove a couple of unused files

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o IDE cleanup (1.612) broke all fdisks I have

Randy Hron <rwhron@earthlink.net>:
  o qlogic "this should not happen" fix

Robert Love <rml@tech9.net>:
  o flag type cleanup
  o bad: schedule() with irqs disabled!

Rusty Russell <rusty@rustcorp.com.au>:
  o Early child_reaper initialization
  o daemonize() calls reparent_to_init cleanup
  o Important per-cpu fix
  o list_t removal


