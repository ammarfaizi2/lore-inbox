Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUFVHVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUFVHVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 03:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUFVHVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 03:21:47 -0400
Received: from mail.sitix.net ([195.143.10.20]:12186 "EHLO mail.sitix.net")
	by vger.kernel.org with ESMTP id S261179AbUFVHVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 03:21:42 -0400
Message-ID: <43914.194.97.5.114.1087888877.squirrel@194.97.5.114>
Date: Tue, 22 Jun 2004 09:21:17 +0200 (CEST)
Subject: Reproducable kernel 2.6.7 panic with AVM B1 and flood ping
From: "Oliver Siegmar" <oliver.siegmar@xams.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-MailScanner: Found to be clean
X-SITIX-MailScanner: Found to be clean
X-SITIX-MailScanner-SpamScore: s
X-MailScanner-From: oliver.siegmar@xams.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I installed a AVM B1 card in my router to have a fallback when DSL fails.
I downloaded an up-to-date version of capi4k-utils - capi4k-utils-2004-06-14
and compiled the sources against 2.6.7.

After establishing a connection I tried to get the router routing over the
ppp0 interface. To get some IO, I started a flood ping from an internal
machine to an outside one (yeah, the outside was also mine :)).

This crashes the kernel reproducable:

Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029710e>]    Not tainted
EFLAGS: 00010046   (2.6.7)
EIP is at skb_dequeue+0x1e/0x40
eax: 00000000   ebx: 00000206   ecx: d7dcea00   edx: d0b78d6c
esi: d0b78d2c   edi: 00000000   ebp: 0000006b   esp: d7f89f08
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=d7f88000 task=d7f8eb30)
Stack: d7dcea00 c0287dbc d0b78d6c d7dcea00 d0b78d2c d0b78d6c 00000001
00000055
       d3f24048 d3f24080 d3f24070 c02845a0 c0284606 d0b78d2c d629cc40
00000293
       d3f24048 d3f24090 c012235d d3f24048 d7f89f74 00000000 d7fa4ec4
d7f88000

Call Trace:

 [<c0287dbc>] handle_minor_send+0x3c/0x240
 [<c02845a0>] recv_handler+0x0/0x80
 [<c0284606>] recv_handler+0x66/0x80
 [<c012235d>] worker_thread+0x1ad/0x250
 [<c0112740>] default_wake_function+0x0/0x20
 [<c0112740>] default_wake_function+0x0/0x20
 [<c01221b0>] worker_thread+0x0/0x250
 [<c012544a>] kthread+0xaa/0xb0
 [<c01253a0>] kthread+0x0/0xb0
 [<c01020fd>] kernel_thread_helper+0x5/0x18

Code: 89 50 04 89 02 c7 41 04 00 00 00 00 c7 01 00 00 00 00 53 9d

 <3>KERNEL: assertion (!atomic_read(&skb->users)) failed at net/core/dev.c
(1666)

Warning: kfree_skb passed an skb still on a list (from c029a316).

------------[ cut here ]------------

kernel BUG at net/core/skbuff.c:225!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c0295ab4>]    Not tainted
EFLAGS: 00010282   (2.6.7)
EIP is at __kfree_skb+0x104/0x120
eax: 00000045   ebx: d629cc40   ecx: 00000001   edx: c03571b8
esi: d7dcea00   edi: 0000000a   ebp: 00000006   esp: d7f89d68
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=d7f88000 task=d7f8eb30)

Stack: c034cd00 c029a316 d7dcea00 d629cc40 c029a316 d7dcea00 c034adc7
c034adb0
       00000682 00000001 c04099d0 c01187fb c04099d0 00000046 00000000
c039fa00
       c0118827 00000000 c0106345 00000000 c039fa00 00000001 ffffe000
00000002

Call Trace:

 [<c029a316>] net_tx_action+0x46/0xd0
 [<c029a316>] net_tx_action+0x46/0xd0
 [<c01187fb>] __do_softirq+0x7b/0x80
 [<c0118827>] do_softirq+0x27/0x30
 [<c0106345>] do_IRQ+0xc5/0xf0
 [<c0110cd0>] do_page_fault+0x0/0x530
 [<c01046ec>] common_interrupt+0x18/0x20
 [<c0110cd0>] do_page_fault+0x0/0x530
 [<c011007b>] end_level_ioapic_irq+0x3b/0xc0
 [<c0104e28>] die+0x78/0xd0
 [<c0110f43>] do_page_fault+0x273/0x530
 [<c0111f7d>] wake_up_process+0x1d/0x30
 [<c0110cd0>] do_page_fault+0x0/0x530
 [<c0104789>] error_code+0x2d/0x38
 [<c029710e>] skb_dequeue+0x1e/0x40
 [<c0287dbc>] handle_minor_send+0x3c/0x240
 [<c02845a0>] recv_handler+0x0/0x80
 [<c0284606>] recv_handler+0x66/0x80
 [<c012235d>] worker_thread+0x1ad/0x250
 [<c0112740>] default_wake_function+0x0/0x20
 [<c0112740>] default_wake_function+0x0/0x20
 [<c01221b0>] worker_thread+0x0/0x250
 [<c012544a>] kthread+0xaa/0xb0
 [<c01253a0>] kthread+0x0/0xb0
 [<c01020fd>] kernel_thread_helper+0x5/0x18


Code: 0f 0b e1 00 9a ac 34 c0 8b 4c 24 14 e9 fe fe ff ff 8d 74 26

 <0>Kernel panic: Fatal exception in interrupt

In interrupt handler - not syncing


Let me know if I can assist (give more information, test patches, ...)


Cheers,
Oliver


