Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135948AbREGAyA>; Sun, 6 May 2001 20:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135950AbREGAxu>; Sun, 6 May 2001 20:53:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35849 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135946AbREGAxg>; Sun, 6 May 2001 20:53:36 -0400
Date: Sun, 6 May 2001 17:53:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <3AF4A857.DDA3599A@didntduck.org>
Message-ID: <Pine.LNX.4.21.0105061750010.11175-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 May 2001, Brian Gerst wrote:
>
> Currently the page fault handler on the x86 can get a clobbered value
> for %cr2 if an interrupt occurs and causes another page fault (interrupt
> handler touches a vmalloced area for example) before %cr2 is read.

That should be ok. 

Yes, we'll get a clobbered value, but we'll get a _valid_ clobbered value,
and we'll just end up doing the fixups twice (and returning to the user
process that didn't get the page it wanted, which will end up re-doing the
page fault).

[ Looks closer.. ]

Actually, the second time we'd do the fixup we'd be unhappy, because it
has already been done. That test should probably be removed. Hmm.

Hmm.. The threading people wanted this same thing. Maybe we should just
make it so.

		Linus

