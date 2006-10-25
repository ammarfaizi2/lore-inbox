Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423269AbWJYLJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423269AbWJYLJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423270AbWJYLJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:09:43 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:18448 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1423269AbWJYLJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:09:42 -0400
Date: Wed, 25 Oct 2006 13:09:37 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rt6] BUG / typo
In-Reply-To: <Pine.LNX.4.63.0610241512500.1852@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610251247460.1852@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241003280.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241408000.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241512500.1852@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again

Just a bit more detail to the way the bug occurs: you just need

CONFIG_LATENCY_TIMING=y

and in my case I had 2 consoles: tty1 and ttyS0. tty1 is a framebuffer. I 
don't know where irqs get disabled (the original BUG was

BUG: scheduling with irqs disabled: posix_cpu_timer/0x00000001/2
caller is rt_spin_lock_slowlock+0xd8/0x1c8

but is it at all ok to schedule in kmalloc(GFP_ATOMIC)? Which is exactly 
what happens here as kmalloc tries to acquire the per-cpu "spinlock" / 
mutex slab_irq_locks and is forced into the slow path.

The bug often triggers when I reset /proc/sys/kernel/preempt_max_latency 
with 0 and if I have high enough console logging level in 
/proc/sys/kernel/printk.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
