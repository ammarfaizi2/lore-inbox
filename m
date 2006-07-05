Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWGESJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWGESJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWGESJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:09:11 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:60449 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964955AbWGESJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:09:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cxpS58XPNpW4dyMCoQ7ryYm2pf79zo4gYMrN0rd62q/Ar6FNax4lZfg7dGqrZA0LFmw9Z+njMUA4ce4J8pjVElbmrUiK5XouJAjIKC5jr+4G4tqOLa3jDsA0Z2yk1k6u5EJl6qhnvuLOKeuV2umqOY+g6AfCYEHM1AM/Bx+HPrA=
Message-ID: <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>
Date: Wed, 5 Jul 2006 14:09:09 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Greg KH" <greg@kroah.com>, "Alon Bar-Lev" <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <44ABFDD3.6040500@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <20060703222645.GA22855@kroah.com>
	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
	 <20060703232927.GA19111@kroah.com>
	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
	 <44ABFDD3.6040500@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While this may be a good idea in general, it could possible be done in
> userspace (the whole concept is basically linking USB ID's to capability
> sets, so there is no need for this to be in-kernel, right?).
>

Yes and no... we can have that stuff in userspace, of course, but I
think that we are walking to a big salad here. Imagine this: some
fingerprint devices have userspace drivers while others have
kernel-mode drivers, while the majority of other USB devices (that
could also be implemented in userspace) are in kernel-space. Why care
to keep that stuff in userspace (except for security, since less
non-critical code in userspace == stability+security), while we still
have other devices being managed in kernel mode ?

Another thing is that this "device information layer" should also be
implemented not only for fingerprint devices, but for other USB
devices too... and possibly (very likely) to other devices that are
not USB. If such device-class-specific properties layer is to be
implemented, we should do it to all device classes (not bind to any
specific BUS type).

> Also, in the less general case of fingerprint readers, most drivers will
> be in userspace. The upek one is, a driver being developed for the
> Authentec AES4000 is, and dpfp will be if the USB stack is now mature
> enough to allow libusb to bind to the fingerprint reader while the
> kernel usbhid driver is bound to the keyboard interface on the same
> device. So, defining some kind of structure for /sys/class/fingerprint
> won't apply to many of the supported devices.
>

I think that the kernel should be aware of the properties of the
devices that it handles, otherwise we're walking to some kind of
microkernel architecture, where one day we'll have everything running
on userspace... Well, I'm not aware if there's any sensus regarding
moving device drivers to userspace, but this sounds to me more like a
decision made by fingerprint devices manufactures (as there are lots
of SDKs that comes with userspace drivers, instead of a kernel driver
for their devices). In order to keep a uniform standard, we should
keep this on kernel space. Things like match algorithm
implementations, indeed, should be kept at userspace.

> Yes - I agree that there needs to be some common abstraction for
> fingerprint readers. When we have more device support, we should look at
> providing a fingerprint processing library, which supports as many
> devices as possible through a common interface.

Do you have any idea about how many fingerprint readers have linux
support (i.e., kernel mode drivers, instead of dozens of
per-manufacturer SDKs) ?



Thanks
Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
