Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286357AbRLTURV>; Thu, 20 Dec 2001 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286361AbRLTURM>; Thu, 20 Dec 2001 15:17:12 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:24331 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S286357AbRLTUQ7>; Thu, 20 Dec 2001 15:16:59 -0500
Date: Thu, 20 Dec 2001 13:16:56 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Oops from 2.4.17-rc2 on Alpha
Message-ID: <20011220131656.A18847@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At last I managed to catch one which seems to make some sense.
Here it goes:

ksymoops 2.4.0 on alpha 2.4.17-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2/ (default)
     -m /boot/System.map-2.4.17-rc2 (specified)

 Bcache double-bit error on Dcache fill at 0x8077C8C0
Unable to handle kernel paging request at virtual address 0000000000000119
klogd(426): Oops 0
pc = [<fffffc0000816500>]  ra = [<fffffc0000816500>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000065  t0 = 0000000000000001  t1 = fffffc0000a79ca8
t2 = fffffc0000a79ca0  t3 = 0000000000000000  t4 = ffffffff00000000
t5 = 0000000000000001  t6 = 00000000000a9cb5  t7 = fffffc00202b8000
s0 = fffffc0002313240  s1 = ffffffffffffffea  s2 = 0000000000000046
s3 = 000000011fffedd0  s4 = 000000011fffedd0  s5 = 000000011ffff9d0
s6 = 000000011ffff5d0
a0 = 0000000000000007  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = 0000000000000008
t8 = fffffc0000ac8b70  t9 = 0000000000004000  t10= fffffc0000ac8b78
t11= fffffc0000ac8b88  pv = fffffc000081e350  at = 0000000000000000
gp = fffffc0000abe4d0  sp = fffffc00202bbd90
Trace:fffffc0000810dc8 fffffc00009c5b98 fffffc000097216c fffffc00009720d0 fffffc0000971e18 fffffc000084a634 fffffc0000810db0 
Code: 23bd7fec  c3e00032  a43da5e8  205e0010  47e30410  47e20412 <a7610118> 6b5b4000 

>>PC;  fffffc0000816500 <do_entInt+a0/170>   <=====
Trace; fffffc0000810dc8 <ret_from_sys_call+0/10>
Trace; fffffc00009c5b98 <unix_dgram_sendmsg+128/4e0>
Trace; fffffc000097216c <sock_write+9c/b0>
Trace; fffffc00009720d0 <sock_write+0/b0>
Trace; fffffc0000971e18 <sock_sendmsg+8/f0>
Trace; fffffc000084a634 <sys_write+e4/160>
Trace; fffffc0000810db0 <entSys+a8/c0>
Code;  fffffc00008164e8 <do_entInt+88/170>
0000000000000000 <_PC>:
Code;  fffffc00008164e8 <do_entInt+88/170>
   0:   ec 7f bd 23       lda  gp,32748(gp)
Code;  fffffc00008164ec <do_entInt+8c/170>
   4:   32 00 e0 c3       br   d0 <_PC+0xd0> fffffc00008165b8 <do_entInt+158/170>
Code;  fffffc00008164f0 <do_entInt+90/170>
   8:   e8 a5 3d a4       ldq  t0,-23064(gp)
Code;  fffffc00008164f4 <do_entInt+94/170>
   c:   10 00 5e 20       lda  t1,16(sp)
Code;  fffffc00008164f8 <do_entInt+98/170>
  10:   10 04 e3 47       mov  t2,a0
Code;  fffffc00008164fc <do_entInt+9c/170>
  14:   12 04 e2 47       mov  t1,a2
Code;  fffffc0000816500 <do_entInt+a0/170>   <=====
  18:   18 01 61 a7       ldq  t12,280(t0)   <=====
Code;  fffffc0000816504 <do_entInt+a4/170>
  1c:   00 40 5b 6b       jsr  ra,(t12),20 <_PC+0x20> fffffc0000816508 <do_entInt+a8/170>

Any ideas?

Because of this "Bcache double-bit error on Dcache fill at 0x8077C8C0"
this can be dismissed as a hardware error; and that as well may be.
There is a catch, though.  2.4.5-ac8 kernel on the same hardware
does not show any issues of that sort - at least so far.

With 2.4.17rc2 I also got, once, "Trying to vfree() nonexistent vm area
(0000050090000000)".  This, probably, when shutting down a network.

  Michal
  michal@harddata.com
