Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVGFQSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVGFQSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVGFQRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:17:36 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:17599 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262321AbVGFL5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:57:49 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 12:57:36 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061257.36738.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I decided to try Ingo's rt-preempt patch on 2.6.12 (V0.7.51-02). I'm 
most interested in the CONFIG_PREEMPT_RT mode, so I selected this option 
instead of the others. I enabled a couple of the debugging options, but I 
wasn't totally clear on which options are most useful, so I just enabled the 
ones that didn't have a warning about significant overhead, namely..

CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_WAKEUP_TIMING=y
CONFIG_CRITICAL_TIMING=y
CONFIG_LATENCY_TIMING=y

Additionally (by mistake) I enabled:

CONFIG_CRITICAL_IRQSOFF_TIMING=y

Which does mention overhead.

Which debugging options are most useful for testing purposes? Is what I've 
selected enough? Also, I got a few unexpected messages in dmesg on bootup. 
Firstly;

spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
[...]
desched cpu_callback 2/00000000
desched thread 0 started up.
softlockup thread 0 started up.

Why does it print out the same ksoftirqd message six times? Is this expected 
behaviour? Next, I got a warning about CONFIG_CRITICAL_IRQSOFF_TIMING;
should this option be enabled?

Finally, I got this:

BUG: soft lockup detected on CPU#0!
 [<c013d7e9>] softlockup_tick+0x89/0xb0 (8)
 [<c0108590>] timer_interrupt+0x50/0xf0 (20)
 [<c013da91>] handle_IRQ_event+0x81/0x100 (16)
 [<c013dbfc>] __do_IRQ+0xec/0x190 (48)
 [<c0105a28>] do_IRQ+0x48/0x70 (40)
 =======================
 [<c024df3b>] acpi_processor_idle+0x0/0x258 (8)
 [<c0103d03>] common_interrupt+0x1f/0x24 (12)
 [<c024df3b>] acpi_processor_idle+0x0/0x258 (4)
 [<c024e05e>] acpi_processor_idle+0x123/0x258 (40)
 [<c024df3b>] acpi_processor_idle+0x0/0x258 (32)
 [<c0101116>] cpu_idle+0x56/0x80 (16)
 [<c03a486c>] start_kernel+0x17c/0x1c0 (12)
 [<c03a43b0>] unknown_bootoption+0x0/0x1f0 (20)

I think it's when my scripts try to set up the IrDA port; the script runs the 
following (I have a weird broken NC6000 IrDA port which needs messing around 
with to work)..

/usr/bin/smcinit -v -s 0x3E8 -f 0x130 -i 4 -d 3 >/dev/null

Of course, the message could've just been coincidental, as it doesn't actually 
refer to the smcs driver at all.

I set preempt_max_latency to zero, but the only messages I've got back from 
the kernel so far are:

( softirq-timer/0-3    |#0): new 3 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 1003 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 1001 us maximum-latency wakeup.

Which is presumably a good sign.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
