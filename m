Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWFAL7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWFAL7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWFAL7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:59:31 -0400
Received: from tornado.reub.net ([202.89.145.182]:21143 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030187AbWFAL7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:59:30 -0400
Message-ID: <447ED6A2.5000107@reub.net>
Date: Thu, 01 Jun 2006 23:59:30 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060531)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <20060601112551.GA5811@elte.hu>
In-Reply-To: <20060601112551.GA5811@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/06/2006 11:25 p.m., Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
>>> * Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>>
>>>>> A .config would be useful too.
>>>> Now up at 
>>>> http://www.reub.net/files/kernel/configs/2.6.17-rc5-mm2-x86_64.confg
>>> hm, i cannot reproduce the stack backtrace secondary crash with your 
>>> config. Weird.
>> ah, managed to reproduce it!
>>
>> Jan, the dwarf2 unwinder apparently fails if we call a NULL function. 
> 
> Reuben, the workaround would be to disable CONFIG_STACK_UNWIND.
> 
> 	Ingo

Ok, now with an identical config with the exception of this:

# CONFIG_STACK_UNWIND is not set

I did a full make mrproper after setting this (via menuconfig).

Not sure that this is much better unfortunately :(

ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000016100 ctl 0x0 bmdma 0x0 irq 58
ata2: SATA max UDMA/133 cmd 0xFFFFC20000016180 ctl 0x0 bmdma 0x0 irq 58
ata3: SATA max UDMA/133 cmd 0xFFFFC20000016200 ctl 0x0 bmdma 0x0 irq 58
ata4: SATA max UDMA/133 cmd 0xFFFFC20000016280 ctl 0x0 bmdma 0x0 irq 58
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
  [<0000000000000000>]
PGD 0
Oops: 0010 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #1
RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
RSP: 0000:ffffffff8065ef98  EFLAGS: 00010006
RAX: 0000000000003a00 RBX: ffffffff8090bec8 RCX: 0000000000000000
RDX: ffffffff8090bec8 RSI: ffffffff808fc100 RDI: 000000000000003a
RBP: ffffffff8065efb0 R08: 0000000000000001 R09: ffffffff80268f0a
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000003a
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 0, threadinfo ffffffff8090a000, task ffffffff805923e0)
Stack: ffffffff80271812 ffffffff8025f491 ffffffff8094c084 ffffffff8090bef0
        ffffffff80265a89  <EOI> ff6500005ccbe8fa 65c900000020250c 00000010250c8b48
        f700001fd8e98148 7400000003582444
