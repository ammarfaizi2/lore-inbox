Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279416AbRJWM5G>; Tue, 23 Oct 2001 08:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279415AbRJWM44>; Tue, 23 Oct 2001 08:56:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279416AbRJWM4r>; Tue, 23 Oct 2001 08:56:47 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: mochel@osdl.org (Patrick Mochel)
Date: Tue, 23 Oct 2001 08:53:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@Elf.ucw.cz (Pavel Machek),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110221726140.25103-100000@osdlab.pdx.osdl.net> from "Patrick Mochel" at Oct 22, 2001 05:29:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vwNB-00050h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea is to allocate all memory in the first pass, disable interrupts,
> then save state. Would that work? Or, should some of the state saving take
> place with interrupts enabled?

Imagine the state saving done on a USB device. There you need interrupts
on while retrieving the state from say a USB scanner, and in some cases
off while killing the USB controller.

> > Ditto on return from suspend where some devices also like to float the irq
> > high as you take them over (eg USB on my Palmax). From comments Ben made
> > ages back I believe ppc has similar issues if not worse
> 
> Yes, the resume sequence is broken into two stages:
> 
> 	device_resume(RESUME_POWER_ON);
> 
> 	/* enable interrupts */
> 
> 	device_resume(RESUME_RESTORE_STATE);
> 
> Do you see a need to break it up further?

Nope.
