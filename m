Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266476AbRGJO5x>; Tue, 10 Jul 2001 10:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbRGJO5n>; Tue, 10 Jul 2001 10:57:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7778 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266476AbRGJO52>; Tue, 10 Jul 2001 10:57:28 -0400
Date: Tue, 10 Jul 2001 16:56:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.7-pre hurts...
Message-ID: <20010710165637.B15734@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107092112180.10220-100000@penguin.transmeta.com> <20010710074315.N1594@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710074315.N1594@athlon.random>; from andrea@suse.de on Tue, Jul 10, 2001 at 07:43:15AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 07:43:15AM +0200, Andrea Arcangeli wrote:
> My first arguments about "overkill" were for async I/O and kiobufs, where
> the race cannot trigger. Mainly for the kiobufs I/O I'm still not very
> convinced.

another issue is that I don't see any value in defining the
unlock_buffer() with the get_bh/put_bh in it. The get_bh over there is
just useless because we don't have the memory barriers in the get_bh and
try_to_free_buffer paths, that's what party fooled me last night in
thinking we didn't need to get_bh in the implicit synchronization point
but that using unlock_buffer (with the get_bh in it was enough), otherwise
unlock_buffer would been pointless (and infact now it sorted out it is
as far I can tell ;).

So I'd kill unlock_buffer and replace it with __unlock_buffer.

Andrea
