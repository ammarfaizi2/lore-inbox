Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUICLq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUICLq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269634AbUICLq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:46:58 -0400
Received: from pop.gmx.net ([213.165.64.20]:18069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269630AbUICLqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:46:54 -0400
X-Authenticated: #4399952
Date: Fri, 3 Sep 2004 13:59:19 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903135919.719db41d@mango.fruits.de>
In-Reply-To: <20040903103244.GB23726@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	<20040903100946.GA22819@elte.hu>
	<20040903123139.565c806b@mango.fruits.de>
	<20040903103244.GB23726@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 12:32:44 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > best would be to enable the NMI watchdog (nmi_watchdog=1 (or 2)
> > > boot option) - check that it's working via the attached
> > > lockupcli.c userspace code (run it as root). To have an NMI
> > > watchdog you need APIC/IOAPIC support in the .config.
> > 
> > Hmm, my local APIC kinda sux and i had all kinds of trouble using it
> > [ERR count went up, stuff didn't work; XT-PIC always worked very
> > well here]. So i'm kinda reluctant to compile with APIC. I suppose i
> > can compile with it but turn it off via boot option? Or does the
> > watchdog need a APIC that actually does stuff? 
> 
> in theory you should be able to boot with just the local APIC enabled
> and "nmi_watchdog=2" and get a working NMI watchdog. You'll still have
> the normal PIC IRQ handling.
> 
> 	Ingo
> 

ok, here you go [mental note to myself: get a second computer or a
digital camera :), maybe my ZX81 will do]. This is what is saw on my
console [sometimes i got lazy in between, i hope not at the wrong
spots]:

[<c0105e29>] do_signal+0x79/0x110
[<c01162a0>] default_wake_function+0x0/0x20
  c012fgd7   do_futex+0x47/0xa0
  c012fb20   sys_futex
  c0103f07   do_notify
  c01060e6   work_notifysig
Code: 96 54 01 00 00 8e e0 8e e8 85 d2 74 11 c7 86 54 01 00 00 00 00 00
00 89 d0 e8 bb e4 ff 8b 9e 5c 01 00 00 85 db 74 09 8b 45 0c <8b> 40 20
48 78 08 8b 5d f8 8b 75 fc c9 c3 c7 86 56 01 00 00 00 
<6> note: scsynth exited with preempt count 1
Unable to handle kernel NULL pointer dereference at virtual adress
00000020 printing eip:
c0117ff2
*pde = 00000000
Oops = 0000[#21]
PREEMPT
Modules linked in: [you wanna know em?]
CPU: 0
EIP: 0060:[<c0117ff2>] Not tainted VLI
EFLAGS: 00010282 (2.6.9-rc1-VP-R0)
EIP is at mm_release+0x42/0xb0

That's all except for the modules list..
