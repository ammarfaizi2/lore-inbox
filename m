Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHFRiV>; Tue, 6 Aug 2002 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHFRiV>; Tue, 6 Aug 2002 13:38:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59818 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S314278AbSHFRiT>;
	Tue, 6 Aug 2002 13:38:19 -0400
Date: Tue, 6 Aug 2002 10:43:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Rob Landley <landley@trommello.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Policy vs API (was Re: [PATCH] integrate driverfs and devfs
 (2.5.28))
In-Reply-To: <20020806055922.26D48644@merlin.webofficenow.com>
Message-ID: <Pine.LNX.4.44.0208061013560.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The user needs some kind of API.  Some way for a program to say "Could I 
> please talk to the slave drive on the second IDE controller".  What I'm 
> wondering is where's the line between "policy" and "API"?  You can't have a 
> standard API without SOME level of "policy".

There is a difference between policy and mechanism. The mechanism provides 
the infrastructure to develop policy. 

It is definitely difficult to _not_ build in some sort of default policy,
because we want to make assumptions about what we know is true. We need 
default policy, but the argument is that it should reside in the kernel. 

Note that in order to boot, we need default policy in either the kernel or 
initramfs. We also need compatibility for some time, so it's not like the 
in-kernel policy is going away right immediately. 

> I've noticed a bias against actually using strings to interface the kernel 
> with userspace (the module autoloader being one relatively obvious example), 
> but it's still done in a bunch of places anyway ("/sbin/init", "linuxrc", 
> "hotplug", "modprobe", the text command line for kernel booting with "init=", 
> "root=", "initrd="...).  The kernel talks to other parts of the kernel by 
> exporting text symbols, userspace talks to userspace with strings, why is 
> kernel to userspace fundamentally different?  The problem with the horror 
> that is /proc is that it's not ORGANIZED, not that it's text.  People put so 
> much stuff into /proc because they WANT a text API, and for a long time that 
> was their only real outlet.

ASCII is good. We want ASCII interfaces. Period. If there are any doubts 
or objections, please read the archives. 

> The problems with devfs are, well, numerous, but the fundamental idea of 
> automatically mounting a /dev directory with the available devices into it 
> rather than a MAKEDEV script to create 8 zillion nodes for devices you might 
> conceivably want to borrow from a museum someday...  Implementation issues 
> aside, what was wrong with the idea itself?  

It depends on what your idea of the idea is. The idea of exposing only the 
hardware that is present is good. But, that's about all the praise about 
it you'll get from me. 

> I'm under the vague impression that devicefs may somehow become the new 
> driver API at some point after Buck Rogers returns from his frozen orbit.  
> The whole POINT of devicefs seems to be to expose new data through a fresh 
> API that's designed to grow without getting disorganized.  This implies (to 
> me) a move towards a device API defined in the context of a text namespace.

Remember that there are two pieces to this movement: the device model and
driverfs.  Everyone calls it driverfs because it's cute, catchy, and what
is actually visible to people. 'The device model' is a crappy name, but I
don't exactly have a better name for it (besides 'Rita', but that doesn't
really make much sense).

The device model is a consolidation of the device and driver
infrastructure. It's purely internal and invisible to the user (excluding
the problem of device naming and /sbin/hotplug).

driverfs is simply the window into the organization of these internal
structures, the relationships between them, and their attributes (via an
ASCII interface).

The distinction is important, and I encourage you to read the
documentation at the link Greg posted (and continue asking questions).



	-pat



