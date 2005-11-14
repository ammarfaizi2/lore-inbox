Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVKNPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVKNPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVKNPm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:42:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbVKNPm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:42:27 -0500
Date: Mon, 14 Nov 2005 07:42:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Pozsar Balazs <pozsy@uhulinux.hu>, linux-kernel@vger.kernel.org
Subject: Re: start_kernel / local_irq_enable() can be very slow
In-Reply-To: <20051113234451.73f2527b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511140740260.3263@g5.osdl.org>
References: <20051112155453.GC21291@ojjektum.uhulinux.hu>
 <20051113234451.73f2527b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Nov 2005, Andrew Morton wrote:
> 
> You could do something like:
> 
> int trace_irqs;
> 
> 	trace_irqs = 1;
> 	local_irq_enble();
> 	trace_irqs = 0;

Do "trace_irqs = 10" first.

> then, over in handle_IRQ_event():
> 
> 	if (trace_irqs)
> 		print_symbol("calling %s\n", (unsigned long)action->handler);

And decrement it here somewhere.

If it's delayed by up to three seconds, it sounds like there's a _lot_ of 
interrupts happening, and I don't think there's any point in showing all 
of them.

			Linus
