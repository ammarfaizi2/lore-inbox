Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVJ2Ipz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVJ2Ipz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJ2Ipy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:45:54 -0400
Received: from ns1.enidan.ch ([217.8.216.11]:7099 "EHLO mail.local.net")
	by vger.kernel.org with ESMTP id S1750826AbVJ2Ipy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:45:54 -0400
Message-ID: <43633721.9010001@computer.org>
Date: Sat, 29 Oct 2005 10:47:29 +0200
From: Per Jessen <per@computer.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: building 2.4.31 for a non-smp system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm upgrading a box from 2.4.23 to .31, but I'm seeing lots of errors
along these lines:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.31/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=tty_ioctl
-DEXPORT_SYMTAB -c tty_ioctl.c
In file included from /usr/src/linux-2.4.31/include/linux
modversions.h:177,
                 from /usr/src/linux-2.4.31/include/linux/module.h:22,
                 from tty_ioctl.c:21:
/usr/src/linux-2.4.31/include/linux/modules/ksyms.ver:576:1: warning:
"del_timer_sync" redefined
In file included from /usr/src/linux-2.4.31/include/linux
ext3_fs_sb.h:20,
                 from /usr/src/linux-2.4.31/include/linux/fs.h:715,
                 from /usr/src/linux-2.4.31/include/linux
capability.h:17,
                 from /usr/src/linux-2.4.31/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.31/include/linux/sched.h:9,
                 from tty_ioctl.c:14:
/usr/src/linux-2.4.31/include/linux/timer.h:30:1: warning: this is the
location of the previous definition
In file included from /usr/src/linux-2.4.31/include/linux
modversions.h:177,
                 from /usr/src/linux-2.4.31/include/linux/module.h:22,
                 from tty_ioctl.c:21:
/usr/src/linux-2.4.31/include/linux/modules/ksyms.ver:660:1: warning:
"set_cpus_allowed" redefined
In file included from tty_ioctl.c:14:
/usr/src/linux-2.4.31/include/linux/sched.h:159:1: warning: this is the
location of the previous definition


The redefinition of "set_cpus_allowed" and "del_timer_sync" only happen
when CONFIG_SMP isn't set.  
I guess I could simply compile with CONFIG_SMP, but surely something's
not right here?

Follow-up:
OK, I've built the kernel with SMP support, and I'm not seeing the above 
any longer. However, when I tried to load module nfsd, I get:

/lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: unresolved symbol 
kernel_flag_cacheline
/lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: unresolved symbol 
atomic_dec_and_lock
/lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: insmod 
/lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o failed
/lib/modules/2.4.31/kernel/net/sunrpc/sunrpc.o: insmod nfsd failed



Per Jessen, Zurich
