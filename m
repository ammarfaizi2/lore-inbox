Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQLKIgg>; Mon, 11 Dec 2000 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLKIg0>; Mon, 11 Dec 2000 03:36:26 -0500
Received: from main.cornernet.com ([209.98.65.1]:32010 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S129846AbQLKIgM>; Mon, 11 Dec 2000 03:36:12 -0500
Date: Mon, 11 Dec 2000 02:06:18 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: <clock@atrey.karlin.mff.cuni.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dropping chars on 16550
In-Reply-To: <20001210211445.00733@ghost.btnet.cz>
Message-ID: <Pine.LNX.4.30.0012110202180.5647-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'll find that there is a problem with 2.2.12, on down - with losing a
few bytes here and there.

The bug is in the tty subsystem - in that when you pass off chars to the
ldisc - from the driver, the ldisc doesn't actually write them.  (I could
get into the details, but you probably don't care.)

upgrade to 2.2.17.

It takes care of that bug.

Now. You *NEED* to understand that the way cdrecord does things, is by
sending control codes (lots of them) to your tty, to achieve the "oOoOo"
effect.

9600bps should be okay - on any reasonable system, to NEVER flow control.

But the *MOMENT* you bank on that, you'll get burned.

Set up flow control. if you don't, you're asking for trouble.

Chad

> Hi folks
>
> What should I do, when I run cdda2wav | gogo (riping CD from a ATAPI
> CD thru mp3 encoder) and get a continuous dropping of characters, on a 16550-
> enhanced serial port, without handshake, with full-duplex load of 115200 bps?
> About 1 of 320 bytes is miscommunicated.
>
> The kernel is 2.2.12.
>
> Clock
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
