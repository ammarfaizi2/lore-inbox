Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTDVC7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTDVC7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:59:24 -0400
Received: from uida4-8.inav.uiowa.net ([64.6.83.152]:640 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262884AbTDVC7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:59:21 -0400
Date: Mon, 21 Apr 2003 22:11:21 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 Oops and loss of keyboard
Message-ID: <20030422031117.GA447@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.21-pre7, I get the following:

Warning: kfree_skb passed an skb still on a list (from c011b1a4).
kernel BUG at skbuff.c:315!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c02268db>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 00000045   ebx: c5e84440   ecx: 00000001   edx: c9546000
esi: c9f73f8c   edi: 00000000   ebp: c9f72000   esp: c9f73f78
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c9f73000)
Stack: c02b4240 c011b1a4 c9f73f8c c011b1a4 c5e84440 c94282e4 c94282e4 ffffffff 
c9f72568 c01233fc c02ccdb0 c9f72560 c9f72570 c9f72000 00000001 00000000 
c02ca7e0 00010000 00000000 00000700 c01232e0 c031e500 00000000 c9f72000 
Call Trace:    [<c011b1a4>] [<c011b1a4>] [<c01233fc>] [<c01232e0>] [<c0105000>]
[<c01056c6>] [<c01232e0>]
Code: 0f 0b 3b 01 7b 32 2b c0 58 5a 8b 5c 24 08 e9 e2 fe ff ff 90 


>>EIP; c02268db <__kfree_skb+11b/140>   <=====

>>ebx; c5e84440 <_end+5b39714/a501334>
>>edx; c9546000 <_end+91fb2d4/a501334>
>>esi; c9f73f8c <_end+9c29260/a501334>
>>ebp; c9f72000 <_end+9c272d4/a501334>
>>esp; c9f73f78 <_end+9c2924c/a501334>

Trace; c011b1a4 <__run_task_queue+44/60>
Trace; c011b1a4 <__run_task_queue+44/60>
Trace; c01233fc <context_thread+11c/1c0>
Trace; c01232e0 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01056c6 <arch_kernel_thread+26/40>
Trace; c01232e0 <context_thread+0/1c0>

Code;  c02268db <__kfree_skb+11b/140>
00000000 <_EIP>:
Code;  c02268db <__kfree_skb+11b/140>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02268dd <__kfree_skb+11d/140>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c02268df <__kfree_skb+11f/140>
   4:   7b 32                     jnp    38 <_EIP+0x38>
Code;  c02268e1 <__kfree_skb+121/140>
   6:   2b c0                     sub    %eax,%eax
Code;  c02268e3 <__kfree_skb+123/140>
   8:   58                        pop    %eax
Code;  c02268e4 <__kfree_skb+124/140>
   9:   5a                        pop    %edx
Code;  c02268e5 <__kfree_skb+125/140>
   a:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  c02268e9 <__kfree_skb+129/140>
   e:   e9 e2 fe ff ff            jmp    fffffef5 <_EIP+0xfffffef5>
Code;  c02268ee <__kfree_skb+12e/140>
  13:   90                        nop    

The keyboard then goes away (at least under X, which makes switching to
  a VC impossible).  Mouse still works, though.  It seems like the system
  is very broken at that point, though.
It's interesting to note, though, that SysRq still works.

Additionally, I've noticed that Ctrl+Alt+SysRq+S (dunno about other keys
  other than S) locks in the Magic SysRq stuff.  That is, all keys pressed
  after that is interpreted as having been typed with Alt+SysRq.  Is kind
  of a pain because, of course, you can't switch VCs or do anything but 
  reboot.  Plain Alt+SysRq+S works fine.  (It might also be the fact that
  I've swapped CapsLock and the left Ctrl keys in my keymap, but 
  everything works fine otherwise, so I dunno).

Thanks for any help.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Isn't it illegal for Microsoft to tie any of its software products to its
  OS?"  --Rob Riggs on slashdot (www.slashdot.org) about Microsoft's order
  to cease and decist using Visual Fox Pro on Linux, a non-Microsoft OS.
"Yes. The penalty is dinner with no dessert." --Alien Being, response