Call Trace:
  <IRQ> [<ffffffff80271812>] do_IRQ+0x5f/0x7d
  [<ffffffff8025f491>] mwait_idle+0x0/0x54
  [<ffffffff80265a89>] ret_from_intr+0x0/0xf
  <EOI> [<ffffffff8045c748>] rtnetlink_rcv+0x54/0x58
  [<ffffffff8036bb09>] irqsafe4_soft_spin_321+0x64/0xe0
  [<ffffffff8036bb0a>] irqsafe4_soft_spin_321+0x65/0xe0
  [<ffffffff8036bb0d>] irqsafe4_soft_spin_321+0x68/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbba>] irqsafe4_soft_rlock_123+0x35/0xe0
  [<ffffffff8036bbbd>] irqsafe4_soft_rlock_123+0x38/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc6a>] irqsafe4_soft_rlock_132+0x5/0xe0
  [<ffffffff8036bc6d>] irqsafe4_soft_rlock_132+0x8/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd1a>] irqsafe4_soft_rlock_132+0xb5/0xe0
  [<ffffffff8036bd1d>] irqsafe4_soft_rlock_132+0xb8/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdca>] irqsafe4_soft_rlock_213+0x85/0xe0
  [<ffffffff8036bdcd>] irqsafe4_soft_rlock_213+0x88/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be7a>] irqsafe4_soft_rlock_231+0x55/0xe0
  [<ffffffff8036be7d>] irqsafe4_soft_rlock_231+0x58/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf50>] irqsafe4_soft_rlock_312+0x4b/0xe0
  [<ffffffff8036bf53>] irqsafe4_soft_rlock_312+0x4e/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c026>] irqsafe4_soft_rlock_321+0x41/0xe0
  [<ffffffff8036c029>] irqsafe4_soft_rlock_321+0x44/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fc>] irqsafe4_soft_wlock_123+0x37/0xe0
  [<ffffffff8036c0ff>] irqsafe4_soft_wlock_123+0x3a/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d2>] irqsafe4_soft_wlock_132+0x2d/0xe0
  [<ffffffff8036c1d5>] irqsafe4_soft_wlock_132+0x30/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a8>] irqsafe4_soft_wlock_213+0x23/0xe0
  [<ffffffff8036c2ab>] irqsafe4_soft_wlock_213+0x26/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37e>] irqsafe4_soft_wlock_231+0x19/0xe0
  [<ffffffff8036c381>] irqsafe4_soft_wlock_231+0x1c/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c454>] irqsafe4_soft_wlock_312+0xf/0xe0
  [<ffffffff8036c457>] irqsafe4_soft_wlock_312+0x12/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c52a>] irqsafe4_soft_wlock_321+0x5/0xe0
  [<ffffffff8036c52d>] irqsafe4_soft_wlock_321+0x8/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c600>] irqsafe4_soft_wlock_321+0xdb/0xe0
  [<ffffffff8036c603>] irqsafe4_soft_wlock_321+0xde/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d6>] irq_inversion_soft_spin_123+0xd1/0xe0
  [<ffffffff8036c6d9>] irq_inversion_soft_spin_123+0xd4/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ac>] irq_inversion_soft_spin_132+0xc7/0xe0
  [<ffffffff8036c7af>] irq_inversion_soft_spin_132+0xca/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c882>] irq_inversion_soft_spin_213+0xbd/0xe0
  [<ffffffff8036c885>] irq_inversion_soft_spin_213+0xc0/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c958>] irq_inversion_soft_spin_231+0xb3/0xe0
  [<ffffffff8036c95b>] irq_inversion_soft_spin_231+0xb6/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2e>] irq_inversion_soft_spin_312+0xa9/0xe0
  [<ffffffff8036ca31>] irq_inversion_soft_spin_312+0xac/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb04>] irq_inversion_soft_spin_321+0x9f/0xe0
  [<ffffffff8036cb07>] irq_inversion_soft_spin_321+0xa2/0xe0
  [<ffffffff8036cbd9>] irq_inversion_soft_rlock_123+0x94/0xe0
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [2] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #1
RIP: 0010:[<ffffffff8026fef9>]  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
RSP: 0000:ffffffff8065ecd8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: b100000000000074 RCX: 0000000000000000
RDX: ffffffff805923e0 RSI: 0000000000000001 RDI: ffffffff8059e680
RBP: ffffffff8065ed18 R08: 0000000000000003 R09: ffffffff804c6873
R10: 0000000000000000 R11: 0000000000000002 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 0, threadinfo ffffffff8090a000, task ffffffff805923e0)
Stack: ffffffff80218050 0000000000000001 000000008065ed18 ffffffff80265aa9
        000000000000000a ffffffff8065afc0 ffffffff8065efc0 0000000000000000
        ffffffff8065ed68 ffffffff80270049
