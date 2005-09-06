Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVIFQIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVIFQIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIFQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:08:51 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:7359 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750750AbVIFQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:08:51 -0400
X-ORBL: [69.107.75.50]
Date: Tue, 06 Sep 2005 09:00:43 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com
References: <20050906100513.25072.qmail@web30307.mail.mud.yahoo.com>
In-Reply-To: <20050906100513.25072.qmail@web30307.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050906160043.9BDFAD480C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I did think about doing this but the problem is how do
> > > you know bus 2 is the bus you think it is?
> > 
> > The numbering is board-specific, but in most cases
> > that can be simplified to being SOC-specific.  ...
> > 
> > Hotpluggable SPI controllers are not common, but
> > that's where that sysfs API to define new devices
> > would really hit the spot. ...
> > 
> > (What I've seen a bit more often is that expansion
> > cards will be wired for SPI, so the thing that's
> > vaguely hotplug-ish is that once you know what
> > card's hooked up, you'll know the SPI devices it
> > has.  Then the question is how to tell the kernel
> > about them ...  same solution, which again must work
> > without hardware probing.)
>
> This is why I decided to pass the cs table as platform
> data when an adapter is registered. This way you don't
> have to try to find out an adapters bus number as the
> adapter has the cs table in it, but because it was
> passed in as platform data it still abstracts that
> from the adapter driver. Simple, yet effective :)

Except that it doesn't work in that primary case, where the SPI devices
are physically decoupled from any given SPI (master) controller.
One expansion card uses CS1 for a touchscreen; another uses CS3 for
SPI flash ... the same "cs table" can't handle both configurations.
It's got to be segmented, with devices separated from controllers.

Plus, that depends on standardizing platform_data between platforms.
That's really not the model for platform_data!  And "struct clk" is
ARM-only for now, too ... 


> Have you looked at the patch which I sent?
> http://www.ussg.iu.edu/hypermail/linux/kernel/0509.0/0817.html
>
> I would appreciate any comments on this approach.

Yes, I plan to follow up to that with comments.  As with Dmitry's
proposal, it's modeled closely on I2C, and is in consequence larger
than needed for what it does.

One reason I posted this driver-model-only patch was to highlight how
minimal an SPI core can be if it reuses the driver model core.  I'm
not a fan of much "mid-layer" infrastructure in driver stacks.

- Dave

