Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTBTVJi>; Thu, 20 Feb 2003 16:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBTVJi>; Thu, 20 Feb 2003 16:09:38 -0500
Received: from unthought.net ([212.97.129.24]:14226 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S265725AbTBTVJh>;
	Thu, 20 Feb 2003 16:09:37 -0500
Date: Thu, 20 Feb 2003 22:19:42 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030220211941.GD13216@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Rusty Lynch <rusty@linux.co.intel.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
	lkml <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Daniel Pittman <daniel@rimspace.net>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz> <1045260726.1854.7.camel@irongate.swansea.linux.org.uk> <20030214213542.GH23589@atrey.karlin.mff.cuni.cz> <1045264651.13488.40.camel@vmhack> <1045274042.2961.4.camel@irongate.swansea.linux.org.uk> <1045632256.2974.76.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1045632256.2974.76.camel@vmhack>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:24:15PM -0800, Rusty Lynch wrote:
> My original proposal raised a couple of issues with sysfs that make it
> difficult to move completely from the current watchdog model documented in 
> watchdog-api to a completely sysfs based implementation.
> 
> Specifically, sysfs needs:
> * persistent file permissions
> * a way to forward ioctl's or in some way represent a device node in sysfs

Something as simple as a watchdog should not need ioctls, IMO.  (Nothing
should need them, but let's take one battle at a time...)

How about using sysfs and specifically - now that we have a collection
of drivers which are simple enough to not need the mistake that ioctls
are - making sure that they work as before, using only device files and
no magic ioctls ?

I shall happily volunteer to delete the 10 lines of code from
sbc60xxwdt.c to make it compliant to the "no ioctls - equivalent
functionality" idea  ;)

I know that there is ioctl support in the existing drivers - but I have
not yet seen a driver which needed it.   "needed" in the sense that
equivalent functionality could not have been created using dev files
alone.

Also, the amount of userspace which will break because of missing ioctl
functionality will be absolutely *minimal*.  There's not a lot of
watchdog software out there, and porting whatever software uses ioctls
to use sane interfaces instead, should be doable.  I don't think anyone
would get terribly upset if this change was made as a 2.4->2.6
transition thing.

If ioctls are kept in watchdog drivers for 2.6, they can't go away until
2.8/3.0/whatever.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
