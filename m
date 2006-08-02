Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHBVeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHBVeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHBVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:34:06 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:22218 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S932213AbWHBVeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:34:04 -0400
Date: Thu, 3 Aug 2006 03:00:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [rt7 x86_64] oops while running pounder
Message-ID: <20060802213043.GD10989@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

I have been running pounder on my x86_64 box (rt7, 64-bit kernel) and
I see these after a couple of hours. First I see a bunch of
these a while -

[2006-07-28 17:13:51] (8515) snake.exe: START loop #0.
irq 209: nobody cared (try booting with the "irqpoll" option)

Call Trace:
       <ffffffff802582ac>{__report_bad_irq+48}
       <ffffffff802584ca>{note_interrupt+465}
       <ffffffff80242f57>{keventd_create_kthread+0}
       <ffffffff80257964>{thread_simple_irq+126}
       <ffffffff80242f57>{keventd_create_kthread+0}
       <ffffffff80257e06>{do_irqd+206}
       <ffffffff80242f57>{keventd_create_kthread+0}
       <ffffffff80257d38>{do_irqd+0}
       <ffffffff80243249>{kthread+212}
       <ffffffff8020a74e>{child_rip+8}
       <ffffffff80242f57>{keventd_create_kthread+0}
       <ffffffff80240197>{run_workqueue+16}
       <ffffffff80243175>{kthread+0}
       <ffffffff8020a746>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff805008c4>] .... _raw_spin_lock_irq+0xf/0x1a
.....[<00000000>] ..   ( <= 0x0)

handlers:
[<ffffffff8043e610>] (usb_hcd_irq+0x0/0x55)


Eventually, the machine oopses -

softirq-tasklet/39[CPU#3]: BUG in __tasklet_action at kernel/softirq.c:488

Call Trace:
       <ffffffff80230f1c>{__WARN_ON+100}
       <ffffffff802357e0>{__tasklet_action+174}
       <ffffffff80235f33>{ksoftirqd+280}
       <ffffffff80235e1b>{ksoftirqd+0}
       <ffffffff80243249>{kthread+212}
       <ffffffff80235e1b>{ksoftirqd+0}
       <ffffffff8020a74e>{child_rip+8}
       <ffffffff80235e1b>{ksoftirqd+0}
       <ffffffff80243175>{kthread+0}
       <ffffffff8020a746>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff805008a4>] .... _raw_spin_lock_irqsave+0x18/0x29
.....[<00000000>] ..   ( <= 0x0)

I am investigating, but just FYI in case you can point me to something.

Thanks
Dipankar
