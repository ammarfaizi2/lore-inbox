Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131177AbQLJQuL>; Sun, 10 Dec 2000 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQLJQuC>; Sun, 10 Dec 2000 11:50:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131177AbQLJQto>; Sun, 10 Dec 2000 11:49:44 -0500
Date: Sun, 10 Dec 2000 08:19:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012100707.CAA17906@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.10.10012100814230.2635-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2000, Theodore Y. Ts'o wrote:
> 
>    You should also just test having it compiled in - I know some people love
>    modules, but there is nothing quite as liberating as just having a kernel
>    that finds the devices it needs and doesn't need anything else.
> 
> Interesting.  Yup, the serial driver works with it compiled in.

Ho humm.. Why wouldn't it work as a module? Strange.

Are you sure cardmgr inserts the right module? If cardmgr tries to insert
serial_cb, and you have warring drivers, you'll break. 

Oh, serial_cb shouldn't work anyway, I think.

> However, the epic driver fails after I eject and remove the card, and
> then re-insert it (it hangs on the re-insertion).  It looks like a
> deadlock; after it hangs, "ifconfig" also hangs, presumably waiting on
> the same lock (ps alx reports it's waiting on "down").

This is almost certainly the silly hotplug issue that we have - there's a
problem with execin'g /sbin/hotplug and the semaphore that protects the
device state. That will be fixed in the next patch..

> In any case, I think I know how to fix the serial driver to not loop in
> receive_chars().  If I get this working, do you want to take a serial
> driver update now or post 2.4.0?

Pls do it now, this is only going to clean it up (I bet we'll also be able
to remove some of the serial.c PCI device lists, because many of them
probably work with the general "is this a serial device?" test and do not
need to be explicitly listed).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
