Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUHQNff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUHQNff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUHQNff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:35:35 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60365 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268225AbUHQNfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:35:33 -0400
Date: Tue, 17 Aug 2004 09:39:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1
In-Reply-To: <1092726346.3081.145.camel@booger>
Message-ID: <Pine.LNX.4.58.0408170936270.22078@montezuma.fsmlabs.com>
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <1092726346.3081.145.camel@booger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, Nathan Lynch wrote:

> i386 seems to want something like this to avoid crashing in
> find_busiest_group... looks like there's a short window in fixup_irqs
> where interrupts are enabled while we're taking a cpu down.

> Index: 2.6.8.1-mm1/arch/i386/kernel/apic.c
> ===================================================================
> --- 2.6.8.1-mm1.orig/arch/i386/kernel/apic.c
> +++ 2.6.8.1-mm1/arch/i386/kernel/apic.c
> @@ -1138,7 +1138,8 @@
>  	 * interrupt lock, which is the WrongThing (tm) to do.
>  	 */
>  	irq_enter();
> -	smp_local_timer_interrupt(&regs);
> +	if (!cpu_is_offline(cpu))
> +		smp_local_timer_interrupt(&regs);
>  	irq_exit();

Hmm i really am trying to avoid that, thats why we also mask the APIC
timer after fixup_irqs, can we try tackling that instead?
