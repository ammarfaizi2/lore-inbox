Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTERP6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTERP6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 11:58:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55681 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261773AbTERP6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 11:58:22 -0400
Date: Sun, 18 May 2003 17:11:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030518161105.GA7404@mail.jlokier.co.uk>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk> <20030518053935.GA4112@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518053935.GA4112@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, May 16, 2003 at 10:51:36PM +0200, Alan Cox wrote:
> > On Iau, 2003-05-15 at 16:16, Dave Jones wrote:
> > > There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
> > > we can work around them with a quirk.  I have one *somewhere*, but it'll
> > > take me a while to dig it out.
> > 
> > Some older SiS cards have problems too. I have a 6326 that doesn't work
> > with sisfb (too old) and vesafb with mtrr fails.
> 
> Can you provide PCI info for them to add a quirk ? 

What exactly "doesn't work" with these cards?

I'm thinking that the only way write-combining MTRRs could possibly
break a framebuffer is if part of the address range is used as a
register bank - otherwise, to the card, it just looks like well
written rendering code.

If this is so, then it might be possible to set write-combining MTRRs
while the framebuffer is operating, but to temporarily disable those
MTRRs while calling into the VESA BIOS code, for these cards.

And if that does work, then it might even be reasonable to temporarily
disable the MTRRs while calling the BIOS for all vesafb cards, thus
removing the need for a blacklist -- which is a headache for something
that needs to be as portable to unknown cards as vesafb.

-- Jamie


