Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWG3Jw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWG3Jw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWG3Jw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:52:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54677 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932171AbWG3Jwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:52:54 -0400
Date: Sun, 30 Jul 2006 11:52:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI-related problem with resuming from RAM
Message-ID: <20060730095242.GD3801@elf.ucw.cz>
References: <200607301140.09836.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301140.09836.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> To make my box (Asus L5D, x86_64) resume from RAM, I have to unload all of the
> ACPI-related modules and the ohci_hcd module before the suspend.
> 
> Also, I can't reload the ohci_hcd module after the resume, because if I try,
> the system crashes with the appended trace.

> irq 11: nobody cared (try booting with the "irqpoll" option)

Heh, does it work with irqpoll? :-).

> Pid: 4908, comm: modprobe Tainted: G   M  2.6.18-rc2-mm1 #20

What is "tainted: M"?

Strange, it seems that "screaming interrupt" detection went crazy and
dump_stack() caused it to oops? Can you stub-out show_trace and see
what happens?

> RIP: 0010:[<ffffffff8020b362>]  [<ffffffff8020b362>] show_trace+0x2c2/0x330
> RSP: 0018:ffffffff8061ecb0  EFLAGS: 00010002
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> RBP: ffffffff8061ed90 R08: 0000000000000002 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff827ffffd
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00002b41c0925b00(0000) GS:ffffffff808c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: ffffffff82800000 CR3: 0000000056fc0000 CR4: 00000000000006e0
> Process modprobe (pid: 4908, threadinfo ffff810056a46000, task ffff81005b88f040)
> Stack:  0000000000000000 ffffffff880a6580 000000000000000a ffffffff8066a240
>  ffffffff8061eeb0 0000000000000022 0000000000000000 0000000000000000
>  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> Call Trace:
>  [<ffffffff8020b6b5>] dump_stack+0x15/0x20
>  [<ffffffff80263b48>] __report_bad_irq+0x38/0x90
>  [<ffffffff80263dca>] note_interrupt+0x22a/0x280
>  [<ffffffff80264a00>] handle_level_irq+0xf0/0x140
>  [<ffffffff8020ccdd>] do_IRQ+0x11d/0x140
>  [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
> DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
> Leftover inexact backtrace:
>  <IRQ> [<ffffffff8020ab82>] call_softirq+0x1e/0x28
>  [<ffffffff8023389a>] __do_softirq+0x5a/0xf0
>  [<ffffffff8020ab82>] call_softirq+0x1e/0x28
>  [<ffffffff8020cb4d>] do_softirq+0x3d/0xb0
>  [<ffffffff8023370e>] irq_exit+0x4e/0x60
>  [<ffffffff8020ccf5>] do_IRQ+0x135/0x140
>  [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
>  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
>  [<ffffffff8020b362>] show_trace+0x2c2/0x330
> PGD 203027 PUD 205027 PMD 0
> Oops: 0000 [2] PREEMPT
> last sysfs file: /devices/pci0000:00/0000:00:02.0/usb2/serial
> CPU 0

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
