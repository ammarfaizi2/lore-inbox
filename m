Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUAOWGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUAOWGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:06:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:52497 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263625AbUAOWFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:05:47 -0500
Date: Thu, 15 Jan 2004 22:55:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Brownell <david-b@pacbell.net>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] improce USB Gadget Kconfig
In-Reply-To: <3FF0F6F5.10409@pacbell.net>
Message-ID: <Pine.LNX.4.58.0401152200330.2530@serv>
References: <20031123172356.GB16828@fs.tum.de> <3FF0F6F5.10409@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0401152200332.2530@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Dec 2003, David Brownell wrote:

> How about using this approach instead?   It simplifies the kconfig
> for the gadget drivers by providing a boolean "which hardware"
> symbol, so gadget drivers don't need to make their own.  The symbol
> that's synthetic is the one needed only by the Makefile.

There are some strange things in there.
choice values can also be tristate symbols, so you wouldn't need the
separate defines, unless you really always want to compile only a single
controller (even as module).
The "default m if USB_GADGET = m" looks weird, if I understand them
correctly this should just be "depends on USB_GADGET", e.g.

config USB_NET2280
	tristate
	depends on USB_GADGET
	default USB_GADGET_NET2280

this would also fix the menu structure and the drivers menu would appear
below the gadget option.
I'm also not sure about USB_PXA2XX_SMALL, as it also can be written as:

config USB_PXA2XX_SMALL
	depends on USB_PXA2XX = y
	default USB_ZERO = y || USB_ETH = y || USB_G_SERIAL

is this really intended?

The dependency "USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100
|| USB_GOKU" can be basically reduced to "USB_GADGET".

> Roman, this seems to trigger some kind of xconfig/menuconfig bug,
> since I can go down the list of hardware options (net2280, goku,
> dummy -- three, not the single one Adrian was working with) and
> each deselects the previous selection ... but then it's impossible
> to turn off the dummy, and select real hardware.

I can't reproduce this, it works fine here.

bye, Roman
