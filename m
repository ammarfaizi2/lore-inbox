Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRJ3STv>; Tue, 30 Oct 2001 13:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRJ3STd>; Tue, 30 Oct 2001 13:19:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9822 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277338AbRJ3STY>; Tue, 30 Oct 2001 13:19:24 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <Pine.LNX.4.33.0110300917520.8603-100000@penguin.transmeta.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 30 Oct 2001 11:05:29 -0700
In-Reply-To: <Pine.LNX.4.33.0110300917520.8603-100000@penguin.transmeta.com>
Message-ID: <m1heshhul2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> HOWEVER, _then_ I started wondering about whether the thing needs to be
> removed from the swap cache at all, and came to the conclusion that for
> the only case we really care about (and the only case where we _can_
> re-use the swap cache page), we don't actually need to remove it from the
> cache in the first place.

There is a second case, though you may be handling it differently now.
Typically the case is swap < RAM.  But basically when we don't have
enough have enough swap pages it pays to drop pages from the swap
cache.  So in as many places as we can figuring out how to drop
swap pages when the swap space is practically full is important.

The other alternative implementation is to create a logical backing
store for anonymous pages (so the don't need a presence in the page
table) and then we could just walk that backing store and free up swap
space on demand.  Though if you can put anonymous pages in the page
cache now, a variation on that idea may be possible.  We don't
want to remove the swap from pages that aren't in ram.

 
> Does anybody see why we have to remove it from the swap cache at all?
 
Not just for cow.

Eric
