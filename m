Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290079AbSAWU46>; Wed, 23 Jan 2002 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290080AbSAWU4u>; Wed, 23 Jan 2002 15:56:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290079AbSAWU4n>; Wed, 23 Jan 2002 15:56:43 -0500
Date: Wed, 23 Jan 2002 15:56:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ertzog <ertzog@bk.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: hot IDE change
In-Reply-To: <Pine.LNX.4.21.0201232301090.1053-100000@dial-up-2.energonet.ru>
Message-ID: <Pine.LNX.3.95.1020123153408.435A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, ertzog wrote:

> This question is more about hardware, but is also related to Linux.
> If I have a harddisk, plugged into the motherboard (IDE cable and power),
> can I turn it off, plugging out first power cable, then IDE cable.
> Can it harm harddisk or motherboard?
> If I can do it, then will Linux detect it back, if I make this 
> operation back: i.e. plug IDE cable, then power cable.
> 
> Best regards.
> 

Linux doesn't care as long as it has been dismounted.

BUT! When you remove power to the drive by pulling its plug, you
are now pulling all those bits low. The IDE interface is just a
transceiver. The controller is in the drive. You may have just
glitched or crashed a bus. This may eventually cause an OOPS or
just make the machine stop.

So, you decide to pull the IDE cable first. Well, if you made
sure that all active bits were disconnected at the same time,
(grin), maybe you can get away with it.

Next stop. Now you have to pull out the power plug making sure
that the ground pins are not disconnected before either of the
voltages, and the two voltages are removed at the same time.
Failure to do this can (read will) generate spurious writes to
the disk media.

Now, do you want to plug in another drive? If the five-volts
isn't present before the +12V, you may back-feed the 5-volt
logic through its protection diodes. If this generates enough
voltage to start up the electronics, you can end up with
strange states that may prevent the disk from ever starting.
This can burn out the transistors that drive the pancake-motor
winding.

I certainly suggest that you turn off the power before you
muck with IDE drives. SCSI is different. It's message-based.
There is no physical connection to your PC's internals, only
logical. With robust SCSI controllers, designed for hot-swapping,
you don't have to worry. Even non-hot-swappable drives and
controllers can survive lots of power-on activity. It is, however,
possible to permanently damage a SCSI disk if you connect the
power plug in such a way that the +12 volts (the yellow wire) makes
a connection first before the +5 volts. Hot-swap trays and connectors
prevent this.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


