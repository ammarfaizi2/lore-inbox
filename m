Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTKYD0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKYD0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:26:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:58586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262051AbTKYD0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:26:07 -0500
Date: Mon, 24 Nov 2003 19:25:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: David Hinds <dhinds@sonic.net>, linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031125031156.GA4243@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0311241919220.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net>
 <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org>
 <20031125023319.GA3819@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241845200.1599@home.osdl.org>
 <Pine.LNX.4.58.0311241851480.1599@home.osdl.org> <20031125031156.GA4243@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Nov 2003, Jean Tourrilhes wrote:

>
> 	Don't waste too much time on that, it might be hopeless. I
> personally don't believe that the kernel code will ever get it right,
> so I'm really looking at adding some override for this specific
> situation.

The kernel is actually very good at getting the PCI irq's right - if it
doesn't, _no_ PCI card will function right. This is definitely not a
"Cardbus is special" issue - the irq routing tables are used for every
single thing out there.

And in fact your tables seem to have the thing:

> Device 00:13.0 (slot 4): CardBus bridge
>   INTA: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
>   INTB: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
>   INTC: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
>   INTD: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Can you enable DEBUG in "arch/i386/pci/pci.h"?

AHH.. I think I know what's up. Your PIRQ table is fine, but your MP table
probably doesn't translate the legacy IRQ into the APIC one.

You may be able to boot a UP kernel properly, but I'm sure that the MP
thing is solvable too. Send the whole dmesg out, with DEBUG enabled both
in pci.h and in "include/asm-i386/apic.h".

		Linus
