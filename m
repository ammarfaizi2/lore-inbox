Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbSLEX6p>; Thu, 5 Dec 2002 18:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLEX6p>; Thu, 5 Dec 2002 18:58:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57094 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267447AbSLEX6n>; Thu, 5 Dec 2002 18:58:43 -0500
Date: Fri, 6 Dec 2002 01:06:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Doesn't that imply your fix is broken to begin with?
> > 
> > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > overdesign to me, OTOH if you do the work it is okay with me.
> 
> You broke the design. S3 support was developed long before swsusp was in 
> the kernel, and completely indpendent of it. It should have remained that 
> way. 
> 
> S3 support is a subset of what is need for S4 support. 

That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
but not for S4. Big part of driver support is only needed for S3.

> swsusp is an implementation of S4 support. In theory, there could be 
> multiple implementations that all use the same core (saving/restoring 
> state). 

There were patches for S4bios floating around, but it never really
worked, IIRC.

> There could also be different power management schemes that use swsusp as 
> an implementation for suspend-to-disk. But, that's another tangent. 
> 
> CONFIG_ACPI_SLEEP should give you S3 support, and the ACPI side of S4 
> support. 

What's ACPI side of S4 good for when you can not do S4?

> The comment in the config option should tell the user that they 
> must choose a suspend implementation (e.g. CONFIG_SUSPEND, which should 
> prolly be CONFIG_SWAP_SUSPEND) in order to get complete S4 support. (The 
> ACPI side can make an empty call to swsusp if no implementation is 
> selected). 

S3 needs process stopper from kernel/suspend.c. I did not want to have
#ifdefs all over suspend.c...

> Some time ago, I made a BK repo for suspend support. I axed it, since no 
> one ever used it. But, it's back again, and I'll be integrating your 
> patches and try to dedicate a few extra cycles to resolving some of the 
> issues. I'll send an announcement to the list once I've integrated your 
> patches. 

I probably will not persuade you to make it CVS, right? [Sorry, I'm
not going to touch bitkeeper.]
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
