Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163461AbWLGVxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163461AbWLGVxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163472AbWLGVxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:53:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:54912 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163468AbWLGVxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:53:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=lkSDShfzwrDk/iDT8x4xaOmF8YciSGs68OqGMP8nmnNDILyyJST38UV2xIUmoegN8Nh6kUa0ZyBrjSCoOfKxHarxpvTiddd9DoITQjv5AWrxLPpEJ2o89dXUNp38vuUdfmk/9lGpFziaCMjZVlnguLbfNOEniOw9+DbTZDFYYhY=
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Thu, 7 Dec 2006 22:53:13 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <200612062241.58476.IvDoorn@gmail.com> <d120d5000612061404x3f6e18e7qd3601c3b450a5f91@mail.gmail.com>
In-Reply-To: <d120d5000612061404x3f6e18e7qd3601c3b450a5f91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612072253.14492.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > >  2 - Hardware key that does not control the hardware radio and does not report anything to userspace
> > >
> > > Kind of uninteresting button ;)
> >
> > And this is the button that rfkill was originally designed for.
> > Laptops with integrated WiFi cards from Ralink have a hardware button that don't send anything to
> > userspace (unless the ACPI event is read) and does not directly control the radio itself.
> >
> 
> So what does such a button do? I am confused here...

Without a handler like rfkill, it does nothing besides toggling a bit in a register.
The Ralink chipsets have a couple of registers that represent the state of that key.
Besides that, there are no notifications to the userspace nor does it directly control the
radio.
That is where rfkill came in with the toggle handler that will listen to the register
to check if the key has been pressed and properly process the key event.

> > And this event should be reported by a generic approach right? So it should
> > be similar as with your point 2 below. But this would mean that the driver
> > should create the input device. Or can a driver send the KEY_WIFI event
> > over a main layer without the need of a personal input device?
> > I am not that familiar with the input device layer in the kernel, and this is
> > my first attempt on creating something for it, so I might have missed something. ;)
> 
> Yes, I think the driver should just create an input device. You may
> provide a generic implementation for a polled button and have driver
> instantiate it but I do not think that a single RFkill button device
> is needed - you won't have too many of them in a single system anyway
> (I think you will normally have 1, 2 at the most).

Ok, this is something that can be added as notice in the rfkill description
to make sure drivers which supports keys that handle the radio event themselves
should handle everything themselves and just use the KEY_RFKILL event for the
input device.

> > > 3. A device without transmitter but with a button - just register with
> > > input core. Userspace will have to manage state of other devices with
> > > transmitters in response to button presses.
> >
> > This is clear too. Rfkill is only intended for drivers that control a device with
> > a transmitter (WiFi, Bluetooth, IRDA) that have a button that is intended to
> > do something with the radio/transmitter.
> >
> > > Does this make sense?
> >
> > Yes, this was what I intended to do with rfkill, so at that point we have
> > the same goal.
> >
> 
> I think it is almost the same. I also want support RF devices that can
> control radio state but lack a button. This is covered by mixing 2)
> and 3) in kernel and for userspace looks exactly like 2) with a
> button.

Ok, this means making the change in rfkill to instead support 1) and 2)
and change it into 2) and 3) that would be possible and would make it possible
again to change the radio state to something different then the key indicates.
That was previously removed because of support for 1) devices.

> ...
> > >
> > > I don't think a config option is a good idea unless by config option
> > > you mean a sysfs attribute.
> >
> > I indeed meant a sysfs attribute. I should have been more clear on this. :)
> >
> 
> OK :)
> 

Ivo
