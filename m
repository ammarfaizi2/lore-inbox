Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbQJaCzj>; Mon, 30 Oct 2000 21:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130019AbQJaCz2>; Mon, 30 Oct 2000 21:55:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130007AbQJaCzQ>; Mon, 30 Oct 2000 21:55:16 -0500
Date: Mon, 30 Oct 2000 18:54:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
In-Reply-To: <20001031020154.A20703@caldera.de>
Message-ID: <Pine.LNX.4.10.10010301852550.6384-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Christoph Hellwig wrote:
> > newstyle rule to something very simple:
> > 
> > 	# Translate to Rules.make lists.
> > 
> > 	O_OBJS          := $(obj-y)
> > 	M_OBJS          := $(obj-m)
> 
> This will destroy one nice feature of list-style makefiles:
> when you have and object both in obj-y and obj-m it will be removed
> from obj-m with the old boiler-plates, not with your proposal.

Ok. That's fine, the "obj-m" thing doesn't have any ordering constraints,
so we can do whatever we want to it. Including the $(filter-out ..) thing.

> > 	MIX_OBJS        := $(export-objs)
> 
> The MIX_OBJS change is wrong.  It may not hurt the resulting
> kernel image but you will build all export-objs, not only the
> ones you actually have selected.  But we might get around this
> with some $(filter ...) magic.

Yes. That's fine, again MIX_OBJS does not care about ordering, so
filtering etc is fine here.

The only thing I really care about is O_OBJS = $(obj-y), and with this
setup it seems to be a valid thing to do, with some slight hackery on the
other ones.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
