Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSFTTX3>; Thu, 20 Jun 2002 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFTTX3>; Thu, 20 Jun 2002 15:23:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61846 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315374AbSFTTX1>;
	Thu, 20 Jun 2002 15:23:27 -0400
Date: Thu, 20 Jun 2002 12:18:25 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0206201207290.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Sorry for the lack of noise in the last week; I was unable to read email 
for the last week, and am only starting to catch up. ]

> Try it out yourself. Just do
> 
> 	mount -t driverfs /devices /devices
> 
> and then look at the whole glory in some graphical file manager to get a
> view of the tree (actually, most file managers are somewhat confused about
> the fact that the directory counts don't reflect sub-directories, so you
> may have to open the subdirectories by hand, whatever. That's a bug.
> Should be fixed. I'm cc'ing Pat)

ACK. I'm looking into it; should have something before I leave for Ottawa. 

> End result: Linux has a notion of a "struct device", and it's an internal
> kernel representation of the whole bus structure as far as Linux can tell.
> It's then exported as a filesystem, but that's not the important part: the
> device tree is valid (and important) even when it's not exported to user
> space, simply because things like power-management events etc have to
> honor the tree and traverse it in the right order.

This is an important point, and one I will be stressing heavily in Ottawa. 
The device model != driverfs. The new device model is about refining the 
kernel representation of device-related objects: devices, drivers, bus 
drivers, and class drivers. 

A filesystem just happens to map very nicely onto internal hierarchial 
structures, which is why it was created. driverfs makes no sense with the 
device model infrastructure to populate it. But, the device model core can 
theoretically be separated from the driverfs implementation. 

> If you like OF, you can actually use OF to _populate_ the Linux device
> tree. The people who like ACPI (yet, they exist) do that with ACPI. The
> Linux device tree is _completely_ agnostic, and absolutely does _not_ want
> to know or depend on firmware issues, since firmware is not portable.
> 
> (Right now ACPI does this, so all the strange ACPI nodes will show up in
> /devices/root/ACPI if you have ACPI enabled).

I made a patch a while back that mapped ACPI-enumerated devices back to 
physical objects in the system. This got rid of the duplicate ACPI 
entries, and should be done generically enough to port it to other 
firmware enumerators. (It depends a couple of other patches that have not 
made it out yet, but I'll bring the whole slew to Canada so people can 
see how it works).

OF wrt the device tree is something I've talked to a few people about. 
Things were much more nebulous than now, and talk is still cheap. Ideally, 
OF should populate the device tree in a similar manner, but I don't think 
anyone has had the time to make it happen...

	-pat

