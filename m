Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129920AbQKFTKC>; Mon, 6 Nov 2000 14:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbQKFTJx>; Mon, 6 Nov 2000 14:09:53 -0500
Received: from waste.org ([209.173.204.2]:22372 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129920AbQKFTJh>;
	Mon, 6 Nov 2000 14:09:37 -0500
Date: Mon, 6 Nov 2000 13:09:19 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A06FA73.948357F6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011061305040.30477-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Jeff Garzik wrote:

> Oliver Xymoron wrote:
> > 
> > On Mon, 6 Nov 2000, David Woodhouse wrote:
> > 
> > > The point here is that although I've put up with just keeping the sound
> > > driver loaded for the last few years, permanently taking up a large amount
> > > of DMA memory, the inter_module_xxx stuff that Keith is proposing would
> > > give us a simple way of storing the data which we want to store.
> > ...
> > > Being able to do it completely in userspace would be neater, though.
> > 
> > I think there are a bunch of other devices that need stuff from userspace
> > before they fully init, namely the ones that load proprietary firmware
> > images. Will an approach like that work here?
> 
> Some devices have a firmware.h that is compiled into the driver.  A few
> sound devices use a function that loads a firmware file from userspace,
> given a filename.  The comment in drivers/sound/sound_firmware.c says
> that this is a poor method, and that the recommended method for
> uploading firmware to a device is via ioctl.

Ioctl (or alternate device for plan9 groupies) is fine. My point is final
initialization of the device is obviously delayed until the firmware is
loaded. Adopting a similar strategy for initializing mixers (possibly
falling back to initializing with zero levels) minimizes the window
between resetting a device and having sane mixer settings.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
