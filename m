Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130229AbQLJLlo>; Sun, 10 Dec 2000 06:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbQLJLle>; Sun, 10 Dec 2000 06:41:34 -0500
Received: from home.ppetru.net ([193.230.129.57]:19843 "HELO home.ppetru.net")
	by vger.kernel.org with SMTP id <S130229AbQLJLl0>;
	Sun, 10 Dec 2000 06:41:26 -0500
Date: Sun, 10 Dec 2000 13:10:33 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc64 network-related problems
Message-ID: <20001210131033.H728@ppetru.net>
In-Reply-To: <20001210105553.E728@ppetru.net> <200012101038.CAA06747@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200012101038.CAA06747@pizda.ninka.net>; from davem@redhat.com on Sun, Dec 10, 2000 at 02:38:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 02:38:28AM -0800, David S. Miller wrote:
> Is this always the _first_ OOPS though?  That is what is important,
> because after the first OOPS all the others are likely just side
> effects of the first one.

No, it was not the first one. Here's the ksymoops'ed first one:

ksymoops 2.3.4 on sparc64 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Dec  8 01:40:48 grey kernel: skput:over: 000000000053ed64:524 put:-428 dev:eth0              \|/ ____ \|/
Dec  8 01:40:48 grey kernel:               "@'/ .. \`@"
Dec  8 01:40:48 grey kernel:               /_| \__/ |_\
Dec  8 01:40:48 grey kernel:                  \__U_/
Dec  8 01:40:48 grey kernel: smtp(7102): Kernel bad trap
Dec  8 01:40:48 grey kernel: CPU[0]: local_irq_count[0] irqs_running[0]
Dec  8 01:40:48 grey kernel: TSTATE: 0000004411009601 TPC: 0000000000528b50 TNPC: 0000000000528b54 Y: 15e00000
Using defaults from ksymoops -t elf32-sparc -a sparc
Dec  8 01:40:48 grey kernel: g0: 0000000000000020 g1: 0000000000000001 g2: 0000000000000008 g3: 0000000000628000
Dec  8 01:40:48 grey kernel: g4: fffff80000000000 g5: 0000000000000001 g6: fffff800076a8000 g7: 0000000000000000
Dec  8 01:40:48 grey kernel: o0: 0000000000000032 o1: 0000000000629eae o2: 0000000000000032 o3: 0000000000000000
Dec  8 01:40:48 grey kernel: o4: 0000000000629e7b o5: 0000000000629ead sp: fffff800076ab1c1 ret_pc: 0000000000528b48
Dec  8 01:40:48 grey kernel: l0: fffff8003a9ec1a0 l1: 0000000000000008 l2: 0000000000000104 l3: 0000000200000000
Dec  8 01:40:48 grey kernel: l4: 0000000000000062 l5: 0000000000000000 l6: 0000000000000008 l7: 7fffffffffffffff
Dec  8 01:40:48 grey kernel: i0: fffff8003c65aae0 i1: fffffffffffffe54 i2: 000000000053ed64 i3: 00000000fffffe54
Dec  8 01:40:48 grey kernel: i4: 00000000000003b8 i5: 0000000000000000 i6: fffff800076ab281 i7: 000000000053ed68
Dec  8 01:40:48 grey kernel: Caller[000000000053ed68]
Dec  8 01:40:48 grey kernel: Caller[000000000055e4e0]
Dec  8 01:40:48 grey kernel: Caller[00000000005255b4]
Dec  8 01:40:48 grey kernel: Caller[0000000000525818]
Dec  8 01:40:48 grey kernel: Caller[000000000045e894]
Dec  8 01:40:48 grey kernel: Caller[000000000040fc34]
Dec  8 01:40:48 grey kernel: Caller[00000000000228fc]
Dec  8 01:40:48 grey kernel: Instruction DUMP: 981223a8  7ffc5ee6  9010000d <91d02005> 30680003  01000000  01000000  9de3bf40  1100167b 

>>PC;  00528b50 <skb_over_panic+30/40>   <=====
>>O7;  00528b48 <skb_over_panic+28/40>
>>I7;  0053ed68 <tcp_sendmsg+2e8/c60>
Trace; 0053ed68 <tcp_sendmsg+2e8/c60>
Trace; 0055e4e0 <inet_sendmsg+40/60>
Trace; 005255b4 <sock_sendmsg+74/a0>
Trace; 00525818 <sock_write+98/c0>
Trace; 0045e894 <sys_write+b4/100>
Trace; 0040fc34 <linux_sparc_syscall32+34/40>
Trace; 000228fc Before first symbol
Code;  00528b44 <skb_over_panic+24/40>
0000000000000000 <_PC>:
Code;  00528b44 <skb_over_panic+24/40>
   0:   98 12 23 a8       or  %o0, 0x3a8, %o4
Code;  00528b48 <skb_over_panic+28/40>
   4:   7f fc 5e e6       call  fffffffffff17b9c <_PC+0xfffffffffff17b9c> 004406e0 <printk+0/240>
Code;  00528b4c <skb_over_panic+2c/40>
   8:   90 10 00 0d       mov  %o5, %o0
Code;  00528b50 <skb_over_panic+30/40>   <=====
   c:   91 d0 20 05       ta  5   <=====
Code;  00528b54 <skb_over_panic+34/40>
  10:   30 68 00 03       unknown
Code;  00528b58 <skb_over_panic+38/40>
  14:   01 00 00 00       nop 
Code;  00528b5c <skb_over_panic+3c/40>
  18:   01 00 00 00       nop 
Code;  00528b60 <skb_under_panic+0/40>
  1c:   9d e3 bf 40       save  %sp, -192, %sp
Code;  00528b64 <skb_under_panic+4/40>
  20:   11 00 16 7b       sethi  %hi(0x59ec00), %o0

Dec  8 01:40:48 grey kernel: CPU[2]: local_irq_count[0] irqs_running[0]
Dec  8 01:40:48 grey kernel: TSTATE: 0000000011009605 TPC: 0000000000449e94 TNPC: 0000000000449e98 Y: 05000000
Dec  8 01:40:48 grey kernel: g0: 80000000000006b0 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000007fffff
Dec  8 01:40:48 grey kernel: g4: fffff80000000000 g5: 0000000000000003 g6: fffff8003e68c000 g7: 0000000000000003
Dec  8 01:40:48 grey kernel: o0: 000000000223e000 o1: 0000000000000000 o2: fffff8003f110000 o3: 0000000000800000
Dec  8 01:40:48 grey kernel: o4: 000000000001ff55 o5: fffff800002d8030 sp: fffff8003e68f481 ret_pc: 0000000000449f14
Dec  8 01:40:48 grey kernel: l0: 00000000000002c7 l1: fffff8003f1109c0 l2: 0000000086000000 l3: 0000000000000000
Dec  8 01:40:48 grey kernel: l4: 000000008823e000 l5: fffff8003f1a0430 l6: 0000000000000003 l7: 000001ffffffe000
Dec  8 01:40:48 grey kernel: i0: 0000000000800000 i1: 000000007012c000 i2: fffff80000505428 i3: fffff8003ee66000
Dec  8 01:40:48 grey kernel: i4: 0000000000000000 i5: 000000008823e000 i6: fffff8003e68f551 i7: 000000000044cfa8
Warning (Oops_read): Code line not seen, dumping what data is available

>>PC;  00449e94 <zap_page_range+134/280>   <=====
>>O7;  00449f14 <zap_page_range+1b4/280>
>>I7;  0044cfa8 <do_munmap+268/300>


3 warnings issued.  Results may not be reliable.

So should I apply your patch ?

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
