Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbRFEMy0>; Tue, 5 Jun 2001 08:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRFEMyT>; Tue, 5 Jun 2001 08:54:19 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:7415 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S261805AbRFEMxm>; Tue, 5 Jun 2001 08:53:42 -0400
Message-ID: <3B1D00B7.168B52D1@adelphia.net>
Date: Tue, 05 Jun 2001 08:54:31 -0700
From: Stephen Wille Padnos <stephenwp@adelphia.net>
Organization: Thoth Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Exporting new functions from kernel 2.2.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

I am writing a pseudo-realtime control system, based on kernel 2.2.14.
The only RT-like task needs to hang off the timer IRQ.  I am using
techniques like those in the book "Linux Kernel Internals", by Beck, et
al..

The patches in that book won't apply (they are for 2.1.24 or lower),
plus I want a somewaht different functionality, which brings me to my
question:  How can I get (modversions-enabled) functions exported from
arch/i386/kernel/irq.c?

I see in /proc/ksyms that there are some functions exported from there
({enable,disable}_irq, probe_irq_{on,off}, etc.), and they have correct
looking versions.

When I add my new finctions to i386ksyms.c:
EXPORT_SYMBOL(grab_timer_interrupt);
EXPORT_SYMBOL(release_timer_interrupt);

I get names like

grab_timer_interrupt_R__ver_grab_timer_interrupt
release_timer_interrupt_R__ver_release_timer_interrupt

instead of
local_irq_count_R4d40375f

Additionally, when I make a dummy module (a la Alessandro Rubini's
"Hello" module in "Linux Device Drivers"), I get the following warning:
control.c:31: warning: implicit declaration of function
`printk_R1b7d4074'
The module seems to work (it printk's "module loaded" on load and
"module unloaded" on unload), but I suspect that this is because I am
printk()-ing unformatted text strings - only one parameter gets sent.

So, I obviously have missed some basics about:
a) versioning,
b) exporting symbols, and
c) modules.

could soemone please enlighten me, or direct me along the path of
enlightenment :)

Thanks
- Steve


