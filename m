Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUFSXqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUFSXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUFSXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:46:15 -0400
Received: from outbound01.telus.net ([199.185.220.220]:60818 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S263879AbUFSXqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:46:13 -0400
Subject: Compile time error, no vmlinuz (2.6.7-bk2)
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087689095.14733.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Jun 2004 17:51:35 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently built 2.6.7-bk2 (or at least tried to).  It refuses to
create the compressed kernel image (the system map and ramdisk image
build though).  I suspect the problem springs from the compile-time
error message I get when I build:

  CC      security/dummy.o
  CC      security/selinux/avc.o
  CC      security/selinux/hooks.o
security/selinux/hooks.c:4130: error: `selinux_netlink_send' undeclared
here (not in a function)
security/selinux/hooks.c:4130: error: initializer element is not
constant
security/selinux/hooks.c:4130: error: (near initialization for
`selinux_ops.netlink_send')
security/selinux/hooks.c:4131: error: `selinux_netlink_recv' undeclared
here (not in a function)
security/selinux/hooks.c:4131: error: initializer element is not
constant
security/selinux/hooks.c:4131: error: (near initialization for
`selinux_ops.netlink_recv')
make[2]: *** [security/selinux/hooks.o] Error 1
make[1]: *** [security/selinux] Error 2
make: *** [security] Error 2
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      security/selinux/hooks.o
security/selinux/hooks.c:4130: error: `selinux_netlink_send' undeclared
here (not in a function)
security/selinux/hooks.c:4130: error: initializer element is not
constant
security/selinux/hooks.c:4130: error: (near initialization for
`selinux_ops.netlink_send')
security/selinux/hooks.c:4131: error: `selinux_netlink_recv' undeclared
here (not in a function)
security/selinux/hooks.c:4131: error: initializer element is not
constant
security/selinux/hooks.c:4131: error: (near initialization for
`selinux_ops.netlink_recv')
make[2]: *** [security/selinux/hooks.o] Error 1
make[1]: *** [security/selinux] Error 2
make: *** [security] Error 2
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  arch/i386/kernel/msr.o
  CC [M]  arch/i386/kernel/cpuid.o
  CC [M]  fs/binfmt_aout.o

I grokked lkml a bit for a patch but found none.  hooks.c seems to have
selinux_netlink_send defined at line 3366 and selinux_netlink_recv seems
to be defined at line 3381 and I didn't see an #ifdef/#endif compiler
directive wrapped around them.  I'm compiling SELinux into the kernel,
but haven't enabled it at boot time on my system (yet).  2.6.7 builds
ok.

Please mail me directly as I'm not on the list, TIA,

Bob

