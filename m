Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261214AbREOSM1>; Tue, 15 May 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261201AbREOSMR>; Tue, 15 May 2001 14:12:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54482 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261237AbREOSEM>;
	Tue, 15 May 2001 14:04:12 -0400
Message-ID: <3B016F9A.360A0CFD@mandrakesoft.com>
Date: Tue, 15 May 2001 14:04:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151031320.2112-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And my opinion is that the "hot-plugged" approach works for devices even
> if they are soldered down

agreed, as you probably know :)


> Now, if we just fundamentally try to think about any device as being
> hot-pluggable, you realize that things like "which PCI slot is this device
> in" are completely _worthless_ as device identification, because they
> fundamentally take the wrong approach, and they don't fit the generic
> approach at all.

Should I interpret this as you disagreeing with
exporting-bus-info-to-userspace type additions?  ie. some random
get-info ioctl spits out pci_dev->slot_name to userspace.

I believe there are rare cases where this is useful.  When one already
has the /dev node (via an open fd used for ioctl, usually), additionally
you need the bus info to make an association between an active device on
the hardware bus, and an active driver in the kernel.  X could use this
info to figure out which fbdev devices to avoid.  SCSI is already using
similar info, as of 2.4.4, as are net devs.  Userspace apps that diddle
hardware are a definite minority case, but for that case the PCI slot
info is useful.


> This is true to the point that I would not actually think that it is a bad
> idea to call /sbin/hotplug when we enumerate the motherboard devices.

Don't ask for it or you might actually get it.... ;-)  I think having a
pci_driver for northbridge and southbridge devices would make ACPI-free
PM easy and achieveable.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
