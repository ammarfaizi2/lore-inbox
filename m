Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317051AbSFFS2O>; Thu, 6 Jun 2002 14:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFFS1u>; Thu, 6 Jun 2002 14:27:50 -0400
Received: from [195.39.17.254] ([195.39.17.254]:41376 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317049AbSFFS1a>;
	Thu, 6 Jun 2002 14:27:30 -0400
Date: Sun, 2 Jun 2002 06:39:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel deadlock using nbd over acenic driver
Message-ID: <20020602063948.A219@toy.ucw.cz>
In-Reply-To: <200206012113.g51LDur14462@oboe.it.uc3m.es> <200206050848.JAA16896@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (somethiung about kernel nbd)
> > 
> > BTW, are you maintaining kernel nbd? If so, I'd like to propose
> > some unifications that would make it possible to run either
> > enbd or nbd daemons on the same driver, at least in a "compatibility
> > mode".
> > 
> No. My interest is just to help ensure that its working by sending
> the occasional bug fix. Pavel Machek is officially in charge, so you'll
> need to convince him of any changes.

...and thanx a lot for your work...

> > The starting point would be
> > 
> > 1) make the over-the-wire data formats the same, which means
> >    enlarging kernel nbd's nbd_request and nbd_reply structs
> >    to match enbd's, or some compromise.
> > 
> > 2) less important .. make the driver structs the same. enbd has more
> >    fields there too, for accounting purposes. That's the nbd_device struct.
> > 
> > Later on one can add some cross-ioctls.
> > 
> I'm not so convinced that this is a good idea. I've always looked upon nbd
> as the "as simple as possible" style of driver and its over the wire format
> is good enough to cope with most things I think. Does enbd have a negotiation
> sequence at start up like nbd ? Perhaps it would be possible to add some
> code so a server could tell which type of client it was talking to ? I
> think that would be simpler code changes and I'd be happier to see that kind
> of change rather than any change to the over the wire format.

Agreed. If you want to integrate enbd, go ahead, and put it into 
drivers/block/enbd.c.

> It would be nice to add a bit more accounting. We need also to dynamically
> allocate the nbd driver structures because as they get larger its less
> efficient to allocate them statically as we currently do. The question is
> then when to free them. I think that probably the disconnect ioctl() could
> provide a suitable hook for that,

Disconnect is actually a bit of problem, and yes it would be nice to get it
solved.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

