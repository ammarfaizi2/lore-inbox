Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSDQQCr>; Wed, 17 Apr 2002 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSDQQCq>; Wed, 17 Apr 2002 12:02:46 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:22931 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S310258AbSDQQCn>; Wed, 17 Apr 2002 12:02:43 -0400
Date: Wed, 17 Apr 2002 09:00:47 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <074401c1e629$0a9ea020$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20020417035236.GC29897@kroah.com>
 <Pine.LNX.4.33.0204162203510.15675-100000@home.transmeta.com>
 <20020417134453.GE32370@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It's code to be a USB client device, not a USB host device, which is
> > > what we currently have.  It is used in embedded devices that run Linux,
> > > like the new Sharp device (can't remember the name right now...)
> > 
> > Ahhh.. A dim light goes on.
> > 
> > It would have made more sense (I think) to call it "usb/client" instead of
> > "usb/device", but maybe that's just because I didn't understand what the
> > thing was all about.
> 
> We (the linux-usb-devel list) talked about different names for this
> stuff, and tried to follow the naming convention used in the USB spec.

... except that this code does NOT follow those conventions, as
I've argued.  And "client" is explicitly contrary to the USB spec,
which uses that as a host-side phrase (though not often).

In fact if you look at USB control messages, they're baby RPCs ...
which always go from "client" (USB host, which initiates) to "server"
(USB device, responds with status and/or data).  I'd find "client"
to be wrong, not just confusing (like the X11 usage of that word).


> However 99% of kernel developers will never read that spec, and 100% of
> users never will, and the name "devices" failed to convey any good
> meaning to the first person that saw the tree outside of the USB
> developers, so changing the name to "client" makes a lot more sense :)

The USB "host" vs "device" naming convention is pretty deeply
ingrained in USB specs, but only "device" is end-user-visible.
At Fry's you buy not a "USB client", but a "USB device".  I think
you could buy a "USB adapter" (PCI card) though.

I think that from the Linux perspective, "device" is itself ambiguous.
In a USB stack with Linux everywhere (in the host side and in the
device side), I count at least four kinds of code that would in some
context be called a "device driver":

    Host side:  "client driver" (USB spec term)
                    interacts with "host controller driver" [HCD] (ditto)
        --- traffic goes over USB ---
    Device side:  "device controller driver" (not a USB spec term) (*)
                    interacts with "function driver" (USB spec term)

Today one tends to talk about a "USB device driver" rather than
a client driver, although many of us have devices that use two
drivers.  (PCI analogy:  one PCI card can have many functions,
each with its own driver)   Most HCDs are PCI device drivers.
(Although there are other HCDs Linux deals with.)

I wish I had a better term to suggest than "USB device", but I'd
sure prefer to avoid "client".  I've spent too many years doing
networking applications for that to make sense to me.  What
would it take to make "device" less ambiguous?

- Dave

(*) The USB spec needlessly avoided using symmetrical terminology
    here.  They did talk about a "bus interface" layer but it shows up on
    both host side and device side ... I think they underspecified things
    on the device side to accomodate implementation variability.  In
    fact the bus interface on the device side is in many ways simpler
    than on the host side:  it doesn't have to multiplex i/o to devices.




