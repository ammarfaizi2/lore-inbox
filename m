Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKUT1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKUT1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVKUT1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:27:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932097AbVKUT1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:27:34 -0500
Date: Mon, 21 Nov 2005 11:27:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <20051121190632.GG1598@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Nov 2005, Matthew Wilcox wrote:
>
> On Mon, Nov 21, 2005 at 10:55:24AM -0800, Linus Torvalds wrote:
> > Quite frankly, if we change [PCI_]NO_IRQ to -1, there's almost certainly 
> > going to be a lot of drivers breaking.
> 
> There's only one driver using NO_IRQ today (outside of architectures
> which define NO_IRQ to -1, that is).  So *this* series of patches should
> break nothing.

Right. But the point is that most drivers will do something like

	if (!dev->irq)
		return;

(whatever, made up). And that having NO_IRQ be anything but 0 is thus 
fundamentally broken.

Because the fact is, NO_IRQ _is_ zero. And exactly because it's zero, and 
that is encoded everywhere, nobody uses it.

> That's a common misreading of the PCI spec -- it actually says the
> opposite.

I'm NOT talking about PCI specs.

I'm talking about real hardware.

Read pretty much _any_ data-sheet for an interrupt router, and you'll see 
that the bit pattern 0000 means _disabled_. 

In other words, I'm talking about HARD REALITY.

I know, it's a bitch.

		Linus
