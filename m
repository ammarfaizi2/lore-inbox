Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286403AbRLTVtH>; Thu, 20 Dec 2001 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286408AbRLTVs5>; Thu, 20 Dec 2001 16:48:57 -0500
Received: from d-dialin-708.addcom.de ([62.96.161.236]:27887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286403AbRLTVso>; Thu, 20 Dec 2001 16:48:44 -0500
Date: Thu, 20 Dec 2001 22:48:46 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Pavel Machek <pavel@suse.cz>
cc: Cory Bell <cory.bell@usa.net>, <linux-kernel@vger.kernel.org>,
        John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <20011219225330.A517@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0112202235520.919-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Pavel Machek wrote:

> dump_pirq is:
> 
> Interrupt routing table found at address 0xfdf40:
>   Version 1.0, size 0x00a0
>   Interrupt router is device 00:07.0
>   PCI exclusive interrupt mask: 0x0000
>   Compatible router: vendor 0x10b9 device 0x1533
> 
> Device 00:0f.0 (slot 0):
> 
> Device 00:02.0 (slot 0):
>   INTA: link 0x59, irq mask 0x0800

Hmmh, this doesn't fit the in-kernel ali IRQ routing code at all. Can you 
mail me your ACPI DSDT, this may help to figure out how the IRQ routing 
really works.

> Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
>   INT1 (link 1): irq 11
>   INT2 (link 2): irq 11
>   INT3 (link 3): unrouted
>   INT4 (link 4): unrouted
>   INT5 (link 5): unrouted
>   INT6 (link 6): unrouted
>   INT7 (link 7): unrouted
>   INT8 (link 8): unrouted
>   Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]

Cruel hack to route every link to irq 11 (may of course lock up your box)

setpci -s 7.0 49.b=99
setpci -s 7.0 4a.b=99
setpci -s 7.0 4b.b=99

(assumes you still hardwire the IRQ for the maestro to 11)

Does this help - do you actually get sound interrupts then? If so, you 
could try to figure out which exact link it is connected to by just having 
one of the above nibbles set to 9, leave the others at 0.

The Ali IRQ routing code definitely needs fixing, it'll write totally 
wrong config space addresses with your $PIRQ table, it's just not clear 
(to me) how to fix it correctly. The DSDT may help, documentation on the 
chipset too, of course.

--Kai



