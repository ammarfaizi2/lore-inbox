Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWGESuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWGESuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWGESut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:50:49 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:5436 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964860AbWGESut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:50:49 -0400
Message-ID: <44AC0B2A.9080500@gentoo.org>
Date: Wed, 05 Jul 2006 19:55:38 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <44A95F12.8080208@gmail.com>	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>	 <20060703214509.GA5629@kroah.com>	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>	 <20060703222645.GA22855@kroah.com>	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>	 <20060703232927.GA19111@kroah.com>	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>	 <44ABFDD3.6040500@gentoo.org> <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>
In-Reply-To: <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> Yes and no... we can have that stuff in userspace, of course, but I
> think that we are walking to a big salad here. Imagine this: some
> fingerprint devices have userspace drivers while others have
> kernel-mode drivers, while the majority of other USB devices (that
> could also be implemented in userspace) are in kernel-space. Why care
> to keep that stuff in userspace (except for security, since less
> non-critical code in userspace == stability+security), while we still
> have other devices being managed in kernel mode ?

You kind of answered your own question before you asked it, but let me 
try and clarify my view. Two things:

1. We generally try and implement things in userspace where possible and 
where it makes sense at least to a certain degree. Or at least, you only 
get USB stuff included in the kernel when you have convinced Greg it 
belongs there (which you may have already done).

2. As you acknowledge, only a certain subset of all USB fingerprint 
reader drivers will be implemented in the kernel, therefore providing 
the abstraction at kernel level is inadequate (you leave the pure 
userspace drivers out of the loop, therefore getting people to actually 
use your interface will be difficult). You may argue that your proposal 
doesn't limit itself to fingerprint readers, but neither does my answer: 
many USB devices (of other types) are supported purely in userspace.

> Another thing is that this "device information layer" should also be
> implemented not only for fingerprint devices, but for other USB
> devices too... and possibly (very likely) to other devices that are
> not USB. If such device-class-specific properties layer is to be
> implemented, we should do it to all device classes (not bind to any
> specific BUS type).

Sounds like you are talking about reimplementing HAL at this point. I 
don't think this argument justifies including it at kernel level (but 
neither does it oppose it).

> I think that the kernel should be aware of the properties of the
> devices that it handles,

If the kernel doesn't *need* to know about the properties and doesn't 
act on them, why? And what about the devices that the kernel doesn't 
handle, where they are operated purely through userspace?

> otherwise we're walking to some kind of
> microkernel architecture, where one day we'll have everything running
> on userspace...

That's not what I'm suggesting - many classes of drivers belong in 
kernel space and would incur major brain damage if moved to userspace.

You might want to go back a year or two and read the discussions when 
the USB scanner driver was moved out of the kernel and reimplemented 
100% inside libsane. There are other examples as well.

> but this sounds to me more like a
> decision made by fingerprint devices manufactures 

It's not their decision while they aren't the ones writing the drivers.

> Do you have any idea about how many fingerprint readers have linux
> support

idmouse is the only fingerprint reader driver in the Linux kernel that I 
know of. There are a number of other devices supported in userspace.

Daniel
