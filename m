Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSAZBBg>; Fri, 25 Jan 2002 20:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAZBB1>; Fri, 25 Jan 2002 20:01:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288973AbSAZBBL>; Fri, 25 Jan 2002 20:01:11 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Sat, 26 Jan 2002 01:00:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a2sv2s$ge3$1@penguin.transmeta.com>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de>
X-Trace: palladium.transmeta.com 1012006863 22593 127.0.0.1 (26 Jan 2002 01:01:03 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Jan 2002 01:01:03 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <jeelkes8y5.fsf@sykes.suse.de>,
Andreas Schwab  <schwab@suse.de> wrote:
>|> 
>|> Storing 30% less executable pages in memory?  Reading 30% less executable 
>|> pages off the disk?
>
>These are all startup costs that are lost in the noise the longer the
>program runs.

That's a load of bull.

Startup costs tend to _dominate_ most applications, except for
benchmarks, scientific loads and games/multimedia. 

Not surprisingly, those three categories are also the ones where lots of
optimizer tuning is regularly done. But it's a _small_ subset of the
general application load.

Note that not only do startup costs often dominate the rest, they are
psychologically very important. From a user standpoint, an application
that loads "instantly" is mostly viewed as being much more pleasant than
one that takes longer to load, even if the latter were to run faster
once loaded.

This is also something that only gets worse and worse with time. Not
only do caches get more and more important (because the CPU core gets
ever faster compared to the outside world), but they get larger as well.

And what that leads to is that the cache warmup phase (which is linear
wrt size of the problem) gets relatively _slower_ and bigger compared to
the warm cache behaviour (ie the running phase). So optimizing for size
is (a) the right thing to do and (b) going to be even more so in the
future.

It's sad that gcc relegates "optimize for size" to a second-class
citizen.  Instead of having a "-Os" (that optimizes for size and doesn't
work together with other optimizations), it would be better to have a
"-Olargecode", which explicitly enables "don't care about code size" for
those (few) applications where it makes sense.

		Linus
