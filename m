Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUBBGZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUBBGZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:25:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:14011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265632AbUBBGZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:25:15 -0500
Date: Sun, 1 Feb 2004 22:22:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] add syscalls.h
Message-Id: <20040201222254.39bc5b39.rddunlap@osdl.org>
In-Reply-To: <20040130163547.2285457b.rddunlap@osdl.org>
References: <20040130163547.2285457b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Date: Tue, 27 Jan 2004 16:46:15 -0800
| From: Andrew Morton <akpm@osdl.org>
| Subject: Re: NGROUPS 2.6.2rc2
| 
| 
[snip]
| rant.  We have soooo many syscalls declared in .c files.  We had a bug due
| to this a while back.  Problem is, we have no anointed header in which to
| place them.  include/linux/syscalls.h would suit.  And unistd.h for
| arch-specific syscalls.  But that's not appropriate to this patch.


I am working on this.  Is anyone else?

I have parts 2.6.1-non-arch* ready for testing, I believe,
except that it will likely require more changes/additions.

I have begun on 2.6.1-arch* but still have a ways to go.

Caveats:
I have only patched 2.6.1.  I will update patches for 2.6.2-rc-current.
I have only tested by building allmodconfig on P4.
Have not test-booted yet.

Patch files for 2.6.1 are here:


http://developer.osdl.org/rddunlap/syscalls/2.6.1-arch-syscalls.diff
 drivers/macintosh/via-pmu.c |    2
 fs/compat.c                 |   14 ---
 include/linux/syscalls.h    |  173 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h      |    1
 init/do_mounts.h            |   15 ---
 init/do_mounts_devfs.c      |    6 -
 init/initramfs.c            |   12 ---
 kernel/compat.c             |   31 -------
 kernel/power/disk.c         |    3
 kernel/power/swsusp.c       |    3
 kernel/sysctl.c             |    2
 kernel/uid16.c              |   13 ---
 net/compat.c                |   23 -----
 13 files changed, 184 insertions(+), 114 deletions(-)


http://developer.osdl.org/rddunlap/syscalls/2.6.1-non-arch-syscalls.diff
 arch/alpha/kernel/osf_sys.c         |    3 --
 arch/ia64/ia32/ia32_ioctl.c         |    3 --
 arch/ia64/ia32/sys_ia32.c           |   26 ---------------------
 arch/mips/kernel/ioctl32.c          |    3 --
 arch/mips/kernel/irixioctl.c        |    4 ---
 arch/mips/kernel/linux32.c          |   13 ----------
 arch/mips/kernel/sysirix.c          |   15 ------------
 arch/parisc/hpux/ioctl.c            |    3 --
 arch/parisc/kernel/sys_parisc.c     |   14 -----------
 arch/parisc/kernel/sys_parisc32.c   |    7 -----
 arch/ppc64/kernel/ppc_ksyms.c       |    2 -
 arch/ppc64/kernel/sys_ppc32.c       |   44 +-----------------------------------
 arch/s390/kernel/compat_ioctl.c     |    3 --
 arch/s390/kernel/compat_linux.c     |   28 ----------------------
 arch/s390/kernel/sys_s390.c         |    3 --
 arch/sparc/kernel/sunos_ioctl.c     |    2 -
 arch/sparc/kernel/sys_sunos.c       |    5 ----
 arch/sparc64/kernel/sparc64_ksyms.c |    2 -
 arch/sparc64/kernel/sunos_ioctl32.c |    3 --
 arch/sparc64/kernel/sys_sparc.c     |    3 --
 arch/sparc64/kernel/sys_sparc32.c   |   25 --------------------
 arch/sparc64/kernel/sys_sunos32.c   |    3 --
 arch/sparc64/solaris/ioctl.c        |    3 --
 arch/sparc64/solaris/socksys.c      |    3 --
 arch/sparc64/solaris/timod.c        |    2 -
 arch/x86_64/ia32/ia32_ioctl.c       |    3 --
 arch/x86_64/ia32/sys_ia32.c         |   27 ----------------------
 arch/x86_64/kernel/x8664_ksyms.c    |    3 --
 include/asm-ia64/unistd.h           |    5 ++++
 include/asm-mips/unistd.h           |    5 ++++
 include/asm-parisc/unistd.h         |    4 +++
 include/asm-ppc/unistd.h            |    4 +++
 include/asm-ppc64/unistd.h          |    4 +++
 include/asm-sparc/unistd.h          |    5 ++++
 include/asm-sparc64/unistd.h        |    5 ++++
 include/asm-v850/unistd.h           |    4 +++
 include/asm-x86_64/unistd.h         |    4 +++
 37 files changed, 67 insertions(+), 228 deletions(-)


Do these look OK, as far as they go?  or am I way off?

--
~Randy


Haven't addressed these yet:

sys_brk
sys_wait*
sys_setuid/gid etc.
sys_init/delete_module
sys_ni_syscall
sys_get/setpriority
signal-related syscalls
rt-related syscalls
sys_execve
sys_ptrace
sys_newuname
schedule-related syscalls
sys_fadvise64_64
sys_nfsservctl
sys_kill
sys_setgroups
sys_sethost/domainname
sys_umask
sys_modify_ldt
