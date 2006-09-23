Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIWXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIWXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIWXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:21:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2064 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750905AbWIWXV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 19:21:56 -0400
Date: Sun, 24 Sep 2006 01:21:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923232150.GK5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923045610.GM541@1wt.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 06:56:10AM +0200, Willy Tarreau wrote:
> Hi Greg, Hi Adrian,
> 
> On Fri, Sep 22, 2006 at 04:09:28PM -0700, Greg KH wrote:
> 
> > If you want to accept new drivers and backports like this, I think you
> > will find it very hard to determine what to say yes or no to in the
> > future.  It's the main problem that everyone who has tried to maintain a
> > stable tree has run into, that is why we set up the -stable rules to be
> > what they are for that very reason.
> 
> When I started the 2.4-hotfix tree nearly two years ago, I wanted to
> avoid merging drivers changes as much as possible. And particularly,
> I avoided to add support for new hardware. The reason is very simple.
> I want to be able to guarantee that if 2.4.X works, then any 2.4.X.Y
> does too so that they can blindly upgrade.

Bugfixes causing regressions are much more likely than new hardware 
support adding regressions.

> And if, for any reason,
> people suspect that 2.4.X.Y might have brought a bug, then reverting
> to 2.4.X.Z(Z<Y) should at most bring back older bugs but not remove
> previous support for any hardware.

Either you want to use the newly supported hardware or you don't want to 
use it.

In any case, I don't see your point.

> The problem with new hardware
> support is that it can break sensible setups :
> 
>   - adding a new network card support will cause existing cards to be
>     renumberred (it happened to me on several production systems when
>     switching from 2.2 to 2.4)
> 
>   - adding support for a new IDE controller can cause hda to become
>     hdc, or worse, hda to become sda (problems encountered when adding
>     libata support)

I don't consider merging any patches that could cause the sda problem.

People not using the onboard IDE controller but a different controller, 
but OTOH having the driver for their onboard controller enabled in their 
kernel really sounds like a strange case.

>   - enabling some devices might lock up memory and/or I/O address ranges
>     on a bus leading to other devices not working anymore. I had this
>     problem when using dlink 580 quad port nics in some buggy machines
>     already equipped with adaptec starfire nics.
> 
>   - other core devices might cause system instability without the
>     admin being aware they're really used (eg: ACPI, ...)
> 
> Since hardware diversity is so high that nobody can know everything, I
> think it's better to avoid playing alone with people's hardware, but I
> agree it's sometimes very hard to resist.
> 
> Adrian, when you have a doubt whether such a fix should go into next
> release, simply tell people about the problem and ask them to test
> current driver. If nobody encounters the problem, you can safely keep
> the patch in your fridge until someone complains. By that time, the
> risks associated with this patch will be better known.

It's not that I wanted to upgrade ACPI to the latest version.

And my rules are:
- patch must be in Linus' tree
- I'm asking the patch authors and maintainers of the affected subsystem
  whether the patch is OK for 2.6.16

> > > "is not really allowed under the current -stable rules" is a bit hard to 
> > > answer, but considering that "Missing PCI id update for VIA IDE" was OK 
> > > for 2.6.17.12 I'd say it's consistent with what you are doing.
> > 
> > That was a bugfix as the driver could not access that device without
> > that fix.
> 
> Even this might be dangerous in late -stable releases, unless it was a
> recent regression.

It was a case that never worked before.

> Just my 2 cents,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

