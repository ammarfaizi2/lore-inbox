Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbTLHJoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTLHJoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:44:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36364 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265358AbTLHJoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:44:01 -0500
Date: Mon, 8 Dec 2003 09:43:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia yenta no devices Re: APM Suspend Problem
Message-ID: <20031208094358.C27327@flint.arm.linux.org.uk>
Mail-Followup-To: Bob <recbo@nishanet.com>, linux-kernel@vger.kernel.org
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com> <20031129082200.A30476@flint.arm.linux.org.uk> <3FC88277.4090304@rogers.com> <20031201210739.C13621@flint.arm.linux.org.uk> <3FD24E34.3050300@rogers.com> <20031207170638.B20112@flint.arm.linux.org.uk> <3FD3DCA6.6000109@nishanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FD3DCA6.6000109@nishanet.com>; from recbo@nishanet.com on Sun, Dec 07, 2003 at 09:06:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 09:06:30PM -0500, Bob wrote:
> If cbdump could help me figure out why I
> don't have any pcmcia cardbus devices showing
> up when I boot or insert or remove storage cards

It might give some clues - you'll have to try it.  The thing to look at
is CB_SOCKET_STATE, bits 1 and 2.  These are the two card detect bits,
and '1' means not detected, '0' means detected.  They both have to be
zero when the card is inserted.

> and a Hawking 10/100 32-bit cardbus ethernet
> pcmcia ethernet card, what is a command line
> that will gcc -o cbdump cbdump.c ?

You didn't look in the comments at the top of the file.  I guess that
also means I could've put a license on the file which required you to
do a John Cleese silly walk and email me the evidence immediately
before compiling it. 8)

> yenta in kernel-2.6.0-test11  but no pcmcia ethernet card drivers
> in kernel since I don't know which eth chip is on a Hawking pcmcia
> PN672TX 32-bit cardbus 10/100 ethernet card.
> 
> boot with compact flash Kingston or Sandisk storage card in
> pcmcia adapter and Hawking ethernet pcmcia card in second
> pcmcia cardbus slot, nothing, try remove and insert, still
> nothing, no pcmcia events or devices reported
> 
> Dec  4 02:32:43 where kernel: Linux Kernel Card Services
> Dec  4 02:32:43 where kernel:   options:  [pci] [cardbus] [pm]
> Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 
> 0000:01:0a.0 [414e:454c]
> Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
> Dec  4 02:32:43 where kernel: Socket status: 30000006
> Dec  4 02:32:43 where kernel: Yenta: CardBus bridge found at 
> 0000:01:0a.1 [414e:454c]
> Dec  4 02:32:43 where kernel: Yenta: ISA IRQ list 0000, PCI irq16
> Dec  4 02:32:43 where kernel: Socket status: 30000006

This tells me that both sockets are reporting that they are empty.
(Socket status == CB_SOCKET_STATE)  Since we don't know any better,
we believe them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
