Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSHREoT>; Sun, 18 Aug 2002 00:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318854AbSHREoT>; Sun, 18 Aug 2002 00:44:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318853AbSHREoS>; Sun, 18 Aug 2002 00:44:18 -0400
Date: Sat, 17 Aug 2002 21:51:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020818042818.GG21643@waste.org>
Message-ID: <Pine.LNX.4.44.0208172141490.1829-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> > We might as well get rid of /dev/random altogether if it is not useful. 
> 
> If it's not accounting properly, it's not useful.

My point exactly.

And if it isn't useful, it might as well not be there.

And your accounting isn't "proper" either. It's not useful on a
network-only device. It's just swinging the error the _other_ way, but
that's still an error. The point of /dev/random was to have an estimate of
the amount of truly random data in the algorithm - and the important word
here is _estimate_. Not "minimum number", nor "maximum number".

And yes, it still mixes in the random data, but since it doesn't account 
for the randomness, that only helps /dev/urandom. 

And helping /dev/urandom is _fine_. Don't get me wrong. It just doesn't 
make /dev/random any more useful - quite the reverse. Your patch will just 
make more people say "/dev/random isn't useful, use /dev/urandom instead".

Do you not see the fallacy of that approach? You're trying to make
/dev/random safer, but what you are actually _doing_ is to make people not
use it, and use /dev/urandom instead. Which makes all of the estimation
code useless.

THIS is my argument. Randomness is like security: if you make it too hard
to use, then you're shooting yourself in the foot, since people end up
unable to practically use it.

The point of /dev/random was to make it _easy_ for people to get random
numbers that we can feel comfortable about. The point of the accounting is
not a theoretical argument, but a way to make us feel _comfortable_ with
the amount of true randomness we're seeding in. It was not meant as a 
theoretical exercise.

		Linus


