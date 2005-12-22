Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVLVKP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVLVKP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLVKP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:15:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35783 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750740AbVLVKP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:15:26 -0500
Date: Thu, 22 Dec 2005 10:15:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.15-rc6-bird1
Message-ID: <20051222101523.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here it comes, after a long delay...  I'm mostly done with
moving the tree to use of git (at least internally), so with any
luck the next revision will be available as a git tree on kernel.org.
For now, it's just a patch.

URL: ftp://ftp.linux.org.uk/pub/people/viro/patch-2.5.16-bird1.bz2

URL of splitup: same place, bird-mbox.  It's stored as git-format-patch
output; i.e. an mbox consisting of individual changesets.

Changes since the last time: a lot.  Moreover, a lot of stuff had come
_through_ the tree and got merged upstream in the meanwhile.  The list
of targets remains the same, ppc and ppc64 had migrated to ARCH=powerpc.
The rest of ppc variants remain on the ARCH=ppc; they still don't build
on ARCH=powerpc.

Coming soon: mips variants and frv added to tracked targets list.  That's
nearly finished, the main problem with frv is that some bits of gcc are
_still_ not in mainline ("U" constraint support).

It's an open season on endianness annotations; feel free to send such
stuff, this time update latency will stay tolerable, honest...

There will be a separate posting on the build setup; there had been a lot
of improvements since the last time, most notable ones being
	* integration of ccache
	* finally, a tolerable support of build clusters (basically,
source trees on build boxen are cloned from a branch in master git repository;
targets are split among the build boxen, any fixes done in a source tree
on a build box are simply pushed to master and then pulled to other build
boxen; on master they are cherry-picked to topic branches; from time to time
upstream in pulled to master; when needed, topic branches are rebased).

I've moved FC4 build boxen to recent binutils and I would like to spend
a few pages on expression of my opinion on that code and changes in it.
However, l-k is supposed to be more or less printable, so let's just
say that doing an as(1) replacement from scratch becomes more and more
attractive ;-/  Never would've thought that I would agree with Ulrich...

Not-so-short log:
Al Viro:
[infrastructure]
      allmodconfig-with-subset support
      disabling DEBUG_INFO for test builds
[task_thread_info series]
      missing helper - task_stack_page()
      alpha: task_thread_info()
      alpha: task_stack_page()
      alpha: task_pt_regs()
      amd64: task_thread_info()
      amd64: task_pt_regs()
      amd64: task_stack_page()
      i386: task_thread_info()
      i386: use task_pt_regs()
      i386: task_stack_page()
      sparc64: task_thread_info()
      sparc64: task_stack_page()
      sparc64: task_pt_regs()
      sh: task_pt_regs()
      sh: task_thread_info()
      sh: task_stack_page()
      sparc: task_thread_info()
      sparc: task_stack_page()
      uml: task_thread_info()
      uml: task_stack_page()
      s390: task_pt_regs()
      s390: task_stack_page()
      xtensa: task_pt_regs(), task_stack_page()
      v850: task_stack_page(), task_pt_regs()
      m32r: task_pt_regs(), task_stack_page(), task_thread_info()
      frv: task_thread_info(), task_stack_page()
      m68k: task_stack_page()
      m6knommu: task_stack_page()
      parisc: task_stack_page(), task_thread_info()
      h8300: task_stack_page()
      arm: task_thread_info()
      arm: task_pt_regs()
      arm: end_of_stack()
      arm: task_stack_page()
      arm26: task_thread_info()
      arm26: task_pt_regs()
      arm26: task_stack_page()
      sh64: task_stack_page()
      powerpc: task_thread_info()
      powerpc: task_stack_page()
      cris: task_pt_regs()
      cris: fix KSTK_EIP
      cris: task_thread_info()
      ia64: task_thread_info()
      ia64: task_pt_regs()
      mips: namespace pollution: dump_regs() -> elf_dump_regs()
      mips: task_pt_regs()
      mips: task_thread_info()
      mips: task_stack_page()
      death of get_thread_info/put_thread_info
