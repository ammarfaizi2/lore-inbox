Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTD3PPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTD3PPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:15:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262267AbTD3PPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:15:35 -0400
Date: Wed, 30 Apr 2003 08:28:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <87ptn4t4sd.fsf@student.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.44.0304300824190.7157-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Apr 2003, Falk Hueffner wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > Classic mistake. Lookup tables are only faster in benchmarks, they
> > are almost always slower in real life. You only need to miss in the
> > cache _once_ on the lookup to lose all the time you won on the
> > previous one hundred calls.
> 
> It seems to me if you call the function so seldom the table drops out
> of the cache, it is irrelevant how long it takes anyway.

Yeah, but then this whole discussion is irrelevant too.

I'm just saying that micro-benchmarks of operations that do not make any
sense on their own are _bad_ measures of real performance. That lookup is 
going to lose to the "natural" code even if it hits the L2, and misses 
only the L1.

Any piece of code that only works well when it sits in (and owns) the L1
is a piece of crap.

> Well, if a lookup table isn't "small and simple", I don't know what
> is.

Something that calculates it directly? Like, perchance, the current code? 

There is _never_ any excuse to use a lookup table for something that can 
be calculated with a few simple instructions. That's just stupid.

		Linus

