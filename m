Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbTGZUqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269672AbTGZUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:46:43 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:37085 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S269646AbTGZUq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:46:29 -0400
Date: Sat, 26 Jul 2003 23:01:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030726210123.GD266@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F21B3BF.1030104@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I'm not sure how the design is intended to work, but either way something 
> >>needs to be fixed.
> 
> Yes, it seems like all the HCDs (and the hub driver) need attention.

Why the hub driver?

For basic functionality, you simply power it down (doing virtual
unplug), and power it back up on resume (doing virtual plug of all
devices). That should work reasonably for everything but mass-storage.

> Plus, the enumeration process should respect hubs' power budgets,
> and handle overcurrent better.  I had a hub re-enumerate over forty
> times not that long ago, just because it enabled too many things at
> once and the surge currents made lots of trouble.  Plenty of power,
> if it got turned on carefully enough... :)

Havin enough juice in "common case", but not in "worst case" is not
too legal situation, is it?

> >Could well be. I need to spend some time auditing power management
> >in the USB drivers in general. The idea here is that a sub-driver
> >(USB device driver) should make sure it has no more pending URBs
> >when returning from suspend() and the HCD driver should just cancel
> >pending URBs if still any and reject any one that would be submited
> 
> Agreed, this needs work.  Some USB device drivers will likely need to
> implement suspend()/resume() callbacks, which thoughtfully enough the
> driver model conversion already gave us.  At one point it was planned
> to have it automatically traverse the devices and suspend, leaves up to
> root; and resume in the reverse order.  Is that behaving now?

Yes.

> Suspend should likely enable remote wakeup (trevor.pering@intel.com
> has been asking about that), at least as a config option.  That'll
> be useful for things like keyboards and mice.

Okay, but we need normal suspend/resume working first :-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
