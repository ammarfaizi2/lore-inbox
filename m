Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbQJ3XlP>; Mon, 30 Oct 2000 18:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQJ3XlF>; Mon, 30 Oct 2000 18:41:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47368 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129807AbQJ3Xkz>; Mon, 30 Oct 2000 18:40:55 -0500
Date: Mon, 30 Oct 2000 15:40:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
In-Reply-To: <200010302332.AAA15959@ns.caldera.de>
Message-ID: <Pine.LNX.4.10.10010301536340.3595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Christoph Hellwig wrote:
> 
> It is simple - but a change in _every_ makefile is required.
> And it is not really needed for old-style makefiles.

Actually, you don't have to change every makefile, because you CAN do this
all with a simple backwards-compatibility layer, something like:

	OXONLY = $(filter-out $(O_OBJS), $(OX_OBJS))
	ALL_O = $(OXONLY) $(O_OBJS)

which is a no-op for a "proper" makefile that follows the new rules
(OXONLY will be empty, because all OX_OBJS files will be part of O_OBJS),
but it will make old-style stuff act the same..

I'd actually prefer to just change every Makefile, but hey, I think
something like the above (untested) would make them work unmodified too.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
