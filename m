Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbSAGSE2>; Mon, 7 Jan 2002 13:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbSAGSEU>; Mon, 7 Jan 2002 13:04:20 -0500
Received: from air-1.osdl.org ([65.201.151.5]:29314 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S284610AbSAGSEK>;
	Mon, 7 Jan 2002 13:04:10 -0500
Date: Mon, 7 Jan 2002 10:05:30 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: Paul Jakma <paulj@alphyra.ie>, <knobi@knobisoft.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201051807160.27113-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Dave Jones wrote:

> On Sat, 5 Jan 2002, Paul Jakma wrote:
>
> > how does devicefs differ from devfs? eg, on some of my systems i mount
> > devfs on /devfs and an ls -l of it shows all the devices that
> > currently have drivers that registered them.
>
> different goals. One of the reasons this has come about is for power
> management, we need a tree like structure so that we for eg, power
> down a network card before powering down the pci bridge it sits on.
> (The idea being to power down from the leaves, and work your way back
> up to the root of the tree)
>
> devicefs is just a means of exporting this to userspace, be that for
> usage with the userspace acpi tools, or for hinv like programs.
> As I mentioned earlier, ACPI enumerates pretty much everything in the
> system, even if theres no driver for it.
> If there is a driver for it, it can register things like "I support
> these power saving states" with driverfs for additional functionality.
>
> It would be nice at some point to get some of the other (pre-ACPI)
> busses registering stuff there too, for completeness.

One of the ideas that I've kicked around with some people here and the
ACPI guys is the notion of trigger device enumeration from userspace
completely.

During the initramfs stage, a program (say devmgr) figures out what type
of system you have, where the PCI buses are, etc. It tells the kernel this
information, which then probes for existence, then loads drivers.

There of course needs to be a fallback mechanism for cases where the
hardware isn't known about, the tables are buggy, or you need to do
things like make bios32 calls. But, that can be triggered via a procfs
file, a system call, etc.

But, this all fits nicely with the notion of parsing firmware tables from
userspace, be them DMI, MPS, or ACPI tables. How they're read is
unimportant (/dev/mem or /var/run/*), it's just that the logic to do so
can be moved out of the kernel and consolidated.

	-pat

