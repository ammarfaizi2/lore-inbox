Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131220AbQLMPHy>; Wed, 13 Dec 2000 10:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbQLMPHo>; Wed, 13 Dec 2000 10:07:44 -0500
Received: from main.cornernet.com ([209.98.65.1]:60420 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S131220AbQLMPHd>; Wed, 13 Dec 2000 10:07:33 -0500
Date: Wed, 13 Dec 2000 08:37:11 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Mark Orr <markorr@intersurf.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Dropping chars on 16550
In-Reply-To: <Pine.LNX.4.21.0012130211450.31563-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.30.0012130827380.21891-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Heh...do what I did.  Go on eBay and pick up a Hayes ESP card.
>
> Hmm.. High speed comm is fine here, as long is I use handshaking. If I
> don't, I'll loose chars.

there are many situations in which a 16550 is KNOWN to be overrunable, all
of which can occur in your common PPP connection.

More importantly - if you have 2 16550's talking together (Which is
EXACTLY what you have, when you hook it to a modem) there are even MORE
overrun possibilities. (For instance, when you fill the transmitter up to
16 bytes - on a uart, and then the receiving side suddenly drops RTS,
there is *NO* way for that 16550 to stop its transmitter. Once the bytes
are in its fifo, it HAS TO SEND THEM.)

This is where a 654 or an 854 (I'm only listing startech design chips.
there are others that would do the job.)  come in handy. They can pause
their transmitter WITH bytes in their fifo. (Automated hardware/software
flow control.)

I have no idea why the 16550 caught on as the "De facto standard" like it
did. there are UARTS out there that are more efficient, yet cost only a
few dollars more to manufacture.

(Your common QUAD 16654 chip costs $20 to an end user, nowadays. Your
common QUAD 16554 costs about $15.)

Imagine what the 2-UART chips would cost. (or, mass-produced all-in-1
sets even.)

Really makes you think.

Chad

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
