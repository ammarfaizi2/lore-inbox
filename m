Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbREYSZO>; Fri, 25 May 2001 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbREYSZE>; Fri, 25 May 2001 14:25:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34706 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261422AbREYSYx>;
	Fri, 25 May 2001 14:24:53 -0400
Date: Fri, 25 May 2001 14:24:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.LNX.4.21.0105251100180.949-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105251415400.27664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Linus Torvalds wrote:

> For example, I suspect that the metadata bitmaps in particular cache so
> well that the fact that we need to do several seeks over them every once
> in a while is a non-issue: we might be happier having the bitmaps in
> memory (and having simpler code), than try to avoid the occasional seeks.
>
> The "simpler code" argument in particular is, I think, a fairly strong
> one. Our current bitmap code is quite horrible, with multiple layers of
> caching (ext2 will explicitly hold references to some blocks, while at the
> same time depending on the buffer cache to cache the other blocks -
> nightmare)

Oh, current code is a complete mess - no arguments here. 8-element LRU.
Combined with the fact that directories allocation tries to get even
distribution of directory inodes by cylinder groups, you blow that LRU
completely on a regular basis if your fs is larger that 16 cg. For 1Kb
blocks fs it's 128Mb. For 4Kb - 2Gb. And pain starts at the half of that
size.

If you are OK with adding two extra arguments to ->readpage() I could
submit a patch replacing that with plain and simple page cache by tomorrow.
It should not be a problem to port, but I want to get some sleep before
testing it...

