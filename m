Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266939AbUBEWe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266977AbUBEWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:34:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:14305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266939AbUBEWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:34:46 -0500
Date: Thu, 5 Feb 2004 14:28:16 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] add syscalls.h (ver. 5)
Message-Id: <20040205142816.75658fd5.rddunlap@osdl.org>
In-Reply-To: <20040203215605.497b3af3.rddunlap@osdl.org>
References: <20040203215605.497b3af3.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Now builds on i386 (P4) and ia64.
| Booted on i386/P4.


If anyone could build a 2.6.2 kernel plus this patch on
x86_64 or ppc or ppc64 or sparc64 etc., and send me any
build errors or warnings (that this patch causes), I'll
fix them up.

I have run LTP-current on the patched x86 kernel with almost
no problems.  :)
There does seem to be some problem with LTP's fcntl15 test,
but this problem happens on my test machine with or without
this patch applied.


Patch is now updated for 2.6.2.

http://developer.osdl.org/rddunlap/syscalls/2.6.2-syscalls-v5.diff
(98 KB)

diffstat totals:
 58 files changed, 554 insertions(+), 454 deletions(-)


Comments?

Thanks,
--
~Randy


full diffstat:
 arch/alpha/kernel/osf_sys.c         |    3 
 arch/ia64/ia32/ia32_ioctl.c         |    3 
 arch/ia64/ia32/sys_ia32.c           |   28 --
 arch/mips/kernel/ioctl32.c          |    3 
 arch/mips/kernel/irixioctl.c        |    4 
 arch/mips/kernel/linux32.c          |   13 -
 arch/mips/kernel/sysirix.c          |   15 -
 arch/parisc/hpux/ioctl.c            |    3 
 arch/parisc/hpux/sys_hpux.c         |    4 
 arch/parisc/kernel/sys_parisc.c     |   14 -
 arch/parisc/kernel/sys_parisc32.c   |    7 
 arch/ppc64/kernel/ppc_ksyms.c       |    2 
 arch/ppc64/kernel/sys_ppc32.c       |   55 ----
 arch/s390/kernel/compat_linux.c     |   28 --
 arch/s390/kernel/compat_linux.h     |    1 
 arch/s390/kernel/sys_s390.c         |    3 
 arch/sparc/kernel/sunos_ioctl.c     |    2 
 arch/sparc/kernel/sys_sunos.c       |    5 
 arch/sparc64/kernel/sparc64_ksyms.c |    2 
 arch/sparc64/kernel/sunos_ioctl32.c |    3 
 arch/sparc64/kernel/sys_sparc.c     |    3 
 arch/sparc64/kernel/sys_sparc32.c   |   39 ---
 arch/sparc64/kernel/sys_sunos32.c   |    3 
 arch/sparc64/solaris/ioctl.c        |    3 
 arch/sparc64/solaris/socksys.c      |    3 
 arch/sparc64/solaris/timod.c        |    2 
 arch/x86_64/ia32/ia32_ioctl.c       |    3 
 arch/x86_64/ia32/sys_ia32.c         |   27 --
 arch/x86_64/kernel/x8664_ksyms.c    |    3 
 drivers/macintosh/via-pmu.c         |    2 
 fs/compat.c                         |   14 -
 include/asm-alpha/unistd.h          |   11 
 include/asm-arm/unistd.h            |    9 
 include/asm-arm26/unistd.h          |   14 -
 include/asm-i386/unistd.h           |    1 
 include/asm-ia64/unistd.h           |   18 -
 include/asm-mips/unistd.h           |    5 
 include/asm-parisc/unistd.h         |   16 -
 include/asm-ppc/unistd.h            |    4 
 include/asm-ppc64/unistd.h          |    4 
 include/asm-s390/unistd.h           |    3 
 include/asm-sparc/unistd.h          |    5 
 include/asm-sparc64/unistd.h        |    5 
 include/asm-um/unistd.h             |   15 -
 include/asm-v850/unistd.h           |    4 
 include/asm-x86_64/unistd.h         |   21 -
 include/linux/syscalls.h            |  458 ++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h              |    1 
 init/do_mounts.h                    |   15 -
 init/do_mounts_devfs.c              |    9 
 init/initramfs.c                    |   12 
 kernel/compat.c                     |   31 --
 kernel/panic.c                      |    3 
 kernel/power/disk.c                 |    3 
 kernel/power/swsusp.c               |    3 
 kernel/sysctl.c                     |    2 
 kernel/uid16.c                      |   13 -
 net/compat.c                        |   23 -
 58 files changed, 554 insertions(+), 454 deletions(-)
---
