Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbTHFLXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270716AbTHFLXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:23:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55309 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270714AbTHFLXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:23:43 -0400
Date: Wed, 6 Aug 2003 12:23:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806122340.B2094@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org> <20030805234212.081c0493.akpm@osdl.org> <200308060711.h767B0I19677@mail.osdl.org> <20030806103320.A2094@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806103320.A2094@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Aug 06, 2003 at 10:33:20AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, more data points.

- Zwane Mwaikambo tried enabling yenta + i82365 + pnp on his machine.
  The boot messages for PCMCIA were:

	Linux Kernel Card Services 3.1.22
	  options:  [pci] [cardbus] [pm]
	...
	ti113x: Routing card interrupts to PCI
	Yenta IRQ list 0000, PCI irq9
	Socket status: 30000006
	Intel PCIC probe: not found.

  As you can see, the PCIC probe didn't find any PNP devices.  No
  problems were noticed.

- I've just tried modular PCMCIA, inserting both yenta and i82365 on
  an (arm) machine, obviously without PNP here...

	Linux Kernel Card Services 3.1.22
	  options:  [pci] [cardbus]
	irq 21: nobody cared
	Yenta IRQ list 0000, PCI irq21
	Socket status: 30000007
	irq 22: nobody cared
	Yenta IRQ list 0000, PCI irq22
	Socket status: 30000811
	Intel PCIC probe: <7>PCI: master abort, pc=0xbf020818
	PCI: master abort, pc=0xbf020818
	PCI: master abort, pc=0xbf020818
	not found.

  Again, no PNP activity as expected, and no undesirable side effects
  caused by inserting and removing PCMCIA cards.  (the master aborts
  come from attempting to access 0x3e0/1 and having nothing on the PCI
  bus to claim it... yes, not even an ISA bridge...)

Could the problem be PNP related?  I don't see much material change in
the PNP layer between 2.5.70 and 2.5.71 though.

Can other people try the CONFIG_YENTA=y, CONFIG_I82365=y, CONFIG_PNP=y
and report their results (in particular the dmesg from boot, and whether
the machine locks when they insert a card _after_ boot.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

