Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130019AbQJaC66>; Mon, 30 Oct 2000 21:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbQJaC6t>; Mon, 30 Oct 2000 21:58:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2319 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130019AbQJaC6m>; Mon, 30 Oct 2000 21:58:42 -0500
Date: Mon, 30 Oct 2000 18:58:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: <13675.972956952@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10010301856330.6384-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Keith Owens wrote:
> 
> You will compile all export objects, whether they are configured or
> not.  The "obvious" fix does not work.
> 
> 	MIX_OBJS        := $(filter $(export-objs),$(obj-y) $(obj-m))
> 
> export_objs contains usb.o, obj-y contains usb_core.o, it does not
> contain usb.o.  Multi lists in obj-y and obj-m need to be expanded
> while preserving the required link order (which is where we came in).

No. We can expand multi-lists at ANY OTHER POINT than O_OBJS. That's ok.
It's only O_OBJS that has any ordering issues.

And we just shouldn't use OX_OBJS at all, as that breaks ordering _and_
can be done equally well with MIX_OBJS instead.

> It still does not document the only real link order constraint in USB.
> The almost complete lack of documentation on which link orders are
> required and which are historical is extremely annoying and _must_ be
> fixed, instead we just propagate the problem.

We can add a comment to the Makefile. That's trivial.

What's not trivial, and what I WANT DONE is to make sure that _when_
somebody wants to maintain link ordering, he can do so in an easy and
obvious way. Not with Yet Another Hack.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
