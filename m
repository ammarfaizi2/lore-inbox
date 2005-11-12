Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVKLVyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVKLVyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVKLVyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:54:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8429 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964824AbVKLVyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:54:23 -0500
Date: Sat, 12 Nov 2005 13:54:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: ia64 SN2 - migration costs: 1) nearly zero 2) BUG 3) repeated
Message-Id: <20051112135410.3eef5641.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

When I boot my small (8 CPU, 4 Memory Node) ia64 SN2 test system with
2.6.14-mm2, I get the following possible problems in /var/log/messages:

 1) The cost values in the matrix are nearly zero - is that ok?

 2) The "BUG: using smp_processor_id() in preemptible" complaint
	(should we add a preempt_disable()/preempt_enable() around
	the call to calibrate_migration_costs() in kernel/sched.c?)

 3) This matrix is repeated 6 times, and the BUG is repeated
    4 times with "code: echo/12941", 4 times with "code: echo/12942"
    and 2 times with "code: rmdir/12981"

This is partly my fault - I never got back to you with the ia64 SN2
information you asked for when you put this matrix in.  Guess my
time has come.  What else do you need to know?

===============================================================================
Nov 12 13:03:49 3A:margin kernel: BUG: using smp_processor_id() in preemptible [00000001] code: echo/12941
Nov 12 13:03:49 4A:margin kernel: caller is calibrate_migration_costs+0x50/0x1500
Nov 12 13:03:49 4A:margin kernel:
Nov 12 13:03:49 4A:margin kernel: Call Trace:
Nov 12 13:03:49 4A:margin kernel:  [<a0000001000139c0>] show_stack+0x80/0xa0
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b006677520 bsp=e00000b006671800
Nov 12 13:03:49 4A:margin kernel:  [<a000000100014290>] dump_stack+0x30/0x60
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b0066776f0 bsp=e00000b0066717d8
Nov 12 13:03:49 4A:margin kernel:  [<a0000001004203a0>] debug_smp_processor_id+0x280/0x2a0
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b0066776f0 bsp=e00000b0066717a8
Nov 12 13:03:49 4A:margin kernel:  [<a0000001000a7e50>] calibrate_migration_costs+0x50/0x1500
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b006677770 bsp=e00000b006671688
Nov 12 13:03:49 4A:margin kernel:  [<a0000001000ab430>] build_sched_domains+0x2130/0x26e0
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b006677850 bsp=e00000b0066713d8
Nov 12 13:03:49 4A:margin kernel:  [<a0000001000abf00>] partition_sched_domains+0x520/0x580
Nov 12 13:03:49 4A:margin kernel:                                 sp=e00000b006677a90 bsp=e00000b0066713d8
Nov 12 13:03:49 4A:margin kernel: ---------------------
Nov 12 13:03:49 4A:margin kernel: | migration cost matrix (max_cache_size: 0, cpu: -1 MHz):
Nov 12 13:03:49 4A:margin kernel: ---------------------
Nov 12 13:03:49 4A:margin kernel:           [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
Nov 12 13:03:49 4A:margin kernel: [00]:     -     0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)
Nov 12 13:03:49 4A:margin kernel: [01]:   0.0(0)    -     0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)
Nov 12 13:03:49 4A:margin kernel: [02]:   0.0(0)  0.0(0)    -     0.0(0)  0.0(0)  0.0(0)  0.0(0)  0.0(0)
Nov 12 13:03:49 4A:margin kernel: [03]:   0.0(0)  0.0(0)  0.0(0)    -     0.0(0)  0.0(0)  0.0(0)  0.0(0)
Nov 12 13:03:49 4A:margin kernel: [04]:   0.0(2)  0.0(2)  0.0(2)  0.0(2)    -     0.0(0)  0.0(1)  0.0(1)
Nov 12 13:03:49 4A:margin kernel: [05]:   0.0(2)  0.0(2)  0.0(2)  0.0(2)  0.0(0)    -     0.0(1)  0.0(1)
Nov 12 13:03:49 4A:margin kernel: [06]:   0.0(2)  0.0(2)  0.0(2)  0.0(2)  0.0(1)  0.0(1)    -     0.0(0)
Nov 12 13:03:49 4A:margin kernel: [07]:   0.0(2)  0.0(2)  0.0(2)  0.0(2)  0.0(1)  0.0(1)  0.0(0)    -
Nov 12 13:03:49 4A:margin kernel: --------------------------------
Nov 12 13:03:49 4A:margin kernel: | cacheflush times [3]: 0.0 (0) 0.0 (0) 0.0 (0)
Nov 12 13:03:49 4A:margin kernel: | calibration delay: 0 seconds
Nov 12 13:03:49 4A:margin kernel: --------------------------------
===============================================================================


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
