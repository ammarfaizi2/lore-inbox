Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWHaVjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHaVjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWHaVjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:39:55 -0400
Received: from mail.suse.de ([195.135.220.2]:54693 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932338AbWHaVjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:39:54 -0400
Date: Thu, 31 Aug 2006 14:39:35 -0700
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Xavier Bestel <xavier.bestel@free.fr>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060831213935.GA11939@kroah.com>
References: <20060830062338.GA10285@kroah.com> <1157013027.7566.515.camel@capoeira> <1157056749.4386.137.camel@mindpipe> <44F74C66.7000705@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F74C66.7000705@nortel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 02:53:58PM -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> >Why?  There's no technical or legal requirement for userspace drivers to
> >be GPLed.
> 
> I could see a benefit to tainting the kernel once userspace starts 
> poking at the hardware directly.  That way at least we'd know that a 
> crash might be due to userspace doing bad things.
> 
> For instance, consider the case where userspace misprograms a DMA 
> engine, which starts overwriting random kernel memory.

Then you get to keep the two pieces that the kernel just broke into.

We can't "taint" anything here.  Userspace is doing these kinds of
things already today.  You can mmap a PCI device and plug away at all
sorts of fun things with it right now.  You can to /dev/mem fun tricks,
and all sorts of other 'evil' things.

And us kernel developers don't really care.

What this framework does, is give users who already do this kind of
userspace driver thing today, a sane interface in which to do it.  One
that is simple and fast, and makes sense, unlike almost every other
proposal like this that I have seen in the past.

We are trying to help people out here.  Pushing drivers to userspace is
a good thing from a kernel's perspective, if they work well for the
driver in question.  USB has been doing this for years quite well.  This
just allows the PCI interrupt to be sanely handled so PCI and other
types of devices like it, can also work in a well defined way.

If a author of a driver doesn't want to put it in the kernel for
whatever reason, that's fine, do it in userspace.  Not all types of
drivers make sense in the kernel as they don't need any of the things
kernelspace is good for (speed, caching, common userspace interfaces,
etc.)

So there is nothing to worry about here, except for more Linux based,
laser welding robots taking over your neighborhood manufacturing plant.

And to answer the question that everyones been asking me in private, no,
I have no idea if nVidia or ATI can use this interface to move their
kerneldrivers out into userspace.  I've never seen that code and do not
know what their requirements are, nor do I care.  Go ask them, they know
this kind of thing, I sure don't.  And if they can move them there,
bully for them.

I don't know why people have this morbid fascination with these two,
monstrously horrible closed source drivers.  There are way more much
more insidious and common closed source Linux kernel modules out there
right now that everyone in the press seems to be ignoring.  Those are
the ones that I worry about...

And those are the ones that this interface might just help out with, and
if that happens, it is a very good thing for Linux overall.

thanks,

greg k-h
