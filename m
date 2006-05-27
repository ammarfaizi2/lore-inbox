Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWE0BOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWE0BOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWE0BOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:14:38 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:55745 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964882AbWE0BOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:14:38 -0400
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 21:14:16 -0400
Message-Id: <1148692456.5381.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 15:53 -0700, john stultz wrote:
> Hey Ingo, All,
> 	We had the following bug reported on bootup on one of our boxes (it
> was a 4way I believe) running -rt22. So far it seems to be a one-off
> but I figured I'd post it to see if anyone had a clue.

I'm assuming this is a i386.  Also I'm assuming that frame pointers was
not compiled in since the stack is a little suspicious.

Anyway, could you show the /proc/interrupts of this machine.  I'm
curious if the i8042 isn't sharing an interrupt with something with
NODELAY in it.

-- Steve


> ...
> usbmon: debugfs is not available
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> mice: PS/2 mouse device common for all mice
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> NET: Registered protocol family 2
> BUG: scheduling with irqs disabled: swapper/0x00010002/0
> caller is rt_lock_slowlock+0xd2/0x139
>  [<c030fb85>] schedule+0x60/0xd0 (8)
>  [<c0310787>] rt_lock_slowlock+0xd2/0x139 (12)
>  [<c0310e2d>] __lock_text_start+0x1d/0x1e (72)
>  [<c022a57f>] i8042_interrupt+0x2c/0x1f0 (4)
>  [<c013edb1>] misrouted_irq+0x85/0x118 (36)
>  [<c013ef08>] note_interrupt+0x43/0x9f (36)
>  [<c013e395>] __do_IRQ+0xc2/0xf9 (16)

