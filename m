Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTADRio>; Sat, 4 Jan 2003 12:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbTADRio>; Sat, 4 Jan 2003 12:38:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266978AbTADRin>; Sat, 4 Jan 2003 12:38:43 -0500
Date: Sat, 4 Jan 2003 09:41:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrey Panin <pazke@orbita1.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
In-Reply-To: <1041685293.641.17.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0301040938480.5425-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Jan 2003, Benjamin Herrenschmidt wrote:
> 
> The "easy" way here to implement that is to make the irq_desc array larger than
> NR_IRQs (or rather split NR_IRQs into NR_SYS_IRQS + NR_DYNAMIC_IRQS). The
> additional "slots" could then easily be allocated/freed. Thus, keeping my
> cardbus example, the cardbus driver can allocate a couple of slots (that is IRQ
>  numbers) dynamically, and use it's own startup/shutdown/enable/disable/...
> hooks for them, dealing itself with the cascade from the PCI irq.

Linearizing a space like this is always a bad idea, I think. 

It would be entirely possible to just add the irq routing information to 
the "struct device" tree, and have a "dev_request_irq(dev, ...)", along 
with a few helper functions like "pci_request_irq(pci_dev, ...)".

And the old "request_irq()" would just use the system root device as the 
device.

		Linus

