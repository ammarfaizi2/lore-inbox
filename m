Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWJ3UGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWJ3UGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWJ3UG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:06:26 -0500
Received: from ms-smtp-02.ohiordc.rr.com ([65.24.5.136]:28625 "EHLO
	ms-smtp-02.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S1161438AbWJ3UGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:06:09 -0500
Date: Mon, 30 Oct 2006 15:05:16 -0500
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Joseph Fannin <jhf@columbus.rr.com>, Greg Kroah-Hartman <greg@kroah.com>,
       Oliver Neukum <oliver@neukum.name>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Fwd: Re: [linux-usb-devel] usb initialization order	(usbhid	vs. appletouch)
Message-ID: <20061030200516.GA26137@nineveh.rivenstone.net>
Mail-Followup-To: Soeren Sonnenburg <kernel@nn7.de>,
	Joseph Fannin <jhf@columbus.rr.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Oliver Neukum <oliver@neukum.name>, Sergey Vlasov <vsu@altlinux.ru>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org> <200610282055.29423.oliver@neukum.name> <1162067266.4044.2.camel@localhost> <20061030101202.GB9265@nineveh.rivenstone.net> <1162212211.3512.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162212211.3512.2.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 01:43:31PM +0100, Soeren Sonnenburg wrote:
> On Mon, 2006-10-30 at 05:12 -0500, Joseph Fannin wrote:
> > On Sat, Oct 28, 2006 at 10:27:46PM +0200, Soeren Sonnenburg wrote:
> > > On Sat, 2006-10-28 at 20:55 +0200, Oliver Neukum wrote:
> > > > > From: Sergey Vlasov <vsu@altlinux.ru>
> > > > > Subject: usbhid: Add HID_QUIRK_IGNORE_MOUSE flag
> > > > >
> > > > > Some HID devices by Apple have both keyboard and mouse interfaces; the
> > > > > keyboard interface is handled by usbhid, but the mouse (really
> > > > > touchpad) interface must be handled by the separate 'appletouch'
> > > > > driver.  Using HID_QUIRK_IGNORE will make hiddev ignore both
> > > > > interfaces, therefore a new quirk flag to ignore only the mouse
> > > > > interface is required.
> >
> >     The appletouch driver doesn't work properly on the MacBook
> > (non-Pro).  It claims the device, and sort of functions, but is
> > basically unusable.
> >
> >     If this goes in, and blacklists the MacBook touchpad too, Macbook
> > users will be unhappy.  I think the MacBook and the -Pro use the same
> > IDs, though, which makes a problem for this patch until appletouch is
> > fixed on MacBooks.
>
> Can you please be a bit more specific on this ? Other sites mention it
> works http://bbbart.ulyssis.be/gentoomacbook/ ... what are you missing ?
> Sensitivity and such can all be tweaked in xorg.conf ...

    That's the first I've heard of it working on a vanilla MacBook.
I'm glad.  I've only heard of failures before, some by people way
smarter than me.

    I wish I could whip out my 'Book and try it again, but it's away
for service.  But here's what I do know:

    Enabling the "dbg" parameter of the module produced output only
once, when I switched VTs to X and back quickly. The one
time it did work, it dumped so much info to syslog it for all
practical purposes locked the machine up, so I didn't learn much.

    Printk's I added to the code that initializes absolute mode for
geiser3 did get printed, though.

    I couldn't get debug events out of the driver in any other
situation, and I couldn't reproduce it.

    The touchpad doesn't respond to any of the xorg.conf knobs, and
synclient doesn't detect any device.  Yes, shm or whatever was
enabled.  (I've had a real synaptics pad working before, for what
that's worth.)

    Without the ability to tweak the settings, the tap-to-click
sensitivity was way too high, even for people who like that sort of
thing, and the pointer speed lower than that of the hid driver, even
with the GNOME mouse speed stuff turned all the way up.

    All my attempts to enable side-scrolling and so on also failed.

    Taken with all the other stuff, it seemed to be that the MacBook
touchpad was getting reset and so dropped out of absolute mode just as
soon as the driver enabled it.  The one time it actually produced
absolute events, it was because the geiser3 init code won the race
with whatever was resetting it, due to the quick switch to X and back
to vgacon.  It was at this point that I decided I was in *way* over my
head.

    Maybe it's a misconfiguration, or HAL doing something dumb to the
mouse device, and Gentoo dude didn't have HAL installed.  Anyway, it
looks like *someone* got it working.  But lots of people have failed,
and they're going to be unhappy when they upgrade their kernel and
their trackpad starts behaving badly.

--
Joseph Fannin
jhf@columbus.rr.com
