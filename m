Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGaXo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGaXo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVGaXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:44:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261256AbVGaXoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:44:25 -0400
Date: Sun, 31 Jul 2005 16:44:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <20050731232735.GF27580@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org> <20050731230507.GE27580@elf.ucw.cz>
 <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org> <20050731232735.GF27580@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Pavel Machek wrote:
> > 
> > Why do it _ever_? There is _zero_ upside to doing it, I don't see why you 
> > want to.
> 
> Being able to turn off your soundcard at runtime when you are not
> using it was one of examples...

I meant the "ACPI restores irq controller state" thing.

Just leave it in. There's never any downside. If all the drivers end up 
doing free_irq/request_irq(), restoring the irq controller state still 
won't have any negative effect, and it solves the case where you have 
drivers that don't do it.

> > Just make ACPI restore the dang thing. It's the right thing to do.
> 
> Requires interpretter running with interrupts disabled => ugly :-(.

I don't see that. What's ugly? I agree that ACPI is ugly, but I do _not_ 
agree that it's ugly to restore irq controller state with interrupts 
disabled. It MakesSense(tm) to do so.

The fact that ACPI was designed by a group of monkeys high on LSD, and is 
some of the worst designs in the industry obviously makes running it at 
_any_ point pretty damn ugly. And the fact that MB vendors don't test it 
with anything else than Windows (and sometimes you wonder whether they do 
even that) doesn't help. So hell yes, it's ugly, and nasty. But interrupts 
disabled has nothing to do with any of it.

Besides, there's no real reason why you'd even have to do it with 
interrupts disabled. I personally think that it makes _sense_ to try to 
restore the irq controller state with irq's off, but as I made clear 
earlier in this flame-fest, there's no real reason why you couldn't just 
run with interrupts on.

If an interrupt is screaming due to lack of initialization and gets turned
off, just make sure it gets re-enabled when it is being initialized.

		Linus
