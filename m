Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJEUHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJEUHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJEUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:02:46 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:49378 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264443AbUJEUCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:02:00 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: PATCH/RFC:  driver model/pmcore wakeup hooks (0/4)
Date: Tue, 5 Oct 2004 13:01:24 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200410041354.37932.david-b@pacbell.net> <20041005193238.GC4723@openzaurus.ucw.cz>
In-Reply-To: <20041005193238.GC4723@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051301.24274.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 12:32 pm, Pavel Machek wrote:
> Hi!
> 
> > One significant example involves USB mice.  If they were to be
> > suspended (usb_suspend_device) after a few seconds of inactivity,
> > that change could often spread up the device tree and let the
> > USB host controller stop DMA access.  Some x86 CPUs could
> > then enter C3 and save a couple Watts of battery power ... until
> > the mouse moved, and woke that branch of the device tree
> > for a while (until the mouse went idle again).
> 
> 
> How fast is the wakeup? 

30+msec for the USB-specific signaling; plus a bit more for each
layer of USB hubs in its tree.  Lots more if power glitches force
re-enumeration of anything; but if those happen, they'd happen
during normal use too.


> Will not that make mouse jump a bit? 
> (Just curious...) 

I actually don't have a wakeup-capable mouse (the one I
have lies about it, fwiw) so I don't know how that acts.
My current wakeup testing uses a USB keyboard instead.

It may even need to be a click that wakes up the mouse;
you don't much want the system to wake up if you nudge
the table (and hence mouse), or a truck goes by, etc.

Len Brown may have details, he was particularly keen
on having this scenario work, given the number of Intel
laptops that would last longer under Linux this way ... it
was evidently a big win under Windows.

- Dave
