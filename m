Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129959AbQJaAr4>; Mon, 30 Oct 2000 19:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbQJaArq>; Mon, 30 Oct 2000 19:47:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2315 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129959AbQJaArb>; Mon, 30 Oct 2000 19:47:31 -0500
Date: Mon, 30 Oct 2000 16:47:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
In-Reply-To: <20001031005740.A17150@caldera.de>
Message-ID: <Pine.LNX.4.10.10010301643300.1789-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Christoph Hellwig wrote:
>
> Old-style Makefiles are playing dirty tricks with defining
> L_TARGET and then using O_TARGET for linking some onjects into
> an intermediate object.

Actually, I think I have an even simpler solution, which is to change the
newstyle rule to something very simple:

	# Translate to Rules.make lists.

	O_OBJS          := $(obj-y)
	M_OBJS          := $(obj-m)
	MIX_OBJS        := $(export-objs)

	# The global Rules.make.

	include $(TOPDIR)/Rules.make

And you're done..

Does anybody see anything wrong with this approach?

It's kin dof cheesy, but I think it should work. The magic is that by
avoiding OX_OBJS and MX_OBJS, we avoid all the sorting issues. We
basically lie, and say that we don't have anything like that.

Then, MIX_OBJS picks up the stragglers, and makes sure that we consider
the proper files to be SYMTAB_OBJS.

This works for me for USB (ie just remove all the stuff with "int-y" and
multi's etc). Does it work for anybody else?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
