Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280022AbRJ3QyP>; Tue, 30 Oct 2001 11:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280023AbRJ3QyG>; Tue, 30 Oct 2001 11:54:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34828 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280022AbRJ3Qxw>; Tue, 30 Oct 2001 11:53:52 -0500
Date: Tue, 30 Oct 2001 17:54:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030175417.K1340@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com> <XFMail.20011030171353.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20011030171353.pochini@shiny.it>; from pochini@shiny.it on Tue, Oct 30, 2001 at 05:13:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 05:13:53PM +0100, Giuliano Pochini wrote:
> 
> >> But of course going from page flush to the mm flush is fine from my part
> >> too. As Linus noted a few days ago during swapout we're going to block
> >> and reschedule all the time, so the range flush is going to be a noop in
> > 
> > Only on architectures where the TLB (or equivalent) is
> > small and only capable of holding entries for one address
> > space at a time.
> > 
> > It's simply not true on eg PPC.
> 
> #ifdef ?

yes, but not for ppc, for alpha and all other archs without accessed bit
provided in hardware (and cached in the tlb). the flush_mm proposed by
Ben looks fine for x86 too, it's a waste only for archs without accessed
bit.

I think an #ifndef HAVE_NO_ACCESS_BIT_IN_TLB or something like that,
then define that in asm-alpha/ and the other archs without accessed bit.

OTOH, it probably doesn't make much difference so maybe it doesn't worth
the effort.

Andrea
