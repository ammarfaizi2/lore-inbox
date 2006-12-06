Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759814AbWLFDWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759814AbWLFDWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 22:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759820AbWLFDWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 22:22:49 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:44909 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759814AbWLFDWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 22:22:49 -0500
Date: Wed, 6 Dec 2006 12:22:23 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061206032223.GB5101@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Jamie Lenehan (1):
      sh: sh775x/titan fixes for irq header changes.

Mark Glaisher (1):
      sh: dma-api channel capability extensions.

Paul Mundt (29):
      sh: SE7206 build fixes.
      sh: Fixup entry-common path breakage for SH-3.
      sh: Configurable timer IRQ.
      sh: Drop CPU subtype IRQ headers.
      sh: Hook SH7785 in to the build system.
      sh: Preliminary support for SH-X2 MMU.
      sh: p3map_sem sem2mutex conversion.
      sh: Explicit endian selection support.
      sh: generic push-switch framework.
      sh: R7780RP push-switch support.
      sh: dma-sysfs fixes.
      sh: Make dma-isa depend on ISA_DMA_API.
      sh: Drop name overload in dma-sh.
      sh: Fixup 4K irq stacks.
      sh: Fixup various PAGE_SIZE == 4096 assumptions.
      sh: More flexible + SH7780 earlyprintk SCIF support.
      sh: Fix store queue bitmap end.
      sh: Get the PGD right in oops case with 64-bit PTEs.
      sh: Turn off IRQs around get_timer_offset() calls.
      sh: Clock framework tidying.
      sh: dyntick infrastructure.
      sh: Fixup movli.l/movco.l atomic ops for gcc4.
      sh: stacktrace/lockdep/irqflags tracing support.
      sh: platform_pata support for R7780RP
      sh: show held locks in stack trace with lockdep.
      sh: set KBUILD_IMAGE to something sensible.
      sh: Fixup pte_mkhuge() build failure.
      sh: compile fixes for header cleanup.
      sh: update r7780rp defconfig.

Stuart Menefy (7):
      sh: gcc4 support.
      sh: Set up correct siginfo structures for page faults.
      sh: Use MMU.TTB register as pointer to current pgd.
      sh: pmd rework.
      sh: TLB miss fast-path optimizations.
      sh: KSTK_EIP/KSTK_ESP consistency.
      sh: Fix syscall tracing ordering.

