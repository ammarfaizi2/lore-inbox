Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293237AbSCJVJI>; Sun, 10 Mar 2002 16:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293238AbSCJVI5>; Sun, 10 Mar 2002 16:08:57 -0500
Received: from [202.54.26.202] ([202.54.26.202]:20729 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S293237AbSCJVIn>;
	Sun, 10 Mar 2002 16:08:43 -0500
X-Lotus-FromDomain: HSS
From: hkumar@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B78.00740223.00@sandesh.hss.hns.com>
Date: Mon, 11 Mar 2002 02:30:30 +0530
Subject: Kernel 2.4.16 failed to compile
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I am trying to compile kernel version 2.4.16 for powerpc with networking off
i.e.
CONFIG_NET was not set.

-----------------------------------
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.16/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
 -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -mcpu=860 " -C  net
make[1]: Entering directory `/usr/src/linux-2.4.16/net'
make -C core
make[2]: Entering directory `/usr/src/linux-2.4.16/net/core'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.16/net/core'
ppc-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4.16/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
 -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -mcpu=860    -c -o sock.o sock.c
In file included from /usr/src/linux-2.4.16/include/net/tcp.h:1036,
                 from sock.c:122:
/usr/src/linux-2.4.16/include/net/tcp_ecn.h: In function `TCP_ECN_send':
/usr/src/linux-2.4.16/include/net/tcp_ecn.h:54: union has no member named
`af_inet'
/usr/src/linux-2.4.16/include/net/tcp_ecn.h:61: union has no member named
`af_inet'
make[3]: *** [sock.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.16/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.16/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.16/net'
make: *** [_dir_net] Error 2
-----------------------------------------------

I am wondering why is it compiling in the net/core directory when I do not want
any
kind of networking support!

After looking at the Makefiles I found that it compiles the net, net/core and
net/ethernet
directories even if  CONFIG_NET is not set. I tried to remove all the networking
 stuff by
changing the makefiles but I had to fix the following:

1. removed (using #ifdef) all the socket related stuff except for a
sys_socketcall which
returns ENOTSUPP. This hook is needed by the code in arch dir
2. put the sock_init call in main.c inside #ifdef
3. added some #ifdefs in fs/fcntl.c to remove calls to  sock_fcntl

Am I doing it right or will it break something? Do we need socket.c etc. even
when we
do not want networking support?

Thanks,
Harendra


"DISCLAIMER: This message is proprietary to Hughes Software Systems Limited
(HSS) and is intended solely for the use of the individual  to whom it is
addressed. It may contain  privileged or confidential information  and should
not be circulated or used for any purpose other than for what it is intended. If
you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that you
are strictly prohibited from using, copying, altering, or disclosing the
contents of this message. HSS accepts no responsibility for loss or damage
arising from the use of the information transmitted by this email including
damage from virus."





