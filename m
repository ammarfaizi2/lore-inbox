Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCWCjz>; Thu, 22 Mar 2001 21:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbRCWCjp>; Thu, 22 Mar 2001 21:39:45 -0500
Received: from dentin.eaze.net ([216.228.128.151]:58130 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S129078AbRCWCjd>;
	Thu, 22 Mar 2001 21:39:33 -0500
Date: Thu, 22 Mar 2001 20:38:18 -0600 (CST)
From: SodaPop <soda@xirr.com>
To: <egger@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Only 10 MB/sec with via 82c686b - FIXED
In-Reply-To: <20010321143956.917977A94@Nicole.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0103222015490.25766-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Regarding the overclocking of the PCI bus, I was not aware of this.  The
documentation led me to believe the pci clock was fixed, however further
experimentation indicates that's clearly not the case.  Thanks.

Regarding the fix:  I installed an Ensonique AudioPci sound card, and
experienced horrible distortion, crackling, and high pitched chirps any
time I tried to use the device.  I noticed that various interrupts were
causing chunks of the real audio to sometimes slip through; on a whim I
tried ping flooding a nearby machine and the sound quality improved
greatly.

Putting two and two together, it occurred to me that the motherboard was
having irq/interrupt routing problems.  The disks could not get reasonable
throughput because the interrupts were getting choked or held up, and the
sound card couldn't properly function either.

Wonder of wonders, I flashed the bios to the latest and greatest version.
Current data transfer rates are 35.7 MB/sec on both udma drives, exactly
as expected and darn close to the continuous read limits of the disks.
The audio also started working, flawlessly.

There are other issues however - the athlon now runs significantly hotter
at idle for one, but the most serious is that the K7 kernel optimizations
cause horrendous kernel panics and crashes.  I'm running now on a kernel
compiled for 386, which seems to be stable.  I'll attempt to build other
kernels to see if I can figure out whats going on.

Net result:  IWill KK266 motherboards have bios problems, it may be a good
idea to upgrade the bios.

-dennis T


On Wed, 21 Mar 2001 egger@suse.de wrote:

> On 20 Mar, SodaPop wrote:
>
> > I have an IWill KK-266R motherboard with an athlon-c 1200
> > processor in it, and for the life of me I can't get more than
> > 10 MB/sec through the on-board ide controller.  Yes, all the
> > appropriate support is turned on in the kernel to enable dma
> > and specific chipset support, and yes, I think I have all
> > relevant patches and a reasonable kernel.
>
>  Yes, actually I'm seeing the same on a KT133 board from Elitegroup.
>  Although here I get a bit more: 15 MB/s
>
> > I noted a number of other interesting things;  one, that -X33,
> > -X34, and -X64 through -X69 all have the same 10 MB/sec transfer
> > rate, and two, that the 10 MB/sec transfer rate can be linearly
> > increased to 12 MB/sec by raising the system bus from 100 mhz to
> > 120 mhz (all components are safely rated at 133, no overclocking
> > involved.)
>
>  Duh, before making such a claim you should consider the fact that
>  this is overclocking your PCI/AGP bus and I have yet to see any
>  graphic cards/IDE controllers/other devices which are rated for
>  37MHz PCI bus speed.
>
> --
>
> Servus,
>        Daniel
>

