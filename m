Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUIZFZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUIZFZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 01:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269497AbUIZFZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 01:25:46 -0400
Received: from [69.25.196.29] ([69.25.196.29]:51128 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S269495AbUIZFZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 01:25:11 -0400
Date: Sun, 26 Sep 2004 01:23:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux@horizon.com, jmorris@redhat.com, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040926052308.GB8314@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>, linux@horizon.com,
	jmorris@redhat.com, cryptoapi@lists.logix.cz,
	linux-kernel@vger.kernel.org
References: <20040924023413.GH28317@certainkey.com> <20040924214230.3926.qmail@science.horizon.com> <20040925145444.GW28317@certainkey.com> <20040925184352.GB7278@thunk.org> <20040926014218.GZ28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926014218.GZ28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 09:42:18PM -0400, Jean-Luc Cooke wrote:
> On Sat, Sep 25, 2004 at 02:43:52PM -0400, Theodore Ts'o wrote:
> > You still haven't shown the flaw in the logic.  My point is that an
> > over-reliance on crypto primitives is dangerous, especially given
> > recent developments.  Fortuna relies on the crypto primitives much
> > more than /dev/random does.  Ergo, if you consider weaknesses in
> > crypto primitives to be a potential problem, then it might be
> > reasonable to take a somewhat more jaundiced view towards Fortuna
> > compared with other alternatives.
> 
> Correct me if I'm wrong here.
> 
> You claimed that the collision techniques found for the UFN design hashs
> (sha0, md5, md5, haval, ripemd) demonstrated the need to not rely on hash
> algorithms for a RNG.  Right?

For Fortuna, correct.  This is why I believe /dev/random's current
design to be superior.

> And I showed that the SHA-1 in random.c now can produce collisions.  So, if
> your argument against the fallen UFN hashs above (SHA-1 is a UFN hash also
> btw.  We can probably expect more annoucments from the crypto community in
> early 2005) should it not apply to SHA-1 in random.c?

(1) Your method of "producing collisions" assumed that /dev/random was
of the form HASH("a\0\0\0...") == HASH("a) --- i.e., you were
kvetching about the lack of padding.  But we've already agreed that
the padding argument isn't applicable for /dev/random, since it only
hashes block-sizes at the same time.  (2) Even if there were real
collisions demonstrated in SHA-1's cryptographic core at some point in
the future, it wouldn't harm the security of the algorithm, since
/dev/random doesn't depend on SHA-1 being resistant against
collisions.  (Similarly, HMAC-MD5 is still safe for now since it also
is designed such that the ability to find collisions do not harm its
security.  It's a matter of how you use the cryptographic primitives.)

> Or did I misunderstand you?  Were you just mentioning the weakened algorithms
> as a "what if they were more serious discoveries?  Wouldn't be be nice if we
> didn't rely on them?" ?

That's correct.  It is my contention that Fortuna is brittle in this
regard, especially in comparison to /dev/random current design.

And you still haven't pointed out the logic flaw in any argument but
your own.

						- Ted
