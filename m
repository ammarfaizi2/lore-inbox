Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTEMV4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTEMV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:56:44 -0400
Received: from ida.rowland.org ([192.131.102.52]:9220 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263516AbTEMV4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:56:43 -0400
Date: Tue, 13 May 2003 18:09:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Greg KH <greg@kroah.com>, Paul Fulghum <paulkf@microgate.com>,
       Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>
Subject: Re: 2.5.69 Interrupt Latency
In-Reply-To: <20030513214830.GA685@hh.idb.hist.no>
Message-ID: <Pine.LNX.4.44L0.0305131805260.774-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Helge Hafting wrote:

> On Tue, May 13, 2003 at 05:35:47PM -0400, Alan Stern wrote:
> > My take is that wakeup_hc() is getting called whenever some stray signal
> > causes the device to generate an interrupt, and then a little while later
> > the stall timer routine calls suspend_hc() since nothing is active.  The
> > interrupts are probably indistinguishable from what you would get if a new
> > device really had just been attached to the bus.
> >
> Could this also happen if the USB interrupt is shared?
> The other device interrupts, and the kernel calls into
> usb interrupt routine just in case USB has some data too?

Yes, it certainly could.  The other part of the problem, which I failed to
mention, is that the Resume-Detect bit in the USB controller's status
register is set.  wakeup_hc() gets called only if that bit is set, and the
bit is supposed to be set only if some device attached to the USB bus has
requested a wakeup (also known as "resume").  If there's nothing on the
bus, the controller shouldn't indicate that a resume was detected.

Alan Stern

