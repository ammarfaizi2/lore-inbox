Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUAEEie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbUAEEie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:38:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263850AbUAEEib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:38:31 -0500
Date: Mon, 5 Jan 2004 04:38:30 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
References: <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:02:20PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 5 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > What is _not_ OK, though, is to have folks suddenly see /dev/hda3 changing
> > its device number - then we would break existing setups that worked all
> > along; even if admin can fix the breakage, it's not a good thing to do.
> 
> Ehh, it will actually happen.
> 
> If nothing else, things like SATA will end up meaning that the device you 
> were used to seeign as /dev/hdc will suddenly show up as /dev/scd0 
> instead. Just because you changed the cabling while you upgraded to a 
> newer version of your CD-ROM drive.

If I open the damn box, I sure as hell can be bothered to edit stuff in
/etc...

> And the thing is, with fs labels and udev, even "existing systems" really
> shouldn't much care.
> 
> Now, we'd probably not want to force the switch, but I do suspect we'll 
> have exactly this as a switch in the "Kernel Debugging Config" section. 
> Where even _common_ things like disks could end up with per-bootup values. 
> Just to verify that every part of the system ends up having it right.

Then we'd better have a very good idea of the things that are going to
break.  Note that right now even late-boot code in kernel itself will
break on that - there are explicit checks for ROOT_DEV==MKDEV(2,0),
all sorts of weird crap deep in the bowels of arch/ppc/*/*, etc.

It won't be an easy transition - I know that Greg is very optimistic
about it, but there will be a *lot* of crap to take care of.  In theory
getting bigger dev_t should've been very straightforward, but if you
check what really had been involved...

ObOtherStraightforwardThings: net_device refcounting.  Take a look at
Jeff's queue someday - by now it's one big merge short of getting it
right for practically all drivers.  1.9Mb total + 247Kb pending patches
here.  Several hundreds changesets, practically all of them fixing
exploitable holes.  And yes, most of them had been bugs all along -
since 2.2 if not earlier.  Sure, that made things better, but if somebody
comes along and makes similar "fun" necessary for e.g. ALSA...

> because "pine" still doesn't get UTF-8 right, and nobody is apparently
> ever going to fix it. Oh, well. But at least I know I'm doing something
> _wrong_, which in itself is a good thing.).

Heh.  Took you long enough - "using pine" should've been a dead giveaway
from the very beginning ;-)
