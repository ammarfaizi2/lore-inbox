Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270460AbRHUBVg>; Mon, 20 Aug 2001 21:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270478AbRHUBV1>; Mon, 20 Aug 2001 21:21:27 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:32269 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S270460AbRHUBVT>;
	Mon, 20 Aug 2001 21:21:19 -0400
Date: Mon, 20 Aug 2001 21:20:53 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010820212053.B20957@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]> <9lrc6u$6pv$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <9lrc6u$6pv$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Mon, Aug 20, 2001 at 04:00:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 04:00:30PM +0000, David Wagner wrote:
> 
> I don't see why not.  Apply this change, and use /dev/urandom.
> You'll never block, and the outputs should be thoroughly unpredictable.
> What's missing?

Absolutely.  And if /dev/urandom is not unpredictable, that means
someone has broken SHA-1 in a pretty complete way, in which case it's
very likely that most of the users of the randomness are completely
screwed, since they probably depend on SHA-1 (or some other MAC which
is probably in pretty major danger if someone has indeed managed to
crack SHA-1).

> (I don't see why so many people use /dev/random rather than /dev/urandom.
> I harbor suspicions that this is a misunderstanding about the properties
> of pseudorandom number generation.)

Probably.  /dev/random is probably appropriate when you're trying to
get randomness for a long-term RSA/DSA key, but for session key
generation which is what most server boxes will be doing, /dev/urandom
will be just fine.

Of course, then you have the crazies who are doing Monte Carlo
simulations, and then send me mail asking why using /dev/urandom is so
slow, and how can they the reseed /dev/urandom so they can get
repeatable, measureable results on their Monte Carlo sinulations....

					- Ted
