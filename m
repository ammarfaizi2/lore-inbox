Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQLFTjE>; Wed, 6 Dec 2000 14:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQLFTiz>; Wed, 6 Dec 2000 14:38:55 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:22291 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130339AbQLFTiv>; Wed, 6 Dec 2000 14:38:51 -0500
Date: Wed, 6 Dec 2000 20:08:03 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
Message-ID: <20001206200803.C847@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001206190850.A847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061033160.1715-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012061033160.1715-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 06, 2000 at 10:38:51AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 10:38:51AM -0800, Linus Torvalds wrote:
> On Wed, 6 Dec 2000, Erik Mouw wrote:
> > So at first the PCI code can't allocate an IRQ for devices 00:00.1
> > (audio), 00:07.2 (USB), and 00:09.0 (winmodem), but after the audio and
> > USB modules get inserted, IRQ 5 and 11 get allocated.
> 
> No, the irq stuff is a two-stage process: at first it only _reads_ the irq
> config stuff for every device - whether they have a driver or not - and at
> this stage it will not ever actually allocate and set up a new route. It
> will just see if a route has already been set up by the BIOS.
> 
> Then, when a driver actually does a pci_enable_device(), it will do the
> second stage of PCI irq routing, which is to actually set up a route if
> none originally existed. So this is why you first se "failed" messages
> (the generic "test if there is a route" code) and then later when loading
> the module you see "allocated irq XX" messages.

Thanks for explaining.

> So your dmesg output looks fine, and everything is ok at that level. The
> fact that something still doesn't work for you indicates that we still
> have problems, of course.
> 
> Can you tell me what device it is that doesn't work for you? 

The USB controller. That's device 00:07.2:

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-  ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at fcc0 [size=32]

I never tried the Winmodem, because I don't need a modem. It came free
with the laptop.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
