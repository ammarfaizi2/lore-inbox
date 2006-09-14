Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWINWUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWINWUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWINWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:20:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30481 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751353AbWINWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:19:59 -0400
Date: Thu, 14 Sep 2006 18:19:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Mattia Dongili <malattia@linux.it>, Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609142347.16578.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609141809430.6982-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:

> > As I see it, there are two ways to resolve the problem.  The easiest is to
> > rip out the autosuspend stuff from ohci-hcd entirely.  When my generic
> > autosuspend patches are accepted, the HCD-specific stuff won't be needed
> > so much.  This has the disadvantage that the root hub will never get
> > suspended if CONFIG_USB_SUSPEND isn't set.  On the other hand, this is how 
> > ehci_hcd works already.
> 
> This isn't a big deal as far as I'm concerned, but I think that dependancy
> will have to be reflected by some Kconfig rules (eg. if CONFIG_USB_SUSPEND
> gets selected automatically if CONFIG_PM is set).

Ultimately the best thing will be for CONFIG_USB_SUSPEND simply to 
disappear.  That's the long-term goal.  It was never intended to be much 
more than a stop-gap setting, for use while the USB suspend/resume 
routines were under development and not entirely reliable.

> > I don't know if this is feasible with OHCI.  For now, I'll include a patch 
> > that takes the first approach and disables the ohci-hcd autosuspend 
> > entirely.  I think it will solve your problem above.
> 
> Yes it does.
> 
> Now I'm able to suspend/resume several times in a row with both
> ohci and ehci hcds loaded all the time.  Thanks a lot!

You're welcome.

I'll wait to hear Dave's comments before submitting this.

Alan Stern

