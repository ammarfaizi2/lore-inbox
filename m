Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbTL3Tz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbTL3Tz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:55:28 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:58333 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265920AbTL3TzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:55:15 -0500
Date: Tue, 30 Dec 2003 12:56:32 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Message-ID: <20031230195632.GB6992@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030906125136.A9266@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org> <20031230004907.GA29143@merlin.emma.line.org> <200312300836.16559.edt@aei.ca> <20031230131350.A32120@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20031230131350.A32120@hexapodia.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30 at 13:13, Andy Isaacson wrote:
>On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
>The consistency check definitely should not take 15 minutes.  It should
>be (much) less than 30 seconds.  What is the hardware you're running on?
>
>I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
>disk, and I can do a complete clone (with full data copy and consistency
>check) of the 2.4 tree in 1:40.  That was with cold caches; with the
>sfile copies and "checkout:get", a half-gig isn't enough to cache
>everything.  The consistency check is about 19 seconds (bk -r check -acv).

For what it is worth:

AMD Duron 950MHz, 768MB RAM
7200RPM 80GB Quantum Viper IDE drive, 26% full

phat-penguin:~/src/linux-2.5> time bk -r check -acv
100% |=================================================================| OK
42.710u 5.770s 2:04.63 38.8%    0+0k 0+0io 74078pf+0w

over 2 minutes of wall time, 42 seconds of "user" time... (if I'm reading it right), without primed disk caches.

The 2nd run, half a minute later:

phat-penguin:~/src/linux-2.5> time bk -r check -acv
100% |=================================================================| OK
41.900u 3.080s 0:45.53 98.7%    0+0k 0+0io 74078pf+0w


...would appear to show that BK's checksumming, on my system, is
constrained near 41 seconds of calculation time, and the difference
between the user and the wall-clock time is basically time spent
waiting for the disk to do all its reads.


I guess in that case, it'd be interesting to see what the user and
wall times were for the original poster who reported a 15+ minute
integrity check.

--eric



-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

