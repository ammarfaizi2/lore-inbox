Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288411AbSAXP3m>; Thu, 24 Jan 2002 10:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSAXP3c>; Thu, 24 Jan 2002 10:29:32 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:28295 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S286188AbSAXP3O>; Thu, 24 Jan 2002 10:29:14 -0500
Date: Thu, 24 Jan 2002 07:27:41 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: usb+driverfs [was depmod problem for
 2.5.2-dj4]
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Torrey Hoffman <thoffman@arnor.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Message-id: <00bd01c1a4eb$aac399e0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net>
 <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz>
 <20020123212435.GB15259@kroah.com>
 <003701c1a470$86b6bda0$6800000a@brownell.org> <20020124100154.A8622@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth "Vojtech Pavlik" <vojtech@suse.cz>:
> On Wed, Jan 23, 2002 at 04:46:13PM -0800, David Brownell wrote:
> > What's the story on "driverfs" happening, by the way?  Last I knew, the
> > PCI bits weren't yet ready.
> 
> I'm not absolutely sure about the status of the PCI support, but it
> should be close to working. Anyway, the driverfs infrastructure itself
> is in place in 2.5, so even if the PCI part wasn't there, still we can
> convert USB and Input to it.

Since all the USB HCDs use PCI, I think the 2.5.3-pre4 updates
(well timed :) are necessary to convert USB:  HCDs first, then the
hub driver, then input.   Or at least, that's how I understand things
right now -- I was waiting for a "finished" example to read! :)


> >     strncpy (buf, dev->devpath, min_t(size_t, size, sizeof dev->devpath));
> > 
> > Use like you'd use pci_dev->slot_name ... no mallocation necessary.
> > It's just the path from root hub down to device, /2/1/7 and so on:  the
> > physical path, which stays the same so long as you don't recable your
> > tree of USB devices and hubs.
> > 
> > I'd expect the typical "driverfs" path for a USB device to be the
> > path for the root hub (normally a PCI slot like 00:0f.3) followed by
> > what "devpath" now shows.
> 
> Ahh, I see. This "devpath" entry wasn't available at the time I wrote
> the 'usb_make_path' function. This is of course much better. What's not
> very convenient for me right now is that it uses slashes instead of
> dots, which the input subsystem uses for delimiting busses from each
> other, like:
> 
> isa0060/serio0/input0 - AT keyboard
> pci0:7.3/usb1:2.2/input0 - USB keboard
> 
> Using slashes in place of the dots would make it quite a mess. The
> slashes are probably there because of usbdevfs, right?

Driverfs -- since the hubs are part of the device hierarchy,
which shows up in the filesystem.  Also that's what the code
it replaced did (in the hub driver).  Maybe it should change
to use driverfs directly... :)

- Dave


> Note that the PCI "slot_name" doesn't use slashes ...
> 
> -- 
> Vojtech Pavlik
> SuSE Labs

