Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTKQCyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 21:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKQCyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 21:54:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32460
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263292AbTKQCyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 21:54:18 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Patrick's Test9 suspend code.
Date: Sun, 16 Nov 2003 20:38:28 -0600
User-Agent: KMail/1.5
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
References: <200311090404.40327.rob@landley.net> <200311151830.45731.rob@landley.net> <20031116131314.GC199@elf.ucw.cz>
In-Reply-To: <20031116131314.GC199@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311162038.31091.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 November 2003 07:13, Pavel Machek wrote:
> Hi!
>
> > > > This brings us to 2B) Snapshotting is way too opaque.  It sits there
> > > > for 15 seconds sometimes doing inscrutable things, with no progress
> > > > indicator or anything, and then either suspends, panics, or fails and
> > > > fires the desktop back up with no diagnostic message.
> > > >
> > > > On the whole, this is really really cool, and if you have any
> > > > suggestions how I could help, I'm all ears.  (I'm unlikely to poke
> > > > into the code too
> > >
> > > Try "my" swsusp code. It should not fail silently; it may
> > > panic the box but at that point you at least have a message.
> >
> > I've had your swsusp hang, panic, go into a half-suspended state where I
> > have to hold the power button ten seconds to actually power it off and
> > reboot, and fail in a few other ways.  What I've never actually had your
> > code do is successfully suspend something I could resume from.
> >
> > 90% of the time, patrick's code does that for me.  Yours has yet to do so
> > even once for me.
> >
> > I suppose I could give it another shot, though...
>
> Strange, they should be pretty much the same, functionality-wise.

Well, I gave your code another try.  It blanked the screen during the 
"powering down devices" stage so I didn't see what it did after that, but a 
full minute later it had stopped accessing the hard drive for rather a long 
time, but the power was still on (except for the screen), so I switched it 
off.  On reboot, it didn't resume from swap (normal boot with fsck instead) 
but I had to do a mkswap to get my swap file back.

On the other hand, playing around with something else I accidentally overwrote 
my backup .config file with a bad one instead of the other way 'round, and 
I've been redoing it from scratch (and realising how badly horked menuconfig 
is.  (The pc speaker isn't under sound, it's under misc at the end of the 
input core, real obvious place for it...  USB isn't considered a bus, it's 
under the devices menu...  and even though USB has all USB devices under the 
usb menu (including USB ethernet), pcmcia doesn't have all pcmcia devices 
under the pcmcia menu, you have to enable pcmcia and then go into the network 
devices menu where PCMCIA wireless devices are mixed in with non-802.11 
wireless devices from the dawn of time...)

I miss my .config file.

Currently, patrick's code isn't working for me anymore either.  I think it's 
because I haven't figured out how I had ACPI set up last time (performance 
covernor, probably.  If I tell it to use the userspace governor, there's 
still nothing in /sys/devices/system/cpu/cpu0, the directory is empty.  Maybe 
the documentation isn't up to date anymore, I don't know...)  When I tried to 
suspend with it, it sort of worked but the writing to disk phase (which never 
caused a problem before) had a visible pause between each sector written, and 
writing out the 3000 sectors took over 5 minutes, and the end result wasn't 
something it could resume from anyway.  Sigh...

I would appear to have stirred up all the sediment in my configuration, and 
broken both suspend implementations with unrelated pokes to the rest of the 
kernel.  That said, you've replied to me more than once, and although I've 
been posting questions and comments about software suspend for a month now 
(ever since http://lists.insecure.org/lists/linux-kernel/2003/Oct/4175.html), 
and emailed patrick directly at least three times, I've never heard back from 
him.  I have at least heard back from you.

> Here are few tricks... OTOH if it works for you 90% of time, these
> would take a lot of time to test :-(.
>
> If you want to trick swsusp/S3 into working, you might want to try:
>
> * go with minimal config, turn off drivers like USB, AGP you don't
> really need

usb and agp were both compiled in to the kernel that worked (not modular).  It 
never seemed to be dying due to the HARDWARE, it always shut all the hardware 
down just fine...

> * use ext2. At least it has working fsck. [If something seemes to go
>   wrong, force fsck when you have a chance]

I use ext3, which fscks as ext2.  And yes, I force fsck whenver something 
really goes "boing".

> * turn off modules
>
> * use vga text console, shut down X
>
> * try running as few processes as possible, preferably go from single
> use mode

Every single time I've tried your code I've done so from the console of a 
freshly booted system, without ever having run X.

Patrick's code I almost always suspended from X, and it worked....

> When you make it work, try to find out what exactly was it that broke
> suspend, and preferably fix that.

I think what broke patrick's suspend is that I redid the ACPI options, 
possibly some other stuff.  If I have to shut down 2/3 of my system to have a 
chance of making your stuff work, I think I'll go back to thumping on 
patrick's.  Abandoned codebase or not, it still used to work for me the 
majority of the time in X, with my pcmcia wireless network card up and 
running and USB loaded and everything...

> 								Pavel

Rob
