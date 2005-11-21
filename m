Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVKUTnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKUTnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKUTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:43:53 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:4557 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932361AbVKUTnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:43:52 -0500
Date: Mon, 21 Nov 2005 12:43:48 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051121194348.GH1598@parisc-linux.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 11:27:05AM -0800, Linus Torvalds wrote:
> On Mon, 21 Nov 2005, Matthew Wilcox wrote:
> >
> > On Mon, Nov 21, 2005 at 10:55:24AM -0800, Linus Torvalds wrote:
> > > Quite frankly, if we change [PCI_]NO_IRQ to -1, there's almost certainly 
> > > going to be a lot of drivers breaking.
> > 
> > There's only one driver using NO_IRQ today (outside of architectures
> > which define NO_IRQ to -1, that is).  So *this* series of patches should
> > break nothing.
> 
> Right. But the point is that most drivers will do something like
> 
> 	if (!dev->irq)
> 		return;
> 
> (whatever, made up). And that having NO_IRQ be anything but 0 is thus 
> fundamentally broken.

The idea was to give them something better to use instead of this.
Whether that be if (has_irq(dev)) return; or some other similar
construct, I'm not terribly fussed.

> I'm NOT talking about PCI specs.
> 
> I'm talking about real hardware.
> 
> Read pretty much _any_ data-sheet for an interrupt router, and you'll see 
> that the bit pattern 0000 means _disabled_. 

The only relevant thing I found with google was
http://www.microsoft.com/whdc/archive/pciirq.mspx

Where it talks about 0 meaning disabled, it says:

	Link Value for INTn#:A value of zero means this interrupt pin is
	not connected to any other interrupt pins and is not connected
	to any of the Interrupt Router's interrupt pins.

which is a different bit from where it talks about the AT-compatible
IRQ numbers.

Everything else I find seems to be talking about Arcnet hardware (!)
