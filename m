Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIWPZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIWPZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUIWPZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:25:53 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:61825 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266273AbUIWPZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:25:51 -0400
Date: Thu, 23 Sep 2004 17:25:30 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
Message-ID: <20040923152530.GA9377@vana.vc.cvut.cz>
References: <1095758630.3332.133.camel@gaston> <1095761113.30931.13.camel@localhost.localdomain> <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com> <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> <52mzzjnuq7.fsf@topspin.com> <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org> <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz> <1095900539.6359.46.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095900539.6359.46.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:49:00AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2004-09-23 at 04:58, Petr Vandrovec wrote:
> 
> > > I'd rather have matroxfb use writel with an explicit swap, or better, the
> > > driver could maybe disable big endian register access and switch the card
> > > to little endian, provided it can do that while keeping the frame buffer
> > > itself set to BE (which is necessary most of the time).
> >
> > It is due to compatibility with XFree (or at least I was told) - they want 
> > both framebuffer and accelerator in big-endian mode, so there is really no
> > choice (other than not supporting ppc...).
> 
> Hrm... having a quick look at mga driver in current Xorg tree, it uses
> the MMIO_IN/OUT macros directly, those are not byteswapping ?
> 
> It also does this at one point (ugh !) :
> 
> #if X_BYTE_ORDER == X_BIG_ENDIAN
> 	/* Disable byte-swapping for big-endian architectures - the XFree
> 	   driver seems to like a little-endian framebuffer -ReneR */
> 	/* pReg->Option |= 0x80000000; */
> 	pReg->Option &= ~0x80000000;
> #endif
> 
> Weird... I think the X driver just lacks any "knowledge" of what's going
> on with endianness...

Ok.  Can somebody tell me what byte order should be used for framebuffer
and for MMIO on PPC/PPC64 then?  From cfb* it seems that framebuffer
have to be in big-endian mode, and from Xorg code it seems that MMIO should 
be always in little-endian.  Yes?

							Petr Vandrovec

