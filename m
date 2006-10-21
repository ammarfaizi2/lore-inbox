Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993141AbWJUQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993141AbWJUQzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993140AbWJUQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:29 -0400
Received: from ns.suse.de ([195.135.220.2]:39836 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993136AbWJUQv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:26 -0400
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: Please pull x86 tree
Date: Sat, 21 Oct 2006 18:44:06 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211844.07051.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please pull from

  git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

These are all accumulated bug fixes for x86-64 and i386 and should
be all pretty safe.

The only thing that isn't a clear bug fix is the dwarf2 unwinder
speedup -- i'm including that on popular demand because it fixes
a serious performance regression with lockdep.

There are also some reverts included where it turned out that
the change wasn't that great an idea.

Andi Kleen:
      i386: Update defconfig
      x86: Use -maccumulate-outgoing-args
      x86-64: Revert interrupt backlink changes
      i386: Disable nmi watchdog on all ThinkPads
      x86: Revert new unwind kernel stack termination
      x86-64: Revert timer routing behaviour back to 2.6.16 state

Andrew Morton:
      i386: fix .cfi_signal_frame copy-n-paste error

bibo,mao:
      x86-64: x86_64 add NX mask for PTE entry

Corey Minyard:
      x86-64: Fix for arch/x86_64/pci/Makefile CFLAGS

Eric W. Biederman:
      x86-64: Use irq_domain in ioapic_retrigger_irq
      x86-64: Put more than one cpu in TARGET_CPUS

Jan Beulich:
      x86-64: Speed up dwarf2 unwinder
      x86-64: Fix ENOSYS in system call tracing

Jeremy Fitzhardinge:
      i386: Fix fake return address

keith mannthey:
      x86-64: x86_64 hot-add memory srat.c fix

Vivek Goyal:
      x86-64: fix page align in e820 allocator
      x86-64: Overlapping program headers in physical addr space fix

Yinghai Lu:
      x86-64: typo in __assign_irq_vector when updating pos for vector and offset

 Makefile                          |    1 
 arch/i386/Makefile                |    8 +
 arch/i386/defconfig               |   30 ++-
 arch/i386/kernel/head.S           |    2 
 arch/i386/kernel/nmi.c            |   10 +
 arch/i386/kernel/process.c        |    6 -
 arch/x86_64/Makefile              |    4 
 arch/x86_64/kernel/e820.c         |   14 +-
 arch/x86_64/kernel/early-quirks.c |    9 +
 arch/x86_64/kernel/entry.S        |   10 -
 arch/x86_64/kernel/genapic_flat.c |    2 
 arch/x86_64/kernel/io_apic.c      |   15 +-
 arch/x86_64/kernel/vmlinux.lds.S  |    3 
 arch/x86_64/mm/srat.c             |    4 
 arch/x86_64/pci/Makefile          |    2 
 drivers/firmware/dmi_scan.c       |   20 ++
 include/asm-generic/vmlinux.lds.h |   16 ++
 include/asm-x86_64/pgtable.h      |    1 
 include/asm-x86_64/proto.h        |    2 
 include/linux/dmi.h               |    2 
 include/linux/unwind.h            |    2 
 init/main.c                       |    1 
 kernel/unwind.c                   |  318 ++++++++++++++++++++++++++++++++-----
 23 files changed, 385 insertions(+), 97 deletions(-)
