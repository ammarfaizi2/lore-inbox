Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUJYT2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUJYT2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUJYP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:59:23 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:35567 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262015AbUJYPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:43:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexander Batyrshin <abatyrshin@ru.mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB82CB18B.9F6E8E89-ON86256F38.0054C14D@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 25 Oct 2004 10:42:17 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/25/2004 10:42:18 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
Actually, I picked up -V0.1 since that was available when I started
this morning and of course -V0.2 came out while I was building....

The kernel I built does not even make it to single user mode unless
I disable selinux.

First try had console messages stop after the message
  INIT: version 2.85 booting
but the Alt-Sysrq keys do work. Alt-Sysrq-L shows...

Pid: 5, comm:   ksoftirqd/1
EIP: 0060:[<c011d808>] CPU:1
EIP is at smp_processor_id+0x28/0xc0
(registers and stack trace...)
preempt count: 00010002
...

Pid: 266, comm:   IRQ 1
EIP: 0060:[<c0115b70>] CPU:0
EIP is at nmi_show_all_regs+0xd0/0x120
(registers and stack trace...)
preempt count: 00010002
...

If I repeat this a few times, the first process changed to "hotplug".
Repeating Alt-Sysrq-L will eventually gets stuck and requires
a hardware reset.

Second try - the INIT message was incomplete, stopping at
INIT:
plus the Alt-Sysrq keys not working at all.

Third try - added
  selinux=0
to the boot parameters. Made it single user mode w/o any errors.
Using telinit 3 got me a few BUG messages related to modprobe
and sleeping from an invalid context. From what I read in
other messages, you may have already fixed that so I will be
building -V0.2 shortly.

I also got the atomic counter underflow (qdisc_destroy) message.

Let me know if you need the system log, it appears to have
captured the messages if you need them.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

