Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTJFQGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTJFQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:06:39 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3969 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263008AbTJFQGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:06:32 -0400
Date: Mon, 6 Oct 2003 17:06:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310061606.h96G6qhp000963@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310061059220.9165@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos>
 <20031003235801.GA5183@redhat.com>
 <Pine.LNX.4.53.0310060834180.8593@chaos>
 <16257.26407.439415.325123@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0310061059220.9165@chaos>
Subject: Re: FDC motor left on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If you can end up with another floppy drive motor on under
> > > any condition when the kernel is given control, then you
> > > can simply reset both (or all) floppy motor control bits.
> >
> > This is not a problem to deal with in the kernel - what if there is
> > hardware other than a floppy controller at that address?
> >
> 
> In the ix86 architecture (and it is in arch-specific code), there
> cannot be anything at this address except a floppy or nothing.
> In both cases, you are covered.
> 
> I any embedded systems developer decides to put something besides
> a FDC at that address, it is up to them to fix the problems they
> create, not linux.

If no support for floppy drives is compiled in to the kernel, it's
reasonable to expect no floppy-related accesses to be done to those
ports.

> > The bootloader needs to ensure that the hardware is at least in a
> > sensible state when the kernel is entered.  Infact, unless the system
> > is being booted from floppy, why is the BIOS accessing the floppy at
> > all?
> >
> 
> The BIOS accesses the floppy (if one exists) because of the
> boot order having been selected. Many who have computers,
> that are not accessible to others, have the BIOS set up so
> that the first thing to check for a boot-loader is the floppy,
> then the CD-ROM, then the hard disk. This lets them do their
> normal work without having to muck with the BIOS.
> 
> It is not an error to configure a machine this way. It
> is an option. It is an error, however, to leave a floppy
> disk-drive motor ON forever.

OK, so the bootloader is at fault, not the BIOS.  If the BIOS is
configured to allow booting from floppy, but you decide to boot from
other media on any occasion, the first code loaded, I.E. the
bootloader, should turn off the floppy motor.

> > Re-configure the BIOS not to try to boot from the floppy, or to seek
> > the drive to see whether it is capable of 40 or 80 tracks.
> >
> 
> The BIOS can be (correctly) set to any of many possible boot-
> options.

If the floppy motor ends up being on all the time, how is that a
correct configuration?

> > If that is not possible, (on a laptop with an obscure BIOS for
> > example), add a delay to the bootloader.  Assumng interupts are still
> > enabled, the BIOS will switch the floppy off after a few seconds.
> >
> 
> An arbitrary delay is a very bad hack.

Yes, it is, the real solution is to fix the bootloader.  I was simply
providing a workaround.

> If you need something OFF,
> you turn it OFF. One should never work-around a primative like
> ON or OFF. The digital-output registers at the FDC's specified
> address is where this is done.

I consider it just as much of a hack to add floppy-related code to all
i386 kernels whether they are for floppy-less machines or not.

John.
