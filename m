Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbSLFAX1>; Thu, 5 Dec 2002 19:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbSLFAX1>; Thu, 5 Dec 2002 19:23:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57607 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267443AbSLFAX0>; Thu, 5 Dec 2002 19:23:26 -0500
Date: Fri, 6 Dec 2002 01:31:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021206003101.GC15784@atrey.karlin.mff.cuni.cz>
References: <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051752060.974-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212051752060.974-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > S3 support is a subset of what is need for S4 support. 
> > 
> > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > but not for S4. Big part of driver support is only needed for S3.
> 
> Ok, acpi_wakeup.S is only for S3.
> 
> As for drivers, I'm dubious of swsusp's handling of device and driver
> support. A suspend cycle is supposed to leave devices in the same state

Some devices do not really have a state (timer -- it needs to be set
to 1kHz, but that's it), and they do not need support for S4 but need
it for S3.

> > > The comment in the config option should tell the user that they 
> > > must choose a suspend implementation (e.g. CONFIG_SUSPEND, which should 
> > > prolly be CONFIG_SWAP_SUSPEND) in order to get complete S4 support. (The 
> > > ACPI side can make an empty call to swsusp if no implementation is 
> > > selected). 
> > 
> > S3 needs process stopper from kernel/suspend.c. I did not want to have
> > #ifdefs all over suspend.c...
> 
> Then break it up into separate files in a separate directory.

Uff, having kernel/suspend/freezer.c and kernel/suspend/disk.c would
seem very ugly to me, and freezer is pretty short in fact... I do not
think we want separate directory for suspend.

> > > Some time ago, I made a BK repo for suspend support. I axed it, since no 
> > > one ever used it. But, it's back again, and I'll be integrating your 
> > > patches and try to dedicate a few extra cycles to resolving some of the 
> > > issues. I'll send an announcement to the list once I've integrated your 
> > > patches. 
> > 
> > I probably will not persuade you to make it CVS, right? [Sorry, I'm
> > not going to touch bitkeeper.]
> 
> I know, and that's fine. I won't touch CVS again, unless there's a hefty 
> sum and a lot of good beer involved. (Or, after I've consumed a lot of 
> good beer). Patches can be made from the repo, most easily after merging 
> to a new kernel version.

:-) there should be some good beer around here ;-).

I'd like to keep it simple for now. I feel alone developing sleep on
2.5, and it is easier for me not to ave to test different
configurations. So I think ACPI_SLEEP requiring SOFTWARE_SUSPEND is
okay for now (code bloat is not too bad). If you are joining and will
work on ACPI_SLEEP && !SOFTWARE_SUSPEND, you can easily catch
non-compilations and similar mistakes, and it will be okay to separate
the two.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