Call Trace:
  <IRQ> [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80265aa9>] exit_intr+0x11/0x1a
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802a1cf6>] trace_hardirqs_on+0xdd/0x124
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff80268f0a>] thread_return+0x63/0x103
  [<ffffffff80271812>] do_IRQ+0x5f/0x7d
  [<ffffffff8025f491>] mwait_idle+0x0/0x54
  [<ffffffff80265a89>] ret_from_intr+0x0/0xf
  <EOI> [<ffffffff8045c748>] rtnetlink_rcv+0x54/0x58
  [<ffffffff8036bb09>] irqsafe4_soft_spin_321+0x64/0xe0
  [<ffffffff8036bb0a>] irqsafe4_soft_spin_321+0x65/0xe0
  [<ffffffff8036bb0d>] irqsafe4_soft_spin_321+0x68/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbba>] irqsafe4_soft_rlock_123+0x35/0xe0
  [<ffffffff8036bbbd>] irqsafe4_soft_rlock_123+0x38/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc6a>] irqsafe4_soft_rlock_132+0x5/0xe0
  [<ffffffff8036bc6d>] irqsafe4_soft_rlock_132+0x8/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd1a>] irqsafe4_soft_rlock_132+0xb5/0xe0
  [<ffffffff8036bd1d>] irqsafe4_soft_rlock_132+0xb8/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdca>] irqsafe4_soft_rlock_213+0x85/0xe0
  [<ffffffff8036bdcd>] irqsafe4_soft_rlock_213+0x88/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be7a>] irqsafe4_soft_rlock_231+0x55/0xe0
  [<ffffffff8036be7d>] irqsafe4_soft_rlock_231+0x58/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf50>] irqsafe4_soft_rlock_312+0x4b/0xe0
  [<ffffffff8036bf53>] irqsafe4_soft_rlock_312+0x4e/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c026>] irqsafe4_soft_rlock_321+0x41/0xe0
  [<ffffffff8036c029>] irqsafe4_soft_rlock_321+0x44/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fc>] irqsafe4_soft_wlock_123+0x37/0xe0
  [<ffffffff8036c0ff>] irqsafe4_soft_wlock_123+0x3a/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d2>] irqsafe4_soft_wlock_132+0x2d/0xe0
  [<ffffffff8036c1d5>] irqsafe4_soft_wlock_132+0x30/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a8>] irqsafe4_soft_wlock_213+0x23/0xe0
  [<ffffffff8036c2ab>] irqsafe4_soft_wlock_213+0x26/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37e>] irqsafe4_soft_wlock_231+0x19/0xe0
  [<ffffffff8036c381>] irqsafe4_soft_wlock_231+0x1c/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c454>] irqsafe4_soft_wlock_312+0xf/0xe0
  [<ffffffff8036c457>] irqsafe4_soft_wlock_312+0x12/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c52a>] irqsafe4_soft_wlock_321+0x5/0xe0
  [<ffffffff8036c52d>] irqsafe4_soft_wlock_321+0x8/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c600>] irqsafe4_soft_wlock_321+0xdb/0xe0
  [<ffffffff8036c603>] irqsafe4_soft_wlock_321+0xde/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d6>] irq_inversion_soft_spin_123+0xd1/0xe0
  [<ffffffff8036c6d9>] irq_inversion_soft_spin_123+0xd4/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ac>] irq_inversion_soft_spin_132+0xc7/0xe0
  [<ffffffff8036c7af>] irq_inversion_soft_spin_132+0xca/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c882>] irq_inversion_soft_spin_213+0xbd/0xe0
  [<ffffffff8036c885>] irq_inversion_soft_spin_213+0xc0/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c958>] irq_inversion_soft_spin_231+0xb3/0xe0
  [<ffffffff8036c95b>] irq_inversion_soft_spin_231+0xb6/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2e>] irq_inversion_soft_spin_312+0xa9/0xe0
  [<ffffffff8036ca31>] irq_inversion_soft_spin_312+0xac/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb04>] irq_inversion_soft_spin_321+0x9f/0xe0
  [<ffffffff8036cb07>] irq_inversion_soft_spin_321+0xa2/0xe0
  [<ffffffff8036cbd9>] irq_inversion_soft_rlock_123+0x94/0xe0
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [3] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #1
RIP: 0010:[<ffffffff8026fef9>]  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
RSP: 0000:ffffffff8065ea18  EFLAGS: 00010006
RAX: 0000000000000000 RBX: b100000000000074 RCX: 0000000000000000
RDX: ffffffff805923e0 RSI: 0000000000000001 RDI: ffffffff8059e680
RBP: ffffffff8065ea58 R08: 0000000000000003 R09: ffffffff804c6873
R10: 0000000000000000 R11: 0000000000000002 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 0, threadinfo ffffffff8090a000, task ffffffff805923e0)
Stack: ffffffff80218050 0000000000000001 000000008065ea58 ffffffff8065ed20
        000000000000000a ffffffff8065afc0 ffffffff8065efc0 0000000000000000
        ffffffff8065eaa8 ffffffff80270049
