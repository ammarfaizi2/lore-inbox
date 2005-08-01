Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263210AbVHAH2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbVHAH2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVHAH04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:26:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17637 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262298AbVHAHZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:25:38 -0400
Date: Mon, 1 Aug 2005 09:25:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050801072500.GL27580@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org> <20050731230507.GE27580@elf.ucw.cz> <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org> <20050731232735.GF27580@elf.ucw.cz> <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Why do it _ever_? There is _zero_ upside to doing it, I don't see why you 
> > > want to.
> > 
> > Being able to turn off your soundcard at runtime when you are not
> > using it was one of examples...
> 
> I meant the "ACPI restores irq controller state" thing.
> 
> Just leave it in. There's never any downside. If all the drivers end up 
> doing free_irq/request_irq(), restoring the irq controller state still 
> won't have any negative effect, and it solves the case where you have 
> drivers that don't do it.
> 
> > > Just make ACPI restore the dang thing. It's the right thing to do.
> > 
> > Requires interpretter running with interrupts disabled => ugly :-(.
> 
> I don't see that. What's ugly? I agree that ACPI is ugly, but I do _not_ 
> agree that it's ugly to restore irq controller state with interrupts 
> disabled. It MakesSense(tm) to do so.

ACPI people claim it would mean rewritting lot of code in
interpretter. And they are probably right: restoring irq states is
done via running ACPI AML code, and it may ask you to grab semaphore;
which is something you can't do with interrupts disabled.

So you'd have to teach ACPI interpretter completely different "irq
disabled" mode, and even then it is not clear what to do if AML code
asks you for some "sleeping operation".

[Hey, it should be Len doing this debate, not me. I hope I'll never
have to touch ACPI interpretter.]
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
