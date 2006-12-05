Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760035AbWLEOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760035AbWLEOKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760042AbWLEOKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:10:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:30359 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760035AbWLEOKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:10:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=imcRexxZ3knef1DR+MYlWWsGhAvgTT92RpEnY+9HXlXGRylfC0d5vf0js1RRnE4T+M2dDWtE2UukdChh0RHXkez9CYDyGfN0ifR2mCFAdUeUky6l5vxVVlJHjrm21FoasrvrCMZIdlEihLScPqGkfJkeUKOQC5SkNhnGCWauNFw=
Message-ID: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>
Date: Tue, 5 Dec 2006 19:40:34 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PREEMPT is messing with everyone
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

preempt stuff SHOULD only stay in #ifdef CONFIG_PREEMP_* , but it is
messing with everyone even though not defined.

e.g.

1. linux-2.6.19/kernel/spinlock.c

Line 18: #include <linux/preempt.h>

Line 26:  preempt_disable();

Line 32:  preempt_disable();

and so on .

2. linux-2.6.19/kernel/sched.c

Line 1096:  int preempted;

Line 1104:   preempted = !task_running(rq, p);

Line 1106:   if (preempted)

Line 2059:  if (TASK_PREEMPTS_CURR(p, this_rq))

Line 3355:    current->comm, preempt_count(), current->pid);

Line 3342:  preempt_disable();

Line 3375:  if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {

Line 3471:  preempt_enable_no_resched();

3. linux-2.6.19/kernel/timer.c

Line 444:     int preempt_count = preempt_count();

Line 447:     if (preempt_count != preempt_count()) {

4. linux-2.6.19/arch/i386/kernel/entry.S

Line 240:  preempt_stop

5. linux-2.6.19/arch/i386/irq.c

Line 111:    irqctx->tinfo.preempt_count =

Line 112:    (irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |

Line 113:    (curctx->tinfo.preempt_count & SOFTIRQ_MASK);

Line 160:  irqctx->tinfo.preempt_count     = HARDIRQ_OFFSET;

and so on.

Similarly unnecessary preempt code is also written in other important files.

70 to 80 % of this code is removed when compiled.

but 20 to 30 % code left in binary kernel image.

Why Linux kernel is wasting its resources which is not defined at all.

Any solution ?

Thank you,

Best Regards,

Jaswinder Singh.
