Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVIMKAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVIMKAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVIMKAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:00:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47541 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932483AbVIMKAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:00:16 -0400
Date: Tue, 13 Sep 2005 12:00:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       dwalker@mvista.com, George Anzinger <george@mvista.com>
Subject: 2.6.13-rt6, ktimer subsystem
Message-ID: <20050913100040.GA13103@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.13-rt6 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

there are lots of small updates all across and there's a big feature as 
well in this release: a complete rework of the high-resolution timers 
framework, from Thomas Gleixner, called 'ktimers'.

under the ktimer framework the HR (and posix) timers live in a separate 
domain, have their own (per-CPU) rbtree to stay scalable and 
deterministic even with a high number of timers. Another positive effect 
of the introduction of separate ktimers is that kernel/timer.c is now 
using preemptible locks again, removing the cascade() worst-case 
latency. The cleanup factor is high as well: the ktimer framework 
slashes 1300+ lines off the HRT code. See kernel/ktimer.c for details.

the end-effect of ktimers is a much more deterministic HRT engine. The 
original merging of HR timers into the stock timer wheel was a Bad Idea 
(tm). We intend to push the ktimer subsystem upstream as well.

Changes since 2.6.13-rt1:

 - new ktimer subsystem to cleanly implement High Resolution Timers
   (Thomas Gleixner)

 - BKL fix for the new pi-lock code (Steven Rostedt)

 - SMP fix for the new pi-lock code (Steven Rostedt)

 - ALL_TASKS_PI updates (Daniel Walker, Steven Rostedt)

 - trace-irqs fix (Daniel Walker)

 - add raw_irqs_disabled() into the might_sleep() check (Daniel Walker)

 - turned off ALL_TASKS_PI

 - ide_lock updates

 - ioapic build fix

 - HRT build fixes

to build a 2.6.13-rt6 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rt6

	Ingo
