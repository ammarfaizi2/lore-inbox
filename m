Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290805AbSAYU4L>; Fri, 25 Jan 2002 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290806AbSAYU4B>; Fri, 25 Jan 2002 15:56:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290805AbSAYUzy>; Fri, 25 Jan 2002 15:55:54 -0500
Date: Fri, 25 Jan 2002 12:40:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <E16UBUl-0003J9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201251237470.1871-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, Alan Cox wrote:
> As Dave pointed out I was mixing them
>
> > just not do it on the right CPU (you're _not_ supposed to read to see if
> > you are writing the same value: MTRR's can at least in theory have
> > side-effects, so it's not the same check as for the microcode update).
>
> So why not just set it twice - surely that is harmless ? Why add complex
> code ?

At the _least_ you have to serialize the thing, which is most of what the
patch actually does. Writing the MTRR's in parallel from two different
cores at the same time is just obviously bogus, the same way it is
obviously bogus to try to update the microcode at the same time.

		Linus

