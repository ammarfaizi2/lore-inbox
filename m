Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUHJDDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUHJDDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUHJDDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:03:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:10936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267407AbUHJDDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:03:04 -0400
Date: Mon, 9 Aug 2004 20:03:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc4
Message-ID: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Not a huge amount of changes, but enough that I wouldn't have felt
comfortable releasing it as 2.6.8. I've been hoping to resolve the dcache
reports, and we found _one_ bug, but that one would likely not affect a
whole lot of people, so..

Some ARM updates, the i586 AES code rewrite, some ppc updates.. A large 
portion of the patch actually ends up being cleaning up some /proc files 
(thanks to Al for doing seq-file conversions) and me fixing some broken 
calling conventions in sysctl and sound /proc handling.

The shortlog gives a reasonable picture of the changes.

		Linus

----

Summary of changes from v2.6.8-rc3 to v2.6.8-rc4
============================================

Adrian Bunk:
  o MTD: remove some kernel 2.0 and 2.2 #ifdef's
  o MAINTAINERS: update MTD list

Alan Cox:
  o HPT IDE update

Alex Williamson:
  o Using CONFIG_IA64_HP_ZX1 on an sx1000 system setup w/ multiple NUMA
    nodes (configured for cell local memory) currently crashes because
    MAX_NUMNODES defaults to 1.  The patch below sets up things to make
    this work.

Alexander Viro:
  o simple_read_buffer() helper function
  o imm.c oops fix
  o ppc64: Fix rtas file mess
  o ppc: seq_file conversion for ppc_htab
  o Fix ppc htab seq_file conversion
  o Teach sscanf about 'hh' and 'll'
  o mpoa patch done right

Andrew Morton:
  o jbd: journal_head unmapping race fix

Andrey Panin:
  o ppc64: fix free_irq()

Anton Blanchard:
  o ppc64: various XICS fixes
  o ppc64: fix PCI allocation warning
  o ppc64: avoid speculative execution after rfid
  o ppc64: set SMT thread priority to medium for all exceptions
  o ppc64: fix chrp_progress mismerge
  o ppc64: suppress 'store_purr' unused warning
  o [ppc64] Fix SLB castout issue

Art Haas:
  o sparc32: gcc-3.3 macro parenthesization fix for memcpy.S

Ben Dooks:
  o [ARM PATCH] 1966/1: S3C2410 - Fix for serial driver compile error
  o [ARM PATCH] 1968/1: S3C2410 - GPIO updates and access functions
  o [ARM PATCH] 1971/1: BAST - default configuraiton update
  o [ARM PATCH] 1972/1: IPAQ H1940 - fix serial clock base
  o [ARM PATCH] 1988/1: S3C2410 - defconfig update to include all
    boards
  o [ARM PATCH] 1989/1: S3C2410 - rename owner of VR1000 board and
    update help
  o [ARM PATCH] 1990/1: S3C2410 - fix mis-spelled time initialisation
    calls

Bjorn Helgaas:
  o machvec.h
  o cyclone.h, cyclone.c, acpi.c, Kconfig
  o sba_iommu.c

Catalin Marinas:
  o [ARM PATCH] 1964/1: Wrong cache block operations checking
  o [ARM PATCH] 1965/1: gas only generates the c and f field bits for
    the "msr [cs]psr, rN" instruction

Cornelia Huck:
  o s390: common i/o layer changes

Dave Hansen:
  o ppc64: move SPINLINE out of global menu
  o ppc64: suppress unused var warning in get_irq_server()

Dave Jones:
  o boolean typo in DVB

David S. Miller:
  o [PKT_SCHED]: Move sch_atm over to qdisc_priv()
  o Cset exclude:
    davem@nuts.davemloft.net|ChangeSet|20040804202342|60209
  o [NET]: Move sndmsg_page destruction back into TCP for now

David Woodhouse:
  o NAND support in JFFS2 isn't experimental any more

Domen Puncer:
  o remove unused #include <linux/version.h>

Geoffrey LEVAND:
  o ppc32: fix ebony uart clock

Heiko Carstens:
  o md multipathing fixes
  o s390: zfcp host adapater

Hidetoshi Seto:
  o Set up CMC/CPE polling *before* enabling CMCI/CPEI interrupts to
    avoid situation where a flood of errors prevents boot.

James Morris:
  o Drop asm i586 AES code
  o Re-implemented i586 asm AES

Jens Axboe:
  o multipath readahead fix
  o adjust SG reserved size automatically
  o Export blk_queue_resize_tags
  o allow broken apps to include kernel header

Jesse Barnes:
  o sgi_io_init.c
  o generic_defconfig update.  I just ran 'make oldconfig' against the
    existing

Johannes Stezenbach:
  o dvb: missing includes