[endianness]
      more sunrpc endianness annotations
[m32r]
      m32r: Kconfig fix (m32r smc91x)
      m32r: play it safer with ld24 arguments (64bit issues in cross-as(1))
      m32r: more binutils fallout
[net]
      arcnet probing cleanups and fixes
      ibm_emac sparse annotations
      appletalk/cops.h: missing const in struct ltfirmware
      macsonic.c: missed s/driver_unregister/platform_driver_unregister/
      missing include of asm/irq.h in drivers/net
      bogus include of linux/irq.h in 7990.c
      wrong ifdefs in 82596.c
[uml]
      uml: kills symlinks in arch/um/sys-*
      uml: kills unmap magic
      uml: no need to add the same file twice to MRPROPER_FILES
      uml: kconfig sanitized around drivers/net
      uml: misc sparse annotations
      uml: __user annotations (hppfs)
      uml: removed assignments to unused variables in arch/um/os-Linux/Makefile
[misc]
      B2 rio
      B12 broken-on-big-endian Kconfig fix (BROKEN_ON_BIG_ENDIAN)
      C4 asm-delay.h
      C5 atyfb-sparc
      C6 sparc-video
      B23 8390 fixes - part 1
      C15 mv643xx_eth ifdefs
      B33 8390 fixes - part 2 (m68k)
      Fix misspellings of ARCH_S390 in Kconfig
      S54 drivers/s390 misc sparse annotations
      mips: namespace pollution - mem_... -> __mem_... in io.h
      at76c651.c: __ilog2() exists not only on powerpc, mips also has it.
      remove bogus asm/bug.h includes.
      arm: fix dependencies for MTD_XIP
      V0 MEMORY_HOTPLUG
      V1 KEXEC on powerpc 6xx is broken
      drive_info removal outside of arch/i386
[m68k]
      m68k: compile fix - hardirq checks were in wrong place
      m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
      m68k: namespace pollution fix (custom->amiga_custom)
      m68k: switch mac/misc.c to direct use of appropriate cuda/pmu/maciisi requests
      m68k: dumb typo in atyfb
      m68k: oktagon makefile fix
      m68k: Kconfig fix (mac vs. FONTS)
      m68k: isa_{type,sex} should be exported
      m68k: fix macro syntax to make current binutils happy
      m68k: more workarounds for recent binutils idiocy
      m68k: static vs. extern in scc.h
      m68k: static vs. extern in sun3ints.h
      m68k: static vs. extern in amigaints.h
      m68k: memory input should be an lvalue (mac/misc.c)
      m68k: broken constraints on mulu.l
      m68k: bogus function argument types (sun3_pgtable.h)
      m68k: lvalues abuse in mac8390
      m68k: lvalues abuse in dmasound
      m68k: compile fixes for dmasound (static vs. extern)
      m68k: basic iomem annotations
      m68k: basic __user annotations
      m68k: signal __user annotations
      m68k: rtc __user annotations
      m68k: syscalls __user annotation
      m68k: checksum __user annotations
      m68k: amiflop __user annotations
      m68k: ataflop __user annotations, NULL noise removal
      m68k: amiserial __user annotations
      m68k: dsp56k __user annotations
      m68k: amifb __user annotations
      m68k: zorro __user annotations
      m68k: drivers/scsi/mac53c94.c __iomem annotations
      m68k: dmasound __user annotations
      m68k: NULL noise removal
      m68k: cast in strnlen switched to unsigned long

Alexey Dobriyan:
      Minimal patch to remove junk endianness warnings from net/sunrpc/*.
      lockd endianness annotations
      nfs endianness annotations
      cdrom: add endianness annotations

Roman Zippel:
      m68k: dmasound_paula.c lvalues abuse (from m68k CVS)
