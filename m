Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUBTJ1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUBTJ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:27:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267759AbUBTJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:27:07 -0500
Date: Fri, 20 Feb 2004 09:26:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220092651.B22235@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston> <4035C068.8050605@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4035C068.8050605@pacbell.net>; from david-b@pacbell.net on Fri, Feb 20, 2004 at 12:08:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 12:08:08AM -0800, David Brownell wrote:
> Benjamin Herrenschmidt wrote:
> > Yes. I also remember a time where the dma mask for the DMA API was all
> > broken too (would not be possible to map the PCI one on top of it),
> > but I think that got fixed. 
> 
> I thought it was still broken.  Last I compared different asm-* arch
> implementations of dma_supported(), the semantics were inconsistent.
> The "mask" was sometimes ignored, sometimes treated as an upper
> bound on the address, once I recall it even being used as a mask!
> Some of that inconsistency seemed to come from PCI though.

My understanding is that it's a mask, which just happens to be treated
as an upper address limit on sane platforms.

However, we have a case where it's a real mask (no surprises there!)
Intel decided not to fix a bug in a chip which means that an address
line (normally A20) must never be asserted during DMA cycles, although
it can address more than 1MB of memory.  The effect of this is that
even MB are dma-able and odd MB aren't.  Not nice.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
