Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVL2Pfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVL2Pfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVL2Pfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:35:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22800 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbVL2Pfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:35:31 -0500
Date: Thu, 29 Dec 2005 16:35:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229153529.GH3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135868049.2935.49.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 03:54:09PM +0100, Arjan van de Ven wrote:
> 
> > I don't care too much whether we put always_inline or inline at the function
> > we _really_ want to inline.  But all others shouldn't have any inline marker.
> > So instead of changing the pretty useful redefinitions we have to keep the
> > code a little more readable what about getting rid of all the stupid inlines
> > we have over the place? 
> 
> just in drivers/ there are well over 6400 of those. Changing most of
> those is going to be a huge effort. The reality is, most driver writers
> (in fact kernel code writers) tend to overestimate the gain of inline in
> THEIR code, and to underestimate the cumulative cost of it. Despite what
> akpm says, I think gcc can make a better judgement than most of these
> authors (probably including me :). We can remove 6400 now, but a year
> from now, another 1000 have been added back again I bet.

Are we that bad reviewing code?

An "inline" in a .c file is simply nearly always wrong in the kernel, 
and unless the author has a good justification for it it should be 
removed.

> You describe a nice utopia where only the most essential functions are
> inlined.. but so far that hasn't worked out all that well ;) Turning
> "inline" back into the hint to the compiler that the C language makes it
> is maybe a cop-out, but it's a sustainable approach at least.
>...

But shouldn't nowadays gcc be able to know best even without an "inline" 
hint?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

