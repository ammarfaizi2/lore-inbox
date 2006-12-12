Return-Path: <linux-kernel-owner+w=401wt.eu-S932188AbWLLL4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWLLL4e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 06:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWLLL4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 06:56:34 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:50285 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbWLLL4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 06:56:33 -0500
Date: Tue, 12 Dec 2006 20:55:52 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061212115552.GA8290@linux-sh.org>
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

Jamie Lenehan (4):
      sh: register rtc resources for sh775x.
      rtc: rtc-sh: fix for period rtc interrupts.
      rtc: rtc-sh: fix rtc for out-by-one for the month.
      rtc: rtc-sh: alarm support.

Paul Mundt (18):
      sh: Reworked swap cache entry encoding for SH-X2 MMU.
      sh: Shut up csum_ipv6_magic() warnings.
      sh: push-switch fixups for work_struct API damage.
      sh: Add uImage and S-rec generation support.
      sh: landisk board build fixes.
      sh: Split out atomic ops logically.
      serial: sh-sci: Shut up various sci_rxd_in() gcc4 warnings.
      sh: BUG() handling through trapa vector.
      sh: Fix get_wchan().
      sh: Fixup kernel_execve() for syscall cleanups.
      sh: Convert remaining remap_area_pages() users to ioremap_page_range().
      sh: Fixup dma_cache_sync() callers.
      sh: SH-MobileR SH7722 CPU support.
      sh: Fixup sh_bios() trap handling.
      sh: Hook up SH7722 scif ipr interrupts.
      sh: Fixup .data.page_aligned.
      sh: Fix .empty_zero_page alignment for PAGE_SIZE > 4096.
      sh: Use early_param() for earlyprintk parsing.

Stuart Menefy (1):
      sh: gcc4 symbol export fixups.

Yoshinori Sato (6):
      sh: SH-2 defconfig updates.
      sh: IPR IRQ updates for SH7619/SH7206.
      sh: Trivial build fixes for SH-2 support.
      sh: Fix Solution Engine 7619 build.
      sh: Kill off unused SE7619 I/O ops.
      sh: Fixup SH-2 BUG() trap handling.

 arch/sh/Kconfig                         |   14 
 arch/sh/Kconfig.debug                   |    3 
 arch/sh/Makefile                        |    7 
 arch/sh/boards/landisk/irq.c            |    4 
 arch/sh/boards/se/7206/irq.c            |   16 
 arch/sh/boards/se/7619/Makefile         |    2 
 arch/sh/boards/se/7619/io.c             |  102 ----
 arch/sh/boards/se/7619/setup.c          |   21 
 arch/sh/boot/Makefile                   |   40 +
 arch/sh/boot/compressed/Makefile        |    6 
 arch/sh/boot/compressed/head.S          |    3 
 arch/sh/boot/compressed/misc.c          |    3 
 arch/sh/configs/landisk_defconfig       |   85 ++-
 arch/sh/configs/se7206_defconfig        |  142 ++++--
 arch/sh/configs/se7619_defconfig        |  744 ++++++++++++++++++++++++++++++++
 arch/sh/drivers/push-switch.c           |   13 
 arch/sh/kernel/cpu/Makefile             |    1 
 arch/sh/kernel/cpu/sh2/entry.S          |   32 -
 arch/sh/kernel/cpu/sh2/setup-sh7619.c   |   41 +
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c  |   62 ++
 arch/sh/kernel/cpu/sh4/Makefile         |    9 
 arch/sh/kernel/cpu/sh4/clock-sh73180.c  |   81 ---
 arch/sh/kernel/cpu/sh4/clock-sh7770.c   |   73 ---
 arch/sh/kernel/cpu/sh4/clock-sh7780.c   |  126 -----
 arch/sh/kernel/cpu/sh4/probe.c          |    9 
 arch/sh/kernel/cpu/sh4/setup-sh73180.c  |   43 -
 arch/sh/kernel/cpu/sh4/setup-sh7343.c   |   43 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c   |   31 +
 arch/sh/kernel/cpu/sh4/setup-sh7770.c   |   53 --
 arch/sh/kernel/cpu/sh4/setup-sh7780.c   |  108 ----
 arch/sh/kernel/cpu/sh4/sq.c             |    7 
 arch/sh/kernel/cpu/sh4a/Makefile        |   19 
 arch/sh/kernel/cpu/sh4a/clock-sh73180.c |   81 +++
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c  |   99 ++++
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c  |   73 +++
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c  |  126 +++++
 arch/sh/kernel/cpu/sh4a/setup-sh73180.c |   43 +
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c  |   43 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c  |   80 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c  |   53 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c  |  108 ++++
 arch/sh/kernel/early_printk.c           |   20 
 arch/sh/kernel/entry-common.S           |   15 
 arch/sh/kernel/head.S                   |    3 
 arch/sh/kernel/process.c                |   15 
 arch/sh/kernel/setup.c                  |   41 -
 arch/sh/kernel/sh_ksyms.c               |   15 
 arch/sh/kernel/signal.c                 |    2 
 arch/sh/kernel/sys_sh.c                 |    8 
 arch/sh/kernel/traps.c                  |   35 +
 arch/sh/kernel/vmlinux.lds.S            |    2 
 arch/sh/mm/Kconfig                      |   12 
 arch/sh/mm/cache-sh4.c                  |    2 
 arch/sh/mm/init.c                       |    2 
 drivers/rtc/rtc-sh.c                    |  245 +++++++++-
 drivers/serial/sh-sci.c                 |   22 
 drivers/serial/sh-sci.h                 |   19 
 include/asm-sh/atomic-irq.h             |   71 +++
 include/asm-sh/atomic-llsc.h            |  107 ++++
 include/asm-sh/atomic.h                 |  153 ------
 include/asm-sh/bug.h                    |   53 +-
 include/asm-sh/bugs.h                   |   12 
 include/asm-sh/checksum.h               |   69 +-
 include/asm-sh/cpu-sh4/cache.h          |    2 
 include/asm-sh/cpu-sh4/freq.h           |    2 
 include/asm-sh/dma-mapping.h            |   10 
 include/asm-sh/irq.h                    |    5 
 include/asm-sh/pgtable.h                |   47 +-
 include/asm-sh/processor.h              |    8 
 include/asm-sh/push-switch.h            |    3 
 70 files changed, 2565 insertions(+), 1084 deletions(-)
