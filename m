Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVBHXCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVBHXCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVBHXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:02:23 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:21122 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261678AbVBHXCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:02:16 -0500
Date: Wed, 9 Feb 2005 00:02:00 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML?
In-Reply-To: <20050208214411.GA22960@elte.hu>
Message-Id: <Pine.OSF.4.05.10502082314000.23457-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Feb 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Now I don't really know who I am responding to. But both up()s now
> > changed to complete()s are in something looking very much like an
> > interrupt handler. But again, as I said, I didn't analyze the code in
> > detail, I just made it compile and checked that it worked in bare
> > 2.6.11-rc2 UML - which I am not too sure how to set up and use to
> > begin with!
> 
> btw., UML is really easy to begin with: after you've compiled you get a
> 'linux' binary in the toplevel directory - just execute it via './linux'
> and you'll see a Linux kernel booting - that's all you need!
> 
> Add a filesystem image via a root= parameter to that command and the UML
> kernel will start booting that filesystem image. (if you are adventurous
> you can even boot a real partition, but for the first user this is
> strongly discouraged.) There are a number of UML-ready filesystem images
> downloadable from the net.
> 
Thanks, I managed to get that far after googling a bit. I have had some 
problems with the filesystem though. Fixed now (I forgot to compile ext3
in *blush*.) But you might still be interessted in this trace (2.6.11-rc2
with or without my changes):

line_ioctl: tty0: ioctl KDSIGACCEPT called
Debug: sleeping function called from invalid context at
include/asm/arch/semaphore.h:107
in_atomic():0, irqs_disabled():1
Call Trace: 
a08639e0:  [<a003071b>] __might_sleep+0x9b/0xb8
a0863a10:  [<a001d364>] uml_console_write+0x20/0x54
a0863a30:  [<a00348cc>] __call_console_drivers+0x50/0x58
a0863a60:  [<a00349c1>] call_console_drivers+0x7d/0x124
a0863a90:  [<a0034f97>] release_console_sem+0xa3/0x25c
a0863aa0:  [<a0034fb0>] release_console_sem+0xbc/0x25c
a0863ac0:  [<a0034d3b>] vprintk+0x193/0x2d0
a0863ae0:  [<a0034ba6>] printk+0x12/0x14
a0863b00:  [<a001e996>] line_ioctl+0x8e/0x94
a0863b24:  [<a001e908>] line_ioctl+0x0/0x94
a0863b30:  [<a012e031>] tty_ioctl+0xfd/0x680
a0863b80:  [<a00a253b>] do_ioctl+0x3f/0x64
a0863bb0:  [<a00a2b7d>] sys_ioctl+0x13d/0x350
a0863bd0:  [<a008971b>] sys_open+0x5b/0x74
a0863be0:  [<a008970c>] sys_open+0x4c/0x74
a0863c00:  [<a0018e8d>] execute_syscall_tt+0xa1/0xe0
a0863c1c:  [<a01a9357>] sigemptyset+0x17/0x30
a0863c70:  [<a0014eb2>] record_syscall_start+0x4e/0x58
a0863c90:  [<a0018f0b>] syscall_handler_tt+0x3f/0x74
a0863cc0:  [<a001a170>] sig_handler_common_tt+0x90/0x108
a0863cd0:  [<a001a1d1>] sig_handler_common_tt+0xf1/0x108
a0863d00:  [<a0028c13>] sig_handler+0x1f/0x38
a0863d20:  [<a01a9058>] __restore+0x0/0x8

It could look like a semaphore which should be replaced by a spinlock
(which will become a mutex in preempt-realtime :-)


Esben

> 	Ingo

