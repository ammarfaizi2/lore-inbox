Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSG2WAF>; Mon, 29 Jul 2002 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSG2WAF>; Mon, 29 Jul 2002 18:00:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52690 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318152AbSG2WAE>; Mon, 29 Jul 2002 18:00:04 -0400
Date: Mon, 29 Jul 2002 23:03:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: 9 vmacct patches to follow
Message-ID: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Alan, Robert and Andrew agreed that the VM overcommit accounting feature
should go into 2.5 first as is, then my fixes to it could follow after.
You now have it in your BK tree, so I'm now mailing you my fixes (many
thanks to DavidW for his invaluable kernel.org webpage: patches apply
to your current tree up to and including ChangeSet 1.523).

As Andrew noted, nothing crashes without these fixes; but some arches
and configs won't build without the last (vmacct 9/9), since a flag was
added to do_munmap but not all sources updated.  I've made that patch
the last (not because I'm deluded into thinking that will coerce you
into applying the rest, but) because I'm uncertain whether you will want
to fix the build with my patch (which removes the added flag again, with
extra code in the one rare mremap path which needs to suppress accting),
or instead update these 11 sources with the additional acct flag:

arch/ia64/kernel/perfmon.c
arch/ia64/kernel/sys_ia64.c
arch/mips/kernel/sysirix.c
arch/s390x/kernel/linux32.c
arch/sparc/kernel/sys_sunos.c
arch/sparc64/kernel/sys_sparc.c
arch/sparc64/kernel/sys_sunos32.c
arch/x86_64/ia32/sys_ia32.c
drivers/char/drm/i810_dma.c
drivers/char/drm/i830_dma.c
drivers/sgi/char/shmiq.c

The 9 patches coming are:

vmacct1 shmem_file_write rounding VM_ACCT
vmacct2 SHMEM_MAX_BYTES overflow checking
vmacct3 mremap MAP_NORESERVE not in flags
vmacct4 mmap MAP_NORESERVE not in vm_flags
vmacct5 remove unhelpful vm_unacct_vma
vmacct6 fix shared and private accounting
vmacct7 update overcommit doc and comment
vmacct8 shmem_file_setup when MAP_NORESERVE 
vmacct9 remove acct arg from do_munmap

 Documentation/vm/overcommit-accounting |   14 ++---
 include/linux/mm.h                     |    4 -
 include/linux/shmem_fs.h               |    2 
 ipc/shm.c                              |    4 -
 kernel/fork.c                          |    5 -
 mm/memory.c                            |   19 ++----
 mm/mmap.c                              |   57 ++++++++++----------
 mm/mprotect.c                          |   27 ++++++---
 mm/mremap.c                            |   35 ++++++++----
 mm/shmem.c                             |   92 +++++++++++++++++++--------------
 10 files changed, 142 insertions, 117 deletions

Please apply!
Hugh

