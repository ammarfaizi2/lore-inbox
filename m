Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVAAUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVAAUaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAAUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 15:30:15 -0500
Received: from mail.tmr.com ([216.238.38.203]:41160 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261173AbVAAUaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 15:30:09 -0500
Message-ID: <41D70AF4.7030901@tmr.com>
Date: Sat, 01 Jan 2005 15:41:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
References: <1104249508.22366.101.camel@localhost.localdomain>
In-Reply-To: <1104249508.22366.101.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ported to the new kernel/irq code.

	[snip]

>  	} else {
> -		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
> +		printk(KERN_ERR "irq %d: nobody cared (try booting with the \"irqpoll\" option.\n", irq);
>  	}
>  	dump_stack();
>  	printk(KERN_ERR "handlers:\n");
	[snip]

I saw this message coming out of ac2 with my runaway IRQ 18 problem, so 
I tried irqpoll, and it just "went away" beyond sysreq or other gentle 
recovery.

I suspect that the problem lies in sharing the shared IRQ, and that 
polling doesn't solve the problem, just changes it to a hang witing for 
the misrouted IRQ. Still poking for the real cause, no patch or 
anything, but acpi={off,ht}, noapic, pci=routeirq, etc have no benefit 
(for me).


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
