Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUF1Pv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUF1Pv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUF1Pvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:51:55 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:53936 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265043AbUF1Pvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:51:33 -0400
Message-ID: <40E03E77.9090109@kolivas.org>
Date: Tue, 29 Jun 2004 01:51:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Timothy Miller <miller@techsource.com>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org> <40E03C2D.5000809@techsource.com> <40E03844.1080000@kolivas.org> <40E03DB8.5090204@thinrope.net>
In-Reply-To: <40E03DB8.5090204@thinrope.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kalin KOZHUHAROV wrote:
| Con Kolivas wrote:
|
|> Timothy Miller wrote:
|> |
|> | Con Kolivas wrote:
|> |
|> |>
|> |> It definitely should _not_ starve. That is the unixy way of doing
|> |> things. Everything must go forward. Around 5% cpu for nice 19 sounds
|> |> just right. If you want scheduling only when there's spare cpu cycles
|> |> you need a sched batch(idle) implementation.
|> |>
|> |
|> | Well, since I can't rewrite the app, I can't make it sched batch.  Nice
|> | values are an easy thing to get at for anything that's running.
|> |
|> | Besides, comparing nice 0 to nice 19, I'd expect something more like a
|> | 100:1 ratio or worse.  (That is, I don't expect nice to be linear.)
|> |
|> | Maybe this is just me, but when I set a process to the worst possible
|> | priority (nice 19), I expect it only to run when nothing else needs the
|> | CPU.
|>
|>
|> Sched batch is a kernel modification, and a simple wrapper will allow
|> you  to run _any_ program as sched batch without modifying it's source.
|>
|> The design has had that ratio of 20:1 for a very long time so now is not
|> the time to suddenly decide it should be different. However if you want
|> to make it 100:1 for your machine feel free to edit kernel/sched.c
|> and change
|> #define MIN_TIMESLICE        ( 10 * HZ / 1000)
|> to
|> #define MIN_TIMESLICE        ( 1 * HZ / 1000)
|>
|> That will give you more what you're looking for.
|
|
| Cool!!!

Be aware that it only works if you have not changed the Hz from the
default of 1000.

|
| As a start, I was palnning to ask such a question on LKML for a long
| time, but
| somehow I always forget. Also running SETI@Home on a few Gentoo boxen,
| but with
| stock kernels (now 2.6.7). Now that I started reading the first e-mail I
| thought
| something like "Oh, so I _did_ send that mail?!?" :-)
|
| I think I will check the suggested MIN_TIMESLICE thing on next
| recompile, but
| it started me thinking...
| Will it be very difficult to have /proc/sched/min_timeslice or
| something, instead of
| the above compile-time define?
| That will be really good thing for the our cases and souldn't (or am I
| overseeing
| something) pose problems for "normal" usage. RFE!

There is such a thing available if you check the archives. The only
problem with changing the min timeslice is that once you get below 10ms
you get significant cache trashing and wasted cpu cycles.

|
| BTW, the mentioned "sched batch kernel modification" is something else,
| right?
| Google wasn't very usefull for "sched batch"...

My staircase scheduler in 2.6.7-ck3 supports sched batch.
http://kernel.kolivas.org

|
| Can you post any concrete pointers/patches for the sched batch
| modification?
|
| Kalin.
|

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4D53ZUg7+tp6mRURAq1/AJ9BydANnAGCUWdRwwo9pJZj6SETdQCeLS0x
LFKhpZsxOHJCysLpUzqRrjU=
=MO5c
-----END PGP SIGNATURE-----
