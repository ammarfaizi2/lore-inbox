Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRATT1j>; Sat, 20 Jan 2001 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbRATT12>; Sat, 20 Jan 2001 14:27:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63494 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129729AbRATT1S>; Sat, 20 Jan 2001 14:27:18 -0500
Date: Sat, 20 Jan 2001 11:26:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <200101201853.VAA05120@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.10.10101201124090.10317-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001 kuznet@ms2.inr.ac.ru wrote:
> > Actually, as long as there is no "struct page" there _are_ problems.
> > This is why the NUMA stuff was brought up - it would require that there
> > be a mem_map for the PCI pages.. (to do ref-counting etc).
> 
> I see.
> 
> Is this strong "no-no-no"? What is obstacle to allow "struct page"
> to sit outside of mem_map (in some private table, or as full orphan)?
> Only bloat of struct page with reference to some "page_ops" or something
> more profound?

There's no no-no here: you can even create the "struct page"s on demand,
and create a dummy local zone that contains them that they all point back
to. It should be trivial - nobody else cares about those pages or that
zone anyway.

This is very much how the MM layer in 2.4.x is set up to work.

That said, nobody has actually done this in practice yet, so there may be
details to work out, of course. I don't see any fundamental reasons it
wouldn't easily work, but..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
