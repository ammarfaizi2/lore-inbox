Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRAQT2k>; Wed, 17 Jan 2001 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135644AbRAQT2e>; Wed, 17 Jan 2001 14:28:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135217AbRAQT2U>; Wed, 17 Jan 2001 14:28:20 -0500
Date: Wed, 17 Jan 2001 11:27:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rick Jones <raj@cup.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A65E825.FFEB194@cup.hp.com>
Message-ID: <Pine.LNX.4.10.10101171104560.9845-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Jones <raj@cup.hp.com> wrote:
>
> : >Agreed -- the hard-coded Nagle algorithm makes no sense these days.
> :
> : The fact I dislike about the HP-UX implementation is that it is so
> : _obviously_ stupid.
> :
> : And I have to say that I absolutely despise the BSD people.  They did
> : sendfile() after both Linux and HP-UX had done it, and they must have
> : known about both implementations.  And they chose the HP-UX braindamage,
> : and even brag about the fact that they were stupid and didn't understand
> : TCP_CORK (they don't say so in those exact words, of course - they just
> : show that they were stupid and clueless by the things they brag about).
> :
> : Oh, well. Not everybody can be as goodlooking as me. It's a curse.
> 
> nor it would seem, as humble :)

Yeah.. Humble is my middle name.

> Hello Linus, my name is Rick Jones. I am the person at Hewlett-Packard
> who drafted the "so _obviously_ stupid" sendfile() interface of HP-UX.
> Some of your critique (quoted above) found its way to my inbox and I
> thought I would introduce myself to you to give you an opportunity to
> expand a bit on your criticism. In return, if you like, I would be more
> than happy to describe a bit of the history of sendfile() on HP-UX.
> Perhaps (though I cannot say with any certainty) it will help explain
> why HP-UX sendfile() is spec'd the way it is.

I do realize why sendfile() is specced like it is: if you don't want to
change the networking layer, it's the obvious way to do it. You can take
just generate an iovec internally in the kernel, and pass that on to an
unmodified networking layer.

Hey, that's the way I'd do it too if I didn't have the ear of the
networking people and could tell them that "Psst! THIS is the right way of
doing this".

The fact that I understand _why_ it is done that way doesn't mean that I
don't think it's a hack. It doesn't allow you to sendfile multiple files
etc without having nagle boundaries, and the header/trailer stuff really
isn't a generic solution.

Sendfile() as done in HP-UX is a performance optimization. Fine. But it's
not exactly pretty. It shouldn't be called "sendfile()", it's more of a
called "send_a_file_and_these_headers_and_those_trailers()" system call.

Also note how I said that it is the BSD people I _despise_. Not The HP-UX
implementation. The HP-UX one is not pretty, but it works. But I hold open
source people to higher standards. They are supposed to be the people who
do programming because it's an art-form, not because it's their job. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
