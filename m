Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVCAIUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVCAIUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCAIRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:17:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:29374 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261413AbVCAIOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:14:17 -0500
Date: Mon, 28 Feb 2005 23:58:32 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, rml@novell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] add driver matching priorities
Message-ID: <20050301075832.GB3890@kroah.com>
References: <1106951404.29709.20.camel@localhost.localdomain> <20050210084113.GZ32727@kroah.com> <1108055918.3423.23.camel@localhost.localdomain> <20050210184508.B5800@flint.arm.linux.org.uk> <1108071423.3423.46.camel@localhost.localdomain> <20050225234107.GE29496@kroah.com> <1109635555.28403.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109635555.28403.117.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 07:05:54PM -0500, Adam Belay wrote:
> On Fri, 2005-02-25 at 15:41 -0800, Greg KH wrote:
> > On Thu, Feb 10, 2005 at 04:37:03PM -0500, Adam Belay wrote:
> > > On Thu, 2005-02-10 at 18:45 +0000, Russell King wrote:
> > > > On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> > > > > > I think the issue that Al raises about drivers grabbing devices, and
> > > > > > then trying to unbind them might be a real problem.
> > > > > 
> > > > > I agree.  Do you think registering every in-kernel driver before probing
> > > > > hardware would solve this problem?
> > > > 
> > > > In which case, consider whether we should be tainting the kernel if
> > > > someone loads a device driver, it binds to a device, and then they
> > > > unload that driver.
> > > > 
> > > > It's precisely the same situation, and precisely the same mechanics
> > > > as what I've suggested should be going on here.  If one scenario is
> > > > inherently buggy, so is the other.
> > > > 
> > > 
> > > I think it would depend on whether the user makes the device busy before
> > > the driver is unloaded.  Different device classes may have different
> > > requirements for when and how a device can be removed.  Are there other
> > > issues as well?  Maybe there are ways to improve driver start and stop
> > > mechanics.
> > 
> > We never fail a device unbind from a driver, so this isn't as big a deal
> > as I originally thought.  Yes, userspace can get messy, but as userspace
> > was the one that loaded the new driver to bind, it's acceptable.
> > 
> > So, care to resubmit your patch?
> > 
> 
> Would you like me to include the portion that adds "*match" to "struct
> device_driver"?  After some more thought, I began considering having
> driver priority be a static quality of a device driver.  The question is
> whether we want a device driver to be able to return a variable priority
> based on bind device.  Also, "*match" could be used to split some
> detection and validation out of "*probe".  What are your reactions to
> this?

Busses really need to be the ones doing this kind of priority logic,
right?  So shouldn't that code be in the individul bus specific driver
structures, not in "struct driver" itself?

> Finally, should every in-kernel driver be registered before devices are
> detected?

That's up to the bus.  Let's leave it as-is for now, and see what falls
apart :)

thanks,

greg k-h
