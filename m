Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbULCWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbULCWwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbULCWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:52:06 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:46208
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262450AbULCWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:51:52 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <1102113437.13353.290.camel@tglx.tec.linutronix.de>
References: <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202233459.GF32635@dualathlon.random>
	 <20041203022854.GL32635@dualathlon.random>
	 <1102113437.13353.290.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 23:51:50 +0100
Message-Id: <1102114310.13353.298.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops, sorry it did add something to the Log after 10 minutes

On Fri, 2004-12-03 at 23:37 +0100, Thomas Gleixner wrote:
> You're right. oom-kill() did not do anything wrong. See log below
> 
> This is w/o PREEMPT. Is it neccecary to verify w/ PREEMPT too ?
> 
> If it would have booted it still would have killed sshd instead of the
> application which was forking a lot of childs.
> 
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> 
> END OF LOG

Unable to handle kernel NULL pointer dereference at virtual address
0000000c
 printing eip:
c011fe30
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c011fe30>]    Not tainted VLI
EFLAGS: 00010082   (2.6.10-rc2)
EIP is at __queue_work+0x20/0x60
eax: 00000000   ebx: c032cc80   ecx: 00000000   edx: 00000008
esi: c03acd14   edi: 00000282   ebp: c035ff64   esp: c035ff34
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c035e000 task=c02ebb00)
Stack: c035ffa4 00000000 c03acd14 c035ff64 c011fe99 00000000 c032cc80
c01dd8b0
       c0119c20 00000000 00000000 c035ffa4 c035ff64 c035ff64 00000000
00000001
       c03a5868 0000000a 003d9007 c0115f3b c03a5868 00000046 00099100
c039e120
Call Trace:
 [<c011fe99>] queue_work+0x29/0x50
 [<c01dd8b0>] blank_screen_t+0x0/0x20
 [<c0119c20>] run_timer_softirq+0xb0/0x170
 [<c0115f3b>] __do_softirq+0x7b/0x90
 [<c0115f77>] do_softirq+0x27/0x30
 [<c010411e>] do_IRQ+0x1e/0x30
 [<c010271e>] common_interrupt+0x1a/0x20
 [<c0100623>] default_idle+0x23/0x40
 [<c01006b4>] cpu_idle+0x34/0x40
 [<c03607d8>] start_kernel+0x168/0x1b0
 [<c0360370>] unknown_bootoption+0x0/0x1e0
Code: eb e5 90 90 90 90 90 90 90 90 90 83 ec 10 8b 44 24 14 89 5c 24 04
8b 5c 2
 <0>Kernel panic - not syncing: Fatal exception in interrupt


