Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275328AbTHMTh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275332AbTHMTh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:37:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22912 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275328AbTHMTh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:37:26 -0400
Date: Wed, 13 Aug 2003 20:37:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030813193713.GF4405@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <bh77pp$rhq$1@abraham.cs.berkeley.edu> <20030811053602.GL10446@mail.jlokier.co.uk> <bh8qat$d7i$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bh8qat$d7i$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> >It may be that an attacker knows about a systemic problem with our
> >machine that we don't know about.  For example the attacker might know
> >our pool state well enough shortly after boot time, to have a chance
> >at matching a dictionary of 2^32 hashes.  The attacker might have had
> >a chance to read our disk, which reseeding the pool at boot time does
> >not protect against.
> >
> >With the right algorithm, we can protect against weaknesses of this kind.
> 
> How?  No matter what we do, the outputs are going to be a deterministic
> function of the state of the pool.  If the attacker can guess the entire
> state of our pool (or narrow it down to 2^32 possibilities), we're screwed,
> no matter what.  Right?

Right if the attacker can guess the entire pool state.  If it's
narrowed to 2^32 possibilities, the question is, how hard do we make
it for the attacker to narrow it down further?

By hashing over fewer than all the internal state bits, we prevent the
attacker from narrowing down knowledge of the unhashed bits _from a
single hash_, under those conditions where it's possible for the
hashed bits to be a weak state while the unhashed bits may not be
determined by the hashed bits.

This can sometimes be true, theoretically, and sometimes it will not
be true.

If the attacker can read multiple hash results, though, they will
eventually have enough to guess the entire pool state anyway, if the
state is weak as a whole.  Also, by hashing over fewer bits, some
kinds of partially-weak state, where a subset of bits is weak but
other bits are unguessable, become guessable where they would not be
with hashing over the whole state.

It's a convoluted enough mix of pros and cons that you can see why I
said, in my last reply to Matt & Ted, that hashing over fewer bits than in
the pool is of dubious value.

-- Jamie
