Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTDLT26 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDLT25 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:28:57 -0400
Received: from mail1.nwe.de ([195.226.126.83]:31206 "EHLO mail1.nwe.de")
	by vger.kernel.org with ESMTP id S263383AbTDLT2z (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 15:28:55 -0400
Date: Sat, 12 Apr 2003 19:01:04 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] Alpha 2.5.67 nfs server oops
Message-ID: <Pine.LNX.4.44.0304121858200.10542-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

starting NFS on Alpha 2.5.67 gives reproducable oops:

ksymoops 2.4.8 on alpha 2.5.56.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67 (specified)
     -m /boot/System.map-2.5.67 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 2834362d657a6973
rpc.nfsd(776): Oops 0
pc = [<fffffc00010146d4>]  ra = [<fffffc0001012e20>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc00010146d0
t2 = fffffc0001518470  t3 = fffffc00015196c0  t4 = 000000000000001c
t5 = fffffc00289bc010  t6 = 000000011ffff49c  t7 = fffffc002995c000
s0 = 0000000000000000  s1 = fffffc000105ca60  s2 = 0000000000000200
s3 = 000000011ffff494  s4 = 0000000000000000  s5 = fffffc00289bc000
s6 = 000000011fff9340
a0 = 2834362d657a6973  a1 = 0000000000000028  a2 = 0000000000000003
a3 = 0000000000000028  a4 = 0000000000000003  a5 = 0000000000000000
t8 = 000000000000001f  t9 = fffffc0001498470  t10= 0000000000000008
t11= 0000000000000000  pv = fffffc0001014290  at = fffffffc0030ab94
gp = fffffc0001518470  sp = fffffc002995fcd8
Trace:fffffc0001012e20 fffffc000108899c fffffc000105c9e0 fffffc00010890c4 fffffc000105ca64 fffffc00010a8050 fffffc0001013094
Code: 44a70405  3cd00001  3cb00000  e49fff1b  c3ffff20  47ff0401 <2cb00000> 2cd00003


>>RA;  fffffc0001012e20 <entUna+90/110>

>>PC;  fffffc00010146d4 <do_entUna+444/590>   <=====

Trace; fffffc0001012e20 <entUna+90/110>
Trace; fffffc000108899c <do_lookup+4c/130>
Trace; fffffc000105c9e0 <kmalloc+0/d0>
Trace; fffffc00010890c4 <link_path_walk+644/b40>
Trace; fffffc000105ca64 <kmalloc+84/d0>
Trace; fffffc00010a8050 <sys_nfsservctl+110/1a0>
Trace; fffffc0001013094 <entSys+a4/c0>

Code;  fffffc00010146bc <do_entUna+42c/590>
0000000000000000 <_PC>:
Code;  fffffc00010146bc <do_entUna+42c/590>
   0:   05 04 a7 44       or   t4,t6,t4
Code;  fffffc00010146c0 <do_entUna+430/590>
   4:   01 00 d0 3c       stq_u        t5,1(a0)
Code;  fffffc00010146c4 <do_entUna+434/590>
   8:   00 00 b0 3c       stq_u        t4,0(a0)
Code;  fffffc00010146c8 <do_entUna+438/590>
   c:   1b ff 9f e4       beq  t3,fffffffffffffc7c <_PC+0xfffffffffffffc7c>
Code;  fffffc00010146cc <do_entUna+43c/590>
  10:   20 ff ff c3       br   fffffffffffffc94 <_PC+0xfffffffffffffc94>
Code;  fffffc00010146d0 <do_entUna+440/590>
  14:   01 04 ff 47       clr  t0
Code;  fffffc00010146d4 <do_entUna+444/590>   <=====
  18:   00 00 b0 2c       ldq_u        t4,0(a0)   <=====
Code;  fffffc00010146d8 <do_entUna+448/590>
  1c:   03 00 d0 2c       ldq_u        t5,3(a0)


--jochen

