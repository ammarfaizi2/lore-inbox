Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVKNHs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVKNHs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVKNHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:48:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750971AbVKNHs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:48:26 -0500
Date: Sun, 13 Nov 2005 23:44:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: start_kernel / local_irq_enable() can be very slow
Message-Id: <20051113234451.73f2527b.akpm@osdl.org>
In-Reply-To: <20051112155453.GC21291@ojjektum.uhulinux.hu>
References: <20051112155453.GC21291@ojjektum.uhulinux.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs <pozsy@uhulinux.hu> wrote:
>
> I've noticed that the local_irq_enable() call in 
>  init/main.c::start_kernel() takes 0.3 .. 3.0 seconds on every boot.
>  (Measured using printk's around it.)
> 
>  I am wondering what happens during this call (which is effectively one 
>  "sti"), why does it take so much time sometimes, and why does it vary so 
>  much, why isn't it (more) deterministic.

Presumably as soon as it does the sti, the CPU takes one or more interrupts
and runs off and does something.

I wonder what?

You could do something like:

int trace_irqs;

	trace_irqs = 1;
	local_irq_enble();
	trace_irqs = 0;

then, over in handle_IRQ_event():

	if (trace_irqs)
		print_symbol("calling %s\n", (unsigned long)action->handler);


