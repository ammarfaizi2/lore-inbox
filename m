Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVKVCis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVKVCis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVKVCis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:38:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:31180 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964874AbVKVCis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:38:48 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 13:36:12 +1100
Message-Id: <1132626973.26560.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If the choice instead is to embrace current graphics hardware, then
> given the current state of the market, I don't see any other
> alternative than using the proprietary drivers and OpenGL stacks. The
> path in that direction is something like Xgl.  We can wish for a
> non-proprietary choice on the current hardware, but the reality is
> that we are not going to get it.

As long as they don't need to put binary junk in the kernel, they can
keep the binary junk in userland, where it belongs. That is at least
acceptable and legal, even if it's not a great situation.

The problem is they load these multi-megabytes blocs that want to hook
into SMM BIOS interrupts, ACPI, VM, etc... all over the place and do all
sort of junk in your kernel. Say goodbye to any kind of stability and
maintainability of a kernel loaded with that crap.

And pretty much all of the crap in there doesn't have any good reason to
be closed source. That's all just plumbing. A lot of that could even be
shared between video drivers (they could use the DRI interface for
example, and if it's not enough for them, extend it). That is not where
the actual IP is.

But the real reasons are elsewhere anyway. They don't wnat to opensource
because they don't want to open the gazillion security holes in their
stuff (afaik, the binary drivers make absolutely no verification of the
command streams passed from userland, you can make the card do whatever
you want from any user context, including arbitrary DMA to/from system
memory), the various comments & workarounds for HW bugs that aren't
supposed to exist and might make some customers want to throw the cards
back at them, the disgusting pile of smelly windows-originated library
they link in and wrap all over the place to make linux look like NT,
etc...

And we do _not_ want that in the kernel. There is no point in having
linux on the desktop if it's at the cost of it being the same crap that
windows is.

Ben.


