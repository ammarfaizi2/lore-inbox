Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbQLZGJR>; Tue, 26 Dec 2000 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbQLZGJI>; Tue, 26 Dec 2000 01:09:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18693 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131260AbQLZGI4>; Tue, 26 Dec 2000 01:08:56 -0500
Date: Mon, 25 Dec 2000 21:37:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: "Marco d'Itri" <md@Linux.IT>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001226175057.A12275@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.10.10012252135390.7059-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Dec 2000, Chris Wedgwood wrote:

> On Mon, Dec 25, 2000 at 01:42:33AM -0800, Linus Torvalds wrote:
> 
>     We just don't write them out. Because right now the only thing
>     that writes out dirty pages is memory pressure. "sync()",
>     "fsync()" and "fdatasync()" will happily ignore dirty pages
>     completely. The thing that made me overlook that simple thing in
>     testing was that I was testing the new VM stuff under heavy VM
>     load - to shake out any bugs.
> 
> Does this mean anyone using test13-pre4 should also expect to see
> data not being flushed on shutdown? 

No.

This all only matters to things that do shared writable mmap's.

Almost nothing does that. innd is (sadly) the only regular thing that uses
this, which is why it's always innd that breaks, even if everything else
works.

And even innd is often compiled to use "write()" instead of shared
mappings (it's a config option), so not even all innd's will break.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
