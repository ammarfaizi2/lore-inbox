Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUHJUa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUHJUa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUHJU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:29:11 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:9119 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267713AbUHJU21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:28:27 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] Fix Device Power Management States
Date: Tue, 10 Aug 2004 11:36:38 -0700
User-Agent: KMail/1.6.2
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net> <20040810101308.GE9034@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040810101308.GE9034@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101136.38387.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 3:13 am, Pavel Machek wrote:
> Hi!
> 
> > > Well, "no DMA" needs to be part of definition, too, because some
> > > devices (USB) do DMA only if they have nothing to do.

I think that should read "even if they have ...", not "only if ...".


> > I don't understand; that doesn't sound healthy.
> 
> It is not healthy. It is basicaly misdesigned piece of hardware called
> UHCI. It simply does DMA all the time :-(.

Unless it's suspended ... and I confess I've only had time to
make sure that OHCI and EHCI suspend properly using the
newish CONFIG_USB_SUSPEND patch.  UHCI is different
from those other mainstream controllers, it doesn't split
out its periodic schedule processing.

Keep in mind that to properly quiesce a USB controller, you've
got to quiesce every driver for every device hooked up to
that USB bus.  There's no escaping the bottom-up suspend
or top-down-resume processes, which makes me wonder
how Patrick's proposed patch can work for it...

- Dave
 
