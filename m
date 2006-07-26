Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWGZCwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWGZCwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 22:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWGZCwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 22:52:03 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:54496 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030370AbWGZCwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 22:52:01 -0400
Message-ID: <44C6D8CD.4040604@comcast.net>
Date: Tue, 25 Jul 2006 22:51:57 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gettimeofday(), clock_gettime(), timer_gettime()
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm looking through a few things and noticing some complaints about time
and performance.  Briefly, the following things have come to my attention:

 - gettimeofday() is slow, or so they say, needing several milliseconds
to execute.

 - Apparently clock_gettime() exists, and can get the same information
as gettimeofday(); it gets its stuff in seconds and nanoseconds, which
is a little more precise than gettimeofday()

 - There are also timers that can count down time incrementally


So I have a few simple questions:

 - Is clock_gettime() faster than gettimeofday()? (doubt it)

 - If not, is timer_gettime() faster than gettimeofday() and clock_gettime()

If it turns out clock_gettime() is faster, then wow what the hell?
Otherwise I'm curious on timer_gettime() because it'll be pretty easy to
implement a timer-based clock tracker that adjusts for clock drift (yeah
if I keep timering and adjusting and resetting the timers the overhead
of maintaining the clock in userspace will drift me away from real
gettimeofday() values).

I'm planning out an interval timer based gettimeofday() in userspace as
an object oriented gettimeofday() mimicry; you'd have to pass a
structure to it for a created timer, because otherwise thread safety
would mean mutexes or thread local storage, both of which are slow.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMbYyws1xW0HCTEFAQIsbQ/9ED7UUxFygEUAzvCw0m+EoW7YSvlbkqkj
DDxinJnM/Q8CpcmpHgiMlRn/kHJUC/g44YwdKly/7QWwBTuLRB2Ys8WxdqrHaqdV
nAGz9SRtkWa09YLYFqc0n4E3zyn3NdVrB9/uP1NgeZRqwULALFX0zYz3CHZz5std
aZo1+XyHbeikxO7ECk0pNjghpzX7iUq1oGMaSNHptCSq4ASLRJqmCNdp+ozUilCi
FF/DrpSvKmhpuAsCRSkScqGyeY1qm06zDpMvTnrTuAnuX2GFDjRc9Z7d1JAFvxx1
1S1mWsu/vKz8gqvHsgXquuRuIZo9zNHdql2cHFJ0/nRBhJzldG9EvDVTQq684bq1
MCZ2p7Tpw4YV2cVcwxoESjluuhdsuiRc7OuAv6HdmeJ/ES+zQkyty0IBDpekTG9m
ZkBMaItDKwxn52AUeVH+em77a0e8K75IozpzEiLiHCoYpbGZvQIOxJl58TLs4X0P
mxbi8MCekIiikarRNhKh2CPn64OV6e4Iq1PVjrBUR4/rviszTQyaLL5F+jyFgWTb
CF5ovwjaU6E2FcW+vOakaLJogyoqGY6/hQOUuiN0J4cz6Bk8zRC5ZPL+zZ6/uMUp
Yo77rfHOhmMYzhAwENT17tvp6OQliC+GpxzCGLLHzbbI7wFOD0Kgl9zj29+KSi3c
IqtjC6+Q7e0=
=Bzic
-----END PGP SIGNATURE-----
