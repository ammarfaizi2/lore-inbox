Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWJGLIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWJGLIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWJGLIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:08:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30469 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750836AbWJGLIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:08:37 -0400
Date: Sat, 7 Oct 2006 11:08:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061007110824.GA4277@ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610060904.51936.oliver@neukum.org> <200610061410.10059.david-b@pacbell.net> <200610071249.48194.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610071249.48194.oliver@neukum.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > > > > - there should be a common API for all devices
> > > > 
> > > > AFAIK there is no demonstrated need for an API to suspend
> > > > individual devices.  ...
> > > 
> > > I doubt that a lot. 
> > 
> > You haven't demonstrated such a need either; so why doubt it?
> 
> OK, let me state the basics.
> 
> To get real power savings, we:
> - blank the display
> - spin down the hard drive
> - put the CPU into an ACPI sleep state
> 
> To do the latter well, we need to make sure there's no DMA. It is
> important that less or little DMA will not help. We need no DMA.
> So we need to handle the commonest scenarios fully.
> 
> I dare say that the commonest scenario involving USB is a laptop with
> an input device attached. Input devices are for practical purposes always
> opened. A simple resume upon open and suspend upon close is useless.

Okay, but you can simply do autosuspend with remote wakeup completely
inside input driver. You do ot need it to be controlled from X... at
most you need one variable ('autosuspend_inactivity_timeout')
controlled from userland.

That's what we already do for hdd spindown... you simply tell disk to
aitospindown after X seconds of inactivity.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
