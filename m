Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUI0NIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUI0NIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUI0NIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:08:55 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:19652 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S264503AbUI0NIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:08:53 -0400
Date: Mon, 27 Sep 2004 09:07:28 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040927130728.GE28317@certainkey.com>
References: <20040926052308.GB8314@thunk.org> <20040927005033.14622.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927005033.14622.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 12:50:33AM -0000, linux@horizon.com wrote:
> > SHA-1 without padding, sure.
> 
> > hash("a") = hash("a\0") = hash("a\0\0") = ...
> > hash("b") = hash("b\0") = hash("b\0\0") = ...
> > hash("c") = hash("c\0") = hash("c\0\0") = ...
> 
> And how do I hash one byte with SHA-1 *without padding*?  The only
> hashing code I can find in random.c works 64 bytes at a time.
> What are the other 63 bytes?
> 
> (I agree that that *naive* padding leads to collisions, but random.c
> doesn't do ANY padding.)

And I guess it is my fault to assume "no padding" is naive padding.

> > I see.  And in the -mm examples, is the code easily readable for other
> > os-MemMgt types?  If no, then I guess random.c is not the exception and I
> > apologize.
> 
> The Linux core -mm code is a fairly legendary piece of Heavy Wizardry.
> To paraphrase, "do not meddle in the affairs of /usr/src/linux/mm/, for
> it is subtle and quick to anger."  There *are* people who understand it,
> and it *is* designed (not a decaying pile of old hacks that *nobody*
> understands how it works like some software), but it's also a remarkably
> steep learning curve.  A basic overview isn't so hard to acquire, but the
> locking rules have subtle details.  There are places where someone very good
> noticed that a given lock doesn't have to be taken on a fast path if you
> avoid doing certain things anywhere else that you'd think would be legal.
> 
> And so if someone tries to add code to do the "obvious" thing, the
> lock-free fast path develops a race condition.  And we all know what
> fun race conditions are to debug.
> 
> Fortunately, some people see this as a challenge and Linux is blessed with
> some extremely skilled VM hackers.  And some of them even write and publish
> books on the subject.  But while a working VM system can be clear, making it
> go fast leads to a certain amount of tension with the clarity goal.

Freightning ... but informative thank you.

> > And the ring-buffer system which delays the expensive mixing stages untill a
> > a sort interrupt does a great job (current and my fortuna-patch).  Difference
> > being, fortuna-patch appears to be 2x faster.
> 
> Ooh, cool!  Must play with to steal the speed benefits.  Thank you!

I'll have a patch for a "enable in crypto options" and "blocking with entropy
estimation" random-fortuna.c patch this week.  My fiance is out of town and
there should be time to hack one up.

JLC
