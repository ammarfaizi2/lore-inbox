Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262797AbREOPqW>; Tue, 15 May 2001 11:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbREOPqM>; Tue, 15 May 2001 11:46:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:60939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262797AbREOPqI>; Tue, 15 May 2001 11:46:08 -0400
Date: Tue, 15 May 2001 08:45:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B014903.B16B650B@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0105150838290.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > 
> > What are the valid cases that couldn't just register as a misc'ish
> > driver? The one that stands out is serial devices (you have hundreds of
> > them), but that's the same argument as a disk anyway.
> 
> /dev/fbN, /dev/dspN, /dev/videoN, ...

I still don't see why they couldn't be misc drivers? 

Sure, some of them already exist and all that, and we need to support
their major numbers just for backwards compatibility reasons. But a simple
"give me 16 minors, please" should work fine, together with minimal
infrastructure to create the nodes.

Think of the problem as a hot-plug issue. We don't want to statically
allocate device numbers etc for hotplug - we create the nodes on an
as-needed basis when the device is plugged in, and it's fairly easy to do
with a /sbin/hotplug kind of approach.

Static devices like /dev/fbN are no different. They were just plugged in
before the OS booted.

We already need (and largely _have_) the infrastructure for creating
device nodes dynamically: modprobe has done this since pretty much day
one, and /sbin/hotplug allows for it too. What's so distasteful with
applying the same logic to pretty much _all_ devices, and get away from
the silly static number allocation.

There are _very_ few things that need static numbers, and 99% of them are
either (a) legacy reasons, ie people _know_ that IDE is major 3 or (b)
really ugly stuff like the ioctl() example Alan posted which is not really
due to wanting static major numbers at all, but is using static knowledge
to work around _other_ problems.

Fixing those other problems would be good too ;)

		Linus

