Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDSQon>; Thu, 19 Apr 2001 12:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDSQod>; Thu, 19 Apr 2001 12:44:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18955 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131424AbRDSQo0>; Thu, 19 Apr 2001 12:44:26 -0400
Date: Thu, 19 Apr 2001 09:43:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.GSO.4.21.0104191223070.16930-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0104190937400.3842-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Alexander Viro wrote:
>
> I certainly agree that introducing ioctl() in _any_ API is a shootable
> offense. However, I wonder whether we really need any kernel changes
> at all.

I'd certainly be interested in seeing the pipe-based approach. Especially
if you make the pipe allocation lazy. That isn'tr trivial (it needs to be
done right with both up_failed() and down_failed() trying to allocate the
pipe on contention and using an atomic cmpxchg-style setting if none
existed before). It has the BIG advantage of working on old kernels, so
that you don't need to have backwards compatibility cruft in the
libraries.

		Linus

