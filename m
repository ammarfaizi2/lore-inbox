Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290763AbSAYSad>; Fri, 25 Jan 2002 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSAYSa0>; Fri, 25 Jan 2002 13:30:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38416 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290763AbSAYSaH>; Fri, 25 Jan 2002 13:30:07 -0500
Date: Fri, 25 Jan 2002 10:14:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <E16UAxL-0003B6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201251009300.1632-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, Alan Cox wrote:
>
> > I strongly suspected somebody else must have hit this problem before, but
> > intensive research did show up nothing. Also my first post on LK
> > received no "hey, that's old stuff" answer. So here I go.
>
> A tiny patch was posted about 4-6 months ago
>
> The patch is total overkill. Just remove the error reporting if the right
> firmware was already loaded. You've written a fixup wrapper around a
> rather nonsensical erorr check for an existing non-error.

You are making the same mistake I did when I saw the patch.

This is the _MTRR_ setting, not the microcode loading.

They both had the same issues with HT - and the microcode fix was indeed
just to make sure that the microcode hadn't already been loaded (together
with some locking).

The Intel MTRR patch is similar - add some locking, and add some logic to
just not do it on the right CPU (you're _not_ supposed to read to see if
you are writing the same value: MTRR's can at least in theory have
side-effects, so it's not the same check as for the microcode update).

		Linus

