Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVBWXYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVBWXYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVBWXX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:23:58 -0500
Received: from hyperion.affordablehost.com ([12.164.25.86]:31438 "EHLO
	hyperion.affordablehost.com") by vger.kernel.org with ESMTP
	id S261679AbVBWXU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:20:56 -0500
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
From: Alan Kilian <kilian@bobodyne.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16925.2739.232237.418632@wombat.chubb.wattle.id.au>
References: <1109190273.9116.307.camel@desk>
	 <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
	 <1109197066.9116.319.camel@desk>
	 <16925.2739.232237.418632@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 17:24:58 -0600
Message-Id: <1109201098.9116.330.camel@desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hyperion.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bobodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan> 	kernel: SSE: Found a DeCypher card.  kernel: ACPI: PCI
> Alan> interrupt 0000:13:03.0[A] -> GSI 36 (level, low) -> IRQ 217
> 
> If ACPI has set this device up to use interrupt 217, why are you
> registering it on IRQ 5?
> 

    Peter,

	Maybe that's it.

	I ask the card which interrupt line it was given at boot-time:

	pci_read_config_byte(dev, PCI_INTERRUPT_LINE,
	                     &softp->interrupt_line);

	Then I request an IRQ:

	request_irq(softp->interrupt_line, sseintr, 
                    SA_INTERRUPT, "sse", softp);

	I don't know who exactly is assigning IRQ 217, and I don't know
	where I could read that value.

	Are you suggesting I should call request_irq(217, sseintr, 
                    SA_INTERRUPT, "sse", softp);

	Maybe you are on to the problem.

	I found out that if I boot with   "pci-noapic" that everyting
	works on the Sun machine!!!

		-Alan

-- 
- Alan Kilian <kilian(at)bobodyne.com>


