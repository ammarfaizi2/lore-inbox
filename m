Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUAPWHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUAPWFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:05:02 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13320 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265804AbUAPVq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:46:26 -0500
Date: Fri, 16 Jan 2004 22:41:06 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Brownell <david-b@pacbell.net>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] improce USB Gadget Kconfig
In-Reply-To: <400749F3.6070203@pacbell.net>
Message-ID: <Pine.LNX.4.58.0401162118320.2530@serv>
References: <20031123172356.GB16828@fs.tum.de> <3FF0F6F5.10409@pacbell.net>
 <Pine.LNX.4.58.0401152200330.2530@serv> <400749F3.6070203@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0401162118331.2530@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, David Brownell wrote:

> > choice values can also be tristate symbols, so you wouldn't need the
> > separate defines, unless you really always want to compile only a single
> > controller (even as module).
>
> That's it precisely.  USB devices have only one (upstream) link;
> they're not like hosts.  And its link to the controller isn't
> re-wired on the fly any more than, say, the MMU.  Kconfig just
> needed some persuasion before it'd dance that way.

It's still weird. Where is the problem to compile all controllers as
module? At runtime you still have the possibility that only one of them
can be loaded and the next one would fail to load.

> And similar for net2280, pxa2xx, and so on.  Either that, or moving it
> up higher in the text file, seems to have been the black magic that
> made the menu layout code behave.

To fix the menu layout it's probably the easiest to put most of it within
a "if USB_GADGET" ... "endif".

> > I'm also not sure about USB_PXA2XX_SMALL, as it also can be written as:
> >
> > config USB_PXA2XX_SMALL
> >     depends on USB_PXA2XX = y
> >     default USB_ZERO = y || USB_ETH = y || USB_G_SERIAL
> >
> > is this really intended?
>
> I'm not sure what you're asking.  I wrote it with one line per
> driver that's less error-prone in case updates get merged.  The
> latest version is more terse, but there are lots of ways to
> write that kind of logic.

The comment confuses me, I don't see how it tests that it's "only one" of
something.

> Reproduced it again here today, with a reasonably current 2.6.1
> tree on top of RH9 (plus some updated RPMs from RH).  It's there
> in gconfig too.  The workaround is "vi .config" and delete the
> sticky DUMMY_HCD entry, then re-configure.

It really works fine here, are you sure you don't have any additional
changes under scripts/kconfig? Did you try this on a different machine?

bye, Roman
