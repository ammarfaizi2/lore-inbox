Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRIKPNR>; Tue, 11 Sep 2001 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIKPNI>; Tue, 11 Sep 2001 11:13:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29445 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268017AbRIKPM5>; Tue, 11 Sep 2001 11:12:57 -0400
Date: Tue, 11 Sep 2001 08:12:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33L.0109102151581.30234-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109110808150.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Sep 2001, Rik van Riel wrote:
> >
> > Pre-loading your cache always depends on some limited portion of
> > prescience.
>
> OTOH, agressively pre-loading metadata should be ok in a lot
> of cases, because metadata is very small, but wastes about
> half of our disk time because of the seeks ...

I actually agree to some degree here. The main reason I agree is that
meta-data often is (a) known to be physically contiguous (so pre-fecthing
is easy and cheap on most hardwate) and (b) meta-data _is_ small, so you
don't have to prefetch very much (so pre-fetching is not all that
expensive).

Trying to read two or more pages of inode data whenever we fetch an inode
might not be a bad idea, for example. Either we fetch a _lot_ of inodes
(in which case the prefetching is very likely to get a hit anyway), or we
don't (in which case the prefetching is unlikely to hurt all that much
either). You don't easily get into a situation where you prefetch a lot
without gaining anything.

We might do other kinds of opportunistic pre-fetching, like have "readdir"
start prefetching for the inode data it finds. That miht be a win for many
loads (and it might be a loss too - there _are_ loads that really only
care about the filename, although I suspect they are fairly rare).

		Linus

