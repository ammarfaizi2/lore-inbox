Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSDCN7M>; Wed, 3 Apr 2002 08:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSDCN6w>; Wed, 3 Apr 2002 08:58:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29057 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311670AbSDCN6p>; Wed, 3 Apr 2002 08:58:45 -0500
Date: Wed, 3 Apr 2002 09:00:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
cc: VANDROVE@vc.cvut.cz, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen corruption in 2.4.18
In-Reply-To: <20020402224053.14575.qmail@web13107.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020403083605.10671A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, [iso-8859-1] Chris Rankin wrote:

>  --- "Richard B. Johnson" <root@chaos.analogic.com>
> wrote: > On Tue, 2 Apr 2002, Chris Rankin wrote:
> > [SNIPPED...]
> > 
> > > 
> > > A few other things:
> > > - since I have about 1.25 GB of RAM, I have
> > enabled a 256 MB AGP aperture.
> > 
> > What? 'since amount of RAM' has nothing to do with
> > AGP aperature. The
> > aperature should be the same as the amount of AGP
> > shared RAM used for
> > the screen-card on-board graphics. This is normally
> > set by the BIOS but
> > can be reset if the BIOS doesn't 'understand' your
> > screen card.
> > 
> > So, unless you have 256 MB on your screen board,
> > typically 32 MB for
> > high-resolution true-color boards, you will be
> > disabling PCI hardware
> > hand-shaking for a lot of addresses above your
> > screen board. This
> > can make DRAM-controler, controlled RAM accesses
> > interfere.
> 
> I set the AGP aperture based upon the following
> information:
> 
> "The AGP aperture is an area of system RAM reserved
> for use by the AGP card for storing textures if it
> needs to.  The RAM is available for use by the system
> as normal if not used by the graphics card."
> ...
> "It is generally advised to set the AGP aperture to
> half the system RAM ."
> 
> Therefore, it seemed reasonable to maximise my AGP
> aperture size for all and any conceivable textures (I
> have system RAM to spare), with no harm done.
> Admittedly, 256 MB does seem excessive, but anyway ...
> ;-).
> 
> Chris
> 

>From Page 153, "The BIOS COMPANION" ISBN 188967120-7
"The AGP Aperture Size is the amount of system memory for the
AGP card, so host cycles hitting that area are forwarded to that
card without translation..."

This may be causing confusion because it really should read
"amount of system address space". Too many writers interchange
the word "memory" for "address space".

No graphics cards, on their own, or with their own BIOS, use any
"system memory". They can't. They don't "own" any. Of course, when
you run X, X will own some system memory that it allocated via mmap(),
and it uses it in conjunction with your AGP card. The internal RAM
within the AGP card is the only RAM in "owns". This is accessible
to the CPU as well as the card electronics. The address range through
which the CPU can access this high-speed RAM is called the Graphics
Aperture and/or the AGP Aperture.

This is the same thing as (page 139), "VGA Frame Buffer Size"
for the older PCI/VGA boards.

So, if you set your AGP aperture size to overlap address-space where
memory exists, you will probably see streaking and flashing (snow) on
the screen. The bus-contention will also slow your machine during
RAM access and may even cause data corruption in RAM. In other words,
if you have 32 MB of RAM in your screen-card, set the aperture size
to 32 MB, not (!) 256 MB.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

