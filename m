Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270449AbTGZPsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272555AbTGZPsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:48:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60682 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S270449AbTGZPrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:47:21 -0400
Date: Sat, 26 Jul 2003 12:02:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dominik Brugger <ml.dominik83@gmx.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
In-Reply-To: <3F21B3BF.1030104@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0307261157080.29083-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, David Brownell wrote:

> Benjamin Herrenschmidt wrote, responding to Alan Stern:
> >>I think the hub driver's power management code may be at fault.  It needs
> >>to cancel the status interrupt URB when suspending and resubmit it when
> >>waking up; right now it probably does neither one.
> >>
> >>Or maybe I'm wrong about that.  Perhaps it's okay to leave the URB active.  
> >>If that's the case, then the root hub power management code needs to be 
> >>changed to restart the status URB timer after a wakeup.
> 
> I thought that patch got merged already ...
> 
> 
> >>I'm not sure how the design is intended to work, but either way something 
> >>needs to be fixed.
> 
> Yes, it seems like all the HCDs (and the hub driver) need attention.

So far as I can see, there's no USB power management code at all apart 
from the HC drivers.  That includes the hub driver.

And I know that the UHCI suspend routine could use a little work.  There's 
a 10-Hz polling timer that it doesn't turn off.

Alan Stern

