Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279738AbRJYJbo>; Thu, 25 Oct 2001 05:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279736AbRJYJbe>; Thu, 25 Oct 2001 05:31:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279735AbRJYJbW>; Thu, 25 Oct 2001 05:31:22 -0400
Date: Thu, 25 Oct 2001 02:29:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <m1zo6gm6rh.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0110250224340.1128-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Oct 2001, Eric W. Biederman wrote:
>
> Or another fun common one.  To shut down the interrupt controller, I first
> need to shut down every device that thinks it can generate interrupts.
> But my interrupt controller is way out on my pci->isa bridge.  So I
> can't shut that device down.
>
> Sorry this whole device tree idea for shutdown ordering doesn't seem
> to match my idea of reality.

Your _examples_ do not match any reality.

Don't worry about things like the CPU shutdown: you have to have special
code for it anyway.

Let's face it, the device tree is for _devices_. It's for shutting down a
network card before we shut down the PCI bridge that is in front of it.

The issue of "core shutdown" is not covered - and isn't _meant_ to be
covered. That's the problem of the architecture-specific code. There is no
point in having a device tree for that, because it's going to be very much
architecture-specific anyway (ie on x86 we may have to just blindly trust
some silly APCI table data etc).

		Linus