Yoshinori Sato (5):
      sh: Add support for SH7206 and SH7619 CPU subtypes.
      sh: Wire up division and address error exceptions on SH-2A.
      sh: Exception vector rework and SH-2/SH-2A support.
      sh: Add SH-2A platform headers.
      sh: Add support for Solution Engine 7206 and 7619 boards.

 arch/sh/Kconfig                         |  100 +++
 arch/sh/Kconfig.debug                   |   22 
 arch/sh/Makefile                        |   26 
 arch/sh/boards/renesas/r7780rp/Makefile |    4 
 arch/sh/boards/renesas/r7780rp/irq.c    |    1 
 arch/sh/boards/renesas/r7780rp/psw.c    |  122 ++++
 arch/sh/boards/renesas/r7780rp/setup.c  |   29 +
 arch/sh/boards/se/7206/Makefile         |    7 
 arch/sh/boards/se/7206/io.c             |  123 ++++
 arch/sh/boards/se/7206/irq.c            |  139 +++++
 arch/sh/boards/se/7206/led.c            |   57 ++
 arch/sh/boards/se/7206/setup.c          |   79 ++
 arch/sh/boards/se/7619/Makefile         |    5 
 arch/sh/boards/se/7619/io.c             |  102 +++
 arch/sh/boards/se/7619/setup.c          |   43 +
 arch/sh/boards/titan/setup.c            |   27 -
 arch/sh/boot/compressed/misc.c          |    3 
 arch/sh/configs/r7780rp_defconfig       |   69 +-
 arch/sh/configs/se7206_defconfig        |  826 +++++++++++++++++++++++++++++++
 arch/sh/drivers/Kconfig                 |    9 
 arch/sh/drivers/Makefile                |    2 
 arch/sh/drivers/dma/Makefile            |    4 
 arch/sh/drivers/dma/dma-api.c           |  274 +++++++---
 arch/sh/drivers/dma/dma-sh.c            |    9 
 arch/sh/drivers/dma/dma-sysfs.c         |   23 
 arch/sh/drivers/pci/ops-titan.c         |   24 
 arch/sh/drivers/pci/pci-sh7780.c        |   14 
 arch/sh/drivers/push-switch.c           |  138 +++++
 arch/sh/kernel/Makefile                 |    3 
 arch/sh/kernel/cpu/Makefile             |   11 
 arch/sh/kernel/cpu/clock.c              |   27 -
 arch/sh/kernel/cpu/init.c               |    2 
 arch/sh/kernel/cpu/irq/Makefile         |    3 
 arch/sh/kernel/cpu/irq/imask.c          |    5 
 arch/sh/kernel/cpu/irq/intc2.c          |   25 
 arch/sh/kernel/cpu/irq/ipr.c            |   93 ---
 arch/sh/kernel/cpu/sh2/Makefile         |    3 
 arch/sh/kernel/cpu/sh2/clock-sh7619.c   |   81 +++
 arch/sh/kernel/cpu/sh2/entry.S          |  341 ++++++++++++
 arch/sh/kernel/cpu/sh2/ex.S             |   46 +
 arch/sh/kernel/cpu/sh2/probe.c          |   16 
 arch/sh/kernel/cpu/sh2/setup-sh7619.c   |   53 ++
 arch/sh/kernel/cpu/sh2a/Makefile        |   10 
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c  |   85 +++
 arch/sh/kernel/cpu/sh2a/probe.c         |   39 +
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c  |   58 ++
 arch/sh/kernel/cpu/sh3/Makefile         |    2 
 arch/sh/kernel/cpu/sh3/clock-sh7709.c   |    2 
 arch/sh/kernel/cpu/sh3/entry.S          |  693 ++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4/Makefile         |    3 
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c  |    4 
 arch/sh/kernel/cpu/sh4/clock-sh7780.c   |    2 
 arch/sh/kernel/cpu/sh4/fpu.c            |   25 
 arch/sh/kernel/cpu/sh4/probe.c          |   19 
 arch/sh/kernel/cpu/sh4/setup-sh7750.c   |   70 ++
 arch/sh/kernel/cpu/sh4/setup-sh7780.c   |   36 -
 arch/sh/kernel/cpu/sh4/sq.c             |   11 
 arch/sh/kernel/early_printk.c           |   44 -
 arch/sh/kernel/entry-common.S           |  433 ++++++++++++++++
 arch/sh/kernel/entry.S                  |  843 --------------------------------
 arch/sh/kernel/head.S                   |   17 
 arch/sh/kernel/irq.c                    |   55 +-
 arch/sh/kernel/process.c                |   32 -
 arch/sh/kernel/relocate_kernel.S        |   14 
 arch/sh/kernel/setup.c                  |    2 
 arch/sh/kernel/sh_ksyms.c               |    2 
 arch/sh/kernel/signal.c                 |   36 -
 arch/sh/kernel/stacktrace.c             |   43 +
 arch/sh/kernel/sys_sh.c                 |    7 
 arch/sh/kernel/time.c                   |  139 +++++
 arch/sh/kernel/timers/Makefile          |    2 
 arch/sh/kernel/timers/timer-cmt.c       |  196 +++++++
 arch/sh/kernel/timers/timer-mtu2.c      |  200 +++++++
 arch/sh/kernel/timers/timer-tmu.c       |   13 
 arch/sh/kernel/timers/timer.c           |    6 
 arch/sh/kernel/traps.c                  |  200 +++++--
 arch/sh/mm/Kconfig                      |   77 ++
 arch/sh/mm/cache-sh2.c                  |   69 +-
 arch/sh/mm/cache-sh4.c                  |   18 
 arch/sh/mm/clear_page.S                 |   18 
 arch/sh/mm/copy_page.S                  |   16 
 arch/sh/mm/fault.c                      |  161 ++----
 arch/sh/mm/init.c                       |   45 -
 arch/sh/mm/ioremap.c                    |    4 
 arch/sh/mm/pg-dma.c                     |    2 
 arch/sh/mm/pg-sh4.c                     |   35 -
 arch/sh/tools/mach-types                |    2 
 drivers/serial/sh-sci.c                 |    6 
 drivers/serial/sh-sci.h                 |   37 +
 include/asm-sh/atomic.h                 |   48 -
 include/asm-sh/bugs.h                   |    8 
 include/asm-sh/clock.h                  |   12 
 include/asm-sh/cpu-sh2/cache.h          |   22 
 include/asm-sh/cpu-sh2/freq.h           |   18 
 include/asm-sh/cpu-sh2/mmu_context.h    |   16 
 include/asm-sh/cpu-sh2/timer.h          |    6 
 include/asm-sh/cpu-sh2a/addrspace.h     |    1 
 include/asm-sh/cpu-sh2a/cache.h         |   39 +
 include/asm-sh/cpu-sh2a/cacheflush.h    |    1 
 include/asm-sh/cpu-sh2a/dma.h           |    1 
 include/asm-sh/cpu-sh2a/freq.h          |   18 
 include/asm-sh/cpu-sh2a/mmu_context.h   |    1 
 include/asm-sh/cpu-sh2a/timer.h         |    1 
 include/asm-sh/cpu-sh2a/ubc.h           |    1 
 include/asm-sh/cpu-sh2a/watchdog.h      |    1 
 include/asm-sh/dma.h                    |   40 +
 include/asm-sh/elf.h                    |    2 
 include/asm-sh/entry-macros.S           |   33 +
 include/asm-sh/irq-sh73180.h            |  314 -----------
 include/asm-sh/irq-sh7343.h             |  317 ------------
 include/asm-sh/irq-sh7780.h             |  311 -----------
 include/asm-sh/irq.h                    |  620 +----------------------
 include/asm-sh/irqflags.h               |  123 ++++
 include/asm-sh/mmu_context.h            |   44 -
 include/asm-sh/page.h                   |   35 +
 include/asm-sh/pgalloc.h                |   20 
 include/asm-sh/pgtable-2level.h         |   70 --
 include/asm-sh/pgtable.h                |  371 +++++++++++---
 include/asm-sh/processor.h              |   24 
 include/asm-sh/push-switch.h            |   28 +
 include/asm-sh/rwsem.h                  |   27 -
 include/asm-sh/se7206.h                 |   13 
 include/asm-sh/system.h                 |  101 ---
 include/asm-sh/thread_info.h            |    8 
 include/asm-sh/timer.h                  |   23 
 include/asm-sh/titan.h                  |   32 -
 include/asm-sh/unistd.h                 |   32 -
 127 files changed, 6145 insertions(+), 3460 deletions(-)
