Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWH3R4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWH3R4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWH3R4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:56:52 -0400
Received: from mail.suse.de ([195.135.220.2]:26003 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbWH3R4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:56:51 -0400
Date: Wed, 30 Aug 2006 10:55:29 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060830175529.GB6258@kroah.com>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830143410.GB19477@gate.crashing.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 09:34:10AM -0500, Matt Porter wrote:
> On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
> > A while ago, Thomas and I were sitting in the back of a conference
> > presentation where the presenter was trying to describe what they did in
> > order to add the ability to write a userspace PCI driver.  As was usual
> > in a presentation like this, the presenter totaly ignored the real-world
> > needs for such a framework, and only got it up and working on a single
> > type of embedded system.  But the charts and graphs were quite pretty :)
> > 
> > Thomas and I lamented that we were getting tired of seeing stuff like
> > this, and it was about time that we added the proper code to the kernel
> > to provide everything that would be needed in order to write PCI drivers
> > in userspace in a sane manner.  Really all that is needed is a way to
> > handle the interrupt, everything else can already be done in userspace
> > (look at X for an example of this...)
> 
> What about portable access to the PCI DMA API from userspace?

It currently does not provide this, but if you know how your card works,
I'm pretty sure you can get this working without such an interface.

If you wish to add this functionality, to make it easier, that would be
great.

> > Thomas mentioned that he had code to do all of this working in some
> > customer sites already and that he would get it to me.
> > 
> > Fast forward to OLS of this year, and I bugged Thomas to send me the
> > code.  He did, and then I sat on it for a while longer...
> > 
> > So, here's the code.  I think it does a bit too much all at once, but it
> > is an example of how this can be done.  This is working today in some
> > industrial environments, successfully handling hardware controls of very
> > large and scary machines.  So it is possible to use this interface to
> > successfully build your own laser wielding robot, all from userspace,
> > allowing you to keep your special-secret-how-to-control-the-laser
> > algorithm closed source if you so desire.
> > 
> > In looking at the proposed kevent interface, I think a few things in
> > this proposed interface can be dropped in favor of using kevents
> > instead, but I haven't looked at the latest version of that code to make
> > sure of this.
> > 
> > And the name is a bit ackward, anyone have a better suggestion?
> 
> Well, if it's focused on industrial controls like it appears from
> the code here then the name is fine. If it's a starting point to
> become someting more generic then User Space Driver (USD) subsystem
> might be nice.
> 
> A more generic system would go a long way to get rid of the dubious
> secret-sauce binary kernel modules that are popular in embedded
> linux projects. 

It's not focused on industrial controls at all, that just happens to be
the name of it right now, as that is why it was written.  It is much
more generic than that.

"USD" is a bit too close to "USB" for a name.  Any other ideas?

> > Thomas has also promised to come up with some userspace code that uses
> > this interface to show how to use it, but seems to have forgotten.
> > Consider this a reminder :)
> 
> That would be nice to see. I can't see how devices and drivers
> are registered from user space with what's here. I see
> iio_register_device() exported but no clue how userspace tells
> the kernel to claim a device or register an iio driver.

His posted example should show you how this all works together.

thanks,

greg k-h
