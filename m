Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRJ3RGp>; Tue, 30 Oct 2001 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280025AbRJ3RGf>; Tue, 30 Oct 2001 12:06:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:37136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280001AbRJ3RGS>; Tue, 30 Oct 2001 12:06:18 -0500
Date: Tue, 30 Oct 2001 18:06:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030180616.M1340@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain> <Pine.LNX.4.33.0110300839360.8603-200000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110300839360.8603-200000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 08:52:58AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:52:58AM -0800, Linus Torvalds wrote:
> So in the short range, I haven't come up with any really good approaches,
> but I suspect I'll just have to move the shrink_[di]cache() back to the
> caller, which will at least shrink them on swapouts (a bit too much, I
> think, but on the other hand maybe not).

Agreed.

It is still interesting to hear if it makes a big performance differece
under swap though. In particular it would be very nice to keep inodes
with pagecache in it out of the unused-inode-list, but it would need
additional bitkeeping in inode.c.

I'm also wondering why you dropped the early-cow for the write swapins,
just to avoid managing the anon pages in the lru in do_swap_page and to
have the logic only in once place? I kept the early-cow logic so I only
get 1 page fault for every write-swapped-in pages.

Andrea
