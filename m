Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVEMV7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVEMV7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVEMV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:59:44 -0400
Received: from waste.org ([216.27.176.166]:28117 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262559AbVEMV7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:59:30 -0400
Date: Fri, 13 May 2005 14:59:05 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513215905.GY5914@waste.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513212620.GA12522@hexapodia.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:26:20PM -0700, Andy Isaacson wrote:
> On Fri, May 13, 2005 at 09:05:49PM +0200, Andi Kleen wrote:
> > On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> > > Why?  It's certainly reasonable to disable it for the time being and
> > > even prudent to do so.
> > 
> > No, i strongly disagree on that. The reasonable thing to do is
> > to fix the crypto code which has this vulnerability, not break
> > a useful performance enhancement for everybody else.
> 
> Pardon me for saying so, but that's bullshit.  You're asking the crypto
> guys to give up a 5x performance gain (that's my wild guess) by giving
> up all their data-dependent algorithms and contorting their code wildly,
> to avoid a microarchitectural problem with Intel's HT implementation.
> 
> There are three places to cut off the side channel, none of which is
> obviously the right one.
> 1. The HT implementation could do the cache tricks Colin suggested in
>    his paper.  Fairly large performance hit to address a fairly small
>    problem.
> 2. The OS could do the scheduler tricks to avoid scheduling unfriendly
>    threads on the same core.  You're leaving a lot of the benefit of HT
>    on the floor by doing so.
> 3. Every security-sensitive app can be rigorously audited and re-written
>    to avoid *ever* referencing memory with the address determined by
>    private data.
> 
> (3) is a complete non-starter.  It's just not feasible to rewrite all
> that code.  Furthermore, there's no way to know what code needs to be
> rewritten!  (Until someone publishes an advisory, that is...)
> 
> Hmm, I can't think of any reason that this technique wouldn't work to
> extract information from kernel secrets, as well... 
> 
> If SHA has plaintext-dependent memory references, Colin's technique
> would enable an adversary to extract the contents of the /dev/random
> pools.  I don't *think* SHA does, based on a quick reading of
> lib/sha1.c, but someone with an actual clue should probably take a look.

SHA1 should be fine, as are the pool mixing bits. Much more
problematic is the ability to do timing attacks against the entropy
gathering itself. If an attacker can guess the TSC value that gets
mixed into the pool, that's a problem.

It might not be much of a problem though. If he's a bit off per guess
(really impressive), he'll still be many bits off by the time there's
enough entropy in the primary pool to reseed the secondary pool so he
can check his guesswork.

-- 
Mathematics is the supreme nostalgia of our time.
