Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbTDNLZu (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTDNLZu (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:25:50 -0400
Received: from [62.75.136.201] ([62.75.136.201]:35983 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262972AbTDNLZa (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 07:25:30 -0400
Message-ID: <3E9A9D70.9020909@g-house.de>
Date: Mon, 14 Apr 2003 13:37:20 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030312
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: nfs-kernel-server Oopses with 2.5.67
References: <kirk-1030412154541.A0214377@hydra.colinet.de> <yw1xllyfv6yf.fsf@zaphod.guide>
In-Reply-To: <yw1xllyfv6yf.fsf@zaphod.guide>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

coming from [Re: 2.5.67 alpha compile failure (solved but nfsd Oopses 
now)] i think the subject line has to change, as i get another problem now:

after applying the cond_syscall patch on my Alpha, 2.5.67 compiled with 
no errors. however the nfs-kernel-server Oopses now:

------------

lila:~# /etc/init.d/nfs-kernel-server start
Apr 14 00:31:08 lila kernel: Unable to handle kernel paging request at
virtual address 2834362d657a6973
Apr 14 00:31:08 lila kernel: rpc.nfsd(22279): Oops 0
Apr 14 00:31:08 lila kernel: pc = [<fffffc0000314748>]  ra =
[<fffffc0000312ec0>]  ps = 0007    Not tainted
Apr 14 00:31:08 lila kernel: v0 = 0000000000000000  t0 =
0000000000000000  t1 = fffffc0000314744
Apr 14 00:31:08 lila kernel: t2 = fffffc0000560848  t3 =
fffffc000055fba0  t4 = 0000000000000001
Apr 14 00:31:08 lila kernel: t5 = 2834362d657a6973  t6 =
000000000000001c  t7 = fffffc00031f8000
Apr 14 00:31:08 lila kernel: s0 = 0000000000000000  s1 =
fffffc000034e0d0  s2 = 0000000000000000
Apr 14 00:31:08 lila kernel: s3 = 000000011ffff3e4  s4 =
0000000000000000  s5 = fffffc0003840000
Apr 14 00:31:08 lila kernel: s6 = 0000000000000801
Apr 14 00:31:08 lila kernel: a0 = 2834362d657a6973  a1 =
0000000000000028  a2 = 0000000000000001
Apr 14 00:31:08 lila kernel: a3 = 0000000000000028  a4 =
0000000000000001  a5 = 0000000000000000
Apr 14 00:31:08 lila kernel: t8 = 0000000000000000  t9 =
fffffc0000540848  t10= fffffc0003ff31c8
Apr 14 00:31:08 lila kernel: t11= fffffc00005c3010  pv =
fffffc0000314300  at = fffffffc002e6b84
Apr 14 00:31:08 lila kernel: gp = fffffc0000560848  sp = fffffc00031fbcd8
Apr 14 00:31:08 lila kernel: Trace:fffffc0000312ec0 fffffc0000379408
fffffc000034e050 fffffc0000379b78 fffffc000034e0d4 fffffc0000397e3c
fffffc0000313134 fffffc0000313090
Apr 14 00:31:08 lila kernel: Code: 3c900001  3cb00000  47f60401
e43fff1d  c3ffff21  47ff0401 <2cb00000> 2cf00003

Starting NFS kernel daemon: nfsd/etc/init.d/nfs-kernel-server: line 79:
22279 Segmentation fault      start-stop-daemon --start --quiet --exec
$PREFIX/sbin/rpc.nfsd -- $RPCNFSDCOUNT
  mountd.
lila:~#

--------------
(could be that the order is a bit messed up, i copied the kernel oops
from /var/log/messages between "start" and "segfault".)

the nfs-kernel-server is from nfs-utils_1.0.3-1 (Debian testing), 
working without problems under 2.5.65. the nfs-user-server does *not* oops.

kernel 2.5.67, compiled with gcc (GCC) 3.2.3 20030309, machine is an 
Alpha EV45/Avtanti.

Thank you,
Christian.

