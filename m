Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbSLFAQA>; Thu, 5 Dec 2002 19:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbSLFAQA>; Thu, 5 Dec 2002 19:16:00 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267473AbSLFAP7>;
	Thu, 5 Dec 2002 19:15:59 -0500
Date: Thu, 5 Dec 2002 18:05:57 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0212051752060.974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > S3 support is a subset of what is need for S4 support. 
> 
> That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> but not for S4. Big part of driver support is only needed for S3.

Ok, acpi_wakeup.S is only for S3.

As for drivers, I'm dubious of swsusp's handling of device and driver
support. A suspend cycle is supposed to leave devices in the same state
they were in before the cycle.  So, you need suspend and resume hooks in
the drivers, even for S4 support, to capture and restore context in the
devices themselves. Then again, I've no proof that swsusp doesn't get 
everything right as is.

> > CONFIG_ACPI_SLEEP should give you S3 support, and the ACPI side of S4 
> > support. 
> 
> What's ACPI side of S4 good for when you can not do S4?

To not litter the code with #ifdefs. 

> > The comment in the config option should tell the user that they 
> > must choose a suspend implementation (e.g. CONFIG_SUSPEND, which should 
> > prolly be CONFIG_SWAP_SUSPEND) in order to get complete S4 support. (The 
> > ACPI side can make an empty call to swsusp if no implementation is 
> > selected). 
> 
> S3 needs process stopper from kernel/suspend.c. I did not want to have
> #ifdefs all over suspend.c...

Then break it up into separate files in a separate directory.

> > Some time ago, I made a BK repo for suspend support. I axed it, since no 
> > one ever used it. But, it's back again, and I'll be integrating your 
> > patches and try to dedicate a few extra cycles to resolving some of the 
> > issues. I'll send an announcement to the list once I've integrated your 
> > patches. 
> 
> I probably will not persuade you to make it CVS, right? [Sorry, I'm
> not going to touch bitkeeper.]

I know, and that's fine. I won't touch CVS again, unless there's a hefty 
sum and a lot of good beer involved. (Or, after I've consumed a lot of 
good beer). Patches can be made from the repo, most easily after merging 
to a new kernel version.

	-pat

