Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSAXJCL>; Thu, 24 Jan 2002 04:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbSAXJCC>; Thu, 24 Jan 2002 04:02:02 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:37394 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S285829AbSAXJB5>; Thu, 24 Jan 2002 04:01:57 -0500
Date: Thu, 24 Jan 2002 10:01:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Torrey Hoffman <thoffman@arnor.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: depmod problem for 2.5.2-dj4
Message-ID: <20020124100154.A8622@suse.cz>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz> <20020123212435.GB15259@kroah.com> <003701c1a470$86b6bda0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003701c1a470$86b6bda0$6800000a@brownell.org>; from david-b@pacbell.net on Wed, Jan 23, 2002 at 04:46:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 04:46:13PM -0800, David Brownell wrote:
> > > > Vojtech, is this a USB function that you want added to usb.c?
> > > 
> > > Yes, please. This will change later when Pat Mochels devicefs kicks in,
> 
> What's the story on "driverfs" happening, by the way?  Last I knew, the
> PCI bits weren't yet ready.

I'm not absolutely sure about the status of the PCI support, but it
should be close to working. Anyway, the driverfs infrastructure itself
is in place in 2.5, so even if the PCI part wasn't there, still we can
convert USB and Input to it.

> > > but for the time being, it'd be very useful.
> >
> > +int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> 
> I don't think that patch is necessary.  It's simpler to just
> 
>     strncpy (buf, dev->devpath, min_t(size_t, size, sizeof dev->devpath));
> 
> Use like you'd use pci_dev->slot_name ... no mallocation necessary.
> It's just the path from root hub down to device, /2/1/7 and so on:  the
> physical path, which stays the same so long as you don't recable your
> tree of USB devices and hubs.
> 
> I'd expect the typical "driverfs" path for a USB device to be the
> path for the root hub (normally a PCI slot like 00:0f.3) followed by
> what "devpath" now shows.

Ahh, I see. This "devpath" entry wasn't available at the time I wrote
the 'usb_make_path' function. This is of course much better. What's not
very convenient for me right now is that it uses slashes instead of
dots, which the input subsystem uses for delimiting busses from each
other, like:

isa0060/serio0/input0 - AT keyboard
pci0:7.3/usb1:2.2/input0 - USB keboard

Using slashes in place of the dots would make it quite a mess. The
slashes are probably there because of usbdevfs, right?

Note that the PCI "slot_name" doesn't use slashes ...

-- 
Vojtech Pavlik
SuSE Labs
