Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSE1WHn>; Tue, 28 May 2002 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSE1WHm>; Tue, 28 May 2002 18:07:42 -0400
Received: from rdu26-247-095.nc.rr.com ([66.26.247.95]:4748 "HELO chapus.net")
	by vger.kernel.org with SMTP id <S316965AbSE1WHl>;
	Tue, 28 May 2002 18:07:41 -0400
Date: Tue, 28 May 2002 18:07:27 -0400
To: linux-kernel@vger.kernel.org
Subject: tcpdump with CONFIG_FILTER causes Oops on Sparc
Message-ID: <20020528220727.GA12229@chapus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: "Eloy A. Paris" <peloy@chapus.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can reliably reproduce an Oops when running tcpdump on a Sun Ultra 5
(sparc64.) I was running without CONFIG_FILTER and was getting bus
errors when tcpdump was run as in "tcpdump host <hostname/IP addr>".
After I compiled my kernel with CONFIG_FILTER I started to get the
Oops. I prefer to get the bus errors, if you ask me.

Kernel version is 2.4.19pre8. tcpdump is 3.6.2. Running Debian
unstable.

Below is the output from ksymoops. Doesn't make much sense to me but
if anyone is interested in debugging this further I am more than
willing to help.

Cheers,

Eloy.-

ksymoops 2.4.5 on sparc64 2.4.19-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8/ (default)
     -m /usr/src/linux/System.map (specified)

May 28 17:46:39 elparis-lnx kernel: Unable to handle kernel paging request in mna handler<1> at virtual address 0015000500008035
May 28 17:46:39 elparis-lnx kernel:               \|/ ____ \|/
May 28 17:46:39 elparis-lnx kernel:               "@'/ .. \`@"
May 28 17:46:39 elparis-lnx kernel:               /_| \__/ |_\
May 28 17:46:39 elparis-lnx kernel:                  \__U_/
May 28 17:46:39 elparis-lnx kernel: tcpdump(201): Oops
May 28 17:46:39 elparis-lnx kernel: TSTATE: 0000004411009607 TPC: 0000000002005b8c TNPC: 0000000002005b90 Y: 02d00000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
May 28 17:46:39 elparis-lnx kernel: g0: fffff800010a2fd1 g1: 0000000000000000 g2: 00000000005ecdf8 g3: 00000000006abfe8
May 28 17:46:39 elparis-lnx kernel: g4: fffff80000000000 g5: 0000000000000001 g6: fffff800010a0000 g7: 0000000000000001
May 28 17:46:39 elparis-lnx kernel: o0: fffff8001feb3c40 o1: 0015000500008035 o2: 0000000000000001 o3: 0000000000007fff
May 28 17:46:39 elparis-lnx kernel: o4: 00000000700299b8 o5: 0000000000000003 sp: fffff800010a3011 ret_pc: 0000000002005b74
May 28 17:46:39 elparis-lnx kernel: l0: fffff80000302040 l1: 0015000500008035 l2: 0000000000000000 l3: 00000000006b76b8
May 28 17:46:39 elparis-lnx kernel: l4: aaaaaaaaaaaaaaab l5: 00000000006b7400 l6: 0000000000000000 l7: 00000000700283a8
May 28 17:46:39 elparis-lnx kernel: i0: fffff800010c04e0 i1: fffff8001feb3c40 i2: 0000000000000000 i3: 0000000002007300
May 28 17:46:39 elparis-lnx kernel: i4: 0000000000000000 i5: 0000000000000000 i6: fffff800010a30d1 i7: 0000000002004f7c
May 28 17:46:39 elparis-lnx kernel: Caller[0000000002004f7c]
May 28 17:46:39 elparis-lnx kernel: Caller[000000000053c1b4]
May 28 17:46:39 elparis-lnx kernel: Caller[000000000053c7a0]
May 28 17:46:39 elparis-lnx kernel: Caller[00000000004645dc]
May 28 17:46:39 elparis-lnx kernel: Caller[000000000046328c]
May 28 17:46:39 elparis-lnx kernel: Caller[00000000004462c0]
May 28 17:46:39 elparis-lnx kernel: Caller[0000000000446a34]
May 28 17:46:39 elparis-lnx kernel: Caller[0000000000446c68]
May 28 17:46:39 elparis-lnx kernel: Caller[0000000000410e74]
May 28 17:46:39 elparis-lnx kernel: Caller[00000000700b17d0]
May 28 17:46:39 elparis-lnx kernel: Instruction DUMP: e25a2040  02c4401a  01000000 <d25c4000> d2722040  7f94f7cb  d0446008  a0100008  02c4000c 


