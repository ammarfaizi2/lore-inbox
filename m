Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJHTTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJHTTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWJHTTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:19:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751351AbWJHTTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:19:51 -0400
Date: Sun, 8 Oct 2006 21:19:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061008191937.GE3788@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071249.48194.oliver@neukum.org> <20061007110824.GA4277@ucw.cz> <200610071916.27315.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610071916.27315.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > OK, let me state the basics.
> > > 
> > > To get real power savings, we:
> > > - blank the display
> > > - spin down the hard drive
> > > - put the CPU into an ACPI sleep state
> > > 
> > > To do the latter well, we need to make sure there's no DMA. It is
> > > important that less or little DMA will not help. We need no DMA.
> > > So we need to handle the commonest scenarios fully.
> > > 
> > > I dare say that the commonest scenario involving USB is a laptop with
> > > an input device attached. Input devices are for practical purposes always
> > > opened. A simple resume upon open and suspend upon close is useless.
> > 
> > Okay, but you can simply do autosuspend with remote wakeup completely
> > inside input driver. You do ot need it to be controlled from X... at
> > most you need one variable ('autosuspend_inactivity_timeout')
> > controlled from userland.
> > 
> > That's what we already do for hdd spindown... you simply tell disk to
> > aitospindown after X seconds of inactivity.
> 
> The firmware in the drive supplies this function. It's hardly by choice
> that it is made available. The power management functions without
> timeout are also exported. For other power control features like
> cpu frequency considerable effort has been made to export them to
> user space.
> 
> A simple timeout solution has drawbacks.
> 
> - there's no guarantee the user wants wakeup (think laptop on
> crowded table)

If you do not want wakeups (=> do not want any input from that
device), then close that device.

> - you want to suspend immediately when you blank the screen (or switch to
> a text console)

I kind-of understand "when you blank", but I do not think this
mandatory. Why would you want to suspend when switching to text
console? Am I no longer allowed to use gpm?

> - you want to consider all devices' activity. I am not pleased if my mouse
> becomes less responsive just because I used only the keyboard for a
> few minutes. Coordinating this inside the driver is hard as some input
> devices might well be not usb (eg. bluetooth mouse, usb tablet)

Yep, that would be nice; but not at price of /sys/.../power/state like
monstrosity that never ever worked properly.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
