Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279702AbRJYEPm>; Thu, 25 Oct 2001 00:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279701AbRJYEPc>; Thu, 25 Oct 2001 00:15:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279699AbRJYEPR>; Thu, 25 Oct 2001 00:15:17 -0400
Date: Wed, 24 Oct 2001 21:14:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wWr6-0002wx-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110242111260.9147-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Alan Cox wrote:
>
> Well I don't want my laptop to suspend during a CD burn or firmware update.
> The device itself doesn't know anything about how busy it is since its
> just sending packets, only the subsystem driver controller it does

But that's _your_ problem. Not the kernels.

If you have a acpi deamon that decides to make the machine go to sleep
while burning a CD, that's nothign to do with the kernel at all.

It has nothing to do with sg.c either, for that matter.

> > Remember: the main point of suspend is to have a laptop go to sleep, and
> > come back up on the order of a few _seconds_.
>
> It also has to avoid unpleasant situations

Absolutely NOT.

The kernel does not set policy. If the user says "suspend now", then we
suspend now. Whether a CD burn or anything else is going on is totally
irrelevant.

> There are certain practicalities here with trying to make user space dig
> around in fuser innards or patching every cd burner. The sg layer is one
> that has to get involved (be it as a driver call back or a virtual driver)

Not a way in hell. If the sg layer wants to export a "/proc/sgbusy",
that's its problem.

But if I say "suspend", and the kernel refuses, I will kill the offending
piece of crap from sg.c before you can blink an eye.

		Linus

