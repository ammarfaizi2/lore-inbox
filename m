Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTL3UQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbTL3UQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:16:59 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:20041 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265922AbTL3UQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:16:56 -0500
Date: Tue, 30 Dec 2003 14:16:55 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Message-ID: <20031230141655.A30003@hexapodia.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org> <20031230004907.GA29143@merlin.emma.line.org> <200312300836.16559.edt@aei.ca> <20031230131350.A32120@hexapodia.org> <20031230195632.GB6992@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031230195632.GB6992@bounceswoosh.org>; from edmudama@mail.bounceswoosh.org on Tue, Dec 30, 2003 at 12:56:32PM -0700
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 12:56:32PM -0700, Eric D. Mudama wrote:
> On Tue, Dec 30 at 13:13, Andy Isaacson wrote:
> >On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
> >The consistency check definitely should not take 15 minutes.  It should
> >be (much) less than 30 seconds.  What is the hardware you're running on?
> >
> >I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
> >disk, and I can do a complete clone (with full data copy and consistency
> >check) of the 2.4 tree in 1:40.  That was with cold caches; with the
> >sfile copies and "checkout:get", a half-gig isn't enough to cache
> >everything.  The consistency check is about 19 seconds (bk -r check -acv).
> 
> For what it is worth:
> 
> AMD Duron 950MHz, 768MB RAM
> 7200RPM 80GB Quantum Viper IDE drive, 26% full
> 
> phat-penguin:~/src/linux-2.5> time bk -r check -acv
> 100% |=================================================================| OK
> 42.710u 5.770s 2:04.63 38.8%    0+0k 0+0io 74078pf+0w
> 
> over 2 minutes of wall time, 42 seconds of "user" time... (if I'm reading it right), without primed disk caches.
> 
> The 2nd run, half a minute later:
> 
> phat-penguin:~/src/linux-2.5> time bk -r check -acv
> 100% |=================================================================| OK
> 41.900u 3.080s 0:45.53 98.7%    0+0k 0+0io 74078pf+0w
> 
> 
> ...would appear to show that BK's checksumming, on my system, is
> constrained near 41 seconds of calculation time, and the difference
> between the user and the wall-clock time is basically time spent
> waiting for the disk to do all its reads.
> 
> 
> I guess in that case, it'd be interesting to see what the user and
> wall times were for the original poster who reported a 15+ minute
> integrity check.

That's basically right, except that if you don't have enough memory to
keep bk's working set in memory, then you're paging and performance
starts to suck.

I didn't realize that the cpu-bound portion of the check would scale so
closely with CPU speed, but it looks like the scaling is almost dead-on;
18.4/41.9 = .439
950/2000  = .475

So I was wrong to say "less than 30 seconds".  "If you have a fast CPU
and enough memory", I guess.  But the memory matters a lot more than the
CPU.

-andy
