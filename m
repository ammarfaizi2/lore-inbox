Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129735AbQK2FkQ>; Wed, 29 Nov 2000 00:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129823AbQK2FkG>; Wed, 29 Nov 2000 00:40:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44550 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129735AbQK2Fj6>; Wed, 29 Nov 2000 00:39:58 -0500
Date: Tue, 28 Nov 2000 21:09:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <UTC200011290408.FAA151004.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011282105040.5871-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:
>
> I did again a large test comparing two identical trees.
> Found again corruption, and, upon inspection, the disk
> files did not differ - this is in-core corruption only.

Ok. It definitely looks like the 1kB thing has become broken somehow. 

The fact that it is in-core only doesn't mean that much - it could still
easily be just problems at read-time, and if you have an IDE disk I would
strongly suggest you try out the patch that Jens Axboe posted,
re-initializing the "head" pointer when doing a re-merge.

That said, the VM/ext2 angle should definitely be looked at too. Nothing
has really changed there in some time - can you give a rough estimate on
when you suspect you started seeing it? Ie is it new to one of the test11
pre-kernels, or does it happen so occasionally that you can't tell whether
it happened much earlier too?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
