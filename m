Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272320AbRH3QYX>; Thu, 30 Aug 2001 12:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272316AbRH3QYN>; Thu, 30 Aug 2001 12:24:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272314AbRH3QYB>; Thu, 30 Aug 2001 12:24:01 -0400
Date: Thu, 30 Aug 2001 09:21:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <3B8E4474.DA6D281F@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0108300909560.7973-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Aug 2001, Roman Zippel wrote:
>
> So why won't you let the compiler help you, even if it's not perfect in
> every case?

I considered enabling -Wsign-compare a long time ago, and it's not a
question of being "perfect", but a question of being _so_ broken that it's
not funny.

For example, let's look at this perfectly natural code:

	static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
	{
		if (len <= sizeof(short) || len > sizeof(*sunaddr))
			return -EINVAL;
		...

Would you agree that the above is _good_ code, and code that makes
perfect sense, and code that does exactly the right thing in testing its
arguments?

Try to compile it with -Wsign-compare.

You'll get not one, but TWO warnings for code that is totally correct, and
that it would make _no_ sense in writing any other way.

In short, -Wsign-compare (at least with a _lot_ of gcc versions) warns for
totally sane and reasonable code - for code that exists all over the
kernel. The above snippet is in fact directly from the kernel, go look and
see for yourself.

In short, -Wsign-compare is totally useless. The warnings are mostly _so_
bogus that nobody has the energy to even try to figure out which of them
might actually be worthwhile.

Face it, you don't know what you're talking about.

		Linus

