Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSDDQmm>; Thu, 4 Apr 2002 11:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313255AbSDDQmd>; Thu, 4 Apr 2002 11:42:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37305 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313254AbSDDQmO>;
	Thu, 4 Apr 2002 11:42:14 -0500
Date: Thu, 4 Apr 2002 11:42:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet>
Message-ID: <Pine.GSO.4.21.0204041120270.22660-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Apr 2002, Tigran Aivazian wrote:

> On Thu, 4 Apr 2002, Alan Cox wrote:
> > > exported only "internally". But that is their own problem -- we should
> > > neither help them nor prevent them from doing their work and earning their
> >
> > So why are you trying to put me out of business by allowing people to use
> > my code in ways the GPL doesn't permit. That cuts both ways.
> 
> That would be the case _only_ under yet another interpretation of GPL.
> Strange thing about GPL is that there are so many interpretations to
> choose from :)
> 
> It is your interpretation that matters, not mine, so how can I convince
> you? But I am entitled to an opinion that your interpretation is, in some
> sense, wrong. Namely, in the sense that it is inconsistent with the
> similar situation in the case of libraries or even system calls. I don't
> see why exporting kernel symbols should be so radically different and
> extremely sensitive to the nature of the consumer's license for some
> symbols but not for others...


Because we don't _HAVE_ an API, let alone ABI.  What we have is 4000-odd
more or less randomly selected functions and variables that had been used
by some module at some point of history.

It's not an interface, it's a wide-open gut wound.  Yes, set of syscalls
is also too large and chaotic, but it's nowhere near that bad.

Situation in the tree itself is also not pretty, but there we at least
can do global changes.  With external stuff we don't have that, but
we can say "recompile and go ahead" - it reduces the set of changes we
can do without breakage, though.   With external binary stuff, we
are fucking stuck - a lot of things _will_ break it.

Again, that wouldn't be a problem if we had a well-defined interface.
We don't.

Moreover, "well-defined" includes mechanisms in place that would resist
changes and prevent adding random stuff to the interface.  Again, no
such thing.

And that's the real problem.  If we can turn the thing into stable _sane_
API (and that will mean changes in 3rd-party code and a *lot* of resistance
from binary-only module authors) - wonderful.  Until that happens any
talk about kernel/module boundary is crap.  There's none.  "You are allowed
to use this API without making your work a derivative" is all nice and
dandy.  When there is something that resembles an API.

