Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310451AbSCLHCU>; Tue, 12 Mar 2002 02:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310459AbSCLHCL>; Tue, 12 Mar 2002 02:02:11 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:23779 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310451AbSCLHB7>; Tue, 12 Mar 2002 02:01:59 -0500
Date: Tue, 12 Mar 2002 08:46:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: rml@tech9.net
Subject: Re: Few questions about 2.5.6-pre3
In-Reply-To: <Pine.LNX.4.44.0203110947110.19020-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203120842570.17313-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Zwane Mwaikambo wrote:

> 2.5.6-pre3 SMP:
> 
> This one is a funny one, it dies *right* after mtrr_init, and even if i 
> put a BUG() after mtrr_init, it never gets executed. This one happens to 
> die in the scheduler when we try and release_kernel_lock(prev, 
> smp_processor_id()) It already is released so we trigger an Oops in 
> spinlock.h:107

Not sure wether this is a known issue but disabling CONFIG_PREEMPT booted 
this box. Robert, here is the oops, if you want me to test a couple 
things just send them my way, but its a high latency test box ;) so you 
might have to wait a while between replies.

Cheers,
	Zwane

Right after mtrr_init in main.c, note that a BUG() after mtrr_init will 
not get triggered. Sorry the oops doesn't reveal much though, perhaps you 
need some specific information?

kernel BUG at /home/zwane/build/source/linux-2.5.6-pre/include/asm/spinlock.h:107!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011b09b>]    Not tainted
EFLAGS: 00010002
eax: 00000001   ebx: c0348000   ecx: 00000000   edx: c032c001
esi: c038b8a0   edi: 00000000   ebp: c0349f64   esp: c0349f48
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c0348000 task=c032c060)
Stack: c0213532 c0213558 c03fe020 c032c060 c0348000 c038b8a0 00000000 c0349f88
       c011b0b9 c03c58c0 00000246 c0105000 c032c060 c03c591c 00000246 0000005c
       0008e000 c01206f0 c02e7c5b c0348000 c0105000 c0350783 c02e3800 c02e864c
Call Trace: [<c0213532>] [<c0213558>] [<c011b0b9>] [<c0105000>] [<c01206f0>]
   [<c0105000>] [<c0105000>]

Code: 0f 0b 6b 00 e0 d2 2d c0 86 15 00 a4 38 c0 ff 4b 10 8b 43 08
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

>>EIP; c011b09b <schedule+8b/470>   <=====
Trace; c0213532 <serial_console_write+142/1e0>
Trace; c0213558 <serial_console_write+168/1e0>
Trace; c011b0b9 <schedule+a9/470>
Trace; c0105000 <_stext+0/0>
Trace; c01206f0 <printk+1a0/210>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c011b09b <schedule+8b/470>
00000000 <_EIP>:
Code;  c011b09b <schedule+8b/470>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011b09d <schedule+8d/470>
   2:   6b 00 e0                  imul   $0xffffffe0,(%eax),%eax
Code;  c011b0a0 <schedule+90/470>
   5:   d2 2d c0 86 15 00         shrb   %cl,0x1586c0
Code;  c011b0a6 <schedule+96/470>
   b:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c011b0a7 <schedule+97/470>
   c:   38 c0                     cmp    %al,%al
Code;  c011b0a9 <schedule+99/470>
   e:   ff 4b 10                  decl   0x10(%ebx)
Code;  c011b0ac <schedule+9c/470>
  11:   8b 43 08                  mov    0x8(%ebx),%eax


