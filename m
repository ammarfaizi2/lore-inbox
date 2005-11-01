Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVKAUTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVKAUTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVKAUTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:19:07 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:31665 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751344AbVKAUTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:19:05 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       nando@ccrma.Stanford.EDU
In-Reply-To: <20051030133316.GA11225@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 12:18:13 -0800
Message-Id: <1130876293.6178.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote: 
> i have released the 2.6.14-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly about ktimer fixes: it updates to the latest 
> ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
> GTOD tree), it fixes TSC synchronization problems on HT systems, and 
> updates the ktimers debugging code.
> 
> These together could fix most of the timer warnings and annoyances 
> reported for 2.6.14-rc5-rt kernels. In particular the new 
> TSC-synchronization code could fix SMP systems: the upstream TSC 
> synchronization method is fine for 1 usec resolution, but it was not 
> good enough for 1 nsec resolution and likely caused the SMP bugs 
> reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> 
> Please re-report any bugs that remain.

2.6.14-rt2 seems to be running fine on my athlon x2 smp system. Apart
from some time warp messages when starting up it looks fine so far (this
is on fc4). 

The same kernel built for fc3 fails to boot in my Sony laptop. I see
this:

Kernel panic - not syncing: Attempted to kill init!

... then it sits there for some time, no traceback or anything and
then...

<3>BUG: init:1, possible softlockup detected on CPU#0
[<c0148760>] softlockup_detected+0x30/0x40 (8)
[] softlockup_tick+0xa0/0xb0 (20)
[] update_process_times+0x62/0x70 (8)
[] timer_interrupt+0x3b/0x70 (8)
[] handle_IRQ_event+0x56/0xd0 (12)
[] handle_IRQ_event+0x56/0xd0 (4)
[] printk+0x17/0x20 (8)
[] __do_IRQ+0x9e/0x140 (36)
[] do_IRQ+0x34/0x70 (32)
[] do_IRQ+0x34/0x70 (4)
[] common_interrupt+0x1a/0x20 (16)
[] __delay+0x20/0x30 (44)
[] panic+0xe5/0xf0 (12)
[] do_exit+0x3d1/0x400 (16)
[] vfs_write+0x133/0x180 (20)
[] do_group_exit+0x35/0xc0 (20)
[] sys_write+0x41/0x70 (4)
[] sysenter_past_esp+0x54/0x75 (28)

This message keeps repeating at regular intervals. Subsequent prints
don't start with the "<3>". 

There could be typos and I ommited beginning addresses to save time,
copied directly from my laptop screen. 

-- Fernando


