Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283591AbRK3JvI>; Fri, 30 Nov 2001 04:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283590AbRK3Ju6>; Fri, 30 Nov 2001 04:50:58 -0500
Received: from host213-121-104-31.in-addr.btopenworld.com ([213.121.104.31]:10668
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S283589AbRK3Jun>; Fri, 30 Nov 2001 04:50:43 -0500
Subject: [PANIC]: Panic out of the blue in timer_bh (possibly bogus)
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 09:49:50 +0000
Message-Id: <1007113790.22600.0.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been observing panics in 2.4.3 and also in 2.4.9. The panics
occur completely out of the blue after a month or two of uptime.
Ksymoops gives a couple of warnings, im not sure exactly how relevent
they are but I'm pretty damn sure its using the correct ksyms/system.map
etc.

Quickly parsing through the timer_bh function and the 2 inline functions
it calls, I couldn't see really see where this dereference was
happening...

Anyone experienced similar panics? Could it be the symbols not resolving
and that this is really happening inside a network interrupt or
something (which btw. would make much more sense)?

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c029b670, System.map says c014e3e0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  ,
tulip says d09a26ec, /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o
says d09a1cac.  Ignoring
/lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip
says d09a26f0, /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o says
d09a1cb0.  Ignoring /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o
entry
Unable to handle kernel NULL pointer dereference at virtual address
00000040
c011b6a0
*pde = 0c92f067
Oops: 0002
CPU:    0
EIP:    0010:[<c011b6a0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000040   ebx: cfe7a000   ecx: cfe7bf8c   edx: c043724c
esi: c0111750   edi: 00000000   ebp: c042c5a0   esp: c03dbf3c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c03db000)
Stack: c0436400 00000000 00000000 c042c5a0 c0117e7b c0117d96 00000000
00000001
       c042c5c0 fffffffe 00000046 c0117b73 c042c5c0 c03dbf98 00000000
c042a900
       c03a15b4 c010893c c03da000 c0105380 c03da000 0008e000 c0106f20
c03da000
Call Trace: [<c0117e7b>] [<c0117d96>] [<c0117b73>] [c010893c>]
[<c0105380>]
   [<c0106f20>] [<c0105380>] [<c01053a4>] [c0105412>] [<c0105000>]
Code: 89 10 c7 41 04 00 00 00 00 c7 01 00 00 00 00 fb 53 ff d6 5a

>>EIP; c011b6a0 <timer_bh+200/250>   <=====
Trace; c0117e7b <bh_action+1b/50>
Trace; c0117d96 <tasklet_hi_action+56/80>
Trace; c0117b73 <do_softirq+53/a0>
Trace; c0106f20 <ret_from_intr+0/7>
Trace; c0105380 <default_idle+0/30>
Trace; c01053a4 <default_idle+24/30>
Code;  c011b6a0 <timer_bh+200/250>
00000000 <_EIP>:
Code;  c011b6a0 <timer_bh+200/250>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c011b6a2 <timer_bh+202/250>
   2:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c011b6a9 <timer_bh+209/250>
   9:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011b6af <timer_bh+20f/250>
   f:   fb                        sti    
Code;  c011b6b0 <timer_bh+210/250>
  10:   53                        push   %ebx
Code;  c011b6b1 <timer_bh+211/250>
  11:   ff d6                     call   *%esi
Code;  c011b6b3 <timer_bh+213/250>
  13:   5a                        pop    %edx

Kernel panic: Aiee, killing interrupt handler!

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

