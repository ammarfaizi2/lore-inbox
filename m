Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQKOVRb>; Wed, 15 Nov 2000 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129559AbQKOVRV>; Wed, 15 Nov 2000 16:17:21 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:13328 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129189AbQKOVRC>; Wed, 15 Nov 2000 16:17:02 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD12@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: CONFIG_USB_HOTPLUG (was Patch(?): linux-2.4.0-test11-pre4/dri
	vers/sound/yss225.c  compile failure)
Date: Wed, 15 Nov 2000 10:18:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

> From: Adam J. Richter [mailto:adam@yggdrasil.com]
> 
> >From randy.dunlap@intel.com Wed Nov 15 09:04:36 2000
> >> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> >> 
> >> Greg KH wrote:
> >> > On Wed, Nov 15, 2000 at 12:29:15AM -0500, Jeff Garzik wrote:
> >> > > If we are going to create CONFIG_USB_HOTPLUG, we must 
> -eliminate-
> >> > > CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
> >> > > CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.
> >> > 
> >> > Argh!
> >> > I thought the whole point of this was to make there be only 
> >> one hotplug
> >> > strategy, due to the fact that this is a real need.
> >> > 
> >> > Please let's not go down this path.  It was all starting 
> to look so
> >> > nice...
> >> 
> >> I -want- there to be only one hotplug strategy, but Adam 
> seemed to be
> >> talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.
> 
> >I told Adam that I didn't want that patch, but it's not
> >up to me now.
> 
> 	You said you wanted to "hold of on CONFIG_USB_HOTPLUG for now",
> which I take to mean up to 2.4.0.

OK, I stand corrected.
Actually I don't recall what that meant.  You could be right,
but it could have meant that it should be re-evaluated later.

> 	I have not asked that CONFIG_USB_HOTPLUG be put in 
> 2.4.0, although
> I would not mind.  I am just agreeing with you (Randy) when you
> identified the problem and wrote in linux-usb-devel "[Why] is 
> it safe to
> use __devinitdata on the usb_device_id table?  It's used 
> during any new
> device connect, after driver init, right ...?"  You were right: the
> __devinitdata being used in the USB drivers will probably crash the
> kernel if CONFIG_HOTPLUG is not defined and the USB code attempts to
> recover from an error by faking disconnect/reconnect.
> 
> 	The statements about how we might address this issue more
> fully have been about in the context of after 2.4.0.  To refresh your
> memory, in my first message on this thread I wrote:
> 
> |        After 2.4.0, and after the fake disconnect/reconnect code in
>          ^^^^^^^^^^^
> | drivers/usb/{devio,storage/scsiglue}.c is designed out, then we may
> | want to explore adding __usbdevinit{,data} defines in 
> include/linux/init.h
> | that would be controlled by a new CONFIG_USB_HOTPLUG option, as in
> | the patches that I posted for this to linux-usb-devel. 
> 
> 	Until there is __usbdev{init,exit}{,data}, the incorrect
> __devinitdata qualifiers should be removed from the USB device
> drivers (but not from the host controller drivers, which are 
> PCI drivers).

I agreed with you that the __dev qualifiers should be
removed for now, until there is a better solution.
I didn't agree that we should add __usbdev qualifiers.
I think that we should have a unified hotplug strategy,
whatever it is/becomes.

Like Greg and Jeff have said, I'd prefer not to see
CONFIG_whateverbuses_HOTPLUG, but I'm saying that based
on style and KISS, not on technical evaluation,
so I could be wrong.  What you are proposing could be
the right thing to do.  Maybe you are way ahead of my
thinking on this.

> 	Would you like to propose a different solution, Randy?

No thanks, I think that we have enough [good] cooks in the
kitchen for now.  If I find that I have some time to
contribute to it, I would like to, but not now.
Obviously I may miss the window of time to contribute
to this if I don't do it now, but c'est la vie.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
