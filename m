Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSGOFHS>; Mon, 15 Jul 2002 01:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSGOFHR>; Mon, 15 Jul 2002 01:07:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25358 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317324AbSGOFHQ>; Mon, 15 Jul 2002 01:07:16 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: HZ, preferably as small as possible
Date: Mon, 15 Jul 2002 05:06:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <agtl95$ihe$1@penguin.transmeta.com>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>
X-Trace: palladium.transmeta.com 1026709801 25625 127.0.0.1 (15 Jul 2002 05:10:01 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jul 2002 05:10:01 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>,
Grover, Andrew <andrew.grover@intel.com> wrote:
>
>But on the other hand, increasing HZ has perf/latency benefits, yes? Have
>these been quantified?

I've never had good reason to believe the latency/perf benefits myself,
but I was approached at OLS about problems with something as simple as
DVD playing, where a 100Hz timer means that the DVD player ends up
having to busy-loop on gettimeofday() because it cannot sanely sleep due
to the lack in sufficient sleeping granularity.

You apparently end up visibly missing frames - a frame is just 3 timer
ticks at 100 Hz, and considering that the kernel has to round up by one
due to POSIX requirements _and_ considering that you lose roughly one
for actually processing the frame itself, that doesn't sound _that_
outlandish. 

>		 I'd either like to see a HZ that has balanced
>power/performance, or could we perhaps detect we are on a system that cares
>about power (aka a laptop) and tweak its value at runtime?

Runtime tweaking is not really an option with the current setup. There
are also divisions etc that really want it to be a compile-time constant
for efficiency.

As noted, even power/performance-wise a higher Hz can actually _help_. 
Especially on laptops.  Exactly because you actually sanely _can_ afford
to sleep, which you cannot with a 100Hz timer. 

So you lose some, you win some, depending on your needs.

There is, of course, the option to do variable frequency (and make it
integer multiples of the exposed "constant HZ" so that kernel code
doesn't actually need to _care_ about the variability). There are
patches to play with things like that.

		Linus
