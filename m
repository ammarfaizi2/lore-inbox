Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279736AbRJYJsr>; Thu, 25 Oct 2001 05:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279735AbRJYJsg>; Thu, 25 Oct 2001 05:48:36 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:35333 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279736AbRJYJs0>; Thu, 25 Oct 2001 05:48:26 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 11:47:04 +0200
Message-Id: <20011025094704.11412@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0110250224340.1128-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110250224340.1128-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Or another fun common one.  To shut down the interrupt controller, I first
>> need to shut down every device that thinks it can generate interrupts.
>> But my interrupt controller is way out on my pci->isa bridge.  So I
>> can't shut that device down.
>>
>> Sorry this whole device tree idea for shutdown ordering doesn't seem
>> to match my idea of reality.
>
>Your _examples_ do not match any reality.
>
>Don't worry about things like the CPU shutdown: you have to have special
>code for it anyway.
>
>Let's face it, the device tree is for _devices_. It's for shutting down a
>network card before we shut down the PCI bridge that is in front of it.
>
>The issue of "core shutdown" is not covered - and isn't _meant_ to be
>covered. That's the problem of the architecture-specific code. There is no
>point in having a device tree for that, because it's going to be very much
>architecture-specific anyway (ie on x86 we may have to just blindly trust
>some silly APCI table data etc).

Definitelly. I have similar issues with pmacs, clocks generation
and interrupt controller are in Apple's mac-io ASIC which is on PCI,
so this ASIC can't be part of the normal PM tree and has to be handled
as part of the "core" PM code. This kind of issue will still happen, the
new scheme won't "magically" make PM work on every single laptop out
there, there will still be some corner cases to deal with, but at least
these will be limited to real corner cases and most "normal" drivers
will fit in the new, saner, mecanism.

Ben.


