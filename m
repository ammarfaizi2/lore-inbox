Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSFIJRW>; Sun, 9 Jun 2002 05:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFIJRV>; Sun, 9 Jun 2002 05:17:21 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:40617 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317468AbSFIJRU>; Sun, 9 Jun 2002 05:17:20 -0400
Date: Sun, 9 Jun 2002 11:17:11 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Peter Osterlund <petero2@telia.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, mochel <mochel@osdl.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
Message-ID: <20020609091711.GA32671@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Peter Osterlund <petero2@telia.com>,
	Alessandro Suardi <alessandro.suardi@oracle.com>,
	linux-kernel@vger.kernel.org, mochel <mochel@osdl.org>
In-Reply-To: <3CFB4DDC.30704@oracle.com> <m2bsaomj1j.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Accept-Language: en; q=1.0, de; q=0.9, ja; q=0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> 
> > In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
> >   in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:
> 
> Same problem here. My network card isn't seen either by the kernel in
> 2.5.20. If it's still broken in 2.5.21, maybe I'll try to fix it.

This oneliner fixes it for me, but I don't know if that's the right fix:

--- linux-2.5.20/drivers/pcmcia/cardbus.c	Sat May 25 03:55:22 2002
+++ linux-2.5.20/drivers/pcmcia/cardbus.c	Sun Jun  9 02:27:35 2002
@@ -284,6 +284,7 @@
 		dev->dev.parent = bus->dev;
 		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
+		dev->dev.bus = &pci_bus_type;
 		device_register(&dev->dev);
 
 		/* FIXME: Do we need to enable the expansion ROM? */

-- 
Tobias								PGP: 0x9AC7E0BC
