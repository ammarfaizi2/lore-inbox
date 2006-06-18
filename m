Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWFRXfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFRXfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWFRXfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:35:14 -0400
Received: from mailfe13.tele2.fr ([212.247.155.140]:49609 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750745AbWFRXfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:35:13 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Mon, 19 Jun 2006 01:35:08 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <20060618231204.GB2212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618231204.GB2212@suse.de>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH, le Sun 18 Jun 2006 16:12:04 -0700, a écrit :
> On Mon, Jun 19, 2006 at 01:00:41AM +0200, Samuel Thibault wrote:
> > - With udev, this just cannot work. As explained in an earlier thread,
> >   even using a special filesystem that would report the opening attempt
> >   to udevd wouldn't work fine since udevd takes time for creating the
> >   device, and hence the original program needs to be notified ; this
> >   becomes racy.
> > 
> > So what is the correct way to do it? I can see two approaches:
> 
> You forgot:
>   - use a static /dev if you want this.
> No one is forcing you to use udev :)

I can't choose the preference of the users of my program.

> > Neither solution looks good to me... Just opening /dev/input/uinput
> > should be sufficient, and udev doesn't let that for now.
> 
> No, just do what the distros that use udev do today, load the needed
> modules at boot time, based on the hardware that is present in the
> system.  This should work just fine for the uinput driver,

No hardware correspond to the uinput driver.

> and if not, simply add it to the list of modules that need to be
> loaded every boot (each distro has a different place to put this
> list), and you should be fine.

I can't ask the users of my program to do that either (actually, they
can't even do this, since they need uinput for just being able to type
things on the console...)

> Please realize that the method of loading a module based on the device
> node number is very restrictive, and only works for a small minority of
> drivers.

Agreed. But here, what is best? To explicitely load a "uinput" module or
to explicitely open "/dev/input/uinput" ?

> > The same situation holds for other virtual devices (loop, snd-seq-dummy,
> > ...).
> 
> Yes, look at how the distros do this today for loop, they merely load it
> at boot time and everyone's happy.

So distributions should load every possible virtual device?

In the debian case, it doesn't, but udev has a links.conf script that
creates a /dev/loop/0 entry, which losetup can open when looking for
loop block devices, and hence the loop module gets auto-loaded. This is
the behavior I'd expect.

> And this whole thing has nothing to do with devfs, as you stated above
> :)

Ok, but devfs had let me some hope that it would work, and udev doesn't
so much (the abovementioned links.conf file is considered hacky).

Samuel
