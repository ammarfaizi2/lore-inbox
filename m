Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWJGRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWJGRPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWJGRPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:15:48 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:40638 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932341AbWJGRPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:15:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sat, 7 Oct 2006 19:16:26 +0200
User-Agent: KMail/1.8
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071249.48194.oliver@neukum.org> <20061007110824.GA4277@ucw.cz>
In-Reply-To: <20061007110824.GA4277@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071916.27315.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 7. Oktober 2006 13:08 schrieb Pavel Machek:
> Hi!
> 
> > > > > > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > > > > > - there should be a common API for all devices
> > > > > 
> > > > > AFAIK there is no demonstrated need for an API to suspend
> > > > > individual devices.  ...
> > > > 
> > > > I doubt that a lot. 
> > > 
> > > You haven't demonstrated such a need either; so why doubt it?
> > 
> > OK, let me state the basics.
> > 
> > To get real power savings, we:
> > - blank the display
> > - spin down the hard drive
> > - put the CPU into an ACPI sleep state
> > 
> > To do the latter well, we need to make sure there's no DMA. It is
> > important that less or little DMA will not help. We need no DMA.
> > So we need to handle the commonest scenarios fully.
> > 
> > I dare say that the commonest scenario involving USB is a laptop with
> > an input device attached. Input devices are for practical purposes always
> > opened. A simple resume upon open and suspend upon close is useless.
> 
> Okay, but you can simply do autosuspend with remote wakeup completely
> inside input driver. You do ot need it to be controlled from X... at
> most you need one variable ('autosuspend_inactivity_timeout')
> controlled from userland.
> 
> That's what we already do for hdd spindown... you simply tell disk to
> aitospindown after X seconds of inactivity.

The firmware in the drive supplies this function. It's hardly by choice
that it is made available. The power management functions without
timeout are also exported. For other power control features like
cpu frequency considerable effort has been made to export them to
user space.

A simple timeout solution has drawbacks.

- there's no guarantee the user wants wakeup (think laptop on crowded table)
- you want to suspend immediately when you blank the screen (or switch to
a text console)
- you want to consider all devices' activity. I am not pleased if my mouse
becomes less responsive just because I used only the keyboard for a
few minutes. Coordinating this inside the driver is hard as some input
devices might well be not usb (eg. bluetooth mouse, usb tablet)

	Regards
		Oliver