John Engel:
  o ppc64: 32-bit ptrace geteventmsg fix

John Lenz:
  o [ARM PATCH] 1974/1: add INITTIME macro to collie machine structure

Kevin Hilman:
  o [ARM PATCH] 1986/1: bootpImage/ARM: add ability to run from
    non-zero address

Linus Torvalds:
  o Fix shrink_dcache_anon() LRU list accesses
  o Make the new simple_read_from_buffer() take a const src buffer
    without complaints.
  o Add infrastructure for the VFS layer to mark files seekable
  o Add pread/pwrite support bits to match the lseek bit
  o Add "nonseekable_open()" helper functions for nonseekable file
    descriptors.
  o Teach sendfile() to honour non-seekable source files
  o Mark tty's as being non-seekable, and remove the now unnecessary
    tests at read/write time.
  o Character device tape drivers are non-lseekable
  o Mark the sunrpc cache control file nonseekable, and remove the
    run-time tests for it.
  o The seq_file code already disabled pread/pwrite access, no need for
    the mtrr code to check any more.
  o Fix up a couple of drivers - notable sg - for nonseekability
  o Make sysctl pass the pos pointer around properly
  o Remove ESPIPE logic from drivers, letting the VFS layer handle it
    instead
  o ppc64: add user annotations to rtc driver
  o Fix up sound driver proc-reading interfaces
  o Revert FAT NLS changes
  o mips: fix up some straggling sysctl functions
  o Fix up drivers that access file->f_pos directly
  o read/write: pass down a copy of f_pos, not f_pos itself
  o Linux 2.6.8-rc4

Luca Tettamanti:
  o Fix JFFS2_COMPRESSION_OPTIONS in Kconfig

Martin Schwidefsky:
  o s390: core changes

Matt Porter:
  o ppc32: clean up PPC44x mmu_mapin_ram()
  o ppc32: remove pci-dma.c
  o ppc32: add PPC4xx DMA engine library

Neil Brown:
  o knfsd: fix some signed ints that should be unsigned

Nishanth Aravamudan:
  o s390: msleep vs. schedule_timeout

Patrick McHardy:
  o [PKT_SCHED]: Fix locking in __qdisc_destroy rcu-callback
  o [PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback
  o [PKT_SCHED]: remove unneccessary checks for qdisc->dev
  o [PKT_SCHED]: Remove useless noop_qdisc assignments in destroy
    functions
  o [PKT_SCHED]: Use double-linked list for dev->qdisc_list
  o [PKT_SCHED]: Fix q_idx calculation in tc_dump_qdisc

Paul Mackerras:
  o Remove ppc32 proc_rtas.c
  o Restore PPP filtering
  o ppc64: pci_dn cleanups

Peter Tiedemann:
  o s390: ctc driver changes

Roland McGrath:
  o fix /proc printing of TASK_DEAD state

Russell King:
  o [SERIAL] replace schedule_timeout() with msleep()
  o [FB] replace schedule_timeout() with msleep()
  o [ARM] Remove unnecessary CONFIG_CPU_32 preprocessor conditional
  o [ARM] Fix sparse warnings in nwfpe
  o [ARM] Eliminate io.c sparse warnings/ gcc 3.4 errors
  o [ARM] Fix sparse warnings in ds1620.c
  o [ARM] Fix nwbutton sparse warnings
  o [ARM] Fix nwflash sparse warnings
  o [ARM] Fix wdt977 sparse warnings
  o [ARM] Fix two makefile problems

Rusty Russell:
  o [NET]: Add skb_iter functions

Sam Ravnborg:
  o kbuild: Remove LANG preset in top-level Makefile

Stephen Hemminger:
  o [PKT_SCHED]: netem limit not returned correctly
  o [BRIDGE]: rmmod device while bridge is down fails
  o [PKT_SCHED]: Cache align qdisc data

Thomas Spatzier:
  o s390: qeth performance

Tom Rini:
  o ppc32: Fix 'mktree' on 64bit hosts
  o ppc32: Fix building of certain CPU types

Tony Luck:
  o Provide comand line keyword "nomca" to turn off mca processing in
    kernel

William Lee Irwin III:
  o sparc32: turbosparc flush warnings
  o sparc32: sparc32 init_idle()
  o sparc32: sun4d cpu_present_map is a cpumask_t
  o sparc32: smp_processor_id() BITFIXUP fixes
  o sparc32: reinstate smp_reschedule_irq()
  o sparc32: remove references to start_secondary()
  o sparc32: define cache_decay_ticks
  o sparc32: remove unused variable in dvma.c
  o sparc32: sun4 does not support SMP
  o sparc32: make CONFIG_SMP depend on CONFIG_BROKEN

Yanmin Zhang:
  o init.c, pgalloc.h

