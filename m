Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUIXSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUIXSCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUIXSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:02:21 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:41657 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269003AbUIXSAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:00:05 -0400
Date: Fri, 24 Sep 2004 13:59:29 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924175929.GU28317@certainkey.com>
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org> <20040924125457.GO28317@certainkey.com> <20040924174301.GB20320@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924174301.GB20320@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I submitted a patch that gave users the choice of swapping my Fortuna for
the current /dev/random, would you be cool with that then?

Our discussions on the matter always seem to move to areas where we can never
agree.

On Fri, Sep 24, 2004 at 01:43:01PM -0400, Theodore Ts'o wrote:
> > A compromise would be to have a primitive PRNG in random.c is no
> > CONFIG_CRYRPTO is present to keep things working.
> 
> Now *that*'s an extremely ill-considered idea.  It means that an
> application can without any warning, can have its strong source of
> random numbers replaced with a weak random number generator.  It
> should be blatently obvious why this is a specatularily bad, horrific
> idea.

Easy fix - use CryptoAPI in our PRNGs and make it standard in the kernel.  :)

You can see we're going in circles.

> If they only want crypto-secure random numbers, they can do it in
> userspace.  Information secure random numbers is something the kernel
> can provide, because it has low-level access to entrpoy sources.  So
> why not try to do the best possible job? 

Sure.  I hate Brittney Spears, but I will not deny people the choice.

> This by the way your complaint that /dev/random is "too slow" is a
> complete red herring.  When do you need more than 6 megs of random
> numbers per second?  And if the application just needs crypto-secure
> random numbers, then the application can just extract 32 bytes or so
> of randomness from /dev/random, and then do the CRNG in userspace, at
> which point it will be even faster, since the data won't have to
> copied from kernel to userspace.

I never complained that it was too slow.  I've just noticed that when ever a
patch is submitted there are only 3 reasons to accept it:
 - does it do something we havn't done before?
 - does it do something faster / smaller?
 - is it in someway better then what's there now?

I did my best to alliviate #2.  #3 I've decided I'll never be able to
convince enough people for an all-out replacement.  I'd be happy with a
configuration choice.

> > What if I told the SHA-1 implementation in random.c right now is weaker
> > than those hashs in terms of collisions?  The lack of padding in the
> > implementation is the cause.  HASH("a\0\0\0\0...") == HASH("a") There
> > are billions of other examples.
> 
> This is another red herring.  First of all, we're not using the hash
> as a MAC, or in any way where we would care about collisions.
> Secondly, all of the places where we take a hash, we are always doing
> it 16 bytes at a time, which is SHA's block size, so that there's no
> need for any padding.  And although you didn't complain about it,
> that's also why we don't need to mix in the length in the padding;
> extension attacks just simply aren't an issue, since the way we are
> using the hash, that just simply an issue as far as the strength of
> /dev/random.

Woh there.  Didn't you just say "see, these hashes are weakened.  That's
bad".  Now I just demonstrated the same thing with your SHA1 implementation
and you throw that "red-herring" phrase out again?

Point of history when breaking a hash:
 - first a method for collisions is found
 - then comes 2nd pre-image
 - then comes complete inversion

MD4 case and point.  Any how.  I've given up trying to sell a replacement.
Can users have an option to switch?

JLC
