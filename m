Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbQLHT1B>; Fri, 8 Dec 2000 14:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbQLHT0w>; Fri, 8 Dec 2000 14:26:52 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:5901 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S131459AbQLHT0i>; Fri, 8 Dec 2000 14:26:38 -0500
Date: Fri, 8 Dec 2000 13:56:49 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] for YMF PCI sound cards
In-Reply-To: <200012081831.KAA06813@ns1.metabyte.com>
Message-ID: <Pine.LNX.4.30.0012081343160.957-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pete!

> The idea of the patch looks good but there is a small problem.
> I have an open/close fix queued with Alan for post-2.2.18,
> which changes the enumeration scheme for ymfcpi to make it
> more friendly to other sound cards (Bug from Abhijit Menon-Sen).
> This is a conflict because you use instance number to find
> what card goes in first. In fact I plan to send the same
> thing to Linus for 2.4 (if he have not fixed that already).

Ok, I'm not a good kernel hacker. I simply did what I believed would be
the behaviour that minimizes the number of gotchas for the end user. If
the instance number isn't reliable then drop it and initialize OPL for all
cards.

The users of multiple cards will have to supply synth_io, but I wouldn't
fight to save few keystrokes for the insane people with more than one YMF
soundcard :-)

> Would you please to hold on to your patch for couple of weeks
> and then resync and redo it? Alternatively, I'll keep your
> patch and will reapply it in the way I see sane, but you will
> have to retest it before I issue it.

The later is better. I never know whether I'll have a free minute in a
couple of weeks.

> > +	{0x41445303, "Yamaha YMF????"          , NULL},
>
> Are you sure it's correct? I am almost certain that no YMFxxx
> has on-chip AC97. I'd like to see a document that allows you
> the change quoted above.

I have no documents, only the log from the patched module:

Dec  8 13:29:35 fonzie kernel: ymfpci0: YMF740C at 0xf0000000 IRQ 10
Dec  8 13:29:35 fonzie kernel: ymfpci0: set OPL3 I/O at 0x388
Dec  8 13:29:36 fonzie kernel: ac97_codec: AC97 Audio codec, id:
0x4144:0x5303 (Yamaha YMF????)

Drop it if it's not convincing.

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
