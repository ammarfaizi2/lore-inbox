Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279631AbRJXWoo>; Wed, 24 Oct 2001 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279632AbRJXWoh>; Wed, 24 Oct 2001 18:44:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279631AbRJXWmz>; Wed, 24 Oct 2001 18:42:55 -0400
Date: Wed, 24 Oct 2001 15:41:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wWiC-0002uM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110241535150.9019-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Alan Cox wrote:
>
> I don't think it is a big problem. We can add virtual nodes. They way I
> see it we either
> 	a) put in grungy subsystem hacks
> 	b) register virtual device nodes for subsystems when needed
>
> b feels cleaner

I agree. I would personally see us using _more_ "virtual device node"
things already: right now we have things like SuperIO chips that contain
both a serial line and a parallel port (and...), and some drivers do
really ugly things with them - keep them as one "struct pci_dev", and then
have two drivers sharing the device.

It would be much cleaner to have _one_ driver for such SuperIO chips (a
"multinode" driver), which just creates two virtual pci_dev structures,
and lets the regular serial driver handle the "virtual serial device" etc.

That has the advantage of:
 - not needing special hacks in various serial/parallel drivers
 - the devices show up naturally and logically in whatever user mode
   "device m nager" tree

So the device nodes do not have to match the physical tree. The physical
device tree only sets up the initial physical scanning, and obviously
limits _reality_ ;)

		Linus