>>PC;  02005b8c <.bss.end+4839/????>   <=====

>>g0; fffff800010a2fd1 <END_OF_CODE+fffff7ffff0a1c7e/????>
>>g2; 005ecdf8 <rtnl_sem+0/20>
>>g3; 006abfe8 <pgt_quicklists+0/20>
>>g4; fffff80000000000 <END_OF_CODE+fffff7fffdffecad/????>
>>g6; fffff800010a0000 <END_OF_CODE+fffff7ffff09ecad/????>
>>o0; fffff8001feb3c40 <END_OF_CODE+fffff8001deb28ed/????>
>>o1; 15000500008035 <END_OF_CODE+150004fe006ce2/????>
>>o3; 00007fff Before first symbol
>>o4; 700299b8 <END_OF_CODE+6e028665/????>
>>sp; fffff800010a3011 <END_OF_CODE+fffff7ffff0a1cbe/????>
>>ret_pc; 02005b74 <.bss.end+4821/????>
>>l0; fffff80000302040 <END_OF_CODE+fffff7fffe300ced/????>
>>l1; 15000500008035 <END_OF_CODE+150004fe006ce2/????>
>>l3; 006b76b8 <zone_table+0/18>
>>l4; aaaaaaaaaaaaaaab <END_OF_CODE+aaaaaaaaa8aa9758/????>
>>l5; 006b7400 <uidhash_table+6b8/800>
>>l7; 700283a8 <END_OF_CODE+6e027055/????>
>>i0; fffff800010c04e0 <END_OF_CODE+fffff7ffff0bf18d/????>
>>i1; fffff8001feb3c40 <END_OF_CODE+fffff8001deb28ed/????>
>>i3; 02007300 <.bss.end+5fad/????>
>>i6; fffff800010a30d1 <END_OF_CODE+fffff7ffff0a1d7e/????>
>>i7; 02004f7c <.bss.end+3c29/????>

Trace; 02004f7c <.bss.end+3c29/????>
Trace; 0053c1b4 <sock_release+14/60>
Trace; 0053c7a0 <sock_close+20/60>
Trace; 004645dc <fput+5c/140>
Trace; 0046328c <filp_close+6c/80>
Trace; 004462c0 <put_files_struct+80/120>
Trace; 00446a34 <do_exit+b4/2c0>
Trace; 00446c68 <sys_exit+8/20>
Trace; 00410e74 <linux_sparc_syscall32+34/40>
Trace; 700b17d0 <END_OF_CODE+6e0b047d/????>

Code;  02005b80 <.bss.end+482d/????>
00000000 <_PC>:
Code;  02005b80 <.bss.end+482d/????>
   0:   e2 5a 20 40       unknown
Code;  02005b84 <.bss.end+4831/????>
   4:   02 c4 40 1a       unknown
Code;  02005b88 <.bss.end+4835/????>
   8:   01 00 00 00       nop 
Code;  02005b8c <.bss.end+4839/????>   <=====
   c:   d2 5c 40 00       unknown   <=====
Code;  02005b90 <.bss.end+483d/????>
  10:   d2 72 20 40       unknown
Code;  02005b94 <.bss.end+4841/????>
  14:   7f 94 f7 cb       call  fe53df40 <_PC+0xfe53df40> 00543ac0 <dev_get_by_index+0/40>
Code;  02005b98 <.bss.end+4845/????>
  18:   d0 44 60 08       unknown
Code;  02005b9c <.bss.end+4849/????>
  1c:   a0 10 00 08       mov  %o0, %l0
Code;  02005ba0 <.bss.end+484d/????>
  20:   02 c4 00 0c       unknown

