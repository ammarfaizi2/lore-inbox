Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWVJe>; Thu, 23 Nov 2000 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQKWVJX>; Thu, 23 Nov 2000 16:09:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34315 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129097AbQKWVJO>; Thu, 23 Nov 2000 16:09:14 -0500
Date: Thu, 23 Nov 2000 12:38:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
In-Reply-To: <20001123205731.A26914@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10011231235170.1338-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Andi Kleen wrote:
> 
> I am actually not sure if the normal kernel contains even a variable
> width long long shift.

Sure it does. The isofs code contains exctly that:

	block = filp->f_pos >> bufbits;

In fact, almost all filesystems do this at some point. ext2 does it for
directories too, for some very similar reasons that isofs does. See
fs/ext2/dir.c:

	blk = (filp->f_pos) >> EXT2_BLOCK_SIZE_BITS(sb);

(and don't ask me about the extraneous parenthesis. I bet some LISP
programmer felt alone and decided to make it a bit more homey).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
