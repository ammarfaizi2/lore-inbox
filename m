Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUIWW4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUIWW4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIWW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:56:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:51423 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267515AbUIWW1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:27:40 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923152530.GA9377@vana.vc.cvut.cz>
References: <1095758630.3332.133.camel@gaston>
	 <1095761113.30931.13.camel@localhost.localdomain>
	 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
	 <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz>
	 <1095900539.6359.46.camel@gaston>  <20040923152530.GA9377@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1095978205.10865.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 08:23:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 01:25, Petr Vandrovec wrote:

> 
> Ok.  Can somebody tell me what byte order should be used for framebuffer
> and for MMIO on PPC/PPC64 then?  From cfb* it seems that framebuffer
> have to be in big-endian mode, and from Xorg code it seems that MMIO should 
> be always in little-endian.  Yes?

I don't know exactly what X.org does ...

In general, on a PCI bus, we expect MMIO to be little endian. Some cards
try to be "smart" and have an endian swap facility for MMIO (like nvidia,
and I think matrox) but I tend to consider that useless since it force us
to have different IO accessors or to add an "un-byteswap" macro. The PPC
is very good at doing byteswapped accesses with one instruction so it
isn't really a waste to do all MMIOs littel endian anyway.

For the framebuffer, it's common practice to have it in big endian format
(and using the proper byteswap register for the access bit depth)

Ben.
 

