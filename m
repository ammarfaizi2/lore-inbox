Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269473AbUIZBnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbUIZBnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUIZBnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:43:16 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:46527 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269473AbUIZBnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:43:13 -0400
Date: Sat, 25 Sep 2004 21:42:18 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com, jmorris@redhat.com,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040926014218.GZ28317@certainkey.com>
References: <20040924023413.GH28317@certainkey.com> <20040924214230.3926.qmail@science.horizon.com> <20040925145444.GW28317@certainkey.com> <20040925184352.GB7278@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925184352.GB7278@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 02:43:52PM -0400, Theodore Ts'o wrote:
> You still haven't shown the flaw in the logic.  My point is that an
> over-reliance on crypto primitives is dangerous, especially given
> recent developments.  Fortuna relies on the crypto primitives much
> more than /dev/random does.  Ergo, if you consider weaknesses in
> crypto primitives to be a potential problem, then it might be
> reasonable to take a somewhat more jaundiced view towards Fortuna
> compared with other alternatives.

Correct me if I'm wrong here.

You claimed that the collision techniques found for the UFN design hashs
(sha0, md5, md5, haval, ripemd) demonstrated the need to not rely on hash
algorithms for a RNG.  Right?

And I showed that the SHA-1 in random.c now can produce collisions.  So, if
your argument against the fallen UFN hashs above (SHA-1 is a UFN hash also
btw.  We can probably expect more annoucments from the crypto community in
early 2005) should it not apply to SHA-1 in random.c?

Or did I misunderstand you?  Were you just mentioning the weakened algorithms
as a "what if they were more serious discoveries?  Wouldn't be be nice if we
didn't rely on them?" ?

The decision to place trust in a entropy estimation scheme vs. a crypto
algorithm we have different views on.  I can live with that.

> Whether or not /dev/random performs the SHA finalization step (which
> adds the padding and the length to the hash) is completely and totally
> irrelevant to this particular line of reasoning.  

I "completly and totally" agree.  I'm pointing out that no added padding
makes me, the new guy reading your code, work harder to decide if it's a
weakness.  You shouldn't do that to people if you can avoid it.  Just like
you shouldn't obfuscate code, even if it doesn't "weaken" its implementation.
It's just rude.  Take the performance penalty to avoid scaring people away
from a very important peice of the kernel.

> ... Whether or not we should trust the design of something as
> critical to the security of security applications as /dev/random to
> someone who fails to grasp the difference between these two rather
> basic issues is something I will leave to the others on LKML.

... biting my toung ... so hard it bleeds ...

The quantitaive aspects of the two RNGs in question are not being discussed.
It's the qualitative aspects we do not see eye to eye on.  So I will no
longer suggest replacing the status-quo.  I'd like to submit a patch to let
users chose at compile-time under Cryptographic options weither to drop in
Fortuna.

Ted, can we leave it at this?

JLC
