Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284289AbRLRRSU>; Tue, 18 Dec 2001 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284302AbRLRRSK>; Tue, 18 Dec 2001 12:18:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284289AbRLRRSC>; Tue, 18 Dec 2001 12:18:02 -0500
Date: Tue, 18 Dec 2001 09:16:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-audio-dev@music.columbia.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <200112181619.fBIGJBv13914@maila.telia.com>
Message-ID: <Pine.LNX.4.33.0112180910270.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Roger Larsson wrote:
>
> Lets see: we have >1 GHz CPU and interrupts at >1000 Hz
>  => 1 Mcycle / interrupt - is that insane?

Ehh.. First off, the CPU may be 1GHz, but the memory subsystem, and the
PCI subsystem definitely are _not_. Most PCI cards still run at a
(comparatively) leisurely 33MHz, and when we're talking about audio, we're
talking about actually having to _access_ that audio device.

Yes. At 33MHz, not at 1GHz.

Also, at 32-byte fragments, the frequency is actually 5.5kHz, not 1kHz.
Now, I seriously doubt the mp3-player actually used 32-byte fragments (it
probably just asked for something small, and got it), but let's say it
asked for something in the kHz range (ie 256-512 byte frags). That does
_not_ equate to "1 Mcycle". It equates to 33 _kilocycles_ in PCI-land, and
a PCI read will take several cycles.

> If the hardware can support it? Why not let it? It is really up to the
> applications/user to decide...

Well, this particular user was unhappy with the CPU spending a noticeably
amount of time on just web-surfing and mp3-playing.

So clearly the _user_ didn't ask for it.

And I suspect that the app writer just didn't even realize what he did. He
may have used another sound card that didn't even allow small fragments.

		Linus

