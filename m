Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUJSRbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUJSRbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269630AbUJSR2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:28:20 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:13937 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S267285AbUJSRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:17:19 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF684A90CB.5A611764-ON86256F32.005DA19F@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 19 Oct 2004 12:14:47 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/19/2004 12:14:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U6 Real-Time Preemption patch:
>
>
http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6

Booted to single user and was able to get some network operations going
with
this version (w/ previously mentioned update). However, at the step where
I start CUPS, I got a number of traces on the display referring to
parport_pc
related function calls [but I don't use a parallel printer...]. It ended
with:

NMI Watchdog detected LOCKUP on CPU1, eip c0139b22, registers:
[not sure you want the all the details, I'll put a few key items in
and can try to reproduce on request]

Modules linked in: parport_pc lp parport autofs4 sunrpc 8139too mii dm_mod
uhci_hcd ext3 jbd
CPU:    1
... EIP is at sub_preempt_count+0x82/0xa0
... Process ksoftirqd/1 (pid:5 ...)

Pid: 1825, comm:    modprobe
... CPU: 0
... EIP is at flush_tlb_others+0x90/0xf0

(stack trace shows sys_init_module, parport_pc_init, ...
parport_announce_port,
 mcount, parport_pc_probe_port, parport_announce_port, __mcount,
parport_daisy_init, ...
 parport_wait_event, down_write_interruptible, error_code, show_stack,
etc.)
preempt count: 00010006
...
console shuts up...

Alt-Sysrq keys are recognized (displays command) but don't display any
data.
Will send whatever made it into to the system log shortly.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

