Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUG2Ptw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUG2Ptw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUG2PhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:37:18 -0400
Received: from pop.gmx.net ([213.165.64.20]:64473 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268035AbUG2PN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:13:26 -0400
Date: Thu, 29 Jul 2004 17:13:24 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.7, ia64] sleeping while atomically allocating...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <15341.1091114004@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this warning [1] while a process was dumping core. Hardware is a
generic ia64 4-way Itanium 2 Intel tiger 4 system.

--- [1]

Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0

Call Trace:
 [<a00000010001b6e0>] show_stack+0x80/0xa0
                                sp=e0000000369ef8b0 bsp=e0000000369e9460
 [<a00000010009bf30>] __might_sleep+0x1b0/0x220
                                sp=e0000000369efa80 bsp=e0000000369e9438
 [<a0000001000bb690>] access_process_vm+0x150/0x540
                                sp=e0000000369efa90 bsp=e0000000369e9380
 [<a0000001000381a0>] ia64_sync_user_rbs+0xa0/0xe0
                                sp=e0000000369efab0 bsp=e0000000369e9350
 [<a00000010001ceb0>] do_copy_task_regs+0xd0/0x3e0
                                sp=e0000000369efac0 bsp=e0000000369e92e8
 [<a00000010001d3b0>] dump_task_regs+0x70/0xc0
                                sp=e0000000369efae0 bsp=e0000000369e92c8
 [<a0000001001d7130>] elf_dump_thread_status+0xd0/0x240
                                sp=e0000000369efcb0 bsp=e0000000369e9258
 [<a0000001001d86b0>] elf_core_dump+0x1410/0x1540
                                sp=e0000000369efcb0 bsp=e0000000369e9160
 [<a000000100180770>] do_coredump+0x590/0x620
                                sp=e0000000369efd50 bsp=e0000000369e9108
 [<a0000001000c94e0>] get_signal_to_deliver+0x700/0xcc0
                                sp=e0000000369efda0 bsp=e0000000369e9098
 [<a0000001000425d0>] ia64_do_signal+0xb0/0x420
                                sp=e0000000369efda0 bsp=e0000000369e9000
 [<a00000010001c0f0>] do_notify_resume_user+0x110/0x120
                                sp=e0000000369efe20 bsp=e0000000369e8fd0
 [<a0000001000129c0>] notify_resume_user+0x40/0x60
                                sp=e0000000369efe20 bsp=e0000000369e8f80
 [<a0000001000128f0>] skip_rbs_switch+0xd0/0xe0
                                sp=e0000000369efe30 bsp=e0000000369e8f68

-- 
Daniel J Blueman

NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

