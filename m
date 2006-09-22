Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWIVXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWIVXJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWIVXJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:09:41 -0400
Received: from ns.suse.de ([195.135.220.2]:53453 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964903AbWIVXJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:09:40 -0400
Date: Fri, 22 Sep 2006 16:09:28 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060922230928.GB22830@kroah.com>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922224735.GB5566@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 12:47:35AM +0200, Adrian Bunk wrote:
> On Fri, Sep 22, 2006 at 03:38:59PM -0700, Greg KH wrote:
> > On Sat, Sep 23, 2006 at 12:23:00AM +0200, Adrian Bunk wrote:
> > > Andrew Burri:
> > >       V4L/DVB: Add support for Kworld ATSC110
> > > 
> > > Curt Meyers:
> > >       V4L/DVB: KWorld ATSC110: implement set_pll_input
> > >       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
> > >       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> > > 
> > > Giampiero Giancipoli:
> > >       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> > > 
> > > Hartmut Hackmann:
> > >       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
> > >       V4L/DVB: Added PCI IDs of 2 LifeView Cards
> > >       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
> > >       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
> > >       V4L/DVB: TDA10046 Driver update
> > >       V4L/DVB: TDA8290 update
> > > 
> > > Peter Hartshorn:
> > >       V4L/DVB: Added support for the Tevion DVB-T 220RF card
> > 
> > Hm, all of these patches seems like these are new features being
> > backported to the 2.6.16.y kernel, which is not really allowed under the
> > current -stable rules.
> > 
> > Or are these patches just bugfixes that fix with the current -stable
> > rules?
> 
> They add support for additional hardware to the saa7134 driver.

That's not a bugfix.

> If you look at the actual diff there's not much that could cause any 
> regression since nearly all of these change don't change anything for 
> the already supported cards.

I'm not disagreeing about the regression issue.  I'm just concerned
because you are starting down the slope of "backporting new driver
support" to the 2.6.16 tree, and that's something that I thought you did
not want to do.

But if it is, let us know, and we can discuss it.

> As long as there's not a serious risk of regressions, such additions are 
> welcome in 2.6.16.

Are you sure?  That really goes against the -stable rules as we
originally set them out to be.

If you want to accept new drivers and backports like this, I think you
will find it very hard to determine what to say yes or no to in the
future.  It's the main problem that everyone who has tried to maintain a
stable tree has run into, that is why we set up the -stable rules to be
what they are for that very reason.

> "is not really allowed under the current -stable rules" is a bit hard to 
> answer, but considering that "Missing PCI id update for VIA IDE" was OK 
> for 2.6.17.12 I'd say it's consistent with what you are doing.

That was a bugfix as the driver could not access that device without
that fix.  Just adding a device id is not something that we normally
will take, as that is what the sysfs "newid" is for.  That patch was
obviously something else.

thanks,

greg k-h
