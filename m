Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbREYSFr>; Fri, 25 May 2001 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbREYSFh>; Fri, 25 May 2001 14:05:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:63498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261374AbREYSF1>; Fri, 25 May 2001 14:05:27 -0400
Date: Fri, 25 May 2001 11:05:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.GSO.4.21.0105251325380.27664-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105251100180.949-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 May 2001, Alexander Viro wrote:
> 
> OK, here's a real-world scenario: inode table on 1Kb ext2 (or 4Kb on
> Alpha, etc.) consists of compact pieces - one per cylinder group.
> 
> There is a natural mapping from inodes to offsets in that beast.
> However, these pieces can trivially be not page-aligned. readpage()
> on a boundary of two pieces means large seek.

Yes.

But by "real-world" I mean "you can tell in real life".

I see the theoretical arguments for it. But I want to know that it makes a
real difference under real load.

For example, I suspect that the metadata bitmaps in particular cache so
well that the fact that we need to do several seeks over them every once
in a while is a non-issue: we might be happier having the bitmaps in
memory (and having simpler code), than try to avoid the occasional seeks.

The "simpler code" argument in particular is, I think, a fairly strong
one. Our current bitmap code is quite horrible, with multiple layers of
caching (ext2 will explicitly hold references to some blocks, while at the
same time depending on the buffer cache to cache the other blocks -
nightmare)

		Linus

