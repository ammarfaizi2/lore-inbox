Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965414AbWJBVen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbWJBVen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965417AbWJBVen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:34:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51724 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965411AbWJBVel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:34:41 -0400
Date: Mon, 2 Oct 2006 17:34:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-arch@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <200610021346.13135.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0610021729490.8219-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, David Brownell wrote:

> > >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> > >      something different depending on whether it's been supplied with a regs
> > >      pointer or not.
> 
> gaak!  where did that come from?  I'll be surprised if removing
> that causes any problem at all.

Here's the statement in question:

	if (likely (regs && HC_IS_RUNNING(ohci_to_hcd(ohci)->state))) {
		...

Notice another questionable use of hcd->state.  I don't know what the 
correct change here is, but I suspect David H's isn't optimal.

Alan Stern

