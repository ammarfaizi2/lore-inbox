Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286938AbRL1RzU>; Fri, 28 Dec 2001 12:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286948AbRL1RzK>; Fri, 28 Dec 2001 12:55:10 -0500
Received: from harddata.com ([216.123.194.198]:13071 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S286938AbRL1RzB>;
	Fri, 28 Dec 2001 12:55:01 -0500
Date: Fri, 28 Dec 2001 10:54:58 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 oops on Alpha - vm or fs?
Message-ID: <20011228105458.A15927@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was greeted today in the morning by the following oops, apparently in
fs/inode.c,  which did NOT kill a machine (Alpha UP1100, Nautilus
chipset):

ksymoops 2.4.0 on alpha 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (specified)

Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says fffffffc002f4f94, /lib/modules/2.4.17/kernel/net/packet/af_packet.o says fffffffc002f2004.  Ignoring /lib/modules/2.4.17/kernel/net/packet/af_packet.o entry
Unable to handle kernel paging request at virtual address ffff800000000ef8
kswapd(4): Oops 0
pc = [<fffffc0000865474>]  ra = [<fffffc00008653d0>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000007  t0 = ffff800000000ec0  t1 = 0000000000000010
t2 = fffffc000fe4f990  t3 = fffffc0004dc2140  t4 = fffffc000ff636b8
t5 = fffffc000ff636a8  t6 = ffffffffffffffff  t7 = fffffc000fe4c000
s0 = fffffc0004dc2dc0  s1 = fffffc000fe4f990  s2 = fffffc0000a78f20
s3 = fffffc000fe4f990  s4 = 0000000000000000  s5 = 0000000000002284
s6 = 5800000000000911
a0 = fffffc0004dc2e00  a1 = 0000000000000000  a2 = 0000000000000053
a3 = fffffc000fe13b80  a4 = 0000e10000000000  a5 = 0000000000000000
t8 = 0000000000008035  t9 = fffffc000083f4c8  t10= 0000000000000f00
t11= 0000000000000300  pv = fffffc000084d2b0  at = 0000000000000001
gp = fffffc0000ab94d0  sp = fffffc000fe4f920
Trace:fffffc000086556c fffffc000086597c fffffc0000865a08 fffffc0000841018 fffffc00008410b4 fffffc00008411a0 fffffc0000841248 fffffc0000841410 fffffc0000810920 fffffc0000841310 
Code: 44411001  e4200002  47e90410  d35ffc73  a4290108  e4200008 <a7610038> e7600006 

>>PC;  fffffc0000865474 <clear_inode+c4/150>   <=====
Trace; fffffc000086556c <dispose_list+6c/b0>
Trace; fffffc000086597c <prune_icache+11c/160>
Trace; fffffc0000865a08 <shrink_icache_memory+48/70>
Trace; fffffc0000841018 <shrink_caches+e8/120>
Trace; fffffc00008410b4 <try_to_free_pages+64/a0>
Trace; fffffc00008411a0 <kswapd_balance_pgdat+70/e0>
Trace; fffffc0000841248 <kswapd_balance+38/70>
Trace; fffffc0000841410 <kswapd+100/160>
Trace; fffffc0000810920 <kernel_thread+58/70>
Trace; fffffc0000841310 <kswapd+0/160>
Code;  fffffc000086545c <clear_inode+ac/150>
0000000000000000 <_PC>:
Code;  fffffc000086545c <clear_inode+ac/150>
   0:   01 10 41 44       and  t1,0x8,t0
Code;  fffffc0000865460 <clear_inode+b0/150>
   4:   02 00 20 e4       beq  t0,10 <_PC+0x10> fffffc000086546c <clear_inode+bc/150>
Code;  fffffc0000865464 <clear_inode+b4/150>
   8:   10 04 e9 47       mov  s0,a0
Code;  fffffc0000865468 <clear_inode+b8/150>
   c:   73 fc 5f d3       bsr  ra,fffffffffffff1dc <_PC+0xfffffffffffff1dc> fffffc0000864638 <__wait_on_inode+8/c0>
Code;  fffffc000086546c <clear_inode+bc/150>
  10:   08 01 29 a4       ldq  t0,264(s0)
Code;  fffffc0000865470 <clear_inode+c0/150>
  14:   08 00 20 e4       beq  t0,38 <_PC+0x38> fffffc0000865494 <clear_inode+e4/150>
Code;  fffffc0000865474 <clear_inode+c4/150>   <=====
  18:   38 00 61 a7       ldq  t12,56(t0)   <=====
Code;  fffffc0000865478 <clear_inode+c8/150>
  1c:   06 00 60 e7       beq  t12,38 <_PC+0x38> fffffc0000865494 <clear_inode+e4/150>


1 warning issued.  Results may not be reliable.

Logs and timestamps on various files indicate that this happened during
a daily, automatic - from cron, 'slocate' run.  It looks like that even
that was finished despite of the oops above.  File systems are mounted
as ext2.

It appears that the above shows oops on line 520 in fs/inode.c; that
means this code:
.....
	wait_on_inode(inode);
	DQUOT_DROP(inode);
===>	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
		inode->i_sb->s_op->clear_inode(inode);
......

  Michal

