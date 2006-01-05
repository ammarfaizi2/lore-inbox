Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWAEVhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWAEVhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbWAEVhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:37:54 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:62925 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750960AbWAEVhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:37:53 -0500
Date: Thu, 5 Jan 2006 16:37:52 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: "Scott E. Preece" <preece@motorola.com>, <akpm@osdl.org>,
       <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060105211446.GD2095@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0601051631200.6460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Pavel Machek wrote:

> > > | Why to make it this complex?
> > > | 
> > > | I do not think there's any confusion possible. "on" always corresponds
> > > | to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
> > > | should know that, too...
> > 
> > Not necessarily.  For instance, a particular driver might want to map 
> > "suspend" to D1 instead of to D3.
> 
> Ok, lets change that to "on" and "off". That way, hopefully all the
> drivers will agree that "off" means as low Dstate as possible.

Nothing wrong with that.  We could let "off" be another synonym.  Although 
I don't see the need for it, really.

> > Given that "on" and "suspend" are generic names and not actual states (at 
> > least, not for PCI devices and presumably not for others as well), I think 
> > it makes sense to treat them specially.
> > 
> > And it's not all that complex.  Certainly no more complex than forcing
> > userspace tools to use {"on", "D1, "D2", "suspend"} instead of the
> > much-more-logical {"D0", "D1", "D2", "D3"}.
> 
> It is not much more logical. First, noone really needs D1 and
> D2. Plus, people want to turn their devices on and off, and don't want
> and should not have to care about details like D1.

Who are you to say what people really need?  What about people who want to 
test their PCI device and see if it behaves properly in D1 or D2?  How are 
they going to do that if you don't let them put it in that state?

What about people with platform-specific non-PCI devices that have a whole
bunch of different internal power states?  Why force them to use only two
of those states?

The kernel isn't supposed to prevent people from doing perfectly legal
things.  The kernel should provide mechanisms to help people do what they
want.

Besides, as long as the sysfs interface accepts "on" and "suspend" (or 
"off"), what harm does it do to accept the device-specific names as 
well?

Alan Stern

