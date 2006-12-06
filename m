Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937702AbWLFWFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937702AbWLFWFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937707AbWLFWFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:05:00 -0500
Received: from hu-out-0506.google.com ([72.14.214.233]:3075 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937702AbWLFWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:04:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=irFh/jwOFIZsYyaghRGjAfPaXCTuFHDz4iLc4NkLlZVdkHsfeio2roMq5woyS6Ef9+bokR8NhNh7dfPTLpk/HTjzmJhHLxK8ADEnjX7Gq6pGhWvHJOVDD1mAZE9w9bT6/gBVCfk1UzClinWOKmjtPPbQcfKPvskcpnRhkWEE4GM=
Message-ID: <d120d5000612061404x3f6e18e7qd3601c3b450a5f91@mail.gmail.com>
Date: Wed, 6 Dec 2006 17:04:56 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Ivo van Doorn" <ivdoorn@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <200612062241.58476.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <200612062031.57148.IvDoorn@gmail.com>
	 <d120d5000612061218x4eac87e0jc18409f82bb7c99c@mail.gmail.com>
	 <200612062241.58476.IvDoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
>
> > >  2 - Hardware key that does not control the hardware radio and does not report anything to userspace
> >
> > Kind of uninteresting button ;)
>
> And this is the button that rfkill was originally designed for.
> Laptops with integrated WiFi cards from Ralink have a hardware button that don't send anything to
> userspace (unless the ACPI event is read) and does not directly control the radio itself.
>

So what does such a button do? I am confused here...

...
>
> And this event should be reported by a generic approach right? So it should
> be similar as with your point 2 below. But this would mean that the driver
> should create the input device. Or can a driver send the KEY_WIFI event
> over a main layer without the need of a personal input device?
> I am not that familiar with the input device layer in the kernel, and this is
> my first attempt on creating something for it, so I might have missed something. ;)

Yes, I think the driver should just create an input device. You may
provide a generic implementation for a polled button and have driver
instantiate it but I do not think that a single RFkill button device
is needed - you won't have too many of them in a single system anyway
(I think you will normally have 1, 2 at the most).

...
> > 3. A device without transmitter but with a button - just register with
> > input core. Userspace will have to manage state of other devices with
> > transmitters in response to button presses.
>
> This is clear too. Rfkill is only intended for drivers that control a device with
> a transmitter (WiFi, Bluetooth, IRDA) that have a button that is intended to
> do something with the radio/transmitter.
>
> > Does this make sense?
>
> Yes, this was what I intended to do with rfkill, so at that point we have
> the same goal.
>

I think it is almost the same. I also want support RF devices that can
control radio state but lack a button. This is covered by mixing 2)
and 3) in kernel and for userspace looks exactly like 2) with a
button.

...
> >
> > I don't think a config option is a good idea unless by config option
> > you mean a sysfs attribute.
>
> I indeed meant a sysfs attribute. I should have been more clear on this. :)
>

OK :)

-- 
Dmitry
