Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVABQWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVABQWh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVABQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:22:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62125 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261272AbVABQWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:22:35 -0500
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D70AF4.7030901@tmr.com>
References: <1104249508.22366.101.camel@localhost.localdomain>
	 <41D70AF4.7030901@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104679098.14712.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 15:18:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I saw this message coming out of ac2 with my runaway IRQ 18 problem, so 
> I tried irqpoll, and it just "went away" beyond sysreq or other gentle 
> recovery.

That means that the cause of the IRQ that hung your machine was not one
we had any driver for. Thats generally BIOS bogosities on a large scale.
The irqpoll code can recover from cases where an IRQ turns up on the
wrong IRQ line but for a registered driver and when an IRQ fails to turn
up in which case the timer tick picks it up on x86 (which may or may not
make it "useful").

> I suspect that the problem lies in sharing the shared IRQ, and that 
> polling doesn't solve the problem, just changes it to a hang witing for 
> the misrouted IRQ. Still poking for the real cause, no patch or 
> anything, but acpi={off,ht}, noapic, pci=routeirq, etc have no benefit 
> (for me).

That wouldn't really fit how the hardware works. You appear to have some
unsupported device connected to that line and asserting IRQ right from
boot.

Alan

