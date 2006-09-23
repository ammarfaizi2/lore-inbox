Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWIWWNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWIWWNB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIWWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:13:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42511 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750805AbWIWWNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:13:01 -0400
Date: Sun, 24 Sep 2006 00:12:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923221254.GG5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922230928.GB22830@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:09:28PM -0700, Greg KH wrote:
> On Sat, Sep 23, 2006 at 12:47:35AM +0200, Adrian Bunk wrote:
> > On Fri, Sep 22, 2006 at 03:38:59PM -0700, Greg KH wrote:
> > > On Sat, Sep 23, 2006 at 12:23:00AM +0200, Adrian Bunk wrote:
> > > > Andrew Burri:
> > > >       V4L/DVB: Add support for Kworld ATSC110
> > > > 
> > > > Curt Meyers:
> > > >       V4L/DVB: KWorld ATSC110: implement set_pll_input
> > > >       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
> > > >       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> > > > 
> > > > Giampiero Giancipoli:
> > > >       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> > > > 
> > > > Hartmut Hackmann:
> > > >       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
> > > >       V4L/DVB: Added PCI IDs of 2 LifeView Cards
> > > >       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
> > > >       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
> > > >       V4L/DVB: TDA10046 Driver update
> > > >       V4L/DVB: TDA8290 update
> > > > 
> > > > Peter Hartshorn:
> > > >       V4L/DVB: Added support for the Tevion DVB-T 220RF card
> > > 
> > > Hm, all of these patches seems like these are new features being
> > > backported to the 2.6.16.y kernel, which is not really allowed under the
> > > current -stable rules.
> > > 
> > > Or are these patches just bugfixes that fix with the current -stable
> > > rules?
> > 
> > They add support for additional hardware to the saa7134 driver.
> 
> That's not a bugfix.

See below.

> > If you look at the actual diff there's not much that could cause any 
> > regression since nearly all of these change don't change anything for 
> > the already supported cards.
> 
> I'm not disagreeing about the regression issue.  I'm just concerned
> because you are starting down the slope of "backporting new driver
> support" to the 2.6.16 tree, and that's something that I thought you did
> not want to do.
> 
> But if it is, let us know, and we can discuss it.

I always said that things like adding new PCI IDs are OK for 2.6.16.

> > As long as there's not a serious risk of regressions, such additions are 
> > welcome in 2.6.16.
> 
> Are you sure?  That really goes against the -stable rules as we
> originally set them out to be.
> 
> If you want to accept new drivers and backports like this, I think you
> will find it very hard to determine what to say yes or no to in the
> future.  It's the main problem that everyone who has tried to maintain a
> stable tree has run into, that is why we set up the -stable rules to be
> what they are for that very reason.

My primary priorities are:
- no regressions
- security fixes

If adding support for hardware without a very low regression risk is 
possible (bugfixes usually have a much higher risk), I don't see the 
point against doing it.

If adding support for hardware would have a regression risk I'll always 
say no - no matter how important the hardware is (I'd expect this e.g. 
in the near future for SATA).

I do know that the only value of the 2.6.16 tree lies in a lack of 
regressions and act accordingly, and as soon as people will report 
regressions compared to earlier 2.6.16 kernels I'll know that I'll have 
done something wrong (but I haven't yet gotten such bug reports).

> > "is not really allowed under the current -stable rules" is a bit hard to 
> > answer, but considering that "Missing PCI id update for VIA IDE" was OK 
> > for 2.6.17.12 I'd say it's consistent with what you are doing.
> 
> That was a bugfix as the driver could not access that device without
> that fix.  Just adding a device id is not something that we normally
> will take, as that is what the sysfs "newid" is for.  That patch was
> obviously something else.

I read the changelog differently.

Anyway, I'm not really seeing any non-academical difference between "as 
the driver could not access that device without that fix" and "adding 
support for a device to a driver" - it's all about a device that tdidn't 
work before and does work after the patch.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

