Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUIPMNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUIPMNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIPMNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:13:52 -0400
Received: from gprs214-31.eurotel.cz ([160.218.214.31]:27776 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268025AbUIPMNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:13:38 -0400
Date: Thu, 16 Sep 2004 14:13:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
Message-ID: <20040916121259.GA3125@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams> <20040916111852.GC5467@elf.ucw.cz> <1095334173.3324.200.camel@laptop.cunninghams> <20040916113205.GF5467@elf.ucw.cz> <1095335274.4932.219.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095335274.4932.219.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > do it later:
> > > 
> > > Suspend all other drivers.
> > > Write pageset 2 (page cache).
> > > Suspend used drivers.
> > > Make atomic copy.
> > > Resume used drivers.
> > > Write pageset 1 (atomic copy)
> > > Suspend used drivers.
> > > Power down all.
> > 
> > What is problem with:
> > 
> > Write pageset 2
> > Suspend all drivers (avoiding slow operations)
> > Make atomic copy
> > Resume all drivers (avoiding slow operations)
> > Write pageset 1
> > Suspend all drivers
> > Power down all.
> 
> It's always interesting trying to remember your logic for doing
> something after the fact :>. If I recall correctly, it goes like this:
> 
> Writing two pagesets forces me to account for memory usage much more
> carefully. I need to ensure before I start to write the image that I
> know exactly what the size is and have allocated enough memory to do the
> write. If I get some driver coming along and grabbing memory for who
> knows what (hotplug, anyone? :>), I may get stuck halfway through
> writing the image with no memory to use. I also have to be paranoid
> about how much memory is available because I save that too (some of it
> may have become slab by the time I do the atomic copy).

What prevents video driver or disk driver to grab some memory? Tree
containing disk device can be pretty big [pci-usb-usb_hub-disk] and
contain some hot-pluggable components.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
