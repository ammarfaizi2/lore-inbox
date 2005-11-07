Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVKGLyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVKGLyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVKGLyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:54:23 -0500
Received: from mgate03.necel.com ([203.180.232.83]:14589 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1751344AbVKGLyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:54:22 -0500
To: linux-kernel@vger.kernel.org
Subject: irq 0?
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 07 Nov 2005 20:54:17 +0900
Message-Id: <buobr0wbrme.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that arch/v850/kernel/irq.c has been updated with a
"show_interrupts" function; in this function it contains the following
bit of code:


	if (i == 0) {
		seq_puts(p, "           ");
		for (i=0; i < 1 /*smp_num_cpus*/; i++)
			seq_printf(p, "CPU%d       ", i);
		seq_putc(p, '\n');
	}

	if (i < NR_IRQS) {
                ... show interrupt i ...
	} else if (i == NR_IRQS)
		seq_printf(p, "ERR: %10lu\n", irq_err_count);

where "i" is iterated (by procfs) from 0...NR_IRQS.

On the v850, irq 0 is a real interrupt, so this doesn't really work
properly -- it doesn't display an entry for irq 0.

Is it now illegal for irq 0 to be a real interrupt (was it illegal before)?
Or is the procfs code just bogus?

Thanks,

-miles
-- 
Occam's razor split hairs so well, I bought the whole argument!
