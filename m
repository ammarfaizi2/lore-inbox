Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbREOS25>; Tue, 15 May 2001 14:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbREOS2v>; Tue, 15 May 2001 14:28:51 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59153 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261222AbREOSQ2>; Tue, 15 May 2001 14:16:28 -0400
Date: Tue, 15 May 2001 11:15:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B016F9A.360A0CFD@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Jeff Garzik wrote:
> 
> > Now, if we just fundamentally try to think about any device as being
> > hot-pluggable, you realize that things like "which PCI slot is this device
> > in" are completely _worthless_ as device identification, because they
> > fundamentally take the wrong approach, and they don't fit the generic
> > approach at all.
> 
> Should I interpret this as you disagreeing with
> exporting-bus-info-to-userspace type additions?  ie. some random
> get-info ioctl spits out pci_dev->slot_name to userspace.

Yes and no.

I'm absolutely _not_ against exporting information. That kind of
information can be very useful to help the user diagnose things, by
visualizing device layout etc (ie think here of a "device
manager" application that does all the pretty graphics that people so
enjoy).

Giving that kind of information to the user can be very useful indeed. And
I have no arguments against it.

The part I absolutely detest is when the information becomes more than
just "information", and is used to enforce a world-view. Anybody who uses
physical location for naming devices (ie you have to know where the hell
the thing is in order to look it up), is so far out to lunch that it's not
even funny. And the sad fact is that this is pretty much how ALL unixes
have historically done things ("Oh, you want to see the disk? Sure. It's
on scsi bus 1, channel 2, ID 3, lun 0, so you just open /dev/s1c3l0 and
you're done! Easy as pie!").

Keep it informational. And NEVER EVER make it part of the design.

That way, people who grew up with big unix machines can have their scripts
that creates the stupid names dynamically on the fly, and still play at
being bound to a static naming scheme that was silly 20 years ago and is
just incredibly stupid today. There's a script for doing exactly this for
SCSI. I forget what it's called, because I obviously think the thing is
stupid, but giving people the power to do even silly things is what Linux
is all about.

		Linus

