Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWEOWDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWEOWDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbWEOWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:03:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965267AbWEOWDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:03:04 -0400
Date: Mon, 15 May 2006 15:02:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
In-Reply-To: <1147730828.26686.165.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>  <20060423150206.546b7483.akpm@osdl.org>
  <20060508145609.GA3983@rhlx01.fht-esslingen.de>  <20060508084301.5025b25d.akpm@osdl.org>
  <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 May 2006, Alan Cox wrote:

> On Llu, 2006-05-08 at 17:34 +0100, Russell King wrote:
> > > So 8250 is requesting an IRQ for non-sharing mode and it's actually
> > > failing, because something else is already using that IRQ.  The difference
> > > is that the kernel now generates a warning when this happens.
> > 
> > Maybe someone is clearing the UPF_SHARE_IRQ flag?  Which port is this?
> 
> Its a bug in the PCMCIA code. Its the one I hit with the IDE code.
> Asking for a private IRQ is not always honoured. 

Note that some PCMCIA architectures simply _will_not_ give you a private 
IRQ. Ever. They may not have any ISA interrupts to give, even to old 
16-bit cards. So the choice may be "shared irq or nothing".

So I would strongly argue that any driver that depends on getting an 
exclusive IRQ is buggy, not the PCMCIA layer itself, and that it would be 
a lot more productive to try to fix those drivers.

Especially since exclusive irq's are clearly a dying breed, and have been 
for the last decade or two. Why try to keep that braindamage alive?

			Linus
