Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280014AbRJ3Qkz>; Tue, 30 Oct 2001 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRJ3Qkp>; Tue, 30 Oct 2001 11:40:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280024AbRJ3QkZ>; Tue, 30 Oct 2001 11:40:25 -0500
Date: Tue, 30 Oct 2001 08:38:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Rik van Riel wrote:
>
> Only on architectures where the TLB (or equivalent) is
> small and only capable of holding entries for one address
> space at a time.
>
> It's simply not true on eg PPC.

Now, it's not true on _all_ PPC's.

The sane PPC setups actually have a regular soft-filled TLB, and last I
saw that actually performed _better_ than the stupid architected hash-
chains. And for the broken OS's (ie AIX) that wants the hash-chains, you
can always make the soft-fill TLB do the stupid thing..

(Yeah, yeah, I'm sure you can find code where the hash-chains are faster,
especially big Fortran programs that have basically no tear-down and
build-up overhead. Which was why those things were designed that way, of
course. But it _looks_ like at least parts of IBM may finally be wising up
to the fact that hashed TLB's are a stupid idea).

		Linus

