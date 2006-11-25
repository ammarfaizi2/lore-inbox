Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966464AbWKYM3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966464AbWKYM3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966465AbWKYM3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:29:21 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:55304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S966464AbWKYM3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:29:20 -0500
Date: Sat, 25 Nov 2006 12:29:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel-discuss] RFC - platform device, IRQs and SoC devices
Message-ID: <20061125122910.GA12104@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
References: <4563242D.9050901@f2s.com> <45682B0E.4060202@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45682B0E.4060202@f2s.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 11:37:50AM +0000, Ian Molton wrote:
> Ian Molton wrote:
> >Hi there.
> >
> >Im working on some SoC type devices attached to the system bus of my ARM 
> >devboard in an isa-like way.
> >
> >The devices are small SoC (System On Chip) types, with one IRQ routed to 
> >the half dozen (sub)devices on board the SoC.
> 
> I just thought of a 'third way'.
> 
> let IRQchips have their own struct irq_desc and have subdevice IRQs 
> start from 0.
> 
> since those IRQs can only be raised by the parent chip I think this 
> ought to work, and would eliminated the problem of a fixed size irq array...

It's quite possible to have:

IRQ	chip
0	irqchip_0
1	irqchip_0
2	irqchip_1
3	irqchip_0
4	irqchip_0
5	irqchip_1
6	irqchip_2
7	irqchip_2
8	irqchip_2
9	irqchip_1

Where do you start '0' for each irqchip?  How do you split the irq_desc
array between the irqchips?

(and yes there are platforms merged which do this.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