Call Trace:
  <IRQ> [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
  [<ffffffff8026ff05>] show_trace+0x15e/0x1a2
  [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80265aa9>] exit_intr+0x11/0x1a
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802a1cf6>] trace_hardirqs_on+0xdd/0x124
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff80268f0a>] thread_return+0x63/0x103
  [<ffffffff80271812>] do_IRQ+0x5f/0x7d
  [<ffffffff8025f491>] mwait_idle+0x0/0x54
  [<ffffffff80265a89>] ret_from_intr+0x0/0xf
  <EOI> [<ffffffff8045c748>] rtnetlink_rcv+0x54/0x58
  [<ffffffff8036bb09>] irqsafe4_soft_spin_321+0x64/0xe0
  [<ffffffff8036bb0a>] irqsafe4_soft_spin_321+0x65/0xe0
  [<ffffffff8036bb0d>] irqsafe4_soft_spin_321+0x68/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbba>] irqsafe4_soft_rlock_123+0x35/0xe0
  [<ffffffff8036bbbd>] irqsafe4_soft_rlock_123+0x38/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc6a>] irqsafe4_soft_rlock_132+0x5/0xe0
  [<ffffffff8036bc6d>] irqsafe4_soft_rlock_132+0x8/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd1a>] irqsafe4_soft_rlock_132+0xb5/0xe0
  [<ffffffff8036bd1d>] irqsafe4_soft_rlock_132+0xb8/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdca>] irqsafe4_soft_rlock_213+0x85/0xe0
  [<ffffffff8036bdcd>] irqsafe4_soft_rlock_213+0x88/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be7a>] irqsafe4_soft_rlock_231+0x55/0xe0
  [<ffffffff8036be7d>] irqsafe4_soft_rlock_231+0x58/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf50>] irqsafe4_soft_rlock_312+0x4b/0xe0
  [<ffffffff8036bf53>] irqsafe4_soft_rlock_312+0x4e/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c026>] irqsafe4_soft_rlock_321+0x41/0xe0
  [<ffffffff8036c029>] irqsafe4_soft_rlock_321+0x44/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fc>] irqsafe4_soft_wlock_123+0x37/0xe0
  [<ffffffff8036c0ff>] irqsafe4_soft_wlock_123+0x3a/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d2>] irqsafe4_soft_wlock_132+0x2d/0xe0
  [<ffffffff8036c1d5>] irqsafe4_soft_wlock_132+0x30/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a8>] irqsafe4_soft_wlock_213+0x23/0xe0
  [<ffffffff8036c2ab>] irqsafe4_soft_wlock_213+0x26/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37e>] irqsafe4_soft_wlock_231+0x19/0xe0
  [<ffffffff8036c381>] irqsafe4_soft_wlock_231+0x1c/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c454>] irqsafe4_soft_wlock_312+0xf/0xe0
  [<ffffffff8036c457>] irqsafe4_soft_wlock_312+0x12/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c52a>] irqsafe4_soft_wlock_321+0x5/0xe0
  [<ffffffff8036c52d>] irqsafe4_soft_wlock_321+0x8/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c600>] irqsafe4_soft_wlock_321+0xdb/0xe0
  [<ffffffff8036c603>] irqsafe4_soft_wlock_321+0xde/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d6>] irq_inversion_soft_spin_123+0xd1/0xe0
  [<ffffffff8036c6d9>] irq_inversion_soft_spin_123+0xd4/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ac>] irq_inversion_soft_spin_132+0xc7/0xe0
  [<ffffffff8036c7af>] irq_inversion_soft_spin_132+0xca/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c882>] irq_inversion_soft_spin_213+0xbd/0xe0
  [<ffffffff8036c885>] irq_inversion_soft_spin_213+0xc0/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c958>] irq_inversion_soft_spin_231+0xb3/0xe0
  [<ffffffff8036c95b>] irq_inversion_soft_spin_231+0xb6/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2e>] irq_inversion_soft_spin_312+0xa9/0xe0
  [<ffffffff8036ca31>] irq_inversion_soft_spin_312+0xac/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb04>] irq_inversion_soft_spin_321+0x9f/0xe0
  [<ffffffff8036cb07>] irq_inversion_soft_spin_321+0xa2/0xe0
  [<ffffffff8036cbd9>] irq_inversion_soft_rlock_123+0x94/0xe0
Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [4] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #1
RIP: 0010:[<ffffffff8026fef9>]  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
RSP: 0000:ffffffff8065e758  EFLAGS: 00010006
RAX: 0000000000000000 RBX: b100000000000074 RCX: 0000000000000000
RDX: ffffffff805923e0 RSI: 0000000000000001 RDI: ffffffff8059e680
RBP: ffffffff8065e798 R08: 0000000000000003 R09: ffffffff804c6873
R10: 0000000000000000 R11: 0000000000000002 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 0, threadinfo ffffffff8090a000, task ffffffff805923e0)
Stack: ffffffff80218050 0000000000000001 000000008065e798 ffffffff8065ea60
        000000000000000a ffffffff8065afc0 ffffffff8065efc0 0000000000000000
        ffffffff8065e7e8 ffffffff80270049
