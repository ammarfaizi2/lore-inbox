Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTDOX02 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTDOX02 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:26:28 -0400
Received: from [62.75.136.201] ([62.75.136.201]:21656 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264157AbTDOX0Y 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:26:24 -0400
Message-ID: <3E9C97D9.6070509@g-house.de>
Date: Wed, 16 Apr 2003 01:38:01 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030312
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops: rpc.nfsd (nfs-kernel-server) and 2.5.67 / Alpha
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

recently i had compiling problems with 2.5.67 on alpha. after applying 
the patch from Måns Rullgård ([PATCH] Fix cond_syscall macro on Alpha), 
compiling was fine and booting 2.5.67 also.
but now the nfs-kernel-server oopses. putting the Oops in a file, 
ksymoops gives:

----------------
lila:~# ksymoops -m /boot/2.5/System.map -K rpc.nfsd.oops
ksymoops 2.4.8 on alpha 2.5.67.  Options used
      -V (default)
      -K (specified)
      -l /proc/modules (default)
      -o /lib/modules/2.5.67/ (default)
      -m /boot/2.5/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 16 01:14:36 lila kernel: Unable to handle kernel paging request at 
virtual address 2834362d657a6973
Apr 16 01:14:36 lila kernel: rpc.nfsd(15103): Oops 0
Apr 16 01:14:36 lila kernel: pc = [<fffffc0000314748>]  ra = 
[<fffffc0000312ec0>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
Apr 16 01:14:36 lila kernel: v0 = 0000000000000000  t0 = 
0000000000000000  t1 = fffffc0000314744
Apr 16 01:14:36 lila kernel: t2 = fffffc0000560848  t3 = 
fffffc000055fba0  t4 = 0000000000000001
Apr 16 01:14:36 lila kernel: t5 = 2834362d657a6973  t6 = 
000000000000001c  t7 = fffffc00010a0000
Apr 16 01:14:36 lila kernel: s0 = 0000000000000000  s1 = 
fffffc000034e0d0  s2 = 0000000000000000
Apr 16 01:14:36 lila kernel: s3 = 000000011ffff3e4  s4 = 
0000000000000000  s5 = fffffc00026fe000
Apr 16 01:14:36 lila kernel: s6 = 000000011fff9340
Apr 16 01:14:36 lila kernel: a0 = 2834362d657a6973  a1 = 
0000000000000028  a2 = 0000000000000001
Apr 16 01:14:36 lila kernel: a3 = 0000000000000028  a4 = 
0000000000000001  a5 = 0000000000000000
Apr 16 01:14:36 lila kernel: t8 = 0000000000000000  t9 = 
fffffc0000540848  t10= fffffc0003ff2f88
Apr 16 01:14:36 lila kernel: t11= fffffc00005c3010  pv = 
fffffc0000314300  at = fffffffc002e6b84
Apr 16 01:14:36 lila kernel: gp = fffffc0000560848  sp = fffffc00010a3cd8
Apr 16 01:14:36 lila kernel: Trace:fffffc0000312ec0 fffffc0000379408 
fffffc000034e050 fffffc0000379b78 fffffc000034e0d4 fffffc0000397e3c 
fffffc0000313134 fffffc0000313090
Apr 16 01:14:36 lila kernel: Code: 3c900001  3cb00000  47f60401 
e43fff1d  c3ffff21  47ff0401 <2cb00000> 2cf00003


 >>RA;  fffffc0000312ec0 <entUna+90/110>

 >>PC;  fffffc0000314748 <do_entUna+448/580>   <=====

Trace; fffffc0000312ec0 <entUna+90/110>
Trace; fffffc0000379408 <do_lookup+48/120>
Trace; fffffc000034e050 <kmalloc+0/d0>
Trace; fffffc0000379b78 <link_path_walk+698/b10>
Trace; fffffc000034e0d4 <kmalloc+84/d0>
Trace; fffffc0000397e3c <sys_nfsservctl+10c/1a0>
Trace; fffffc0000313134 <entSys+a4/c0>
Trace; fffffc0000313090 <entSys+0/c0>

Code;  fffffc0000314730 <do_entUna+430/580>
0000000000000000 <_PC>:
Code;  fffffc0000314730 <do_entUna+430/580>
    0:   01 00 90 3c       stq_u        t3,1(a0)
Code;  fffffc0000314734 <do_entUna+434/580>
    4:   00 00 b0 3c       stq_u        t4,0(a0)
Code;  fffffc0000314738 <do_entUna+438/580>
    8:   01 04 f6 47       mov  t8,t0
Code;  fffffc000031473c <do_entUna+43c/580>
    c:   1d ff 3f e4       beq  t0,fffffffffffffc84 <_PC+0xfffffffffffffc84>
Code;  fffffc0000314740 <do_entUna+440/580>
   10:   21 ff ff c3       br   fffffffffffffc98 <_PC+0xfffffffffffffc98>
Code;  fffffc0000314744 <do_entUna+444/580>
   14:   01 04 ff 47       clr  t0
Code;  fffffc0000314748 <do_entUna+448/580>   <=====
   18:   00 00 b0 2c       ldq_u        t4,0(a0)   <=====
Code;  fffffc000031474c <do_entUna+44c/580>
   1c:   03 00 f0 2c       ldq_u        t6,3(a0)

lila:~#
----------------

yes, i specified -K because /proc/ksyms is not available in 2.5.67. i 
have heard System.map should also do.

machine is AlphaStation 255/233 EV45 (Avanti), glibc-2.3.1, gcc-3.2.3, 
nfs-kernel-server 1.0.3-1 (Debian).

Thank you for comments,
Christian.

