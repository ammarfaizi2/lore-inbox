Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHCTxy>; Sat, 3 Aug 2002 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSHCTxy>; Sat, 3 Aug 2002 15:53:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55308 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317610AbSHCTxx>; Sat, 3 Aug 2002 15:53:53 -0400
Date: Sat, 3 Aug 2002 12:43:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: "David S. Miller" <davem@redhat.com>, <davidm@napali.hpl.hp.com>,
       <gh@us.ibm.com>, <frankeh@watson.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <15692.12093.514064.496253@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, David Mosberger wrote:
>
> Your point about wanting databases have access to giant pages even
> under memory pressure is a good one.  I had not considered that
> before.  However, what we really are talking about then is a security
> or resource policy as to who gets to allocate from a reserved and
> pinned pool of giant physical pages.

Absolutely. We can't allow just anybody to allocate giant pages, since
they are a scarce resource (set up at boot time in both Ingo's and Intels
patches - with the potential to move things around later with additional
interfaces).

>			  You don't need separate system
> calls for that: with a transparent superpage framework and a
> privileged & reserved giant-page pool, it's trivial to set up things
> such that your favorite data base will always be able to get the giant
> pages (and hence the giant TLB mappings) it wants.  The only thing you
> lose in the transparent case is control over _which_ pages need to use
> the pinned giant pages.  I can certainly imagine cases where this
> would be an issue, but I kind of doubt it would be an issue for
> databases.

That's _probably_ true. There aren't that many allocations that ask for
megabytes of consecutive memory that wouldn't want to do it. However,
there might certainly be non-critical maintenance programs (with the same
privileges as the database program proper) that _do_ do large allocations,
and that we don't want to give large pages to.

Guessing is always bad, especially since the application certainly does
know what it wants.

		Linus

