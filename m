Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTDNLnC (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTDNLnC (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:43:02 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:1718
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S262984AbTDNLnA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 07:43:00 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs-kernel-server Oopses with 2.5.67
References: <kirk-1030412154541.A0214377@hydra.colinet.de>
	<yw1xllyfv6yf.fsf@zaphod.guide> <3E9A9D70.9020909@g-house.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 14 Apr 2003 13:54:51 +0200
In-Reply-To: <3E9A9D70.9020909@g-house.de>
Message-ID: <yw1xof398fas.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian <evil@g-house.de> writes:

> coming from [Re: 2.5.67 alpha compile failure (solved but nfsd Oopses
> now)] i think the subject line has to change, as i get another problem
> now:
> 
> 
> after applying the cond_syscall patch on my Alpha, 2.5.67 compiled
> with no errors. however the nfs-kernel-server Oopses now:

It happens for me too.  Here's the output of ksymoops.

ksymoops 2.4.5 on alpha 2.5.67.  Options used
     -v /mnt/linux/linux-sx164-2.5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67/ (default)
     -m /mnt/linux/linux-sx164-2.5/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
warning: process `update' used the obsolete bdflush system call
Unable to handle kernel paging request at virtual address 2834362d657a6973
rpc.nfsd(93): Oops 0
pc = [<fffffc0000314404>]  ra = [<fffffc0000312c30>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc0000314400
t2 = fffffc0000559ec8  t3 = fffffc0000559720  t4 = 000000000000001c
t5 = fffffc002f0e0010  t6 = 000000011ffff44c  t7 = fffffc002f2d0000
s0 = 0000000000000000  s1 = fffffc000034e370  s2 = 0000000000000000
s3 = 000000011ffff444  s4 = 0000000000000000  s5 = fffffc002f0e0000
s6 = 000000011fff9410
a0 = 2834362d657a6973  a1 = 0000000000000028  a2 = 0000000000000003
a3 = 0000000000000028  a4 = 0000000000000003  a5 = 000000011ffffecb
t8 = 000000000000001f  t9 = fffffc0000539ec8  t10= 0000000000000008
t11= 00000200001c70a0  pv = fffffc0000313fd0  at = fffffffc002c0b74
gp = fffffc0000559ec8  sp = fffffc002f2d3cd8
Trace:fffffc0000312c30 fffffc000037999c fffffc000034e2f0 fffffc000037a0e0 fffffc000034e374 fffffc0000398410 fffffc0000312ea4 
Code: 44a70405  3cd00001  3cb00000  e49fff1f  c3ffff24  47ff0401 <2cb00000> 2cd00003 


>>RA;  fffffc0000312c30 <entUna+90/110>

>>PC;  fffffc0000314404 <do_entUna+434/580>   <=====

Trace; fffffc0000312c30 <entUna+90/110>
Trace; fffffc000037999c <do_lookup+4c/130>
Trace; fffffc000034e2f0 <kmalloc+0/d0>
Trace; fffffc000037a0e0 <link_path_walk+660/ac0>
Trace; fffffc000034e374 <kmalloc+84/d0>
Trace; fffffc0000398410 <sys_nfsservctl+110/1a0>
Trace; fffffc0000312ea4 <entSys+a4/c0>

Code;  fffffc00003143ec <do_entUna+41c/580>
0000000000000000 <_PC>:
Code;  fffffc00003143ec <do_entUna+41c/580>
   0:   05 04 a7 44       or   t4,t6,t4
Code;  fffffc00003143f0 <do_entUna+420/580>
   4:   01 00 d0 3c       stq_u        t5,1(a0)
Code;  fffffc00003143f4 <do_entUna+424/580>
   8:   00 00 b0 3c       stq_u        t4,0(a0)
Code;  fffffc00003143f8 <do_entUna+428/580>
   c:   1f ff 9f e4       beq  t3,fffffffffffffc8c <_PC+0xfffffffffffffc8c> fffffc0000314078 <do_entUna+a8/580>
Code;  fffffc00003143fc <do_entUna+42c/580>
  10:   24 ff ff c3       br   fffffffffffffca4 <_PC+0xfffffffffffffca4> fffffc0000314090 <do_entUna+c0/580>
Code;  fffffc0000314400 <do_entUna+430/580>
  14:   01 04 ff 47       clr  t0
Code;  fffffc0000314404 <do_entUna+434/580>   <=====
  18:   00 00 b0 2c       ldq_u        t4,0(a0)   <=====
Code;  fffffc0000314408 <do_entUna+438/580>
  1c:   03 00 d0 2c       ldq_u        t5,3(a0)


1 error issued.  Results may not be reliable.


-- 
Måns Rullgård
mru@users.sf.net
