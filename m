Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284334AbRLRR3K>; Tue, 18 Dec 2001 12:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284337AbRLRR3A>; Tue, 18 Dec 2001 12:29:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12303 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284334AbRLRR2s>; Tue, 18 Dec 2001 12:28:48 -0500
Date: Tue, 18 Dec 2001 09:27:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Mansfield <david@cobite.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin>
Message-ID: <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, David Mansfield wrote:
> >
> > 	audio_devs[devc->dev]->min_fragment = 5;
> >
>
> Generally speaking, you want to be able to specify about a 1ms fragment,
> speaking as a realtime audio programmer (no offense Victor...).  However,
> 1ms is 128 bytes at 16bit stereo, but only 32 bytes at 8bit mono.  Nobody
> does 8bit mono, but that's probably why it's there.  A lot of drivers seem
> to have 128 byte as minimum fragment size.

Good point.

Somebody should really look at "dma_set_fragment", and see whether we can
make "min_fragment" be really just a hardware minimum chunk size, but use
other heuristics like frequency to cut off the minimum size (ie just do
something like

	/* We want to limit it to 1024 Hz */
	min_bytes = freq*channel*bytes_per_channel >> 10;

Although I'm not sure we _have_ the frequency at that point: somebody
might set the fragment size first, and the frequency later.

Maybe the best thing to do is to educate the people who write the sound
apps for Linux (somebody was complaining about "esd" triggering this, for
example).

		Linus

