Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWGERxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWGERxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWGERxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:53:55 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:24332 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964932AbWGERxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:53:54 -0400
Message-ID: <44ABFDD3.6040500@gentoo.org>
Date: Wed, 05 Jul 2006 18:58:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>	 <44A95F12.8080208@gmail.com>	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>	 <20060703214509.GA5629@kroah.com>	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>	 <20060703222645.GA22855@kroah.com>	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>	 <20060703232927.GA19111@kroah.com> <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
In-Reply-To: <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> Ok, I'll develop this in a cleaner way. But did you get the idea ? Let
> me know if you think that this is something worthy to develop so I can
> work on it. There are some details that I need to study about the USB
> layer to get the whole picture so I can avoid redundant stuff.
> 
> I just think that it would be cool to be able to know the capabilities
> of each device connected to our system, and who's better to tell us
> that than the device drivers? =]
> This way we can know, for example, that a webcam can do 30fps at
> 640x480 and the output type of the video, independently of which
> webcam (and driver) we're using...

While this may be a good idea in general, it could possible be done in 
userspace (the whole concept is basically linking USB ID's to capability 
sets, so there is no need for this to be in-kernel, right?).

Also, in the less general case of fingerprint readers, most drivers will 
be in userspace. The upek one is, a driver being developed for the 
Authentec AES4000 is, and dpfp will be if the USB stack is now mature 
enough to allow libusb to bind to the fingerprint reader while the 
kernel usbhid driver is bound to the keyboard interface on the same 
device. So, defining some kind of structure for /sys/class/fingerprint 
won't apply to many of the supported devices.

Yes - I agree that there needs to be some common abstraction for 
fingerprint readers. When we have more device support, we should look at 
providing a fingerprint processing library, which supports as many 
devices as possible through a common interface.

Daniel
