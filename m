Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278369AbRJMTXr>; Sat, 13 Oct 2001 15:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278374AbRJMTXh>; Sat, 13 Oct 2001 15:23:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16141 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278373AbRJMTXZ>; Sat, 13 Oct 2001 15:23:25 -0400
Date: Sat, 13 Oct 2001 12:23:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk>
Message-ID: <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Jamie Lokier wrote:
>
> In fact it was proposed here on this list years ago, and I think you
> argued against it (TLB flush costs).  The costs and kernel
> infrastructure have changed and maybe the idea could be revisited now.

It's still not entirely unlikely that doing VM mappings is simply more
expensive than just doing a memcpy. The TLB invalidate is only part of the
issue - you also have the page table walk, the VM lock, and the fact that
PAGE_COPY itself ends up being overhead.

Which is why the PAGE_COPY kind of read() optimization is _probably_ only
worth it if the user asks for it directly (or automatically only for large
reads together with single-threaded applications).

The explicit flag is probably a good idea also because of usage patterns
(PAGE_COPY is a slowdown _if_ the file is actually written to or even
mapped shared).

		Linus

