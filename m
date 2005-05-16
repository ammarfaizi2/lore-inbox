Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVEPLaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVEPLaC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVEPL3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:29:34 -0400
Received: from tim.rpsys.net ([194.106.48.114]:16345 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261560AbVEPL3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:29:09 -0400
Message-ID: <018201c55a0a$75a99cf0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20050512033100.017958f6.akpm@osdl.org> <01a101c55877$e84e1130$0f01a8c0@max>
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 12:27:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For reference, the oops below still occurs with 2.6.12-rc4-mm2. I've noticed 
that "/sbin/init: error while loading shared libraries: /sbin/init: Cannot 
allocate version reference table: Cannot allocate Memory" appears on the 
console just before the "Kernel panic".

2.6.12-rc4, 2.6.12-rc3-mm2 and  2.6.12-rc3-mm3 all work with the same root 
filesystem which suggests this is a kernel issue of some sort.

Richard Purdie:
> 2.6.12-rc4-mm1 on a Sharp Zaurus (arm pxa255) results in:
>
> VFS: Mounted root (jffs2 filesystem) readonly.
> Freeing init memory: 76K
> Kernel panic - not syncing: Attempted to kill init!
> <3>BUG: soft lockup detected on CPU#0!
>
> Pid: 1, comm:                 init
> CPU: 0
> PC is at __delay+0x0/0xc
> LR is at panic+0x108/0x130
> pc : [<c00f71ac>]    lr : [<c0037140>]    Not tainted
> sp : c0301f4c  ip : c0301f4c  fp : c0301f58
> r10: 4001d000  r9 : c0300000  r8 : 00007f00
> r7 : c0300000  r6 : c027a3e8  r5 : c027a3e4  r4 : 0000240b
> r3 : 60000013  r2 : 000003ca  r1 : 00000000  r0 : 00017133
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: 397F  Table: A1CB0000  DAC: 00000015
> [<c0059c90>] (softlockup_tick+0x0/0xa0) from [<c0021020>] 
> (timer_tick+0xb4/0xf8)
> r5 = C0300000  r4 = C0301F04
> [<c0020f6c>] (timer_tick+0x0/0xf8) from [<c00277e0>] 
> (pxa_timer_interrupt+0x48/0xa8)
> r6 = C0301F04  r5 = C0300000  r4 = F2A00000
> [<c0027798>] (pxa_timer_interrupt+0x0/0xa8) from [<c001cbc4>] 
> (__do_irq+0x6c/0xc4)
> r8 = C0301F04  r7 = 00000000  r6 = 00000000  r5 = C0300000
> r4 = C0230374
> [<c001cb58>] (__do_irq+0x0/0xc4) from [<c001ce48>] 
> (do_level_IRQ+0x68/0xb8)
> [<c001cde0>] (do_level_IRQ+0x0/0xb8) from [<c001ceec>] 
> (asm_do_IRQ+0x54/0x160)
> r6 = 04000000  r5 = F2D00000  r4 = FFFFFFFF
> [<c001ce98>] (asm_do_IRQ+0x0/0x160) from [<c001ba14>] 
> (__irq_svc+0x34/0x74)
> [<c0037038>] (panic+0x0/0x130) from [<c003a22c>] (do_exit+0x7c8/0xda4)
> r3 = 00000001  r2 = C02E8E40  r1 = C02E8D60  r0 = C02004C0
> [<c0039a64>] (do_exit+0x0/0xda4) from [<c003a900>] 
> (do_group_exit+0xc0/0x104)
> [<c003a840>] (do_group_exit+0x0/0x104) from [<c001be20>] 
> (ret_fast_syscall+0x0/0x2c)
> r5 = 00000000  r4 = 0000002F
>
> There was an extremely long pause after it printed "Kernel panic ..." 
> before it printed the traceback.

