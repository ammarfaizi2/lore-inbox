Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274887AbTHFHLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274893AbTHFHLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:11:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:56237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274887AbTHFHLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:11:02 -0400
Message-Id: <200308060711.h767B0I19677@mail.osdl.org>
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.5/2.6 PCMCIA Issues
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Reply-To: torvalds@osdl.org
Date: Wed, 06 Aug 2003 00:11:00 -0700
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org> <20030805234212.081c0493.akpm@osdl.org>
Organization: OSDL
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> I have an IBM A21P which has the same problem.
> 
> The controller is a PCI1450 (rev 03)
> 
> The symptoms are that insertion of a PCMCIA or Cardbus card causes the
> machine to lock up: it is calling yenta_interrupt() a zillion times per
> second.  Presumably the IRQ isn't getting cleared.
> 
> Disabling i82635 in config fixes it up.

Ok. Misha confirmed that disabling 82365 works for him too.

I don't see what should have changed in 2.5.71 here, though. There are
some pcmcia changes there, but they all look like they are just changes
to the calling convention, not any _functional_ differences.

Anyway, I suspect that i82365 should just quit by default if a yenta
controller has already been found. I can't imagine that you'd have
both a yenta controller _and_ an i82365 controller, since there are
actually some port overlaps there (ie yenta should already register
the i82365 legacy ports).

Something is broken in resource handling that the i82365 driver
even tries to probe for the ports that are in use.

Russell, any ideas about why i82365 doesn't just leave the thing
well alone?

                Linus
