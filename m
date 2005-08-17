Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVHQTb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVHQTb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVHQTb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:31:59 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:13702 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751199AbVHQTb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:31:58 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1124303466.5247.8.camel@localhost.localdomain>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>  <43036F80.2020406@cybsft.com>
	 <1124303466.5247.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 15:31:35 -0400
Message-Id: <1124307095.5186.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 14:31 -0400, Steven Rostedt wrote:

> On my AMD SMP box, the system boots with no problems. 

I shouldn't say no problems. I got this really nasty stuff on the serial
but not on the vga.  Below is the patch.

I'm currently compiling my laptop to try this out. I started converting
to my AMD box and decided to try this first. Unfortunately, I modified
enough to do a full compile from scratch again.


BUG: stack overflow: only 984 bytes left! [c05c0424...(c05c0000-c05c2000)]
----------------------------->
| new stack-footprint maximum: swapper/0, 7096 bytes (out of 8136 bytes).
------------|
 [<c05c2000>] no_halt+0x0/0x20 (20)
 [<c01430cb>] __mcount+0x4b/0xe0 (20)
 [<c0142a77>] fill_worst_stack+0x67/0x70 (12)
 [<c0142c30>] debug_stackoverflow+0x70/0xd0 (16)
 [<c01223d0>] printk+0x20/0x30 (8)
 [<c01223ee>] vprintk+0xe/0x2b0 (4)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223ee>] vprintk+0xe/0x2b0 (20)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (8)
 [<c01223bb>] printk+0xb/0x30 (60)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223d0>] printk+0x20/0x30 (20)
 [<c0142aab>] __print_worst_stack+0x2b/0xf0 (20)
 [<c01457ac>] sub_preempt_count+0x1c/0x20 (8)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (24)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (4)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c01430cb>] __mcount+0x4b/0xe0 (32)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (40)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0113d8c>] mcount+0x14/0x18 (8)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (20)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c01225dd>] vprintk+0x1fd/0x2b0 (12)
 [<c01430cb>] __mcount+0x4b/0xe0 (28)
 [<c01223bb>] printk+0xb/0x30 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223bb>] printk+0xb/0x30 (20)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (20)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (32)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (4)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c01430cb>] __mcount+0x4b/0xe0 (32)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (40)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0113d8c>] mcount+0x14/0x18 (8)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (20)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
[<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c01225dd>] vprintk+0x1fd/0x2b0 (12)
 [<c01430cb>] __mcount+0x4b/0xe0 (28)
 [<c01223bb>] printk+0xb/0x30 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223bb>] printk+0xb/0x30 (20)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (20)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (32)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (4)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c01430cb>] __mcount+0x4b/0xe0 (32)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (40)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0113d8c>] mcount+0x14/0x18 (8)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (20)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c01225dd>] vprintk+0x1fd/0x2b0 (12)
 [<c01430cb>] __mcount+0x4b/0xe0 (28)
 [<c01223bb>] printk+0xb/0x30 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223bb>] printk+0xb/0x30 (20)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (20)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (32)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (4)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c01430cb>] __mcount+0x4b/0xe0 (32)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (40)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0113d8c>] mcount+0x14/0x18 (8)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (20)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c01225dd>] vprintk+0x1fd/0x2b0 (12)
 [<c01430cb>] __mcount+0x4b/0xe0 (28)
 [<c01223bb>] printk+0xb/0x30 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223bb>] printk+0xb/0x30 (20)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (20)
 [<c0142b8a>] print_worst_stack+0x1a/0x50 (32)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (4)
 [<c01425fb>] check_raw_flags+0xb/0x60 (4)
 [<c01430cb>] __mcount+0x4b/0xe0 (32)
 [<c02ec334>] _raw_spin_lock_irqsave+0x14/0xb0 (40)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (12)

[...]

 [<c01223bb>] printk+0xb/0x30 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223bb>] printk+0xb/0x30 (20)
 [<c0142ae1>] __print_worst_stack+0x61/0xf0 (20)
 [<c0122753>] release_console_sem+0x33/0xf0 (32)
 [<c0142baf>] print_worst_stack+0x3f/0x50 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (8)
 [<c0142c17>] debug_stackoverflow+0x57/0xd0 (20)
 [<c01430cb>] __mcount+0x4b/0xe0 (20)
 [<c0122184>] call_console_drivers+0x14/0x150 (40)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c0122184>] call_console_drivers+0x14/0x150 (20)
 [<c0122753>] release_console_sem+0x33/0xf0 (44)
 [<c0122628>] vprintk+0x248/0x2b0 (32)
 [<c01223bb>] printk+0xb/0x30 (68)
 [<c0113d8c>] mcount+0x14/0x18 (20)
 [<c01223d0>] printk+0x20/0x30 (20)
 [<c05d2d4c>] sched_init+0x12c/0x150 (20)
 [<c0113d8c>] mcount+0x14/0x18 (8)
 [<c05c2901>] start_kernel+0x51/0x220 (32)



-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/latency.c
===================================================================
--- linux_realtime_goliath/kernel/latency.c	(revision 295)
+++ linux_realtime_goliath/kernel/latency.c	(working copy)
@@ -377,8 +377,11 @@
 		print_worst_stack();
 		tr->stack_check++;
 	} else
-		if (worst_stack_printed != worst_stack_left)
+		if (worst_stack_printed != worst_stack_left) {
+			tr->stack_check--;
 			print_worst_stack();
+			tr->stack_check++;
+		}
 out:
 	atomic_dec(&tr->disabled);
 }


