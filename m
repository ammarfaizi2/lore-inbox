Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3Xw6>; Mon, 30 Oct 2000 18:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQJ3Xwt>; Mon, 30 Oct 2000 18:52:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129053AbQJ3Xwl>; Mon, 30 Oct 2000 18:52:41 -0500
Date: Mon, 30 Oct 2000 15:51:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
In-Reply-To: <20001031004500.A16524@caldera.de>
Message-ID: <Pine.LNX.4.10.10010301548150.3595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Christoph Hellwig wrote:
> 
> But when we are changing makefiles everywhere - why not do the proper think
> and let the new-style makefiles share their code?
> 
> (I have a patch ready - it just needs some forward-porting and testing)

I hate your patch.

I'd rather see "Rules.make" just base itself entirely off the new-style
Makefiles, and have it use "$(obj-y)" instead of O_OBJS etc.

Then, _old_style Makefiles could be fixed up by doing a

	include Compat.make

or preferably by just fixing them. I don't want to have another
Rules.make. I want to fix the old users.

(Compat.make would then look like

	obj-y = $(OX_OBJS) $(O_OBJS)
	export-objs = $(OX_OBJS)
	...

and make _old_ Makefiles look like new ones as far as Rules.make is
concerned.

See? 

This is the same as with source code. I do NOT want to have backwards
compatibility in source code - if compatibility is needed, I'd much rather
have it be _forwards_ compatibility, where the old setup is made to look
like the new with wrapper functions etc.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
