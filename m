Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVKUWSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKUWSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVKUWSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:18:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751164AbVKUWSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:18:45 -0500
Date: Mon, 21 Nov 2005 14:18:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132609994.26560.39.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511211413390.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
 <24299.1132571556@warthog.cambridge.redhat.com>  <20051121121454.GA1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>  <20051121190632.GG1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>  <20051121194348.GH1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>  <1132607776.26560.23.camel@gaston>
  <Pine.LNX.4.64.0511211336440.13959@g5.osdl.org> <1132609994.26560.39.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> And ? I really don't agree that just because 0 "looks kewl", we should
> enforce that and add some dodgy remapping all over the place.

That's not at all what I'm saying.

THE "BAD IRQ" MAPPING IS REQUIRED REGARDLESS.

If we make PCI_NO_IRQ be -1, then PC's need to remap 0 to that value. In 
pretty much _exactly_ the same places that I suggest that the ppc code 
should do it.

And there are several thousand times more PC's than there are other 
things.

Got it?

Everybody who argues for PCI_NO_IRQ being -1 is arguing for all the same 
things I argue that the ppc port should do, except they _also_ argue that 
we should break now-working setups.

Is that so hard to understand? -1 is no different from 0, except it is in 
many way sprovably _inferior_. Both need some mapping. But the -1 case 
needs more of it, _and_ will result in a inferior end result (because the 
nice "!dev->pci" thing suddenly doesn't work).

See? You're arguing for a technically inferior solution. 

		Linus
