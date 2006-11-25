Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966539AbWKYMvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966539AbWKYMvA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966560AbWKYMu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:50:59 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:39393 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S966539AbWKYMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:50:59 -0500
Message-ID: <45683C45.8020904@f2s.com>
Date: Sat, 25 Nov 2006 12:51:17 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel-discuss] RFC - platform device, IRQs and SoC devices
References: <4563242D.9050901@f2s.com> <45682B0E.4060202@f2s.com> <20061125122910.GA12104@flint.arm.linux.org.uk>
In-Reply-To: <20061125122910.GA12104@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>
> It's quite possible to have:
> 
> IRQ	chip
> 0	irqchip_0
> 1	irqchip_0
> 2	irqchip_1
> 3	irqchip_0
> 4	irqchip_0
> 5	irqchip_1
> 6	irqchip_2
> 7	irqchip_2
> 8	irqchip_2
> 9	irqchip_1
> 
> Where do you start '0' for each irqchip?  How do you split the irq_desc
> array between the irqchips?

I see no reason why this couldnt continue to work 'as is' with the new 
behaviour only applying to irqchips with their own non-NULL irq_desc array.

The other problem is integration with /proc, specifically the irq usage 
counter.

The irq numbers in /proc wouldnt have to be 'real' they can be 
synthesized from a base starting after the main system IRQs.

Im not sure how fixed the format of /proc/interrupts is, wether the IRQ 
numbers are required to be sequential or not (some arent even numbers 
like NMI on x86). if they dont have to be sequential then its simply a 
matter of keeping a counter starting from BOARD_IRQ_END+1 and for each 
IRQchip adding its individual irq numbers to it as they are displayed, 
then incrementing the counter by the size of the irqdesc array for that 
chip.
