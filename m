Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbQLVBJE>; Thu, 21 Dec 2000 20:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbQLVBIz>; Thu, 21 Dec 2000 20:08:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131392AbQLVBIk>; Thu, 21 Dec 2000 20:08:40 -0500
Date: Thu, 21 Dec 2000 16:37:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Niehusmann <jan@gondor.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
In-Reply-To: <20001222010334.A984@gondor.com>
Message-ID: <Pine.LNX.4.10.10012211634440.945-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Dec 2000, Jan Niehusmann wrote:
> 
> This is the result - against test12-pre7, but works well with 
> test13-pre3:

This looks bogus.

You can't test "bh->b_next!=0", because that is entirely meaningless.

b_next can be NULL either because the buffer isn't hashed, or because the
buffer _is_ hashed, but just happens to be last on the hash chain.

So testing "bh->b_next" doesn't actually tell you anything at all.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
