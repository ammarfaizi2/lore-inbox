Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290549AbSA3UJS>; Wed, 30 Jan 2002 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290527AbSA3UJH>; Wed, 30 Jan 2002 15:09:07 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:50881 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S290549AbSA3UJC>; Wed, 30 Jan 2002 15:09:02 -0500
Date: Wed, 30 Jan 2002 12:07:26 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@suse.de>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <0a1501c1a9c9$bdf427e0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org>
 <08cf01c1a933$f45ac460$6800000a@brownell.org>
 <20020130040908.GA23261@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"> " ==  "Greg KH" <greg@kroah.com>

> I completly agree.  

As I see -- some mailer daemons were adding delays and
fomenting confusion!


> However, the root hub name _does_ propose a problem.  I feel we have two
> solutions:
> - use the bus number (usb_bus_00x)
>   Pros:
>   matches the usbfs naming and directory structure
>   Cons:
>   depends on the initialization order of the busses.

At this point, I'd propose that "driverfs" should adopt a policy
that naming dependencies on initialization order are a virus
that should be obliterated to the degree it's possible ... which
in this case is completely!  :)


> - use a generic name like I did (usb_bus)
>   Pros:
>   does not depend on the init order, and relies on the
> location in the entire pci topology tree to show its
> uniqueness.
>   Cons:
>   boring :)

Or a third option is to get rid of the extra level of indirection
in the current driverfs naming policy, as Patrick suggested
in a separate email.  I'll follow up separately.


> And also remember, the status file in a device's directory also provides
> a _lot_ of information.  We haven't even started to fill up the fields
> there...

And there can be a lot more such files.  Though that 4KB limit
may become an issue at some point.

What sort of USB information were you thinking should show
up?  Current configuration and altsetting?  Power consumption
for hubs (not that we budget that yet :)?  There really aren't any
examples of this in the kernel yet.

Also, one could argue that each USB function ("interface")
should be presented as an individual device, just like each PCI
function is handled ... after all, USB drivers bind to interfaces,
not devices, and this is the "driver" FS!  :)

- Dave


