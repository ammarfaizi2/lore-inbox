Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbQJaNzw>; Tue, 31 Oct 2000 08:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQJaNzm>; Tue, 31 Oct 2000 08:55:42 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:35338 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129942AbQJaNz0>; Tue, 31 Oct 2000 08:55:26 -0500
Date: Tue, 31 Oct 2000 07:55:06 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Keith Owens <kaos@ocs.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
Message-ID: <20001031075506.B1041@wire.cadcamlab.org>
In-Reply-To: <13675.972956952@ocs3.ocs-net> <Pine.LNX.4.10.10010301856330.6384-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10010301856330.6384-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 30, 2000 at 06:58:38PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [kaos]
> > It still does not document the only real link order constraint in
> > USB.  The almost complete lack of documentation on which link
> > orders are required and which are historical is extremely annoying
> > and _must_ be fixed, instead we just propagate the problem.

[Linus]
> We can add a comment to the Makefile. That's trivial.

True.

The thing that Keith's patch does is flush these things out into the
open.  By using LINK_FIRST/LINK_LAST, we declare that "these are the
known issues" -- and then the rest of the objects are reordered, and if
something breaks, we track it down and add it to LINK_FIRST.

That way these things *will* get documented eventually.  I have very
little hope that they otherwise will, since some ordering requirements
may have already been lost to the mists of time.

Obviously, "flushing issues out into the open" is not 2.4 material,
which is why Keith's patch does *not* reorder unless you explicitly
declare a LINK_FIRST line -- i.e. only drivers/usb/Makefile is affected
at the moment.  The plan has been to change that behavior in 2.5.

> What's not trivial, and what I WANT DONE is to make sure that _when_
> somebody wants to maintain link ordering, he can do so in an easy and
> obvious way. Not with Yet Another Hack.

One man's hack is another man's clean design ... but I concede the
point that LINK_FIRST is a hack, because I respect your judgment.
However, I still maintain that it is a less ugly hack than any
alternatives I've seen for preventing/removing duplicate object files
in link lines (see my last mail).

A few months ago I actually tried to write a make function (yes, GNU
make has these!) to remove duplicates while not sorting, but GNU make
doesn't seem to support the necessary iteration/(tail-)recursion
features.  (Surprising, considering GNU's overall LISP-ish worldview.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
