Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284283AbRLRRJK>; Tue, 18 Dec 2001 12:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284289AbRLRRJA>; Tue, 18 Dec 2001 12:09:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17422 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284283AbRLRRIt>; Tue, 18 Dec 2001 12:08:49 -0500
Date: Tue, 18 Dec 2001 09:07:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <200112181429.fBIETsf15577@pinkpanther.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0112180901250.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Alan Cox wrote:
>
> > at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
> > in less than 1/100th of a second, but at least it should be < 200 irqs/sec
> > rather than >400).
>
> With a few exceptions the applications tend to use 4K or larger DMA chunks
> anyway. Very few need tiny chunks.

Doing another grep seems to imply that none of the other drivers even
allow as small chunks as the sb driver does, 32 byte "events" is just
ridiculous. At simple 2-channel, 16-bits, CD-quality sound, that's a DMA
event every 0.18 msec (5500 times a second, 181 _micro_seconds appart).

I obviously agree that the app shouldn't even ask for small chunks:
whether a mp3 player reacts within 1/10th or 1/1000th of a second of the
user asking it to switch tracks, nobody can even tell. So an mp3 player
should probably use a big fragment size on the order of 4kB or similar
(that still gives max fragment latency of 0.022 seconds, faster than
humans can react).

So it sounds like a player sillyness, but I don't think the driver should
even allow such waste of resources, considering that no other driver
allows it either..

			Linus

