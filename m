Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWIWUtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWIWUtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIWUtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:49:09 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:13843 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964896AbWIWUtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:49:06 -0400
Date: Sat, 23 Sep 2006 22:49:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-Id: <20060923224909.69579243.khali@linux-fr.org>
In-Reply-To: <20060922230928.GB22830@kroah.com>
References: <20060922222300.GA5566@stusta.de>
	<20060922223859.GB21772@kroah.com>
	<20060922224735.GB5566@stusta.de>
	<20060922230928.GB22830@kroah.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, Greg,

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
> 
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

I second Greg's objection, and share his worries. "No possible
regression" is something extremely hard to evaluate in general.
Besides, the goal of -stable as I remember it is not "no regression"
but rather "only bugfixes", i.e. patches don't go in without a good
reason (default policy = reject), rather than patches are rejected if
they may cause problem (default policy = accept.)

Adding support for new devices, even if it's only adding an ID in a
list, is not always safe. I am not happy about new IDs being considered
as OK for late RCs, I am even less so for -stable.

The sole fact that Adrian felt the need to release a -pre1 for
2.6.16.30 betrays his lack of confidence IMHO. And the size of
ChangeLog-2.6.16.29 speaks for itself.

Given that 2.6.16.y follows the naming convention of -stable and is
released in the official v2.6 directory on ftp.kernel.org, I'd like to
see it follow the same rules we have for "real" -stable trees. Adrian,
if you are going to diverge from the original intent of -stable, this
is your own right, but then please change the name of your tree to
2.6.16-ab or something similar, to clear the confusion.

I will not use 2.6.16.y with its current rules, for sure, and I doubt
any distribution will. Wasn't the whole point of 2.6.16.y to serve as a
common base between several distributions?

Thanks,
-- 
Jean Delvare
