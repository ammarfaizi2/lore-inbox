Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275325AbRIZQ6S>; Wed, 26 Sep 2001 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275331AbRIZQ6I>; Wed, 26 Sep 2001 12:58:08 -0400
Received: from waste.org ([209.173.204.2]:5689 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S275325AbRIZQ55>;
	Wed, 26 Sep 2001 12:57:57 -0400
Date: Wed, 26 Sep 2001 12:00:00 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@ufl.edu>
cc: David Wagner <daw@mozart.cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
In-Reply-To: <1001465531.10701.61.camel@phantasy>
Message-ID: <Pine.LNX.4.30.0109261132560.22327-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Sep 2001, Robert Love wrote:

> On Tue, 2001-09-25 at 20:20, David Wagner wrote:
> > I'm worried about the language in the configuration documentation:
> >   +  Some people, however, feel that network devices should not contribute to
> >   +  /dev/random because an external attacker could observe incoming packets
> >   +  in an attempt to learn the entropy pool's state. Note this is completely
> >   +  theoretical.
> > Incrementing the entropy counter based on externally observable
> > values is dangerous.  Calling this risk 'completely theoretical'
> > is, I believe, a misrepresentation, unless I've missed something.
>
> First, I agree the wording is too `kind' and I will change it.
>
> However, the actual end result -- that the output of /dev/random can be
> predicted -- is theoretical, because of the fact the output is one-way
> hashed.

Explain to me how you can simultaneously prefer /dev/random for its purely
theoretical advantages and yet want to throw exactly that advantage out
the window?

What is really called for is the addition of potential network randomness
without crediting it with entropy. And using /dev/urandom, now exactly as
strong as the /dev/random you propose[1]. And acceptable to everyone.

> Some diskless machines really have _zero_ entropy.

Then we shouldn't be pretending that they can generate secure random
numbers.


[1] Assume an SSL webserver with only network interrupts as a source of
entropy. If entropy is a bottleneck, you're in a catch-22: you must wait
for more traffic to generate keys, but getting more traffic depends on
generating said keys. Blocking = dropping connections = not handling n% of
load at all load levels. Thus, the application demands entropy produced is
greater than entropy consumed.

Assuming that's the case and you'd be able to run a system with
/dev/random+network "entropy", it will work just as well with
/dev/urandom+network "entropy". Blocking buys us nothing if entropy is
proportional to load and capacity is proportional to entropy.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

