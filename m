Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933244AbWKNJIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244AbWKNJIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933303AbWKNJIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:08:04 -0500
Received: from mga07.intel.com ([143.182.124.22]:54622 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S933244AbWKNJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:08:00 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,420,1157353200"; 
   d="scan'208"; a="145873426:sNHT4040957340"
Subject: [PATCH] some irq_chip variables initiate end to point to NULL
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1163495289.4311.68.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 14 Nov 2006 17:08:10 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an oops when booting 2.6.19-rc5-mm1 on my ia64 machine.

Below is the log.

Oops 11012296146944 [1]
Modules linked in: binfmt_misc dm_mirror dm_multipath dm_mod thermal processor f
an container button sg eepro100 e100 mii

Pid: 0, CPU 0, comm:              swapper
psr : 0000121008022038 ifs : 800000000000040b ip  : [<a0000001000e1411>]    Not
tainted
ip is at __do_IRQ+0x371/0x3e0
unat: 0000000000000000 pfs : 000000000000040b rsc : 0000000000000003
rnat: 656960155aa56aa5 bsps: a00000010058b890 pr  : 656960155aa55a65
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000e1390 b6  : a0000001005beac0 b7  : e00000007f01aa00
f6  : 000000000000000000000 f7  : 0ffe69090000000000000
f8  : 1000a9090000000000000 f9  : 0ffff8000000000000000
f10 : 1000a908ffffff6f70000 f11 : 1003e0000000000000909
r1  : a000000100fbbff0 r2  : 0000000000010002 r3  : 0000000000010001
r8  : fffffffffffbffff r9  : a000000100bd8060 r10 : a000000100dd83b8
r11 : fffffffffffeffff r12 : a000000100bcbbb0 r13 : a000000100bc4000
r14 : 0000000000010000 r15 : 0000000000010000 r16 : a000000100c01aa8
r17 : a000000100d2c350 r18 : 0000000000000000 r19 : a000000100d2c300
r20 : a000000100c01a88 r21 : 0000000080010100 r22 : a000000100c01ac0
r23 : a0000001000108e0 r24 : e000000477980004 r25 : 0000000000000000
r26 : 0000000000000000 r27 : e00000000913400c r28 : e0000004799ee51c
r29 : e0000004778b87f0 r30 : a000000100d2c300 r31 : a00000010005c7e0

Call Trace:
 [<a000000100014600>] show_stack+0x40/0xa0
                                sp=a000000100bcb760 bsp=a000000100bc4f40
 [<a000000100014f00>] show_regs+0x840/0x880
                                sp=a000000100bcb930 bsp=a000000100bc4ee8
 [<a000000100037fb0>] die+0x250/0x320
                                sp=a000000100bcb930 bsp=a000000100bc4ea0
 [<a00000010005e5f0>] ia64_do_page_fault+0x8d0/0xa20
                                sp=a000000100bcb950 bsp=a000000100bc4e50
 [<a00000010000caa0>] ia64_leave_kernel+0x0/0x290
                                sp=a000000100bcb9e0 bsp=a000000100bc4e50
 [<a0000001000e1410>] __do_IRQ+0x370/0x3e0
                                sp=a000000100bcbbb0 bsp=a000000100bc4df0
 [<a000000100011f50>] ia64_handle_irq+0x170/0x220
                                sp=a000000100bcbbb0 bsp=a000000100bc4dc0
 [<a00000010000caa0>] ia64_leave_kernel+0x0/0x290
                                sp=a000000100bcbbb0 bsp=a000000100bc4dc0
 [<a000000100012390>] ia64_pal_call_static+0x90/0xc0
                                sp=a000000100bcbd80 bsp=a000000100bc4d78
 [<a000000100015630>] default_idle+0x90/0x160
                                sp=a000000100bcbd80 bsp=a000000100bc4d58
 [<a000000100014290>] cpu_idle+0x1f0/0x440
                                sp=a000000100bcbe20 bsp=a000000100bc4d18
 [<a000000100009980>] rest_init+0xc0/0xe0
                                sp=a000000100bcbe20 bsp=a000000100bc4d00
 [<a0000001009f8ea0>] start_kernel+0x6a0/0x6c0
                                sp=a000000100bcbe20 bsp=a000000100bc4ca0
 [<a0000001000089f0>] __end_ivt_text+0x6d0/0x6f0
                                sp=a000000100bcbe30 bsp=a000000100bc4c00
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


The root cause is that some irq_chip variables, especially ia64_msi_chip,
initiate their memeber end to point to NULL. __do_IRQ doesn't check
if irq_chip->end is null and just calls it after processing the interrupt.

As irq_chip->end is called at many places, so I fix it by reinitiating
irq_chip->end to dummy_irq_chip.end, e.g., a noop function.

Below patch against 2.6.19-rc5-mm1 fixes it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.19-rc5-mm1/kernel/irq/chip.c	2006-11-14 14:16:16.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/kernel/irq/chip.c	2006-11-14 14:14:25.000000000 +0800
@@ -233,6 +233,8 @@ void irq_chip_set_defaults(struct irq_ch
 		chip->shutdown = chip->disable;
 	if (!chip->name)
 		chip->name = chip->typename;
+	if (!chip->end)
+		chip->end = dummy_irq_chip.end;
 }
 
 static inline void mask_ack_irq(struct irq_desc *desc, int irq)

