Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSAXAtC>; Wed, 23 Jan 2002 19:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290230AbSAXAsw>; Wed, 23 Jan 2002 19:48:52 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:966 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S289621AbSAXAsl>; Wed, 23 Jan 2002 19:48:41 -0500
Date: Wed, 23 Jan 2002 16:46:13 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: depmod problem for 2.5.2-dj4
To: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Torrey Hoffman <thoffman@arnor.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Message-id: <003701c1a470$86b6bda0$6800000a@brownell.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Vojtech, is this a USB function that you want added to usb.c?
> > 
> > Yes, please. This will change later when Pat Mochels devicefs kicks in,

What's the story on "driverfs" happening, by the way?  Last I knew, the
PCI bits weren't yet ready.


> > but for the time being, it'd be very useful.
>
> +int usb_make_path(struct usb_device *dev, char *buf, size_t size)

I don't think that patch is necessary.  It's simpler to just

    strncpy (buf, dev->devpath, min_t(size_t, size, sizeof dev->devpath));

Use like you'd use pci_dev->slot_name ... no mallocation necessary.
It's just the path from root hub down to device, /2/1/7 and so on:  the
physical path, which stays the same so long as you don't recable your
tree of USB devices and hubs.

I'd expect the typical "driverfs" path for a USB device to be the
path for the root hub (normally a PCI slot like 00:0f.3) followed by
what "devpath" now shows.

- Dave