Call Trace:
  <IRQ> [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
  [<ffffffff8026ff05>] show_trace+0x15e/0x1a2
  [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff8026fef9>] show_trace+0x152/0x1a2
  [<ffffffff8026ff05>] show_trace+0x15e/0x1a2
  [<ffffffff80218050>] release_console_sem+0x20/0x247
  [<ffffffff80265aa9>] exit_intr+0x11/0x1a
  [<ffffffff80270049>] _show_stack+0xe9/0xf8
  [<ffffffff802700e4>] show_registers+0x8c/0x101
  [<ffffffff802701f9>] __die+0xa0/0xe3
  [<ffffffff8020b16e>] do_page_fault+0x86e/0x9c4
  [<ffffffff802a2bfd>] __lockdep_acquire+0xb4d/0xc06
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802a1cf6>] trace_hardirqs_on+0xdd/0x124
  [<ffffffff8026c058>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802662bd>] error_exit+0x0/0x8e
  [<ffffffff80268f0a>] thread_return+0x63/0x103
  [<ffffffff80271812>] do_IRQ+0x5f/0x7d
  [<ffffffff8025f491>] mwait_idle+0x0/0x54
  [<ffffffff80265a89>] ret_from_intr+0x0/0xf
  <EOI> [<ffffffff8045c748>] rtnetlink_rcv+0x54/0x58
  [<ffffffff8036bb09>] irqsafe4_soft_spin_321+0x64/0xe0
  [<ffffffff8036bb0a>] irqsafe4_soft_spin_321+0x65/0xe0
  [<ffffffff8036bb0d>] irqsafe4_soft_spin_321+0x68/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbb9>] irqsafe4_soft_rlock_123+0x34/0xe0
  [<ffffffff8036bbba>] irqsafe4_soft_rlock_123+0x35/0xe0
  [<ffffffff8036bbbd>] irqsafe4_soft_rlock_123+0x38/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc69>] irqsafe4_soft_rlock_132+0x4/0xe0
  [<ffffffff8036bc6a>] irqsafe4_soft_rlock_132+0x5/0xe0
  [<ffffffff8036bc6d>] irqsafe4_soft_rlock_132+0x8/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd19>] irqsafe4_soft_rlock_132+0xb4/0xe0
  [<ffffffff8036bd1a>] irqsafe4_soft_rlock_132+0xb5/0xe0
  [<ffffffff8036bd1d>] irqsafe4_soft_rlock_132+0xb8/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdc9>] irqsafe4_soft_rlock_213+0x84/0xe0
  [<ffffffff8036bdca>] irqsafe4_soft_rlock_213+0x85/0xe0
  [<ffffffff8036bdcd>] irqsafe4_soft_rlock_213+0x88/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be79>] irqsafe4_soft_rlock_231+0x54/0xe0
  [<ffffffff8036be7a>] irqsafe4_soft_rlock_231+0x55/0xe0
  [<ffffffff8036be7d>] irqsafe4_soft_rlock_231+0x58/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf4f>] irqsafe4_soft_rlock_312+0x4a/0xe0
  [<ffffffff8036bf50>] irqsafe4_soft_rlock_312+0x4b/0xe0
  [<ffffffff8036bf53>] irqsafe4_soft_rlock_312+0x4e/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c025>] irqsafe4_soft_rlock_321+0x40/0xe0
  [<ffffffff8036c026>] irqsafe4_soft_rlock_321+0x41/0xe0
  [<ffffffff8036c029>] irqsafe4_soft_rlock_321+0x44/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fb>] irqsafe4_soft_wlock_123+0x36/0xe0
  [<ffffffff8036c0fc>] irqsafe4_soft_wlock_123+0x37/0xe0
  [<ffffffff8036c0ff>] irqsafe4_soft_wlock_123+0x3a/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d1>] irqsafe4_soft_wlock_132+0x2c/0xe0
  [<ffffffff8036c1d2>] irqsafe4_soft_wlock_132+0x2d/0xe0
  [<ffffffff8036c1d5>] irqsafe4_soft_wlock_132+0x30/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a7>] irqsafe4_soft_wlock_213+0x22/0xe0
  [<ffffffff8036c2a8>] irqsafe4_soft_wlock_213+0x23/0xe0
  [<ffffffff8036c2ab>] irqsafe4_soft_wlock_213+0x26/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37d>] irqsafe4_soft_wlock_231+0x18/0xe0
  [<ffffffff8036c37e>] irqsafe4_soft_wlock_231+0x19/0xe0
  [<ffffffff8036c381>] irqsafe4_soft_wlock_231+0x1c/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c453>] irqsafe4_soft_wlock_312+0xe/0xe0
  [<ffffffff8036c454>] irqsafe4_soft_wlock_312+0xf/0xe0
  [<ffffffff8036c457>] irqsafe4_soft_wlock_312+0x12/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c529>] irqsafe4_soft_wlock_321+0x4/0xe0
  [<ffffffff8036c52a>] irqsafe4_soft_wlock_321+0x5/0xe0
  [<ffffffff8036c52d>] irqsafe4_soft_wlock_321+0x8/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c5ff>] irqsafe4_soft_wlock_321+0xda/0xe0
  [<ffffffff8036c600>] irqsafe4_soft_wlock_321+0xdb/0xe0
  [<ffffffff8036c603>] irqsafe4_soft_wlock_321+0xde/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d5>] irq_inversion_soft_spin_123+0xd0/0xe0
  [<ffffffff8036c6d6>] irq_inversion_soft_spin_123+0xd1/0xe0
  [<ffffffff8036c6d9>] irq_inversion_soft_spin_123+0xd4/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ab>] irq_inversion_soft_spin_132+0xc6/0xe0
  [<ffffffff8036c7ac>] irq_inversion_soft_spin_132+0xc7/0xe0
  [<ffffffff8036c7af>] irq_inversion_soft_spin_132+0xca/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c881>] irq_inversion_soft_spin_213+0xbc/0xe0
  [<ffffffff8036c882>] irq_inversion_soft_spin_213+0xbd/0xe0
  [<ffffffff8036c885>] irq_inversion_soft_spin_213+0xc0/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c957>] irq_inversion_soft_spin_231+0xb2/0xe0
  [<ffffffff8036c958>] irq_inversion_soft_spin_231+0xb3/0xe0
  [<ffffffff8036c95b>] irq_inversion_soft_spin_231+0xb6/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2d>] irq_inversion_soft_spin_312+0xa8/0xe0
  [<ffffffff8036ca2e>] irq_inversion_soft_spin_312+0xa9/0xe0
  [<ffffffff8036ca31>] irq_inversion_soft_spin_312+0xac/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb03>] irq_inversion_soft_spin_321+0x9e/0xe0
  [<ffffffff8036cb04>] irq_inversion_soft_spin_321+0x9f/0xe0
  [<ffffffff8036cb07>] irq_inversion_soft_spin_321+0xa2/0xe0

apkm: the x.tar.bz2 from a day ago that I tried works fine, so it's something 
that has gone into -mm in the last 24 or so hours...

reuben
